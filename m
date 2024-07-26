Return-Path: <linux-kernel+bounces-263701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E9593D973
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7031C23362
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A67014F9ED;
	Fri, 26 Jul 2024 20:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vE8wLO46"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B26F14A08B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722024007; cv=none; b=VYAB/G2Imwo+w0AgLIivggaS3CbgnKvXDFi0XSJT28VPnh9Wt/U3+lsfWJm6602/jFIN9iIuMbDqBPQFTl+ZDDM/6WZR/54NP5x3v5EBjwXrGF7TLjzqPbhbM92brqlZmbjCcSS124qRvXzQuNwDVOa6Hf/Q2anwsPtXP2afbHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722024007; c=relaxed/simple;
	bh=EbgGe2gsLdH2biBweP1nqPyr3Zg50Y1HA4LdIiHtm3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+iM/fcweCgBl8Aaqz6pOo7iK2wI/Bz4eUUxnBVyKiVzLv56NJAjtY4pl4qv1crBJJj4AOiKcnh+rqU20vaJkQ4eNzkU6wO6/pydkTzUQGwL4vjcPfVhiWUcIpfSo9l2l+jnPGMDlzU+doRSTRDMbcdTXI+A+V165/WNizMXOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vE8wLO46; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5afa207b8bfso706827a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722024003; x=1722628803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POgjzXRrZKTYuk9IJwxX6t4KWtvdb6O1DoH7Fypmtpc=;
        b=vE8wLO46tz42t4+EsgXj+WRE4wNMAzeRXioKCIhmj+m/AiV3tN3sLLwv84HFS1+HM/
         kMoguvHy4wsBHXuGaxgFnH9TwN5JzbqUcYcG09nuxFCQHPI0dt1Rr56yCiQZKkIl57Fe
         F38W+bZg2IuT6eXoRhTQkOYCp4QleVN4TpiYzjr5jrLN7WyU1/lv9RRAet9EPo6kb00t
         dpBZWeidfzzi7vGPOGPYkUthyQJlGpar+eJxmjYvnqzEGwdfOM+JDUYwR6XuOrX20Swl
         inSB/U5ESurF9zn6DOG+aHUv7Buwfqjcz1Irta7IOBORcDIN3IIJ6IbzCbbJqdew4kB5
         gRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722024003; x=1722628803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POgjzXRrZKTYuk9IJwxX6t4KWtvdb6O1DoH7Fypmtpc=;
        b=DW3DKIILo0Ev5Vq0uLvbQxM5LC6XSH6EfsnYYO+vgkwn21U0ICprI+G5rcRNamXprC
         d2ciKpRBowyWAnoUoUmyagaVEwmcbG8TGLO3dk3YhEy8Iq1EGfzH3i7GrY4Jz3QBNYDk
         wuIYIrj10VBedWmFcga3BWUOV/XQtpgm0IV5jIJEwfRxiDg40nPH2qdFNV8LYt8Ny79E
         imctL8dExLPU0JF4ZCV1a9exFKsGBSHE1Z5oqR+VeOLP2PgvtidCPpM402yf2UHRr3l3
         pTt8WECm+mTpTf1tLtFR0PbiNSwpZdk1crba2+/uIqYuLpFseOzoSSoI3rSKRYNp9P9F
         oL5g==
X-Forwarded-Encrypted: i=1; AJvYcCUZgYLyTokjiDUZ4MLhtc/hbX5cTx3CZqkyHxrJ40q2P5gOQar9MahOffGtHQXWTbgeO/8eiEv0uG7Ws5gvbu84dBJOk7QYBLSeWIID
X-Gm-Message-State: AOJu0Yzwl4/KpE9eSWFBrxI1lKqBD4e4dk+d35gxYFnb2wuRYaiA2+gS
	Qy67InUkM81vX5Ti/KBmHOTCgS3BLMv1dGeH56zTx98XwUXRsC+fcQMMehwWvuw=
X-Google-Smtp-Source: AGHT+IFTEGZPICz8oxt3K4AgX4DGGbn/vDQD5wGVMFK8bcxJxs67PXzAxqfUJbBP4LD3EEqv+kU6xA==
X-Received: by 2002:a17:907:2da7:b0:a7a:ab1a:2d65 with SMTP id a640c23a62f3a-a7d40160769mr43935566b.67.1722024003367;
        Fri, 26 Jul 2024 13:00:03 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad90e1esm209999166b.151.2024.07.26.13.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:00:02 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Simon Horman <horms@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Judith Mendez <jm@ti.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Linux regression tracking <regressions@leemhuis.info>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] can: m_can: Remove m_can_rx_peripheral indirection
Date: Fri, 26 Jul 2024 21:59:40 +0200
Message-ID: <20240726195944.2414812-4-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240726195944.2414812-1-msp@baylibre.com>
References: <20240726195944.2414812-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

m_can_rx_peripheral() is a wrapper around m_can_rx_handler() that calls
m_can_disable_all_interrupts() on error. The same handling for the same
error path is done in m_can_isr() as well.

So remove m_can_rx_peripheral() and do the call from m_can_isr()
directly.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index fd600ab93218..42ed7f0fea78 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1037,22 +1037,6 @@ static int m_can_rx_handler(struct net_device *dev, int quota, u32 irqstatus)
 	return work_done;
 }
 
-static int m_can_rx_peripheral(struct net_device *dev, u32 irqstatus)
-{
-	struct m_can_classdev *cdev = netdev_priv(dev);
-	int work_done;
-
-	work_done = m_can_rx_handler(dev, NAPI_POLL_WEIGHT, irqstatus);
-
-	/* Don't re-enable interrupts if the driver had a fatal error
-	 * (e.g., FIFO read failure).
-	 */
-	if (work_done < 0)
-		m_can_disable_all_interrupts(cdev);
-
-	return work_done;
-}
-
 static int m_can_poll(struct napi_struct *napi, int quota)
 {
 	struct net_device *dev = napi->dev;
@@ -1250,7 +1234,7 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 		} else {
 			int pkts;
 
-			pkts = m_can_rx_peripheral(dev, ir);
+			pkts = m_can_rx_handler(dev, NAPI_POLL_WEIGHT, ir);
 			if (pkts < 0)
 				goto out_fail;
 		}
-- 
2.45.2


