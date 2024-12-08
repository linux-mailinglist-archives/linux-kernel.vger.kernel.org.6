Return-Path: <linux-kernel+bounces-436326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA5F9E8476
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 10:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDADE1884B4F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 09:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5C41494A9;
	Sun,  8 Dec 2024 09:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="VOyNYOcq"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297271448C7
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733651417; cv=none; b=MQZgs5V5UWdqR6yZdFQHm9DxcswFX0h2sbhTxbA9NkKL/riRpK5LI2G1uiIFeW7d/iV+O2VKVmAZhKellfdiJpl9ODtvwh6sWbcDy35QE3VxJvFAvRbZRFYzgYFv/LYLLj0/4XhFsZP0pmUMaLYbYUABkbomTXbpXg8qmjtRcdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733651417; c=relaxed/simple;
	bh=wXdUfPDZdTp7uaCmZH8pm7BfzwNL7Ba4+AgLadvA+oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jsXAMvV+EmUtd8EZ0+UZ4EDYtEzTW26OubPH/+Z6Uh96PoPfYeaLP3VahisG3dAALfX9+1ERI0bHcXeD8gKabwDtanEbzoBG0U6JQ1aEVPODkOpWYL3Ck9Ie0MKB0v2xvTIe8BkCnre+mjOTld1EQupgb7KdwK0Rdj6qPhzYU+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=VOyNYOcq; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffc86948dcso34126781fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 01:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733651413; x=1734256213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qJbTipl5jmcN+zl+yZ2AXjrvMRunb990PfhdGFi+FM=;
        b=VOyNYOcqXtcI3aCNYRedaRVcOaFPSgTgnsDW1JqQD3s/C/3NnzJwJVPCd1TkgATPzf
         nt4UwqQWzNDhbwqL3TWfYdICpAb/b2LY+DRvtVlNMAHcaqIjDhwVpc7j/tbuc4czCv7U
         Ju0b31JTSxN7K0l5o/5yspnzzyTYRfYouZLvaKDTAEqJZQyvhtcUJd/Cyq2Jwr7w7JdZ
         K16SFeY0qMdvJ0LH/WDSbPaZZIzp7svCNisKyU1yOm0oCWdyHMX4wLR8FQSDCusp3hHe
         v6pqZ0kbObYDI3a483+JP6zgGJo/DbQ7ztkoD7CrKDTTBsccasIyC554v85uBUGeQzGe
         /8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733651413; x=1734256213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qJbTipl5jmcN+zl+yZ2AXjrvMRunb990PfhdGFi+FM=;
        b=QXw1gcBTCAARYDUh+ixeb1iLKHieIxuKDhuJahUw7XkJkuhlpsU/06LSUj1ifjpr1O
         gvwiK3z8r7jdH9DLx0FTgFalxwZyDaZD8rgzEbwtOsSiHH79I4UOaE3CvVPbp2U8rLbF
         Eky51GXTqw7+Ts1SXzhQgEZKkdo3sUDGXyjfcilYJy+iA7J+TGKPkYYuUNs7Qgx2Q8YC
         m9BFn+fu7Wn81Wc+RF3RHu6w63HG6mjnzlcxN530DX13Te7fHsFaxqlV46cI8g6SKcf8
         Qxhuz91EiiSNUWj250Vf7O5LWRZDjWE9HPsOd91Wlvdj2R11qy8RhL69ZTnPvcBXrRQq
         Hhig==
X-Forwarded-Encrypted: i=1; AJvYcCUNCa111eF/wKOesS0qrNTwPsnKrLiCyHijojNCMsRkseLUhoHD77Z7/YYcGUg6J4GS021yTo1/in/h46I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmzWZOd5jqT17gGyF78FEolBK9p00lrVu/mMxN2w/qSbJNXSHU
	h+r+s5Hwy8HmiF2cmZxTpahUfDBciYqso5CJQ67gCr880TwwGipatldA1PkAMVg=
X-Gm-Gg: ASbGncsSLgsY9g2vab6zFFDzrc3is7+oxwHXF6K6y/TudEIIQjdVvH8XjQ+pZaGbUIo
	SS4k1XBcdybTKZzVmb8UAbA9DwwdvCW1UnzCbXbBpICnK6nUpSQhb3ydaMYPh/cM8aSMGYmHYTL
	f3AZRxP+biNw0i0928zcjQxJbHS7wA/E9ppYe+3DQdwqNQbY/urVeOvHins98adQHylItY0m5Ae
	KivpoBBqk0/z6Zd55ACwTIlDE+rqk8R/TeIO/mvhp6LBJJfndMq/jbU7KHBmgzJ
X-Google-Smtp-Source: AGHT+IHjfkWlUO9ktjjTWDVzSSef25MV2HxBTpd82UrqbQLyW1H2AFrdbCeLYV2NDHOM5jBn6C1seA==
X-Received: by 2002:a2e:bccb:0:b0:2ff:55f0:ae4b with SMTP id 38308e7fff4ca-3002fc2585amr46517131fa.21.1733651413281;
        Sun, 08 Dec 2024 01:50:13 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30031b80e7fsm6645311fa.120.2024.12.08.01.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 01:50:13 -0800 (PST)
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
Subject: [PATCH net v2 resend 2/4] net: renesas: rswitch: fix race window between tx start and complete
Date: Sun,  8 Dec 2024 14:50:02 +0500
Message-Id: <20241208095004.69468-3-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241208095004.69468-1-nikita.yoush@cogentembedded.com>
References: <20241208095004.69468-1-nikita.yoush@cogentembedded.com>
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

Fixes: 3590918b5d07 ("net: ethernet: renesas: Add support for "Ethernet Switch"")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 32b32aa7e01f..c251becef6f8 100644
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
 
@@ -1685,6 +1685,8 @@ static netdev_tx_t rswitch_start_xmit(struct sk_buff *skb, struct net_device *nd
 	gq->skbs[(gq->cur + nr_desc - 1) % gq->ring_size] = skb;
 	gq->unmap_addrs[(gq->cur + nr_desc - 1) % gq->ring_size] = dma_addr_orig;
 
+	dma_wmb();
+
 	/* DT_FSTART should be set at last. So, this is reverse order. */
 	for (i = nr_desc; i-- > 0; ) {
 		desc = &gq->tx_ring[rswitch_next_queue_index(gq, true, i)];
@@ -1695,8 +1697,6 @@ static netdev_tx_t rswitch_start_xmit(struct sk_buff *skb, struct net_device *nd
 			goto err_unmap;
 	}
 
-	wmb();	/* gq->cur must be incremented after die_dt was set */
-
 	gq->cur = rswitch_next_queue_index(gq, true, nr_desc);
 	rswitch_modify(rdev->addr, GWTRC(gq->index), 0, BIT(gq->index % 32));
 
-- 
2.39.5


