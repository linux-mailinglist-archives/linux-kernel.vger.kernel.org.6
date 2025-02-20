Return-Path: <linux-kernel+bounces-523036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FC1A3D132
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B95C1896264
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A241E47D9;
	Thu, 20 Feb 2025 06:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axQ49k7K"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC3B1E5B66;
	Thu, 20 Feb 2025 06:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031881; cv=none; b=Yig+CMkbNmtDQDav5asq52QjW85wkT7VBGawuYDRBaVojWEot69FLYdFLvpzIvgfW43O77zHxMm15NYnNZZ0cGflEUURSV6eVD5m4Qs8wZNNN0KrtSXlebitVilNvUIV3B6pHoONCrv+kGXxdz21qeHpCU6RYBYL2m/QjY72R3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031881; c=relaxed/simple;
	bh=6U5XgCEy+ulJchyfM81frgddEG2ykLPjTr/ADmTTCe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I8UJOWUQzqOoYqGZZJYmtnVItPUZppahV8/519V8DkdffjHjwdZOVaU80fBcCu70XGyR/8GyaJtf6cmuow7pyOFIjx60gqZmOz+W1gJ4a9c/eg/cNQGmlBDnHEQP4MyLwMI+/+GyAH2O+9CywUNrZR8yF228KLl0zFukLJetnXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axQ49k7K; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-220c8f38febso9597185ad.2;
        Wed, 19 Feb 2025 22:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740031878; x=1740636678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+j78yv7W1SEsENaFWTruZEdfPJNI2RZz4FriJMcOius=;
        b=axQ49k7KCsq9rLQZxMzXEeBiVCsgWO9KSHRu6WQHMdbY3SmOA+gS2LGEzddGAUHHpF
         +0+rluF5WD68BYtmmGeM1lv5TTptdkyVYsqJETn9mFeE7quUtFr3Fh8dt+AyD2NWKs/e
         nCMA/biFbPRlLvUaRHan4Mn8qF6bga2FH/+/N7i+n/bDBpuSdmuGxHI2GUKtYvT2wglt
         Q3yk0W/77EVHSf+ogrRwEpEJwKKqFDIJV6jczNFB/s5BVWdve7x5t3kQWmbfoLVX1pmO
         7H67RG3g4oSRS8bZcdry1m8CPDXQsNKcjqiqcAcxNexRguevmQP9VOa0fys+FRPte2QN
         goOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740031878; x=1740636678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+j78yv7W1SEsENaFWTruZEdfPJNI2RZz4FriJMcOius=;
        b=SovKMR4Nms8VODzY3vEsfODsVSBOCFXNgfj4ehjyNzQ7n1FbCzc4XiQ/+yvmjvG2iW
         Fzxeh0m5szdBMY2AScQGYu65rHfVCsHLAUbg/iAzajFZKJllDFrSLFTBLK9tdsAZ9Sua
         0mcVLmg7is9YF9Jx9QhQ1V1a8+/JP5y5qExqadYVi2OxMy+2CluGFJ4XT/WjOaSrJN80
         9ojOs9rkeUYSJd0MzngnNesTTZASbj2rJWLbtIljlK+f5P0QToIA4issJUlX3ch1XU0S
         N5J8Uahr1a7xtGcmR7cf7K6peviSuqq6INz9/l1no+mGiDZZe0oKz6tydd2v4jJ44/z6
         WtEA==
X-Forwarded-Encrypted: i=1; AJvYcCWLpjcT4MubZwrlkZLl5WZhpJR+hnhwE5ttVsjM0nu7KJvU179PdA54dnQfyMzYJmsiB26LJU+zfD3L@vger.kernel.org
X-Gm-Message-State: AOJu0YznZ88FBiqq1Qz+vjNQ4662mgbaaxd8ofJrCplkCuWx5n7IFKkc
	0vWxWRUTdj61T8bADS48p7h+cKHPnIPaZeQG+ExLK71jWiuYmN+a
X-Gm-Gg: ASbGnct1mky0w8yxxzlDwLGzXfyR2EhMP582uBZntJpM1MOGyr7kPThrAxo6Sqz+735
	5vWvd8O2mCgNYMe88i1r0Ey3HSPbpBhKtnz2/xqIOdSZvvfJYbYgjB/i9HrpaIht78bQLJc9pFJ
	hKigNTVPr/Vq2Ex431fYxrFvXKTJPMrM/UoBU4X5L+4S41u8a5ZWkyuITKYgVnjzCEopRYu9XMp
	z/W0Y8l6hGyC7Hu0UZpPY6dVlAnrQfFiHWgvtH+XNCXeBVgcU+FkZmGoWojEIUv7NhhgzNMBzMG
	vqNhxtUCG7hEvxgfKPCQdL88/A==
X-Google-Smtp-Source: AGHT+IFU3vxY9Ip1+CC3bff8XqxgjtFV+EfaOwsPv0Qbpgrftb/RcnRACrHbtb9fAqxl0J/+zKDiqA==
X-Received: by 2002:a05:6a20:9148:b0:1ee:e2ac:5159 with SMTP id adf61e73a8af0-1eee5c95932mr2769361637.19.1740031877986;
        Wed, 19 Feb 2025 22:11:17 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:dc0a:4fe5:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73271a02648sm8226823b3a.107.2025.02.19.22.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 22:11:17 -0800 (PST)
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
Subject: [PATCH RESEND v2 2/4] i3c: master: svc: Add support for Nuvoton npcm845 i3c
Date: Thu, 20 Feb 2025 14:11:05 +0800
Message-Id: <20250220061107.1718239-3-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220061107.1718239-1-yschu@nuvoton.com>
References: <20250220061107.1718239-1-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stanley Chu <yschu@nuvoton.com>

Nuvoton npcm845 SoC uses the same Silvico IP but an older version.
Add npcm845 specific quirks.

Signed-off-by: Stanley Chu <yschu@nuvoton.com>
---
 drivers/i3c/master/svc-i3c-master.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index d6057d8c7dec..c58440061d5a 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -133,6 +133,22 @@
 #define SVC_I3C_EVENT_IBI	GENMASK(7, 0)
 #define SVC_I3C_EVENT_HOTJOIN	BIT(31)
 
+/*
+ * SVC_I3C_QUIRK_FIFO_EMPTY:
+ * I3C HW stalls the write transfer if the transmit FIFO becomes empty,
+ * when new data is written to FIFO, I3C HW resumes the transfer but
+ * the first transmitted data bit may have the wrong value.
+ * Workaround:
+ * Fill the FIFO in advance to prevent FIFO from becoming empty.
+ */
+#define SVC_I3C_QUIRK_FIFO_EMPTY	BIT(0)
+/*
+ * SVC_I3C_QUIRK_FLASE_SLVSTART:
+ * I3C HW may generate an invalid SlvStart event when emitting a STOP.
+ * If it is a true SlvStart, the MSTATUS state should be SLVREQ.
+ */
+#define SVC_I3C_QUIRK_FALSE_SLVSTART	BIT(1)
+
 struct svc_i3c_cmd {
 	u8 addr;
 	bool rnw;
@@ -216,6 +232,7 @@ struct svc_i3c_master {
 	struct mutex lock;
 	u32 enabled_events;
 	u32 mctrl_config;
+	u32 quirks;
 };
 
 /**
@@ -230,6 +247,14 @@ struct svc_i3c_i2c_dev_data {
 	struct i3c_generic_ibi_pool *ibi_pool;
 };
 
+struct svc_i3c_drvdata {
+	u32 quirks;
+};
+
+const struct svc_i3c_drvdata npcm845_drvdata = {
+	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY | SVC_I3C_QUIRK_FALSE_SLVSTART,
+};
+
 static inline bool is_events_enabled(struct svc_i3c_master *master, u32 mask)
 {
 	return !!(master->enabled_events & mask);
@@ -1811,6 +1836,7 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct svc_i3c_master *master;
+	const struct svc_i3c_drvdata *data = of_device_get_match_data(dev);
 	int ret;
 
 	master = devm_kzalloc(dev, sizeof(*master), GFP_KERNEL);
@@ -1868,6 +1894,8 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, master);
+	if (data)
+		master->quirks = data->quirks;
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SVC_I3C_PM_TIMEOUT_MS);
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -1960,6 +1988,7 @@ static const struct dev_pm_ops svc_i3c_pm_ops = {
 
 static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
 	{ .compatible = "silvaco,i3c-master-v1"},
+	{ .compatible = "nuvoton,npcm845-i3c", .data = &npcm845_drvdata },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
-- 
2.34.1


