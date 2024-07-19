Return-Path: <linux-kernel+bounces-257600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2CA937C7A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4A2282E8E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F301F1474C5;
	Fri, 19 Jul 2024 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="awsykAAc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3466E14601E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721413998; cv=none; b=MHNozgmBUlLp9b4kH1X0nh/8EayuJeYO/Qvjude/nbNnvTzsd9jXdPwpMdYGKlbs0Zc2bDepJWr5toU1sh7/UUEU7ix00ijhk72tUMxa6w5FmSvj3TwH1UWIoEkn83pm584spskmZuR+uC3S3yWH/k3ua0QEYzD3euThbYtqd+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721413998; c=relaxed/simple;
	bh=IkzcR7VWO+DKOmGz9vouLtnCJPTsLZ70oeegNUwvCJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZsyvVVZnanuuM2wJpGADaEa6fxNIII+Q/gW78XMDUE2zBXNjg3JJaGbPePbczttSkuHvVnBLYFN9mAyeUqIsWfDxW+nPyW7ZkDX34G61MbhvWn8oAyJxxIaVXqUzzJaLkHlBGKKdhTvbFszoCyutKZlRf8hN731it3Vx723htA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=awsykAAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CB4C32782;
	Fri, 19 Jul 2024 18:33:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="awsykAAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1721413995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0TqnwIchdJwFEi/bgRiz9oojlT0Jv9SMShO3MysI85I=;
	b=awsykAAcrlL0bWP0XpcEQV/z2HyT4b7gl41bZ+MgG3RBND7UiwE/tsY89TO9OEsgInXGPq
	GHNPTvjBghJltElFWN/YSXSSUth/CopzEiSI6Ansnfq/SmX7FFPazFjU44JQGIAE27ZCof
	h+7ow2HsJ4zsG8v0l6zglpwYzfhrBJE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 88533201 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Jul 2024 18:33:15 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator updates for 6.11-rc1
Date: Fri, 19 Jul 2024 20:33:08 +0200
Message-ID: <20240719183308.1472668-1-Jason@zx2c4.com>
In-Reply-To: <ZpqwFK5hgU2gOA7y@zx2c4.com>
References: <ZpqwFK5hgU2gOA7y@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's the vDSO getrandom() work we've been discussing for the last few weeks.
Thank you very much for your input on this and for working with me to get this
where it is. I'm happy with the set of compromises, and I think this wound up
in a decent place. A blurb for the merge message:

This is a short pull adding getrandom() support to the vDSO. First, it adds a
new kind of mapping to mmap(2), MAP_DROPPABLE, which lets the kernel zero out
pages anytime under memory pressure, which enables allocating memory that never
gets swapped to disk but also doesn't count as being mlocked. Then, the vDSO
implementation of getrandom() is introduced in a generic manner and hooked into
random.c. Next, this is implemented on x86. (Also, though it's not ready for
this pull, somebody has begun an arm64 implementation already.) Finally, two
vDSO selftests are added.

There are also two housekeeping cleanup commits.

Each version of this series has been in linux-next for a little bit, and there
are no major reported issues, though there is a easy merge conflict in
mm/rmap.c and a trivial one in tools/testing/selftests/mm/Makefile, both of
which have resolutions in linux-next.

Please pull, and thanks again for your input on this.

Thanks,
Jason

The following changes since commit 8a18fda0febb7790de20ec1c3b4522ce026be1c6:

  Merge tag 'spi-fix-v6.10-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi (2024-07-11 12:07:50 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.11-rc1-for-linus

for you to fetch changes up to ad8070cb1b4bd40aa19a5e3f7c24d7f62c71b382:

  MAINTAINERS: add random.h headers to RNG subsection (2024-07-19 20:23:12 +0200)

----------------------------------------------------------------
Random number generator updates for Linux 6.11-rc1.
----------------------------------------------------------------

Jason A. Donenfeld (6):
      mm: add MAP_DROPPABLE for designating always lazily freeable mappings
      random: introduce generic vDSO getrandom() implementation
      x86: vdso: Wire up getrandom() vDSO implementation
      selftests/vDSO: add tests for vgetrandom
      random: note that RNDGETPOOL was removed in 2.6.9-rc2
      MAINTAINERS: add random.h headers to RNG subsection

 MAINTAINERS                                        |   6 +
 arch/x86/Kconfig                                   |   1 +
 arch/x86/entry/vdso/Makefile                       |   3 +-
 arch/x86/entry/vdso/vdso.lds.S                     |   2 +
 arch/x86/entry/vdso/vgetrandom-chacha.S            | 178 +++++++++++++
 arch/x86/entry/vdso/vgetrandom.c                   |  17 ++
 arch/x86/include/asm/vdso/getrandom.h              |  55 ++++
 arch/x86/include/asm/vdso/vsyscall.h               |   2 +
 arch/x86/include/asm/vvar.h                        |  16 ++
 drivers/char/random.c                              |  18 +-
 fs/proc/task_mmu.c                                 |   1 +
 include/linux/mm.h                                 |   7 +
 include/linux/userfaultfd_k.h                      |   3 +
 include/trace/events/mmflags.h                     |   7 +
 include/uapi/linux/mman.h                          |   1 +
 include/uapi/linux/random.h                        |  17 +-
 include/vdso/datapage.h                            |  11 +
 include/vdso/getrandom.h                           |  46 ++++
 lib/vdso/Kconfig                                   |   5 +
 lib/vdso/getrandom.c                               | 251 ++++++++++++++++++
 mm/ksm.c                                           |   2 +-
 mm/madvise.c                                       |   5 +-
 mm/memory.c                                        |  13 +
 mm/mempolicy.c                                     |   3 +
 mm/mlock.c                                         |   2 +-
 mm/mmap.c                                          |  30 +++
 mm/rmap.c                                          |  22 +-
 mm/vmscan.c                                        |   9 -
 tools/include/asm/rwonce.h                         |   0
 tools/include/uapi/linux/mman.h                    |   1 +
 tools/testing/selftests/mm/.gitignore              |   1 +
 tools/testing/selftests/mm/Makefile                |   1 +
 tools/testing/selftests/mm/droppable.c             |  53 ++++
 tools/testing/selftests/vDSO/.gitignore            |   2 +
 tools/testing/selftests/vDSO/Makefile              |  18 ++
 tools/testing/selftests/vDSO/vdso_test_chacha.c    |  43 +++
 tools/testing/selftests/vDSO/vdso_test_getrandom.c | 288 +++++++++++++++++++++
 37 files changed, 1122 insertions(+), 18 deletions(-)
 create mode 100644 arch/x86/entry/vdso/vgetrandom-chacha.S
 create mode 100644 arch/x86/entry/vdso/vgetrandom.c
 create mode 100644 arch/x86/include/asm/vdso/getrandom.h
 create mode 100644 include/vdso/getrandom.h
 create mode 100644 lib/vdso/getrandom.c
 create mode 100644 tools/include/asm/rwonce.h
 create mode 100644 tools/testing/selftests/mm/droppable.c
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_chacha.c
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_getrandom.c

