Return-Path: <linux-kernel+bounces-557619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22883A5DBA1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500B7171E56
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BF523BD13;
	Wed, 12 Mar 2025 11:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJzEwRYp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8649155389
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779279; cv=none; b=TswnOoiXAVerXcvaPyW20BszeL1OsvVTcZAlk1QHoFHB6Hqx2agrzpDhro3VKrsjm5KhEigsO39PJnVZJIS2G++I9A6TzBpwYurXQfHRrdoSiq4K8p68uGstuki5m4HEb6Tg7De6xtyHZ/vxo2+IRFCXYRZwdMsn1U9e15ejv4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779279; c=relaxed/simple;
	bh=L0BGdmGDSv8Y5bf7d9tbNE/oKd7GKTE+M8lW/o8PGVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tedlx0BouB8bseMdRErrF+30SduJ5KKvUf2AuDYNh+Otf1jguRaKG85TjAuiBFN6FthkGP70uue559H3QFU9kd0FhGHHNo9xD+t2fZTq+FsuJ2YdSm+C1Yyzz5vlC6lEH6BA8j84OrrMrTmY6EOunoKE1kJKFRqLwlxWIbAUYJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJzEwRYp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741779277; x=1773315277;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L0BGdmGDSv8Y5bf7d9tbNE/oKd7GKTE+M8lW/o8PGVk=;
  b=CJzEwRYpUhY+0eMnvuZtuiXIBNlUOz+jBMotM8OrtxeRlJrcFuDZLSAP
   EcX4H+WeyVOsd0WgwF5azp1YGZf/q/GzGweXEktN02F1gYSpnhxAAhXLo
   X/dWZDjDloNyQuJ8OqINT2nm+gnOmkOe6czR1nDpjtmz2zI8rS7ZR1YA+
   HBU4PtNjF4alSZ6R1HqNMgC9hvCyXrmg0YWXtACldcyB51HSsED/y9L0v
   3fOdwRkoA+biPwrGz+qEwBbM22GhbLgjZ8VoduZkbHgpKEHFwqEWqhsux
   hVwoDKLZXVoQSN6oqg+DqlvFLVHQMzRO41gGah+c1/rsO1oQAAP9KPKT8
   A==;
X-CSE-ConnectionGUID: eu3FCZEHSHKPCO7ayaS9fw==
X-CSE-MsgGUID: 4sk2mO+/TTOTb0xeR82ZBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42985119"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42985119"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:34:37 -0700
X-CSE-ConnectionGUID: STY+9IJyS4CBf6YMC3gjrA==
X-CSE-MsgGUID: zi5kUTkjQcq0TpHw48NZSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="124775961"
Received: from iweiny-desk3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.221.164])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:34:32 -0700
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	bp@alien8.de,
	tglx@linutronix.de,
	peterz@infradead.org,
	mingo@redhat.com,
	kirill.shutemov@linux.intel.com
Cc: hpa@zytor.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	reinette.chatre@intel.com,
	isaku.yamahata@intel.com,
	dan.j.williams@intel.com,
	thomas.lendacky@amd.com,
	ashish.kalra@amd.com,
	dwmw@amazon.co.uk,
	bhe@redhat.com,
	nik.borisov@suse.com,
	sagis@google.com
Subject: [RFC PATCH 0/5] TDX host: kexec/kdump support
Date: Thu, 13 Mar 2025 00:34:12 +1300
Message-ID: <cover.1741778537.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dave,

This series is not ready for your review, but we want to move the
discussion external at this point.  Please feel free to ignore it until
we get it a bit more polished.

-----------------------------------------------------------------------

TDX hosts do not currently support kexec.  CONFIG_KEXEC_CORE must be
disabled in order to enable CONFIG_INTEL_TDX_HOST.  This is not
acceptable to distros at least Redhat since they want both to be turned
on.  There are other customers who want to use kexec together with TDX.

This series adds TDX host kexec support.  With CONFIG_KEXEC_CORE and
CONFIG_INTEL_TDX_HOST both enabled, a TDX enabled kernel can kexec into
a new kernel and the kdump (crash kexec) can work as normal.

One limitation is if the old kernel has ever enabled TDX, the new kernel
cannot use TDX.  This is a future work.

One exception is that kexec/kdump is disabled when the platform has the
TDX "partial write machine check" erratum (and when the
CONFIG_INTEL_TDX_HOST is turned on).  See below for more information.

This was supposed to be a v8, but I tagged this series as RFC because
in the recent internal review I feel there's one point regarding the use
of MOVDIR64B to reset TDX private memory that I want to get feedback on
the list.  Please see section "2) Reset TDX private memory using
MOVDIR64B" below for more information.

v7 -> this RFC: 

The major change is, for the sake of keeping code change minimal, I
removed the patches which handle resetting TDX private memory to make
kexec work with the TDX erratum.  Instead, add a patch to simply disable
kexec/kdump for such platforms.

v7: https://lore.kernel.org/lkml/cover.1727179214.git.kai.huang@intel.com/

=== More information ===

TDX private memory is memory that is encrypted with private Host Key IDs
(HKID).  If the kernel has ever enabled TDX, part of system memory
remains TDX private memory when kexec happens.  E.g., the PAMT (Physical
Address Metadata Table) pages used by the TDX module to track each TDX
memory page's state are never freed once the TDX module is initialized.
TDX guests also have guest private memory and secure-EPT pages.

After kexec, the new kernel will have no knowledge of which memory page
was used as TDX private page and can use all memory as regular memory.

1) Cache flush

Per TDX 1.5 base spec "8.6.1.Platforms not Using ACT: Required Cache
Flush and Initialization by the Host VMM", to support kexec for TDX, the
kernel needs to flush cache to make sure there's no dirty cachelines of
TDX private memory left over to the new kernel (when the TDX module
reports TDX_FEATURES.CLFLUSH_BEFORE_ALLOC as 1 in the global metadata for
the platform).  The kernel also needs to make sure there's no more TDX
activity (no SEAMCALL) after cache flush so that no new dirty cachelines
of TDX private memory are generated.

SME has similar requirement.  SME kexec support uses WBINVD to do the
cache flush.  WBINVD is able to flush cachelines associated with any
HKID.  Reuse the WBINVD introduced by SME to flush cache for TDX.

Currently the kernel explicitly checks whether the hardware supports SME
and only does WBINVD if true.  Instead of adding yet another TDX
specific check, this series does unconditional WBINVD for bare-metal for
code simplicity since kexec is a slow path.

2) Reset TDX private memory using MOVDIR64B

The TDX spec (the aforementioned section) also suggests the kernel
*should* use MOVDIR64B to clear TDX private page before the kernel
reuses it as regular one.

However, in reality the situation can be more flexible.  Per TDX 1.5
base spec ("Table 16.2: Non-ACT Platforms Checks on Memory Reads in Ci
Mode" and "Table 16.3: Non-ACT Platforms Checks on Memory Reads in Li
Mode"), the read/write to TDX private memory using shared KeyID without
integrity check enabled will not poison the memory and cause machine
check.

Note on the platforms with ACT (Access Control Table), there's no
integrity check involved thus no machine check is possible to happen due
to memory read/write using different KeyIDs.

Since it is not trivial to reset TDX private memory, this series assumes
KeyID 0 doesn't have integrity check enabled, and chooses to NOT reset
TDX private memory but leave TDX private memory as-is to the new kernel.
As mentioned above, in practice it is safe to do so.

The worst case is someday Intel decides to enable integrity check for
KeyID 0 for some new platforms, and the impact is the old kernels
running on those platforms may get machine check after kexec.  But this
change will not happen silently.  We can have a patch to reset TDX
private memory for those platforms and backport to stable.  In the
meantime, we can enjoy the performance gain until that happens.

3) One limitation

If the kernel has ever enabled TDX, after kexec the new kernel won't be
able to use TDX anymore.  This is because when the new kernel tries to
initialize TDX module it will fail on the first SEAMCALL due to the
module has already been initialized by the old kernel.

More (non-trivial) work will be needed for the new kernel to use TDX,
e.g., one solution is to just reload the TDX module from the location
where BIOS loads the TDX module (/boot/efi/EFI/TDX/).  This series
doesn't cover this, but leave this as future work.

4) Kdump support

This series also enables kdump with TDX, but no special handling is
needed for crash kexec (except turning on the Kconfig option):

 - kdump kernel uses reserved memory from the old kernel as system ram,
   and the old kernel will never use the reserved memory as TDX memory.
 - /proc/vmcore contains TDX private memory pages.  It's meaningless to
   read them, but it doesn't do any harm either.

5) TDX "partial write machine check" erratum

On the platform with TDX erratum, a partial write (a write transaction
of less than a cacheline lands at memory controller) to TDX private
memory poisons that memory, and a subsequent read triggers machine
check.  On those platforms, the kernel needs to reset TDX private memory
before jumping to the new kernel otherwise the new kernel may see
unexpected machine check.

The kernel currently doesn't track which page is TDX private memory.
It's not trivial to reset TDX private memory.  For simplicity, this
series simply disables kexec/kdump for such platforms.  This will be
enhanced in the future.


Kai Huang (5):
  x86/kexec: Do unconditional WBINVD for bare-metal in stop_this_cpu()
  x86/kexec: Do unconditional WBINVD for bare-metal in relocate_kernel()
  x86/kexec: Disable kexec/kdump on platforms with TDX partial write
    erratum
  x86/virt/tdx: Remove the !KEXEC_CORE dependency
  x86/virt/tdx: Update the kexec section in the TDX documentation

 Documentation/arch/x86/tdx.rst       | 17 +++++++++-------
 arch/x86/Kconfig                     |  1 -
 arch/x86/include/asm/kexec.h         |  2 +-
 arch/x86/kernel/machine_kexec_64.c   | 30 ++++++++++++++++++++--------
 arch/x86/kernel/process.c            | 21 +++++++++----------
 arch/x86/kernel/relocate_kernel_64.S | 15 +++++++++-----
 6 files changed, 54 insertions(+), 32 deletions(-)

-- 
2.48.1


