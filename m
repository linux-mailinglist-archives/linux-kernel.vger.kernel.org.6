Return-Path: <linux-kernel+bounces-305828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573A09634EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD951F246D7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA7E1AD3F9;
	Wed, 28 Aug 2024 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWBoCJT7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EE1166F01
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884828; cv=none; b=QD3obxlmCLAhRVsBFxHkhdRRRCVz+N8pIOHhfAY+0QSGjQ+1yDSXliEbMni7zkm51u7GfTQMPLvsKrXypUSwxQwWhV8HV8+W3xObVaW8sn1eY8LdLHsbV1duVFNzwcriuDcIgfVAzDvZlRCRF/li8+hcnPn8sVdX+GMFJfU0XSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884828; c=relaxed/simple;
	bh=w97wCVpJgt6bJ+N/mhy9Y0K9i8SQlHFEOfjW9LC1isc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UQM9i5WmXvGznzNju3nnuWxM/GAAAFow6cykb+jaIg84q+bOhIqF4yDZ5DfNCVkuCCdG1Qn6j12K9f//eH5LrwK1d3jV22AlWDtUNqYSPz7MgmnOHMZoMOl0q45ygqOPZ/Cpy0vQtw45Ju7qJsjnzMVK3EHmDUGgDHb4QciJmmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWBoCJT7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724884827; x=1756420827;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w97wCVpJgt6bJ+N/mhy9Y0K9i8SQlHFEOfjW9LC1isc=;
  b=nWBoCJT7Jwr3IQIG549cZt8m+70EJ02oYkPvG1gZvegCUDDkA5u4Cp8H
   t8lPc9dBkjkb9rVSIq9Gfy8/Kx/xZXlndN+Po94JajEk/LId1WtMMRfmC
   kOmpqetu3iqRMKdisL83KWY03dSj6pppKNUUISLfGLcjj1k70xI7BlEYc
   vi6jEtapUd/+T2tPVbwydtG2poQ6aJUdpBo0AecOiqBNByslYnWE0H6Tl
   pc45gDdznT9amhihvjx+PV9ZYuisQF4ZjAlZGiOjp9Xquda/Lu7VMFakc
   l76xxo2ErunfLpx8Ltw5jhXe+AJ4lMfqlhj0ZmAi3Gh4bz1VPfwphYQTn
   w==;
X-CSE-ConnectionGUID: 3VN/ycjBTfKH5eXACVj3TA==
X-CSE-MsgGUID: wyt/0XC2SlWIf4E/6oY/Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="13269363"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="13269363"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:40:27 -0700
X-CSE-ConnectionGUID: BqmN+pEhRwikRzxDNJfgyA==
X-CSE-MsgGUID: n6D5bouDREGJeQMaZVGAYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68152537"
Received: from njkybert-mobl.amr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.125.160.160])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:40:26 -0700
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Cc: pawan.kumar.gupta@linux.intel.com,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH] x86/bugs: Add missing NO_SSB flag
Date: Wed, 28 Aug 2024 15:40:11 -0700
Message-Id: <20240828224011.4043872-1-daniel.sneddon@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Moorefield and Lightning Mountain Atom processors are
missing the NO_SSB flag in the vulnerabilities whitelist.
This will cause unaffected parts to incorrectly be reported
as vulnerable. Add the missing flag.

Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
---
 arch/x86/kernel/cpu/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d4e539d4e158..be307c9ef263 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1165,8 +1165,8 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 
 	VULNWL_INTEL(INTEL_CORE_YONAH,		NO_SSB),
 
-	VULNWL_INTEL(INTEL_ATOM_AIRMONT_MID,	NO_L1TF | MSBDS_ONLY | NO_SWAPGS | NO_ITLB_MULTIHIT),
-	VULNWL_INTEL(INTEL_ATOM_AIRMONT_NP,	NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT),
+	VULNWL_INTEL(INTEL_ATOM_AIRMONT_MID,	NO_SSB | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | MSBDS_ONLY),
+	VULNWL_INTEL(INTEL_ATOM_AIRMONT_NP,	NO_SSB | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT),
 
 	VULNWL_INTEL(INTEL_ATOM_GOLDMONT,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
 	VULNWL_INTEL(INTEL_ATOM_GOLDMONT_D,	NO_MDS | NO_L1TF | NO_SWAPGS | NO_ITLB_MULTIHIT | NO_MMIO),
-- 
2.25.1


