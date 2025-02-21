Return-Path: <linux-kernel+bounces-525243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEFAA3ECEF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459544219FB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927A11FF1C5;
	Fri, 21 Feb 2025 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laXPO21f"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1AB1FECDF;
	Fri, 21 Feb 2025 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740119743; cv=none; b=s/GpAD1IKpedE9MMjEb7aQhT6K0vbZP7StbYKgPiSs4N2dKdf1+0f4gMAe/ZY5ooiuCRPYL0H4j0Z8/OabKpfmp8mxxEwC+cT2CvfyplIEF8Zbu/fnpGwSTEjZ4DpwT7qKjN5QnZrKUod2H97Cm4R2GL5hGucxZVGeP/BjuqrBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740119743; c=relaxed/simple;
	bh=kW18YEUKCbD8b382clFr4aV99j9PvmbD6WrEXApyOew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GNuS1kCM1yS7lX1YdIRI0kTSZf1TzB1tOsOsBc/zjS96EJDtEgd2/2tYiMyUb7crXfhMdZXLSX6QNiNLWHpXKpCIeTQ4jbpZKmKBteCWqSjYHwsYnu3Hm4oMeidDEs8o8f3wBcHQWJOquqY+sSXOZZqx3fdrtfQYHK5alsedK2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laXPO21f; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220f4dd756eso34722765ad.3;
        Thu, 20 Feb 2025 22:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740119741; x=1740724541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0UmhVr497ovNg9ejUAc8bbMw7RbeVAmmP57+q0HxTw=;
        b=laXPO21fkzfzredmElU2X6+twj6B2iGSc/9e6HXhFwrI+iICg4IY/nQiOAtXu8IoHn
         A42WO1VQzJtwuuOwUTOkDs5NFoShGbtPMDeoJBXXuda12WXn7JnuyiBTVldr6OVHo921
         pZ3RgfMdql2i9/Wrv5f6FfU0+tEF6hPBXwlTrz4PaTOZhQTIctS90bo/+CA/nWG1grDy
         nw8Y/uWnevnZGGZwziaRqwLPQzg5FFIj+RUaePOIgL4lsTgOOsfQnxHTKwSACUCRd/Eu
         3a0S1QAw8TnunLgXkQUVY4AHpKLVDVvk2gfw0XybauKjW9m3/9/D7A0wr1ADmKke+OL5
         DCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740119741; x=1740724541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0UmhVr497ovNg9ejUAc8bbMw7RbeVAmmP57+q0HxTw=;
        b=BV1rZoKVanGfUarkpbcHvgDViGrHY95TmtvgP/WoWcfNU7+ChuT4S6C3T4/8fP7gqW
         7+tQmGuI90LAEtil81nJxlMZEFajpDh5E0NPQRQg0IhuwZyfzdGD7AGUA06Leqr+sCw4
         EjmAsdLbiHlMLNUekKZbND6+VsyCO09JNs0fhAs5aH/Blb40QUfo51a/8UENxXKsINt1
         C28Sf6eTbZaz1+P6d6hUam2K9wpo9QQ27nXd2AwhQe9oOJQwDbLhQyHEsAduNidf8MtP
         gzoNN4HHDnvf8Ztgd+8nwzDUqRSquEqf5gl9OXfTqeCW2T0VY30cyRiRKaN6dPRCUd4Q
         5uPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/qOkxCB4eZlGVjBCFIztYP/RGHi6QECatBPGTHH2kVjXYFw8vsX56EqNU7yPq5zA2uJdafydEpGra@vger.kernel.org
X-Gm-Message-State: AOJu0YyrXYQcPN7TCLBiFXVWslOcrILyS4PrZBTKIhy9fF8VQI6Q+aYl
	1e6lA39rDmTuw5+nUftDa8nhG/yMB3eFzr7kcmp8bDmjj8/e8qxN
X-Gm-Gg: ASbGncswQuAWYwjdBFsAaV4Q7d4GKsuHoqeGMpJQiULz+QK5YvJJmW8sm1MFXrqqUXt
	ocsA2RPU8lho6NInooAu4qQM1p4gb04gsGtl+PRszzFR/eumaWe4EF5d3fefqcX4tDjBhdnREI9
	aiFYOpgmIoGWjTagPbYILACmpak+bDlfV+wF+YXhB0XrfpzjY2ew3KS3pjaIkfTyp0drOiZlBze
	1bvXussyzjATCU4BDVVkW4esXKmNxITtgxEUnclhzHRlEeXXyqGOkRVjW3v9LRX9LMlelpb/JIh
	MnT4AGWVFzK7XjXnoHlBsNbXIulbEgsgFpqz
X-Google-Smtp-Source: AGHT+IExk4fm0MpazRHrquV5b4b+qLPghd14iv0oO0qS+yk53d9y18NJGOOCf2qnXgXgyqH2xQdxBg==
X-Received: by 2002:a05:6a21:6b0f:b0:1ee:c093:e23c with SMTP id adf61e73a8af0-1eef3db70e6mr4214308637.41.1740119740736;
        Thu, 20 Feb 2025 22:35:40 -0800 (PST)
Received: from cs20-buildserver.lan ([2403:c300:dc0a:4fe5:2e0:4cff:fe68:863])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adb57c5dc68sm13777275a12.9.2025.02.20.22.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 22:35:40 -0800 (PST)
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
Subject: [PATCH v3 2/4] i3c: master: svc: Add support for Nuvoton npcm845 i3c
Date: Fri, 21 Feb 2025 14:35:26 +0800
Message-Id: <20250221063528.1810007-3-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221063528.1810007-1-yschu@nuvoton.com>
References: <20250221063528.1810007-1-yschu@nuvoton.com>
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
 drivers/i3c/master/svc-i3c-master.c | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index d6057d8c7dec..1e7e3e1f3d22 100644
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
+ * If it is a true SlvStart, the MSTATUS state is SLVREQ.
+ */
+#define SVC_I3C_QUIRK_FALSE_SLVSTART	BIT(1)
+
 struct svc_i3c_cmd {
 	u8 addr;
 	bool rnw;
@@ -158,6 +174,10 @@ struct svc_i3c_regs_save {
 	u32 mdynaddr;
 };
 
+struct svc_i3c_drvdata {
+	u32 quirks;
+};
+
 /**
  * struct svc_i3c_master - Silvaco I3C Master structure
  * @base: I3C master controller
@@ -214,6 +234,7 @@ struct svc_i3c_master {
 		spinlock_t lock;
 	} ibi;
 	struct mutex lock;
+	const struct svc_i3c_drvdata *drvdata;
 	u32 enabled_events;
 	u32 mctrl_config;
 };
@@ -230,6 +251,15 @@ struct svc_i3c_i2c_dev_data {
 	struct i3c_generic_ibi_pool *ibi_pool;
 };
 
+const struct svc_i3c_drvdata npcm845_drvdata = {
+	.quirks = SVC_I3C_QUIRK_FIFO_EMPTY | SVC_I3C_QUIRK_FALSE_SLVSTART,
+};
+
+static inline bool svc_has_quirk(struct svc_i3c_master *master, u32 quirk)
+{
+	return (master->drvdata && (master->drvdata->quirks & quirk));
+}
+
 static inline bool is_events_enabled(struct svc_i3c_master *master, u32 mask)
 {
 	return !!(master->enabled_events & mask);
@@ -1868,6 +1898,7 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, master);
+	master->drvdata = of_device_get_match_data(dev);
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SVC_I3C_PM_TIMEOUT_MS);
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -1960,6 +1991,7 @@ static const struct dev_pm_ops svc_i3c_pm_ops = {
 
 static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
 	{ .compatible = "silvaco,i3c-master-v1"},
+	{ .compatible = "nuvoton,npcm845-i3c", .data = &npcm845_drvdata },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
-- 
2.34.1


