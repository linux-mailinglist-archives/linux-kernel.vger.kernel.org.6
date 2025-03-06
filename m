Return-Path: <linux-kernel+bounces-548380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74412A54409
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1F0171489
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973121FF7BF;
	Thu,  6 Mar 2025 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWif9Adb"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AC71FDA65;
	Thu,  6 Mar 2025 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247690; cv=none; b=Hwo7RCqI6kbdTA+0Q97oFfjb9fn/VwnkAmLjWvLaGDIDM2OLNSTs0z3CquZ/beupwqHzAJBe1gryHDK4y11NT/0VZEAQkGBkcl7DQ9BqXiBIm/IDPAa2kfgGlsGMpPn+4cKPeKMLmCTSAzEHQUzNOPtYAkwZOUKzsIHZggEmc8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247690; c=relaxed/simple;
	bh=a1jTTNqDWm6Rt73APC9vmSVtKjdWQslgAYtvB0Wstws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u7hi45Xq76+ghqBzWmN4eB3oU/j6wNrNJeQvjGcbmEKdttIeJkQL+JkL7KShrnt6XnbPJhl7DHa6Zna2tP3EttHIT8AHPMGU7bPGc0BftlTEz8b7tmGEzOHnEdYOybjPvo6c/iYAnwwj3uaHSu6sgac9D5zPYCuvWf+IO6bRPDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWif9Adb; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22401f4d35aso5050055ad.2;
        Wed, 05 Mar 2025 23:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741247689; x=1741852489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2+tfajWqV/BpF+HlwJ7tnoTx43eUOwV3JjZ5iyWcbQ=;
        b=WWif9AdbMUiFRt7hYlsQiakjdhkdE43aEtI3Mlt9OxhFibNypbIlP2ymHclAXdxe6H
         RgPA2knT2RccRDerbhEi8CdjQdIt5HIEfg3HhbYq0KDyN+nBx3J3x4Tkq1+rO9vBh3G6
         X7TnDmcfwTKqfG+aHS35bOFvwVah2MJULlNRgTxmIy79zzR6GzxIovWH0+nCWn1gXhIX
         axFw6K0gbiAS8Tp6rr7UloHS93mCyzjhwq5D1s2ZgTk++95vvniCH98jfwO6SVPc4NCF
         He6i+Wh3KRhVYcSxSa/y+OEKVaPU4SnvLKigySjM164PEnjt2wt4PanNGaPVxn2bf4mI
         EPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741247689; x=1741852489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2+tfajWqV/BpF+HlwJ7tnoTx43eUOwV3JjZ5iyWcbQ=;
        b=ANatyzMIR4D5PA6No3pgBhb8F1cMxp7Bxm0JlN/BG1uOf1RLake35x/c2qzo70zRx5
         yNB5rQ38xL6x8UOOcnrWN05ytHdlfgyySwADfdp/zXwycgKn/KIjchTtsdWhc41UJjAP
         cubeEVDxTHOJvWe14mCX24hjoYp1ZEbo0s5TETavO/2EedutT18hgdHqr2qxB2ZvNq//
         PNsi98ahpWWtyGOPSWFiwPS79fvcaRhHunhiJdf9sGbPqQB0NXLY6oKBGhPNzYXtgif1
         bqdEcFZcld+ak9FFU3lhw5j2QCuQ97PlEq7gbW8+MHm76Vazy8BUYCH2K2uEzgmojpA3
         qqyw==
X-Forwarded-Encrypted: i=1; AJvYcCVTL6HwDEm/BtFCWzjjkv9iUzf7lk656J0i+TxpXgbCoyB+90jjdZkkLboaAMxIUEiRGAl7fIlnMcvt@vger.kernel.org
X-Gm-Message-State: AOJu0Yznkyn3fXXcvg0tNFck1ASLYTCFK3R+QcJMwcE2pnQxZwZHDq1U
	L4XTfrappyB33R03LTbqX1e1tZQCHf+IuRkiJ8P92YQ7yHbber2FtWLWoA==
X-Gm-Gg: ASbGncsdrDQlyNnZpbhHkSEZLYGcjCX8dnYVoLksu1536KeNahUWgouJugvEZhnCBJ1
	OaGDVzKGybtf8SfjIIoTQBrQ6j6/kZEVNjcX4rYfnEbMA9seucYrBQY9pjYWw9Wh1Xh7SjjjMtl
	UP5CF1kh5vtZhKUcra/hpRivRjAH11OZwlnesg4EjC6M7mSoiYp1/prQKEgeFZ4oIaAf9MC7L6g
	/RoHj+AhrimWBc+poarLrg8SsAbjiALeIOsa3j1wTDuWQOqikNW/6+Yl9zWMLl9kXCtD7DIkjis
	/MZV7+w7pEXzhhJy2FyTErQNXAiDfqIhtAZjcZLE3d7M+UpLpxo4SD0=
X-Google-Smtp-Source: AGHT+IF5txJTRwnyckdazVXegR2kdBARmrqG1Lso7rQth72ORrfeInWjkigbGtMEweDgwRomphqtbQ==
X-Received: by 2002:a17:903:8cb:b0:220:d7f9:9ea8 with SMTP id d9443c01a7336-223f1c979bamr117875855ad.26.1741247688596;
        Wed, 05 Mar 2025 23:54:48 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:d305:9d26:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa448dsm6085485ad.210.2025.03.05.23.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 23:54:48 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v7 4/5] i3c: master: svc: Fix npcm845 invalid slvstart event
Date: Thu,  6 Mar 2025 15:54:28 +0800
Message-Id: <20250306075429.2265183-5-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306075429.2265183-1-yschu@nuvoton.com>
References: <20250306075429.2265183-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

I3C HW may generate an invalid SlvStart event when emitting a STOP.
If it is a true SlvStart, the MSTATUS state is SLVREQ. Check the
MSTATUS state to ignore the false event.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index cba89a685e13..1cab5b8594de 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -58,6 +58,7 @@
 #define SVC_I3C_MSTATUS      0x088
 #define   SVC_I3C_MSTATUS_STATE(x) FIELD_GET(GENMASK(2, 0), (x))
 #define   SVC_I3C_MSTATUS_STATE_DAA(x) (SVC_I3C_MSTATUS_STATE(x) == 5)
+#define   SVC_I3C_MSTATUS_STATE_SLVREQ(x) (SVC_I3C_MSTATUS_STATE(x) == 1)
 #define   SVC_I3C_MSTATUS_STATE_IDLE(x) (SVC_I3C_MSTATUS_STATE(x) == 0)
 #define   SVC_I3C_MSTATUS_BETWEEN(x) FIELD_GET(BIT(4), (x))
 #define   SVC_I3C_MSTATUS_NACKED(x) FIELD_GET(BIT(5), (x))
@@ -143,6 +144,12 @@
  * Fill the FIFO in advance to prevent FIFO from becoming empty.
  */
 #define SVC_I3C_QUIRK_FIFO_EMPTY	BIT(0)
+/*
+ * SVC_I3C_QUIRK_FLASE_SLVSTART:
+ * I3C HW may generate an invalid SlvStart event when emitting a STOP.
+ * If it is a true SlvStart, the MSTATUS state is SLVREQ.
+ */
+#define SVC_I3C_QUIRK_FALSE_SLVSTART	BIT(1)
 
 struct svc_i3c_cmd {
 	u8 addr;
@@ -586,6 +593,11 @@ static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
 	/* Clear the interrupt status */
 	writel(SVC_I3C_MINT_SLVSTART, master->regs + SVC_I3C_MSTATUS);
 
+	/* Ignore the false event */
+	if (svc_has_quirk(master, SVC_I3C_QUIRK_FALSE_SLVSTART) &&
+	    !SVC_I3C_MSTATUS_STATE_SLVREQ(active))
+		return IRQ_HANDLED;
+
 	svc_i3c_master_disable_interrupts(master);
 
 	/* Handle the interrupt in a non atomic context */
@@ -2018,7 +2030,8 @@ static const struct dev_pm_ops svc_i3c_pm_ops = {
 };
 
 static const struct svc_i3c_drvdata npcm845_drvdata = {
-	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY,
+	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY |
+		SVC_I3C_QUIRK_FALSE_SLVSTART,
 };
 
 static const struct svc_i3c_drvdata svc_default_drvdata = {};
-- 
2.34.1


