Return-Path: <linux-kernel+bounces-548542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED7BA54641
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7AFF171949
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FC220968E;
	Thu,  6 Mar 2025 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9xwnJsH"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DCF20101A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253229; cv=none; b=lR9ROz27gRQbww3axZsE1O5jb0mBGhGxpATFhkqmzoBrx3eHvXETY6KBH8f6V5RK6vHCPvv8tvgAuqyVNy6RO7iDmd+zOxBGQ4OsB5xnuyOYN5Y7wnMwbQu5tNZemTWQmRUMUKQdL+qdmGqjDDaGuzILLq+6tHWeTyN9INBXnWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253229; c=relaxed/simple;
	bh=xPaxoD+qKt9qygkNfIjSAyVeHaeHQjVmhU/zMf8dK1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bqV75fgxNl61DMcwiILSZAu6AsMol4hIXNrSei9+ygCWI0ZFjCethjh6tjGF/hGBntGXdZXW5qii7DYONE6Xiu1F3qZpJikXUJ5V9zwwnegCPPIBwjNkIabnVAM+R38WkEVdarSQAX8HgEaLY8t8gN7MSNGtr9rTO+31LM2gs+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9xwnJsH; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741253228; x=1772789228;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xPaxoD+qKt9qygkNfIjSAyVeHaeHQjVmhU/zMf8dK1g=;
  b=E9xwnJsHDorx8xLzytiHYJgxfw3FM6zvc0xuOZ4b/HKK/JVbds36OcXI
   l3dZkpPQGh/d17Iw+aiPJqIgg9bbO8cEm8jP+sJQ3gMOXmFzbFH15ziD8
   8opThmOLEo92vVo3kcDZKWfaB3s8EBYeJgfCEDBh3daBB29+C7DJ7gNIV
   Kqn9lLUxUnZJY3/snBBUA+evjabhyZMfZgACByqYRhCFCfV1Z+3M30hcv
   JTyxvfIpu6q4bldFAesYWf9iiFVjXy6IRazO9OZFcTz0Q3CAtUlNRg+/B
   x6RPbb/QH3F7tQf9S3l9p75BO26U4QPfV6X7tNF97tW1yIF507iY6WXRD
   Q==;
X-CSE-ConnectionGUID: DeuTnQFCTI642eZ01Nq5lg==
X-CSE-MsgGUID: b25Q7N20RYuuxMamU3tpxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53236646"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="53236646"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 01:27:08 -0800
X-CSE-ConnectionGUID: L5PFff7LQJG9ifCA3gAfNw==
X-CSE-MsgGUID: 2Q8n90kgStO3AdOBCahUYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156191783"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 06 Mar 2025 01:27:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2E68720B; Thu, 06 Mar 2025 11:27:03 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/1] x86/mm: Check if PTRS_PER_PMD is defined before use
Date: Thu,  6 Mar 2025 11:25:41 +0200
Message-ID: <20250306092658.378837-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compiler (GCC) is not happy about PTRS_PER_PMD being undefined
(note, clang also issues the quite similar warning)

In file included from arch/x86/kernel/head_32.S:29:
arch/x86/include/asm/pgtable_32.h:59:5: error: "PTRS_PER_PMD" is not defined, evaluates to 0 [-Werror=undef]
   59 | #if PTRS_PER_PMD > 1

Add a check to make sure PTRS_PER_PMD is defined before use.

The documentation for GCC 7.5.0+ says that:

	if defined BUFSIZE && BUFSIZE >= 1024

    can generally be simplified to just #if BUFSIZE >= 1024, since if BUFSIZE
    is not defined, it will be interpreted as having the value zero.

But in the same time the last paragraph points out that

    It will warn wherever your code uses this feature.

which is what we met here.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202412152358.l9RJiVaH-lkp@intel.com/
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: made the commit message more accurate by citing the documentation (Dave)

 arch/x86/include/asm/pgtable_32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index 7d4ad8907297..3c0523588f59 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -56,7 +56,7 @@ do {						\
  * With PAE paging (PTRS_PER_PMD > 1), we allocate PTRS_PER_PGD == 4 pages for
  * the PMD's in addition to the pages required for the last level pagetables.
  */
-#if PTRS_PER_PMD > 1
+#if defined(PTRS_PER_PMD) && (PTRS_PER_PMD > 1)
 #define PAGE_TABLE_SIZE(pages) (((pages) / PTRS_PER_PMD) + PTRS_PER_PGD)
 #else
 #define PAGE_TABLE_SIZE(pages) ((pages) / PTRS_PER_PGD)
-- 
2.47.2


