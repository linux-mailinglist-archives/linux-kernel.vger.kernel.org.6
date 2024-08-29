Return-Path: <linux-kernel+bounces-307757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3170E965291
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96435B20DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CEF1BA889;
	Thu, 29 Aug 2024 22:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPWpf+46"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6A2189F5A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968861; cv=none; b=U0D7KHzjwQHuI1LgUPS1RmQhvpIlw1EF8QLo7RFSnMZW+Mgiw9hhbSd7s/8Qp/IvBlGRpsvxjehwCcAN1AwpoUadGUz+HqOop7UPOpjcc5vwycAYbjDN3EwAL+7FMrq8me5f5KQne4CLFEZnnahHW0Y9wMfog3tRhFhVCo7q/4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968861; c=relaxed/simple;
	bh=555NiDT1akwshfxmcJK2zpufHLm5vRcouLjx06bYV1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sOgPQZcE5zp+Vgmhp2zBoyJKhoimNI1RhXuDMs/xnYeDKl84QW/LJoRWobsGRpKnxHFmp+/T+xE8dRf4aAf+Wk5WPwfDoUrVEB4L0KhXr8gcndfpf+Vq9JvyC8TcfhT8r7/KkS9pJK0PHQVNlxhM0VpE4plsskJO9KkHDENyhYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPWpf+46; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724968859; x=1756504859;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=555NiDT1akwshfxmcJK2zpufHLm5vRcouLjx06bYV1U=;
  b=YPWpf+46e8CT7BizHnefXwKa8e3B1apGbYBWCw/183YCEIi7naQwY9qu
   13mDjl8+HRGlUG1Io5X2r6tMePE1iZRjC+oVNfhnveNY2cVGCourdE+mO
   u+uyZx30X30NqzLLCesj13HRoUvufQ0Ge23108r9IEDDuoSyU43cUyVg2
   wYAMQBwT3m/px0pEmH1zN+oyeOeAVmlyCKep/MZxBXXOuUup5MU2rY7x/
   iEBL7lHuRDFuSoVDCODGxZ/4Vcu2supNKIsLKvPp4rqG8QwoNZyRonft8
   KykSvkFfBq4YWFOmCghaYk998bwXGDJ55M/J2xGWzYmzmXb1letGNF+LR
   w==;
X-CSE-ConnectionGUID: dcK/WeiMREKid95fp7QEgg==
X-CSE-MsgGUID: 3JkBosYZTu6ydN1hF4Gyew==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34214287"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34214287"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 15:00:58 -0700
X-CSE-ConnectionGUID: mn1Fep4TTFenRjvNWKp15A==
X-CSE-MsgGUID: U3K30unBSiGLEQHwzG8UcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63703040"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by fmviesa008.fm.intel.com with ESMTP; 29 Aug 2024 15:00:57 -0700
From: Dave Hansen <dave.hansen@linux.intel.com>
To: Tony Luck <tony.luck@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH] x86/cpu/intel: Replace PAT erratum model/family magic numbers
Date: Thu, 29 Aug 2024 15:00:42 -0700
Message-Id: <20240829220042.1007820-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's an erratum[1] that prevents the PAT from working correctly.
The kernel currently disables PAT support on those CPUs.  But it
does it with some magic numbers.

Replace the magic numbers with new "IFM" macros.

Make the check refer to the last affected CPU (INTEL_CORE_YONAH)
rather than the first fixed one. This makes it easier to find the
documentation of the erratum since Intel documents where it is
broken and not where it is fixed.

I don't think the Pentium Pro (or Pentium II) is actually affected.
But the old check included them, so it can't hurt to keep doing the
same.  I'm also not completely sure about the "Pentium M" CPUs
(models 0x9 and 0xd).  But, again, they were included in in the
old checks and were close Pentium III derivatives, so are likely
affected.

While we're at it, revise the comment referring to the erratum name
and making sure it is a quote of the language from the actual errata
doc.  That should make it easier to find in the future when the URL
inevitably changes.

Why bother with this in the first place? It actually gets rid of one
of the very few remaining direct references to c->x86{,_model}.

1. https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/pentium-dual-core-specification-update.pdf
   Document 316515 Version 010

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/include/asm/intel-family.h |  2 ++
 arch/x86/kernel/cpu/intel.c         | 18 ++++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index f81a851c46dca..27bdf3b55c6f0 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -47,6 +47,8 @@
 /* Wildcard match for FAM6 so X86_MATCH_VFM(ANY) works */
 #define INTEL_ANY			IFM(X86_FAMILY_ANY, X86_MODEL_ANY)
 
+#define INTEL_PENTIUM_PRO		IFM(6, 0x01)
+
 #define INTEL_FAM6_CORE_YONAH		0x0E
 #define INTEL_CORE_YONAH		IFM(6, 0x0E)
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a9ea0dba6f0cf..b1515ab00e640 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -304,16 +304,18 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	}
 
 	/*
-	 * There is a known erratum on Pentium III and Core Solo
-	 * and Core Duo CPUs.
-	 * " Page with PAT set to WC while associated MTRR is UC
-	 *   may consolidate to UC "
-	 * Because of this erratum, it is better to stick with
-	 * setting WC in MTRR rather than using PAT on these CPUs.
+	 * PAT is broken on early family 6 CPUs, the last of which
+	 * is "Yonah" where the erratum is named "AN7":
 	 *
-	 * Enable PAT WC only on P4, Core 2 or later CPUs.
+	 * 	Page with PAT (Page Attribute Table) Set to USWC
+	 * 	(Uncacheable Speculative Write Combine) While
+	 * 	Associated MTRR (Memory Type Range Register) Is UC
+	 * 	(Uncacheable) May Consolidate to UC
+	 *
+	 * Disable PAT and fall back to MTRR on these CPUs.
 	 */
-	if (c->x86 == 6 && c->x86_model < 15)
+	if (c->x86_vfm >= INTEL_PENTIUM_PRO &&
+	    c->x86_vfm <= INTEL_CORE_YONAH)
 		clear_cpu_cap(c, X86_FEATURE_PAT);
 
 	/*
-- 
2.34.1


