Return-Path: <linux-kernel+bounces-334077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFE897D257
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0F61F21EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A9F7DA87;
	Fri, 20 Sep 2024 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NocuYjic"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA066F307;
	Fri, 20 Sep 2024 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820176; cv=none; b=PtQ3pr3idbnnAPyKI+4qkncDkwYrUX4eE5EvZZxManp2xj+YBIw7jiiRwW2cCGfH46YMge3uDYQ3CvxX5NkHa/9qDw/KGHsEgD16hWqmAktCqbPsNXqeyDHN+3b3gbAYX32Lg7d/yNzrUSrTwrIslKYjf8p6hGvyLmdDkCggJ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820176; c=relaxed/simple;
	bh=KFoyhl3w36LgJKQF6XlNX6jdkTChd706ofq02msKEhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tXDtVrdkDaVhzvkPFjHLvaoUkymwpUIAFaUtwth/6WC3GwkcNKy8YLdHvPLn9j6MjNz3LemYzrnSnenxI/7JxXrpKTgyKxR2ky8Wu7BX+kGzhvB6k7+savUpp1LjgqG6BbqElwpAY7hTPlogRPbz7ztrYBwu9eUpsCo5CE1lRlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NocuYjic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F233DC4CED8;
	Fri, 20 Sep 2024 08:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726820176;
	bh=KFoyhl3w36LgJKQF6XlNX6jdkTChd706ofq02msKEhg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NocuYjicviiHW9dkiMF1PZAPN+bOKTEV8Q/8GI/dVG4rWnrBzWMf3t/lahZSH2iy7
	 VS/32v06yE9EdLx9H+qpjXgD3j98icutMRSmYJxWIk85Pt8iQAthT+CWUIjI7/oeBQ
	 HmOHaCYWHWq5g9tESqP6uXE178bzI2/SQ64wVwrp3DZpR8aSO00L/oe7MZLmBOnetu
	 70buGgFLqBcdp4uaKx936hjQ4eCFNBEh/TGCfpaz2K7mPh9sl+eTtJ4DlYazqihHCb
	 byhDbV1jXYdfjjNeDFKzW719lTG0gIK5EwsC7C5QAl2xRROoWpeZDr1VbXUFc0ja6N
	 CzHJQS+MNsn1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90D9CF58E5;
	Fri, 20 Sep 2024 08:16:15 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 20 Sep 2024 16:16:16 +0800
Subject: [PATCH 6/6] clk: meson: s4: Delete the spinlock from the MPLL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-mpll_spinlock-v1-6-5249a9a7e2b7@amlogic.com>
References: <20240920-mpll_spinlock-v1-0-5249a9a7e2b7@amlogic.com>
In-Reply-To: <20240920-mpll_spinlock-v1-0-5249a9a7e2b7@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726820174; l=1660;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=kO2S9WluZnKsZu8WbD08FCxRfFkq+Y8JsWEudLTTuJE=;
 b=XoCk+GChXy9oiDtXd6sz8adYDgdcRqK51hXoqH8GCDNNc/qoUkYn7Gv9MKWO5M+QWeYQuOBUM
 L6QxNxGTq4kCsmICSgdLYk2oDQPdZiwAsiVXPVaK4uYGyhXIAE4IDFG
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

It is meaningless to define a spinlock in the struct meson_clk_mpll_data.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 drivers/clk/meson/s4-pll.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clk/meson/s4-pll.c b/drivers/clk/meson/s4-pll.c
index 9697f6577e06..d8e621e79428 100644
--- a/drivers/clk/meson/s4-pll.c
+++ b/drivers/clk/meson/s4-pll.c
@@ -17,8 +17,6 @@
 #include "meson-clkc-utils.h"
 #include <dt-bindings/clock/amlogic,s4-pll-clkc.h>
 
-static DEFINE_SPINLOCK(meson_clk_lock);
-
 /*
  * These clock are a fixed value (fixed_pll is 2GHz) that is initialized by ROMcode.
  * The chip was changed fixed pll for security reasons. Fixed PLL registers are not writable
@@ -547,7 +545,6 @@ static struct clk_regmap s4_mpll0_div = {
 			.shift   = 29,
 			.width	 = 1,
 		},
-		.lock = &meson_clk_lock,
 		.init_regs = s4_mpll0_init_regs,
 		.init_count = ARRAY_SIZE(s4_mpll0_init_regs),
 	},
@@ -601,7 +598,6 @@ static struct clk_regmap s4_mpll1_div = {
 			.shift   = 29,
 			.width	 = 1,
 		},
-		.lock = &meson_clk_lock,
 		.init_regs = s4_mpll1_init_regs,
 		.init_count = ARRAY_SIZE(s4_mpll1_init_regs),
 	},
@@ -655,7 +651,6 @@ static struct clk_regmap s4_mpll2_div = {
 			.shift   = 29,
 			.width	 = 1,
 		},
-		.lock = &meson_clk_lock,
 		.init_regs = s4_mpll2_init_regs,
 		.init_count = ARRAY_SIZE(s4_mpll2_init_regs),
 	},
@@ -709,7 +704,6 @@ static struct clk_regmap s4_mpll3_div = {
 			.shift   = 29,
 			.width	 = 1,
 		},
-		.lock = &meson_clk_lock,
 		.init_regs = s4_mpll3_init_regs,
 		.init_count = ARRAY_SIZE(s4_mpll3_init_regs),
 	},

-- 
2.42.0



