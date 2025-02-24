Return-Path: <linux-kernel+bounces-529714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F6BA42A2C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B9D188B313
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E807D264624;
	Mon, 24 Feb 2025 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2NSNRLb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40691BEF81
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418790; cv=none; b=AdgF+ftAxZy4ldn1LHHK4fU8A6B6GFOfExn9bHI0rregezz8aiiP+8nVpS86XfeNSXdpN7GbmYTpTevVsBh/HPmEvzrLwTCgDbgalOzfNXtlrw+OMXELVGFYfPJPG0lmcs9wbcOeeeV0WrfJIyL/b/2BRhuwdlFBmXgc+HaIj/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418790; c=relaxed/simple;
	bh=4lq1u+Vg4c4+yWArBVNq2YzRcRNdLD4JckKo5A8x8Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXdMSIX9b0f7BFjVOsd6sG4jYHIF3PvLk8UCSGBBsjyJCk6FMAHyqWsAI/Q+/0yu8hphRjr5ePACz5d8bcu05ivijhcyosxYzDsFX8euRibF5FyqRgNkA3ZtZ1x/siNtvcEmh7kpuFToMGxyPEoLYhBeaOM2z0RGFf0PlAzFb1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2NSNRLb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740418788; x=1771954788;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4lq1u+Vg4c4+yWArBVNq2YzRcRNdLD4JckKo5A8x8Xs=;
  b=i2NSNRLbThbRyYlpqHL0YwFhIQfZT19pAbth56cGpKF1VVHz1h5jkXmX
   /1BTt0avTU+JLpZPn3efhc9cOMPZXTgBiIcZ9jIe9BaauAXjWjbN1kS1L
   JDlhhOrV8CgzCbyOmqiqu3ztFwIwsJzcNUoj0D93yeTFllB1wjSz2myaO
   91fPN4suUglhxU+eSrgzp6MR+RII92zhpEDQKr1sjcXW1Xlsk/gUMZ0hS
   MR+xsR/3/hzV5kJqMq0p7/4zXBjA3yk2qnW1uX5HR1p4KkIU9niqiqHEu
   VZDNiDlTFxT6FJ4yF1xq/5EwNzbNpyMH4MQ283Iy/TxKyjf9kFFThkhzt
   Q==;
X-CSE-ConnectionGUID: +YFWOVryTuy1HXEjRCUQMg==
X-CSE-MsgGUID: wVbgnliqRju1V5nO1fK5Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40895804"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="40895804"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 09:39:48 -0800
X-CSE-ConnectionGUID: I8c25QPLQdiBkDUpD1m+gA==
X-CSE-MsgGUID: FwY/wvYIS++TuOGjxFe9Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="116625052"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 24 Feb 2025 09:39:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 5845C19E; Mon, 24 Feb 2025 19:39:44 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] x86/mm: Check if PTRS_PER_PMD is defined before use
Date: Mon, 24 Feb 2025 19:39:40 +0200
Message-ID: <20250224173940.219820-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.45.1.3035.g276e886db78b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compiler is not happy about PTRS_PER_PMD being undefined

In file included from arch/x86/kernel/head_32.S:29:
arch/x86/include/asm/pgtable_32.h:59:5: error: "PTRS_PER_PMD" is not defined, evaluates to 0 [-Werror=undef]
   59 | #if PTRS_PER_PMD > 1

Add a check to make sure PTRS_PER_PMD is defined before use.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202412152358.l9RJiVaH-lkp@intel.com/
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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
2.45.1.3035.g276e886db78b


