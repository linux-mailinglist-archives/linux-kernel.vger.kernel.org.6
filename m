Return-Path: <linux-kernel+bounces-390192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EDD9B76BD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873DF1F22D36
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79E21891B8;
	Thu, 31 Oct 2024 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5MjTGoN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E139D17BEA2
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364607; cv=none; b=XBEi7oL0JlE5AKrFUhJJoEWVvsea45lggX1J6cvOHLa+3mJFTnsZ/bXsivqvgysnme1J3GTtyhkjLPUPrB6pyJmsjW10SwyKRdNNkBmjcH6f7IoTaTAtIEd9plJbIe7g7+Ty6My9RMJgcwsiYz6MtGevNoLaTfWQLCsSe/w+yNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364607; c=relaxed/simple;
	bh=XvdhSg4zvXjRCuMSpLZ4dZs5CqzyZmykfta/uucnus0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPtI+cS43mHb4AiqG/qXUWBJ0gtTvLnHdtH54afPMFR7N9putHaRB1m0mNbe4ehOog+hT8VfNlDnRs2sskQLywtGafFCjk3cJWzzhtskamN0eP2zxv2NOCE6PcBOYkPqtAbf1/fNTCJjoPdpnwc+RXgvaVL/I1PVEeg2EWYzWSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5MjTGoN; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730364605; x=1761900605;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XvdhSg4zvXjRCuMSpLZ4dZs5CqzyZmykfta/uucnus0=;
  b=e5MjTGoNk+FpjZv3gTwjr7iAWpDqA9ACdBkm/nhVyMgRSsJXRzQOpyTz
   MFvvyquFFCljfIcRHGWV1a/PUUihrixPXKiECMZ+IH+NdeXmo/PXjVvHa
   zpEw6S+Wr4E6FVGFuu/ITmnfZZOX49vYnYP8oSi0q1NFX55MwZpzwHCZu
   dczRuQl9giz6UTociIDAlAJPGBk6uLcm2v11ptOsI6+ZMIhL20LHjcuMK
   pQE2R+JcKtJYursUrW+iJcltQg5BKvT15rj69DlRW7Vsz10BKNM2c/GG4
   P60B+my3CrAF9WiZlJ0qCDAB99zqwCtDfeBiXMIjWiBz2wj/xQbaBW40I
   A==;
X-CSE-ConnectionGUID: 5Bl3FDryRAahsu/c8RX/6A==
X-CSE-MsgGUID: rN+2AjX2T1WUFCyg8WkaoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30046886"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30046886"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 01:50:04 -0700
X-CSE-ConnectionGUID: Qf3lhUz9SIuPilB/IJGPdA==
X-CSE-MsgGUID: CFGXVKyiRViqyYPa0HrzQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82685000"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 31 Oct 2024 01:50:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A2BE91C4; Thu, 31 Oct 2024 10:50:00 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/mm/doc: Add missing details in virtual memory layout
Date: Thu, 31 Oct 2024 10:49:46 +0200
Message-ID: <20241031084946.2243440-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve memory layout documentation:

 - Document 4kB guard hole at the end of userspace.
   See TASK_SIZE_MAX definition.

 - Divide the description of the non-canonical hole into two parts:
   userspace and kernel sides.

 - Mention the effect of LAM on the non-canonical range.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 Documentation/arch/x86/x86_64/mm.rst | 35 +++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/arch/x86/x86_64/mm.rst b/Documentation/arch/x86/x86_64/mm.rst
index 35e5e18c83d0..f2db178b353f 100644
--- a/Documentation/arch/x86/x86_64/mm.rst
+++ b/Documentation/arch/x86/x86_64/mm.rst
@@ -29,15 +29,27 @@ Complete virtual memory map with 4-level page tables
       Start addr    |   Offset   |     End addr     |  Size   | VM area description
   ========================================================================================================================
                     |            |                  |         |
-   0000000000000000 |    0       | 00007fffffffffff |  128 TB | user-space virtual memory, different per mm
+   0000000000000000 |    0       | 00007fffffffefff | ~128 TB | user-space virtual memory, different per mm
+   00007ffffffff000 | ~128    TB | 00007fffffffffff |    4 kB | ... guard hole
   __________________|____________|__________________|_________|___________________________________________________________
                     |            |                  |         |
-   0000800000000000 | +128    TB | ffff7fffffffffff | ~16M TB | ... huge, almost 64 bits wide hole of non-canonical
-                    |            |                  |         |     virtual memory addresses up to the -128 TB
+   0000800000000000 | +128    TB | 7fffffffffffffff |   ~8 EB | ... huge, almost 63 bits wide hole of non-canonical
+                    |            |                  |         |     virtual memory addresses up to the -8 EB
                     |            |                  |         |     starting offset of kernel mappings.
+                    |            |                  |         |
+                    |            |                  |         | LAM relaxes canonicallity check allowing to create aliases
+                    |            |                  |         | for userspace memory here.
   __________________|____________|__________________|_________|___________________________________________________________
                                                               |
                                                               | Kernel-space virtual memory, shared between all processes:
+  __________________|____________|__________________|_________|___________________________________________________________
+                    |            |                  |         |
+   8000000000000000 |   -8    EB | ffff7fffffffffff |   ~8 EB | ... huge, almost 63 bits wide hole of non-canonical
+                    |            |                  |         |     virtual memory addresses up to the -128 TB
+                    |            |                  |         |     starting offset of kernel mappings.
+                    |            |                  |         |
+                    |            |                  |         | LAM_SUP relaxes canonicallity check allowing to create
+                    |            |                  |         | aliases for kernel memory here.
   ____________________________________________________________|___________________________________________________________
                     |            |                  |         |
    ffff800000000000 | -128    TB | ffff87ffffffffff |    8 TB | ... guard hole, also reserved for hypervisor
@@ -88,15 +100,26 @@ Complete virtual memory map with 5-level page tables
       Start addr    |   Offset   |     End addr     |  Size   | VM area description
   ========================================================================================================================
                     |            |                  |         |
-   0000000000000000 |    0       | 00ffffffffffffff |   64 PB | user-space virtual memory, different per mm
+   0000000000000000 |    0       | 00fffffffffff000 |  ~64 PB | user-space virtual memory, different per mm
+   00fffffffffff000 |  ~64    PB | 00ffffffffffffff |    4 kB | ... guard hole
   __________________|____________|__________________|_________|___________________________________________________________
                     |            |                  |         |
-   0100000000000000 |  +64    PB | feffffffffffffff | ~16K PB | ... huge, still almost 64 bits wide hole of non-canonical
-                    |            |                  |         |     virtual memory addresses up to the -64 PB
+   0100000000000000 |  +64    PB | 7fffffffffffffff |   ~8 EB | ... huge, almost 63 bits wide hole of non-canonical
+                    |            |                  |         |     virtual memory addresses up to the -8EB TB
                     |            |                  |         |     starting offset of kernel mappings.
+                    |            |                  |         |
+                    |            |                  |         | LAM relaxes canonicallity check allowing to create aliases
+                    |            |                  |         | for userspace memory here.
   __________________|____________|__________________|_________|___________________________________________________________
                                                               |
                                                               | Kernel-space virtual memory, shared between all processes:
+  ____________________________________________________________|___________________________________________________________
+   8000000000000000 |   -8    EB | feffffffffffffff |   ~8 EB | ... huge, almost 63 bits wide hole of non-canonical
+                    |            |                  |         |     virtual memory addresses up to the -64 PB
+                    |            |                  |         |     starting offset of kernel mappings.
+                    |            |                  |         |
+                    |            |                  |         | LAM_SUP relaxes canonicallity check allowing to create
+                    |            |                  |         | aliases for kernel memory here.
   ____________________________________________________________|___________________________________________________________
                     |            |                  |         |
    ff00000000000000 |  -64    PB | ff0fffffffffffff |    4 PB | ... guard hole, also reserved for hypervisor
-- 
2.45.2


