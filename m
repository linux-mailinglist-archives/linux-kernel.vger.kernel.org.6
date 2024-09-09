Return-Path: <linux-kernel+bounces-321131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D319714FA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EE2CB23B8D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DF91B3F08;
	Mon,  9 Sep 2024 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSHgrb4a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B681AD3EF;
	Mon,  9 Sep 2024 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876681; cv=none; b=P5twA0dsxfE7fZFQ9wxVaFneSDWo1owSqTnNqlvKBo8dJpiffcM0TA9KTRAyXvZ5WyGEFQZSIqNspk5RtIMapCIbg3RftG+l40Wi6hlKiR+BIKPIeisP2TZfs+XO+IT4ixYtre7UiFTXUi5UF1hNkEqM1vcRNlyqFanfjMbBSLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876681; c=relaxed/simple;
	bh=vvlOf3FJ8E89u5XJBz4yvALF0Sbc3Vr4gQs/Ydqc08Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q6Scq6+WR5b5d4hYSHqbZaC3X/+usMyvxQ3rE/hk98VsHMwBV31RvoUDa6Vy7kXUszm2a/TFQUt3MXHTTTOGqxbrY9XgxWzkkluEIfTMrP9y7Zn0VC0jOLT86+OI5DZ5RJlIbKs7tq+dDNl3X+okUbAzr+xNg4y6+4UY4NKw2OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSHgrb4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B21C4CEC5;
	Mon,  9 Sep 2024 10:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725876681;
	bh=vvlOf3FJ8E89u5XJBz4yvALF0Sbc3Vr4gQs/Ydqc08Y=;
	h=From:To:Cc:Subject:Date:From;
	b=OSHgrb4aOuuyefGW9wRDf5QC77+H/qhDFCoJQjzlZXZMpRqg3G9l8NNHyplKMjy8t
	 Jcdnj5uGNcd3hmBrZzO3U2nzJQrnpA2v00FyvyqSHRs7KLxigckzIuOrPDfjEKR+B7
	 iM2KRWNwAGiOILId4ZKj9vPj21F2H8o1OIJMBWn4QUnQTgtGXxpqR+js+0bbEsWp+z
	 Ko0JnY8VyLBLYRsQnQGfAgxGZKUOMuWoiMmeJ1LQW7WhHPEZNvrzmtjnuvUgcav+s8
	 j13mR/NPHFXnHd76Ii2gQeCjyepu81nrQsk6nO7nDw/FOYAHZn7csjAIwX1/QDYXIx
	 WZHmHTYYCVNCg==
From: Arnd Bergmann <arnd@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	YouMin Chen <cym@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Sugar Zhang <sugar.zhang@rock-chips.com>,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: rockchip: remove unused mclk_pdm0_p/pdm0_p definitions
Date: Mon,  9 Sep 2024 12:11:05 +0000
Message-Id: <20240909121116.254036-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When -Wunused-const-variable is enabled (not the default),
there is a warning about two definitions in this file:

In file included from drivers/clk/rockchip/clk-rk3576.c:14:
drivers/clk/rockchip/clk-rk3576.c:334:7: error: 'mclk_pdm0_p' defined but not used [-Werror=unused-const-variable=]
  334 | PNAME(mclk_pdm0_p)                      = { "mclk_pdm0_src_top", "xin24m" };
      |       ^~~~~~~~~~~
drivers/clk/rockchip/clk.h:564:43: note: in definition of macro 'PNAME'
  564 | #define PNAME(x) static const char *const x[] __initconst
      |                                           ^
drivers/clk/rockchip/clk-rk3576.c:333:7: error: 'pdm0_p' defined but not used [-Werror=unused-const-variable=]
  333 | PNAME(pdm0_p)                           = { "clk_pdm0_src_top", "xin24m" };
      |       ^~~~~~
drivers/clk/rockchip/clk.h:564:43: note: in definition of macro 'PNAME'
  564 | #define PNAME(x) static const char *const x[] __initconst
      |                                           ^

Remove them for the moment. If they are needed later, they can
be added back at that point.

Fixes: cc40f5baa91b ("clk: rockchip: Add clock controller for the RK3576")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/rockchip/clk-rk3576.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3576.c b/drivers/clk/rockchip/clk-rk3576.c
index 4de05b208771..595e010341f7 100644
--- a/drivers/clk/rockchip/clk-rk3576.c
+++ b/drivers/clk/rockchip/clk-rk3576.c
@@ -330,8 +330,6 @@ PNAME(mclk_sai7_8ch_p)			= { "mclk_sai7_8ch_src", "sai1_mclkin" };
 PNAME(mclk_sai8_8ch_p)			= { "mclk_sai8_8ch_src", "sai1_mclkin" };
 PNAME(mclk_sai9_8ch_p)			= { "mclk_sai9_8ch_src", "sai1_mclkin" };
 PNAME(uart1_p)				= { "clk_uart1_src_top", "xin24m" };
-PNAME(pdm0_p)				= { "clk_pdm0_src_top", "xin24m" };
-PNAME(mclk_pdm0_p)			= { "mclk_pdm0_src_top", "xin24m" };
 PNAME(clk_gmac1_ptp_ref_src_p)		= { "gpll", "cpll", "gmac1_ptp_refclk_in" };
 PNAME(clk_gmac0_ptp_ref_src_p)		= { "gpll", "cpll", "gmac0_ptp_refclk_in" };
 PNAME(dclk_ebc_p)			= { "gpll", "cpll", "vpll", "aupll", "lpll_dummy",
-- 
2.39.2


