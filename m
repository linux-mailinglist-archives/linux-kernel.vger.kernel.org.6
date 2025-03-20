Return-Path: <linux-kernel+bounces-570319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC6DA6AED3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2748482968
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922E822D4DB;
	Thu, 20 Mar 2025 19:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ySiHrO5S"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AFD22CBD9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499905; cv=none; b=Xg7WhPiCgtL+MaRhJpL6bp6dEg4eg7mp1FnP2tT+7ECWCoLzuHC3Cwr0Lq/qFPk6hJaL9et2eHJVbBS9P2KvKgHQFZu5r58wsuY0EPT7Wg/qunPTw5dGU1t6NqLkoDDqUrS22KKJbRYdwp1alrV0Ua0RMB/T2bVdK5YfxXvgZsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499905; c=relaxed/simple;
	bh=7QAAJf2NOHMjLyRwHDC/VFO3OWMb54/brTQBqB150Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rAde+N43YERdeT0vzKNPI8azzTf09Yo4WKq5D3gvdpLT8p3PY6sWo5kv31kEl0m+iucLVfgq/8szRihVbSK5eEdLYcuGamnCIE0LVSYyRFaHkALpxKngTtXr79dseNmsrmy7c5F2QZqjJGwxK+/4jhmfnxZCmxBl1gM+fMi2fDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ySiHrO5S; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85b40a5120eso32221539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 12:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1742499903; x=1743104703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOH9+f67UaOTwwttF6Hojln5eRz8NpWPkTKFPaDKYGI=;
        b=ySiHrO5S4P9WexIIBVkAHOJu46mBelPMxBil2qLA7PUVI8K/dGtMsZz5+2SLhuw3Ji
         DB409K2hBy5tLw5A6uaLvBjG39JYbSJq0LACC14sTf7MFzNWPd2EeD8yXF7pyvlAQx0H
         r/+2oeEMh4vHEWrjarRuTbXrcssv8HknlxaJ3EZU1JX9RYM2y6sJCuB4jZ+uhWuAeyBs
         oQb+ySWbcsEYYJLnJ+JFVrWJEyI5p87nQQ2j713k603BVEz/Y+2z75PLD4GUSjty+9Tk
         YI4TfGvLYuoawEuPgvFMLo/iQjkhUh83Dn7okqSgmjSIMUCUzhAIUhynqdx5OLqBh1zx
         laAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499903; x=1743104703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOH9+f67UaOTwwttF6Hojln5eRz8NpWPkTKFPaDKYGI=;
        b=CVzG2bpG2Uys88nYNt5g/goC40ajpFTS+ZwNUNQpxxJuQtMOaALovYk2IYW98Hdyy7
         tq7b715r0bcPwxqBMsyDYJTS6+UuuCS1edigkWdTwf3sf7GviDTy0Sa1Feiafj8eRY6Y
         X3JwRb1lu8UdQ7ubmBP3y4wJd4wfb1J9n4VNHHiQ/aJOSBJb0Dzvg0fZYtrvECNBuhOI
         MrcsP2rAgus89xobMoLJ61uq3gMJ9NB3CHT2XPbAaLKQJv16KtdW/0zzqnIUGtl24FTl
         vVvO4F8zEzuCPa9XVb3dH+PH5po3VzST5Vm3Tl/617TzSyj9VCZseW7xjug+yV5ak84J
         /2fg==
X-Forwarded-Encrypted: i=1; AJvYcCVKkjG9Kk/iGf61HqR14aWQw+e5o2KrLJLbdMTAHAJ/76GHR45AwPZBq1i/istRqD8rfAMOInioYbhd6f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD5SbCnkHHfo7FnSqhuoeKmLbtyoBREXItN6pmDo0RnXiyP8yb
	SE1YxgeLmPiXRrc2Ehv0umS19Ntq0lQKMWmP+6fl2QFvRDHCImUU9KhZdg+NIFY=
X-Gm-Gg: ASbGnct8plhr+csYqCo3LwoEQdGAMKFpNP4h1CUHoz00J8PB3IDtyuJsaF0aTC8A/dc
	UQCfC++5HLTMiC8SIjf5P7m37rfdsjKXaJezzwYuo5gB6ZqBqBrgn7j5m7ASOf2H9yy/9paG4Fo
	vQVB4JWnpqfttA9SPxyy/2YRh7OywBpU7CERKE6C+DV8pz1g3TuxH6u98JTSPDW37y51o6rSoiD
	JQctsgN8GwvnaiaUa8n5N14eYN+inJuEleiB8nxpSKkzezpobh3IScOk5gZM06wTl+8tirzHnjp
	VyKya7WCLSl9ac0A9H++E5E9zc0fAQfVidn9E3derg0cezZGrLzD+WKNWeNWhWKMp+ZvxsTy133
	+7XQ8zEZ2rR7Ijocsz2X1kTbC
X-Google-Smtp-Source: AGHT+IGLluEbi7mVLd8DDg8abX1N/lpDFpXeV010Osk+pfg4+/ZU3s3WYLjc6c/sr9ENyVx55qtevQ==
X-Received: by 2002:a05:6602:4c05:b0:85d:a69f:371d with SMTP id ca18e2360f4ac-85e2ca55b1dmr75211939f.4.1742499903064;
        Thu, 20 Mar 2025 12:45:03 -0700 (PDT)
Received: from zoltan.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e2bd8c40fsm8341439f.32.2025.03.20.12.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 12:45:02 -0700 (PDT)
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
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] clk: spacemit: define new syscons with only resets
Date: Thu, 20 Mar 2025 14:44:47 -0500
Message-ID: <20250320194449.510569-7-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320194449.510569-1-elder@riscstar.com>
References: <20250320194449.510569-1-elder@riscstar.com>
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


