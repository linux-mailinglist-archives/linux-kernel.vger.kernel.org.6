Return-Path: <linux-kernel+bounces-428268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6ED9E0C36
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25EE282D01
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0752B1DE4F0;
	Mon,  2 Dec 2024 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgEqmon/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640AD1DE4D0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168095; cv=none; b=E114PX2uGnTFF8GNsxRKkNQBpxINwB1dozQdltZcdvraVvLU41jpkionkst0ACSX9ugCIyXguRm56lI0QEPWxcQZTsPTrLjMaSBCy1Y8ATurXyw8tRnzaJNsNjicyZCj8/xXv/yee4XYMnKxV0yNK8ynN2F2B7eh1CkfHkc1gRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168095; c=relaxed/simple;
	bh=wp4BmsGxvjD7oTxaF2bUxCCEqVLETSyVeENvWalTvxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VmDxeL7nxk4vdSlB3bPssMuXNDTY9WOm2iYYx6tSeKb5zmt9fdiSR0dET2ttV0uPUKmfKDiZkwwAHO5ViABv0wCiqG1vrn5MO4qFmxoIdexW+MQ7LErzhqZIKk75GwotQ/ndY6vFZauUw32uLR7XV5b5o7NGOaXgXiVU6Mx4BYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QgEqmon/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733168093; x=1764704093;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wp4BmsGxvjD7oTxaF2bUxCCEqVLETSyVeENvWalTvxM=;
  b=QgEqmon/sWQKn0pz25Dh/kNc+LvFiem08AqwX/5u2CXjtny6NaA8JIQ2
   IWlyh1w/ieF8m/FIbizGd/kvSptHtb5JkPBQprwTgizqkykeJmp7he44W
   7XDSOtUF5/EqXYKCRsWPadPsraSyijsq2YmizjX3rDTXP01az6UEqkMs8
   G0mP3jiJAHfeqK8Xb08aA300JqXxSRhL9Fqe2vh9Bkqcbz8xGYkcaQIyb
   JfTZHcPbZzX66R7TRBkI0fDf1YmExe9fMQ6V7MnvhCdrB4yiMO/C4ojEe
   WZHeyvDWtjMHoqmMQWoMhi95+1872OG4jNHy+gnG1hOz+pM7AIsWVdos0
   g==;
X-CSE-ConnectionGUID: 2p/CTy0uT/2F54GaFJT9nQ==
X-CSE-MsgGUID: 1XAoURPWS1+cl0Pi+gzr5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33274265"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="33274265"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 11:34:53 -0800
X-CSE-ConnectionGUID: 1bxLlLjBRme8NsbbevLGrA==
X-CSE-MsgGUID: qGBGCvheTq2SjJsZSNvUUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="92855911"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 02 Dec 2024 11:34:50 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CBEFE31C; Mon, 02 Dec 2024 21:34:48 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] lockdep: Move lockdep_assert_locked() under #ifdef CONFIG_PROVE_LOCKING
Date: Mon,  2 Dec 2024 21:34:45 +0200
Message-ID: <20241202193445.769567-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When lockdep_assert_locked() is unused, it prevents kernel builds
with clang, `make W=1` and CONFIG_WERROR=y:

  kernel/locking/lockdep.c:160:20: error: unused function 'lockdep_assert_locked' [-Werror,-Wunused-function]

Fix this by moving it under the respective ifdeffery.

See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
inline functions for W=1 build").

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/locking/lockdep.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2d8ec0351ef9..bb65abfcfa71 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -157,10 +157,12 @@ static inline void lockdep_unlock(void)
 	__this_cpu_dec(lockdep_recursion);
 }
 
+#ifdef CONFIG_PROVE_LOCKING
 static inline bool lockdep_assert_locked(void)
 {
 	return DEBUG_LOCKS_WARN_ON(__owner != current);
 }
+#endif
 
 static struct task_struct *lockdep_selftest_task_struct;
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


