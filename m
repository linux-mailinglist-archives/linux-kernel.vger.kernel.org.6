Return-Path: <linux-kernel+bounces-548378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB688A5440B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678701887F62
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637DB1F8BC6;
	Thu,  6 Mar 2025 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVNv+YRh"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F12F1F8736;
	Thu,  6 Mar 2025 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247684; cv=none; b=YtIynk0Eu0vnr6ceV42cMY3AT4sprRSMxAkPOfay5cSGWIuWGlDZHdmQq1XxDilbqDBJ5E7I8b4rU79QD0CRcHkmxeR0lnsxoWIyx1IZNUZn0I9wbxRW4shVCH8eDO0G4zDYPEquyy6Ok9e6v5Ql3vaLVjVzOkXcX1gwMm9zE48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247684; c=relaxed/simple;
	bh=o2lq1LUKE9RuAg/hZz1ZlOwXz2aoqXlZrwNR0bKCDAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fUd+TWV15KeKzbPy3ISk6ITQxetwrIAZjdRcsVEFLRu75RTV/O1aK4UjqSBq1ODLhNNZVKO+8l7fOuf6g+xxTAPLwjZ6E/MPeSiCEM3wBREtdEOeMVENj0Jz96Yus77Fpr8k76fBrzqcFCD9mn7thz2U013DDzJwBX8+RQ2ACcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVNv+YRh; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22337bc9ac3so5811075ad.1;
        Wed, 05 Mar 2025 23:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741247682; x=1741852482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z+sL0RW4cJTOyML1J6fde/KORBWPqtZnRc7ageiDm8=;
        b=YVNv+YRhA2yX8kD+dMKwQoVdaqzymCCZTZ4WOmF/IBNuxNhtFNIHIGCbUBKCZRAOku
         ZeTSOItG7tejyJ6Zj5DSBfKlRBAteEO6h6eDKdBecriz2dZPtHfQug9+CBLpl8rGflQv
         boTLax/NUQa00qcsw3PoWprujNDyOlPOQlGlitZXprI3838MlqllDEEQnVt6szAMvItR
         Ww7ZBRSGyScrZKasS2RdbEyZBXKWd0/Tcmf+0HikeJaJGaE8gvjo1cK+l1YidloFZxK+
         wzK+QiXuPs1rfoZE32fFJpLAcDe3epqK08lDNIuIyRl3nzJW2rDvSeuXk35yPDDMWS3A
         us9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741247682; x=1741852482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8z+sL0RW4cJTOyML1J6fde/KORBWPqtZnRc7ageiDm8=;
        b=ayZG5MmtRH6EGpB3mxYoHwhE5oa8iMtZULRFX89K5QoGyGt/9qA33c8jsTKKVBd3Mo
         rkF3BaJz48i5FrpUL+QAbNqrG01ZXDAk3k5wu3I8LDYSqEkNWuc2ANeAyKpqfG9DJo/B
         0fwdRONCajmsX7XMrUmIiR1uBolCOlsy0ej3uOyhPgDJtG2ORWjVRNedlgQSP1sRPUgk
         OqVMvSdz+ipetSNtb1s6YC4T/mONLvNVfaF8ZuqpAd/2vFcHMG9Nxx5P/dWTGGyDVGLI
         dpUtWtH4jG0UhSvdOvcKDY73WZmZ1xcv2KFMsp3AxiLWiTPpyM+zPFQk+icxQAC+F8i9
         o1nA==
X-Forwarded-Encrypted: i=1; AJvYcCU5K1JaTZ4H9N9CT9Sg+k4i5pkAQBVEqrhhzsLC8+n8JVgvyjMqisjMfMBk3oQgdcYRQbW1FYz2q9dM@vger.kernel.org
X-Gm-Message-State: AOJu0YwaYZ0eBw7tnVZeK9+mS1Tnq+iod9743pEahpU41EC26fVV9X+3
	DWZbektoOFLwTkd8TR3rqGnVRqSbm0Uo8ZE+aa4Ppaydi+Ahy4As
X-Gm-Gg: ASbGncv/4au3pE/5E/QGvX7ljG+31mJznOp3XGwfJSJAfemSPTxuRpD1pzI06/grK6v
	sjOOjvNxk7dZrpIEg3oh6+V2cC7waD5ZDVqQmtZzc3Wqig2Ao+vFC1iFik/rYl3APjlWFDn/6f2
	azzlYUf/stRScl+3pv+qZ4nsmzqmYh0Gjla/vZ9V3v6isNJunoGWeVTqjjJaeTcQAYHVcyWWkaZ
	TctaI3xre1pfCakoqQw0WAyF0lvlLij71WzCz74Ce1MyNp+97Bm3QglGX20YyTd1JKluDXr16iK
	uRDjNU2ui5DygeFp6KS7oYMY08t7p3yHx+THFDTC4zl3KlHN0JKjarI=
X-Google-Smtp-Source: AGHT+IGXAIOce42vV0eof1Rl6r+EywEWrktnOVXaG5lMZQPu7G/rBfveA9yLXalq4mL2qutxXfLdqg==
X-Received: by 2002:a17:903:230e:b0:223:3396:15e8 with SMTP id d9443c01a7336-223f1c81638mr107329295ad.22.1741247682439;
        Wed, 05 Mar 2025 23:54:42 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:d305:9d26:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa448dsm6085485ad.210.2025.03.05.23.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 23:54:42 -0800 (PST)
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
Subject: [PATCH v7 2/5] i3c: master: svc: Add support for Nuvoton npcm845 i3c
Date: Thu,  6 Mar 2025 15:54:26 +0800
Message-Id: <20250306075429.2265183-3-yschu@nuvoton.com>
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

Nuvoton npcm845 SoC uses an older IP version, which has specific
hardware issues that need to be addressed with a different compatible
string.

Add driver data for different compatible strings to define platform
specific quirks.
Add compatible string for npcm845 to define its own driver data.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503061400.GGr64rkR-lkp@intel.com/
Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index d6057d8c7dec..40269b692aa8 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -158,6 +158,10 @@ struct svc_i3c_regs_save {
 	u32 mdynaddr;
 };
 
+struct svc_i3c_drvdata {
+	u32 quirks;
+};
+
 /**
  * struct svc_i3c_master - Silvaco I3C Master structure
  * @base: I3C master controller
@@ -183,6 +187,7 @@ struct svc_i3c_regs_save {
  * @ibi.tbq_slot: To be queued IBI slot
  * @ibi.lock: IBI lock
  * @lock: Transfer lock, protect between IBI work thread and callbacks from master
+ * @drvdata: Driver data
  * @enabled_events: Bit masks for enable events (IBI, HotJoin).
  * @mctrl_config: Configuration value in SVC_I3C_MCTRL for setting speed back.
  */
@@ -214,6 +219,7 @@ struct svc_i3c_master {
 		spinlock_t lock;
 	} ibi;
 	struct mutex lock;
+	const struct svc_i3c_drvdata *drvdata;
 	u32 enabled_events;
 	u32 mctrl_config;
 };
@@ -1817,6 +1823,10 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 	if (!master)
 		return -ENOMEM;
 
+	master->drvdata = of_device_get_match_data(dev);
+	if (!master->drvdata)
+		return -EINVAL;
+
 	master->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(master->regs))
 		return PTR_ERR(master->regs);
@@ -1958,8 +1968,13 @@ static const struct dev_pm_ops svc_i3c_pm_ops = {
 			   svc_i3c_runtime_resume, NULL)
 };
 
+static const struct svc_i3c_drvdata npcm845_drvdata = {};
+
+static const struct svc_i3c_drvdata svc_default_drvdata = {};
+
 static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
-	{ .compatible = "silvaco,i3c-master-v1"},
+	{ .compatible = "nuvoton,npcm845-i3c", .data = &npcm845_drvdata },
+	{ .compatible = "silvaco,i3c-master-v1", .data = &svc_default_drvdata },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
-- 
2.34.1


