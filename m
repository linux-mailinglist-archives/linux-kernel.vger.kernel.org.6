Return-Path: <linux-kernel+bounces-251909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DF7930B71
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 22:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44749281070
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 20:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540B213D243;
	Sun, 14 Jul 2024 20:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="o41wkx3o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBD413C904
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720987261; cv=none; b=VhMF6ZVUubuk7cfVb56yx4R8eMD9my6CJTUZJbhmDmG+QSa5XYx8Q1u5tUVNwkkVl5XTUI3GG4/coo116OYdxGG5G9Yi/upCZQ2ciuEmNfrH7kvg7UShXEmDeBS93Ruz4T50skCnyBBX1FuWTtgISpJW88gW9WBwzIy4DqeRQro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720987261; c=relaxed/simple;
	bh=KT6PJV8jtQ03ieQG9Iv0WqDazw8MnnaupLdnU1y9t0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pZblL0NIRvEQZO+M9b8aVOkMuv54f7/0Y9spaLb0uTLShOch38XQjow7jITC3r+j9eJ7JRWvbXcZ0+xpgnMiO/M83oitzigQQ2R23i4TF+/RK9vn9bGRr8GDonaOu+JgOQuzU5mvodrB821OFvlkUHajO+uj8rF/qj8zVAb22ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=o41wkx3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1B5C116B1;
	Sun, 14 Jul 2024 20:01:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="o41wkx3o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720987258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bHQO3zPLyzmQphSeEtg/qyiTJJ9u4T8elR7sypfsuz0=;
	b=o41wkx3oMoc2az4dOEH0Cd1Vy2+Xea0kftHV4AC8+7XSjURgt/lwitL8I7PX+Njop7Ju/D
	BJlcQ0bf/veSKtFiGtSiDHWciIXRTgGntSSqRYMHf9nGDSaIhfWkECuW9BGB69bfdbmyfg
	yMixCHtk36e5uQfCNTXLoJdGLN3Zy5I=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 29c6a6ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 14 Jul 2024 20:00:58 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator updates for 6.11-rc1
Date: Sun, 14 Jul 2024 22:00:50 +0200
Message-ID: <20240714200050.902013-1-Jason@zx2c4.com>
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

This is a short series adding getrandom() support to the vDSO. First, it adds a
new kind of mapping to mmap(2), MAP_DROPPABLE, which lets the kernel zero out
pages anytime under memory pressure, which enables allocating memory that never
gets swapped to disk but also doesn't count as being mlocked. Then, the vDSO
implementation of getrandom() is introduced in a generic manner and hooked into
random.c. Next, this is implemented on x86. (Also, though it's not ready for
this pull, somebody has begun an arm64 implementation already.) Finally, two
vDSO selftests are added.

Each version of this series has been in linux-next for a little bit, and there
are no major reported issues, though there may be a trivial merge conflict.

Please pull, and thanks again for your input on this.

Thanks,
Jason

The following changes since commit 8a18fda0febb7790de20ec1c3b4522ce026be1c6:

  Merge tag 'spi-fix-v6.10-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi (2024-07-11 12:07:50 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.11-rc1-for-linus

for you to fetch changes up to 41c32169260827f81a55f5c832c4b334ad4c3586:

  selftests/vDSO: add tests for vgetrandom (2024-07-12 03:31:01 +0200)

----------------------------------------------------------------
Random number generator updates for Linux 6.11-rc1.
----------------------------------------------------------------

Jason A. Donenfeld (4):
      mm: add MAP_DROPPABLE for designating always lazily freeable mappings
      random: introduce generic vDSO getrandom() implementation
      x86: vdso: Wire up getrandom() vDSO implementation
      selftests/vDSO: add tests for vgetrandom

 MAINTAINERS                                        |   4 +
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
 include/uapi/linux/random.h                        |  15 ++
 include/vdso/datapage.h                            |  11 +
 include/vdso/getrandom.h                           |  46 ++++
 lib/vdso/Kconfig                                   |   5 +
 lib/vdso/getrandom.c                               | 251 ++++++++++++++++++
 mm/ksm.c                                           |   2 +-
 mm/madvise.c                                       |   5 +-
 mm/memory.c                                        |   4 +
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
 37 files changed, 1110 insertions(+), 17 deletions(-)
 create mode 100644 arch/x86/entry/vdso/vgetrandom-chacha.S
 create mode 100644 arch/x86/entry/vdso/vgetrandom.c
 create mode 100644 arch/x86/include/asm/vdso/getrandom.h
 create mode 100644 include/vdso/getrandom.h
 create mode 100644 lib/vdso/getrandom.c
 create mode 100644 tools/include/asm/rwonce.h
 create mode 100644 tools/testing/selftests/mm/droppable.c
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_chacha.c
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_getrandom.c

