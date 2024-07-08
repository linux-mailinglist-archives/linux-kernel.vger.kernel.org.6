Return-Path: <linux-kernel+bounces-244144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A01929FBE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD14286EB2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AFC77F13;
	Mon,  8 Jul 2024 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h+E5YnyD"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF1D7346F;
	Mon,  8 Jul 2024 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432657; cv=none; b=akrTbtGB0CPnUfzTtXK5SVKVP4ift33toeg9xEgvdlyCmI8nOeEq8n+2W2AYEkAxSOMas43C2rUvFb7IHAtHe4zyoaqaEnuHQQOicfm7nL9G+rNeuHhGSQKJfsnEIrr6JJcfq3xTs8zNVVV8a2gPCMKf1YHit4l1bKjYuknwUqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432657; c=relaxed/simple;
	bh=w2If79lWwbWbJEfpkvSvIjHGyXXDg5JyR1TcCbacBAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KOmuKUCe2batJDoVXnAcRmGuNqve+/EwdJFCGE532ZgV828xSFJZTliQfg0iR8SVMN1loOHyIi12lP9U2UiopcQ9SaSMOgbwSXXHx/0M6x1ZsS967OXM5DlYAjMNDjgFwZ10Cxvl+thAiq0fu2zKDR9395Bru0bXAosRoZBXZic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h+E5YnyD; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0306D1C000A;
	Mon,  8 Jul 2024 09:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720432653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a9tyEv6JiL2E2sj4V72RhLJVpp93RMHsSx3RfEM+Nf0=;
	b=h+E5YnyDv9LB7ywtFJKvfaXWywDOtCqLrq5gwRNnqXkHwtDB2gqVJe1Aix182s+ctkDDPW
	VLvnyYJ3jgG7O2N572wkSqfZmfW58J9A4W7GH27JK+Qg43q7yeeclO7AMMBnDAUBSKy1vA
	PzoO1SBKo8f3A6lx+N/mPkAx77aGiM4Nwu8vhFxQs+arX5ESNSHHezQpyTw5NoB9VEpKwK
	tewiRM2uNSO6x4tzRYS7JCChCpqGcQDCmVH2rkmvi2NZks3h1fdshLnqbior5Zu9eg+2OX
	rQ6qGzW4kXI23rryCUsEYcyHCUjVpT6H8H+UmkKiUV3WW2IpJAqxxbTo5AXJnw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 08 Jul 2024 11:56:33 +0200
Subject: [PATCH v3 3/4] clk: divider: Introduce CLK_DIVIDER_EVEN_INTEGERS
 flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240708-mbly-clk-v3-3-f3fa1ee28fed@bootlin.com>
References: <20240708-mbly-clk-v3-0-f3fa1ee28fed@bootlin.com>
In-Reply-To: <20240708-mbly-clk-v3-0-f3fa1ee28fed@bootlin.com>
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
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: theo.lebrun@bootlin.com

Add CLK_DIVIDER_EVEN_INTEGERS flag to support divisor of 2, 4, 6, etc.
The same divisor can be done using a table, which would be big and
wasteful for a clock dividor of width 8 (256 entries).

Require increasing flags size from u8 to u16 because
CLK_DIVIDER_EVEN_INTEGERS is the eighth flag.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/clk/clk-divider.c    | 12 +++++++++---
 include/linux/clk-provider.h | 11 +++++++----
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index a2c2b5203b0a..b6654c5c36d2 100644
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
@@ -538,7 +544,7 @@ struct clk_hw *__clk_hw_register_divider(struct device *dev,
 		struct device_node *np, const char *name,
 		const char *parent_name, const struct clk_hw *parent_hw,
 		const struct clk_parent_data *parent_data, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width, u8 clk_divider_flags,
+		void __iomem *reg, u8 shift, u8 width, u16 clk_divider_flags,
 		const struct clk_div_table *table, spinlock_t *lock)
 {
 	struct clk_divider *div;
@@ -610,7 +616,7 @@ EXPORT_SYMBOL_GPL(__clk_hw_register_divider);
 struct clk *clk_register_divider_table(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_divider_flags, const struct clk_div_table *table,
+		u16 clk_divider_flags, const struct clk_div_table *table,
 		spinlock_t *lock)
 {
 	struct clk_hw *hw;
@@ -664,7 +670,7 @@ struct clk_hw *__devm_clk_hw_register_divider(struct device *dev,
 		struct device_node *np, const char *name,
 		const char *parent_name, const struct clk_hw *parent_hw,
 		const struct clk_parent_data *parent_data, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width, u8 clk_divider_flags,
+		void __iomem *reg, u8 shift, u8 width, u16 clk_divider_flags,
 		const struct clk_div_table *table, spinlock_t *lock)
 {
 	struct clk_hw **ptr, *hw;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 4a537260f655..cb348e502e41 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -675,13 +675,15 @@ struct clk_div_table {
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
@@ -697,6 +699,7 @@ struct clk_divider {
 #define CLK_DIVIDER_READ_ONLY		BIT(5)
 #define CLK_DIVIDER_MAX_AT_ZERO		BIT(6)
 #define CLK_DIVIDER_BIG_ENDIAN		BIT(7)
+#define CLK_DIVIDER_EVEN_INTEGERS	BIT(8)
 
 extern const struct clk_ops clk_divider_ops;
 extern const struct clk_ops clk_divider_ro_ops;
@@ -726,18 +729,18 @@ struct clk_hw *__clk_hw_register_divider(struct device *dev,
 		struct device_node *np, const char *name,
 		const char *parent_name, const struct clk_hw *parent_hw,
 		const struct clk_parent_data *parent_data, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width, u8 clk_divider_flags,
+		void __iomem *reg, u8 shift, u8 width, u16 clk_divider_flags,
 		const struct clk_div_table *table, spinlock_t *lock);
 struct clk_hw *__devm_clk_hw_register_divider(struct device *dev,
 		struct device_node *np, const char *name,
 		const char *parent_name, const struct clk_hw *parent_hw,
 		const struct clk_parent_data *parent_data, unsigned long flags,
-		void __iomem *reg, u8 shift, u8 width, u8 clk_divider_flags,
+		void __iomem *reg, u8 shift, u8 width, u16 clk_divider_flags,
 		const struct clk_div_table *table, spinlock_t *lock);
 struct clk *clk_register_divider_table(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 shift, u8 width,
-		u8 clk_divider_flags, const struct clk_div_table *table,
+		u16 clk_divider_flags, const struct clk_div_table *table,
 		spinlock_t *lock);
 /**
  * clk_register_divider - register a divider clock with the clock framework

-- 
2.45.2


