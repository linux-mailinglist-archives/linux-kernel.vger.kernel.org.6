Return-Path: <linux-kernel+bounces-550147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7C2A55BD8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFA2A7AC821
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1A832C8B;
	Fri,  7 Mar 2025 00:26:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A8718E3F;
	Fri,  7 Mar 2025 00:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307201; cv=none; b=i2t8DvBiJx4xlD97+PV2dprvWWnsieZ8BwBCEinPJnRbhPRuesIVR4TNXOQk4L0yql5g9skXpoaL9x4V3YiLk9Z6CkjKjN9QtVmewi/Ts+n/o6RDZAHRP7k23yLHpox3VNbSQzUfmXIxPJZ1XobHx0iVF4taKugZB+YO6WNpgT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307201; c=relaxed/simple;
	bh=9w7vRAtkQAW7G8Id799JDC7Ap9kH/BLsKHJeWJAr1eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDUuY22xxCQ0rDFej8JWeapHiE2OBuIkCZwjVO909q2xFpU0MFBQgBk1JJN0I0FJZLil+5vE9G4q+RwJZlT2T+wK3/q16te/JvJTuPbLv5RQXyth5l5QJNK4D7f5yxUXgeyC1hkHialU1PCXrqAOT2eBJHf+6JUxRi6Zi1IhJgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C1FE169E;
	Thu,  6 Mar 2025 16:26:52 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F8443F673;
	Thu,  6 Mar 2025 16:26:37 -0800 (PST)
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
Subject: [PATCH v4 02/14] clk: sunxi-ng: mp: provide wrappers for setting feature flags
Date: Fri,  7 Mar 2025 00:26:16 +0000
Message-ID: <20250307002628.10684-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250307002628.10684-1-andre.przywara@arm.com>
References: <20250307002628.10684-1-andre.przywara@arm.com>
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


