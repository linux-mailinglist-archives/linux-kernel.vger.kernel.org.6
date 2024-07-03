Return-Path: <linux-kernel+bounces-239596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EECD9262EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C061C23313
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6A8180A9B;
	Wed,  3 Jul 2024 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BzGJM5Z6"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C6917B4F7;
	Wed,  3 Jul 2024 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015697; cv=none; b=KvCKJh+STkiSvxvBDMRA+Qnefbkns+zLlE+zo8Anz4H6TSr18lq9iX0/kqz5IALvlL1Ch+hjnMnb5FvKLWgNgqXNnGsM082i8It6jG/baRk6IO4ravlQbQ6yJSX4ZMJpxJJ+Xz6L4Sq1wfqtM46gVH+OPUs+xw1p77+5gXLX33g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015697; c=relaxed/simple;
	bh=WtGnHZZ+RLi3ObKl8onh0tBYRgZkXH7SUIfhPKJ46EI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cMUOGTguQSTIj0EKClNZ66glgTU0z7AQrdIZPa30/jBTk7YwPWLBPZYSzCB7sWoPk5VJPi1sx8wcxIEgJtpmqF9XdgpwIhaOz7js7wJO0vWb/mOIuoO1aZwYRFKOmwxmK0j+4P5Fxpo+4xyfrbZITXb+2i8SUax6FflJ2fy1idI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BzGJM5Z6; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 1DFCAC6D23;
	Wed,  3 Jul 2024 13:46:15 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7ADEE240010;
	Wed,  3 Jul 2024 13:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720014373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LRcR8zDM+0q/eOEPboWIYCWFm9lgVjfqj9jKDcJMYSY=;
	b=BzGJM5Z6KLBDrGEfvfdRjXUtnsKf5GqM8obPJ8l8fr4PCOPPi7bwUFKoH5Ie3oHq9MhoUT
	EsspARrAu6sOCA/cf+u7t4bMYkjd/LZYLsTFAL0xFSmsmJMjT4QrTHB0IvJYJG7iXMA68u
	QovaIrwB5IN25iskNZAjTX+jfXIYtGM0uxCjEesi4Elr6dMlizq5pQ5qkVfWmfgm4g6o9U
	CuUY23XWAvuAMDeOovPpJwLpXmKaNrpA2xJ0+b/M+1DwAg/iVFuNLtVEdY3TPww0weBmic
	zLjsHPyi3JOa7xAbUlbz1+/1lKlCe1FIlfCDEiy0ErSl/TmypnWA8wra5hfz0g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 03 Jul 2024 15:46:06 +0200
Subject: [PATCH v2 2/4] dt-bindings: clock: add Mobileye EyeQ6L/EyeQ6H
 clock indexes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240703-mbly-clk-v2-2-fe8c6199a579@bootlin.com>
References: <20240703-mbly-clk-v2-0-fe8c6199a579@bootlin.com>
In-Reply-To: <20240703-mbly-clk-v2-0-fe8c6199a579@bootlin.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-13183
X-GND-Sasl: theo.lebrun@bootlin.com

Add #defines for Mobileye EyeQ6L and EyeQ6H SoC clocks.

Constant prefixes are:
 - EQ6LC_PLL_: EyeQ6L clock PLLs
 - EQ6HC_SOUTH_PLL_: EyeQ6H south OLB PLLs
 - EQ6HC_SOUTH_DIV_: EyeQ6H south OLB divider clocks
 - EQ6HC_ACC_PLL_: EyeQ6H accelerator OLB PLLs

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 include/dt-bindings/clock/mobileye,eyeq5-clk.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/dt-bindings/clock/mobileye,eyeq5-clk.h b/include/dt-bindings/clock/mobileye,eyeq5-clk.h
index 26d8930335e4..b433c1772c28 100644
--- a/include/dt-bindings/clock/mobileye,eyeq5-clk.h
+++ b/include/dt-bindings/clock/mobileye,eyeq5-clk.h
@@ -19,4 +19,25 @@
 
 #define EQ5C_DIV_OSPI	10
 
+#define EQ6LC_PLL_DDR		0
+#define EQ6LC_PLL_CPU		1
+#define EQ6LC_PLL_PER		2
+#define EQ6LC_PLL_VDI		3
+
+#define EQ6HC_SOUTH_PLL_VDI		0
+#define EQ6HC_SOUTH_PLL_PCIE		1
+#define EQ6HC_SOUTH_PLL_PER		2
+#define EQ6HC_SOUTH_PLL_ISP		3
+
+#define EQ6HC_SOUTH_DIV_EMMC		4
+#define EQ6HC_SOUTH_DIV_OSPI_REF	5
+#define EQ6HC_SOUTH_DIV_OSPI_SYS	6
+#define EQ6HC_SOUTH_DIV_TSU		7
+
+#define EQ6HC_ACC_PLL_XNN		0
+#define EQ6HC_ACC_PLL_VMP		1
+#define EQ6HC_ACC_PLL_PMA		2
+#define EQ6HC_ACC_PLL_MPC		3
+#define EQ6HC_ACC_PLL_NOC		4
+
 #endif

-- 
2.45.2


