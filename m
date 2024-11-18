Return-Path: <linux-kernel+bounces-412334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D07989D07BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 03:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FEA281B8B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DE1286A9;
	Mon, 18 Nov 2024 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DTV6J84k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1DA17597
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731895787; cv=none; b=XonnizF+jPW21YCDwzCm6lWJxzzoY4CVgpaQv+wqJemEAyle6sK4S/wQLfXJqRsodLUyJ0lvFTTr1pFP/DSTP0swU09thOyLC1gauJp/CTE3om8aOFn1BERV+sQieqFh0yA/bPfBRQWTyY3MYbblUJeTGm6bq1cS6QXh1CZN32Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731895787; c=relaxed/simple;
	bh=ftZvDMYsL07DGBMTwC1DQ7ahC1v8JYK2svw2XjBSC+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sS6IHAZXd6AS28sXSFKORD1RfvNPmc6oMeAlnMPd8S+AXuQVHOpDcZqINNNXFYTsy6pMZhFlOcIh4NJvsvdMfuP/86HUmIkgSBnqL1zgk9wXXtOG9HNHQJHtuGfO4mf/dQNGTTGQfKPlFsSlURBd/zq3bOZWkxBYGwmgqbIDBIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=DTV6J84k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6CAC4CECD;
	Mon, 18 Nov 2024 02:09:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DTV6J84k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1731895784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rpjZBOeGMzVDuzjjFToNPOoJEjJtf0SoqgjWu/d8t8U=;
	b=DTV6J84kYMPSRONCoRImdaIqAZ/09QfVbQtsjdjOnd6Kuv4hUEjuyXHVojJVnZ3+JT/Y92
	Uae65gXCA8WQ2ms3TD3Hdia4D8JbE70BdCn6JDBxMCP3tcbNmyC1hs3cFRKHTb7tzWIWRB
	6uhzsgwjUWUa1Vuj919PH/axDUGTPbI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d6e83aca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 02:09:44 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator updates for 6.13-rc1
Date: Mon, 18 Nov 2024 03:09:39 +0100
Message-ID: <20241118020939.641511-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

This pull request contains a single series from Uros to replace uses of
#include <linux/random.h> with prandom.h or other more specific headers, as
needed, in order to avoid a circular header issue. Uros' goal is to be able to
use percpu.h from prandom.h, which will then allow him to define __percpu in
percpu.h rather than in compiler_types.h.

This has been sitting in next for most of the 6.12 cycle.

Please pull!

Thanks,
Jason

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.13-rc1-for-linus

for you to fetch changes up to d18c13697b4dcbf6a8f06c3d8e564c4f5ad1477c:

  prandom: Include <linux/percpu.h> in <linux/prandom.h> (2024-10-03 18:21:07 +0200)

----------------------------------------------------------------
Random number generator updates for Linux 6.13-rc1.
----------------------------------------------------------------

Uros Bizjak (19):
      x86/kaslr: Include <linux/prandom.h> instead of <linux/random.h>
      crypto: testmgr: Include <linux/prandom.h> instead of <linux/random.h>
      drm/i915/selftests: Include <linux/prandom.h> instead of <linux/random.h>
      drm/lib: Include <linux/prandom.h> instead of <linux/random.h>
      media: vivid: Include <linux/prandom.h> in vivid-vid-cap.c
      mtd: tests: Include <linux/prandom.h> instead of <linux/random.h>
      fscrypt: Include <linux/once.h> in fs/crypto/keyring.c
      scsi: libfcoe: Include <linux/prandom.h> instead of <linux/random.h>
      bpf: Include <linux/prandom.h> instead of <linux/random.h>
      lib/interval_tree_test.c: Include <linux/prandom.h> instead of <linux/random.h>
      kunit: string-stream-test: Include <linux/prandom.h>
      random32: Include <linux/prandom.h> instead of <linux/random.h>
      lib/rbtree-test: Include <linux/prandom.h> instead of <linux/random.h>
      bpf/tests: Include <linux/prandom.h> instead of <linux/random.h>
      lib/test_parman: Include <linux/prandom.h> instead of <linux/random.h>
      lib/test_scanf: Include <linux/prandom.h> instead of <linux/random.h>
      netem: Include <linux/prandom.h> in sch_netem.c
      random: Do not include <linux/prandom.h> in <linux/random.h>
      prandom: Include <linux/percpu.h> in <linux/prandom.h>

 arch/x86/mm/kaslr.c                              | 2 +-
 crypto/testmgr.c                                 | 2 +-
 drivers/gpu/drm/i915/selftests/i915_gem.c        | 2 +-
 drivers/gpu/drm/i915/selftests/i915_random.h     | 2 +-
 drivers/gpu/drm/i915/selftests/scatterlist.c     | 2 +-
 drivers/gpu/drm/lib/drm_random.h                 | 2 +-
 drivers/media/test-drivers/vivid/vivid-vid-cap.c | 1 +
 drivers/mtd/tests/oobtest.c                      | 2 +-
 drivers/mtd/tests/pagetest.c                     | 2 +-
 drivers/mtd/tests/subpagetest.c                  | 2 +-
 fs/crypto/keyring.c                              | 1 +
 include/linux/prandom.h                          | 1 +
 include/linux/random.h                           | 7 -------
 include/scsi/libfcoe.h                           | 2 +-
 kernel/bpf/core.c                                | 2 +-
 lib/interval_tree_test.c                         | 2 +-
 lib/kunit/string-stream-test.c                   | 1 +
 lib/random32.c                                   | 2 +-
 lib/rbtree_test.c                                | 2 +-
 lib/test_bpf.c                                   | 2 +-
 lib/test_parman.c                                | 2 +-
 lib/test_scanf.c                                 | 2 +-
 net/sched/sch_netem.c                            | 1 +
 23 files changed, 22 insertions(+), 24 deletions(-)

