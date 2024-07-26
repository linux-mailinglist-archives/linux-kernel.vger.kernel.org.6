Return-Path: <linux-kernel+bounces-263699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7ED93D96F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 486B1B23190
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A1C14A08D;
	Fri, 26 Jul 2024 20:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UnJcUbJr"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9760C13FD66
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722024004; cv=none; b=Uy9BfEmy1wKiUxpY73RxxxzL9TjeHgPNGyJdrMiWq18RrpTMRx4x57mtXb/1+tGcOO1zv9Yw6jYGavBHGGzrRv4dx7husSk0Dq58RcexUl1RmsQKxV66xExKnlTbJT/9JQEJONdu00jKNnz4KMmnGeP6FgB9yqH5awBs08EM2eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722024004; c=relaxed/simple;
	bh=X0Lb8mIRnjkJhheZaa1C9/ChMOXWk5LNcIzDjYItBcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p73zmL4OyMNMnFfZtPSMFyNzVu10tKDjoAzfoSHONqLUpGmDqf53pr9oU+kr806IE3aLyNNEiQ2HEBk0Nj8N7+TiyP4x3iz+icjze8xyQ9sjks31njbSl9QGT8cG6lYFjbbOnDvKUcDs3185DX5YQ+RADsCf4UTrgXmIhnNBMW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UnJcUbJr; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5af326eddb2so1601979a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722024001; x=1722628801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RujnloDbg8cFq7uk55+LRxz/Crsv4ySF/ZqdPlHzEpI=;
        b=UnJcUbJrDG9Cq804yVbehwjGAd++KrMBOQzz716Pwcnv2sym3XrA7RBcmayl3k23cg
         vMQhICD4s+3vEUxb9aUAyDpJrAkQVB8rdJgqUGaYZmVyjxg6W74kTpM8c/ysgNJmK2bW
         95aGCuNTw6nVqAFvvfRHF44wWPcd/ejbxP0XEDWNzYS3HrLt0s3YjajH3NPktFKkGINP
         xejpMzWqF+zG/Wdz3P8g6AoXkGdbWurp+mRQM2tRWa8Po1K3/fER+akwyvplj1C6K1qg
         5kD14gKfLDLB1JKgcfk5+CtiYDCj/++PoUAHuI7r4Dh+9hTGnwfyESrVP3WezvKWGqoI
         fgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722024001; x=1722628801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RujnloDbg8cFq7uk55+LRxz/Crsv4ySF/ZqdPlHzEpI=;
        b=HqJE/BamBVmX3lu2G7VpNB55glzINsrvY7zGzXiGNo39V3AIO5KSyVEMdcmDx1m+kG
         itlMoO3Un8BfesQDaATHsi418mFYqS1+71y30d6qkC43tQUdIv23QJxdGJWI1U0MeLkb
         r0RxOH4PYKVgKOrjH7NAWfrWeg8FhQIN97KDu4eW7cEVMe3abuPySLOy/h/fJGybkcGa
         bbQUAwAUJ/OW5fv8iR2ADyg6hfrl/PvwWPUNhL9UzuOm4uTJw/qqZGMfm5+reXc3D3Ky
         L/FLQcDpssZr7MEmrzpRYMKY7JgNvb4MNYNmLcWUfcFdvhEVL/XEj1WrgJl8j2vcsbrX
         cymw==
X-Forwarded-Encrypted: i=1; AJvYcCW+sH22fL+KoZ9eJ2+hjjTINS5ax7fUDqPNa+Of6MOLWHP5F3+HBuHEitKWOg3FrH/4vYnr0t9d4i6/U1RzgVDak5z0oFa5TtjBYS/n
X-Gm-Message-State: AOJu0Yw2M5MIgU7yYkRyE5t3MCFkBBFBSCICkCGCD47AXF78I0emHEbB
	NeMqh4NBCiXYBut8pXG/RqVQamEFmdj5jzDqb8fcBk/cQDKR3/j/C/iPbcv8yGI=
X-Google-Smtp-Source: AGHT+IGLTeby7IgSps+WCZxoecp8rEY41Qs9z/KH8R39SBVZDRYsG+VUFkY5AJGG2wUOq14cKvVarA==
X-Received: by 2002:a17:907:7f88:b0:a7d:2772:6d5f with SMTP id a640c23a62f3a-a7d3fa3f8bemr56915366b.23.1722024000997;
        Fri, 26 Jul 2024 13:00:00 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad90e1esm209999166b.151.2024.07.26.13.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:00:00 -0700 (PDT)
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
Subject: [PATCH 2/7] can: m_can: Remove coalesing disable in isr during suspend
Date: Fri, 26 Jul 2024 21:59:39 +0200
Message-ID: <20240726195944.2414812-3-msp@baylibre.com>
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

We don't need to disable coalescing when the interrupt handler executes
while the chip is suspended. The coalescing is already reset during
suspend.

Fixes: 07f25091ca02 ("can: m_can: Implement receive coalescing")
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/net/can/m_can/m_can.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 9d7d551e3534..fd600ab93218 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1223,10 +1223,8 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	u32 ir;
 
-	if (pm_runtime_suspended(cdev->dev)) {
-		m_can_coalescing_disable(cdev);
+	if (pm_runtime_suspended(cdev->dev))
 		return IRQ_NONE;
-	}
 
 	ir = m_can_read(cdev, M_CAN_IR);
 	m_can_coalescing_update(cdev, ir);
-- 
2.45.2


