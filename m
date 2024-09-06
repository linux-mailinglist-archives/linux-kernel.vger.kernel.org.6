Return-Path: <linux-kernel+bounces-318179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A622096E985
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522CF1F24377
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D119F13B7A1;
	Fri,  6 Sep 2024 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCUAAoKk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370671EB3D;
	Fri,  6 Sep 2024 05:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725601957; cv=none; b=AM1acYqv96PuGONWIfhOym89NEy3qCS79Yq9K7X0cmckQlpYQu1+28gh1v9B/k7BqZqb7Wf65jjdG1B1K7KieqRw6A+jUKTMN4lRtsEibA7j3CzHI4eW9myYdXyOmPo/NBg+OVNfO0o7dxu2AYGeET7Dj68xiHv16IPEM3UYakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725601957; c=relaxed/simple;
	bh=S3mFqsYvIRYGegsx08fYvuzsX6Qwu4VsDx147bN5fYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MNkCNgG8bH2+WQilTrnmK0nokv9UT6KPu+FM8k0YgCfQ60D6eO2CuW7pRunzW+ZW6OPeEXboecjRddNiVOYcLTvqXMchag51SuVTEW5Je8Ei2LaMZkAGdBz5toHYRTPx9X28NRQjL7bTmHsY6iWuk0dUeuZKhsM/JGpuNYul1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCUAAoKk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D445CC4CEC9;
	Fri,  6 Sep 2024 05:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725601956;
	bh=S3mFqsYvIRYGegsx08fYvuzsX6Qwu4VsDx147bN5fYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YCUAAoKkVzT2EMiB9d27VUcc2cwtreBRMnj8ACMRtWT68xLZHapaFd8VxJwPlmrNa
	 eXlp8EuZ4p9XYAKbWECgqunAnmbTcFPuU+zFacPZMnNYhA/UO+/Ea8XeXy5AJ/cIHB
	 D3Rerl1wyv3x3kN56BxKQOMO7+xAshSmTWIECqT7GapOdkQQ+3b3ApMdB26UiuiJzs
	 fM0m17qCQEL0zynEU1HvIhsQawZeiSyjfqWCehYLajnCZRze4v3up1WYLrTQEHE+Wo
	 UazDJJwgOj+eQZZArA24Dv+IghHu/ATxBBGjk+1LWiAxTikBDV+o2Mv65hn4gr5Nrc
	 A4uZUJi2Nikwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A64CD5BA4;
	Fri,  6 Sep 2024 05:52:36 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 06 Sep 2024 13:52:34 +0800
Subject: [PATCH 2/4] clk: meson: c3: pll: hifi_pll frequency is not
 accurate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-fix_clk-v1-2-2977ef0d72e7@amlogic.com>
References: <20240906-fix_clk-v1-0-2977ef0d72e7@amlogic.com>
In-Reply-To: <20240906-fix_clk-v1-0-2977ef0d72e7@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725601955; l=836;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=M/IqRKmFgbyGrESbxg574FVPvS6H4iQmlVvP8JBwBMQ=;
 b=fchMifHrKQ1Qtl5EJeyYwqm5AFN+WR+v2xXBG5jYR5Bv2xcf2EFq/9m415BdgCEIMgcTOHG5p
 ZLaESWUH2lsD2xDLkYxGRCwkuqlxfJmrulvCl1A4FRfKItaqvJsnTzp
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

The fractional denominator of C3's hifi_pll fractional multiplier is
fixed to 100000, so flag CLK_MESON_PLL_FIXED_FRAC_MAX is added.

Fixes: 8a9a129dc565 ("clk: meson: c3: add support for the C3 SoC PLL clock")
Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/c3-pll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/meson/c3-pll.c b/drivers/clk/meson/c3-pll.c
index 32bd2ed9d304..a350173efe90 100644
--- a/drivers/clk/meson/c3-pll.c
+++ b/drivers/clk/meson/c3-pll.c
@@ -361,6 +361,7 @@ static struct clk_regmap hifi_pll_dco = {
 		.range = &c3_gp0_pll_mult_range,
 		.init_regs = c3_hifi_init_regs,
 		.init_count = ARRAY_SIZE(c3_hifi_init_regs),
+		.flags = CLK_MESON_PLL_FIXED_FRAC_MAX,
 	},
 	.hw.init = &(struct clk_init_data) {
 		.name = "hifi_pll_dco",

-- 
2.42.0



