Return-Path: <linux-kernel+bounces-571515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5AFA6BE31
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FA13B4C04
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F3C22CBF3;
	Fri, 21 Mar 2025 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="0Gfz8NrA"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD1D22B598
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570325; cv=none; b=cwkgrBOOABQQv53fowQrIrOndMT9EfcZVaNjBHjvv8x3UeSkHZ29l3RDa/7s1WTQUCyNIjx0HXgxSSjVjz0yT06WMEZeoB2goDiOB54NCVR44bqBA6nXsJazYL5UeG3nSS0K5U3TmrctgInFxdYert9igWXiH+dK+dvvSxBmIgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570325; c=relaxed/simple;
	bh=7QAAJf2NOHMjLyRwHDC/VFO3OWMb54/brTQBqB150Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlCuDoVOXq3gDbEBuTHgAyZziNrHW6N33Xzw48YWuRmqirRd/fJaJIkXPUzh9YbZ+S5HgD1HfOEsUUoprfwS2K38wtVuKG/LvRB67+QQOD7hmaOOyx+XZ8i+EwOb0Q/wTD6YXFKet8n9ONlmj3uryvUo51GoOCYXvMfCPXS4G1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=0Gfz8NrA; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85e15dc8035so46426239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742570323; x=1743175123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOH9+f67UaOTwwttF6Hojln5eRz8NpWPkTKFPaDKYGI=;
        b=0Gfz8NrAaHMI9TaWpSKpbadFVIhsBYNg71lm3i0kNmNMmgATTBaa/AuiIr0kAiXSjr
         LxRcmhK/BRojDwn6KPBzcfAcjmFVQ6HpBnC9gmNdQECk6Zo9TQsSPiSwLIYCNCmVMLWm
         1g3Sm0LDyfAkv3tEulwONZP/R/uVWpIaLOzF6LSI5zn8wGuF2IX0N+NbPrr3WF5WJaNG
         1at5ilOpeKBALzKSb11GvfwZC476QtQWU3rAdwBPG3jOXJozhn8FVctLyElFqGcupGvQ
         WnXzZfU4g7OIaTAT5n184qvFLimobvYPcc5X9MPX1ZK9TwjZu/eQasD+zasw/vXsAXOv
         MZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742570323; x=1743175123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOH9+f67UaOTwwttF6Hojln5eRz8NpWPkTKFPaDKYGI=;
        b=YMw8klowFAyWTIVC4yhAfcsIKW0BXnZUdqMrkzCjhQivExpei71+4JUOBdSnsRcuPC
         bxKQfLbDPVW5tofpFIXR2hy95qDLCe3/N6ndm6PbQSRTGUwzeaKsmZb2QHRWkQjdRspX
         5yGn+KxUrfMF3+hMfEL1J1wJeL8g7eAMQGTfe6Hwh5trYqDxVX0Q3heHTouV61kMyoQN
         saKz3N+bDcro8A/QTDmCexZ6kn3myLJROCKWo9f+uFiM8Z0ERNefn6pHA5ePwuOfrzdt
         2RxRcrjkL9AgC9/BB4FZUILDyAQaZmVHMmXsriuFmj2qmafqjdJghDn44pBLyg3Weg3z
         hgGw==
X-Forwarded-Encrypted: i=1; AJvYcCVJAc/QDxCyJyxmML8cN0wgnOMQY+Ny4e0tbcw2078QFJnFFXJ4tif3wnRKVD2NIe1CmURNh3qi0ARuGx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhxsew0HbYCvUJb/YeFDf4CmxNdO4HNF0YX/b75OUaDJipkk2C
	ROOkVR8+9NfKKuynXWjZfYIh4idq1+/nv8EZcRvJMQcLjlP9foLU28XJ6MPiwt8=
X-Gm-Gg: ASbGnctOl/EAgj7hQr7XgVtX1xA1mwC5KOGMr+wa7uwT/CUMgH0l69Xg5BuFFKlz3qF
	PdToOuKcJaCG08JYkm0L0uJhyTG76LpIuRmIPI54B/ji+ugXDNNPnRLsPFYPGQW45fk5+QqLK8q
	9Asq2tXmfP+hK85ZoG0jWnlYRsqcx7sQ1hArZrilYGzmFzudPZ11u2xq4PmA8WcDOPKyTYxty1D
	+E+nsSJHnnAx/3bRO6XnJcJyb4TkkJ/nwU5RBJQZcXDhef5fa2GTTXL6eEmIXu7bpRvDsDewZYD
	aLzCgnQmHPjc93aEdMIoW1J2T345GzpysqrVb8iIYuOpjVG/ZnVSfE94KkUqBEWTI0pSDvNMZN3
	zRg08Ne4mPEqM2XGiQVxBmEwl
X-Google-Smtp-Source: AGHT+IF/Hdzj6qersLRDCR3zz5/D7xP2GuJej/d+Z4QpdhOjbhKoRLFIjr/QXQ/fsdYRqhMLr9/wFw==
X-Received: by 2002:a05:6602:4c05:b0:85d:a69f:371d with SMTP id ca18e2360f4ac-85e2ca55b1dmr441679539f.4.1742570322839;
        Fri, 21 Mar 2025 08:18:42 -0700 (PDT)
Received: from zoltan.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2cbdd0a21sm475553173.41.2025.03.21.08.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:18:42 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: p.zabel@pengutronix.de,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	dlan@gentoo.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heylenay@4d2.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 6/7] clk: spacemit: define new syscons with only resets
Date: Fri, 21 Mar 2025 10:18:29 -0500
Message-ID: <20250321151831.623575-7-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321151831.623575-1-elder@riscstar.com>
References: <20250321151831.623575-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable support for three additional syscon CCUs which support reset
controls but no clocks:  ARCPU, RCPU2, and APBC2.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/clk/spacemit/ccu-k1.c | 106 ++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
index 17e321c25959a..bf5a3e2048619 100644
--- a/drivers/clk/spacemit/ccu-k1.c
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -130,6 +130,37 @@
 #define APMU_EMAC0_CLK_RES_CTRL		0x3e4
 #define APMU_EMAC1_CLK_RES_CTRL		0x3ec
 
+/* RCPU register offsets */
+#define RCPU_SSP0_CLK_RST		0x0028
+#define RCPU_I2C0_CLK_RST		0x0030
+#define RCPU_UART1_CLK_RST		0x003c
+#define RCPU_CAN_CLK_RST		0x0048
+#define RCPU_IR_CLK_RST			0x004c
+#define RCPU_UART0_CLK_RST		0x00d8
+/* XXX Next one is part of the AUD_AUDCLOCK region @ 0xc0882000 */
+#define AUDIO_HDMI_CLK_CTRL		0x2044
+
+/* RCPU2 register offsets */
+#define RCPU2_PWM0_CLK_RST		0x0000
+#define RCPU2_PWM1_CLK_RST		0x0004
+#define RCPU2_PWM2_CLK_RST		0x0008
+#define RCPU2_PWM3_CLK_RST		0x000c
+#define RCPU2_PWM4_CLK_RST		0x0010
+#define RCPU2_PWM5_CLK_RST		0x0014
+#define RCPU2_PWM6_CLK_RST		0x0018
+#define RCPU2_PWM7_CLK_RST		0x001c
+#define RCPU2_PWM8_CLK_RST		0x0020
+#define RCPU2_PWM9_CLK_RST		0x0024
+
+/* APBC2 register offsets */
+#define APBC2_UART1_CLK_RST		0x0000
+#define APBC2_SSP2_CLK_RST		0x0004
+#define APBC2_TWSI3_CLK_RST		0x0008
+#define APBC2_RTC_CLK_RST		0x000c
+#define APBC2_TIMERS0_CLK_RST		0x0010
+#define APBC2_KPC_CLK_RST		0x0014
+#define APBC2_GPIO_CLK_RST		0x001c
+
 struct spacemit_ccu_clk {
 	int id;
 	struct clk_hw *hw;
@@ -1781,6 +1812,69 @@ static const struct k1_ccu_data k1_ccu_apmu_data = {
 	.rst_data	= &apmu_reset_controller_data,
 };
 
+static const struct ccu_reset_data rcpu_reset_data[] = {
+	[RST_RCPU_SSP0]		= RST_DATA(RCPU_SSP0_CLK_RST,	0, BIT(0)),
+	[RST_RCPU_I2C0]		= RST_DATA(RCPU_I2C0_CLK_RST,	0, BIT(0)),
+	[RST_RCPU_UART1]	= RST_DATA(RCPU_UART1_CLK_RST,	0, BIT(0)),
+	[RST_RCPU_IR]		= RST_DATA(RCPU_CAN_CLK_RST,	0, BIT(0)),
+	[RST_RCPU_CAN]		= RST_DATA(RCPU_IR_CLK_RST,	0, BIT(0)),
+	[RST_RCPU_UART0]	= RST_DATA(RCPU_UART0_CLK_RST,	0, BIT(0)),
+	[RST_RCPU_HDMI_AUDIO]	= RST_DATA(AUDIO_HDMI_CLK_CTRL,	0, BIT(0)),
+};
+
+static const struct ccu_reset_controller_data rcpu_reset_controller_data = {
+	.count		= ARRAY_SIZE(rcpu_reset_data),
+	.data		= rcpu_reset_data,
+};
+
+static struct k1_ccu_data k1_ccu_rcpu_data = {
+	/* No clocks in the RCPU CCU */
+	.rst_data	= &rcpu_reset_controller_data,
+};
+
+static const struct ccu_reset_data rcpu2_reset_data[] = {
+	[RST_RCPU2_PWM0]	= RST_DATA(RCPU2_PWM9_CLK_RST,	BIT(2), BIT(0)),
+	[RST_RCPU2_PWM1]	= RST_DATA(RCPU2_PWM9_CLK_RST,	BIT(2), BIT(0)),
+	[RST_RCPU2_PWM2]	= RST_DATA(RCPU2_PWM9_CLK_RST,	BIT(2), BIT(0)),
+	[RST_RCPU2_PWM3]	= RST_DATA(RCPU2_PWM9_CLK_RST,	BIT(2), BIT(0)),
+	[RST_RCPU2_PWM4]	= RST_DATA(RCPU2_PWM9_CLK_RST,	BIT(2), BIT(0)),
+	[RST_RCPU2_PWM5]	= RST_DATA(RCPU2_PWM9_CLK_RST,	BIT(2), BIT(0)),
+	[RST_RCPU2_PWM6]	= RST_DATA(RCPU2_PWM9_CLK_RST,	BIT(2), BIT(0)),
+	[RST_RCPU2_PWM7]	= RST_DATA(RCPU2_PWM9_CLK_RST,	BIT(2), BIT(0)),
+	[RST_RCPU2_PWM8]	= RST_DATA(RCPU2_PWM9_CLK_RST,	BIT(2), BIT(0)),
+	[RST_RCPU2_PWM9]	= RST_DATA(RCPU2_PWM9_CLK_RST,	BIT(2), BIT(0)),
+};
+
+static const struct ccu_reset_controller_data rcpu2_reset_controller_data = {
+	.count		= ARRAY_SIZE(rcpu2_reset_data),
+	.data		= rcpu2_reset_data,
+};
+
+static struct k1_ccu_data k1_ccu_rcpu2_data = {
+	/* No clocks in the RCPU2 CCU */
+	.rst_data	= &rcpu2_reset_controller_data,
+};
+
+static const struct ccu_reset_data apbc2_reset_data[] = {
+	[RST_APBC2_UART1]	= RST_DATA(APBC2_UART1_CLK_RST,	BIT(2), (0)),
+	[RST_APBC2_SSP2]	= RST_DATA(APBC2_SSP2_CLK_RST,	BIT(2), (0)),
+	[RST_APBC2_TWSI3]	= RST_DATA(APBC2_TWSI3_CLK_RST,	BIT(2), (0)),
+	[RST_APBC2_RTC]		= RST_DATA(APBC2_RTC_CLK_RST,	BIT(2), (0)),
+	[RST_APBC2_TIMERS0]	= RST_DATA(APBC2_TIMERS0_CLK_RST, BIT(2), (0)),
+	[RST_APBC2_KPC]		= RST_DATA(APBC2_KPC_CLK_RST,	BIT(2), (0)),
+	[RST_APBC2_GPIO]	= RST_DATA(APBC2_GPIO_CLK_RST,	BIT(2), (0)),
+};
+
+static const struct ccu_reset_controller_data apbc2_reset_controller_data = {
+	.count		= ARRAY_SIZE(apbc2_reset_data),
+	.data		= apbc2_reset_data,
+};
+
+static struct k1_ccu_data k1_ccu_apbc2_data = {
+	/* No clocks in the RCPU2 CCU */
+	.rst_data	= &apbc2_reset_controller_data,
+};
+
 static struct ccu_reset_controller *
 rcdev_to_controller(struct reset_controller_dev *rcdev)
 {
@@ -1959,6 +2053,18 @@ static const struct of_device_id of_k1_ccu_match[] = {
 		.compatible	= "spacemit,k1-syscon-apmu",
 		.data		= &k1_ccu_apmu_data,
 	},
+	{
+		.compatible	= "spacemit,k1-syscon-rcpu",
+		.data		= &k1_ccu_rcpu_data,
+	},
+	{
+		.compatible	= "spacemit,k1-syscon-rcpu2",
+		.data		= &k1_ccu_rcpu2_data,
+	},
+	{
+		.compatible	= "spacemit,k1-syscon-apbc2",
+		.data		= &k1_ccu_apbc2_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, of_k1_ccu_match);
-- 
2.43.0


