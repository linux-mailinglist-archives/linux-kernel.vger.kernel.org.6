Return-Path: <linux-kernel+bounces-446082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 574BA9F1FA0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 16:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BC7F7A0F58
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 15:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5142C1AB517;
	Sat, 14 Dec 2024 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6NEnUA1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA87195FE5
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734189408; cv=none; b=lTD5cvXz8GQVfaDHjVKh2ZGgz/LADZXEQ8ucNu8SsHz3UgU2tVjEpWE0dbFdZ0iX3ynLY9wmz6uH95rX6UPNc10gfXhpLMyINyLGPNx9ImqtO+sFr6Nk0id/e/E/DA9+kUejmK+8vAmBtlsT11Do78Bb4ONhk/JppjH5zjVxF/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734189408; c=relaxed/simple;
	bh=KK8X38CNscfJpPfeQuOnllEfBhSvoC4tkCFHMTuag6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVNDIYBqqEfZjiYUKqIGP3XTV8klUQziZkapFiZBYsTPlXD/8v0oikMXzyLITi1SiSVQC62B7j3Lr55qDHiLHz1sxJ1LDAZEIds6vRzP1Cju4MBo/Qer72H1cvoxgrBsGV/NWt5a6clgGCCkul0EA+FCBfw6DBQIUWiHt6wu4DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P6NEnUA1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734189407; x=1765725407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KK8X38CNscfJpPfeQuOnllEfBhSvoC4tkCFHMTuag6M=;
  b=P6NEnUA1iING8TbCIVpy6tfybffJa24sTjmT0Y7vlxp+Je7aE6w7/AAr
   +R18SVX9HqFRPiawmRus6eIohZk6ufI1BcRJCwO2tAt3qYvluRMU4lcqc
   zjyYnfKAR1I/7Jt/czxFj3p+/ykB4idjfLkKrh9vMY0VHguySEQ2Rfnn+
   rAU0Zz3e27NI5XhQho8Klf7lA6LyYXpDgE6ExpJhr3jJmBZcB90V2vd4e
   b2/cTRe5xeirqdNu9LlIfMvGfprhKcJ5V9P1qD1Iw60aIUY6oSXf+nRwd
   k6CdzV3SaZ3Vhs52iB17G6HA+kPjMs4nHDbGFWe+p2FQmwNm24ZCfhniJ
   w==;
X-CSE-ConnectionGUID: tm/pSrQITXmh672N2Fj2aw==
X-CSE-MsgGUID: yyzvEdROQ3qoXO1zHKVpRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45109916"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45109916"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 07:16:47 -0800
X-CSE-ConnectionGUID: CV8pDeISQMKTqfA+NlvmmQ==
X-CSE-MsgGUID: +pQR5jDsRVuZvxyEvPcIZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120050184"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.223.200])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 07:16:37 -0800
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
Subject: [PATCH v9 4/6] x86/virt/tdx: Use dedicated struct members for PAMT entry sizes
Date: Sun, 15 Dec 2024 04:15:45 +1300
Message-ID: <ccf46f3dacb01be1fb8309592616d443ac17caba.1734188033.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734188033.git.kai.huang@intel.com>
References: <cover.1734188033.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the 'struct tdmr_sys_info_tdmr' which includes TDMR related
fields defines the PAMT entry sizes for TDX supported page sizes (4KB,
2MB and 1GB) as an array:

	struct tdx_sys_info_tdmr {
		...
		u16 pamt_entry_sizes[TDX_PS_NR];
	};

PAMT entry sizes are needed when allocating PAMTs for each TDMR.  Using
the array to contain PAMT entry sizes reduces the number of arguments
that need to be passed when calling tdmr_set_up_pamt().  It also makes
the code pattern like below clearer:

	for (pgsz = TDX_PS_4K; pgsz < TDX_PS_NR; pgsz++) {
		pamt_size[pgsz] = tdmr_get_pamt_sz(tdmr, pgsz,
					pamt_entry_size[pgsz]);
		tdmr_pamt_size += pamt_size[pgsz];
	}

However, the auto-generated metadata reading code generates a structure
member for each field.  The 'global_metadata.json' has a dedicated field
for each PAMT entry size, and the new 'struct tdx_sys_info_tdmr' looks
like:

	struct tdx_sys_info_tdmr {
		...
		u16 pamt_4k_entry_size;
		u16 pamt_2m_entry_size;
		u16 pamt_1g_entry_size;
	};

Prepare to use the autogenerated code by making the existing 'struct
tdx_sys_info_tdmr' look like the generated one.  When passing to
tdmrs_set_up_pamt_all(), build a local array of PAMT entry sizes from
the structure so the code to allocate PAMTs can stay the same.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 14 +++++++++-----
 arch/x86/virt/vmx/tdx/tdx.h |  4 +++-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 7a2f979092e7..28537a6c47fc 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -304,9 +304,9 @@ struct field_mapping {
 static const struct field_mapping fields[] = {
 	TD_SYSINFO_MAP(MAX_TDMRS,	      max_tdmrs),
 	TD_SYSINFO_MAP(MAX_RESERVED_PER_TDMR, max_reserved_per_tdmr),
-	TD_SYSINFO_MAP(PAMT_4K_ENTRY_SIZE,    pamt_entry_size[TDX_PS_4K]),
-	TD_SYSINFO_MAP(PAMT_2M_ENTRY_SIZE,    pamt_entry_size[TDX_PS_2M]),
-	TD_SYSINFO_MAP(PAMT_1G_ENTRY_SIZE,    pamt_entry_size[TDX_PS_1G]),
+	TD_SYSINFO_MAP(PAMT_4K_ENTRY_SIZE,    pamt_4k_entry_size),
+	TD_SYSINFO_MAP(PAMT_2M_ENTRY_SIZE,    pamt_2m_entry_size),
+	TD_SYSINFO_MAP(PAMT_1G_ENTRY_SIZE,    pamt_1g_entry_size),
 };
 
 static int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
@@ -932,14 +932,18 @@ static int construct_tdmrs(struct list_head *tmb_list,
 			   struct tdmr_info_list *tdmr_list,
 			   struct tdx_sys_info_tdmr *sysinfo_tdmr)
 {
+	u16 pamt_entry_size[TDX_PS_NR] = {
+		sysinfo_tdmr->pamt_4k_entry_size,
+		sysinfo_tdmr->pamt_2m_entry_size,
+		sysinfo_tdmr->pamt_1g_entry_size,
+	};
 	int ret;
 
 	ret = fill_out_tdmrs(tmb_list, tdmr_list);
 	if (ret)
 		return ret;
 
-	ret = tdmrs_set_up_pamt_all(tdmr_list, tmb_list,
-			sysinfo_tdmr->pamt_entry_size);
+	ret = tdmrs_set_up_pamt_all(tdmr_list, tmb_list, pamt_entry_size);
 	if (ret)
 		return ret;
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 2600ec3752f5..ec879d54eb5c 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -84,7 +84,9 @@ struct tdmr_info {
 struct tdx_sys_info_tdmr {
 	u16 max_tdmrs;
 	u16 max_reserved_per_tdmr;
-	u16 pamt_entry_size[TDX_PS_NR];
+	u16 pamt_4k_entry_size;
+	u16 pamt_2m_entry_size;
+	u16 pamt_1g_entry_size;
 };
 
 /* Kernel used global metadata fields */
-- 
2.47.1


