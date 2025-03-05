Return-Path: <linux-kernel+bounces-546045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 878D5A4F584
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 846B716F483
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD06919066D;
	Wed,  5 Mar 2025 03:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7gF/zpK"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CCD18DF8D;
	Wed,  5 Mar 2025 03:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741146285; cv=none; b=hNTvTtSs+88XhyO5QPEE534Lpb34HvPg5E8wKkp4wAUUiKvMm5GOPX/dkgCueaApWPNituONzGvE3FYrsp+JSTVrm6sMDAiBmiQM9TsgwDyDu3HB7IO72OEdp/I697Rof97AB31o5c477LrQZSX0Row6VkB//MY7vIoIHOr7xP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741146285; c=relaxed/simple;
	bh=FwM1Ixf0fNp1sGAgh6/aGjBRduhxfLm9u0al2RJZu2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kw1FibGFVENvN8eDw1A1RdLs55lrMTdmATLBM3GVmsMz9ZYDfOhJxpwnRVkkmjz4wkBAN1e4eimn0qJlUacEfiaQrhPncAjK6Z45SFxRO/yLJmcu9mpoXn3WnwyzJwATfL70zoG5nwqG1qax9nchA/hp3OXW7K4R8GZpxecjaS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7gF/zpK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2238d965199so62610605ad.2;
        Tue, 04 Mar 2025 19:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741146283; x=1741751083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxSorQjSMBJHTcXavhQOvOimi4+hQN1XV3dQDpeZRl4=;
        b=L7gF/zpKFpBWbWIK1Nda4TP3esmfJncSxJZS8YG8aSUPG4p6JKU90JGjNyac+qlRqg
         5JUA1s31eAhnFeFhyxKrz1TH8vp4rW1lccVKGFXT3G3W4Mhksc7HD5BW0ujv21W8ucEy
         d1V2QVgpEs6c3K8/uK2+b1Cay32Jy6fVlvhvOHN0zy7scLOqjJjg5ZDEEKrcrePaPBl9
         5GF7b0t8oCcqyQ7Ga3+ZPHBN5YfzaMzKnSWGoQAxc3wRNyjtU3kmsPE/G3byKjJhnXOV
         r470mhdhvs4KJKsW+KFD3o95MgDuwT0+O4un4WeS5GJCBV5L7x7k2OH1bb9KHhPR3GC3
         gttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741146283; x=1741751083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxSorQjSMBJHTcXavhQOvOimi4+hQN1XV3dQDpeZRl4=;
        b=Q/9WDLKWabD7hVAhlz+RhN9iKH0REenvcsbNLIbY7AWJqzQGpO8EfgbaemOdiviiw2
         4G7LIocmjKd1JtPR2uVZ6til8jTLgFF9SGLPWb0Gp+zQ7+XFMbWhLpzZug4fljlzofxt
         Os5IdKoSefAAxi4/F8XTm4Rvtffp1X7NHzE4bluPBXBBWWXGs9W8CZ/w1BfwAt/9zfKY
         SEbEHGP5uduVG0rjx9O31pSYhvvZJTYWs6xx2hXTaKLOSJ29Xw/nPtvDHtd9TyoR2Bki
         gSGbQHmnfjj8Nt0q+/w8vzf9EIKvJTQbhntaJkuef83toe9DMyvkM0dYvpbj6whHdyVj
         ovhw==
X-Forwarded-Encrypted: i=1; AJvYcCVHr7N7IEWHwUlL595NBPOe+LKabrVwBacGf6Xt7raV0D1pMgNWyR5kue6il3Nu1vWJDawOsPr9DzlS@vger.kernel.org
X-Gm-Message-State: AOJu0YxkLuFC8dJ8zqsWkvw7SiHc7YxWiGoyrv2dYmqn58Mi2eEPb5jC
	VgtJSEamwptphb1HmseOImfkGVHfyPJgLnHs4LCN+uaCpmf/FYIs
X-Gm-Gg: ASbGnctB0o1G3o51BAtdXExTNczR9Gw8q21lVuRU0VL1/nxImfTYH7iMLS639+mWXhr
	I/RWiWGlkGXpFQOABqnMDgrkNfyqzu8SzSKT69rZlTW5s8U7uEJA71CWVrh9nPDgHjvQPIDPZju
	TMMucX7hep2MHTNsaotfpHr55WnjUcYpK0BEJhSy+tu52FK+FFSNWRU98ovEx8q2R+dXpXgxLS+
	DpkMq+FPaa9afkdsxt1H4EQoNx7oRucS3iB46WNn054nwfaIFNl7UiHz+LG7hi6YeZE+C6r0b4E
	ZDPkZap90DkncpkxWNI4ee2bY899OWUg/frM/sQ65UC5gGtmoQR9P9E=
X-Google-Smtp-Source: AGHT+IEN4FhUYURRgYRRhgTu3XPVnsiW8vehuNjd+QA5rMsT8ISHbmnMzH5qpu1A6/3fHjlDi0Nr1w==
X-Received: by 2002:a17:902:ec90:b0:21f:4c65:6290 with SMTP id d9443c01a7336-223f1c7d39emr24886825ad.1.1741146282851;
        Tue, 04 Mar 2025 19:44:42 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:d305:9d26:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5c37sm102734335ad.133.2025.03.04.19.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:44:42 -0800 (PST)
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
Subject: [PATCH v6 2/5] i3c: master: svc: Add support for Nuvoton npcm845 i3c
Date: Wed,  5 Mar 2025 11:44:11 +0800
Message-Id: <20250305034414.2246870-3-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250305034414.2246870-1-yschu@nuvoton.com>
References: <20250305034414.2246870-1-yschu@nuvoton.com>
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

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index d6057d8c7dec..7cafdc8fd1ad 100644
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
 
+const struct svc_i3c_drvdata npcm845_drvdata = {};
+
+const struct svc_i3c_drvdata svc_default_drvdata = {};
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


