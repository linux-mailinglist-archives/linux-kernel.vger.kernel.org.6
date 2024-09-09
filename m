Return-Path: <linux-kernel+bounces-321124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AA69714E9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C517B21D6F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0861B3F3A;
	Mon,  9 Sep 2024 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHnOH4k4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58DD1B3B2B;
	Mon,  9 Sep 2024 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876557; cv=none; b=FU95KNXskkcnT6yFNnm5uKLDBkIOqrSLVQlFaeBJSyPO7O56VNZlF4KSQP8rO3hBHEAJZ1TqBW2F1/L9qkJoappdHt3uPkirnkGZUM0/v+RjbznEs7YKNFOBYspJDV3Xl6VwEepE9L03wf2Xz0NXsSQPqypUUQZ7I2XRFeFVHnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876557; c=relaxed/simple;
	bh=RkUWT/0arfso8PoZuHXKVk1Cw40RK964zYOKCHpr3nE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c6M83fFjRWqTudDhpzsrs8OqwuWKyRdVD19jbWINdcONfI3IlRjPICAw/4k+zmURjxapg2T4M9UcpHvZsezE0o77OvpWXSZK8jHG6O41bpQ6jxKitBL/h8+Mlst8Wk8Ty8nDMEs2d1pGJx4GRvTujJMq7fTlTO17oX9Al3GJGRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHnOH4k4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61337C4CEC8;
	Mon,  9 Sep 2024 10:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725876557;
	bh=RkUWT/0arfso8PoZuHXKVk1Cw40RK964zYOKCHpr3nE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EHnOH4k4ZdZj7SxH1Niavu5KXKFCh02h94MH3UcaYiXKHUSywi84ReEY4czfIYVQh
	 47f0B75OGH6xPtcZg6LZUAXE6XCpDPxhk9r2VuCsLLrDYhkz3zo5ifi7v5/2el0mjr
	 SLA8fzJPRQPc+c89YHZMLI+3TF5MyxkHARsIW5YeHw3aTef8j1X5nxeBhct5cwZFUZ
	 /iS1HgcxR4n0+GDYvx1evlvud5OnTjghoJC1iHQ+SiLNZ0swsTIOZOOglk83JefK2T
	 WiMkwoUiinSFlF4DHZybJevCq/PwZj9yng7rzp5QS9AVmyaFB4jHWTjfabAZklkdUB
	 CZNCIcaKZzVQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB12ECE579;
	Mon,  9 Sep 2024 10:09:17 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Mon, 09 Sep 2024 18:08:56 +0800
Subject: [PATCH v3 1/3] clk: meson: Support PLL with fixed fractional
 denominators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240909-fix_clk-v3-1-a6d8f6333c04@amlogic.com>
References: <20240909-fix_clk-v3-0-a6d8f6333c04@amlogic.com>
In-Reply-To: <20240909-fix_clk-v3-0-a6d8f6333c04@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725876555; l=1833;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=tm+eqZ6z2/fu+O9mUT6fjnN7chLjmdHoODAhOfI/R44=;
 b=U11cPwwTOmhBwh26n/Uf/6HYS90n2Yjr6nBrNusbctnjBVmkncO4x1YgCC6W4bb8CpHU6PAXJ
 FDIVkNCLdYHAyfiGCt9F3/9ZnyZv7DL6hWUl2tTSf0Oti+fqY3IWf+I
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
index bc570a2ff3a3..89f0f04a16ab 100644
--- a/drivers/clk/meson/clk-pll.c
+++ b/drivers/clk/meson/clk-pll.c
@@ -57,12 +57,13 @@ static unsigned long __pll_params_to_rate(unsigned long parent_rate,
 					  struct meson_clk_pll_data *pll)
 {
 	u64 rate = (u64)parent_rate * m;
+	unsigned int frac_max = pll->frac_max ? pll->frac_max :
+						(1 << pll->frac.width);
 
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
+	unsigned int frac_max = pll->frac_max ? pll->frac_max :
+						(1 << pll->frac.width);
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



