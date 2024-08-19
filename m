Return-Path: <linux-kernel+bounces-292060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09053956AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71221F22DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C7C16C44C;
	Mon, 19 Aug 2024 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXvwEr/L"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C2E16BE19
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070092; cv=none; b=armf5pbKSYPM1dH4SU4RxVlkTdkfkh5ClNNTcmodxX6g9qRpQ0X44aNxlHXb2vOy1n5IBm7y31y7igqR4voG8ItoArNMY5RW3ZA28QGI2zDx6zopo7CkX951gAf+wNj0r76VZIcfiOwp+APWGkYMF7ZBSvIw9uSs5jOHcNyR7Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070092; c=relaxed/simple;
	bh=nM+YAlHecPAAIEM9M5qTH/W5Av3MsCgo9r/AnobGRU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4nDvtUICrkKgdn51jGXwqrJ8GUczTxsJ9ZDLPmJ1Ln5I34DYBfilF/7Aqggyo8l57GQ2kxf1xYIlHmfwudRwn4QYVTfb9PYdBt0U9jTGcjVXEzhy68/s7D9uWbvJvP90zlzEsyWwKzZaXBjOYxgo2mZRkm2fLFMMxTpALqIZoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXvwEr/L; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724070091; x=1755606091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nM+YAlHecPAAIEM9M5qTH/W5Av3MsCgo9r/AnobGRU4=;
  b=NXvwEr/LDRu8Gecs5QyDgg4d5PcUVh8wlKvZZwErSs2lOX9vHFxyOHxw
   t5/h/x7G0/GRzkRd6TcuLw+VnB9OINiaZXxjG+0U47E34yFI09b+85EgR
   bAvq5LP6aHugW3TIC7X1iyNS+n4BLv3YviSuy2W/NHdcdRpqPsaYHPLJ8
   8uf6vGMaHBWDdhn0kEMDg8hDtW//pDx3qmJ+UR5FgaZKYVDuiaSoOCHso
   DmepzdTrNquNl1rmeAZUlBuQzgduXD4A2fi+P24GeSSNwjMZdjvFvP+05
   r4P4hHqs2koOMg3ckBw89geuCQFpUEfmLfaEiILMUz8UU0igJAYB5KvKQ
   Q==;
X-CSE-ConnectionGUID: vg6UmwgHQT22+YOj3knKaQ==
X-CSE-MsgGUID: VSz6L0K2SzqcIJ6++A1AvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="39773657"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="39773657"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 05:21:30 -0700
X-CSE-ConnectionGUID: /HCve+gPQ8Cha5/hK54VwA==
X-CSE-MsgGUID: i7Gerqp/QrGAs1fyxhu3SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60658832"
Received: from tfalcon-desk.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.220.124])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 05:21:28 -0700
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
Subject: [PATCH 2/2] x86/kexec: Add comments around swap_pages() assembly to improve readability
Date: Tue, 20 Aug 2024 00:21:12 +1200
Message-ID: <2ee726723302df54460880ead6747bdb1eb95363.1724068916.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1724068916.git.kai.huang@intel.com>
References: <cover.1724068916.git.kai.huang@intel.com>
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
2.45.2


