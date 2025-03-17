Return-Path: <linux-kernel+bounces-564579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DE6A657AF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE0D3B5EF7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351061917F9;
	Mon, 17 Mar 2025 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X3CnJLaI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964EC176ADB
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742227931; cv=none; b=cZdLC15YeRzFS6WHcyt2wRmU8YDC0EWOPb99LLvef9f1A1k90A0uX/VNT9FnJVwyb1/Vzky8eMMNjvtoBcC+c18AdxTomWuopcVsWnUrbS5EwGPcLDdLbjIeMhOaxd6KN/zvXpFnsAJe8geo/UZ3hnzlfR9gSgVRbxRvgSegRQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742227931; c=relaxed/simple;
	bh=vQhSg4exNShyR6UpTWLbeR4x0vQAsMy8hVeG3EC07t8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mBqqjfFkZKKIwvPaATeLhN6sQ7KdgN7FOuO5ODy0t2dKEHc4s8SUfg7ih+WpasxdpFNsblCCPW8UKlkc8eI8YWAikp8eO/VSAHHY8NMsCNWidAfWuQoMU71JckseRKfaZTdXpRjbFMSzyMVUXRc0E9cc8RHpKC33/F2vcWpVkss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X3CnJLaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014D5C4CEE3;
	Mon, 17 Mar 2025 16:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742227931;
	bh=vQhSg4exNShyR6UpTWLbeR4x0vQAsMy8hVeG3EC07t8=;
	h=Date:From:To:Cc:Subject:From;
	b=X3CnJLaIq6ET3UYDVKrDnU0otOKODVNkWSvBvdG0GziQlBuryTXxzciXLdYoWNYs3
	 JF/Qsk8E/7QV6NwBu9sw28fx7ACFRcscegJGiSvdd/pPJrnB/oQw6H6u/G8hhdRPZS
	 1/woxcMAadyFJvS/visKt5eHnwqDcMs03rLiaiJyRy1Y5ygQ4sVuKB6izw+cqd8EZH
	 /NMiptnjcBTk69IvffnM4vCZn4HS8hTHWxlYWZ0d7z8MH+DdO3wimv5I8IjUZRW56L
	 R6ajxKBRw236J4knlNoL3pM5EigjYLPTvB64LAjcsRWsm9BnaRL5TYwQOCychwnxnF
	 cYBP9Yp4MNY0g==
Date: Mon, 17 Mar 2025 09:12:08 -0700
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
	Baoquan He <bhe@redhat.com>, Dave Martin <Dave.Martin@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, kernel test robot <lkp@intel.com>,
	sunliming <sunliming@kylinos.cn>, Timur Tabi <ttabi@nvidia.com>,
	Yonatan Goldschmidt <yon.goldschmidt@gmail.com>
Subject: [GIT PULL] execve updates for v6.15-rc1
Message-ID: <202503170912.7B08D1FE19@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull these execve updates for v6.15-rc1.

Thanks!

-Kees

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.15-rc1

for you to fetch changes up to 8d68cabeb1ff1cea57caae79a76a5606b11dbb4a:

  binfmt_elf_fdpic: fix variable set but not used warning (2025-03-07 20:07:33 -0800)

----------------------------------------------------------------
execve updates for v6.15-rc1

- elf: Define and use note name macros (Akihiko Odaki)

- elf: add remaining SHF_ flag macros (Timur Tabi)

- binfmt: Remove loader from linux_binprm struct (Yonatan Goldschmidt)

- binfmt_elf_fdpic: fix variable set but not used warning (sunliming)

----------------------------------------------------------------
Akihiko Odaki (6):
      elf: Define note name macros
      binfmt_elf: Use note name macros
      powerpc/crash: Use note name macros
      crash: Use note name macros
      s390/crash: Use note name macros
      crash: Remove KEXEC_CORE_NOTE_NAME

Timur Tabi (1):
      elf: add remaining SHF_ flag macros

Yonatan Goldschmidt (1):
      binfmt: Remove loader from linux_binprm struct

sunliming (1):
      binfmt_elf_fdpic: fix variable set but not used warning

 arch/powerpc/kernel/fadump.c               |  2 +-
 arch/powerpc/platforms/powernv/opal-core.c |  8 +--
 arch/s390/kernel/crash_dump.c              | 62 +++++++------------
 fs/binfmt_elf.c                            | 21 +++----
 fs/binfmt_elf_fdpic.c                      | 13 ++--
 fs/exec.c                                  |  2 -
 fs/proc/kcore.c                            | 12 ++--
 include/linux/binfmts.h                    |  2 +-
 include/linux/kexec.h                      |  2 -
 include/linux/vmcore_info.h                |  3 +-
 include/uapi/linux/elf.h                   | 99 ++++++++++++++++++++++++++++--
 kernel/crash_core.c                        |  2 +-
 12 files changed, 148 insertions(+), 80 deletions(-)

-- 
Kees Cook

