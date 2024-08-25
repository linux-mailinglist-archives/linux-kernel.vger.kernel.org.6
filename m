Return-Path: <linux-kernel+bounces-300347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F7295E2A2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 10:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3C11F21106
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 08:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4485770FD;
	Sun, 25 Aug 2024 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f5IcAsiy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D9574429
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724573903; cv=none; b=MWLqjy5aOzEvY1MEYCU4YOIhQxG0YYVCEWI/BHZyqO+1XTyA8ltOnwmdK8IrqpIoFHUN6o8jGxc+wJ3JvTbIrnXIG58jvaF2KPLRb1avBGNj+ya7eikFc9dXr7XaFn/xtv/12qI6DV6HkU1IqF0j8lH8UK0t958Qq2VZ+eQHWNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724573903; c=relaxed/simple;
	bh=1qHAeRyAQX9oLfgczm9A1aJxQGkAsZGio0fOv5jByJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNmRXEvwORRpyFTQplMTMc54+EYwvRhxoonDg0QE0HPcnRteDkSf+zzZtihu1FTjnSfgp46qVpv5wYnQ3DrEyLnWxeZTqvsIb31JJTk4rJvoMNCmuv7ldM/GZ+VlY6sn/u7CUYDjSe4oyHnI6Uf3CisR4RcdOb9Jr3JlwiVB6Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f5IcAsiy; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724573902; x=1756109902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1qHAeRyAQX9oLfgczm9A1aJxQGkAsZGio0fOv5jByJE=;
  b=f5IcAsiyyLOLHdeURf48/Xscy89s/EUCHC7RyjTRpXRq71hz0i+2NbdN
   wasN4EX/XKehSjEZ+5Kda1skzjsHiWCkVb4oamuNcRA9rnV6uuizVn3/s
   tf/WD3hAsOrymJurJmDyxlWX7cyH9GC30ryaUrnrHOyImIE1RkKcCd+cS
   3AcYEDdhQ2Jh+CXnIcBb1I00i6R1xRH61M4nzB+7+TAehXT1w+N6jur6n
   leltz6GZAsdBv72sDpLhX9/dg1lLLDR9PKhnN1XI9fWT5fgiDnSNOzKx0
   j+QBdTgLiNJnPtx8EzXkmI2tZblqBmvY2XDBr6+6UFbjvNbq67ePhmPQk
   A==;
X-CSE-ConnectionGUID: al1cdAEjR2O38snqkZ0DGQ==
X-CSE-MsgGUID: 5I7Gw8OITXqqSLPZ1gAwow==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="23186623"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="23186623"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 01:18:21 -0700
X-CSE-ConnectionGUID: lgYS4C7aSSWv0uyHIT6zuA==
X-CSE-MsgGUID: 6SBycgDaRKCOCmuZz812sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="67014958"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.222.196])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 01:18:20 -0700
From: Kai Huang <kai.huang@intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@intel.com,
	hpa@zytor.com,
	peterz@infradead.org
Cc: kirill.shutemov@linux.intel.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	nik.borisov@suse.com
Subject: [PATCH v2 2/2] x86/kexec: Add comments around swap_pages() assembly to improve readability
Date: Sun, 25 Aug 2024 20:18:06 +1200
Message-ID: <8b52b0b8513a34b2a02fb4abb05c6700c2821475.1724573384.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724573384.git.kai.huang@intel.com>
References: <cover.1724573384.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current assembly around swap_pages() in the relocate_kernel() takes
some time to follow because the use of registers can be easily lost when
the line of assembly goes long.  Add a couple of comments to clarify the
code around swap_pages() to improve readability.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index f7a3ca3dee53..e9e88c342f75 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -170,6 +170,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	wbinvd
 .Lsme_off:
 
+	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
 	movq	%rcx, %r11
 	call	swap_pages
 
@@ -289,18 +290,21 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	movq	%rcx,   %rsi  /* For ever source page do a copy */
 	andq	$0xfffffffffffff000, %rsi
 
-	movq	%rdi, %rdx
-	movq	%rsi, %rax
+	movq	%rdi, %rdx    /* Save destination page to %rdx */
+	movq	%rsi, %rax    /* Save source page to %rax */
 
+	/* copy source page to swap page */
 	movq	%r10, %rdi
 	movl	$512, %ecx
 	rep ; movsq
 
+	/* copy destination page to source page */
 	movq	%rax, %rdi
 	movq	%rdx, %rsi
 	movl	$512, %ecx
 	rep ; movsq
 
+	/* copy swap page to destination page */
 	movq	%rdx, %rdi
 	movq	%r10, %rsi
 	movl	$512, %ecx
-- 
2.46.0


