Return-Path: <linux-kernel+bounces-307543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E02C964EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0727B21AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC8C1B8EA8;
	Thu, 29 Aug 2024 19:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4tHo9dC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA8E1B654B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959499; cv=none; b=qpa3K4+pUrcK9qv07+GGEiZxpYaBveO6On11jg9fqLdT6TCDje5c3Ci44i7gSB9u1Yp6LlSSEUYVKck8DGuFwMUZdDU8GyQPknnF0HnnyueQEvvEze1Px0tcY3nh5vRg1itNJGn8LStFBkmS2XkVXqXLGKIfm+P8gwn6zEAxiNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959499; c=relaxed/simple;
	bh=XUsJEwS8qMaPfo7+tnpNvdtkNqTWxZqP5ZD8QQ4imn8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cknhjr8XheuXUKm2gF1ST/uMcbQDBDuUs216rbfUe78Ukh6LZRv38Rf9iNDHvqhoCm0vYxpuIhkUYH7AtnDscSU8/IfNCDDnBdjpobljtumA+KWEe9QDInEj47LGHj7/ujSZXXpquYOqRpB6T/5N6A1E396B36hrmeuogSc4iB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4tHo9dC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724959497; x=1756495497;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XUsJEwS8qMaPfo7+tnpNvdtkNqTWxZqP5ZD8QQ4imn8=;
  b=E4tHo9dC1EDLeoC7DINSuJ65tYYN0F2ocJgFRvfsuNiXh6tNBCpacQ4L
   XbQm+s8b5IPovcf4uqzOz536bAhirSwTGHGoW/YmKheb4xw8yWzVxIep6
   Ps+O5onipJrq8AKsxLc0mJ8p6UlzXt+sbFocXSY2gDT8AT6Emd4C0SpXK
   qzcmxQM9tOSsXxLB6jXDhnE/urg8gLJhDcy/5U0xzhOv+DLNX8c8WGmXf
   c3VC4XWEd4NpKV3CaDLyC01LkfngRCQbJ05yWFoKPmKWoyOkKPdbJZ+UZ
   FofF+XLQXhI3xwEBBUw1qczcNy1Hy4eOK6jBLIzemOJ3UB9SpMbyRSICh
   Q==;
X-CSE-ConnectionGUID: /AbWSNIVT2yUBiPAfPHKvQ==
X-CSE-MsgGUID: pTtg++7GQq6btPK9uKi4Rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23097064"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="23097064"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 12:24:57 -0700
X-CSE-ConnectionGUID: ymixQ/tGT8uCgmevhBcwcg==
X-CSE-MsgGUID: GLzP+IwqSkCGG2EAboxM1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="68063838"
Received: from joseju8x-mobl.amr.corp.intel.com (HELO dsneddon-desk.sneddon.lan) ([10.125.49.4])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 12:24:56 -0700
From: Daniel Sneddon <daniel.sneddon@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Cc: pawan.kumar.gupta@linux.intel.com,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	"Shanavas . K . S" <shanavasks@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH v2] x86/bugs: Add missing NO_SSB flag
Date: Thu, 29 Aug 2024 12:24:37 -0700
Message-Id: <20240829192437.4074196-1-daniel.sneddon@linux.intel.com>
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

These parts are currently out of service and were verified
internally with archived documentation that they need the
NO_SSB flag.

Reported-by: Shanavas.K.S <shanavasks@gmail.com>
Closes: https://lore.kernel.org/lkml/CAEJ9NQdhh+4GxrtG1DuYgqYhvc0hi-sKZh-2niukJ-MyFLntAA@mail.gmail.com/
Signed-off-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
---
V1->V2
	Added Reported-by and Closes tags
	Added note re: missing public documentation

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


