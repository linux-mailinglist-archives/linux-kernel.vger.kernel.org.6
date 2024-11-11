Return-Path: <linux-kernel+bounces-403420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6136D9C3579
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C45282016
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 00:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDA878276;
	Mon, 11 Nov 2024 00:47:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B831B487BE;
	Mon, 11 Nov 2024 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731286061; cv=none; b=FpC7m/jwRXDnHbRacALfbkUpsY694h1kjGMmx26vS4eiAQsnJNQCoGmvh1qIymb9IVOGaRCuSOvIu/io1FpxgFhljwJRI3O2rJoxYbXWtZy8JR2kqN9uh0b8dMbB3vGA0PcJAugZ9wP83j3P24ccuZl8KS+MbhVswytFc1GoAqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731286061; c=relaxed/simple;
	bh=GPfoqLQgxD1Cp/dF8JfOc6vcc6K8LscjGEzu2i/odP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H76FWHqxpzqYoVbaS5RQCrNWVFfZYX1oW3kRchoSbQ1Gi1wEMb0fBfrtmXSRjOUzg/WofkDsJ5LFIVFN7O9+RYt595KtOadZyEZSkscetkoeEz0BTEyYnd5zT8mDrwqzCK5Chmggn/wy5yg5BJtALPxes+iy4JkQoSegkbg0+PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 274F31CE0;
	Sun, 10 Nov 2024 16:48:09 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E56B3F66E;
	Sun, 10 Nov 2024 16:47:37 -0800 (PST)
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
	Icenowy Zheng <uwu@icenowy.me>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] clk: sunxi-ng: mp: provide wrapper for setting feature flags
Date: Mon, 11 Nov 2024 00:47:18 +0000
Message-ID: <20241111004722.10130-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241111004722.10130-1-andre.przywara@arm.com>
References: <20241111004722.10130-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So far our sunxi clock instantiation macros set the required flags
depending on the clock type, but the new "dual divider MP clock"
requires us to pass that piece of information in by the user.

Add a new wrapper macro that allows to specify a "features" field, to
allow marking those dual-divider clocks accordingly.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi-ng/ccu_mp.h | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mp.h b/drivers/clk/sunxi-ng/ccu_mp.h
index e235fdfde2d36..687bd2ec798e2 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.h
+++ b/drivers/clk/sunxi-ng/ccu_mp.h
@@ -100,11 +100,12 @@ struct ccu_mp {
 				   _muxshift, _muxwidth,		\
 				   0, _flags)
 
-#define SUNXI_CCU_MP_DATA_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
+#define SUNXI_CCU_MP_DATA_WITH_MUX_GATE_FEAT(_struct, _name, _parents, _reg, \
 					_mshift, _mwidth,		\
 					_pshift, _pwidth,		\
 					_muxshift, _muxwidth,		\
-					_gate, _flags)			\
+					_gate, _flags,			\
+					_features)			\
 	struct ccu_mp _struct = {					\
 		.enable	= _gate,					\
 		.m	= _SUNXI_CCU_DIV(_mshift, _mwidth),		\
@@ -112,13 +113,25 @@ struct ccu_mp {
 		.mux	= _SUNXI_CCU_MUX(_muxshift, _muxwidth),		\
 		.common	= {						\
 			.reg		= _reg,				\
+			.features	= _features,			\
 			.hw.init	= CLK_HW_INIT_PARENTS_DATA(_name, \
 								   _parents, \
-								   &ccu_mp_ops, \
+								   &ccu_mp_ops,\
 								   _flags), \
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
 #define SUNXI_CCU_MP_DATA_WITH_MUX(_struct, _name, _parents, _reg,	\
 				   _mshift, _mwidth,			\
 				   _pshift, _pwidth,			\
-- 
2.46.2


