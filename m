Return-Path: <linux-kernel+bounces-318679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C7596F19B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43788B24A57
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA501CA681;
	Fri,  6 Sep 2024 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6FSWxuR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784A21C9EB7;
	Fri,  6 Sep 2024 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618898; cv=none; b=imwqlrtqebVjgTx9O/PF5x85y+ygF1uTMv25FmeOgpl3ieQsRWrRKkC86UlzGZrldp8Wb/wVCtFSmp7ikOWuE4D8MTczpxkmGrXB09qXHyAqyPB/+HlJZvitioJpW+Xnxme0bn6hkKve0Mzydhin7fKTVcu3Uy6EBHkojb9bipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618898; c=relaxed/simple;
	bh=wNROTOGwTrtcI0H20f0EmINCmCNdwFiZLjQMJFcLHU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A+QK2OmJFN5jIGHYWPX0f1ion6SIXPVL8NHEuxHDYpzqlCboSAuNGDCek1SaC6gj6NrRwWyj0khDh77XQ3pusH3Dvu5cCEpARzQ/7Px1uqNyJtaiRb2X97GEhz7OI6COHr2mvRjiosw9Dd+ZKwbzi/Eu2Wu9yPoFvZEYnR9QVaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6FSWxuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11535C4CEC8;
	Fri,  6 Sep 2024 10:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725618898;
	bh=wNROTOGwTrtcI0H20f0EmINCmCNdwFiZLjQMJFcLHU0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z6FSWxuRSTKe/x3nQ8Q3ngcRLUR2Bmr427Sp2jclLnw+S7ttvc0dj5WuTu6vdwyZZ
	 Vc08i8ggquZSgUuH45nHbIbuW6ywtNjzKx/kbyNWyHFbJP9vS+sTyddN8DL1h3GxZ3
	 OI8uwI4W9LwaNVTpCm8262abAHdj/iUUzBmSEKbY2I5qqKbtUQ/PGxrHtXK8YK9ELk
	 LN7CisCV1g4lZnzHnCQ5z9DBVS741Qd6hjQZU7TRwrGUHkZQHMZWg7xUTCHE6ffDoj
	 0ELoME1wn29+lHK6llxnq1x7u/5iNbfby9Fb2Aag5Ffa6WWqAlwWHIGB7n4/oLDN8i
	 S4G71bwzPMJXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024A6CE7AFE;
	Fri,  6 Sep 2024 10:34:58 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 06 Sep 2024 18:34:41 +0800
Subject: [PATCH v2 2/3] clk: meson: c3: pll: fix frac maximum value for
 hifi_pll
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-fix_clk-v2-2-7a3941eb2cdf@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725618896; l=770;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=I33Vhd+oqJKtNl4x++Y8xPKvaKodnZowE3DBu//z/PA=;
 b=SADKBH0Q0M4WKvE3kt3/P9oBlUQyRQdTGwUXOIBOYeC1DM1J+oIsLeZanYu9JVZEUNfkwxyeO
 LKUG7LOZoIMBf9/qE6ZBzEJkfCtwZ+SCdrrj54fGqYCVjdoC0hTkw2F
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

The fractional denominator of C3's hifi_pll fractional multiplier is
fixed to 100000.

Fixes: 8a9a129dc565 ("clk: meson: c3: add support for the C3 SoC PLL clock")
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/c3-pll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/meson/c3-pll.c b/drivers/clk/meson/c3-pll.c
index 32bd2ed9d304..35fda31a19e2 100644
--- a/drivers/clk/meson/c3-pll.c
+++ b/drivers/clk/meson/c3-pll.c
@@ -361,6 +361,7 @@ static struct clk_regmap hifi_pll_dco = {
 		.range = &c3_gp0_pll_mult_range,
 		.init_regs = c3_hifi_init_regs,
 		.init_count = ARRAY_SIZE(c3_hifi_init_regs),
+		.frac_max = 100000,
 	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "hifi_pll_dco",

-- 
2.42.0



