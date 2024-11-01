Return-Path: <linux-kernel+bounces-392138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8EC9B902B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4075D2826B9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D23199386;
	Fri,  1 Nov 2024 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+vndXs6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D60199238
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 11:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730460143; cv=none; b=a72M5eqMaorgSwCDc6YPdL4cGPEpZbt9lZpL7fJKggYnwxZoPNJc67qgCBNl3kM0oE7hANLkAA+J+umItYekmwrw9TmY86oq/ydczmJmrEKt1FmtQ0rrIsTF1gTUwfhLX3CvHEDGODewaT+YJEAwxrQIWpIXRecssJJsg6HTUMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730460143; c=relaxed/simple;
	bh=tdlKZn5k9PFGSFM3oyQ39p7jeTDTtFbsaHyBExgxcc4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X0/Pwo/3tNN/sTJZiR50pLNn5mTONFu4peuXGqD/jStP0ttJXCMlyei23SodSvz/LfBW0c6k3x5MDivrSmgyidlMV99qpVus24RalL+7P8zDqS/oWFGgxEP+vxlPvUTFMWiISlZ4EPCJJm8HOMhLa05DiCrQrwGOzbm1oKxbmzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+vndXs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAC8C4CECD;
	Fri,  1 Nov 2024 11:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730460142;
	bh=tdlKZn5k9PFGSFM3oyQ39p7jeTDTtFbsaHyBExgxcc4=;
	h=Date:From:To:Cc:Subject:From;
	b=u+vndXs6+N2NMKcDk1uYSOhshrJfQimS3Dj/T0hKQyyRlX32URiSTCa9ee7Et2ZUe
	 uFybPerwA5m7yvgpHLmLjS91DsdiJbFAEePvO/ipqptIKxSuT1evPNV7HOp3I02RN4
	 i9f9aleIBVO9GTQO1cyrfigqGpOO+22KSPZqeiraSZTNRqvQrsAC4FTFhgtLCpTXl9
	 fAmsR0aqjtjfKriH+F/+6aYC6EkHhEa0Upa058jV14S4uCdnZxi2ZG/1qfMQXGMOhT
	 srMc8xBrDSM8byIFGEbUIbwV572KBphqHkAppfkgEIjNFHKB9/1N1sLhPcMKEatJq3
	 WDvIxC/T/U2rg==
Date: Fri, 1 Nov 2024 11:22:08 +0000
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc6
Message-ID: <20241101112207.GA8472@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Linus,

Please pull these arm64 fixes for -rc6. The important one is a change to
the way in which we handle protection keys around signal delivery so that
we're more closely aligned with the x86 behaviour, however there is also
a revert of the previous fix to disable software tag-based KASAN with
GCC, since a workaround materialised shortly afterwards.

I'd love to say we're done with 6.12, but we're aware of some longstanding
fpsimd register corruption issues that we're almost at the bottom of
resolving. Hopefully we'll be done reviewing the fixes next week, so
there'll be one more pull from me before the merge window opens.

Cheers,

Will

--->8

The following changes since commit 7aed6a2c51ffc97a126e0ea0c270fab7af97ae18:

  kasan: Disable Software Tag-Based KASAN with GCC (2024-10-15 11:38:10 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 2e8a1acea8597ff42189ea94f0a63fa58640223d:

  arm64: signal: Improve POR_EL0 handling to avoid uaccess failures (2024-10-29 17:59:12 +0000)

----------------------------------------------------------------
arm64 fixes for -rc6

- Fix handling of POR_EL0 during signal delivery so that pushing the
  signal context doesn't fail based on the pkey configuration of the
  interrupted context and align our user-visible behaviour with that of
  x86.

- Fix a bogus pointer being passed to the CPU hotplug code from the
  Arm SDEI driver.

- Re-enable software tag-based KASAN with GCC by using an alternative
  implementation of '__no_sanitize_address'.

----------------------------------------------------------------
Kevin Brodsky (1):
      arm64: signal: Improve POR_EL0 handling to avoid uaccess failures

Marco Elver (2):
      kasan: Fix Software Tag-Based KASAN with GCC
      Revert "kasan: Disable Software Tag-Based KASAN with GCC"

Xiongfeng Wang (1):
      firmware: arm_sdei: Fix the input parameter of cpuhp_remove_state()

 arch/arm64/kernel/signal.c   | 92 +++++++++++++++++++++++++++++++++++++-------
 drivers/firmware/arm_sdei.c  |  2 +-
 include/linux/compiler-gcc.h |  4 ++
 lib/Kconfig.kasan            |  7 +---
 4 files changed, 85 insertions(+), 20 deletions(-)

