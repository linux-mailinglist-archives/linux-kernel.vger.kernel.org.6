Return-Path: <linux-kernel+bounces-550683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24302A562E7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 216247A4B30
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC611AF4C1;
	Fri,  7 Mar 2025 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UEafKVHp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B08C19E971
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337281; cv=none; b=u5mt2nTKGdg6KNsu+Ozv03rfKxaqBhteAicJsf0oSSvEguaBmxbW682jaytK+9IgZ8wXBORe+rm2wI2OvPEH7hBj0yb1n/t+jtEWQ8chU/yqr1k5nfo9FwulE9K4E1CXpzDsW1YNRC57zdS0I5H80O6ayU59PYwQOWQvXOx23Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337281; c=relaxed/simple;
	bh=stm8J5gXFKeg0kDXqkjFf2m6eLexUCdtvHC4jHfKAJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lr8McSgp3BE3DcbRuLqDPngqfsLFSfPIvUbqhM32yGFZ1MnazeYX98R29rAeBvNuMbB1thUORuCzDjXb51RbCLy1K/kMAJFWMUZvTOQiVNGsZhsaDGfRc+mJ/EJ+08rIkQP2LhQFgKQjpWfb7XHcqclaecWuueL5Zsb17Wp5Kc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UEafKVHp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741337280; x=1772873280;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=stm8J5gXFKeg0kDXqkjFf2m6eLexUCdtvHC4jHfKAJ0=;
  b=UEafKVHpbv7S9AyFCrWlzt1YSZGiipN8+qh6jVtiUUwwNpKUTnKs0jc7
   vprzwtIcdAVpmTBeJCQm0R8FF8i+5qniVN7ar5RiU8k6Di3NuWsCcuXmM
   OPyQbhzxhVlGPDRLG6N+8gl2e5NcUOi6TyDgNhLPVbRWwO62XpVDHH1d6
   ZqjtAboYTkce6sSE8FtK86RWOX3Zd2OeT2xEaM8d/sijlaHPiHLOFgyFA
   xPBb+WzFgAX8eR9ZhJE2HrTLp/HVDdRnp1JLDWyBmKtUXsfyj46CY9qDN
   0ENYVAMxcPwOdmdXvwyMVPAsucYHSSIXFFLs99R4jcHsoR6YU6VQ8InNM
   g==;
X-CSE-ConnectionGUID: 8hHZNZ2KTEarRWy3oxoFdw==
X-CSE-MsgGUID: IMXSGq/4Tv6fvYTMlSnUFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53769252"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="53769252"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 00:44:34 -0800
X-CSE-ConnectionGUID: oGr4x6h7SmuAvUGno+g93w==
X-CSE-MsgGUID: DiqR7WcBTBW1JLx2QHUJ8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="119447799"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 07 Mar 2025 00:44:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id CE7751FC; Fri, 07 Mar 2025 10:44:28 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: akpm@linux-foundation.org,
	ebiederm@xmission.com,
	bhe@redhat.com
Cc: dave.hansen@intel.com,
	x86@kernel.org,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	rick.p.edgecombe@intel.com,
	Yan Zhao <yan.y.zhao@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ashish Kalra <Ashish.Kalra@amd.com>,
	Jianxiong Gao <jxgao@google.com>
Subject: [PATCHv3] kexec_core: Accept unaccepted kexec segments' destination addresses
Date: Fri,  7 Mar 2025 10:44:11 +0200
Message-ID: <20250307084411.2150367-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yan Zhao <yan.y.zhao@intel.com>

The UEFI Specification version 2.9 introduces the concept of memory
acceptance: some Virtual Machine platforms, such as Intel TDX or AMD
SEV-SNP, require memory to be accepted before it can be used by the
guest.

Accepting memory is expensive. The memory must be allocated by the VMM
and then brought to a known safe state: cache must be flushed, memory
must be zeroed with the guest's encryption key, and associated metadata
must be manipulated. These operations must be performed from a trusted
environment (firmware or TDX module). Switching context to and from it
also takes time.

This cost adds up. On large confidential VMs, memory acceptance alone
can take minutes. It is better to delay memory acceptance until the
memory is actually needed.

The kernel accepts memory when it is allocated from buddy allocator for
the first time. This reduces boot time and decreases memory overhead as
the VMM can allocate memory as needed.

It does not work when the guest attempts to kexec into a new kernel.

The kexec segments' destination addresses are not allocated by the buddy
allocator. Instead, they are searched from normal system RAM (top-down or
bottom-up) and exclude driver-managed memory, ACPI, persistent, and
reserved memory. Unaccepted memory is normal system RAM from kernel
point of view and kexec can place segments there.

Kexec bypasses the code path in buddy allocator where memory gets
accepted and it leads to a crash when kexec accesses segments' memory.

Accept the destination addresses during the kexec load, immediately after
they pass sanity checks. This ensures the code is located in a common place
shared by both the kexec_load and kexec_file_load system calls.

This will not conflict with the accounting in try_to_accept_memory_one()
since the accounting is set during kernel boot and decremented when pages
are moved to the freelists. There is no harm in invoking accept_memory() on
a page before making it available to the buddy allocator.

No need to worry about re-accepting memory since accept_memory() checks the
unaccepted bitmap before accepting a memory page.

Although a user may perform kexec loading without ever triggering the jump,
it doesn't impact much since kexec loading is not in a performance-critical
path. Additionally, the destination addresses are always searched and found
in the same location on a given system.

Changes to the destination address searching logic to locate only memory in
either unaccepted or accepted status are unnecessary and complicated.

Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
[ kirill: Update the commit message ]
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Jianxiong Gao <jxgao@google.com>
---
 v3:
   - Update the commit message and retest the patch.

 kernel/kexec_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c0bdc1686154..9a2095216f4f 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -210,6 +210,16 @@ int sanity_check_segment_list(struct kimage *image)
 	}
 #endif
 
+	/*
+	 * The destination addresses are searched from system RAM rather than
+	 * being allocated from the buddy allocator, so they are not guaranteed
+	 * to be accepted by the current kernel.  Accept the destination
+	 * addresses before kexec swaps their content with the segments' source
+	 * pages to avoid accessing memory before it is accepted.
+	 */
+	for (i = 0; i < nr_segments; i++)
+		accept_memory(image->segment[i].mem, image->segment[i].memsz);
+
 	return 0;
 }
 
-- 
2.47.2


