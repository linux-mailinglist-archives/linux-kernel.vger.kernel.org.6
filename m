Return-Path: <linux-kernel+bounces-444537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404E49F0884
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499C716314A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B551B413D;
	Fri, 13 Dec 2024 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SiS1nwZj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B411AB52F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083544; cv=none; b=sauEYF45YWh3bv6+MWUbVylBYWkG2AHs4ZFz63DrkaTEAjwnZymmwQW/3+NlN1GsjkJinu6nQGnK2vNOWQ3kz18BPZYyT9xitNNL1lfKOf/J8pPO9xSykEaWFLcwFnveX190d39gGFoiQs2rJfbqGcod4k23Y5Q24UQ0Ck8BtGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083544; c=relaxed/simple;
	bh=xwlk6T0nmyV++vOWX/z4H8mtusZ/0NhrBUoKvYKhCZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQpoG1ttYluC5DGMjgqUfWncV7l5dOvtZKYgl6aLqD1f5sc1qStCaZsMavMi7zPREXr90rN6PtH5du8b/JpDVR2uOyaYSuwFk0xLkZSahXQXq7umOtdpw1CgrGGCmIwwLfkRgG0c5/idnbakQ4l+y54HMNebs5a+Mn3cvvhojFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SiS1nwZj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734083543; x=1765619543;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xwlk6T0nmyV++vOWX/z4H8mtusZ/0NhrBUoKvYKhCZM=;
  b=SiS1nwZj3cYMW2Sllzp6H1xXll+E4lbTveq+bSraneH4XkMzS2JmurhW
   NVnO0M1sCne+SWNjpOQrpcAWlp0ydP3XtwJkYQ+2IFdBmDugAZwuaSMlB
   eLxiqon2rb8yjUVXfmIbbDa7aJjRQeZCbApslfvMHGcgmh0EllUkIaK3m
   /Pw959G7zRk49o5vxiKDssnTDAGi61CTzVnD0SOrmDp7H1iKnUEbw6QNv
   KtZo4UESxFq7wFy4RRl06V5JcSnsR8prgcQSMs0jhJpiZ/tc7aKWi0jXg
   yUAOWgo4O3YhRGkVTnovdEtToQRL09EGfR27DCW7vsKYC0bKSGxrS2DvM
   Q==;
X-CSE-ConnectionGUID: b56/TcvySBiRQFwVEBjN/Q==
X-CSE-MsgGUID: RzcgfbOLT1imQ89TdJ2Aew==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="38208347"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="38208347"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 01:52:23 -0800
X-CSE-ConnectionGUID: RbaQtVoiRRCjzNuo9wo9dw==
X-CSE-MsgGUID: xampagART3u7nhSiZyDG4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="96394961"
Received: from yzhao56-desk.sh.intel.com ([10.239.159.62])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 01:52:19 -0800
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
Subject: [PATCH v2 0/1] Accept unaccepted kexec segments' destination addresses
Date: Fri, 13 Dec 2024 17:49:30 +0800
Message-ID: <20241213094930.748-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Eric,

This is a repost of the patch "kexec_core: Accept unaccepted kexec
destination addresses" [1], rebased to v6.13-rc2.

The code implementation remains unchanged, but the patch message now
includes more background and explanations to address previous concerns from
you and Baoquan.

Additionally, below is a more detailed explanation of unaccepted memory in
TDX. Please let me know if it is still not clear enough.


== UnAccepted memory in TDX ==

Intel TDX (Trusted Domain Extension) provides a hardware-based trusted
execution environment for TDs (hardware-isolated VMs). The host OS is not
trusted. Although it allocates physical pages for TDs, it does not and
cannot know the content of TD's pages.

TD's memory is added via two methods by invoking different instructions in
the host:
1. For TD's initial private memory, such as for firmware HOBs:
   - This type of memory is added without requiring the TD's acceptance.
   - The TD will perform attestation of the page GPA and content later.

2. For TD's runtime private memory:
   - After the host adds memory, it is pending for the TD's acceptance.

Memory added by method 1 is not relevant to the unaccepted memory we will
discuss.

For memory added by method 2, the TD's acceptance can occur before or after
the TD's memory access:
(a) Access first:
    - TD accesses a private GPA,
    - Host OS allocates physical memory,
    - Host OS requests hardware to map the physical page to the GPA,
    - TD accepts the GPA.

(b) Accept first:
    - TD accepts a private GPA,
    - Host OS allocates physical memory,
    - Host OS requests hardware to map the physical page to the GPA,
    - TD accesses the GPA.

For "(a) Access first", it is regarded as unsafe for a Linux guest and is
therefore not chosen.
For "(b) Accept first", the TD's "accept" operation includes the following
steps:
- Trigger a VM-exit
- The host OS allocates a physical page and requests hardware to map the
  physical page to the GPA.
- Initialize the physical page with content set to 0.
- Encrypt the memory 


To enable the "Accept first" approach, an "unaccepted memory" mechanism is
used, which requires cooperation from the virtual firmware and the Linux
guest.

1. The host OS adds initial private memory that does not require TD's
   acceptance. The host OS composes EFI_HOB_RESOURCE_DESCRIPTORs and loads
   the virtual firmware first. Guest RAM, excluding that for initial
   memory, is reported as UNACCEPTED in the descriptor.

2. The virtual firmware parses the descriptors and accepts the UNACCEPTED
   memory below 4G. It then excludes the below-4G range from the UNACCEPTED
   range.

3. The virtual firmware loads the Linux guest image (the address to load is
   below 4G).

4. The Linux guest requests the UNACCEPTED bitmap from the virtual
   firmware:
   - Locate EFI_UNACCEPTED_MEMORY entries from the memory map returned by
     the efi_get_memory_map boot service.
   - Request via EFI boot service to allocate an unaccepted_table in memory
     of type EFI_ACPI_RECLAIM_MEMORY (E820_TYPE_ACPI) to hold the
     unaccepted bitmap.
   - Install the unaccepted_table as an EFI configuration table via the
     boot service.
   - Initialize the unaccepted bitmap according to the
     EFI_UNACCEPTED_MEMORY entries.

5. The Linux guest decompresses the kernel image. It accepts the target GPA
   for decompression first in case it is not accepted by the virtual
   firmware.

6. The Linux guest calls memblock_free_all() to put all memory into the
   freelists for the buddy allocator. memblock_free_all() further calls
   down to __free_pages_core() to handle memory in 4M (order 10) units.

  - In eager mode, the Linux guest accepts all memory and appends it to the
    freelists.
  - In lazy mode, the Linux guest checks if the entire 4M memory has been
    accepted by querying the unaccepted bitmap.
    a) If all memory is accepted, it adds the 4M memory to the freelists.
    b) If any memory is unaccepted (even if the range contains accepted
       pages), the Linux guest does not add the 4M memory to the freelists.
       Instead, it queues the first page in the 4M range onto the list
       zone->unaccepted_pages and sets the first page with the Unaccepted
       flag.

7. When there is not enough free memory, cond_accept_memory() in the Linux
   guest calls try_to_accept_memory_one() to dequeue a page from the list
   zone->unaccepted_pages, clear its Unaccepted flag, accept the entire 4M
   memory range represented by the page, and add the 4M memory to the
   freelists.


== Conclusion ==
- The zone->unaccepted_pages is a mechanism to conditionally make accepted
  private memory available to the page allocators.
- The unaccepted bitmap resides in the firmware's reserved memory and
  persists across guest OSs. It records exactly which pages have not been
  accepted.
- Memory ranges represented by zone->unaccepted_pages may contain accepted
  pages.


For kexec in TDs,
- If the segments' destination addresses are within the range managed by
  the buddy allocator, the pages must have been in an accepted state.
  Calling accept_memory() will check the unaccepted bitmap and do nothing.
- If the segments' destination addresses are not yet managed by the buddy
  allocator, the pages may or may not have been accepted.
  Calling accept_memory() will perform the "accept" operation if they are
  not accepted.

For the kexec's second guest kernel, it obtains the unaccepted bitmap by
locating the unaccepted_table in the EFI configuration tables. So, pages
unset in the unaccepted bitmap are not accepted repeatedly.


The unaccepted table/bitmap is only useful for TDs. For a Linux host, it
will detect that the physical firmware does not support the memory
acceptance protocol, and accept_memory() will simply bail out.

Thanks
Yan

[1] https://lore.kernel.org/all/20241021034553.18824-1-yan.y.zhao@intel.com

Yan Zhao (1):
  kexec_core: Accept unaccepted kexec segments' destination addresses

 kernel/kexec_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.43.2


