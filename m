Return-Path: <linux-kernel+bounces-432594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1540B9E4D6C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 06:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37A12856BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 05:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E173912CDA5;
	Thu,  5 Dec 2024 05:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="P4yRei9p"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7DC15DBB3
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733377922; cv=none; b=YUbXhlIISNmAI+iI/QFH991ME0mSBPNs6puH0SdHCn8bHZA8zAghnD9RbIswkTOmyYkFN+yIVVOwdRDEjY/9/fbOeawTriHq52HMBO9oAfysZVtzi3X9kXmgT5XnDO8Lopw5/SYzx923VPObnArWpvcO2vhTDeauWOAAgnyqtNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733377922; c=relaxed/simple;
	bh=BhMhSsWYj7UUiSSyfoFi0ExJT5aD3I1Sr5suZGDHQVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GrPiuci7ZuZ7pCtfnSbj0lEbb7Jah3CuDO1w9w3ApKeYjOjyvy2bex2hblpESMSjTlu8YFWtrybrb2jGbrCwTrldVnmiVuCUJW1Uh1Tg182u6pUzRhUq2ZCwythoTCF+UUpS+SYWh7psJSeyHX1TTzAScSWKOYDcsYR4K95ONEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=P4yRei9p; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1733377916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8Fs7cVjM2GkxZPaD8/jJEr7h5lNPnqaZgEf0tlU2kIs=;
	b=P4yRei9pALuG9iwghPWGCTE2QQjnpSAk+xlNuXF/tmhZvlIG4hOxYxv3fBmzJh39gpzlsH
	TVOgAuGEij5xfLad5DaLiI0LC53metQoyyEKkpsIDplZsZ3QC2/BNPMXGAPLjht+MzNNzu
	pR0pIkcZ95j3UTH0/mmZUJmF0AA+pQcWCRuafwVR25w+KVnfVhbHtdM99FU6WWVN3oIVWm
	MVVI7fX/MSHYfPoVv9lbTw1Bsn+Z3TR6fMVN9aCn32Vc/j5j0n+umtrIBB35zRdFhp73zs
	ws56384hHJcc9jIPvL3RvW/y6bX3WCAmDMelRq5HT4F0qKk1BXnRDNIpb58m1A==
From: Val Packett <val@packett.cool>
To: 
Cc: Val Packett <val@packett.cool>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH] clk: rockchip: add clock ID for CIF0/1 on RK3066
Date: Thu,  5 Dec 2024 02:50:46 -0300
Message-ID: <20241205055122.11613-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

RK3066 does have two "CIF" video capture interface blocks, add their
corresponding clock IDs so that they could be used.

Signed-off-by: Val Packett <val@packett.cool>
---
 drivers/clk/rockchip/clk-rk3188.c             | 4 ++--
 include/dt-bindings/clock/rk3188-cru-common.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 684233e72105..81e94b338d0f 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -344,7 +344,7 @@ static struct rockchip_clk_branch common_clk_branches[] __initdata = {
 
 	GATE(0, "pclkin_cif0", "ext_cif0", 0,
 			RK2928_CLKGATE_CON(3), 3, GFLAGS),
-	INVERTER(0, "pclk_cif0", "pclkin_cif0",
+	INVERTER(PCLK_CIF0, "pclk_cif0", "pclkin_cif0",
 			RK2928_CLKSEL_CON(30), 8, IFLAGS),
 
 	FACTOR(0, "xin12m", "xin24m", 0, 1, 2),
@@ -602,7 +602,7 @@ static struct rockchip_clk_branch rk3066a_clk_branches[] __initdata = {
 
 	GATE(0, "pclkin_cif1", "ext_cif1", 0,
 			RK2928_CLKGATE_CON(3), 4, GFLAGS),
-	INVERTER(0, "pclk_cif1", "pclkin_cif1",
+	INVERTER(PCLK_CIF1, "pclk_cif1", "pclkin_cif1",
 			RK2928_CLKSEL_CON(30), 12, IFLAGS),
 
 	COMPOSITE(0, "aclk_gpu_src", mux_pll_src_cpll_gpll_p, 0,
diff --git a/include/dt-bindings/clock/rk3188-cru-common.h b/include/dt-bindings/clock/rk3188-cru-common.h
index 01e14ab252a7..dd988cc9d582 100644
--- a/include/dt-bindings/clock/rk3188-cru-common.h
+++ b/include/dt-bindings/clock/rk3188-cru-common.h
@@ -103,6 +103,8 @@
 #define PCLK_PERI		351
 #define PCLK_DDRUPCTL		352
 #define PCLK_PUBL		353
+#define PCLK_CIF0		354
+#define PCLK_CIF1		355
 
 /* hclk gates */
 #define HCLK_SDMMC		448
-- 
2.47.1


