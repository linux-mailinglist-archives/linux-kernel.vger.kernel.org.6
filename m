Return-Path: <linux-kernel+bounces-435503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FFD9E78B4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B30516B4E4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C66203D4F;
	Fri,  6 Dec 2024 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="yeBXnInn"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9201DFE1E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512609; cv=none; b=IeU5evrq9r0/67n+6Y3USGVjKscLyKLXHh/GjfkiXHIdjqHxYO83r74hZ9N+B14mfoJ70NmdcXz5+vO4DpK/aA+WobX8KiQ4sYO3NbWjsF61hhCtx0RKlx0t53xEd6revU3Sad8H5ZRBF/j2PXFbVFBprG5ysL3gYZqt+tSAv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512609; c=relaxed/simple;
	bh=wXdUfPDZdTp7uaCmZH8pm7BfzwNL7Ba4+AgLadvA+oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oW+XwlHPkjw7cuc7GrTVfQp/2x6R5Nk3hIO+aKZKE+PRAvlpILVz8Nym64MOJaXdgOqNbdUYaRR2uDw5BGpz3dKR3LALUG5dom6KNDnKutJqgjpyq0A6z0yXu8WibtMqUkobLE16eiUuw2DOUdMwrKLbR54l2KZNe8Tz3j7BjQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=yeBXnInn; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53e22458fb5so2263077e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733512606; x=1734117406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qJbTipl5jmcN+zl+yZ2AXjrvMRunb990PfhdGFi+FM=;
        b=yeBXnInnAHebowSy/6LEyx7rq+2F8MuBDzcc1z9TOClxRX2vm2dhFsm74sRLYze3JY
         CCvlYdZhyyMpNd3qVz0f4wGnSBuOlg3OiDuSvlfXlKlv3FNFk7A8+5k6CoQwAKLCxLwS
         BQYgOFOwDp1DISzdf/XpE9OlW8cD6iJsZQtoNj2gPRSeM+iwJJWpbXPb4c40hDK6zI2B
         thmWBcqLu1ipi0WzMlCWIwReByfskL43prk4aPAjIAjDQlhvM3D71VB7X+qTHUOVO58f
         7Xx+SuJlBTv0R9WOmVdIDUTePB7qnTm+R6JuVT+fgTsz438ps68HJZKLOkKPF07eLVK9
         k4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512606; x=1734117406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qJbTipl5jmcN+zl+yZ2AXjrvMRunb990PfhdGFi+FM=;
        b=PJCWOA6sjlgTST8oEgxI3QkNXTQk2zvHV6kMajmV55u6RSjg9g29KPl3JtAt2Q/jrW
         2TWkgLVLs3hz28NoUoTWe5qhqwQPrlO+aMhGg6vP4KHTy8cAuvp9/ycaK3ljrYiH0qgp
         1XNTj78nc0wL6+TGqaFwmbZQx6Ffj3vuZPlSMiAEnIW0w1TjD0XSgu/kyCij9/tNbEKs
         0cUMGQBD/pY8FhvhPtKEwjoZfQIK0k1LVxgRK9Ei1v691UPmzQVJd06wJ92uyhodmJim
         wZcsJEOC0So0dCrxTfWdBlPOZ5q8YAulC0f8Wol/Tke/9hkTUhJaSxtYcC3oNoqn2oPC
         GKBw==
X-Forwarded-Encrypted: i=1; AJvYcCXeq0AKiOZjHueYeXojb+limQlnZn7OR82w9/fjxgIMD4lOiyqbN3mBM0PJZ0cyDLbZeTvnQ7kzhcWAlaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywba95N55x/HX4Tzbq+LiOJzeL6LtyOtCiST0wDQQoFHin9EN93
	mc7ISYUZ9bzgKiWViRffHxpBY8CFanfbOqcmfCluo38EVjg1H3aPB3snyBqoqy34bxC591fR19F
	f2lA=
X-Gm-Gg: ASbGnctu2XJfVm+RZBnsgw93BipgXWKjtaGJochydtYbjCknn2ZtiEApdqemP5GfvZH
	Ms31BuoiTd9I3XkVRAbVAO1/ILSmEfGSUjxwBGuY4aZ+WyRUCHJbhoG9U0zFcHc4pFiso2MnsHy
	XyjXjgS8pS4DQ2QKULyoeE6TwiOiA6tZAVq1mtpy4xr0i0hzW3Aekkb2gXSP2BKKsiApP8fND/l
	7cLhwzkDdg8tSsqoSIm+2rnBwAPYUhTzA5X8i8VEW6WWFNE4A822Xlbi0BmV505
X-Google-Smtp-Source: AGHT+IHuzHk6NLkXAtdHOqa5qip3aYMDDKdLV1Lp1l1D6ZrIJKd5dbtyB1JS3gM+1Efv+f3BgNnv7A==
X-Received: by 2002:a19:6450:0:b0:53e:3729:eae8 with SMTP id 2adb3069b0e04-53e3729ed4amr728856e87.19.1733512605591;
        Fri, 06 Dec 2024 11:16:45 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229bae3bsm575973e87.127.2024.12.06.11.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:16:45 -0800 (PST)
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
Date: Sat,  7 Dec 2024 00:16:40 +0500
Message-Id: <20241206191640.1416-1-nikita.yoush@cogentembedded.com>
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


