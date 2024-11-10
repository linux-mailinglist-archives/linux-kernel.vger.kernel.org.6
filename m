Return-Path: <linux-kernel+bounces-403384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F949C34D2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 22:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887E21F21213
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 21:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39719156F55;
	Sun, 10 Nov 2024 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dd5R/p2r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8515814B075;
	Sun, 10 Nov 2024 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731275517; cv=none; b=YSvhkeEsvRkkmYhK8SWzAsvo57z2zMdQltoGDuNzyS7YF+xFj/Z5YWYYNPYCdwupfd8rI70KMhpBdK822W86cDtoM1/CIKniLtscD9Z6JZ39834fYeesbr19ptKENxL/5oAtDsFWOkm3qSSbVl6xbeMnxgwBQVACiofNeJqEddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731275517; c=relaxed/simple;
	bh=NAUNrPUxX5H90AZKzKdY4k0TnPede6p8yPkOjrkiGH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=umKBAhvDDyc6LWUO0k2qck7q8t9cvU4OV8XEtIqmQgsLtYVw0r8BDvGPQXazH2jI4kpoWZP5wHoot1rAD8hGGuy5Qv9SY1s95xQ8k45W1hD4ZpcvVyqnO+dto8HuybWcmeDpMNY6TOhFaLG/ct5cG/LfLNK92Jtlm7LA+fjbMFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd5R/p2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F8FC4CECD;
	Sun, 10 Nov 2024 21:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731275517;
	bh=NAUNrPUxX5H90AZKzKdY4k0TnPede6p8yPkOjrkiGH4=;
	h=From:To:Cc:Subject:Date:From;
	b=dd5R/p2rW5NrmIORuNreqCJYsgpm79AmgomrGj7RCR17cIOi7NhmCyjoLHKkZYhrJ
	 55Mq/df+yzSVmYrDpDfNfUgyPGUJeLvcB6R0b3QhuqO43xa2uPGIYVT7lgM77XNzLk
	 37VB9PwL0ASW9d/UGfbXzU415UbQpbDiSIH/7+aJxmg2Mt3Yi9HLfHKy1O0Fb27vWR
	 h8RXv5dapFmPwZvI5qCMsrCLr+Y0sYXZsHWk3eVJVTmuAkS4d6ge9Mi83HhxZDQjSF
	 Y/0XJHMOdSpefqh7EN3ACop0Soe1tlPkCM2KG/ah6+LXJU+55fTO/RtRjsShUZkz6b
	 8xSWetfdgaGiQ==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.12-rc6
Date: Sun, 10 Nov 2024 13:51:55 -0800
Message-ID: <20241110215155.505460-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 6b5cca7868fdd2499384e21279fdab86bfa04997:

  clk: test: Fix some memory leaks (2024-10-16 14:39:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 714398d8742d5e019a8e5512de2abb8db69ba0a3:

  Merge tag 'qcom-clk-fixes-for-6.12' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-fixes (2024-11-05 15:32:08 -0800)

----------------------------------------------------------------
A handful of Qualcomm clk driver fixes:

 - Correct flags for X Elite USB MP GDSC and pcie pipediv2 clocks
 - Fix alpha PLL post_div mask for the cases where width is not
   specified
 - Avoid hangs in the SM8350 video driver (venus) by setting HW_CTRL
   trigger feature on the video clocks

----------------------------------------------------------------
Abel Vesa (1):
      clk: qcom: gcc-x1e80100: Fix USB MP SS1 PHY GDSC pwrsts flags

Barnabás Czémán (1):
      clk: qcom: clk-alpha-pll: Fix pll post div mask when width is not set

Johan Hovold (1):
      clk: qcom: videocc-sm8350: use HW_CTRL_TRIGGER for vcodec GDSCs

Qiang Yu (1):
      clk: qcom: gcc-x1e80100: Fix halt_check for pipediv2 clocks

Stephen Boyd (1):
      Merge tag 'qcom-clk-fixes-for-6.12' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into clk-fixes

 drivers/clk/qcom/clk-alpha-pll.c  |  2 +-
 drivers/clk/qcom/gcc-x1e80100.c   | 12 ++++++------
 drivers/clk/qcom/videocc-sm8350.c |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

