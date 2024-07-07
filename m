Return-Path: <linux-kernel+bounces-243681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE406929932
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 19:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22F32815FE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 17:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260B655897;
	Sun,  7 Jul 2024 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ug5Hyrr1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62697376E0;
	Sun,  7 Jul 2024 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720374960; cv=none; b=YJ300GOsmaXbHCIXAhXDr1NBUAGUx8o0AOSGdhJzGeM0mbxon2hpiLBR5f4IBrznhTZlkFgk/umbs4lmg7P2j9T8WzLa36GYDHgJ/0M8mVN/g73x1sCRlNSQj7cUHAPS6l8lr0HwS0KGuOSlIklnNCwvyoxiLPJBe04Duu7ZJYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720374960; c=relaxed/simple;
	bh=tCtzvIADdB8zhgu5nlKpUyUKWSyi/Efze9E/Z4YX6oA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lVQhiFAYih5sZpXANH9v8l/DHRtsZ8FeNzr5Vxi5Sq4tIqXKaMwPs9bj6mqn/5DdEtocTlpe+IhdUmc9Vx1N+/nACrANaNBRIxr8b2/+pL+2MZ61URzYYUANNRhAEFTQYK0trNBUQ9IICNP4C2pJujRDq2n4j3/FCJVG47GjJhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ug5Hyrr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E75C3277B;
	Sun,  7 Jul 2024 17:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720374959;
	bh=tCtzvIADdB8zhgu5nlKpUyUKWSyi/Efze9E/Z4YX6oA=;
	h=From:To:Cc:Subject:Date:From;
	b=Ug5Hyrr1o4GFLMRYpODBkeDRNnms4fj0A0EV2Hs8HvN6WY05xse/McpVlSW0re59H
	 DcuzrT4ZRVBmQy6nBT6AffTsiC4e7vWiqQqOwZTvCirJdGVJ/znaX/ClxemDpHRW//
	 hgJ0KZ/r2W5nGV5THLhVrbniq2LF7HYbNX+mxwzyg5ghOYtbmwUKbadn2NdpgGR3/D
	 Y07O/fLMm+CVepo96z2d0qh34Iu6L9GuG9glEv38tUGT/Ql4BeNbDHRhDLYzc7WwYr
	 TTpffuoj/t08qKxkG2v5tDZzokZ00sp9VyrXuN9trA8IQBbgWNAEPULc8ZajumxLH1
	 0fmHrLpRncn2w==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.10-rc6
Date: Sun,  7 Jul 2024 10:55:58 -0700
Message-ID: <20240707175558.480229-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 2607133196c35f31892ee199ce7ffa717bea4ad1:

  clk: sifive: Do not register clkdevs for PRCI clocks (2024-05-29 12:31:02 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 10f84de27bd05bd2648512975d085dbe0a1e71c3:

  Merge tag 'qcom-clk-fixes-for-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-fixes (2024-07-02 12:03:15 -0700)

----------------------------------------------------------------
A set of clk fixes for the Qualcomm, Mediatek, and Allwinner drivers:

 - Fix the Qualcomm Stromer Plus PLL set_rate() clk_op to explicitly set
   the alpha enable bit and not set bits that don't exist
 - Mark Qualcomm IPQ9574 crypto clks as voted to avoid stuck clk
   warnings
 - Fix the parent of some PLLs on Qualcomm sm6530 so their rate is
   correct
 - Fix the min/max rate clamping logic in the Allwinner driver that got
   broken in v6.9
 - Limit runtime PM enabling in the Mediatek driver to only
   mt8183-mfgcfg so that system wide resume doesn't break on other
   Mediatek SoCs

----------------------------------------------------------------
Frank Oltmanns (1):
      clk: sunxi-ng: common: Don't call hw_to_ccu_common on hw without common

Gabor Juhos (2):
      clk: qcom: clk-alpha-pll: set ALPHA_EN bit for Stromer Plus PLLs
      clk: qcom: apss-ipq-pll: remove 'config_ctl_hi_val' from Stromer pll configs

Luca Weiss (1):
      clk: qcom: gcc-sm6350: Fix gpll6* & gpll7 parents

Md Sadre Alam (1):
      clk: qcom: gcc-ipq9574: Add BRANCH_HALT_VOTED flag

Pin-yen Lin (1):
      clk: mediatek: mt8183: Only enable runtime PM on mt8183-mfgcfg

Stephen Boyd (2):
      Merge tag 'sunxi-clk-fixes-for-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-fixes
      Merge tag 'qcom-clk-fixes-for-6.10' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-fixes

 drivers/clk/mediatek/clk-mt8183-mfgcfg.c |  1 +
 drivers/clk/mediatek/clk-mtk.c           | 24 ++++++++++++++----------
 drivers/clk/mediatek/clk-mtk.h           |  2 ++
 drivers/clk/qcom/apss-ipq-pll.c          |  2 --
 drivers/clk/qcom/clk-alpha-pll.c         |  3 +++
 drivers/clk/qcom/gcc-ipq9574.c           | 10 ++++++----
 drivers/clk/qcom/gcc-sm6350.c            | 10 +++++-----
 drivers/clk/sunxi-ng/ccu_common.c        | 18 ++++++++++++------
 8 files changed, 43 insertions(+), 27 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

