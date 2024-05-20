Return-Path: <linux-kernel+bounces-184261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 768418CA4B2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315C6280634
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A5B13D24A;
	Mon, 20 May 2024 22:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKMSI+dF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C4613C903
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245214; cv=none; b=V5Af9zRZ/RavPV+UnHbsUVTI8XJ05RrWRfhuylpjy5A11JonV/w4Ul2U63Do3fq8lsamo9FmhQc38jHPJ3nqBdvOUucFLxamk0CFnqJ570G/EEPZbpndtA8h8LXCKPkb6edkkvce1XiCKErRvpm1pMN79rxqMrlm4Cg/OtVTgL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245214; c=relaxed/simple;
	bh=sASbPr2zR3JdDKlYAQlWUeMercohyneum+eNLKpGg/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3rco2bg6IGHAcRotsgBFM+GM19AyIMDN5vrw0t2v4/gMGTaQIFrLuZJ8dXO07piBSiLmdGhowlSRswaxCQ15Udb03UEPrW/Fj6inchCH0lqZK7Whz+Vm45jNOyQv4zl0dsbZbkpOrPNK1prdSQKCPnt81yx9Pgdr0SctDJf/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKMSI+dF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245213; x=1747781213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sASbPr2zR3JdDKlYAQlWUeMercohyneum+eNLKpGg/c=;
  b=cKMSI+dFAGRDXbJv3aOwGwutUZKZ+KU5pvE/r0Aoig36o4BlMWE9eyfa
   Z+dRvnECzZHcmiwQ8rAjG46v3z8CzCF1F1GC72L8YbXhjBtPLaUzsAlAx
   x/osZD3MhEXLb4ZJpyOGnlRUmaMrliOjwaWGXMhSHs/fOPNQUeJ9oFAkC
   1IUybRzAvsVDmqSRHemlO87i1aSUAj4qRt+ENRvelfCBNPh4IcFxUZh+i
   5qj3Fl44mV+y8780q52Cu2BvmTH7LYadV1gw1CfU75FgE3Lp6nW7ol3nJ
   HtsNa42UmdwCHzfCYbDR1+SWDHVVUWTh6cN1SE8e3aFA9BlHMUU8RfHJ6
   g==;
X-CSE-ConnectionGUID: PLqZ0/pdQXS0kc0t/BbOmw==
X-CSE-MsgGUID: GNkGNA9cTJuoabxnS4e+pg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199878"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199878"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:39 -0700
X-CSE-ConnectionGUID: nlACXApCRPuDY0QXHvTOlQ==
X-CSE-MsgGUID: rNZxRk8JRsmWn+lR2jNOeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593486"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:39 -0700
From: Tony Luck <tony.luck@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Tony Luck <tony.luck@intel.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Thomas Renninger <trenn@suse.de>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH v6 34/49] x86/boot: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:46:05 -0700
Message-ID: <20240520224620.9480-35-tony.luck@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240520224620.9480-1-tony.luck@intel.com>
References: <20240520224620.9480-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New CPU #defines encode vendor and family as well as model but
boot code doesn't have all the infrastructure to use them. Hard
code the one CPU model number used here.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/boot/cpucheck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/cpucheck.c b/arch/x86/boot/cpucheck.c
index fed8d13ce252..0aae4d4ed615 100644
--- a/arch/x86/boot/cpucheck.c
+++ b/arch/x86/boot/cpucheck.c
@@ -203,7 +203,7 @@ int check_knl_erratum(void)
 	 */
 	if (!is_intel() ||
 	    cpu.family != 6 ||
-	    cpu.model != INTEL_FAM6_XEON_PHI_KNL)
+	    cpu.model != 0x57 /*INTEL_XEON_PHI_KNL*/)
 		return 0;
 
 	/*
-- 
2.45.0


