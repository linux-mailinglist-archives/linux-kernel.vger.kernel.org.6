Return-Path: <linux-kernel+bounces-435485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939A89E7874
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 548DA287C58
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7339C203D45;
	Fri,  6 Dec 2024 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="An9K38cC"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E921D1953BA
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733511646; cv=none; b=RzzQPiDa1AHKhNf/TYvkAhPU98kxsROWiI2MsF5HmIYC7tE56tRMr6bEfxYe3V/n26ybykfT9A+5rPDTKBQV+62rdLT+j7FSc5aVFA+daEwurKQajhUfWxr7eLTYkIIkTAWe7M1v6+brAx83u6tODCnzs681HiCiAK04F3qetns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733511646; c=relaxed/simple;
	bh=SI27lQ6ouPyc6VSvj6mijRBvLjbpSdfHHV2X5cxHAlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AkzJe1yz1TB8ebJXsva6L+u5kFmFCwrAA3zXLuass1ugMXJJlymKUGGIhaQLhlJHItUEK0Xa4ur6z9fnHy6RPRRprDN86cU59Z5tmiJapEZTyKrUSozJM8a/jrxdUflrjtPdo1EKKXtP31+hDIPKlzK60H73saorA7ieJrzNKro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=An9K38cC; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3004028c714so486501fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733511643; x=1734116443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cynV8pOJrKJvNaQFqaJO/JMUBstzgBuJjjWcaNQed4I=;
        b=An9K38cCeebXwLpU8bCqmEJrBomOqrqLyAEbSNfU5B1LcVFGHGcoTePkagOr9EooU+
         ztKAPCweLgsy27AP1Rzz64gf2Iy8pl8uUv+1twRJ2O+gKY+a0jYaHQ++Fn/yBikwAtjM
         vFuwi5irPwKRVd9L+4pAP2HcCv1J5uwFjkwLEXQVvq5bs1T27WiWPfs6AXPLWDEutQLP
         SJwpsErk307MnFV/g+wN3GtDb4f3G5h/FUHjfj/Wlqx2v9DifPtQGBCbikm7iIJQX1gw
         fxGRuw1sAsPHw6Tqq4OiLETw+ewIj4h76o1dUXpdTVxZnUjBVCdCQN6A5Sx5z7LLnbAD
         d4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733511643; x=1734116443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cynV8pOJrKJvNaQFqaJO/JMUBstzgBuJjjWcaNQed4I=;
        b=boR/TR+Mbg2nSLIWal5ZKFk/dwozZwg5ECJYFfe6/55hPQ7LFc2Rx1dtaqWtNF0aMI
         C/8t3OrY+KAbsJ6zE329pROpd976nUirXS0HZsWsV6qHGMYAastwKVcSUwqO2Cxi+7Pm
         i5jMhxUA7jMGXu237u60QONlU9BwXkWv/q/cT8U2SyoXCZdOE+QEKXATNFEkll/5u8D8
         HpOkXJy1pGrVqshd3SO+cSRlnnRAw6/3TZutINI4aHb1xUACvvTIzC20v1oRaCZjvZ1q
         B/Eqsr9FcyB4vljSUfRJYoVT2mRxZhXm9Wz6JAoFW5GhweODASv8J9v5LILL14IXqP0K
         fVpA==
X-Forwarded-Encrypted: i=1; AJvYcCWPvicM6pdso2QvQfxsd3zEaAmHjXiGjGlfMgzLmxdnVyOliwVCOxepyDYIdaBv0RRGyRR25G8UrmvXjdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPqC+dU5F5cRuOolxP6YqjoFKHImTl6qZ9a+mPfw/AB/XerqLp
	0TS9caprmv4vfiThvXF9/jxOTKORA7LGJlMve8LsiylkqJNSEMVj6Lc8A7R8/yw=
X-Gm-Gg: ASbGnctHyb7KvUP6u6U39M5rTly0mordlGpoAaQgIOPoK6ThNriGpbatFsMz3R9EdLD
	LYU3NAATNDdfcFiTbIFgOcbGL/1p5mmjIPGgy6rZEDeMTbZgnkwxQV9DbWSe0jBk+2ghv2Gs6rb
	7TnbbyVBDsQw1b6+AMTBFzNbrZIUBH7LxJkBOwuCFMF1miPrd3E5f2exMEeS0MVTb3wmgbx2HUV
	/XJHmgL0TPkBEI8qfOcIa3hMCe9wzZZ1HfkHJHn+M/zJKqi6zsDRpfaqlk7Sc2M
X-Google-Smtp-Source: AGHT+IEW2UU+jTNoTOcEYuuCfhMKM2BI21VZcY54iVxmn2QTSlWVK53wH/yWJXy8oWjj5yDpAga4hA==
X-Received: by 2002:a2e:a98e:0:b0:2ff:8f5f:1adf with SMTP id 38308e7fff4ca-3002f795a90mr13121781fa.5.1733511643070;
        Fri, 06 Dec 2024 11:00:43 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30020e58200sm5523201fa.113.2024.12.06.11.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:00:42 -0800 (PST)
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
Subject: [PATCH net v2 1/4] net: renesas: rswitch: fix possible early skb release
Date: Sat,  7 Dec 2024 00:00:12 +0500
Message-Id: <20241206190015.4194153-2-nikita.yoush@cogentembedded.com>
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


