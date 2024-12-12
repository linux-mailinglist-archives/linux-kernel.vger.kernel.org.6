Return-Path: <linux-kernel+bounces-442731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA89C9EE0E6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEEE918882FF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4360120B81D;
	Thu, 12 Dec 2024 08:09:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED6720B20B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990960; cv=none; b=aRGaDGXHZu8EW4IRDUKOQtGncODXsCwd586ozc44cz8rcBMAjjbS3DViwnR0UTcKxgIpIn9wGHqnEtoZ0jcTfvvekjb1VU2tx4AN6Yvk+Os8cLuMah6Dyv8JBCaL8p75V3zxWhXmTtGRZ/dFXHpKPJrr/F+hLJSdS0QhyquhswY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990960; c=relaxed/simple;
	bh=hdVsir5xwdWU1N+oSx55isIAUlAtsgjQ0MGltDXuKM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZeolF3U20Vk8KlOYts2hz2AxIMcTzaK7PJz3WFGdlkC5dYHRFe7f2fL6Qz/gmxxprjEp1cnDVfKoH81RcfKBASfeHG0tAOdfy9/h+iBbYPoqDbHKtIHc9AG25fli1UgOY8rXcMXfkks2vOOVcL2zXBq2a1IidM1GEEEXRMRaWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 701451756;
	Thu, 12 Dec 2024 00:09:40 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 213A03F5A1;
	Thu, 12 Dec 2024 00:09:11 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	bp@alien8.de,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	jane.chu@oracle.com,
	osalvador@suse.de,
	tglx@linutronix.de
Subject: [PATCH v2 1/2] x86/mm: Remove unused __set_memory_prot()
Date: Thu, 12 Dec 2024 08:09:03 +0000
Message-ID: <20241212080904.2089632-2-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241212080904.2089632-1-kevin.brodsky@arm.com>
References: <20241212080904.2089632-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__set_memory_prot() is unused since commit 5c11f00b09c1 ("x86:
remove memory hotplug support on X86_32"). Let's remove it.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/x86/include/asm/set_memory.h |  1 -
 arch/x86/mm/pat/set_memory.c      | 13 -------------
 2 files changed, 14 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index cc62ef70ccc0..6586d533fe3a 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -38,7 +38,6 @@ int set_memory_rox(unsigned long addr, int numpages);
  * The caller is required to take care of these.
  */
 
-int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot);
 int _set_memory_uc(unsigned long addr, int numpages);
 int _set_memory_wc(unsigned long addr, int numpages);
 int _set_memory_wt(unsigned long addr, int numpages);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 95bc50a8541c..2dc1145cfdb8 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1944,19 +1944,6 @@ static inline int cpa_clear_pages_array(struct page **pages, int numpages,
 		CPA_PAGES_ARRAY, pages);
 }
 
-/*
- * __set_memory_prot is an internal helper for callers that have been passed
- * a pgprot_t value from upper layers and a reservation has already been taken.
- * If you want to set the pgprot to a specific page protocol, use the
- * set_memory_xx() functions.
- */
-int __set_memory_prot(unsigned long addr, int numpages, pgprot_t prot)
-{
-	return change_page_attr_set_clr(&addr, numpages, prot,
-					__pgprot(~pgprot_val(prot)), 0, 0,
-					NULL);
-}
-
 int _set_memory_uc(unsigned long addr, int numpages)
 {
 	/*
-- 
2.47.0


