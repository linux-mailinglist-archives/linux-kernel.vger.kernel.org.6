Return-Path: <linux-kernel+bounces-331924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD8897B305
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 18:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EDB1F23967
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 16:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F76D17C234;
	Tue, 17 Sep 2024 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiSFquMT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6972517AE11;
	Tue, 17 Sep 2024 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726590684; cv=none; b=W+u5hmPHvCHwY+Pdw8UDZW5frg0otudtsWSEHWd8QOBF+AdfLSc+yNyz/ttazMFO7muHgr3ZP7/SvH4IL1sg81LjO65qtZijnDH7nzABRMpHKyirVAcTm88HyPTIk+fHdVH4tKqsd4r4KM95xwnosUq2NXKDMY4R3HhcX2RWbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726590684; c=relaxed/simple;
	bh=Otc0zh3c/58YMdEqJr0IqjKLuSXPqpKwMXo5XoW3uz8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K9X9z+xEWTf9k0evS9Xp+STfOl9fmay9bPL332sF2gWe2KvSsOOIHl7GArJYXUGhuzWTvVl8vKQq5lU9owKjK7zBHNkx2r6R8i9kkuWnP+W/dX/VqzuQDCjGl2TO6ng/aAKP3Zfz8kHWnrqvR9LNkqUf/X7P3xkYH4jScNGbHPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiSFquMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5D9C4CEC5;
	Tue, 17 Sep 2024 16:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726590684;
	bh=Otc0zh3c/58YMdEqJr0IqjKLuSXPqpKwMXo5XoW3uz8=;
	h=Date:From:To:Subject:From;
	b=DiSFquMTP6xwmHVHHGQ9E1BociBWxKZYS0iG7FHjaeu1anJ/5LuGSIOXjE86s+Oot
	 d7VhJf0uAqP0D9gUpLZ80uXJUDowqW9o63NlTG+j9XGpr4UswPIjEc8Q3+kh57Docg
	 4Ce19fuOEZTG8GJz04+yVJgF+32YnhTHcx53NcPlodfI2HDOheyYHYdyc+7YPzFaKO
	 KhU5Zkzv/R+N4+d7sQBMKVtOMUnEI04tJrxr83VPQlTMIxCKehx8tIeuQ1hzclvuG9
	 rRI4DxaZtE/8uTLjkdNc4Sz4L4TN0eoRxFOKVz4qI6WQyqxSN5FuQL0rfVEtt997+v
	 msBXa22WBp3/Q==
Date: Tue, 17 Sep 2024 18:31:19 +0200
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes and updates for v6.12-rc1
Message-ID: <Zumu14EgYx4LhqTx@p100>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull the parisc architecture fixes and updates for 6.12-rc1, which
includes:

- On parisc we now use the generic clockevent framework for timekeeping.

- Although there is no 64-bit glibc/userspace for parisc yet, for testing
  purposes one can run statically linked 64-bit binaries. This patchset
  contains two patches which fix 64-bit userspace which has been broken since
  kernel 4.19.

- Fix the userspace stack position and size when the ADDR_NO_RANDOMIZE
  personality is enabled.

- On other architectures mmap(MAP_GROWSDOWN | MAP_STACK) creates a
  downward-growing stack. On parisc mmap(MAP_STACK) is now sufficient
  to create an upward-growing stack.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit da3ea35007d0af457a0afc87e84fddaebc4e0b63:

  Linux 6.11-rc7 (2024-09-08 14:50:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.12-rc1

for you to fetch changes up to 5d698966fa7b452035c44c937d704910bf3440dd:

  parisc: Allow mmap(MAP_STACK) memory to automatically expand upwards (2024-09-16 23:01:43 +0200)

----------------------------------------------------------------
parisc architecture fixes and updates for kernel v6.12-rc1:

- Convert parisc to the generic clockevents framework
- Fix syscall and mm for 64-bit userspace
- Fix stack start when ADDR_NO_RANDOMIZE personality is set
- Fix mmap(MAP_STACK) to map upward growing expandable memory on parisc

----------------------------------------------------------------
Helge Deller (6):
      parisc: Convert to generic clockevents
      parisc: Fix stack start for ADDR_NO_RANDOMIZE personality
      parisc: Fix 64-bit userspace syscall path
      parisc: Fix itlb miss handler for 64-bit programs
      parisc: Use PRIV_USER instead of hardcoded value
      parisc: Allow mmap(MAP_STACK) memory to automatically expand upwards

Hongbo Li (1):
      parisc: pdc_stable: Constify struct kobj_type

 arch/parisc/Kconfig                 |   2 +-
 arch/parisc/include/asm/mman.h      |  14 ++
 arch/parisc/include/asm/processor.h |   2 +-
 arch/parisc/kernel/entry.S          |   6 +-
 arch/parisc/kernel/smp.c            |   2 +-
 arch/parisc/kernel/syscall.S        |  14 +-
 arch/parisc/kernel/time.c           | 261 +++++++++++++++---------------------
 arch/parisc/kernel/traps.c          |   2 +-
 drivers/parisc/pdc_stable.c         |   2 +-
 fs/exec.c                           |   3 +-
 10 files changed, 136 insertions(+), 172 deletions(-)

