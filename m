Return-Path: <linux-kernel+bounces-427632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B243D9E03FB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77EE12823FA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98E2202F93;
	Mon,  2 Dec 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="qTVpSCx6"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6774F33F6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147370; cv=none; b=WiSNWSfz3K5m3pbAvcVu22B9byYSHcqBrdVLrGs0tDeXvMpIKpf8uxeZ+n8gf1I1qa79KQ8uTNF5/gkvpMcFvTWh1aezrc1RNHFhIiCOg9FlIz2UkOZtArXngJswq6qHPtiIftXYCug6cwF31/FbJYFZHicbGru2UDnJy6IUfKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147370; c=relaxed/simple;
	bh=SI27lQ6ouPyc6VSvj6mijRBvLjbpSdfHHV2X5cxHAlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SklG54h4bsPggluJuhTcuS+TQJzWuMFE/XWVBSROdYOVBxYa8/X+7tgn+drFCXhnmTctYnG8C8WFg3u6dYQ59AJSuWDi0qq1VAccGeIMLUzz4Fj9ItTVyzxps2Oz5c+4QOpRynwwups269NLjP5YysFyfDIZdJtWqWmojqeGz0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=qTVpSCx6; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffbfee94d7so35441831fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 05:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733147367; x=1733752167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cynV8pOJrKJvNaQFqaJO/JMUBstzgBuJjjWcaNQed4I=;
        b=qTVpSCx6nDrSBxfGPmm8KRQIza1xs8O+P2CMhuBLjzwZ+1/K+LOyRjrwf31ALA5B0Z
         fV2pN9Ro5NwmhF5Ow5oK5q78qT5YOkCWs5luj5egPC6fSomWZikC8qxVI/LpP/ZCF5Kn
         k+gvMiMkYG0LQqzPY5oWD6UwwQ9tUJDbQ40mo59KN/zFeQhqSYurkShbpQ4FoLUnwXSn
         RCFtJnFymsFKpwyiqbuYVmbKnwjra+6Ycq2QoME9r6li75Gnw697/b+XV3vF0yPw5oTF
         2qogEYnGPaZZjvQaBh1CEtzVtD9dujafXPdnZmV1O3e8srVM79RcprWWHpvGJIKb6tmK
         122w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733147367; x=1733752167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cynV8pOJrKJvNaQFqaJO/JMUBstzgBuJjjWcaNQed4I=;
        b=VnapiqvyM4YVK9pNuLt4294qC6l80O8vAQquWccWx3vAzTUtp7Z7TEtmGFPjRusLmK
         ENWYMqh6fG4KeI2XWfr+lA/pTnmzEuKBn+iTV7xZjTPmAQpBGZijcavTrDC7/Rtzp7kV
         XkWwKxA/QmaijPvMKKYdgy14u2G/Mlpo5JSsYSDOvy+67izmgdkQ5mqJk7LVHs2QSJ7Z
         F6JGktFh2sytGlJ3mOunxO+xxdSJMERd1utwYdPDurVaXm3A9VzVremprV/9ojjOdE9k
         tdE7Rz0Drdsh1HyLf6bO2DRud7pUL9g4Wbz6++Eoi8T59Buuu7fSiLRkdTok81z8hBDq
         SV1g==
X-Forwarded-Encrypted: i=1; AJvYcCUXWUCggjZ+y1eMXXJ1k2zci7KM+6DSaVeXpP2fhhQjTrZOx7rVO0xgyoKO2ctepphmU9ZpN+l0RNzIQ8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKaMykuUrk3NBASjOOSlK4fyI+CXaKBb6hVHNJjixbuxef5TD2
	AELBWsUDhq0u75GeEtLzYDPXV9yAPy1nwF9pu3Qma6orimMRLgp7SG8x9HWYJxY=
X-Gm-Gg: ASbGncttL2UHWxqSVqOylirMu63iRziOWLayvoamhLuJqnyDdM6bRNnMmudGquxl+O5
	mMGxrSQepb/gaM01OgMTteBEyGFjn3naGCYghykLpOkNk/hGCMnm/71pEGH6Zay1EmVfI8Vtr6D
	5y/+UlGo2KduLxF5C08AuGqZJkPclzfRjoob/vDaqwWOVSw/iDauuxacZcAmx1w9j4P+Bfbo7ct
	8Hxvb2jYEWZGMLOxdZ0Jw7Kz6E59lQFjXdNvuJWYwlEMYvRV22fwwIVWHe/0OS+
X-Google-Smtp-Source: AGHT+IGMSwQqN8YQrvqohBJn4xVh/kPUa6r3akG6CJKNWLEOJ8q9gtd0peH+hJ9kwJ7mo6G0r5fDTQ==
X-Received: by 2002:a05:651c:1547:b0:2ff:8f5f:1adf with SMTP id 38308e7fff4ca-2ffd5fcc1bemr59514231fa.5.1733147366620;
        Mon, 02 Dec 2024 05:49:26 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb8f2csm12972661fa.15.2024.12.02.05.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 05:49:26 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 1/5] net: renesas: rswitch: fix possible early skb release
Date: Mon,  2 Dec 2024 18:49:00 +0500
Message-Id: <20241202134904.3882317-2-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241202134904.3882317-1-nikita.yoush@cogentembedded.com>
References: <20241202134904.3882317-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sending frame split into multiple descriptors, hardware processes
descriptors one by one, including writing back DT values. The first
descriptor could be already marked as completed when processing of
next descriptors for the same frame is still in progress.

Although only the last descriptor is configured to generate interrupt,
completion of the first descriptor could be noticed by the driver when
handling interrupt for the previous frame.

Currently, driver stores skb in the entry that corresponds to the first
descriptor. This results into skb could be unmapped and freed when
hardware did not complete the send yet. This opens a window for
corrupting the data being sent.

Fix this by saving skb in the entry that corresponds to the last
descriptor used to send the frame.

Fixes: d2c96b9d5f83 ("net: rswitch: Add jumbo frames handling for TX")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index b80aa27a7214..32b32aa7e01f 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1681,8 +1681,9 @@ static netdev_tx_t rswitch_start_xmit(struct sk_buff *skb, struct net_device *nd
 	if (dma_mapping_error(ndev->dev.parent, dma_addr_orig))
 		goto err_kfree;
 
-	gq->skbs[gq->cur] = skb;
-	gq->unmap_addrs[gq->cur] = dma_addr_orig;
+	/* Stored the skb at the last descriptor to avoid skb free before hardware completes send */
+	gq->skbs[(gq->cur + nr_desc - 1) % gq->ring_size] = skb;
+	gq->unmap_addrs[(gq->cur + nr_desc - 1) % gq->ring_size] = dma_addr_orig;
 
 	/* DT_FSTART should be set at last. So, this is reverse order. */
 	for (i = nr_desc; i-- > 0; ) {
-- 
2.39.5


