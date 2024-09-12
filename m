Return-Path: <linux-kernel+bounces-327410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63979977598
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE532819C3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1AF1C2DA6;
	Thu, 12 Sep 2024 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxIXWoZc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D8619F12B;
	Thu, 12 Sep 2024 23:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183911; cv=none; b=eyd6l+xcaG9a6ZK/hWF8Ds1LqL0Z8aapC3SYr3KC0dQcVJZNj90UQIav6qnJdG+8tGRosaNPx/zxv9CpmctDf4QJ2wWyZcyznLUcX2gond5uu2thGq8d8zlx0qq6evXkLbltGKlKdarirAv7NfERu9L3gk4ul9p0iSV7IjMjLDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183911; c=relaxed/simple;
	bh=Z9JSzBM8cUSMozMvf6HU9FhqYubxNBiiPQOmpIc7w7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AaVp/5SA2ot7FzxyySiDM0r0EOvcgxotAlp91QkV0bHLuqMBH0Uoxs1TPTD0mjKp+Gaf5D5fdwsPNvsescIdrYTOxmMInzDJxtJlsdraJJkt/vJSuu1vD5fi4SqkAizeO/NvsYzX+fmyqNFYSPORLZfytIq8nHJAE1DnM1M2Ga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxIXWoZc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6514DC4CEC3;
	Thu, 12 Sep 2024 23:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726183910;
	bh=Z9JSzBM8cUSMozMvf6HU9FhqYubxNBiiPQOmpIc7w7k=;
	h=From:To:Cc:Subject:Date:From;
	b=JxIXWoZctvIb4DUfEKxvD2ByCiMY9wxJ6s5aYHMFQ3YNjk1NyaJNg3nb/vUYRZ6I0
	 SORd7BdLpyXrK1ZFWpnQ7c5LYxGa7KInaQ8bloWTTfjSY61RKBF437pmG2QJqYr3+n
	 lk40DYY5SBM2E5SFgBTQ8/rl0Js+F0QJ6/Hnu7UEWllZXMAHQZBfbAv0HZOz0j1v6W
	 BjeinMcoDC664zELxZNy4oH4pBiGF09aXDepu8wX5VWUseSXXE45gwqwCis8PU0Iev
	 KGayqAJT3pcTsCPEZqciE7vnr98PKRLD82Vij07YJClRTtT1AJSeegzDwIP5XfO2A4
	 G1CsQcmb9z7pg==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.11-rc7
Date: Thu, 12 Sep 2024 16:31:47 -0700
Message-ID: <20240912233149.1923482-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 71c03a8cb213d267853e0d9f520c972480960544:

  clk: qcom: gcc-sc8280xp: don't use parking clk_ops for QUPs (2024-09-03 13:01:34 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to a4d89b11aca3ffa73e234f06685261ce85e5fb41:

  clk: qcom: clk-alpha-pll: Simplify the zonda_pll_adjust_l_val() (2024-09-09 14:06:07 -0700)

----------------------------------------------------------------
One build fix for 32-bit arches using the Qualcomm PLL driver. It's
cheaper to use a comparison here instead of a division so we just do
that to fix the build.

----------------------------------------------------------------
Satya Priya Kakitapalli (1):
      clk: qcom: clk-alpha-pll: Simplify the zonda_pll_adjust_l_val()

 drivers/clk/qcom/clk-alpha-pll.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

