Return-Path: <linux-kernel+bounces-292059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7485D956AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283351F22AA1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFE716BE0B;
	Mon, 19 Aug 2024 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TUwOZh3I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95471684A8
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070089; cv=none; b=XLTXMzilXL5xw/B1xh3G6plW07hodCsL6GXt0bILTPEVfwMK2dyE+0iCBQrQ9TO9JydSCLhr+wyhZTuu3rWnkMfjzPzANJ8ojd1wPi/h5/WjkEsuFjaN6+VGMY/LLMLT//Svt8W/NtslEbnAojXgltoy/IX844f/vLUuMCLskNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070089; c=relaxed/simple;
	bh=Ut9BBG4LPjEqy8zhwtMmPgC/zpi6LcB2U7BJcN4XyEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyHKIVcgX39lzNMqUB/tJ8ttaNdfd6mKuMbelRytg6vu/f5cLiFv2hrSOei6Cu1dsBS7LV3cUUZDNZ28INdRcQTDX6nDA8GM4XPhIcEUOrkKFDj4TCj3Lv8DDBtg8ctSTKo9zrlGdk83Ss6G7ri+GqA9z7T91qOkEI8RNS2NSp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TUwOZh3I; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724070088; x=1755606088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ut9BBG4LPjEqy8zhwtMmPgC/zpi6LcB2U7BJcN4XyEU=;
  b=TUwOZh3IiTKIxZO84axehbmHg6DnhAGhBCeYTO8cqE/gBxcYU0XADMJy
   8Jt5aK7FltXEnAM8nG0Gf3jJG7feD6i6oD1iZ9yUyketEgs0lQmH4Dtje
   pK3Z19DPd8VivQ8yBhsO8fo7J0wyy9c/9GnopcGS5fChpXeY3fFLdQbbU
   WmSPkuOs0vg3wabcRGiWfurmLTudPpbJEbQuAcq7wcRKDL1TWLo9t1/if
   6ampLYjlvn9w8W3YLFp4HCxa8xA0oK0q7lmKeORGTK1jIk/Pu3VunpQJX
   pxctXp+L1QEcEKuUkxFnWVEnw/xtuL9gmfFADX59QZ/NcZuVLFSRwkIrA
   g==;
X-CSE-ConnectionGUID: lAmaDeYFT8OLTk0LfCAwpA==
X-CSE-MsgGUID: LFXAKsAvSACMFyqfF8Hwow==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="39773645"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="39773645"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 05:21:28 -0700
X-CSE-ConnectionGUID: YYpULpnyTTuC46aGHrBXPw==
X-CSE-MsgGUID: NIen8Fh9QouWNQzZTUe5PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="60658827"
Received: from tfalcon-desk.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.220.124])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 05:21:25 -0700
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
Subject: [PATCH 1/2] x86/kexec: Fix a comment of swap_pages() assembly
Date: Tue, 20 Aug 2024 00:21:11 +1200
Message-ID: <d4538576fc5eeab2e4f3ea4c5111dc9597369ed4.1724068916.git.kai.huang@intel.com>
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

When relocate_kernel() gets called, %rdi holds 'indirection_page' and
%rsi holds 'page_list'.  And %rdi always holds 'indirection_page' when
swap_pages() is called.

Therefore the comment of the first line code of swap_pages()

	movq    %rdi, %rcx      /* Put the page_list in %rcx */

.. isn't correct because it actually moves the 'indirection_page' to
the %rcx.  Fix it.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 042c9a0334e9..f7a3ca3dee53 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -258,7 +258,7 @@ SYM_CODE_END(virtual_mapped)
 	/* Do the copies */
 SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	UNWIND_HINT_END_OF_STACK
-	movq	%rdi, %rcx	/* Put the page_list in %rcx */
+	movq	%rdi, %rcx	/* Put the indirection_page in %rcx */
 	xorl	%edi, %edi
 	xorl	%esi, %esi
 	jmp	1f
-- 
2.45.2


