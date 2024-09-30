Return-Path: <linux-kernel+bounces-344732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D512D98AD96
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9753228245A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE03F19E82A;
	Mon, 30 Sep 2024 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="RJyXOf+w"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C359119D89D
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726188; cv=none; b=lYyxvitLrT9rt6oWa0j4clnGFD86W2x9eg9i9XdcxJ/ZaiJKPXTnrEIyfKscYdl6HBmsbhHx81iDPfv9wiwdf6f6Fj87+cV80UtKfTWK5F7xN/moFTcN7lrxA7eOQbmsKJFF8O5xaiiI283DOOMjF4Gf2XYwa3vGSGyEnXWtjow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726188; c=relaxed/simple;
	bh=nsUO0zUQmPXPPHgAa7TLcCDNB56tC1YTIiQbChsZvV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mnPnv0ubudjUFbTU6xlajUcqWuPM3h0jrJa8zwuDqUyYksgVZt1sI97SGuOGygRjCqMCW+D6QO7xeFTGxOd/06bvY/asLBcs1pbzw6neiHVo/uRmUGzSMaau4dJTMJScuTnrmZ/25HKmgVzaIUDfJ8KzBaiock2jZgHJ56ogaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=RJyXOf+w; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-719ba0654f9so3997582b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 12:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727726186; x=1728330986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=04aIwQhVG9kkwqyptz1spBSbHv2X9I/9d0b2JatFAhQ=;
        b=RJyXOf+wXACz9wnyeVNKgTGVV3fzalT+WhJa1AVnTxUyU4NWa8H8IeltV8esdbPxuE
         UB2FDOb/e5Hoklbs7w+GYb2eafcZM9CRTC0pYq4gGoDaiuaefa/xJoy1+xzU9ZA9NZwy
         3ptLPjRGfDf5ixwornc7Wxr8gl8Jd935m6mns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727726186; x=1728330986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=04aIwQhVG9kkwqyptz1spBSbHv2X9I/9d0b2JatFAhQ=;
        b=kIhWkxcTt8GEix3ipBdBJU6NQN+vjSWh5SQwb8EEAurTf+H61tuwqV4aGWeJq/9gRd
         elomJnxpV1oU1UIv0GJe3sDyXsNE3gIypGP2RAvcAOat88Agyuz5T2f+KUcvf4AHMiAp
         ljSBKS3ZwpxzIJIXel3xnWDsKN+FgHttDQHLoPShfcmPsgwI8nZRlDcd1AsZlQBJ9GRe
         C32ddOTE9NQMO6nB0uPXs4E5i0t1Ai/y/yvD3QcF3KaRI4SQp6xlJSlFcpgttvGemCpw
         v/ILWd6PJ3xrzx2qOJlDhG4MfMe+M6v9DGVW6cHx4mjYteTqYmRZ3eCdQ/UP1DYrEvMO
         WSAw==
X-Forwarded-Encrypted: i=1; AJvYcCVeuXx/16DpGQz29i6IsG3snfzx0xkp/Q5F0VLqQiW+0qPIBb474gSoWxNGdzCQfhDrXJqNoU0wCwxX+OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsHD5Zmg3Cd/HXsFCQcs0sa5GZnIJTXZcS9i6296F0LSvMXujl
	oPBDfvUOVpJ4P037D4lbQ1LfmM5pSimbJE9XZjmhHn29oMRlGQZqjtY5Aohbcgc=
X-Google-Smtp-Source: AGHT+IGe90vkHUWOcUodfCwsCtj3m+WHIqgqWMT4BLw6euSWP2mWVdam1jgwx+7tGd2QFCKQcm2lxw==
X-Received: by 2002:a05:6a00:198e:b0:714:3a4b:f78f with SMTP id d2e1a72fcca58-71b26057a41mr18282679b3a.20.1727726186115;
        Mon, 30 Sep 2024 12:56:26 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2649a2cesm6604450b3a.43.2024.09.30.12.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 12:56:25 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kamal Heib <kheib@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	Noam Dagan <ndagan@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Shay Agroskin <shayagr@amazon.com>
Subject: [net-next 0/2] ena: Link IRQs, queues, and NAPI instances
Date: Mon, 30 Sep 2024 19:56:11 +0000
Message-Id: <20240930195617.37369-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

This series uses the netdev-genl API to link IRQs and queues to NAPI IDs
so that this information is queryable by user apps. This is particularly
useful for epoll-based busy polling apps which rely on having access to
the NAPI ID.

I've tested these commits on an EC2 instance with an ENA NIC configured
and have included test output in the commit messages for each patch
showing how to query the information.

I noted in the implementation that the driver requests an IRQ for
management purposes which does not have an associated NAPI. I tried to
take this into account in patch 1, but would appreciate if ENA
maintainers can verify I did this correctly.

Thanks,
Joe

Joe Damato (2):
  ena: Link IRQs to NAPI instances
  ena: Link queues to NAPIs

 drivers/net/ethernet/amazon/ena/ena_netdev.c | 38 +++++++++++++++++---
 1 file changed, 33 insertions(+), 5 deletions(-)

-- 
2.43.0


