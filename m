Return-Path: <linux-kernel+bounces-436325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCF89E8473
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 10:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C012328186B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 09:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1811465BD;
	Sun,  8 Dec 2024 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="qJwWDtA8"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C31113A258
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733651415; cv=none; b=g6+0pm+IlzIrcI1Zqz+orRV7TeWPwVgWpYflRYr9UrFufio/VfgsHk7AbRu2K/3sp9lG/wM9HgccDF5+y7qivoa9vYKTzDUQOw5fkcsJ2RVsjGHg7MMErF2UrU8tgfRvs4F47oBFYisTB8181ich9e1FTpWx3nQQLGGnqaTyGw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733651415; c=relaxed/simple;
	bh=SI27lQ6ouPyc6VSvj6mijRBvLjbpSdfHHV2X5cxHAlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MmXVwE2ZEf6NIfcKN3BJ2g+obLp+jzebcKXVT4oSFTrcvJF/Pj0XvJ/q9moCb/nbmH5asdB+13ke0LQqoxJcerd/T/cT0c4P4GSbmSMCnnpg0WP6aCRp3FLHsRJF7BOMqpe1aqTpDmSpVSvKa2DfNG5SfDaFP5jM56A7j86T+UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=qJwWDtA8; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3003c0c43c0so14637491fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 01:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733651412; x=1734256212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cynV8pOJrKJvNaQFqaJO/JMUBstzgBuJjjWcaNQed4I=;
        b=qJwWDtA8HYNQUxBJnk5UQAwTob5KH7pl9B6Ae1iyRzoO/77/FJsXTu9ch/SrstK+wl
         YL1AEeug/zISOaQddiI2/m0qDpX+tiAo7chTJRhzLKKx0LYBIbTIexPJELJ5onZ6aOnk
         GTYW3mu4Dwnz73cDbodVXNHQaQYh5Zvw3gOZCnnsVmqeJw1D5yAj/g2p8sUPcX0C1l8c
         GgW8bQx2xYQqT/6ix2CLR8nAvNYrQw7TvihpnwEkdKRAefcK5Z4ohY5kbgXRSs5Mrs80
         bdN39B/e2cCwhUGOjb1I9w5ZuJVNMsttzqIe7Dh7qJkZDIRWOfLvNvj9gRPwGcmCaJOr
         XiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733651412; x=1734256212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cynV8pOJrKJvNaQFqaJO/JMUBstzgBuJjjWcaNQed4I=;
        b=e3MGKvtY4Jv/iB2FiCJgzae8U+wEszblgyu5NnBVAv/YrDTQvA55em3xP98XN03cl3
         FMLq6jMtHxFokSwoAPTSZE+jY16YNmzunSR8XTmoEhq/rc2I3kDU8JN2Si23FNqSNOJ0
         jC6k20iDNMTyhwguBKFZaAXsQXRXGK1vxnXnaIw7cSk7v4FE8odNNUsdea3HY1sV164d
         0RPiHU48SL9JOgB0aGtHgvmg3PPf8A/n88gjn64CTw3Lnob4TXDmjvZirH596u8/dwsm
         HSEkYPE/L9ZNbfKleB85AXtB5RoiCMvQGJ3Ki4bvBSpWsCgkHWBOUBJLnsOsGZf/0tt6
         14UA==
X-Forwarded-Encrypted: i=1; AJvYcCV+f/XYiCvaF/5wuFppJ3kjPCEx4PkKv/JdT7y2E4/lF5hVnjFWK+E0oZq+0Vouvdw2tCHgJdN9R/8gYQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQXUOhlcn8saKf1iWu0XJvEAXw2qWuH7T+H1+UtMHgd/Fdo6IP
	g5+0hwZUXNThcjtt2K/hJkaES60rw36tan3EWgUZvLInEhFZ7NAO2bA03gezKEDWs9WhMDVtbkl
	pi7s=
X-Gm-Gg: ASbGncvMG9N2DsoJqu0atiFASBs1lkW8LEg48M6e/8rfBuhTFszh5sb3KVQcJcpX2KO
	7BXNdg/y+pPlMDTB8SGa2dtalupPy3uE7YhZak8jWwW7Un72uBZPxuk3E2LdZgRT+dpq3vuo6WR
	fDkrG3is5I8+ZPl2sf2oaNVq1HVdnKj+OEVVoU6SP6kgOoQLSLCjqiSbGz/R/nWh8mJOTEMRszQ
	INB6ZviD2ah6m9wlpWiIK1QcNOdTYlP9mHBNWmfN0ku23wtyEsZrRlSHWctet4z
X-Google-Smtp-Source: AGHT+IGmOlhACGEiwReXdOmA2tPXqwQWewjxb6Ay7meV1g237ucqsf808iRNKjO6hZpq9iuPGcdG5g==
X-Received: by 2002:a05:651c:1586:b0:300:3e66:5881 with SMTP id 38308e7fff4ca-3003e6658cfmr17033281fa.7.1733651411640;
        Sun, 08 Dec 2024 01:50:11 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30031b80e7fsm6645311fa.120.2024.12.08.01.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 01:50:11 -0800 (PST)
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
Subject: [PATCH net v2 resend 1/4] net: renesas: rswitch: fix possible early skb release
Date: Sun,  8 Dec 2024 14:50:01 +0500
Message-Id: <20241208095004.69468-2-nikita.yoush@cogentembedded.com>
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


