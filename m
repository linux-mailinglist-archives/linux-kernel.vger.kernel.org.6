Return-Path: <linux-kernel+bounces-407518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7809C6E89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7460B2833E7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77BA2038CC;
	Wed, 13 Nov 2024 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grPDI9mS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C1A200C9A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499074; cv=none; b=eDNetQyvhTZcCwylnJb8CS4oB8DfvU7SkMajWjF9Gn8bGX6YkvI9pY1rxfqzL+2QaFjoCCoznB1VdNjOaN24EbC4aEgudnUDBD+yBXDNk/iw4tQ/Z7j0u+rjih8SlWM9Q4KekmJnkNryQszbV82sduGot6+5rc5isoNQwuLTY+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499074; c=relaxed/simple;
	bh=MiDuW3xv90eOoJn+KPKLwF+2gnSv91ApeTBM2COmSK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MogDa/iDp/sOfXYhHSi0pTG7MjuduNYrIoUvsnzflwFp/eXJR2JLBZx5E87eUjUA0wGERNx2ZViA9JPeX5ZqAM9qjtMKtrNX2jdapI0ATd+RzaeMbnd9g/7Lla8Q6d/tVHwLDwO3PPuaCB9WxbNx1AA6n0CSFpUc396sQgZuknY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grPDI9mS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731499073; x=1763035073;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MiDuW3xv90eOoJn+KPKLwF+2gnSv91ApeTBM2COmSK8=;
  b=grPDI9mS9+AgNlqORyCAEHxvXdtzHAj9TihRgnWJpeFDJE3G5aNTKmj8
   0S+ll1qV9upXUv+i8tM9zofJeivgj+BRKUw2QO0escfi5OpR+fWUFSdEu
   RccRkJ+U9lrPCAGlWqIibRQ0rZ8p4tHh2Ot85X5USSUVtbvkwGlGcbGcW
   qSoMO3Vx3tjHm4L9XpWsRKcRWn5sZHdPp8/OhNQu5Y5pzJsKIRYioU561
   UMDSS01PCDSQOUvqqWjanakUUCtPR152rak4ENlTa2dUDqANe7ZM8A2QB
   ElJM77TkDFiR68f/cQrqp6sVYZR4pMKeLp5QJTWoBYyt0HNHr+6MwYtNq
   g==;
X-CSE-ConnectionGUID: v7uVvJm2SuCHdBtlhWiZpg==
X-CSE-MsgGUID: ugnpBB+URpSrtSACwIslCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31630791"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="31630791"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 03:57:41 -0800
X-CSE-ConnectionGUID: 02WXJXzYSi2Auzh/RnuWrA==
X-CSE-MsgGUID: z3pIwWcPRpSSK/ZRQgVfyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="92323520"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.124.220.169])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 03:57:38 -0800
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
Subject: [PATCH v8 4/9] x86/virt/tdx: Use dedicated struct members for PAMT entry sizes
Date: Thu, 14 Nov 2024 00:57:09 +1300
Message-ID: <91c01c4ea4cdf8f5f8565e0e0794889b2edb4921.1731498635.git.kai.huang@intel.com>
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

To prepare to use the auto-generated code, make the existing 'struct
tdx_sys_info_tdmr' look like the generated one.  But when passing to
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
2.46.2


