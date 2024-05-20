Return-Path: <linux-kernel+bounces-184252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF8B8CA4A9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295B01C214FC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927C313C80B;
	Mon, 20 May 2024 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LokOjLfj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CFF13BACC
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716245210; cv=none; b=GDt0VrN1ktsz8HXJmLQ+X90OY3EeOiyjoa6ipRfYbblvXFnLONLXh1CygKXndcXUrBHDkpnyxwQvlt6CNGAw8elCYL9cOdbgzmr7k4+EQ8DEPVzIem5tVm0QZIT0EivNF0HtzcsUl9PCT5lVFwjXjGsTwsWQNUbxt8t9Y9dxJYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716245210; c=relaxed/simple;
	bh=rwri8jBEq7rYQ3kqqSBg1ylAIT9NhdjG7ASmrOmfXDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OM6KYEAj2Zw2oZKOA7jbGtc3w3BKB277rUcWAlGDdRl1n9fUfJ32M5VbRMz2/8TVmgRpwwFgUMv6C8iKdBgX/Y6GeBAU/hpRIvqxHVOuO7dXtjooTTlvPzxguKvZ3CCOvirad8tv8j2/ebuuVD3yf1WpgVs7p7o/rbdywX4jCbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LokOjLfj; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716245208; x=1747781208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rwri8jBEq7rYQ3kqqSBg1ylAIT9NhdjG7ASmrOmfXDA=;
  b=LokOjLfj8b8VbfB04oQof4anKZTjqeyFo7rIRFw6W0UafJj7VAkGZKdd
   zdttS02Z3rUww3hBUqWqzbnODx9sKPSVuvbLbkDVHbgwD5lZGy7y3VAYK
   djVAYcVouEOQkPJDFXZLzcIKjqayzQlRTtzr2uEBiJY1bchIyhYjplHG0
   6DH/pmSVTnCAbKEQxAigMY3NkRUdvCjaVfEdNFdBgXt1DRdizH/y16ebq
   12zKMth2slIWfZmGXvkFkeQFNYEBslvINjSCFAl/dUw7+0ku5V4R6I8tD
   VyAHTztgSbIjrAjpzD/caaPXSkan9D+xo2viO2ljpatzV+8jlpIE8YfhS
   A==;
X-CSE-ConnectionGUID: 1RUGE7O3SW6kKeh5WwyUGg==
X-CSE-MsgGUID: Ezro+SKgQtiNUBp+VYYjUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12199767"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12199767"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:38 -0700
X-CSE-ConnectionGUID: FztG9Ou+RESzMOqFyPwPAw==
X-CSE-MsgGUID: Rnxll98ZSOSjAegawaf+GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32593454"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 15:46:38 -0700
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
	patches@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v6 24/49] platform/x86/intel: pmc: Switch to new Intel CPU model defines
Date: Mon, 20 May 2024 15:45:55 -0700
Message-ID: <20240520224620.9480-25-tony.luck@intel.com>
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

New CPU #defines encode vendor and family as well as model.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/pmc/pltdrv.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel/pmc/pltdrv.c b/drivers/platform/x86/intel/pmc/pltdrv.c
index ddfba38c2104..22cfcd431987 100644
--- a/drivers/platform/x86/intel/pmc/pltdrv.c
+++ b/drivers/platform/x86/intel/pmc/pltdrv.c
@@ -35,14 +35,14 @@ static struct platform_device *pmc_core_device;
  * other list may grow, but this list should not.
  */
 static const struct x86_cpu_id intel_pmc_core_platform_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L,		&pmc_core_device),
-	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE,		&pmc_core_device),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&pmc_core_device),
-	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&pmc_core_device),
-	X86_MATCH_INTEL_FAM6_MODEL(CANNONLAKE_L,	&pmc_core_device),
-	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&pmc_core_device),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&pmc_core_device),
-	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&pmc_core_device),
+	X86_MATCH_VFM(INTEL_SKYLAKE_L,		&pmc_core_device),
+	X86_MATCH_VFM(INTEL_SKYLAKE,		&pmc_core_device),
+	X86_MATCH_VFM(INTEL_KABYLAKE_L,		&pmc_core_device),
+	X86_MATCH_VFM(INTEL_KABYLAKE,		&pmc_core_device),
+	X86_MATCH_VFM(INTEL_CANNONLAKE_L,	&pmc_core_device),
+	X86_MATCH_VFM(INTEL_ICELAKE_L,		&pmc_core_device),
+	X86_MATCH_VFM(INTEL_COMETLAKE,		&pmc_core_device),
+	X86_MATCH_VFM(INTEL_COMETLAKE_L,	&pmc_core_device),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_platform_ids);
-- 
2.45.0


