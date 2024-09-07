Return-Path: <linux-kernel+bounces-319902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A945970392
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 20:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04B91F222FB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 18:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3358165EFB;
	Sat,  7 Sep 2024 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okZUxg7z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324E92E634;
	Sat,  7 Sep 2024 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725733553; cv=none; b=ODSV348sKis6RnEHhTuDZuPCRIrVx9wMg3H7FiGyjOFfKZYmqjlmcHQHSJ7hS5wAzHGKD0SpLqyrF/0NXHpcKVHeDj/nk9VBU64RwLI1VGS0iXSEqAYfbmo87gU4hC/Ed7S19tXgGnuDbAIcmKkzsycoeNg2AXl2q+EKdGdDLms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725733553; c=relaxed/simple;
	bh=XARaDRAkR4sOntqRK+SXz1Qd0JJ/hcAkRh+k6gHp/sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nYIs41TGdQm6hmYhYAx6+BVBSrQsFp1EkUf8o4PL+LhTi9YSI4EyPFJzwPiCd0B/m8w6qLuQ6FoIcTV1Mw1KTM3reglD6PnKkVvpOIg5u/8KWxtaa5hY/9ivIwTdtl9ETrC/cspDvrVBRQqxfiLAvZcmTYYo9mhM2O8Fx4zgpak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okZUxg7z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75364C4CEC2;
	Sat,  7 Sep 2024 18:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725733552;
	bh=XARaDRAkR4sOntqRK+SXz1Qd0JJ/hcAkRh+k6gHp/sg=;
	h=From:To:Cc:Subject:Date:From;
	b=okZUxg7z6Lhxa5d5C/6WSQnoKn73AXyLemkJAmxSDSbscIBouwXqKJ+SHN2CNKJvs
	 CAVNDHRYIavRq4HUtrAwIAuBzww8y6N+7ZGFms/hY5Tzo5p8MI7JQtQVwvbOU7se7K
	 GAcIT4U4OnCKZjlqxSNghYZ96hp1sEFz2BX9NzZO/qX7EB4/x37U56Ys1uvqWgqkAL
	 AseGDu9MrqsFmabURx4wGw/g1cMX2Fvs6zbzecgNvSkl/VOjUTzIuz8u47nR3xcERl
	 95NtbyIjpZIzo2E3YYfD1P1w4JqYx5zOkSMee9rWvHj2xXnErXZ9u/PW4ilCdp4GsF
	 ejku3+ZHXizhw==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.11-rc6
Date: Sat,  7 Sep 2024 11:25:48 -0700
Message-ID: <20240907182551.128901-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 39a3396558fb97e6e7d4c1eb04c2166da31904a9:

  clk: thead: fix dependency on clk_ignore_unused (2024-07-31 14:51:47 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 71c03a8cb213d267853e0d9f520c972480960544:

  clk: qcom: gcc-sc8280xp: don't use parking clk_ops for QUPs (2024-09-03 13:01:34 -0700)

----------------------------------------------------------------
A pile of Qualcomm clk driver fixes with two main themes: the alpha PLL
driver and shared RCGs, and one fix for the Starfive JH7110 SoC.

 - The Alpha PLL clk_ops had multiple problems around setting rates.
   There are a handful of patches here that fix masks and skip enabling
   the clk from set_rate() when the PLL is disabled. The PLLs are
   crucial to operation of the system as almost all frequencies in the
   system are derived from them.

 - Parking shared RCGs at a slow always on clk at registration time
   breaks stuff. USB host mode can't handle such a slow frequency and
   the serial console gets all garbled when the UART clk is handed over
   to the kernel. There's a few patches that don't use the shared
   clk_ops for the UART clks and another one to skip parking the USB clk
   at registration time.

 - The Starfive PLL driver used for the CPU was busted causing cpufreq
   to fail because the clk didn't change to a safe parent during
   set_rate(). The fix is to register a notifier and switch to a safe
   parent so the PLL can change rate in a glitch free manner.

----------------------------------------------------------------
Abel Vesa (1):
      clk: qcom: gcc-x1e80100: Fix USB 0 and 1 PHY GDSC pwrsts flags

Bryan O'Donoghue (1):
      clk: qcom: gcc-x1e80100: Don't use parking clk_ops for QUPs

Johan Hovold (1):
      clk: qcom: gcc-sc8280xp: don't use parking clk_ops for QUPs

Neil Armstrong (1):
      clk: qcom: gcc-sm8650: Don't use shared clk_ops for QUPs

Satya Priya Kakitapalli (4):
      clk: qcom: clk-alpha-pll: Fix the pll post div mask
      clk: qcom: clk-alpha-pll: Fix the trion pll postdiv set rate API
      clk: qcom: clk-alpha-pll: Fix zonda set_rate failure when PLL is disabled
      clk: qcom: clk-alpha-pll: Update set_rate for Zonda PLL

Stephen Boyd (3):
      Merge tag 'qcom-clk-fixes-for-6.11' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-fixes
      clk: qcom: gcc-sm8550: Don't use parking clk_ops for QUPs
      clk: qcom: gcc-sm8550: Don't park the USB RCG at registration time

Xingyu Wu (1):
      clk: starfive: jh7110-sys: Add notifier for PLL0 clock

devi priya (1):
      clk: qcom: ipq9574: Update the alpha PLL type for GPLLs

 drivers/clk/qcom/clk-alpha-pll.c               | 25 ++++++++++--
 drivers/clk/qcom/clk-rcg.h                     |  1 +
 drivers/clk/qcom/clk-rcg2.c                    | 30 ++++++++++++++
 drivers/clk/qcom/gcc-ipq9574.c                 | 12 +++---
 drivers/clk/qcom/gcc-sc8280xp.c                | 48 +++++++++++-----------
 drivers/clk/qcom/gcc-sm8550.c                  | 54 ++++++++++++-------------
 drivers/clk/qcom/gcc-sm8650.c                  | 56 +++++++++++++-------------
 drivers/clk/qcom/gcc-x1e80100.c                | 52 ++++++++++++------------
 drivers/clk/starfive/clk-starfive-jh7110-sys.c | 31 +++++++++++++-
 drivers/clk/starfive/clk-starfive-jh71x0.h     |  2 +
 10 files changed, 196 insertions(+), 115 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

