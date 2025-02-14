Return-Path: <linux-kernel+bounces-514960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E5EA35DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EB927A245A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229BC264A68;
	Fri, 14 Feb 2025 12:56:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5743F17555;
	Fri, 14 Feb 2025 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537767; cv=none; b=li2s1pJnwAbafqoFBBFO4CQvXJBd7cdKS1FZBAbs+LJ37DIUIRHZadiVYtA7y8g9k9sCDFF/+hXHiB3cqo2EticYZ79w6hYkyCx9Nf4XemYIclEM5i7Efg9/j1Ausbn2pDhDlNHXpHZQjout7fJaE9Jpcgm3Nz5gyH4AxonZGB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537767; c=relaxed/simple;
	bh=mlkGxHHcw5VSY3CeB6KXyFMVPAtFQyUZYK5opokkdt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9JbOE4MaTuklMw3z980qSHSRGJnW/1PuoISKUQ0+G+hyWipDQ6a35ZHUVMnHI5SdfiwyUGVGex4FmfTpQzvLOmGv8TQ8yBDqY4P27Na4GpuxYgMNyrOlJuGJHphiVbTgsCNQDfWjwrZ2gRtY8xyNjZFLiN91NFLZfwz/Lkd058=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE32327D3;
	Fri, 14 Feb 2025 04:56:25 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1F213F58B;
	Fri, 14 Feb 2025 04:56:03 -0800 (PST)
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
Subject: [PATCH v2 01/15] clk: sunxi-ng: mp: Add SUNXI_CCU_P_DATA_WITH_MUX_GATE wrapper
Date: Fri, 14 Feb 2025 12:53:45 +0000
Message-ID: <20250214125359.5204-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250214125359.5204-1-andre.przywara@arm.com>
References: <20250214125359.5204-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PRCM CCU in the A523 SoC contains some clocks that only feature a
P (shift) factor, but no M divider.
Treat this as a special case of an MP clock: by forcing the M mask to be
0 bits wide, this always result in the M divider value to be 1.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/clk/sunxi-ng/ccu_mp.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_mp.h b/drivers/clk/sunxi-ng/ccu_mp.h
index 6e50f3728fb5f..e235fdfde2d36 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.h
+++ b/drivers/clk/sunxi-ng/ccu_mp.h
@@ -71,6 +71,24 @@ struct ccu_mp {
 		}							\
 	}
 
+#define SUNXI_CCU_P_DATA_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
+				       _pshift, _pwidth,		\
+				       _muxshift, _muxwidth,		\
+				       _gate, _flags)			\
+	struct ccu_mp _struct = {					\
+		.enable	= _gate,					\
+		.m	= _SUNXI_CCU_DIV(0, 0),				\
+		.p	= _SUNXI_CCU_DIV(_pshift, _pwidth),		\
+		.mux	= _SUNXI_CCU_MUX(_muxshift, _muxwidth),		\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT_PARENTS_DATA(_name,    \
+								   _parents, \
+								   &ccu_mp_ops,\
+								   _flags),  \
+		}							\
+	}
+
 #define SUNXI_CCU_MP_WITH_MUX(_struct, _name, _parents, _reg,		\
 			      _mshift, _mwidth,				\
 			      _pshift, _pwidth,				\
-- 
2.46.3


