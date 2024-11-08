Return-Path: <linux-kernel+bounces-401581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 468589C1C81
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6D31F243E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52D01E47D6;
	Fri,  8 Nov 2024 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODcsFpXc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EBA7462
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067036; cv=none; b=nfODuvnuArx1YV8XJODhUKQjruON3dl+lCeB8dqEY20aClv754weMJVpUmwhTjo8uTm6NzESc3+cHULOk8bh9KmeUfhnF++PqGELn9hzj82ZEg6RczkWm3B65GhQQHBA5mxrQgoiQ9TaidTeE4OKrQM6iVh9Pbjt9leLaylImjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067036; c=relaxed/simple;
	bh=fTsuTudBfDdFxkn1fwKanJcNb/J6/WmqUXH2vacHmtI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cJFDd1DaF3LPUKdyf2uLspRmyzYWUYFS3v5UXj8BNGd0qGd2CQibyIFqcY+0g1HQUTu+S3C1nkMtxUOzYWOqHafjOTdzAOMevkW5cF6iskC3RnALcvrv3wYLQNMByhgsprYXpfIxfK2IiH41Rk02Rpprgalh4kO9CIftoWFsLFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODcsFpXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFB6C4CECD;
	Fri,  8 Nov 2024 11:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731067035;
	bh=fTsuTudBfDdFxkn1fwKanJcNb/J6/WmqUXH2vacHmtI=;
	h=Date:From:To:Cc:Subject:From;
	b=ODcsFpXcL3NMgWgdY5z6YAb97UoEeL2HpXT3eg8kEtISjP2y8HiVWoRSf4MhKy9dG
	 d+U27SeRqt42fiJzfZYb5M+chBBZoQ47YzlTb5ZkpRow4h0vhYX2/7DcZ9Beal8/kw
	 iMS7uFpCKIaAnz0eBv8PemL/LS2e27ZIUMu+G8SIELvngOtYpeAD57XMU6GHeplMBr
	 aL7vzaEd2lqlx+sRINXpJ5at3H2vGClYzFp6LrZZwK0txb7JuvnVUh15957z5jC+TV
	 ocQCyB8oHqOWrAfj27pmChlBxyoZq/TvNEckDxIio4WLuLaY5iFhxEY1ptmgDbsl04
	 MvGDe1klZOIWQ==
Date: Fri, 8 Nov 2024 11:57:11 +0000
From: Will Deacon <will@kernel.org>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc7
Message-ID: <20241108115709.GA17107@willie-the-truck>
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

As promised, here is a (hopefully) final round of arm64 fixes for 6.12
that address some user-visible floating point register corruption. Both
of the Marks have been working on this for a couple of weeks and we've
ended up in a position where SVE is solid but SME still has enough
pending issues that the most pragmatic solution for the release and
stable backports is to disable the feature. Yes, it's a shame, but the
hardware is rare as hen's teeth at the moment and we're better off
getting back to a known good state before fixing it all properly. We're
also improving the selftests for 6.13 to help avoid merging broken code
in the future.

Anyway, the good news is that we're removing a lot more code than we're
adding.

Cheers,

Will

--->8

The following changes since commit 2e8a1acea8597ff42189ea94f0a63fa58640223d:

  arm64: signal: Improve POR_EL0 handling to avoid uaccess failures (2024-10-29 17:59:12 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 81235ae0c846e1fb46a2c6fe9283fe2b2b24f7dc:

  arm64: Kconfig: Make SME depend on BROKEN for now (2024-11-07 11:20:35 +0000)

----------------------------------------------------------------
arm64 fixes for -rc7

- Fix handling of SVE traps from userspace on preemptible kernels when
  converting the saved floating point state into SVE state.

- Remove broken support for the SMCCCv1.3 "SVE discard hint"
  optimisation.

- Disable SME support, as the current support code suffers from numerous
  issues around signal delivery, ptrace access and context-switch which
  can lead to user-visible corruption of the register state.

----------------------------------------------------------------
Mark Brown (1):
      arm64/sve: Discard stale CPU state when handling SVE traps

Mark Rutland (2):
      arm64: smccc: Remove broken support for SMCCCv1.3 SVE discard hint
      arm64: Kconfig: Make SME depend on BROKEN for now

 arch/arm64/Kconfig             |  1 +
 arch/arm64/kernel/fpsimd.c     |  1 +
 arch/arm64/kernel/smccc-call.S | 35 +++--------------------------------
 drivers/firmware/smccc/smccc.c |  4 ----
 include/linux/arm-smccc.h      | 32 +++-----------------------------
 5 files changed, 8 insertions(+), 65 deletions(-)

