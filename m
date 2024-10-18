Return-Path: <linux-kernel+bounces-371687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A80FF9A3E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51363B20F1F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE1826AD9;
	Fri, 18 Oct 2024 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Y7MEqk8S"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B2D3C17
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255299; cv=none; b=NwO2S1mPbisllW9jEgaWDqEW/JO6+r5LFOckoojJP7/WuFBxU9+IDpoZolc/cA87dw/BHLpa+QaiM82ux5VBIBGxkU8ecL+Vh9jfjLLEJGTsGtaPeaoDd10Jf13UetExQzRBwbGRf//lmlrnTuBgQClhZo+cYKh544ySLERSKX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255299; c=relaxed/simple;
	bh=ldk81eBVBGKVUalDPu3BKnKqpZv8ZtoW0LkiflSsqmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlEX+IMAikEtthSv9ys/1j13djtOAo7Vfmb3elMMPhdUoWd02ISWh4mIGm9FTkfeNPvx1iOc4oNyZOWv29g7z02lvl9fgKva9XDzBhtgE2RgGwJzjNWPXy/Xtd6d+hF8LC9HqFnDOUrUuWX7T8Z/JdigO5uTPuVt9PznYdafNU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Y7MEqk8S; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5441240E021A;
	Fri, 18 Oct 2024 12:41:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7dgNbHGzmzXz; Fri, 18 Oct 2024 12:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729255291; bh=BlfrhmfeGCduIrCHopmZetJIS8sbiBrVD0sW0uTur4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y7MEqk8Szo70xVWAV+6wJDhcbtxKeqEFsLmNkq5gOkA7Ic/bRXM6AGWhahq0LLbwG
	 wsEA9HQ2+a9+yqGRE6nvaCXMbjRt7HBIwJS9ttRKMp1YbHHyVrLXvtXRYO9o1S2wjO
	 eIKzzUwwkgIkGxS4c/dqLfeQNIQidfa7opUdUehH4OxpB9Jd+VdCA7SHew614KE0Lm
	 NyKfN9RtsRT8SSXVK94jGZU+rmCDHfzMu5MJ1tyGpPjDwh8g23J/AVAUQ5T0PuTo/n
	 /DIgV9th4S5rc1wkEX3JOnliRFVqnvCJ3h+1Tj5BzP1nOMb6Yc8JTUCI8TLN97OJJu
	 YvQjSPJ+3OS+39y0TQUbhyjFhnXcDc9orWVEBLmLb8WB6sCsajOJUFNEt3vp1Y8gbh
	 1yDqLiqrmJqp85ZSKviIABF/1Mt0h7mejI2UclUnAlMsAj4f2bGPFN6yrHA2NzTGv6
	 vRwjmZaPDrhXJs3yE90dQP3miQGcdjVSTCYZyUJ6Wuiu4hh4JaWG23sjT0xmvTFyAU
	 90w31PWgm5s4SbeRDi8GPV3GeXnlanmcPasElVH/xDyzZ+3OTibUz4TPTYW9eSPWgG
	 1WiZc8n30w/1nquSGyvDPGDsId/LMpnIagbPkYRdPkqsWbIihcOBkpzfcb16YajdPI
	 K2HqcddH/9tTtetVDRfSPYPg=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5298B40E0169;
	Fri, 18 Oct 2024 12:41:23 +0000 (UTC)
Date: Fri, 18 Oct 2024 14:41:18 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v3 2/8] x86/sev: Add support for the RMPREAD instruction
Message-ID: <20241018124118.GCZxJXbvAIcEak1gue@fat_crate.local>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <4f9d9eac997784cd11f4243d545dd05e670b2e4c.1727709735.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f9d9eac997784cd11f4243d545dd05e670b2e4c.1727709735.git.thomas.lendacky@amd.com>

On Mon, Sep 30, 2024 at 10:22:10AM -0500, Tom Lendacky wrote:
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 103a2dd6e81d..73d4f422829a 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -301,6 +301,17 @@ static int get_rmpentry(u64 pfn, struct rmpentry *entry)
>  {
>  	struct rmpentry_raw *e;
>  
> +	if (cpu_feature_enabled(X86_FEATURE_RMPREAD)) {
> +		int ret;
> +
> +		asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfd"
> +			     : "=a" (ret)
> +			     : "a" (pfn << PAGE_SHIFT), "c" (entry)
> +			     : "memory", "cc");
> +
> +		return ret;
> +	}

I think this should be:

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 73d9295dd013..5500c5d64cba 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -303,12 +303,11 @@ static int get_rmpentry(u64 pfn, struct rmpentry *entry)
 	struct rmpentry_raw *e;
 
 	if (cpu_feature_enabled(X86_FEATURE_RMPREAD)) {
-		int ret;
+		int ret = pfn << PAGE_SHIFT;
 
 		asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfd"
-			     : "=a" (ret)
-			     : "a" (pfn << PAGE_SHIFT), "c" (entry)
-			     : "memory", "cc");
+			     : "+a" (ret), "+c" (entry)
+			     :: "memory", "cc");
 
 		return ret;
 	}

because "The RCX register provides the effective address of a 16-byte data
structure into which the RMP state is written."

So your %rcx is both an input and an output operand and you need to do the "+"
thing here too for that.

Same for %rax.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

