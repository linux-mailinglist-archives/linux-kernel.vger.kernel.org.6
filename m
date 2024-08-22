Return-Path: <linux-kernel+bounces-297053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B09395B258
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA441C21157
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E9C13AF2;
	Thu, 22 Aug 2024 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iYJcnamx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6AE15C13A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724320292; cv=none; b=GXH3Ci2jGqjtISkQiedVotzttV1aaLkv806Nr2Wh6XAuC/ejke+ScLwmLG87rE9R80xy4kAbGsEuaif09VH8cvUUcPi/AXuiQVhHE+72nnw90OIdFEtJRbcdkabRpVPD8jHA9U/kMY0+wNSQwxEl1/iqiAFB7VBBSlA5+QUmdvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724320292; c=relaxed/simple;
	bh=tm4KVTgxOb1hR5BQxnaBJKucNvgA+yEul7CT9atCQyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d4ENmgnTLRRlOaAAaqDhjkQjsMVYyagdhvYGIMyPNkRPMqktHPaquJWwl0Klck9MRIQOvkfs9HJ89LFpYZJB444CV62cIqyGmBxS1roOWwyHlAIOYc9Uaj5iIyyCownvnouvqtFQGAiYCu0w7JkBbXAvBoUO14/8MynNZAxMV04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iYJcnamx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724320291; x=1755856291;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tm4KVTgxOb1hR5BQxnaBJKucNvgA+yEul7CT9atCQyE=;
  b=iYJcnamxEFK6lnmWb5vWK2SV4NDEeeikFxRZa721C0vCF1Wq0E9HSvkq
   IFIZoFOniIOLEzgURER+eAhRQgN+mRBAr+WpoHeWarqQUXG23j/NiNaWa
   v3Gpac3qR18w58GJE1FKIOETMZjmGhvjA6EbRkTiSziq5YhAsGDWOJs0w
   YO+iM9ewxdfPPfxifgtqfDDVI3eiyhkaUT79/OxsUb2GdU5scNxuMzbFo
   LFAqcSy+XNUEFxatMqo+4SJqsk7l7RVgF4FbQSW3bK7JgpadAszAo3oFS
   8nS8TF2KelJ9Pa5l/CQyU/cU++eDfSy0blcbQZE3VzW1vXGBtcMlMz6wF
   Q==;
X-CSE-ConnectionGUID: iKpAARj/SZ6jj7otsZdi1w==
X-CSE-MsgGUID: nFFiaNQ7QnyR46ntmLO+/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="25618287"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="25618287"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 02:51:30 -0700
X-CSE-ConnectionGUID: aq3hJjzIRwqV/Nmr7di1xQ==
X-CSE-MsgGUID: XK5avY4PQ468FXJEBQTz/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="62112301"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 22 Aug 2024 02:51:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A359A49F; Thu, 22 Aug 2024 12:51:25 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [PATCH] x86/tdx: Fix crash on kexec with CONFIG_EISA
Date: Thu, 22 Aug 2024 12:51:22 +0300
Message-ID: <20240822095122.736522-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDX has concept of private and shared memory. Private memory is
protected from VMM and shared is used for communication between guest
and host. Shared memory is mapped into guest with shared bit set in the
page table entry.

Normally memory got converted from private to shared with MapGPA
TDVMCALL before it got accessed. However, what is supposed to happen
when private memory is accessed via shared mapping is not defined.
It is left up to the VMM to decide.

This is problematic. Currently, KVM implicitly converts memory to shared
and removes the page from the secure EPT, so subsequent access via private
mapping leads to a crash.

This issue causes real problems:

1. If the kernel is compiled with EISA support, it will attempt to probe
   EISA by reading 4 bytes from the 0x0FFFD9 address (see eisa_bus_probe()).
   The kernel treats this read as MMIO and accesses this memory via
   shared mapping as we do for MMIO.

   KVM converts memory to shared upon such access.

2. The same memory range (0xF0000-0x100000) is scanned to look for the MP
   table (see mpparse_find_mptable()). However, this is not MMIO and it
   is accessed via private mapping.

   This will cause a crash if the memory is not private.

During normal boot, the kernel scans for SMP information before probing
for EISA, and it boots fine. However, the memory becomes shared and causes
issues on kexec when the second kernel attempts to scan for SMP information.

TDX behaviour on access of private memory via shared mapping has to be
clarified to avoid such crashes in the future. It takes time.

In meanwhile, avoid probing EISA for TDX guest.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/kernel/eisa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/eisa.c b/arch/x86/kernel/eisa.c
index 53935b4d62e3..678244d178b6 100644
--- a/arch/x86/kernel/eisa.c
+++ b/arch/x86/kernel/eisa.c
@@ -13,7 +13,9 @@ static __init int eisa_bus_probe(void)
 {
 	void __iomem *p;
 
-	if ((xen_pv_domain() && !xen_initial_domain()) || cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+	if ((xen_pv_domain() && !xen_initial_domain()) ||
+	    cc_platform_has(CC_ATTR_GUEST_SEV_SNP) ||
+	    cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
 		return 0;
 
 	p = ioremap(0x0FFFD9, 4);
-- 
2.43.0


