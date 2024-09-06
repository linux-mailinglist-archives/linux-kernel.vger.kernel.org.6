Return-Path: <linux-kernel+bounces-318677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C5496F199
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B90A4B249D0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C747C1C9ED3;
	Fri,  6 Sep 2024 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feLd2oA2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA291C870E;
	Fri,  6 Sep 2024 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618898; cv=none; b=sTK+q+vy25zTRza9COIpUPyryxnZh+f4uY3c3KRiWxyQ1EUscG54OTldvNU9Kawy0SSGDtasXc0eZeXp83SMcqth7uF1DRW3Trn4CNhiDnsFeZ/nkM/Bh57h0VprJ0NPojkv4ee0gY8ZWlhkSdyxF/YNzdK+AlO+P0zcrMD0He4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618898; c=relaxed/simple;
	bh=Q5Nu6ki00BNEPUpMCqJOMGrigpdjNMijiEiU0fOJHMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RfIxbYg8ns5dov1cdqR2omXjHto1Ig2DchIdw21pt7naXPrWoJV11oB7RponXNP/yhKK05mCt+j1H0HpYX/zikisMaTs641eAKeBWZnjA3fyGtIYcA2E0hT3qoMjcF6OK1DO6pY68JVx1Vxmnd56Qhec7Yo5I6agEMdLF8irQA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feLd2oA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00445C4CEC5;
	Fri,  6 Sep 2024 10:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725618898;
	bh=Q5Nu6ki00BNEPUpMCqJOMGrigpdjNMijiEiU0fOJHMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=feLd2oA2h1fpNCwu7OpYQg6Jto2lrd2wkK8rIboKdt5MEPbWf8DvzVpLyDlb2+JF1
	 xS81og+9ExOQU8Hiy7c4cpSGLIrljE3hzX6juND7ZQxvH2qX+R5JHsIocdeokZ8PjG
	 5KC83NKiI617ls/Ki73IxaFbL0byLlalpjCAqdaasuJh1CjMTtGYOUWTyIyE0PJyFy
	 Yz6KFOaNMOTNAOq9rWnTahxmQRquAGsADK7WmHG8y1XcKSXfIgtV2FvkIirhJggiwY
	 r8u+g4skA+DftSPhHlfORbz78/eGGezkuaOtfioeoBvW5ekwCYwG2E4oZ168wmgiSt
	 KE6zIpKX+G5iQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02A6CE7AFD;
	Fri,  6 Sep 2024 10:34:57 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 06 Sep 2024 18:34:40 +0800
Subject: [PATCH v2 1/3] clk: meson: Support PLL with fixed fractional
 denominators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-fix_clk-v2-1-7a3941eb2cdf@amlogic.com>
References: <20240906-fix_clk-v2-0-7a3941eb2cdf@amlogic.com>
In-Reply-To: <20240906-fix_clk-v2-0-7a3941eb2cdf@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725618896; l=1859;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=sWmncD36tYvYasLV2agsUM1OmEI/Pbp0y7H5RQI6gyA=;
 b=4/xHBnoby8jx3W1+dFt1CO/FshqhvP3WwGUal1rMsRXHWSq+LWZPSvMSKC2/icWrRMR/HUXnO
 PsJNpbDCIRdClPh2zEqrnCf1n7wS7rEGGn5JB6cxFetc3LLQkMSdhul
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

Some PLLS with fractional multipliers have fractional denominators with
fixed values, instead of the previous "(1 << pll-> frc.width)".

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/clk-pll.c | 8 +++++---
 drivers/clk/meson/clk-pll.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
index bc570a2ff3a3..a141ab450009 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -57,12 +57,13 @@ static unsigned long __pll_params_to_rate(unsigned long parent_rate,
 					  struct meson_clk_pll_data *pll)
 {
 	u64 rate = (u64)parent_rate * m;
+	unsigned int frac_max = unlikely(pll->frac_max) ? pll->frac_max :
+							  (1 << pll->frac.width);
 
 	if (frac && MESON_PARM_APPLICABLE(&pll->frac)) {
 		u64 frac_rate = (u64)parent_rate * frac;
 
-		rate += DIV_ROUND_UP_ULL(frac_rate,
-					 (1 << pll->frac.width));
+		rate += DIV_ROUND_UP_ULL(frac_rate, frac_max);
 	}
 
 	return DIV_ROUND_UP_ULL(rate, n);
@@ -100,7 +101,8 @@ static unsigned int __pll_params_with_frac(unsigned long rate,
 					   unsigned int n,
 					   struct meson_clk_pll_data *pll)
 {
-	unsigned int frac_max = (1 << pll->frac.width);
+	unsigned int frac_max = unlikely(pll->frac_max) ? pll->frac_max :
+							  (1 << pll->frac.width);
 	u64 val = (u64)rate * n;
 
 	/* Bail out if we are already over the requested rate */
diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
index 7b6b87274073..949157fb7bf5 100644
--- a/drivers/clk/meson/clk-pll.h
+++ b/drivers/clk/meson/clk-pll.h
@@ -43,6 +43,7 @@ struct meson_clk_pll_data {
 	unsigned int init_count;
 	const struct pll_params_table *table;
 	const struct pll_mult_range *range;
+	unsigned int frac_max;
 	u8 flags;
 };
 

-- 
2.42.0



