Return-Path: <linux-kernel+bounces-523015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A9AA3D101
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D804A3BEE7C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526B91E766E;
	Thu, 20 Feb 2025 05:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwufkHUN"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DEF1E5705;
	Thu, 20 Feb 2025 05:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740030234; cv=none; b=n22BWfNp2nqJR5mDb7FUG0rb+M2uDrOs//GilAZXsL4hYlFv1tG6MA+hUOaxacE/CWzd6/l0kmQDQ7hm0LSCaMh79n1FjwIE6AJpffV5/6QhxGHA0nX0zBaa6TVRdCukagQbkIHqDW5usK4ORkm+B6CFDXXTVB4I83r2dOUsWHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740030234; c=relaxed/simple;
	bh=EIDVJC2gm10OZ8P0I+SHebr0+b6ferB3eGip91BSF1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mlaUlvHc9NuV9KLjVlLV8fTDtLXyFEF3+MkFse4ORxyUJ/RNESeGTQUXn0roHRuv0I2JdTx6ZCGwurZXtLXk09MxJxXTJpmatcYokYMcfDNtOR5XSXhlgxaD/i+K/p88uNAjmx6gkNLEQiB6XFR9SyMCoy7MxhSx0cY8Eu5VV94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwufkHUN; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-221057b6ac4so8253815ad.2;
        Wed, 19 Feb 2025 21:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740030232; x=1740635032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEAs/2W8i6unwL/IOH0/meAWRqs6OoDg3QxDG87nlzI=;
        b=MwufkHUNGvfC/Hqzw1OgvAOIgMxrQ8fZzRv2fI3L3PkggrOdIThAsrRZFHKM4ygI5+
         Hbe+JM/zMyF7PJ0otXVQsSEU1Doc7fgDMB8UfUQpXRJDwNzATbdrprklfcTIdcNAEIfp
         IPPn0PUVv9N1ZSUjJhNcVTSqUjwq418LfkpfdFumZhdOICmbF7n+KGZNs/hkcYprGyAa
         DeiSdTNTc21Ej7W3OkejMz5Qf1LbN+IrR+fZs5pnJMhOIgxqWU7kVLak8yELNIIElvyK
         J1RBtoTAikRmVpiYeMg3FcGvcZlOa7rKtMqCvpxQBjvvYhnlu+ya7ogZKgYBOAWKiS8t
         ualg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740030232; x=1740635032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEAs/2W8i6unwL/IOH0/meAWRqs6OoDg3QxDG87nlzI=;
        b=wk45+OV+Jf+wxu40hVrPHz6e75b+X9uyfDesBuROCg1f8bP4zj/7G/dCx9maMoQ9eP
         L2b7snXTog5tP58znPokXO+q6ZA+MBk50ARYw+29XjpitgxBUiHmxm26BrpLRPV4Arx7
         nzaVQ7Yup9aBRVEgCMJa9XxMbEKqvB35fLdmN7RXPZgVIn3kjE/D6OE/4m18MeOteTCt
         OO9p+8RdiC2ZY9e1ixv/kczlrUSoNhyUMVdkBIRQPaypMgFmR1zxTyUinrZsqKS9z/Sz
         a31h1d+PZd5vPu8UYNpW59tCSwZdGGSVA9FhuTZxL63+eQSWcjs8xHrA7ux03VMlA4FU
         d3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWF1rQVU9+UfoCEwUFxQnuvuY7RejxgGRByt7PCj/MijK3EHV4Obdh1zvEmJ7/Sl3zvT8ayFmMATg5G@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyrv5GulCXeGyVjAsyTYUqMSOdremuDb2JFw9lx2gthFyWra5g
	FMaukZwdxeRnL1NvpGjW+aszALjVdkiGtVuNoPS1fy8SQt3Ak0n9
X-Gm-Gg: ASbGncvnMkkoeIHSVeBUcTvAZvJHcTQ/BXwXJ6WAsF1PnNfLfLHJaTXjcaSxuTiMPWM
	/mSe5S564fMZaMv8hwTkI74mPAYaOQEkVeyDnj7sPobrCHgthiWJ8g/RwOfCaUMimsPxh23uKuQ
	k94vjAGCsL+He3Afpe4uVYO37p5luxOfGJiHsy/UjhoXhDptLimNJqODSG9uGGbm1XhnZ0dvDh1
	GIBFEB65AYrWLzBz8H6MQTD4y9l4eZbSOjoVENA9CcTpRLvkWTNHZrF0Vavg81R30cobqGcRUKZ
	L3wB/D+6Zzh24u8GYLVtCvuSyA==
X-Google-Smtp-Source: AGHT+IGUkXoXo59VQXM/7j5YyIdcs9w/cg9RxyXROlX7CbTDYkiET2l2tQDyhfUyca1cDQgdkp4yXg==
X-Received: by 2002:a17:902:e887:b0:21f:4c8b:c4de with SMTP id d9443c01a7336-221040bdb96mr284464145ad.42.1740030232395;
        Wed, 19 Feb 2025 21:43:52 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:dc0a:4fe5:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534951fsm114415335ad.25.2025.02.19.21.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 21:43:52 -0800 (PST)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: frank.li@nxp.com,
	miquel.raynal@bootlin.com,
	alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com
Subject: [PATCH v2 4/4] i3c: master: svc: Fix npcm845 invalid slvstart event
Date: Thu, 20 Feb 2025 13:43:30 +0800
Message-Id: <20250220054330.1711979-5-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220054330.1711979-1-yschu@nuvoton.com>
References: <20250220054330.1711979-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I3C HW may generate an invalid SlvStart event when emitting a STOP.
If it is a true SlvStart, the MSTATUS state should be SLVREQ. Check
the MSTATUS state to ignore the false event.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 2140da3f5187..5861358eb9e5 100644
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
@@ -589,6 +590,11 @@ static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
 	/* Clear the interrupt status */
 	writel(SVC_I3C_MINT_SLVSTART, master->regs + SVC_I3C_MSTATUS);
 
+	/* Ignore the false event */
+	if ((master->quirks & SVC_I3C_QUIRK_FALSE_SLVSTART) &&
+	    !SVC_I3C_MSTATUS_STATE_SLVREQ(active))
+		return IRQ_HANDLED;
+
 	svc_i3c_master_disable_interrupts(master);
 
 	/* Handle the interrupt in a non atomic context */
-- 
2.34.1


