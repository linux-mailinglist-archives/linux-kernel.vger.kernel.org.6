Return-Path: <linux-kernel+bounces-224862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89A29127C0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90751C212DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD423208D4;
	Fri, 21 Jun 2024 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aSYa3Blx"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA642031D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980172; cv=none; b=C/csJQv8YCgsGEcorJ0sM7iRebQWARCxjsfGC0TLyoDW/YAZgCdiYSlR9P5eP5W1j1tfMqUA1qLM/++iBde3LS9JkWz+tB88+Ix1K/+Ar0xulz91FXlqNBykQpu1mKMn0IdTeGiRZdn15BAVMrgNq3vilYfNPTjLHAV6kB7M5t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980172; c=relaxed/simple;
	bh=9egxi6exw9idWssQbwO+N/vioyvE59JFWetrlixmfbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvKPU3g2S2Rxg/RId1wYXXxKCq2m6lx7FOBHkq+x93RpBAvpt2jw8c5hvpAHdTMkzstTHdnXfqAzgQeHxFLduzUawIRCFdSnIdeFpvteE1+lRHzFcaODb21QnmGZjU+3Dkv2bux8VDc9eplZUpL0uC6AWbUC32SpZU8nxmaFCTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aSYa3Blx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 278D240E01F9;
	Fri, 21 Jun 2024 14:29:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gwf1TO_xvEHv; Fri, 21 Jun 2024 14:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718980165; bh=6EuTonoJ+uHLxgWfdIlpoFfVsFVmv5y+5kGtUTqWIGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aSYa3BlxSB5+dQjv9k4KjU63YoAAP0A7XYXnhUMZ4Az6M89ylUoSTUchwvpt3DZCQ
	 KZZxT9rjVYSwwuj7VvpV8OaJGXJ/YY63WwEsBNXlXGdMdxCJKLjH0YjSLPq8i72rTV
	 rvaciOsbDx6ubwOz3y+xWS0x232cE1FWvUDmlveUVMMgC8wdgtbZNI3eaOG7LXXSum
	 97rxIyd9q5qWVix/ZgoRi5LH3CR5waj8fjBIox156gOgwx/T7bRAtndGa2LPAMb2rA
	 SqLZDOlsgCZ7BuJ48oKu8EMS4FbgaCn1/3zQlOiKptN5AQVGbqqkhiOZP7f3ki/tnq
	 eq5/CKHRb1qIeEAfGJuDH9Gt0rIZsfWbzYJpRSlEW/whhwborMPGmZH663Uyzo/Ft5
	 /HE5RgF2KU5ykJmKNIT7Ywe8wm5X8a6J+6j3rp27fgdatLoGYu7be3oMnRo5awRGVS
	 oR+atpJ29prSOsGjGpULjBw0WdHxm5/YADiKiVomICkffHUXes9flmxgzkKonu1Tn1
	 +nELoJlEg3KdHyYNtrZr7pDyHpFc8LePaZ9U3Uv+MmFgz+fHUT1uM9U0LQj9lr7n2f
	 HypADksrh4OCbSIBJir5f6KPxOh2iVVgc4DRfcRAqPQdzpJo+uoBuf/NvNlYGG1T38
	 1a+E5+4jpcZFv0vjv2bqMwkI=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D5DDC40E01D6;
	Fri, 21 Jun 2024 14:29:16 +0000 (UTC)
Date: Fri, 21 Jun 2024 16:29:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH] x86/sev: Do RMP memory coverage check after max_pfn has
 been set
Message-ID: <20240621142911.GIZnWON-Pgx4dSzlGZ@fat_crate.local>
References: <92b4ba20a5afeb4aecde167bfac094d0275d8e1b.1717601917.git.thomas.lendacky@amd.com>
 <20240621135935.GGZnWHRxn08g8CkLNu@fat_crate.local>
 <4c4c8208-7194-79d0-a9cf-e625e5feff23@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4c4c8208-7194-79d0-a9cf-e625e5feff23@amd.com>

On Fri, Jun 21, 2024 at 09:17:35AM -0500, Tom Lendacky wrote:
> I think it makes the code easier to follow and less of a chance to compute
> the value wrong given you have to substract 1 (end = base + size - 1). I
> guess I can create a #define or a helper function so that the calculation
> is always the same if that is preferred.

Why, what's wrong with this variant?

You can always do a separate variable if warranted but right now you need it
at exactly one spot and one spot only...

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 0ae10535c699..8a87c0344833 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -120,7 +120,7 @@ static __init void snp_enable(void *arg)
 
 bool snp_probe_rmptable_info(void)
 {
-	u64 max_rmp_pfn, calc_rmp_sz, rmp_sz, rmp_base, rmp_end;
+	u64 rmp_sz, rmp_base, rmp_end;
 
 	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
 	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
@@ -137,28 +137,11 @@ bool snp_probe_rmptable_info(void)
 
 	rmp_sz = rmp_end - rmp_base + 1;
 
-	/*
-	 * Calculate the amount the memory that must be reserved by the BIOS to
-	 * address the whole RAM, including the bookkeeping area. The RMP itself
-	 * must also be covered.
-	 */
-	max_rmp_pfn = max_pfn;
-	if (PHYS_PFN(rmp_end) > max_pfn)
-		max_rmp_pfn = PHYS_PFN(rmp_end);
-
-	calc_rmp_sz = (max_rmp_pfn << 4) + RMPTABLE_CPU_BOOKKEEPING_SZ;
-
-	if (calc_rmp_sz > rmp_sz) {
-		pr_err("Memory reserved for the RMP table does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
-		       calc_rmp_sz, rmp_sz);
-		return false;
-	}
-
 	probed_rmp_base = rmp_base;
 	probed_rmp_size = rmp_sz;
 
 	pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
-		probed_rmp_base, probed_rmp_base + probed_rmp_size - 1);
+		probed_rmp_base, rmp_end);
 
 	return true;
 }
@@ -206,9 +189,8 @@ void __init snp_fixup_e820_tables(void)
  */
 static int __init snp_rmptable_init(void)
 {
+	u64 max_rmp_pfn, calc_rmp_sz, rmptable_size, probed_rmp_end, val;
 	void *rmptable_start;
-	u64 rmptable_size;
-	u64 val;
 
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		return 0;
@@ -219,10 +201,28 @@ static int __init snp_rmptable_init(void)
 	if (!probed_rmp_size)
 		goto nosnp;
 
+	probed_rmp_end = probed_rmp_base + probed_rmp_size - 1;
+
+	/*
+	 * Calculate the amount the memory that must be reserved by the BIOS to
+	 * address the whole RAM, including the bookkeeping area. The RMP itself
+	 * must also be covered.
+	 */
+	max_rmp_pfn = max_pfn;
+	if (PHYS_PFN(probed_rmp_end) > max_pfn)
+		max_rmp_pfn = PHYS_PFN(probed_rmp_end);
+
+	calc_rmp_sz = (max_rmp_pfn << 4) + RMPTABLE_CPU_BOOKKEEPING_SZ;
+	if (calc_rmp_sz > probed_rmp_size) {
+		pr_err("Memory reserved for the RMP table does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
+		       calc_rmp_sz, probed_rmp_size);
+		goto nosnp;
+	}
+
 	rmptable_start = memremap(probed_rmp_base, probed_rmp_size, MEMREMAP_WB);
 	if (!rmptable_start) {
 		pr_err("Failed to map RMP table\n");
-		return 1;
+		goto nosnp;
 	}
 
 	/*

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

