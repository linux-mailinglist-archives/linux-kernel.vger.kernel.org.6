Return-Path: <linux-kernel+bounces-337122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9E99845AF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9A78B22025
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19981A76AB;
	Tue, 24 Sep 2024 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XszwyB3X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4391A76A2
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180054; cv=none; b=EQt1ZPsl16ul4KLt3tjp6dhTuWFlqaM1xh+BWbKKsAOYiZZs/dPGXsjreUvJFW4FrHPFvLMaBusvsPy7dpixWXKRDlYsbvg03U7jZbvYZzSmnpyKZYo9ZSTk8Bo4pDUhOqov2UVimVpCzbBjxFO6/GpyerIOxYAOTKI4Jn+ExoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180054; c=relaxed/simple;
	bh=tKJSo0NsHUwZOvzv4BX5E3C1d/QwQCqmgt08a19Z0Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bbEtkBZqTQ5hUIS/Bjr4plxpXWc64Ls7zkGACkzAEaryyclfAI5lGtgn9pYNZlypByeArzE44fMSL6Y9QMyHNSJnY8ErYcOV7Uc0VRf1MuZJHTwCPfkk46Mt167nGqokddjEHYaJwBQdwSnJ5JBRcv3Fymr/FYX9DF8EQ6diuCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XszwyB3X; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727180052; x=1758716052;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tKJSo0NsHUwZOvzv4BX5E3C1d/QwQCqmgt08a19Z0Q4=;
  b=XszwyB3XXXh3BdjUK/ZfZz64WtrbfeNSg970bSQNwjC7swLIHHJgP+uE
   tUIiZDuaGHwy/y0C3gfoSJqMme+GZ5uSOIx/01KmVoE20YMnchYZc0Y03
   pDOw1ylu+8jzvc0SFdLKU/hmEXpiptwOYL3PfnHjRVqyVPdUHp3uv7oYT
   Kvs+I4cOCOGGQ+r0XNXH50IR1jRb4r5aX9exDBZvK8fRrx5N+UeRN+BAD
   +YtbTy7NfmZgEAg6qWvaqVQUD7PDlYzd9sCFlQy87d0eKZ8DiLNWqqJ/U
   J0KwRvHhVe6IgdSKXYb7nLOA5oVbn37+pBp91oao3xw2sjCMFRv84M984
   A==;
X-CSE-ConnectionGUID: 5OAnQwDUQyS+skd/S+OlnQ==
X-CSE-MsgGUID: SUKKQnxdRNm2tI3PhPgzLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="29881833"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="29881833"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 05:14:11 -0700
X-CSE-ConnectionGUID: +7WUg0VNR/So0k3O9Cqc6Q==
X-CSE-MsgGUID: fX0+SzsjTPKvYRQmxipqUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="71473230"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.221.10])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 05:14:07 -0700
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org,
	mingo@redhat.com,
	hpa@zytor.com,
	kirill.shutemov@linux.intel.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	dan.j.williams@intel.com,
	thomas.lendacky@amd.com,
	rick.p.edgecombe@intel.com,
	isaku.yamahata@intel.com,
	ashish.kalra@amd.com,
	bhe@redhat.com,
	nik.borisov@suse.com,
	sagis@google.com
Subject: [PATCH v7 0/5] TDX host: kexec() support
Date: Wed, 25 Sep 2024 00:13:52 +1200
Message-ID: <cover.1727179214.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently kexec() support and TDX host are muturally exclusive in the
Kconfig.  This series adds the TDX host kexec support so that they can
be both enabled in Kconfig.

With this series, the user can kexec (including crash kdump) to the new
kernel at any time regardless of whether TDX has been enabled in the
first kernel.  One limitation is if the first kernel has ever enabled
TDX, for now the second kernel cannot use TDX.  This is the future work
in my TODO list.

Hi maintainers,

This series aims to go through the tip tree, but I also CC'ed Sean/Paolo
due to when KVM TDX comes to play a KVM patch [*] is needed to complete
the kexec support for TDX.  Also copy Dan for TDX connect.

Thanks for your time!

v6 -> v7:
 - Address one comment (add a comment) from David Kaplan, and added his
   Tested-by for patch 2.
 - Change to use "Link: <permalink>" in patch 1.

 v6: https://lore.kernel.org/lkml/cover.1725868065.git.kai.huang@intel.com/T/ 

v5 -> v6:

 - Fixed the issue when rebasing to latest tip/master, conflicting with
   commit 93c1800b3799 ("x86/kexec: Fix bug with call depth tracking").
 - Use cpu_feature_enabled() instead of boot_cpu_has() -- Boris.
 - Improve the coverletter to point out if the first kernel has enabled
   TDX the second kernel cannot use TDX anymore, and this will be a
   future work (as asked by Sagi in the v5).

 v5: https://lore.kernel.org/all/47dbc3b5dd6bd7cc3fa94ffe770e22419daf1d01.camel@intel.com/T/

v4 -> v5:
 - Rebase to tip/master.
 - Remove the TDX-specific callback due to no need to reset TDX private
   memory for crash kexec.
 - Add a new patch to make module status immutable in reboot notifier
   (split from v1) in order to use module status to tell the presence of
   TDX private memory.
 - Minor changelog updates, trivial comments improvements.
 - Add Tom's Reviewed-by tag.

 v4: https://lore.kernel.org/all/cover.1713439632.git.kai.huang@intel.com/

v3 -> v4:
 - Updated changelog and comments of patch 1/2 per comments from
   Kirill and Tom (see specific patch for details).

 v3: https://lore.kernel.org/linux-kernel/cover.1712493366.git.kai.huang@intel.com/

v2 -> v3:
 - Change to only do WBINVD for bare-metal, as Kirill/Tom pointed out
   WBINVD in TDX guests and SEV-ES/SEV-SNP guests triggers #VE.

 v2: https://lore.kernel.org/linux-kernel/cover.1710811610.git.kai.huang@intel.com/

v1 -> v2:
 - Do unconditional WBINVD during kexec() -- Boris
 - Change to cover crash kexec() -- Rick
 - Add a new patch (last one) to add a mechanism to reset all TDX private
   pages due to having to cover crash kexec().
 - Other code improvements  -- Dave
 - Rebase to latest tip/master.

 v1: https://lore.kernel.org/linux-kernel/cover.1706698706.git.kai.huang@intel.com/

=== More information ===

If the kernel has ever enabled TDX, part of system memory remains TDX
private memory when kexec happens.  E.g., the PAMT (Physical Address
Metadata Table) pages used by the TDX module to track each TDX memory
page's state are never freed once the TDX module is initialized.  TDX
guests also have guest private memory and secure-EPT pages.

Similar to AMD SME, to support kexec the kernel needs to flush dirty
cachelines for TDX private memory before booting to the second kernel.
Also, the kernel needs to reset TDX private memory to normal (using
MOVDIR64B) before booting to the second kernel when the platform has
"partial write machine check" erratum, otherwise the second kernel may
see unexpected machine check.

The majority code change in this series handles "resetting TDX private
memory" (flushing cache part is relatively straightforward).  Due to
currently the kernel doesn't have a unified way to tell whether a given
page is TDX private or not, this series chooses to only reset PAMT in
the core-kernel kexec code, but requires the in-kernel TDX users (e.g.,
KVM to reset the TDX private pages that they manage (see [*]).

This series also covers crash kexec, but no special handling is needed
for crash kexec:

1) kdump kernel uses reserved memory from the first kernel, but the
   reserved memory will never be used as TDX memory.
2) /proc/vmcore in the kdump kernel will only be used for read, but read
   itself won't poison TDX private memory thus won't cause unexpected
   machine check (only "partial write" will).

Note, if the first kernel has ever enabled TDX, after kexec the second
kernel for now cannot use TDX anymore.  This is because when the second
kernel tries to initialize TDX module it fails on the first SEAMCALL.

More (non-trivial) work will be needed for the second kernel to use TDX,
e.g., one solution is to just reload the TDX module from the location
where BIOS loads the TDX module (/boot/efi/EFI/TDX/).  This series
doesn't cover this, but leave this as future work.


[*]: https://github.com/intel/tdx/commit/f5ef6cf63e34c5364cd88df52f91f05e72cb49b2



Kai Huang (5):
  x86/kexec: do unconditional WBINVD for bare-metal in stop_this_cpu()
  x86/kexec: do unconditional WBINVD for bare-metal in relocate_kernel()
  x86/virt/tdx: Make module initializatiton state immutable in reboot
    notifier
  x86/kexec: Reset TDX private memory on platforms with TDX erratum
  x86/virt/tdx: Remove the !KEXEC_CORE dependency

 arch/x86/Kconfig                     |  1 -
 arch/x86/include/asm/kexec.h         |  2 +-
 arch/x86/include/asm/tdx.h           |  2 +
 arch/x86/kernel/machine_kexec_64.c   | 37 +++++++++----
 arch/x86/kernel/process.c            | 19 ++++---
 arch/x86/kernel/relocate_kernel_64.S | 19 +++++--
 arch/x86/virt/vmx/tdx/tdx.c          | 78 ++++++++++++++++++++++++++++
 7 files changed, 132 insertions(+), 26 deletions(-)


base-commit: a6f489fee2633f8595934a850981bd4284abdbba
-- 
2.46.0


