Return-Path: <linux-kernel+bounces-573444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF369A6D758
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D9C16E1E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7730625DB11;
	Mon, 24 Mar 2025 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="K3sDFV8h"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AA425D8E7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742808585; cv=none; b=OU4i8SGKSzjXGcgs2tSMBHifL//MkMG0a6b8ZfFHNsTe+A6L4nCz7Syar6kjnuRek3fCDSa6Oe2kI2ZMkN66q+H05W6rY8Nv4MIw12TbOoulUDpsqDQ77299N4TCThTMUeJqgKCPcPr1OgQaaUIk7lfepp5luiJ+FPpMq/zdPR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742808585; c=relaxed/simple;
	bh=Jg2Ux5dpMEc1Gq/iD6BBtOeo1/OyGHegPZAHexg9xXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czu56Mism1pRxxT/Vibx5AlZOSdVFcH/LGcg2LFzKPYxepnL7nxCsLoO5122T7TqzrByjxML7Auz0Tx1Do8mtlkw6pFRHiVYWgq+3piGFnCjacuvpRzaYpxdzCN2BvUrlKv0gYB3sjOBUjnXXo9OfnO5QIMTqB8rcF5s4iHA+4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=K3sDFV8h; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8DEF140E01D1;
	Mon, 24 Mar 2025 09:29:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Q0jb--TMQEV8; Mon, 24 Mar 2025 09:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742808573; bh=kx+lLNVmZoG27PV24TZRKC1S4MTXMtaKeJEU2cHIdwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K3sDFV8hvAM+fv0jYtBCgS/neox0qcux/YHY5FmpQGr+se9cVt63ZwRG2k3l3ju1Y
	 XIfRzStLSWj0mCVn+3iRj8xKHfYQyuJbLnO2Jqcvuv9AM33F5blnKrO0IpEJCMKdrZ
	 BgADmjaI2fKlkygtr8MRt4m3+ODUzK7hvnaJFbohGiV9WJ/QSk23M3O/QFzfHf08KG
	 zHm2k1QlcpYfPRHlvaKAckN2Smsci/52hV234rq4877BLzoKXdqzWfMP9N+bsp6vX4
	 54KCRfL5YQAK0d+JCO0oDR3V0pDBlPXg6qKeTiOwR19zQWEkKL6d73rv+KAGw53/BY
	 dCZpBkMx0jo73HMXG0CklMDihxDt2UOTIis+jJfFnKQBYPjwszwiRLSfJVtjdEQgYR
	 vc4qoPZ9nOacgXA0Fo5YdONZ6Mfnx1kePMpANcJmw0wVusgSbCua04KufkmoblRAxW
	 AAz98skeuV9xijdIGWvDI9clAWMgZ8LP2XrWqMv2J+DwKdS7OYNoiIorSZ8b3rRBXx
	 +cC84/sFpl+Z7uEFOrqweAarPZNqNWDrHNz6veZGbA/iV5+6dXv2YF9HDoGXVw66dh
	 4ndkgEppjx/q98Qkb2U0Gpm+PEfSE59bdTmPmYL4zigVA/u2la1OqHBEx0Rb7C+/pr
	 djpJaCaxMSr02LfdMCldKv50=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 75EAE40E021E;
	Mon, 24 Mar 2025 09:29:21 +0000 (UTC)
Date: Mon, 24 Mar 2025 10:29:15 +0100
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: David Kaplan <david.kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: Re: [PATCH v4 03/36] x86/bugs: Restructure mmio mitigation
Message-ID: <20250324092915.GAZ-El68JG2BVuMK0K@fat_crate.local>
References: <20250310164023.779191-1-david.kaplan@amd.com>
 <20250310164023.779191-4-david.kaplan@amd.com>
 <20250313093617.GHZ9KnEXpdM4dwLYFz@fat_crate.local>
 <20250313192606.iijythngqtpx4tyy@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250313192606.iijythngqtpx4tyy@desk>

On Thu, Mar 13, 2025 at 12:26:06PM -0700, Pawan Gupta wrote:
> Hmm, that would not be straightforward, specially for sysfs status.

See below:

- the unknown thing is done only for this vuln and not for the others

- it doesn't do anything besides reporting things differently - it doesn't
  apply any mitigations - it is simply causing unnecessary complications which
  don't bring anything besides maintenance overhead. Unless I'm missing an
  angle...

- all the currently unaffected CPUs can also be in "unknown" status so why is
  this special?

IOW, just whack the thing.

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 46935f29805c..75d77a5c28d7 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -518,7 +518,7 @@
 #define X86_BUG_ITLB_MULTIHIT		X86_BUG(23) /* "itlb_multihit" CPU may incur MCE during certain page attribute changes */
 #define X86_BUG_SRBDS			X86_BUG(24) /* "srbds" CPU may leak RNG bits if not mitigated */
 #define X86_BUG_MMIO_STALE_DATA		X86_BUG(25) /* "mmio_stale_data" CPU is affected by Processor MMIO Stale Data vulnerabilities */
-#define X86_BUG_MMIO_UNKNOWN		X86_BUG(26) /* "mmio_unknown" CPU is too old and its MMIO Stale Data status is unknown */
+/* unused, was #define X86_BUG_MMIO_UNKNOWN		X86_BUG(26) "mmio_unknown" CPU is too old and its MMIO Stale Data status is unknown */
 #define X86_BUG_RETBLEED		X86_BUG(27) /* "retbleed" CPU is affected by RETBleed */
 #define X86_BUG_EIBRS_PBRSB		X86_BUG(28) /* "eibrs_pbrsb" EIBRS is vulnerable to Post Barrier RSB Predictions */
 #define X86_BUG_SMT_RSB			X86_BUG(29) /* "smt_rsb" CPU is vulnerable to Cross-Thread Return Address Predictions */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4386aa6c69e1..a91a1cac6183 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -428,7 +428,6 @@ static const char * const mmio_strings[] = {
 static void __init mmio_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
-	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN) ||
 	     cpu_mitigations_off()) {
 		mmio_mitigation = MMIO_MITIGATION_OFF;
 		return;
@@ -591,8 +590,6 @@ static void __init md_clear_update_mitigation(void)
 		pr_info("TAA: %s\n", taa_strings[taa_mitigation]);
 	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
 		pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
-	else if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
-		pr_info("MMIO Stale Data: Unknown: No mitigations\n");
 	if (boot_cpu_has_bug(X86_BUG_RFDS))
 		pr_info("Register File Data Sampling: %s\n", rfds_strings[rfds_mitigation]);
 }
@@ -2819,9 +2816,6 @@ static ssize_t tsx_async_abort_show_state(char *buf)
 
 static ssize_t mmio_stale_data_show_state(char *buf)
 {
-	if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
-		return sysfs_emit(buf, "Unknown: No mitigations\n");
-
 	if (mmio_mitigation == MMIO_MITIGATION_OFF)
 		return sysfs_emit(buf, "%s\n", mmio_strings[mmio_mitigation]);
 
@@ -3006,7 +3000,6 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 		return srbds_show_state(buf);
 
 	case X86_BUG_MMIO_STALE_DATA:
-	case X86_BUG_MMIO_UNKNOWN:
 		return mmio_stale_data_show_state(buf);
 
 	case X86_BUG_RETBLEED:
@@ -3075,10 +3068,7 @@ ssize_t cpu_show_srbds(struct device *dev, struct device_attribute *attr, char *
 
 ssize_t cpu_show_mmio_stale_data(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
-		return cpu_show_common(dev, attr, buf, X86_BUG_MMIO_UNKNOWN);
-	else
-		return cpu_show_common(dev, attr, buf, X86_BUG_MMIO_STALE_DATA);
+	return cpu_show_common(dev, attr, buf, X86_BUG_MMIO_STALE_DATA);
 }
 
 ssize_t cpu_show_retbleed(struct device *dev, struct device_attribute *attr, char *buf)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 12126adbc3a9..4ada55f126ae 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1402,15 +1402,10 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	 * Affected CPU list is generally enough to enumerate the vulnerability,
 	 * but for virtualization case check for ARCH_CAP MSR bits also, VMM may
 	 * not want the guest to enumerate the bug.
-	 *
-	 * Set X86_BUG_MMIO_UNKNOWN for CPUs that are neither in the blacklist,
-	 * nor in the whitelist and also don't enumerate MSR ARCH_CAP MMIO bits.
 	 */
 	if (!arch_cap_mmio_immune(x86_arch_cap_msr)) {
 		if (cpu_matches(cpu_vuln_blacklist, MMIO))
 			setup_force_cpu_bug(X86_BUG_MMIO_STALE_DATA);
-		else if (!cpu_matches(cpu_vuln_whitelist, NO_MMIO))
-			setup_force_cpu_bug(X86_BUG_MMIO_UNKNOWN);
 	}
 
 	if (!cpu_has(c, X86_FEATURE_BTC_NO)) {
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 9e3fa7942e7d..e88500d90309 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -508,7 +508,7 @@
 #define X86_BUG_ITLB_MULTIHIT		X86_BUG(23) /* "itlb_multihit" CPU may incur MCE during certain page attribute changes */
 #define X86_BUG_SRBDS			X86_BUG(24) /* "srbds" CPU may leak RNG bits if not mitigated */
 #define X86_BUG_MMIO_STALE_DATA		X86_BUG(25) /* "mmio_stale_data" CPU is affected by Processor MMIO Stale Data vulnerabilities */
-#define X86_BUG_MMIO_UNKNOWN		X86_BUG(26) /* "mmio_unknown" CPU is too old and its MMIO Stale Data status is unknown */
+/* unused, was #define X86_BUG_MMIO_UNKNOWN		X86_BUG(26) * "mmio_unknown" CPU is too old and its MMIO Stale Data status is unknown */
 #define X86_BUG_RETBLEED		X86_BUG(27) /* "retbleed" CPU is affected by RETBleed */
 #define X86_BUG_EIBRS_PBRSB		X86_BUG(28) /* "eibrs_pbrsb" EIBRS is vulnerable to Post Barrier RSB Predictions */
 #define X86_BUG_SMT_RSB			X86_BUG(29) /* "smt_rsb" CPU is vulnerable to Cross-Thread Return Address Predictions */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

