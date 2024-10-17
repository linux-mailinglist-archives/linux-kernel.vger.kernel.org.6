Return-Path: <linux-kernel+bounces-370702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9B79A30FB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F221F22B6F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232971D79B3;
	Thu, 17 Oct 2024 22:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9kmZI6a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EFF1D6DBE;
	Thu, 17 Oct 2024 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729205340; cv=none; b=sSG/2JV+TRsZEZ2aS1FugqH5EUi8TyAS3U7gwH2+Npacs30rJ/dy7dl4qh8+OHni9k1mdnMm2MJxnruzKTRUCiN3+G73BXSIV9Ciya6PeMH0OqXL/ucb3EhG26sz1lZgBbBoDw/k+QPSI3NaBiRSaoyAZV2/UBwKN7RfxXWQoeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729205340; c=relaxed/simple;
	bh=Iv+6OmHuMrO+YnI4hpYi4pu0LsU15h8P3GuX6Qr7+UM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ObnpLpa1hwi2PL7v8HvHNE1Gse2+9UAfZTK6UNJw3c3OauccUWa22OYZvfzPUaml6iArOk+DNeONR5gPIvmbLlL+okmKXeyAOFFjmlLXJvzUdi0/GHdAfXeg2Ec3+JUrrau4JF5t4GytazlVgyHV18JiuSJMyGcjBr/jRYb8SGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9kmZI6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7FEC4CEC7;
	Thu, 17 Oct 2024 22:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729205340;
	bh=Iv+6OmHuMrO+YnI4hpYi4pu0LsU15h8P3GuX6Qr7+UM=;
	h=From:To:Cc:Subject:Date:From;
	b=V9kmZI6aqNv4Omj7l7ixp9aldfUHsARhgLVlSM1N1j6UEco/PPP3J5BWmSJYLB5Db
	 lk/euDAKpwhJ5ppiyAb8AvykxOD2lFPYOEYGQtGFTEDnp56cdL1Pro9ZTIZUKLnAeM
	 9SSfsUQg1dGmyzoFy6DblCFv8rifalGcxc2u/+q+UHv3+dgWTTMfARqmsSR7K58Mw7
	 A+gjOOgRO+ND7vzjoc0bilM9CWBo3+bV+bU7VleUl+DpskIxNGS7NFRXf0WSPO+6o4
	 zLSyDmlPz4Lh1fSBZNluMQPFpmoIjtOTDLO/1JeoMKuIH1CS3JdBxQHmF+xW7p1rK4
	 laN834IB9EqiA==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.12-rc3
Date: Thu, 17 Oct 2024 15:48:58 -0700
Message-ID: <20241017224858.2175159-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 6b5cca7868fdd2499384e21279fdab86bfa04997:

  clk: test: Fix some memory leaks (2024-10-16 14:39:18 -0700)

----------------------------------------------------------------
Two clk driver fixes and a unit test fix:

 - Terminate the of_device_id table in the Samsung exynosautov920 clk
   driver so that device matching logic doesn't run off the end of the
   array into other memory and break matching for any kernel with this
   driver loaded

 - Properly limit the max clk ID in the Rockchip clk driver

 - Use clk kunit helpers in the clk tests so that memory isn't leaked
   after the test concludes

----------------------------------------------------------------
Jinjie Ruan (2):
      clk: samsung: Fix out-of-bound access of of_match_node()
      clk: test: Fix some memory leaks

Stephen Boyd (1):
      Merge tag 'samsung-clk-fixes-6.12' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into clk-fixes

Yao Zi (1):
      clk: rockchip: fix finding of maximum clock ID

 drivers/clk/clk_test.c                   | 61 ++++++++------------------------
 drivers/clk/rockchip/clk.c               |  2 +-
 drivers/clk/samsung/clk-exynosautov920.c |  1 +
 3 files changed, 16 insertions(+), 48 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

