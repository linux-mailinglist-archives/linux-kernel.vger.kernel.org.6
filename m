Return-Path: <linux-kernel+bounces-435486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57499E7879
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA9416DD83
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED88204592;
	Fri,  6 Dec 2024 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="XRyJBV5r"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B778B1FFC70
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511648; cv=none; b=M87znW3Z8m/7LxN7NJrPFvZfxDMN01J+XRxxTrqkvINZhF7hgy6AVQa/yBd2GzH+17Hsq9V8WssFw3y3WYZlFWX0f6T3xSZb5a/vx0v7UX3/3rLHF6tUTc7pFanr2aJihHc0pqeRVUqQpvaHlJfU7bqA/mKZINt4B5vGpVfb/Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511648; c=relaxed/simple;
	bh=b5jXhaNolTyyvrbjKKxRcvCAJp8P/hsnV5mqr6x9R1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ns1Ei9Qt++upN+uqtdfIuYSyGaKe2niPU/9zHQsgpJeGvO6+rcGpg9mgtyb5AKsv+lbHIag8c2QmbibqNfHM7it98DKq/77iOBxqi+0HDFJZ1AshrgROmffnryrX94TSL0iZy7fGtJouC/8+Ou8IJv8rYJbeSFy3GWzCA7QgwEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=XRyJBV5r; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ffbf4580cbso26642131fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733511645; x=1734116445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6OmUl/hmI7+OxMAFAfIf+jIYSG9pd6PU033H69utPY=;
        b=XRyJBV5r5naGO6NKYhqVdJ1aD41SPwRTObnU+SV6/NfOjJDykNY6Bo+ydj5kUjMuZs
         0uT5TX16HjBY34lB7Mu6iV0uVeofnX4zfgowjzPQ7SBgZVr2lStVSRXJS7ZVmgFZnZDX
         8ScRIS3kTXBtNiGgDsOid1y3nxeQxzC7+P78iHR68t8lRxhjPJJULAx25mMcPydWDIxl
         du6U3Q4TCqiHEXhaH5wso9j0WXhptPUIlpfuh3wUUNNC0l/csE3RSdth1ARqF2xW3ZwY
         eB4k2/unOTf/uRrJuIZg/Uxk+7b4NDtFOvnK3hcYyNmwX5djLN9QgmKk4ls/lnWKWD/D
         6rKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733511645; x=1734116445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6OmUl/hmI7+OxMAFAfIf+jIYSG9pd6PU033H69utPY=;
        b=j3mMBJlEa6Wi0p247rI29jUJ0SlmDvAYgj1th6K4R4N7XL/gLQR0W/yD6JzomxadZI
         u9ZBq14AaqaH60oesOQv9E3AnzIWklkSohvw4M4wvQNnha+2tFLhXoC8njXN2don+jh0
         8Euj9l2phw7nnz41ic7fPHHHVbO/mdStvxXqQD7CJyV5rnEXPHP+68NJ70MpokxhqREE
         JF7SpkXo9ohtyGczgDF1b9/HBIU+LKw4mIauXXfP9PJe36Xqa7Nn7RTt0txg/jwvb6VO
         5WnRqeHbEDYPoRJjOYlbVprym+LxzI2ONRmLuxtNd540PwKmOLhvSBEJ6xbjqvVkqc5r
         KIFg==
X-Forwarded-Encrypted: i=1; AJvYcCWSheGEn8Ztly2EzwsYA0Sl6ZSUrd14WS3PCnM6aeblCmfasoe6hlhBCzfsUXU5yEfiOxtVkB6CJjwUOvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC7X5gixy9Co8bghsqVM4KeVZXvEVnyyHp1r+KoUfzhoueMY+3
	gIWLd3rPnlim4Uj+e2FOfIgpCYEWNQYbWayuPfglRfyM37Em1x+TElEoeKZb3EI=
X-Gm-Gg: ASbGncvSaGLWdlbK1tQlw6nBeAr5i8qD0eNgVgIfEM09KAgNOYJT7+p/ChJvHqJ3qPO
	c5tH9di0MNjON9WyebsIkckLhonHNLPwrzq2z9yth/BdWeK2t58zz/gOcxyBadoo30bXwh9tU+s
	6p5+SsGk3Az53V311FqQBiBnLx4ROymYcYNnwt8Egtq6Um45ZxRPorQIWLSaLfMgtrr2hYR63Y1
	nWKqyJHxtHArnKGIBRCdPWm81wNZ2GddI3eGzy+Q8hz/eC29F1UkYhlli/5AFzV
X-Google-Smtp-Source: AGHT+IG27wfeYMQbSTxDwOz7Jah13F/6degbx6OGNBuq2fRCCebyOoNgchqtp/MSVdvmUbDhxY2IGg==
X-Received: by 2002:a05:651c:1586:b0:300:3e66:5881 with SMTP id 38308e7fff4ca-3003e6658cfmr4086831fa.7.1733511644842;
        Fri, 06 Dec 2024 11:00:44 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e58200sm5523201fa.113.2024.12.06.11.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:00:44 -0800 (PST)
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
Subject: [PATCH net v2 2/4] net: renesas: rswitch: fix race window between tx start and complete
Date: Sat,  7 Dec 2024 00:00:13 +0500
Message-Id: <20241206190015.4194153-3-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206190015.4194153-1-nikita.yoush@cogentembedded.com>
References: <20241206190015.4194153-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If hardware is already transmitting, it can start handling the
descriptor being written to immediately after it observes updated DT
field, before the queue is kicked by a write to GWTRC.

If the start_xmit() execution is preempted at unfortunate moment, this
transmission can complete, and interrupt handled, before gq->cur gets
updated. With the current implementation of completion, this will cause
the last entry not completed.

Fix that by changing completion loop to check DT values directly, instead
of depending on gq->cur.

3590918b5d07 ("net: ethernet: renesas: Add support for "Ethernet Switch"")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 32b32aa7e01f..800744a6c25b 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -862,13 +862,10 @@ static void rswitch_tx_free(struct net_device *ndev)
 	struct rswitch_ext_desc *desc;
 	struct sk_buff *skb;
 
-	for (; rswitch_get_num_cur_queues(gq) > 0;
-	     gq->dirty = rswitch_next_queue_index(gq, false, 1)) {
-		desc = &gq->tx_ring[gq->dirty];
-		if ((desc->desc.die_dt & DT_MASK) != DT_FEMPTY)
-			break;
-
+	desc = &gq->tx_ring[gq->dirty];
+	while ((desc->desc.die_dt & DT_MASK) == DT_FEMPTY) {
 		dma_rmb();
+
 		skb = gq->skbs[gq->dirty];
 		if (skb) {
 			rdev->ndev->stats.tx_packets++;
@@ -879,7 +876,10 @@ static void rswitch_tx_free(struct net_device *ndev)
 			dev_kfree_skb_any(gq->skbs[gq->dirty]);
 			gq->skbs[gq->dirty] = NULL;
 		}
+
 		desc->desc.die_dt = DT_EEMPTY;
+		gq->dirty = rswitch_next_queue_index(gq, false, 1);
+		desc = &gq->tx_ring[gq->dirty];
 	}
 }
 
@@ -1685,6 +1685,9 @@ static netdev_tx_t rswitch_start_xmit(struct sk_buff *skb, struct net_device *nd
 	gq->skbs[(gq->cur + nr_desc - 1) % gq->ring_size] = skb;
 	gq->unmap_addrs[(gq->cur + nr_desc - 1) % gq->ring_size] = dma_addr_orig;
 
+	dma_wmb();	/* ensure that hw won't start and complete before
+			   skb pointer was saved */
+
 	/* DT_FSTART should be set at last. So, this is reverse order. */
 	for (i = nr_desc; i-- > 0; ) {
 		desc = &gq->tx_ring[rswitch_next_queue_index(gq, true, i)];
@@ -1695,8 +1698,6 @@ static netdev_tx_t rswitch_start_xmit(struct sk_buff *skb, struct net_device *nd
 			goto err_unmap;
 	}
 
-	wmb();	/* gq->cur must be incremented after die_dt was set */
-
 	gq->cur = rswitch_next_queue_index(gq, true, nr_desc);
 	rswitch_modify(rdev->addr, GWTRC(gq->index), 0, BIT(gq->index % 32));
 
-- 
2.39.5


