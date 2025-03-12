Return-Path: <linux-kernel+bounces-557623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E514A5DBA6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CB11796C1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF718155389;
	Wed, 12 Mar 2025 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZbyesLY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA7F24166E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779295; cv=none; b=YzVKPERPg8hSNvbUBg+WAnaRGGKOs8/h0mkROkUov/V3iOa1BEOXrQlmoLznAOjSHr7rEYiagp6uOYpXeljmQTu8Ib3V7YwcvdKx2nH+ym5LIJCI54KFMaqRQcLLgkx/CFs86Q6u6F/YRlpTjq2dQjAdpdqwzTJ8bCD8+odXXuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779295; c=relaxed/simple;
	bh=sGbCY+YrXZbAygAc4GG+nRChDurFUrfw2J5bfC1dNLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2C9aUtRCi7L4C5Aj3iNqLAle5mpKkPHC3LIh+4lFUq362q35r8ovSkkBVdLtA6njfc+fOJjn7aXS5GNRpr8JbTomVPYlmWjeXnokJjRCbY49ss4r4Zk+GNEdUIAgU0/tokw15ZASBjXFIEH5roP+AJE/29xxbsJoTRWY+GSlI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZbyesLY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741779293; x=1773315293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sGbCY+YrXZbAygAc4GG+nRChDurFUrfw2J5bfC1dNLA=;
  b=hZbyesLY05Hn5mB6sHQP3wzGWY+0p6MpiZoJQE/F5FlJK7YAXrS642RI
   JbRgvmKVW9SkR9Xr5w8SmiPfLMHf0xSsf2OMHtfIz90UWs26TyUMdk6iD
   kd4DzdtLATIl1NSBZzMzUHdwjFeNHsCiDdSj7X5K726sbmTc+ErgF/XoM
   z5ZInV2mcxGSka/FmfD5LVFucF8lCjnR1zz1SStvwl60AkDpPORXO03GO
   BfU+GvnepmklsqTm/wFz66UrPIaZHjX159D6IYpd6NeMnyhKW4/FASIWP
   gihlmanxNwRxucRyoIH3xVpVCjJtckMzJ8W8BIuDkmp11SaEsIyh83GuS
   A==;
X-CSE-ConnectionGUID: RVT0LCDwR8yRVocASN6lNA==
X-CSE-MsgGUID: NcOZ673CSxyCVZOT4km8cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42985171"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="42985171"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:34:53 -0700
X-CSE-ConnectionGUID: TknHble/S1SswKOBX1NDqw==
X-CSE-MsgGUID: 21mz/lznQr6WSnMlaY46GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="124776063"
Received: from iweiny-desk3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.221.164])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 04:34:48 -0700
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
Subject: [RFC PATCH 3/5] x86/kexec: Disable kexec/kdump on platforms with TDX partial write erratum
Date: Thu, 13 Mar 2025 00:34:15 +1300
Message-ID: <408103f145360dfa04a41bc836ca2c724f29deb0.1741778537.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741778537.git.kai.huang@intel.com>
References: <cover.1741778537.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some early TDX-capable platforms have an erratum: A kernel partial
write (a write transaction of less than cacheline lands at memory
controller) to TDX private memory poisons that memory, and a subsequent
read triggers a machine check.

On those platforms, the old kernel must reset TDX private memory before
jumping to the new kernel, otherwise the new kernel may see unexpected
machine check.  Currently the kernel doesn't track which page is a TDX
private page.  For simplicity just fail kexec/kdump for those platforms.

Leverage the existing machine_kexec_prepare() to fail kexec/kdump by
adding the check of the presence of the TDX erratum (which is only
checked for if the kernel is built with TDX host support).  This rejects
kexec/kdump when the kernel is loading the kexec/kdump kernel image.

The alternative is to reject kexec/kdump when the kernel is jumping to
the new kernel.  But for kexec this requires adding a new check (e.g.,
arch_kexec_allowed()) in the common code to fail kernel_kexec() at early
stage.  Kdump (crash_kexec()) needs similar check, but it's hard to
justify because crash_kexec() is not supposed to abort.

It's feasible to further relax this limitation, i.e., only fail kexec
when TDX is actually enabled by the kernel.  But this is still a half
measure compared to resetting TDX private memory so just do the simplest
thing for now.

The impact to userspace is the users will get an error when loading the
kexec/kdump kernel image:

  kexec_load failed: Operation not supported

This might be confusing to the users, thus also print the reason in the
dmesg:

  [..] kexec: not allowed on platform with tdx_pw_mce bug.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/kernel/machine_kexec_64.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 0e9808eeb63e..e438c4163960 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -311,6 +311,22 @@ int machine_kexec_prepare(struct kimage *image)
 	unsigned long reloc_end = (unsigned long)__relocate_kernel_end;
 	int result;
 
+	/*
+	 * Some early TDX-capable platforms have an erratum.  A kernel
+	 * partial write (a write transaction of less than cacheline
+	 * lands at memory controller) to TDX private memory poisons that
+	 * memory, and a subsequent read triggers a machine check.
+	 *
+	 * On those platforms the old kernel must reset TDX private
+	 * memory before jumping to the new kernel otherwise the new
+	 * kernel may see unexpected machine check.  For simplicity
+	 * just fail kexec/kdump on those platforms.
+	 */
+	if (boot_cpu_has_bug(X86_BUG_TDX_PW_MCE)) {
+		pr_info_once("Not allowed on platform with tdx_pw_mce bug\n");
+		return -EOPNOTSUPP;
+	}
+
 	/* Setup the identity mapped 64bit page table */
 	result = init_pgtable(image, __pa(control_page));
 	if (result)
-- 
2.48.1


