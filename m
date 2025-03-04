Return-Path: <linux-kernel+bounces-543109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209AEA4D19E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 03:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F731890691
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7A6189915;
	Tue,  4 Mar 2025 02:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJ5QlwHq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7DF17C21B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 02:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055162; cv=none; b=TGKEm2VPKfF6nEgIZCIk8CmlaSWHpiMB+k9VCXVDdSTC2d4WnMBO2KKN3HfUFnaY4un/pfzjJStL6TPZf4NBlpYhF/dBbJbYTJGSKPvWfiYOLAWkZMH8COP84k8KE6JjGZmdjPQO2hvNptqSxl99LygIZrBxn77uUBseAaVo2SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055162; c=relaxed/simple;
	bh=xTuOfrIUzYJfE4dXLNmbIGwP4eOxJEuJfLBSjb6Lb0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=szkjLsa+9qbmLDedNmMEQe5fwA3MJeM7NuCbbk/KS1tEQykv/g+xx0NSecOruvvI7av7T1LUaqb6XpU9/MUqRZpoci2t6Ocq88YkIWLJFxHXLacS4fgunY6KOWhkhViM+nKpQzc5QNjbtlEe+Jim3qLeHS9ZdOhC9YCBDVXuC5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJ5QlwHq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741055160; x=1772591160;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xTuOfrIUzYJfE4dXLNmbIGwP4eOxJEuJfLBSjb6Lb0M=;
  b=ZJ5QlwHqQnm8zRGK68A/Xh+Dot0GbJKOOfFHUrWNFvt89+j1pmBomXfm
   U45rHq/KYH8EB12PcxgwdIhODi600nR9zJm/5w0VADnEx+uOuYaRXntWL
   p5SpVU2R2+j/LONkxH7es7N/38vYxZyX3TAIAxpMq7jyQB88QPaeYxJ3Z
   bK3FygkvURSj8hRZDHP8W0yYkoyNDM6C6DGiKUOpfVP0Vya1OvUOseETx
   Ng4TUjUENcu7+xLG29cScTd2AVMoSCs18bAp7rsDd4kq2l2Vw0lsL+H4e
   rNMONnKlz5cflajxSFv9k7X/jXzhvSuG3GhwpbL/HyLmfHaYunyWiMsLY
   Q==;
X-CSE-ConnectionGUID: Npu48Ws8RNK1BJbZYtsOog==
X-CSE-MsgGUID: 0VcH5fOlTputPssAFbfXvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53358189"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="53358189"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 18:25:59 -0800
X-CSE-ConnectionGUID: riYarjPuQb6rzkaZ1DGrtA==
X-CSE-MsgGUID: fVi2j3fWQ42aAnsrEsdXkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118083185"
Received: from zhiquan-linux-dev.bj.intel.com ([10.238.156.102])
  by orviesa010.jf.intel.com with ESMTP; 03 Mar 2025 18:25:57 -0800
From: Zhiquan Li <zhiquan1.li@intel.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	kirill.shutemov@linux.intel.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhiquan1.li@intel.com
Subject: [PATCH v2 RESEND] crash: Export PAGE_UNACCEPTED_MAPCOUNT_VALUE to vmcoreinfo
Date: Tue,  4 Mar 2025 11:02:03 +0800
Message-Id: <20250304030203.1684256-1-zhiquan1.li@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Intel TDX guest, unaccepted memory is unusable free memory which is
not managed by buddy, until it's accepted by guest.  Before that, it
cannot be accessed by the first kernel as well as the kexec'ed kernel.
The kexec'ed kernel will skip these pages and fill in zero data for the
reader of vmcore.

The dump tool like makedumpfile creates a page descriptor (size 24
bytes) for each non-free page, including zero data page, but it will not
create descriptor for free pages.  If it is not able to distinguish
these unaccepted pages with zero data pages, a certain amount of space
will be wasted in proportion (~1/170).  In fact, as a special kind of
free page the unaccepted pages should be excluded, like the real free
pages.

Export the page type PAGE_UNACCEPTED_MAPCOUNT_VALUE to vmcoreinfo, so
that dump tool can identify whether a page is unaccepted.

Link: https://lore.kernel.org/all/20240809114854.3745464-5-kirill.shutemov@linux.intel.com/

Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

---
V2 RESEND note:
- No changes on this, just rebasd to v6.14-rc5.

V1: https://lore.kernel.org/all/20250103074941.3651765-1-zhiquan1.li@intel.com/

Changes since V1:
- Rebase to v6.14-rc5.
- Added document into admin-guide/kdump/vmcoreinfo.rst per Dave's
  suggestion.
- Add Kirill's Reviewed-by tag.
---
 Documentation/admin-guide/kdump/vmcoreinfo.rst | 2 +-
 kernel/vmcore_info.c                           | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 0f714fc945ac..3b47916f1856 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -331,7 +331,7 @@ PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_slab|PG_hwpoision|PG_head_mask|P
 Page attributes. These flags are used to filter various unnecessary for
 dumping pages.
 
-PAGE_BUDDY_MAPCOUNT_VALUE(~PG_buddy)|PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)
+PAGE_BUDDY_MAPCOUNT_VALUE(~PG_buddy)|PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)|PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_unaccepted)
 -----------------------------------------------------------------------------
 
 More page attributes. These flags are used to filter various unnecessary for
diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index 1fec61603ef3..e066d31d08f8 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -210,6 +210,10 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_NUMBER(PAGE_HUGETLB_MAPCOUNT_VALUE);
 #define PAGE_OFFLINE_MAPCOUNT_VALUE	(PGTY_offline << 24)
 	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
+#ifdef CONFIG_UNACCEPTED_MEMORY
+#define PAGE_UNACCEPTED_MAPCOUNT_VALUE	(PGTY_unaccepted << 24)
+	VMCOREINFO_NUMBER(PAGE_UNACCEPTED_MAPCOUNT_VALUE);
+#endif
 
 #ifdef CONFIG_KALLSYMS
 	VMCOREINFO_SYMBOL(kallsyms_names);

base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
-- 
2.25.1


