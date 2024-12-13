Return-Path: <linux-kernel+bounces-444571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745909F08EA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82ECE1695E0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5F31BAEFD;
	Fri, 13 Dec 2024 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cXvSiAeB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A081DE899
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083863; cv=none; b=A97xPnYYhFsYK3ndqXRwtTuZ3zktdio3030nppCpglqWz85WlSY3HCxEImo1nxX8ryPBC7IhBhIbyUzu+NYU35Qvfsd5mnmzdwHVY+U1TCJFWJv3QoszlIlLQ0qqqYSy5C0/1IySJwynoWDQgHiOtS6PoSeIsa2Cj2a/GISh9y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083863; c=relaxed/simple;
	bh=GH1L5UbCox+/l9a3Rv/+h7MmSzvbSrhCbpBcYNUY9OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cl4Fzs3GeoJRIJJ+m4pKMMSphd+b+V/PbH3CgwglZMqj796iHmynD2sQSnluEeuOU6hC3Id4H0AQIDP9PfruhhAB4mzV5gdw0qlPv7P7Zi1Z+mGu13RumW8VzxA8cUdd+gvspG1ve6sZgSMeKsAxx2aytXdWIB5ZmO/ATYtAmnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cXvSiAeB; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734083861; x=1765619861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GH1L5UbCox+/l9a3Rv/+h7MmSzvbSrhCbpBcYNUY9OQ=;
  b=cXvSiAeBc8FkP4yM6kQMs3WEiWaux9naHPZsB8vXCSkcHfFFXQyg/5i+
   yqrlfuW6cfBrP7LAATotRq/eFqQ5DHkl4KKv4uDtdFeYMI3EtohRK9b3s
   wgPeiPdImYTynA5+ufI6ebqnuni5qv6Kwx+Ycyj/bZMRxuUoCX0H5obaI
   K1WYgoIt1aAzc+R/CS1YENP6p4tmKeyVkSsX96RIoP+4kmLaWDDQCx8N+
   Fy8SnJEDAhIN7fhgMyE1i7oZ1X/8+LbsWFWZ0WI5qRMxSg6qNDYE3vQ3O
   nfoEN1nP5vY71+qSgHIxSq16WXN1Caz54urSK7FZkbFjTYdTNP5AQyVn5
   w==;
X-CSE-ConnectionGUID: 7rQ+DrmYQYuyObSX9oif9w==
X-CSE-MsgGUID: Bv4eVmaXSkmagJNF/nWr9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34666956"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="34666956"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 01:57:40 -0800
X-CSE-ConnectionGUID: CyrDsqVNQpq9aVXhn30Ofw==
X-CSE-MsgGUID: R2kEnO8rTTKX9eAophPF8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="96262543"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 01:57:37 -0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: ebiederm@xmission.com
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	x86@kernel.org,
	rick.p.edgecombe@intel.com,
	kirill.shutemov@linux.intel.com,
	bhe@redhat.com,
	Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH v2 1/1] kexec_core: Accept unaccepted kexec segments' destination addresses
Date: Fri, 13 Dec 2024 17:54:49 +0800
Message-ID: <20241213095449.881-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241213094930.748-1-yan.y.zhao@intel.com>
References: <20241213094930.748-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In TDX, to run a linux guest, TDs (hardware-isolated VMs) must accept
before accessing private memory. Accessing private memory before acceptance
is considered a fatal error and may result in the termination of the TD.

The "accepting memory" operation in guest includes the following steps:
- trigger a VM-exit
- the host OS allocates a physical page and requests hardware to map the
  physical page to the GPA.
- initialize memory content to 0.
- encrypt the memory

For a Linux guest, eagerly accepting all memory during kernel boot can slow
down the boot process and cause unnecessary memory occupation on the host
for pages that may never be accessed. Therefore, Linux guests usually opt
for a lazy mode to delay page acceptance operations by not moving the pages
to the buddy allocator's freelists. Instead, the kernel tracks memory
in 4M units and places them in a zone->unaccepted_pages list if any page in
the entire 4M range is in an unaccepted state (even if part of the memory
range may have been accepted by firmware or the kernel). When the kernel
does not have enough free pages, it will move memory from the
zone->unaccepted_pages list and accept it, ensuring that the memory is
accepted before moving it to the freelists and being available to the buddy
allocator.

The kexec segments' destination addresses are not allocated by the buddy
allocator. Instead, they are searched from normal system RAM (top-down or
bottom-up) and exclude driver-managed memory, ACPI, persistent, and
reserved memory... Although these addresses may fall within the memory
range managed by the buddy allocator (which must be in an accepted state),
they could also be outside that range and in an unaccepted state.

Since the kexec code will access the segments' destination addresses during
the kexec process by swapping their content with the segments' source
pages, it is necessary to accept the memory before performing the swap
operations.

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
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c0caa14880c3..f8eee0516bd9 100644
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
2.43.2


