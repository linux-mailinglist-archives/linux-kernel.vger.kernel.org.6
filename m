Return-Path: <linux-kernel+bounces-431396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F059E3D3E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44503B2C995
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8379207A2C;
	Wed,  4 Dec 2024 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BD9K3aS1"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE0E16BE20
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322766; cv=none; b=GRXkvOO8gxHFOprMFcpqzaI7+wfTHCqLDw/XrChH6dhim+nOFFRudO4wcxN2HB/FIpIni9mcCFGlYDNZBanDhAPQTU5gzQROYlF1DfSk2mal6/yHDqd1Ld5DEww2HFV34EgNfpjMdBs+hWyAzvh4XkXTVFCjPQxUu1/5gnsL+ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322766; c=relaxed/simple;
	bh=W/dFHpeO+fCZG8QYDejCyurqPNg8bX0ZocrORK+cTpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyoq46y+OnQIkVha8QQap9hOnWPaIu9pPh0B3EPpe76vUkx81HLmYF0vTzBgPzdhe2Qd4bsJ/NGkOVKOoc10RPJX/OhJO0y4jFKlLCftxbDSNqS8KeZY1blWLd89VVGT+gMVCxzzG1dMNxsle6Qf5CyybBvnatkHNJ3gybTcd9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BD9K3aS1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C0C7940E0269;
	Wed,  4 Dec 2024 14:32:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id F2FF6yAVXuPx; Wed,  4 Dec 2024 14:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733322750; bh=16wl3GhH7Xjac9nG/I9USAT0vc1eLOzRj1VYVtsaAJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BD9K3aS1wOZmSQaFRSpqoq3J9eH73sVnLsogx+967eB9Lsi5JMgxklZD2MTmmuhyp
	 vOGm1qYALLm8tUeIve8YBjA7mG7pbHaDUKn/xF+NDSjVnd+5eFConYfAxNmyXHmZB7
	 fLoAaemC/8EKeXtO+kiV/9rs7u+CFDlsBlUJpysFTFe3T/iVdnAduYQl5G5to4Yuyz
	 AWUeBx5hGd8PkS1gv/aQWww1VL0bs4L1fGECGOMoCKtA4gQ3qjgMghn4bK6Q+J/Q/7
	 cdffmpcpId0F/cykzQkB8WXRC3HdOAHJbf6cXFjk1Q1YQdMfbwh9JZlRyN8tl3KXX5
	 P3tAJN7W9QmHA26lBOsxlbRM7atY9iA16fMgRiDSH6gnKSSZPRG1WpQIUhjZYl5m41
	 Sh4gBduv72ZQeJnuswLg6tPWPk/7bR9uCgL3g1GrhjYIyF3z5Oba08vv7lJb2wMLyL
	 8UjeOKlFWLcqY+L5QtNUJL/A7gxf8cLNbYCvvgTuXMIX+h3stLM3JFv0gGCjinTfkO
	 2VEy5DREh8RlQC4AmZUaM+o16HJs6SaeM/ckricMDfVD9tXZm8/D+1phPGMiW2lfpS
	 dfzZqipoP9JId71kuX0FjeCVuTlU4ei8GF9qWmBXb9jky4ctDQKsqrZA8jk/3936DY
	 zvuZFovuLm7qLCeqHf3ndick=
Received: from zn.tnic (p200300EA9736a14B329c23FFfEa6A903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a14b:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC07640E0266;
	Wed,  4 Dec 2024 14:32:11 +0000 (UTC)
Date: Wed, 4 Dec 2024 15:32:06 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Huang Ying <ying.huang@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] x86/cacheinfo: Delete global num_cache_leaves
Message-ID: <20241204143206.GAZ1Bn5jsTCvI_1ci0@fat_crate.local>
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
 <20241128002247.26726-3-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128002247.26726-3-ricardo.neri-calderon@linux.intel.com>

On Wed, Nov 27, 2024 at 04:22:47PM -0800, Ricardo Neri wrote:
>  arch/x86/kernel/cpu/cacheinfo.c | 41 +++++++++++++++------------------
>  1 file changed, 18 insertions(+), 23 deletions(-)

Does that work too?

---
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 95e38ab98a72..e6fa03ed9172 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -715,22 +715,23 @@ void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c)
 
 void init_amd_cacheinfo(struct cpuinfo_x86 *c)
 {
-
-	unsigned int cpu = c->cpu_index;
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
 
 	if (boot_cpu_has(X86_FEATURE_TOPOEXT)) {
-		get_cpu_cacheinfo(cpu)->num_leaves = find_num_cache_leaves(c);
+		ci->num_leaves = find_num_cache_leaves(c);
 	} else if (c->extended_cpuid_level >= 0x80000006) {
 		if (cpuid_edx(0x80000006) & 0xf000)
-			get_cpu_cacheinfo(cpu)->num_leaves = 4;
+			ci->num_leaves = 4;
 		else
-			get_cpu_cacheinfo(cpu)->num_leaves = 3;
+			ci->num_leaves = 3;
 	}
 }
 
 void init_hygon_cacheinfo(struct cpuinfo_x86 *c)
 {
-	get_cpu_cacheinfo(c->cpu_index)->num_leaves = find_num_cache_leaves(c);
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
+
+	ci->num_leaves = find_num_cache_leaves(c);
 }
 
 void init_intel_cacheinfo(struct cpuinfo_x86 *c)
@@ -740,20 +741,21 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 	unsigned int new_l1d = 0, new_l1i = 0; /* Cache sizes from cpuid(4) */
 	unsigned int new_l2 = 0, new_l3 = 0, i; /* Cache sizes from cpuid(4) */
 	unsigned int l2_id = 0, l3_id = 0, num_threads_sharing, index_msb;
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(c->cpu_index);
 
 	if (c->cpuid_level > 3) {
 		/*
 		 * There should be at least one leaf. A non-zero value means
 		 * that the number of leaves has been initialized.
 		 */
-		if (!get_cpu_cacheinfo(c->cpu_index)->num_leaves)
-			get_cpu_cacheinfo(c->cpu_index)->num_leaves = find_num_cache_leaves(c);
+		if (!ci->num_leaves)
+			ci->num_leaves = find_num_cache_leaves(c);
 
 		/*
 		 * Whenever possible use cpuid(4), deterministic cache
 		 * parameters cpuid leaf to find the cache details
 		 */
-		for (i = 0; i < get_cpu_cacheinfo(c->cpu_index)->num_leaves; i++) {
+		for (i = 0; i < ci->num_leaves; i++) {
 			struct _cpuid4_info_regs this_leaf = {};
 			int retval;
 
@@ -789,14 +791,14 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 	 * Don't use cpuid2 if cpuid4 is supported. For P4, we use cpuid2 for
 	 * trace cache
 	 */
-	if ((!get_cpu_cacheinfo(c->cpu_index)->num_leaves || c->x86 == 15) && c->cpuid_level > 1) {
+	if ((!ci->num_leaves || c->x86 == 15) && c->cpuid_level > 1) {
 		/* supports eax=2  call */
 		int j, n;
 		unsigned int regs[4];
 		unsigned char *dp = (unsigned char *)regs;
 		int only_trace = 0;
 
-		if (get_cpu_cacheinfo(c->cpu_index)->num_leaves && c->x86 == 15)
+		if (ci->num_leaves && c->x86 == 15)
 			only_trace = 1;
 
 		/* Number of times to iterate */
@@ -990,8 +992,10 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 
 int init_cache_level(unsigned int cpu)
 {
+	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
+
 	/* There should be at least one leaf. */
-	if (!get_cpu_cacheinfo(cpu)->num_leaves)
+	if (!ci->num_leaves)
 		return -ENOENT;
 
 	return 0;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

