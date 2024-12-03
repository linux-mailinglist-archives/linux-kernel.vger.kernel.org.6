Return-Path: <linux-kernel+bounces-428854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FE89E144A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C086B16693D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DE91D517B;
	Tue,  3 Dec 2024 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="og5pTrpR"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FC71C0DE2
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211069; cv=none; b=W90vic5Gq5FrzXqJpL46/yagZhTE6woDcp6tdinZoQPtpcXeR8KsjE84WuTYPCOli16rQpeQy6WBuxhaguI7SMDe2oRWHFMfMsYehAGAWtQuU2GtsEdhXf+Ky66bAG4dICQkMShfVC0715ldXqeRsPpIeC73tPKssE/JDmIRerg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211069; c=relaxed/simple;
	bh=ONGQeGV/Lo+dvZaz/MxmBnTpy+k0yha3gjPk1y+HOIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfNG7tcXU9/XBu0IscT6lNMoeOnwzuqesTIs/iEFM3eefc1AuSr0GPOuXElxgnCNtuw98aAleV2z8haXjraDMbvruNVJu4wiXmOh6iFVmmmpcUErCL7M1WdxZClFwwbc0/auTW8DF25+1KzdPFV+vfg4XNI1Lx6QtoQ62VWg8RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=og5pTrpR; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8F7A03F626
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733211065;
	bh=5NLMnu2Z46KkDgOBwjL355ay2S58qzCZBNzBIFOkdbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=og5pTrpRvLJr0XSW2GAPqyptSvzFiPq9P25nRwiD6RklmYc4qDy4rvVU9T3KAfj/x
	 Kof18ZoRu2x9ict/CHI2zJFFgFlnisNZJDC5EBmFIvzAp3IyH/I6AnGj6wQFPR8q1w
	 zbXemcHYEdDkJS1yXV2fTgikPPjukJndYPlIPy866fkR8/bemteoziajT0nGS1brC+
	 Ih4il8+C72+0fyb+YPTyc5qnsfMHHI4OkkyFX3QeTY3HbQ1wShBkEjDA58NiYyloHw
	 ng8xxkWAkYp3nJ7RNl8RLA7S/ixHNBID+0F0F7RXLwqWJMomQZt58oZk2zSkT7n41Y
	 fhH5R9zpnNlbA==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21567f825d2so25688985ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 23:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733211063; x=1733815863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NLMnu2Z46KkDgOBwjL355ay2S58qzCZBNzBIFOkdbw=;
        b=sBa0psNaPKrryzWRgoQXNwOQphAI331ibS1Hs0cwBj3KjEV5jxjJgauNCQUM9VsYk4
         MOKO8HZyI5AvpsSI7wD6Le5ifn6mUt5F3V1735aXdoCWSURXVW73wLKy4tRR/Z2LiPLK
         T4mvHUIG3CoKipWv6pplNGNyELU0kRaho48/wjD8TyOsDb+aeE4KoTdTHpMjX/6niZ72
         DUvzjvkTPOa8X4rpg+MqXZe1Y2m8W5hpTTT5JebQi6Ii+1s8l9s8gdMA+dAENz7DZo8D
         JAbrvaIOIx9KgIpxezKGzHdzti5TYxzh073TTGV5jnCMJJvcvbEvuwEpMeeTo+F81qtU
         NHBA==
X-Forwarded-Encrypted: i=1; AJvYcCUSrg59e71+7V0RyMzkJa+V1h0if8lnpyyOSvrKE9C7vLsuPmQDHxoPRPlX+lv8xZGk6JRIU7p2ZQMt47k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx58zl68c+32E2OgIvjuKYAAmxv/nEnvWwwpb+FU9JTbzdGgI+h
	BGxTkcT1Ipo0v9Ugns60dFPHEh5x+PTQDrVtucI44QJTChpBOXCXFE3o6DkRsVUlYQXCUIAn/AI
	GYZujg+lRTVECNf64KGwhpmMk/VQYTvlCP/TdyFCl7cXt7j+bsM2xhAuY+3Of8u11WiypRd24CB
	JU4w==
X-Gm-Gg: ASbGnctemJwdrEmYzRNdP+EpZB3vFPuvs5C1TicWGjHFYyirg+aipnv0g+DGvUYqwZz
	0ES55/HvoSksk/hWtg5J+Kx1PuNatGN6kXphY3YEBimuehbMpwnKWW4cvIRmmm1RxdcsziU0y6w
	S3SPx7r0OVcJKKV99ku9LhBDiPd9wX0p9YBcavmj38uJKw29wdGosVvYqxJV3QSrxX0ezyXWgm5
	wzAixv2yhjDzVPQmSKA/GuhhzBpp09qk9VXPeh7RnlYHmwBhoF3slTnESRsWsGG0t4R
X-Received: by 2002:a17:903:32cc:b0:215:6e07:e0c9 with SMTP id d9443c01a7336-215bd25580bmr20893725ad.53.1733211063425;
        Mon, 02 Dec 2024 23:31:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeKLM2ys5e0Q3udqn6af/fNUMQYdUmFkZT/mCzd4RS2FR0h2mYZFsi+zEkr90jaY94M2UwGw==
X-Received: by 2002:a17:903:32cc:b0:215:6e07:e0c9 with SMTP id d9443c01a7336-215bd25580bmr20893465ad.53.1733211063136;
        Mon, 02 Dec 2024 23:31:03 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:b2b6:e8c2:50d0:c558])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21586d40afasm35735165ad.270.2024.12.02.23.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 23:31:02 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: virtualization@lists.linux.dev
Cc: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net-next v2 3/5] virtio_net: add missing netdev_tx_reset_queue() to virtnet_tx_resize()
Date: Tue,  3 Dec 2024 16:30:23 +0900
Message-ID: <20241203073025.67065-4-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241203073025.67065-1-koichiro.den@canonical.com>
References: <20241203073025.67065-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtnet_tx_resize() flushes remaining tx skbs, so DQL counters need to
be reset.

Fixes: c8bd1f7f3e61 ("virtio_net: add support for Byte Queue Limits")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/net/virtio_net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index df9bfe31aa6d..0103d7990e44 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3399,6 +3399,8 @@ static int virtnet_tx_resize(struct virtnet_info *vi, struct send_queue *sq,
 	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf, &flushed);
 	if (err)
 		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
+	if (flushed)
+		netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qindex));
 
 	virtnet_tx_resume(vi, sq);
 
-- 
2.43.0


