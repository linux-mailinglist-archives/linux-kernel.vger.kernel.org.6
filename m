Return-Path: <linux-kernel+bounces-339833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A374986B28
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16351C21867
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 03:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BCD132122;
	Thu, 26 Sep 2024 03:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="DIY/71x5"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8022A1741C6
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 03:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727319644; cv=none; b=LuhafhuHs7VmFON1V+WB8+14SulyZl1kQIh3gt9PUCl0pSi85hgnHDDM6tiBnzoDb6oaFrhkP095JCNIbV47CWzqJ2jhg/bfilxvDn9MTRaqPcyQJRf42X5lIbmjLegtEKm/zv15koj6ANlyNKgZJ6b5HuX/WS8s07JBcr1bHEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727319644; c=relaxed/simple;
	bh=a+2A2X56v8avfGnGaZXZZCNMUcWFVcTLZyUxm6YKkio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Riz561iIKiDwdyV4pcaq9Pnwcg4R8acYe07nDsL8EGP671Vr7979KoS2vvbEPpAkybb8RYQ14h3++kaxe6h/lBGUDJdQKzc/oqSiefxZ/S4g7mEDBUUPjNx44HXnH+BtoerPiSrnRgRbq7H4FdniGit+Ogs/SGAXERJJ6AXG0I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=DIY/71x5; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so291971a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 20:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727319642; x=1727924442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQ326iJq7/755KDRIrjwbi7w0izAIGARnlRJDcZSAPk=;
        b=DIY/71x5yAph88swWhxr1+Xxkd3Y/aecwLy+KwKIUjNySkRNLVheYVyniHPYnPKF4/
         Qq4c+LZqMJQf1Fl68ONgK5jS+C2Bs05kF6GFtNl5TNpsvex8UFscMkp0rmYHPvdYRybD
         A8to4rnTGPWa/lzqq/w2vkJoXbt+XL+QfjNYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727319642; x=1727924442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQ326iJq7/755KDRIrjwbi7w0izAIGARnlRJDcZSAPk=;
        b=c833iYvRDun2OIPqjQyLtRd2wn2dfpIng0PxASEe+jAntaluzsBwT1WR5TLDuCUnzr
         c3LGA6YU6woyU0p5+yUuC454di4oipPmq9yBHBATn/ZtvPO4vs+wO28lY4AljD4vN6rV
         tk5dvl9F3DctHw40LxEVRUYggrLQOQOs6MBTGg9OVh0X3mmaIdnrqbBkDOjvI97zWZHH
         cLcMIpMBGOzPbwWTt+mgObmIXZFsILvDZq22N+dNb7f83CDce1GYr70X16MCU5GqICNd
         mPNaSsX6PqNS591r5CRpsT5AULdzZUCH3x/qOevMjvgwzxdKFXzp8oMcJ7fClAok0a4k
         2qdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY0RuFMzehq2fu4cSf+wYbpV6a5y93dIcXOFHdH0cbAJhzazgX7RtRkwv36DYJmzZdhPedG5nbw3z+96k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqsT22SjjAvmTIBh5965RPArCE4XGgsFytXwrj4nSxiDbFYBI/
	d5s5l1hftU68jdIBkrsYaBXAcn662Dq94LoSACAtIlosUtc9kdt7W1HI2Qo1Yio=
X-Google-Smtp-Source: AGHT+IEl4JZWW76rfK6necgAw5IVoweAhLHc+sCKW0Ogf1bMtEKelsG6Qo1q6hyeazOeixbqu5s/3A==
X-Received: by 2002:a05:6a20:cfa5:b0:1cf:3677:1c4a with SMTP id adf61e73a8af0-1d4d4aaf678mr6134983637.16.1727319641715;
        Wed, 25 Sep 2024 20:00:41 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc97c2a8sm3354111b3a.163.2024.09.25.20.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 20:00:41 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jeroen de Borst <jeroendb@google.com>,
	linux-kernel@vger.kernel.org (open list),
	Paolo Abeni <pabeni@redhat.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Ziwei Xiao <ziweixiao@google.com>
Subject: [RFC net-next 0/2] gve: Link IRQs, queues, and NAPI instances
Date: Thu, 26 Sep 2024 03:00:20 +0000
Message-Id: <20240926030025.226221-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

This RFC uses the netdev-genl API to link IRQs and queues to NAPI IDs so
that this information is queryable by user apps. This is particularly
useful for epoll-based busy polling apps which rely on having access to
the NAPI ID.

I've tested these commits on a GCP instance with a GVE NIC configured
and have included test output in the commit messages for each patch
showing how to query the information.

I hope to send this next week when net-next reopens as an official
submission, but wanted to send an RFC now in case there were any changes
requested from the GVE maintainers.

Thanks,
Joe

Joe Damato (2):
  gve: Map IRQs to NAPI instances
  gve: Map NAPI instances to queues

 drivers/net/ethernet/google/gve/gve_main.c  | 12 ++++++++++++
 drivers/net/ethernet/google/gve/gve_utils.c |  1 +
 2 files changed, 13 insertions(+)

-- 
2.43.0


