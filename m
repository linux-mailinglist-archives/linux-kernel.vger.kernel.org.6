Return-Path: <linux-kernel+bounces-263660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3B293D8CF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7C01F22D5C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E196026A;
	Fri, 26 Jul 2024 18:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNAfXJpZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA5B3BBC1;
	Fri, 26 Jul 2024 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722020237; cv=none; b=Cc0sqpaopJK7Y0ACVVI7f0Ta1haAHF5qZv4EPkR9R10vACA5YcYUlw0Pib/8sDlfhPt2IUvFAxqhG14a6GgD5WT1x108VRvlWlpxZZRwoJRlp5+OhS7qNf/20RII7eh9zVDJs3OLrZlWmIeBlUoN4CYozGHs+HepwqgUO/NuBlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722020237; c=relaxed/simple;
	bh=VPARTokuI49hwdCTuZE5J9fKaft2WQrXZnJAoM3nQ0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d46ZpduMOMV65ixOiVftdiF3yJw9nZ5dLkpdefAajxt1nP/UuVDZAOP0FXsCWpwpseLZ2lmV1aPQhkM238l1m2hjuLTs/70+ctR7vkdolOt84AldJYCIvOckD6IZxdi/NWOCLzxX0uFMchqL1Hqv/8FbJnVU8KngtHiP+G5fjl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNAfXJpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B007C32782;
	Fri, 26 Jul 2024 18:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722020236;
	bh=VPARTokuI49hwdCTuZE5J9fKaft2WQrXZnJAoM3nQ0s=;
	h=From:To:Cc:Subject:Date:From;
	b=QNAfXJpZMgjIMf9NKa4asjosQ0Z1aZJfiJ9881Sbu1uLXEZDEV0SCKT64LkvpCdg+
	 CxeSEJjkswgrpthEAaoyzKgJOhlxwK0hst7+RNriMdIfOoXrvGgHTWOJGggYK4NWi2
	 xQHHEEJkqHm6KFVNGWOYTGJORtt5p/MQAANj98lvp2r52UiVuOn58qqohunBNWjKsU
	 6FZSst9fl5ywCk6Wz7lD5z80EPnni3WJ50h8q4PwWOCXrxZClUl5A6o9NGoCKwfCpT
	 xYP/HqYHBy0mr2MjArbaZyAC5yxPIERAROEDnVcas9noIe5N6KBNz3rFg5ki3DTI3G
	 IWBDepurmpZvg==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for the merge window
Date: Fri, 26 Jul 2024 11:57:14 -0700
Message-ID: <20240726185715.3655728-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 589eb11498fbf7de7a1bc8ff1f4b7592687dfd46:

  Merge branches 'clk-qcom', 'clk-rockchip', 'clk-sophgo' and 'clk-thead' into clk-next (2024-07-16 11:24:25 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to f99b3feb3b0e9fca2257c90fc8317be8ee44c19a:

  clk: samsung: fix getting Exynos4 fin_pll rate from external clocks (2024-07-23 11:29:23 -0700)

----------------------------------------------------------------
A few clk driver fixes for the merge window to fix the build and boot on
some SoCs.

 - Initialize struct clk_init_data in the TI da8xx-cfgchip driver so
   that stack contents aren't used for things like clk flags leading to
   unexpected behavior

 - Don't leak stack contents in a debug print in the new Sophgo clk
   driver

 - Disable the new T-Head clk driver on 32-bit targets to fix the build
   due to a division

 - Fix Samsung Exynos4 fin_pll wreckage from the clkdev rework done last
   cycle by using a struct clk_hw directly instead of a struct clk
   consumer

----------------------------------------------------------------
Bastien Curutchet (1):
      clk: davinci: da8xx-cfgchip: Initialize clk_init_data before use

Dan Carpenter (1):
      clk: sophgo: clk-sg2042-pll: Fix uninitialized variable in debug output

Krzysztof Kozlowski (1):
      clk: samsung: fix getting Exynos4 fin_pll rate from external clocks

Palmer Dabbelt (1):
      clk: T-Head: Disable on 32-bit Targets

 drivers/clk/davinci/da8xx-cfgchip.c |  4 ++--
 drivers/clk/samsung/clk-exynos4.c   | 13 +++++++------
 drivers/clk/sophgo/clk-sg2042-pll.c |  2 +-
 drivers/clk/thead/Kconfig           |  1 +
 4 files changed, 11 insertions(+), 9 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

