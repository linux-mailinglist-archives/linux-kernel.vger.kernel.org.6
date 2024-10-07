Return-Path: <linux-kernel+bounces-353434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC78992DC6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A0F1F24597
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748061D5ACE;
	Mon,  7 Oct 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EIYTGJDk"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669C81D45FF;
	Mon,  7 Oct 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728308972; cv=none; b=qvF6ocVoA/6hd9kGlQ/vA5mNry8MjIOvgBybwOQvlPezflWWzcZYbzbTsSFR6nKAtmc7bDZwQKjL1cYDADxBc9ZNAlT9Gcz6Z9V6IIgrh1Go4lWfXSUz0XC+qZjYHvMbGdFuJK8NyDpEbuvgwx5d3S/pAlefv7fJ6xAuhCGSD/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728308972; c=relaxed/simple;
	bh=50UAV4Xk3G+FxlFEx31uXtrKM5w+3qQxuIVFotgyQSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GeABFIZEjj1gXKzFdLNPaj+d+PT5T1sFpQTZSaz50qD34LBrBJSsmxMLTgoBP/VvdiXam1BiVR7cQeRSEKshNomGxBdg8pPsvrQCXtGfbAxGqZsbQ08AocZzp2+69cR+wf22Y3zsfbdcobXBOBCfyLz95BvRVlQ0h3mFbHJfNZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EIYTGJDk; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4CBCA1C0006;
	Mon,  7 Oct 2024 13:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728308962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXbRtL9Q4qiiZuijRuxad0SlAgGkJvMcm8hCa7CUa2Y=;
	b=EIYTGJDkXeP0kFNcEShD56jN8xKK0yZ2QbjINf99r1JxKRTcwClpnIL8lBd9LJ1+fgSmAG
	OFcgFkIuBPhyvemz+6YGLKLWw4/U0b5gn6t7aDcIBxB53CommWGdrd2DuDLQk6ief9wrau
	+OtUWvJt3dg4ES5qm9+nVuCU7cNTreSHeyTNKnquqKH98WQU+hxkvyImO9EpNtYjMt+BJh
	VGpZUiIZVq5W9q07A98riSdjrpw/lYXNPtBFA2XGhLHuPKi9IsUihHfqOKNd6rzvBGPGlZ
	JhShRmz8WAn2FQfqC+CKuhYzfa+PpSTmt2IZIyW6jmRS+0CJfvjn2KBr/irU9A==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 07 Oct 2024 15:49:18 +0200
Subject: [PATCH v5 3/4] clk: divider: Introduce CLK_DIVIDER_EVEN_INTEGERS
 flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241007-mbly-clk-v5-3-e9d8994269cb@bootlin.com>
References: <20241007-mbly-clk-v5-0-e9d8994269cb@bootlin.com>
In-Reply-To: <20241007-mbly-clk-v5-0-e9d8994269cb@bootlin.com>
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


