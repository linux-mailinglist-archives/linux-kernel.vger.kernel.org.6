Return-Path: <linux-kernel+bounces-560578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF0CA606C0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 01:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5195419C41BC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 00:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE50D530;
	Fri, 14 Mar 2025 00:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ar98Jctd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63B44C8F;
	Fri, 14 Mar 2025 00:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741913712; cv=none; b=JSeg4MybY2W5ImpxH1S8ks6rvGm4trH82pDFR/0yD0S7DwgcfdTaZzHN4kofou+2Wu1nRNV/tTA21/C1/0QIkI+A9rSI7QA+cqP2RUUXPkwiSxK+jcba0DEn48bcp2nx2kZvJK5HyVRuG1K3ideeD81Y/0ncqlKVpaQfq4IRiaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741913712; c=relaxed/simple;
	bh=xiymOwGdpiolvxSpo7Wc6Qj4/3bVL26RjucPZbihx6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p36P9aTtwDDSpDtS0zXFCNjg8S6OPVtrBS2YXmYciI+BgIddj97zCxqXe0Y8UZuenim6geoIoVoMD3RAjMULhT43Trj/pq6INDfs1Izttrglrq2bO5qZKYTzeBJKvrP3BmCYtJ0w3deqBUUnHDxhdq0TPc+WvIovsOV8ES3UmGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ar98Jctd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0045BC4CEDD;
	Fri, 14 Mar 2025 00:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741913712;
	bh=xiymOwGdpiolvxSpo7Wc6Qj4/3bVL26RjucPZbihx6s=;
	h=From:To:Cc:Subject:Date:From;
	b=Ar98JctdXNu7QRSMtiH7m0xRPs6m1fV3Uat8DhDc/fVHyYGBbNAc8uUJgCwGPNfHz
	 Hfp6yY78SXlPsD3s3gSkkof5y9iIAjfxeI4TrqrRU6muKIDgJvbI8FPaiSTlLiz4yK
	 DOnfoKN4RSZLmCHITVo8W91lSIHy5/0BLwSG3DMvtPUY3/Iow8QkeugbzDmeQwtXMp
	 fyb1PRpczW3N1/3kDNQUqD0YAcFpk8EBEebId924T5yECTarCg1bADoKeRujacbyQF
	 wpBdhcmghsvgmB6WpveNEZrpuedYYO7kgyIf/M39Wh4fByhbd7OJRw83eXc9Dfa3i4
	 XxvdCHAQFdZTw==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.14-rc6
Date: Thu, 13 Mar 2025 17:55:10 -0700
Message-ID: <20250314005511.1022757-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 54493279312f9e6edf64173681cb18d1df4297c1:

  Merge tag 'samsung-clk-fixes-6.14' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into clk-fixes (2025-03-11 10:51:13 -0700)

----------------------------------------------------------------
A few clk driver fixes for Samsung and Qualcomm clk drivers

 - Suspend on Google GS101 crashes when trying to save some clk
   registers that we shouldn't be saving so we don't do that anymore

 - The PLL lock time was wrong on the Tesla FSD which could lead to the
   PLL never locking

 - Qualcomm's display clk controller on SM8750 was trying to change the
   frequency of a parent clk for the DSI device when it should have
   stopped and adjusted the divider. The failure is that the clk
   frequency was half what was expected, leading to broken display.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      clk: qcom: dispcc-sm8750: Drop incorrect CLK_SET_RATE_PARENT on byte intf parent

Peter Griffin (1):
      clk: samsung: gs101: fix synchronous external abort in samsung_clk_save()

Stephen Boyd (1):
      Merge tag 'samsung-clk-fixes-6.14' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into clk-fixes

Varada Pavani (1):
      clk: samsung: update PLL locktime for PLL142XX used on FSD platform

 drivers/clk/qcom/dispcc-sm8750.c | 2 --
 drivers/clk/samsung/clk-gs101.c  | 8 --------
 drivers/clk/samsung/clk-pll.c    | 7 ++++++-
 3 files changed, 6 insertions(+), 11 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

