Return-Path: <linux-kernel+bounces-543040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CFBA4D0D4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 941E2173708
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F7D155382;
	Tue,  4 Mar 2025 01:30:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF1013DDAA;
	Tue,  4 Mar 2025 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051839; cv=none; b=PyQ4I98sm5T3Nx/lFJZMRBCt6nGk/txVl1R2VfFONiLSVVH7oNUJHEplm5MiFxLrkutGYnC8HOd3UjrlJ4EMdh+nBBIQSfvF5S9S51eyV5lmeba7dnMGhXwupVbH6FbPzHkyeGXvvQZSizt23mO9LuKv8bUDifB78klImglit9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051839; c=relaxed/simple;
	bh=9w7vRAtkQAW7G8Id799JDC7Ap9kH/BLsKHJeWJAr1eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZLrSB16b4rqpxre2unN9i3vC1pJspj0E4RAd5GXklk3M+bBqvfz0S1qKKZ0oVAjv7w2SQF8Jt/rVyZLkmk7130A/f1cj7Hd5o0NEN9Ko7eGnAQhAREzTgLhoh/HUuEqFndzKom3Du8VJQxzd9CsqW1lcsOjmP50U8YRHSmNEIbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D874106F;
	Mon,  3 Mar 2025 17:30:51 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCB553F673;
	Mon,  3 Mar 2025 17:30:35 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/15] clk: sunxi-ng: mp: provide wrappers for setting feature flags
Date: Tue,  4 Mar 2025 01:27:52 +0000
Message-ID: <20250304012805.28594-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250304012805.28594-1-andre.przywara@arm.com>
References: <20250304012805.28594-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So far our sunxi clock instantiation macros set the required clock
features depending on the clock type, but the new "dual divider MP
clock" requires us to pass that piece of information in by the user.

Add new wrapper macros that allow to specify a "features" field, to
allow marking those dual-divider clocks accordingly. Also add two
convenience macros that deal with the most common cases.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi-ng/ccu_mp.h | 58 ++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mp.h b/drivers/clk/sunxi-ng/ccu_mp.h
index 6e50f3728fb5f..b35aeec70484d 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.h
+++ b/drivers/clk/sunxi-ng/ccu_mp.h
@@ -82,11 +82,35 @@ struct ccu_mp {
 				   _muxshift, _muxwidth,		\
 				   0, _flags)
 
-#define SUNXI_CCU_MP_DATA_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
-					_mshift, _mwidth,		\
-					_pshift, _pwidth,		\
-					_muxshift, _muxwidth,		\
-					_gate, _flags)			\
+#define SUNXI_CCU_MP_MUX_GATE_POSTDIV_DUALDIV(_struct, _name, _parents, _reg, \
+					      _mshift, _mwidth,		\
+					      _pshift, _pwidth,		\
+					      _muxshift, _muxwidth,	\
+					      _gate, _postdiv,		\
+					      _flags)			\
+	struct ccu_mp _struct = {					\
+		.enable	= _gate,					\
+		.m	= _SUNXI_CCU_DIV(_mshift, _mwidth),		\
+		.p	= _SUNXI_CCU_DIV(_pshift, _pwidth),		\
+		.mux	= _SUNXI_CCU_MUX(_muxshift, _muxwidth),		\
+		.fixed_post_div = _postdiv,				\
+		.common	= {						\
+			.reg		= _reg,				\
+			.features	= CCU_FEATURE_FIXED_POSTDIV |	\
+						CCU_FEATURE_DUAL_DIV,	\
+			.hw.init	= CLK_HW_INIT_PARENTS_DATA(_name, \
+								   _parents, \
+								   &ccu_mp_ops, \
+								   _flags), \
+		}							\
+	}
+
+#define SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(_struct, _name, _parents, _reg, \
+					     _mshift, _mwidth,		\
+					     _pshift, _pwidth,		\
+					     _muxshift, _muxwidth,	\
+					     _gate, _features,		\
+					     _flags)			\
 	struct ccu_mp _struct = {					\
 		.enable	= _gate,					\
 		.m	= _SUNXI_CCU_DIV(_mshift, _mwidth),		\
@@ -94,6 +118,7 @@ struct ccu_mp {
 		.mux	= _SUNXI_CCU_MUX(_muxshift, _muxwidth),		\
 		.common	= {						\
 			.reg		= _reg,				\
+			.features	= _features,			\
 			.hw.init	= CLK_HW_INIT_PARENTS_DATA(_name, \
 								   _parents, \
 								   &ccu_mp_ops, \
@@ -101,6 +126,29 @@ struct ccu_mp {
 		}							\
 	}
 
+#define SUNXI_CCU_MP_DATA_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
+					_mshift, _mwidth,		\
+					_pshift, _pwidth,		\
+					_muxshift, _muxwidth,		\
+					_gate, _flags)			\
+	SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(_struct, _name, _parents,	\
+					     _reg, _mshift, _mwidth,	\
+					     _pshift, _pwidth,		\
+					     _muxshift, _muxwidth,	\
+					     _gate, _flags, 0)
+
+#define SUNXI_CCU_DUALDIV_MUX_GATE(_struct, _name, _parents, _reg,	\
+				   _mshift, _mwidth,			\
+				   _pshift, _pwidth,			\
+				   _muxshift, _muxwidth,		\
+				   _gate, _flags)			\
+	SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(_struct, _name, _parents,	\
+					     _reg, _mshift, _mwidth,	\
+					     _pshift, _pwidth,		\
+					     _muxshift, _muxwidth,	\
+					     _gate, _flags,		\
+					     CCU_FEATURE_DUAL_DIV)
+
 #define SUNXI_CCU_MP_DATA_WITH_MUX(_struct, _name, _parents, _reg,	\
 				   _mshift, _mwidth,			\
 				   _pshift, _pwidth,			\
-- 
2.46.3


