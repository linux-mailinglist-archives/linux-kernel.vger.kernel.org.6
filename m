Return-Path: <linux-kernel+bounces-350138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F4999005B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8057F1C23100
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD6C148827;
	Fri,  4 Oct 2024 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAqVMtgs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801F7140E50
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728035829; cv=none; b=an5kHtkB79gWR+l0O0+7o3iCmzN29mJ2qKqqTkImRiI34aM7zNFhq6ROl0fUthCuss8H5BQuCxCHMf6aYrb0IEiz48sQRsKVr6O/C7dZd13NZrSCTZeJ7v7Rr/Fh44iYk9IMKevCR5OBRji6uY8qZJD/+Zujr5g5eX/Pw/PddkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728035829; c=relaxed/simple;
	bh=QmFYoC1IHM+OAIDny2KkOyA6l3NAUFs34jQGh53m32c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TlnNsfr4QHRg4qqLCoVZILdD0W5TP8VNo8nZKGQIByxMwn9wr93Eml+ghqhD23wWPLslnBFlWo8P1WRYZwXy/IjXs18WJN/ltlnFxFCuL9jHF6qkX5y4QSlt34jFODxYNlXkScR1LKnA/j+j0uSaGs/tbSxCpEi7i3MWAhJ90wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAqVMtgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739CAC4CEC6;
	Fri,  4 Oct 2024 09:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728035829;
	bh=QmFYoC1IHM+OAIDny2KkOyA6l3NAUFs34jQGh53m32c=;
	h=From:To:Cc:Subject:Date:From;
	b=HAqVMtgsJZBGRupdDGNIvb4ax1Y65X5H1hZWJN8hd+0n5FGfbttmR+l9CtlqL67+V
	 HSF2L6AHj+Ta5h7NdrbAUFRUw7jPuBhsqL4cKdogNxJaJP4uXa1tbgWfXeeIvAKq4Z
	 ZUF995SGitiFacEpv7XrOdu8S5y72gIlK+r0HTUhaEBlaHj8bPxUf58sdN7oTp5B7r
	 R4FfjUT56ka6DsibNk7oZTePB+dJoAp2ccQwBjn0yJBVr5zG++IEs+exiZpjHCcjMP
	 zSvHRGL44IRDhdwttEiuETCGZe9gvk1Jb2RMo13AQ9SJZft8PXkzQWKtSRRxfjQCpO
	 fj8/MV+6Kgr7g==
From: Arnd Bergmann <arnd@kernel.org>
To: Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	kernel test robot <lkp@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Hou Tao <houtao1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Jianhui Zhou <912460177@qq.com>,
	Yury Norov <yury.norov@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] preempt_rt: increase PERCPU_DYNAMIC_SIZE_SHIFT for slab randomization
Date: Fri,  4 Oct 2024 09:56:56 +0000
Message-Id: <20241004095702.637528-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When both PREEMPT_RT and RANDOM_KMALLOC_CACHES are enabled, the slub allocator
runs into a build time failure:

In file included from <command-line>:
In function 'alloc_kmem_cache_cpus',
    inlined from 'do_kmem_cache_create' at mm/slub.c:6041:7:
include/linux/compiler_types.h:517:45: error: call to '__compiletime_assert_598' declared with attribute error: BUILD_BUG_ON failed: PERCPU_DYNAMIC_EARLY_SIZE < NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH * sizeof(struct kmem_cache_cpu)
  517 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |                                             ^
include/linux/compiler_types.h:498:25: note: in definition of macro '__compiletime_assert'
  498 |                         prefix ## suffix();                             \
      |                         ^~~~~~
include/linux/compiler_types.h:517:9: note: in expansion of macro '_compiletime_assert'
  517 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
      |                                     ^~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
   50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
      |         ^~~~~~~~~~~~~~~~
mm/slub.c:5133:9: note: in expansion of macro 'BUILD_BUG_ON'
 5133 |         BUILD_BUG_ON(PERCPU_DYNAMIC_EARLY_SIZE <
      |         ^~~~~~~~~~~~

The problem is the additional size overhead from local_lock in
struct kmem_cache_cpu.  Avoid this by preallocating a larger area.

Fixes: d8fccd9ca5f9 ("arm64: Allow to enable PREEMPT_RT.")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410020326.iaZIteIx-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
There is a good chance that there is a better way to address this, this
version was the first I came up with and I verified that it fixes all of
the broken configs.

See https://pastebin.com/raw/tuPgfPzu for a .config from a failing
randconfig build on 6.12-rc1.
---
 include/linux/percpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index b6321fc49159..4083295da27f 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -41,7 +41,11 @@
 					 PCPU_MIN_ALLOC_SHIFT)
 
 #ifdef CONFIG_RANDOM_KMALLOC_CACHES
+#ifdef CONFIG_PREEMPT_RT
+#define PERCPU_DYNAMIC_SIZE_SHIFT      13
+#else
 #define PERCPU_DYNAMIC_SIZE_SHIFT      12
+#endif
 #else
 #define PERCPU_DYNAMIC_SIZE_SHIFT      10
 #endif
-- 
2.39.2


