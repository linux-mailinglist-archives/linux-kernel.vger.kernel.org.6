Return-Path: <linux-kernel+bounces-407521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C5B9C6E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50FF71F21243
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2B7200CA7;
	Wed, 13 Nov 2024 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJwySx2O"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A4F20400B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499077; cv=none; b=ikStqROOrr7cfYz+IcF9u5srP1s8CA5av9YK5Jj9ZM4el8mXf1V1JnUfDdWHzJMPZhR3BdKhLMtryZ7WUSAy3hldEaSOsAHgAE7vmxu8INuIe9YtUKd/ARBGoG8jv/8yWpt+90/JxynFMuTW8z8RSLyp65jg+7F9qWbXC5hH8Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499077; c=relaxed/simple;
	bh=xC5/zJL1RLVLXEbALQImKDQiKww6NEisk/Qv8MnNTfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSE45AM7iBvPVqw3kn1/7A36rd2qFManqqWFZTJMwWKxmDWCAtGLOrbCvtqu5xDDIq4dQKdTt3EKicbRnQyhxj3UwMIYzQRRNDNb5HFohoL/E7qBS2yc44NeqC/4UnOIG8E/2/nzl+Nie8gOf3nBrRJXXGmWP79cOfmk2r3hBu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJwySx2O; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731499076; x=1763035076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xC5/zJL1RLVLXEbALQImKDQiKww6NEisk/Qv8MnNTfA=;
  b=BJwySx2ODzQqzYg7x8+SuEn6Wg7auuX9Z607tlkyZCvh+8UbcFEBCerq
   H5w1964a6l5IoyJ7dfAcfTDHYaupWZZQFead+VC5ugg5iX95noueBcnUk
   OKDddNxmAkREuWKARrw6bHypyG08k84DDsCJhGMtSEiaX1em/zmExecEA
   NnQNzSULbAMhicHrwGNCqQLsUJWDw7ssYnKJo8IHntrzIXtgzYKrLGGkt
   c3T69rtrHXSKpPSrxCHc2NfA6S05nl0SK89/n6Bq/r9l7xeSmsN03M5D5
   3/4YH9y+pDpyDIzR8Qwf3EBhcJ0H9FyNFZ+9TZUeY/ZxrxjvIMm4PQE3F
   A==;
X-CSE-ConnectionGUID: Ex3IoDfkR867gJ2/XsEzyQ==
X-CSE-MsgGUID: zEyWZUTJRP+77bCnyiPBWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31630847"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="31630847"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 03:57:52 -0800
X-CSE-ConnectionGUID: gz/XqoyNQ8uKO3vO4o/m1A==
X-CSE-MsgGUID: PweW+/xdR5CyZbvK8oN8/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="92323567"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.220.169])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 03:57:48 -0800
From: Kai Huang <kai.huang@intel.com>
To: dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	peterz@infradead.org,
	mingo@redhat.com,
	hpa@zytor.com,
	dan.j.williams@intel.com,
	seanjc@google.com,
	pbonzini@redhat.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	rick.p.edgecombe@intel.com,
	isaku.yamahata@intel.com,
	adrian.hunter@intel.com,
	nik.borisov@suse.com,
	kai.huang@intel.com
Subject: [PATCH v8 7/9] x86/virt/tdx: Trim away tail null CMRs
Date: Thu, 14 Nov 2024 00:57:12 +1300
Message-ID: <f8831fdeb4664b6cfb7ca83760207a22f49f70c1.1731498635.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1731498635.git.kai.huang@intel.com>
References: <cover.1731498635.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TDX architecturally supports up to 32 CMRs.  The global metadata field
"NUM_CMRS" reports the number of CMR entries that can be read by the
kernel.  However, that field may just report the maximum number of CMRs
albeit the actual number of CMRs is smaller, in which case there are
tail null CMRs (size is 0).

A future fix to a module initialization failure issue will need to loop
over all CMRs.  Trim away those null CMRs once for all here so that the
kernel doesn't need to explicitly skip them each time when it uses CMRs
at later times.

More information about CMR can be found at "Intel TDX ISA Background:
Convertible Memory Ranges (CMRs)" in TDX 1.5 base spec [1], and
"CMR_INFO" in TDX 1.5 ABI spec [2].

Now get_tdx_sys_info() just reads kernel-needed global metadata to
kernel structure, and it is auto-generated.  Add a wrapper function
init_tdx_sys_info() to invoke get_tdx_sys_info() and provide room to do
additional things like dealing with CMRs.

Link: https://cdrdv2.intel.com/v1/dl/getContent/733575 [1]
Link: https://cdrdv2.intel.com/v1/dl/getContent/733579 [2]
Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 42 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 43ec56db5084..5e6d8021681d 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -272,6 +272,46 @@ static int read_sys_metadata_field(u64 field_id, u64 *data)
 
 #include "tdx_global_metadata.c"
 
+/* Update the @sysinfo_cmr->num_cmrs to trim tail null CMRs */
+static void trim_null_tail_cmrs(struct tdx_sys_info_cmr *sysinfo_cmr)
+{
+	int i;
+
+	/*
+	 * The TDX module may report the maximum number of CMRs that
+	 * TDX architecturally supports as the actual number of CMRs,
+	 * despite the latter is smaller.  In this case some tail
+	 * CMR(s) will be null (size is 0).  Trim them away.
+	 *
+	 * Note the CMRs are generated by the BIOS, but the MCHECK
+	 * verifies CMRs before enabling TDX on hardware.  Skip other
+	 * sanity checks (e.g., verify CMR is 4KB aligned) but trust
+	 * MCHECK to work properly.
+	 *
+	 * The spec doesn't say whether it's legal to have null CMRs
+	 * in the middle of valid CMRs.  For now assume no sane BIOS
+	 * would do that (even MCHECK allows).
+	 */
+	for (i = 0; i < sysinfo_cmr->num_cmrs; i++)
+		if (!sysinfo_cmr->cmr_size[i])
+			break;
+
+	sysinfo_cmr->num_cmrs = i;
+}
+
+static int init_tdx_sys_info(struct tdx_sys_info *sysinfo)
+{
+	int ret;
+
+	ret = get_tdx_sys_info(sysinfo);
+	if (ret)
+		return ret;
+
+	trim_null_tail_cmrs(&sysinfo->cmr);
+
+	return 0;
+}
+
 /* Calculate the actual TDMR size */
 static int tdmr_size_single(u16 max_reserved_per_tdmr)
 {
@@ -1051,7 +1091,7 @@ static int init_tdx_module(void)
 	struct tdx_sys_info sysinfo;
 	int ret;
 
-	ret = get_tdx_sys_info(&sysinfo);
+	ret = init_tdx_sys_info(&sysinfo);
 	if (ret)
 		return ret;
 
-- 
2.46.2


