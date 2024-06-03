Return-Path: <linux-kernel+bounces-198952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C080E8D7FA0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BDB728D595
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44285823A6;
	Mon,  3 Jun 2024 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jitBqWF1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FEC7E796;
	Mon,  3 Jun 2024 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717409077; cv=none; b=IPvmU9ztC57nEmn4TEyPVl8qkbW7Qon5gU5C0kdBPE5RXB/vNVnBM6/erXORA9ArZdAKcQphv8ixyngSHyDRWlNSv/PsSgb8mvx4p6QEfk/RTrOCAZG6xUnDbuMwgs/dD8hEExTzRAoX8tADV5EGeXblhUdhjf/1Z4OnTnbSjCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717409077; c=relaxed/simple;
	bh=Wlp7cZUIlE4IOHsusBnYh5vU2mzpL9FERd+nACxXsNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UewtMI66+QzqNePQaPlWoT61VlaUQmvLG0+SGxGv/Tc6DWhGK4wGPAlxjyrbGhNrbYhAvmm+9I/1kTPNWFTWbuOa4SAvSFgQzi54jJFQbM3MghdtKssCcSRq32UQzOVizg614GEdDQUrM6bTKfjt3agSDwZA4q9nihL947vmrfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jitBqWF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3BE1C2BD10;
	Mon,  3 Jun 2024 10:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717409077;
	bh=Wlp7cZUIlE4IOHsusBnYh5vU2mzpL9FERd+nACxXsNk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=jitBqWF1HmyfocksqKrVWvoUdLzYHte1P62IPlwRvfzXXcj+S+Ew3u5pSPaWdaPqC
	 TnDYquRgSjqKGrddFCEt7XSQ2cu5R1FDLVNrI8HO+NJ4M7EQof9EPK/ATJ8PRsLXYI
	 19qmKeJBi2NkOyLWdIMmyOSP2tCMrawtG9YrDEO4G9FzMfqjlDJHj0fPqvnfP3hANW
	 BrPlGxBnGwWfVQhdCf/hCRbjjoXK2VyZThPXUOTq2ZISjEA1N7gooblakjh0z3oZPZ
	 AbfyUkJVJvQMLuOJKYLmKsjRanem+wocNewNB2m5Yx6jyx1zCDLIMBMSvl74XkSBpQ
	 9ZV3CNB1BrPlA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9170C27C44;
	Mon,  3 Jun 2024 10:04:36 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 03 Jun 2024 18:04:33 +0800
Subject: [PATCH] clk: meson: s4: fix fixed_pll_dco clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-s4_fixedpll-v1-1-2b2a98630841@amlogic.com>
X-B4-Tracking: v=1; b=H4sIADCVXWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwNj3WKT+LTMitSUgpwcXWNLo6QkM6PUZEtzCyWgjoKiVJAcyLTo2Np
 aAPgIUCtdAAAA
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Yu Tu <yu.tu@amlogic.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717409074; l=969;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=SOD0rIzjB9of1yjvijBbI9sErwBPGjkFM4JLYIAkE/M=;
 b=EWCSOcnNVVrdnL4wLFgNl2+yIEH8TlQrvcy01wiM/tm0IMyHU3b5njMf9swxD3EF8sp0fC7I7
 SQIYVaOz7myArhV3xPZMCbNAf8qNc/P/MP4qsyCyZEF6SHCnNBeF3vx
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

The fixed_pll_dco output frequency is not accurate,
add frac factor for fixed_pll_dco clk to fix it.

Fixes: 57b55c76aaf1 ("clk: meson: S4: add support for Amlogic S4 SoC peripheral clock controller")
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/clk/meson/s4-pll.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/meson/s4-pll.c b/drivers/clk/meson/s4-pll.c
index 8dfaeccaadc2..47c0c105e32d 100644
--- a/drivers/clk/meson/s4-pll.c
+++ b/drivers/clk/meson/s4-pll.c
@@ -38,6 +38,11 @@ static struct clk_regmap s4_fixed_pll_dco = {
 			.shift   = 0,
 			.width   = 8,
 		},
+		.frac = {
+			.reg_off = ANACTRL_FIXPLL_CTRL1,
+			.shift   = 0,
+			.width   = 17,
+		},
 		.n = {
 			.reg_off = ANACTRL_FIXPLL_CTRL0,
 			.shift   = 10,

---
base-commit: ba535bce57e71463a86f8b33a0ea88c26e3a6418
change-id: 20240603-s4_fixedpll-392bb62ec978

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



