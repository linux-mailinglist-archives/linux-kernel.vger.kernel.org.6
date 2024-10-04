Return-Path: <linux-kernel+bounces-350702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EB29908C3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59AEEB215A7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495AF221E52;
	Fri,  4 Oct 2024 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HQRVYK6e"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA061C7600;
	Fri,  4 Oct 2024 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056740; cv=none; b=EcuBKeE/Knzmcu8WP0zyjfdyZoD0Rx07gwapnR+foF5kD1XYIxOUgyOVi4ZFAz8ldEKsahCat5qU7WZlhd3oA9B96jl9ZZYCc3bsNZunoYQrHE5L11K+zSa+9fEKRsqLR9NIbBjNQdXZoMPTzDfMxg1ZOfdXhRU/ZpExynuqyh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056740; c=relaxed/simple;
	bh=50UAV4Xk3G+FxlFEx31uXtrKM5w+3qQxuIVFotgyQSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VaSeqnfuBWKXVUtD5fz75lllG+wfF5qn4Fl53N94poNXRTjFndB4UvlIWnRF58+c0gsz3UO+Bc8GTBiW4aqpu3NltbQKrTHlZGt+PYFH2I7uqxay1x3eNVcT0o4sgNtubUAg8ERUnrQnTULIOBv8ig96dlaOZaVhIer6IVIW+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HQRVYK6e; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EC08FFF803;
	Fri,  4 Oct 2024 15:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728056736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXbRtL9Q4qiiZuijRuxad0SlAgGkJvMcm8hCa7CUa2Y=;
	b=HQRVYK6e8WDON6B8CzjCetSoa0svFbOckj7KctwxkadvAK7buw91bNP2osuO2U24B3tzfm
	vuNRK8wZq1Q3FuCK8ym+40A3i93qmSXXvoHjFDVhg3LHm4xtfjWt0dkDp8w5Yf+gexAqnL
	WOmNuKqLdrvjI+XEsvb9Fz+Let6GcGjxS9wazXi8roHQloKBOZEmAHT+k+8u2TXK3jP4Fz
	K9PH9RfooxTy4EBu39RTNdGS25YumbmIGaALBDStTQcvPBa8pOsNcCidn3IHAdpp16zEba
	u/IcCrQiOfKu20iF5qUB3KThsONec1RL5nEOryxmtY0bFQnH9SD9wAhI8bA8Jg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 04 Oct 2024 17:45:35 +0200
Subject: [PATCH v4 3/4] clk: divider: Introduce CLK_DIVIDER_EVEN_INTEGERS
 flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241004-mbly-clk-v4-3-c72c2e348e1f@bootlin.com>
References: <20241004-mbly-clk-v4-0-c72c2e348e1f@bootlin.com>
In-Reply-To: <20241004-mbly-clk-v4-0-c72c2e348e1f@bootlin.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: theo.lebrun@bootlin.com

Add CLK_DIVIDER_EVEN_INTEGERS flag to support divisor of 2, 4, 6, etc.
The same divisor can be done using a table, which would be big and
wasteful for a clock dividor of width 8 (256 entries).

Require increasing flags size from u8 to u16 because
CLK_DIVIDER_EVEN_INTEGERS is the eighth flag. u16 is used inside struct
clk_divider; `unsigned long` is used for function arguments.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/clk/clk-divider.c    | 16 ++++++++++++----
 include/linux/clk-provider.h | 15 ++++++++++-----
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index a2c2b5203b0a95cf1cf651b1fb4e2c24d230d831..c1f426b8a5043cb5a1de08e1da385928ec54a2ed 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -72,6 +72,8 @@ static unsigned int _get_maxdiv(const struct clk_div_table *table, u8 width,
 		return clk_div_mask(width);
 	if (flags & CLK_DIVIDER_POWER_OF_TWO)
 		return 1 << clk_div_mask(width);
+	if (flags & CLK_DIVIDER_EVEN_INTEGERS)
+		return 2 * (clk_div_mask(width) + 1);
 	if (table)
 		return _get_table_maxdiv(table, width);
 	return clk_div_mask(width) + 1;
@@ -97,6 +99,8 @@ static unsigned int _get_div(const struct clk_div_table *table,
 		return 1 << val;
 	if (flags & CLK_DIVIDER_MAX_AT_ZERO)
 		return val ? val : clk_div_mask(width) + 1;
+	if (flags & CLK_DIVIDER_EVEN_INTEGERS)
+		return 2 * (val + 1);
 	if (table)
 		return _get_table_div(table, val);
 	return val + 1;
@@ -122,6 +126,8 @@ static unsigned int _get_val(const struct clk_div_table *table,
 		return __ffs(div);
 	if (flags & CLK_DIVIDER_MAX_AT_ZERO)
 		return (div == clk_div_mask(width) + 1) ? 0 : div;
+	if (flags & CLK_DIVIDER_EVEN_INTEGERS)
+		return (div >> 1) - 1;
 	if (table)
 		return  _get_table_val(table, div);
 	return div - 1;
@@ -538,7 +544,8 @@ struct clk_hw *__clk_hw_register_divider(struct device *dev,
 		struct device_node *np, const char *name,
 		const char *parent_name, const struct clk_hw *parent_hw,
 		const struct clk_parent_data *parent_data, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width, u8 clk_divider_flags,
+		void __iomem *reg, u8 shift, u8 width,
+		unsigned long clk_divider_flags,
 		const struct clk_div_table *table, spinlock_t *lock)
 {
 	struct clk_divider *div;
@@ -610,8 +617,8 @@ EXPORT_SYMBOL_GPL(__clk_hw_register_divider);
 struct clk *clk_register_divider_table(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_divider_flags, const struct clk_div_table *table,
-		spinlock_t *lock)
+		unsigned long clk_divider_flags,
+		const struct clk_div_table *table, spinlock_t *lock)
 {
 	struct clk_hw *hw;
 
@@ -664,7 +671,8 @@ struct clk_hw *__devm_clk_hw_register_divider(struct device *dev,
 		struct device_node *np, const char *name,
 		const char *parent_name, const struct clk_hw *parent_hw,
 		const struct clk_parent_data *parent_data, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width, u8 clk_divider_flags,
+		void __iomem *reg, u8 shift, u8 width,
+		unsigned long clk_divider_flags,
 		const struct clk_div_table *table, spinlock_t *lock)
 {
 	struct clk_hw **ptr, *hw;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7e43caabb54b901d68484b86c8349febfe12ba0f..dbe793964c24ca3ab3a7facd090dfb6ae9df7631 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -689,13 +689,15 @@ struct clk_div_table {
  * CLK_DIVIDER_BIG_ENDIAN - By default little endian register accesses are used
  *	for the divider register.  Setting this flag makes the register accesses
  *	big endian.
+ * CLK_DIVIDER_EVEN_INTEGERS - clock divisor is 2, 4, 6, 8, 10, etc.
+ *	Formula is 2 * (value read from hardware + 1).
  */
 struct clk_divider {
 	struct clk_hw	hw;
 	void __iomem	*reg;
 	u8		shift;
 	u8		width;
-	u8		flags;
+	u16		flags;
 	const struct clk_div_table	*table;
 	spinlock_t	*lock;
 };
@@ -711,6 +713,7 @@ struct clk_divider {
 #define CLK_DIVIDER_READ_ONLY		BIT(5)
 #define CLK_DIVIDER_MAX_AT_ZERO		BIT(6)
 #define CLK_DIVIDER_BIG_ENDIAN		BIT(7)
+#define CLK_DIVIDER_EVEN_INTEGERS	BIT(8)
 
 extern const struct clk_ops clk_divider_ops;
 extern const struct clk_ops clk_divider_ro_ops;
@@ -740,19 +743,21 @@ struct clk_hw *__clk_hw_register_divider(struct device *dev,
 		struct device_node *np, const char *name,
 		const char *parent_name, const struct clk_hw *parent_hw,
 		const struct clk_parent_data *parent_data, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width, u8 clk_divider_flags,
+		void __iomem *reg, u8 shift, u8 width,
+		unsigned long clk_divider_flags,
 		const struct clk_div_table *table, spinlock_t *lock);
 struct clk_hw *__devm_clk_hw_register_divider(struct device *dev,
 		struct device_node *np, const char *name,
 		const char *parent_name, const struct clk_hw *parent_hw,
 		const struct clk_parent_data *parent_data, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width, u8 clk_divider_flags,
+		void __iomem *reg, u8 shift, u8 width,
+		unsigned long clk_divider_flags,
 		const struct clk_div_table *table, spinlock_t *lock);
 struct clk *clk_register_divider_table(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_divider_flags, const struct clk_div_table *table,
-		spinlock_t *lock);
+		unsigned long clk_divider_flags,
+		const struct clk_div_table *table, spinlock_t *lock);
 /**
  * clk_register_divider - register a divider clock with the clock framework
  * @dev: device registering this clock

-- 
2.46.2


