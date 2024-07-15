Return-Path: <linux-kernel+bounces-252826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E39931888
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15AF52830AB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552B21C6B2;
	Mon, 15 Jul 2024 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Javxz1Mm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3A41B7E9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721061289; cv=none; b=XHjsZQf+lTGE/ECTeQl1hxssESiGjm9+AGt6Uf+S8XHYNdxVxJQ2PGGTV6US6TbIlcAr5ivMcg1o+iY4og4s8xhFmJhL4SmejaCOtX8gvoOvv4RCm9nr28fUWJATI3GLMj2rG1DYkCrV/E5Ie4Fj+yjaJBlacwVzuiyXXgYpn1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721061289; c=relaxed/simple;
	bh=AGHSgENar+lXClT369caPNG8CCiiDlCOOhhMXrfjcE4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WYeFeKTWpCydWrmUYSBugegbq03Kf5MLXZxergJtAbnWWUMxbJkdzCXuKOsBJ/03+Mzlxttb1ON5u7vzNAmJszUOFgnuf/fyCmDaxgDq7V69iMURlCS6/WHyYB7sfhPhXzp8tbpzcibZqe+26+VFAHgT1UAgNgqtYAYkyLaG9BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Javxz1Mm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354D0C32782;
	Mon, 15 Jul 2024 16:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721061289;
	bh=AGHSgENar+lXClT369caPNG8CCiiDlCOOhhMXrfjcE4=;
	h=Date:From:To:Cc:Subject:From;
	b=Javxz1MmfZFpXBjo2p+4HOUiONWkg7OPU56IUwbB5CqubFVwOlEjHj6zfKJAmGAfx
	 m1D5QpUMUe6a8FTuVxfYTSlQgXRlk9cZi/8I8wRQYM9fiHRW2uiZMIZtxKG8PULsMS
	 2C2i91Sk7v2OLwaxt7bAPSbyB/cQfHPiL0LcpPtcJpjd09H84P40NYZp2v3cWhUQZ+
	 b4/LBVaRgx73S8nYPgy459YECpzePZidAnNDSfDEV2GPiZU1n8GDjDohGAJZJAZp0H
	 oSgsAYmMKj1eOSLOfOkpPaYgmUDynrFn+4f8jGZEIUSKue6+d1q3+aDQlkGs96e7I7
	 Uoac1d0/tV9Yg==
Date: Mon, 15 Jul 2024 09:34:47 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
	Kees Cook <kees@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yanjun Yang <yangyj.ee@gmail.com>,
	Yuntao Liu <liuyuntao12@huawei.com>
Subject: [GIT PULL] hardening updates for v6.11-rc1
Message-ID: <202407150933.E1871BE@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these hardening updates for v6.11-rc1.

Thanks!

-Kees

The following changes since commit c3f38fa61af77b49866b006939479069cd451173:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.11-rc1

for you to fetch changes up to 872bb37f6829d4f7f3ed5afe2786add3d4384b4b:

  randomize_kstack: Improve stack alignment codegen (2024-07-13 21:36:36 -0700)

----------------------------------------------------------------
hardening updates for v6.11-rc1

- lkdtm/bugs: add test for hung smp_call_function_single() (Mark Rutland)

- gcc-plugins: Remove duplicate included header file stringpool.h
  (Thorsten Blum)

- ARM: Remove address checking for MMUless devices (Yanjun Yang)

- randomize_kstack: Clean up per-arch entropy and codegen

- KCFI: Make FineIBT mode Kconfig selectable

- fortify: Do not special-case 0-sized destinations

----------------------------------------------------------------
Kees Cook (4):
      x86/alternatives: Make FineIBT mode Kconfig selectable
      fortify: Do not special-case 0-sized destinations
      randomize_kstack: Remove non-functional per-arch entropy filtering
      randomize_kstack: Improve stack alignment codegen

Mark Rutland (1):
      lkdtm/bugs: add test for hung smp_call_function_single()

Thorsten Blum (1):
      gcc-plugins: Remove duplicate included header file stringpool.h

Yanjun Yang (1):
      ARM: Remove address checking for MMUless devices

 arch/arm/mm/fault.c                     |  4 ++--
 arch/arm64/kernel/syscall.c             | 16 +++++++---------
 arch/s390/include/asm/entry-common.h    |  2 +-
 arch/x86/Kconfig                        |  9 +++++++++
 arch/x86/include/asm/cfi.h              |  2 +-
 arch/x86/include/asm/entry-common.h     | 15 ++++++---------
 arch/x86/kernel/alternative.c           |  8 ++++----
 drivers/misc/lkdtm/bugs.c               | 30 ++++++++++++++++++++++++++++++
 include/linux/fortify-string.h          |  8 ++------
 include/linux/randomize_kstack.h        | 18 ++++++++++++------
 lib/fortify_kunit.c                     |  3 +--
 scripts/gcc-plugins/gcc-common.h        |  5 -----
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 13 files changed, 76 insertions(+), 45 deletions(-)

-- 
Kees Cook

