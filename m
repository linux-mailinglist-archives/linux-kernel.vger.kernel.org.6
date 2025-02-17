Return-Path: <linux-kernel+bounces-516903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF957A3797F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 02:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E01188A9E1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 01:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49A354F81;
	Mon, 17 Feb 2025 01:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWwTB9L3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D91CFBC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739756911; cv=none; b=ipeYS+K5PVZNQxZrFHyxO5SjQFkp8SibvIjQrRPp/SKG6eyls1SupY1xMZ1x2GuXkLtVZHU0YlwGTQaSFCdpubsev6S9L1P/jc8XO2GfydeWeBLsDOeJEQsUi4rYUuBUVRqoXVFj+8Ft1q+8r6wAM/XXFy4RSkgChM+6ZrIfOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739756911; c=relaxed/simple;
	bh=2GwrQAvpI+du66jAl7ybJ2vRX2ga2dva4adjZ6Ub7XM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DXI+RrAeIH0mMpeIG2XmZZKfgkju8MOzIppo3mtlHKHNCSa7VEnUw+ogOImjQr536t6pqL2/v/vgNXaT9yXT0lRm6CkzYQepGUUcUkqPyz+l6LEsE3lK5ECAsPP7i5201eMMxWqakifDquoZfCgcoGAtmM5n9LJpM6wUUcZ9b04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWwTB9L3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739756909; x=1771292909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2GwrQAvpI+du66jAl7ybJ2vRX2ga2dva4adjZ6Ub7XM=;
  b=NWwTB9L3l9dgIMjPpFyk+apmLSUDpvfFjcF+VOrg+t2uNeVRAWYEaV5Y
   jHdvf9s+SRV/aHiA0xz4a7CoZ/yJgG7PVvC/IPFRkAqTbFZEOX3DepnuX
   mRQNEYKW8ho7mdNMfoO0e8U3zL9ylSpnANBKLdQlxRrq2z25AzgfA7AUo
   sQrYxwfyOnPNXmNwOVX1zYUQ2pUPy7glrrHMUdXeq4b7qz+chcdD3Chk2
   iyXLhD/9xZCHaLCXgcL9IaI3nQemhjZOGrmNeSoTVtSIxSs4+C0Td7F97
   QoeQv8n8meeVAKdqveiWxbIMnGrTPX7ztDHcWPEyaBGZcMJaZ1bSG5HEt
   g==;
X-CSE-ConnectionGUID: kUxdssxwQw+JghZQeD1lmQ==
X-CSE-MsgGUID: KX7+G0MsRmK+EBGpHL7eJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51856125"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51856125"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 17:48:28 -0800
X-CSE-ConnectionGUID: ePYr3PJcSLCXvJq2ubhrkA==
X-CSE-MsgGUID: xjwPS82HT+SVi3vgaGRq/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,291,1732608000"; 
   d="scan'208";a="113932110"
Received: from zhiquan-linux-dev.bj.intel.com ([10.238.156.102])
  by orviesa006.jf.intel.com with ESMTP; 16 Feb 2025 17:48:25 -0800
From: Zhiquan Li <zhiquan1.li@intel.com>
To: bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com,
	kirill.shutemov@linux.intel.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhiquan1.li@intel.com
Subject: [PATCH v2 RESEND] crash: Export PAGE_UNACCEPTED_MAPCOUNT_VALUE to vmcoreinfo
Date: Mon, 17 Feb 2025 10:24:35 +0800
Message-Id: <20250217022435.4056776-1-zhiquan1.li@intel.com>
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
- No changes on this, just rebasd to v6.14-rc3.

V1: https://lore.kernel.org/all/20250103074941.3651765-1-zhiquan1.li@intel.com/

Changes since V1:
- Rebase to v6.14-rc3.
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

base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
-- 
2.25.1


