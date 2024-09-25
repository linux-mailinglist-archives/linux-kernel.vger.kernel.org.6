Return-Path: <linux-kernel+bounces-339503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60460986611
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE2F7B2314D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C4554757;
	Wed, 25 Sep 2024 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="OG4ptymS"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DEB1D5ADD
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727287225; cv=none; b=Vnknb+uhZMzZ1+zgugf7QNDqRTTmsqwyjupB5hoVXHIFcwUc2/8mdX+strHtFzkmQ1Po7YbNV/tPi7Jx6ATTiqlQj8T5iWfY5alx2CyNe5oZ+MV11RRURk0mi25nlJTTLPXVYxOWbtEV1EdFCA9HkZVt1heBecwLtbbN3BqoIeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727287225; c=relaxed/simple;
	bh=ml7Lf8R+3X+VkfxghOUGl4HkedqDwORC7CzGX9bOHwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qipc0RP5U/iTkveCVbLQU1h0sCJvdQWITBprjpq7xgorfpLsX+JL5+Iy0t7YEr3t2Qg02P4iXHkPL6V2LRUA9wpa5igNy3gG5w6aezPNzdTCwbAd+QxRKd7d4okQ5VySfgqAaPqZNnhOoAyCICU0F3Rs+tNhGEZmUZS/aVVuC6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=OG4ptymS; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso78273a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 11:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727287223; x=1727892023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=80NsANXDl6afdpJyUxRTROzlpMEuv9TyTDUFDqoq4HI=;
        b=OG4ptymSYvriSg796+FKu67afq1ipv9Z7zKmEoz0oF0qnMMM7PQIn/ZwEcJ24nbSq8
         ggnxn7ilVGFLfgHBnXoR9HqvylYLbj/IdYVzS2cZcEMKKxCiZsbSVxcMsCDIQKpanrhx
         /hhiiMlijMaf1uJCAgSRBT1EZLgDeC073SbR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727287223; x=1727892023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80NsANXDl6afdpJyUxRTROzlpMEuv9TyTDUFDqoq4HI=;
        b=vuzEemULzZG6tcJ7+oAQtgpz4Kbeuihh8HoOTXodRu3kJjoiaIy8F8QjET3tl4ISnC
         hf0NDz6wH3u1w+NnfjsUtO9I04NekqHK8FzLKVpwtpaTIZOi8u33RvhGs2FnAGIqZST1
         vEQ8z3p3Z7pE2Hc3ViQwEY0UhzWrzHfBYwQ5oFnU9eaUmuPugErjDP/Mt2dj27ejpPwB
         w9vxwAlp2p2BkKyEJdpxrAeB7iUCHMGCshEqJwxfZ3VUaQjB5DpT8WEWkhJOT8CaD8WR
         ZTaCRo7a4yKROoBSWbnZ7PrcmRpv41o0lVB3kHeyO0H5PiKBtSHZ4bCzyiH9r6eusWg/
         J+qA==
X-Forwarded-Encrypted: i=1; AJvYcCVDpKx+FgBBUCUCMG+9tIm+RSe5GZ6zqfenlAFt/1v8enHv61xWxEBh5Gk3XMytFAUO0yP65DQZusO9ZMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrlUFSG+volE0tlWrcD/1fU/mmBk0uWYzTeDqYsLQjU04QPEC5
	tRvq1+o8MkC4rGQVfU09Akcb8ERIggJX5REf+mtt4Rtgwd/SEYbyWrloPz/JgkU=
X-Google-Smtp-Source: AGHT+IHuEEr9A4jmt4t0IDsNG4JI3VKgSWVYhK1yjS6ZBQdIfGIEb27Yn7hFv1mpig5rQWcSs3VyZQ==
X-Received: by 2002:a05:6a20:cfa3:b0:1d2:e888:3982 with SMTP id adf61e73a8af0-1d4d4aaf7fdmr4336724637.19.1727287223334;
        Wed, 25 Sep 2024 11:00:23 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c73092sm2980539a12.64.2024.09.25.11.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 11:00:22 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [RFC net-next 0/1] idpf: Don't hardcode napi_struct size
Date: Wed, 25 Sep 2024 18:00:16 +0000
Message-Id: <20240925180017.82891-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

While working on an RFC which adds fields to napi_struct [1], I got a
warning from the kernel test robot about tripping an assertion in idpf
which seems to hardcode the size of napi_struct. The assertion was
triggered after applying patch 3 from the RFC [2].

I'm submitting this as an RFC so the Intel folks have time to take a
look and request changes, but I plan to submit this next week when
net-next reopens.

I did not want to the include this change in my RFC v4 because I wanted
to keep the review of that RFC focused on the in core work instead, so I
was hoping Intel would be OK to merge this (or a change which
accomplishes the same thing).

Please note: I do not have this hardware and thus have only compile
tested this.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20240912100738.16567-1-jdamato@fastly.com/
[2]: https://lore.kernel.org/netdev/20240912100738.16567-6-jdamato@fastly.com/

Joe Damato (1):
  idpf: Don't hard code napi_struct size

 drivers/net/ethernet/intel/idpf/idpf_txrx.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.25.1


