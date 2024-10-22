Return-Path: <linux-kernel+bounces-376306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEDE9AA2EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A139EB2280E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B3F19DF99;
	Tue, 22 Oct 2024 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FhMlQxln"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789B11C27
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603284; cv=none; b=iuJlOZiO2bCFhEdYdSh80jz/97/9gv5jo97wZR2skKCC52lGrM3pmALOfkuVRdXuC1OS6I/hFOli3QeRJm9IiGC78lH6kZ9o92v0MU2NPGu3X5hjnvPJZdha9CFxbkY5KFzE/FZ20WCf9yebmRrnkkoXcpwTLTSSvAfO1HexvXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603284; c=relaxed/simple;
	bh=ystE7XvCDr5nP3P92mePG0w996TUqGPmg0Xj4sfkCME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkDUkV0MTJh9Xl5x4ucjMwekbgtDDLwzFmvDp0cztRtugxFilM8mKLGrMwEC3ffm3hHBQ5910HmDc2Fn9cczDWwxPvg4b/hTMd1O9QbPGGzRgAjR0avY4VJbOlUZh5TZWgORMzyaIdK7nEaB3m0fLWKFBP3cTEkMq7abm6X96f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FhMlQxln; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E756540E01A5;
	Tue, 22 Oct 2024 13:21:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iDRJxERt-Cka; Tue, 22 Oct 2024 13:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729603274; bh=kXFX/HNtWsHwMvtY26MKEC4FQQNuuTolu8A7vDJViI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FhMlQxlnr8Jw5MVT3cm4lzfGQOJGOtJ5LorhiJ6HPoBO4BGBN0FfcQjUyu3JxQmle
	 KU/z4kfXN/C6t8MhePJMmcdMnim2R3E7rsxeK8vmVMv734/olvLC0qoSpMrKhqnNq3
	 zfKB+zVoYNHO55YRQxvhdyXunjlpDmFL+ZFDuF/I3ZHbdxIeDB7RYeWpUyyws6v5gV
	 glQrcIlu8rNJNlDUwjnnLOmVmO4WuTeNnnZpxGImh2abyeYiyjtnUTPhzJcdBqVQq6
	 gzAxhDGbQpr+TYgY2xwA4y5DnbKNs6N9ZE575dd3g3HAKJ7oPvg/aj2QtYlJxK+AT+
	 fXxlZx6leUVGHGjdZeSInFE/gYzKcwqIOVD2K9XUdWjGz+1WUjfyIUpONIH3rH/TlJ
	 4PxENTeXeS6ZzSLIku8J3UvDG2aDU8tPktbNXHGJFqAs0IJrq4ec/6KPqF68FIu+PC
	 G4ZSRczaKT+rjICbLdShgphVCWXhBIumCtQbsyFtCtQzzjCDMcTzv9H8rpfUxCZbCQ
	 MUOhkI+z31aKLge/xb/pMCRG/WIjmDxw2XwHbNk6wJx9Osrick0BC88wmEG9rne1Z8
	 b0ObxSOl2+bnBAasNLlWI92I8o29LcGrewNMc/8SpWB+bFQ+RzEosyOR5Mfs33sn9N
	 OWX5BQg3wDLD4XlrjguFwsrQ=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB1BF40E0198;
	Tue, 22 Oct 2024 13:20:55 +0000 (UTC)
Date: Tue, 22 Oct 2024 15:20:50 +0200
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
Subject: Re: [PATCH v7 2/3] x86/cacheinfo: Delete global num_cache_leaves
Message-ID: <20241022132050.GHZxemsmJSLg8Q_7U7@fat_crate.local>
References: <20240913083155.9783-1-ricardo.neri-calderon@linux.intel.com>
 <20240913083155.9783-3-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240913083155.9783-3-ricardo.neri-calderon@linux.intel.com>

On Fri, Sep 13, 2024 at 01:31:54AM -0700, Ricardo Neri wrote:
> diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
> index 392d09c936d6..182cacd772b8 100644
> --- a/arch/x86/kernel/cpu/cacheinfo.c
> +++ b/arch/x86/kernel/cpu/cacheinfo.c
> @@ -178,7 +178,16 @@ struct _cpuid4_info_regs {
>  	struct amd_northbridge *nb;
>  };
>  
> -static unsigned short num_cache_leaves;
> +static inline unsigned int get_num_cache_leaves(unsigned int cpu)
> +{
> +	return get_cpu_cacheinfo(cpu)->num_leaves;
> +}

There already is

#define cache_leaves(cpu)       (ci_cacheinfo(cpu)->num_leaves)

And there's also get_cpu_cacheinfo().

And now you're adding more silly wrappers. Yuck.

Can we pls use *one* of those things and work with it everywhere?

> @@ -742,19 +753,19 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
>  	unsigned int l2_id = 0, l3_id = 0, num_threads_sharing, index_msb;
>  
>  	if (c->cpuid_level > 3) {
> -		static int is_initialized;
> -
> -		if (is_initialized == 0) {
> -			/* Init num_cache_leaves from boot CPU */
> -			num_cache_leaves = find_num_cache_leaves(c);
> -			is_initialized++;
> -		}
> +		/*
> +		 * There should be at least one leaf. A non-zero value means
> +		 * that the number of leaves has been initialized.
> +		 */
> +		if (!get_num_cache_leaves(c->cpu_index))
> +			set_num_cache_leaves(c->cpu_index,
> +					     find_num_cache_leaves(c));

Ugly linebreak.

>  
>  		/*
>  		 * Whenever possible use cpuid(4), deterministic cache
>  		 * parameters cpuid leaf to find the cache details
>  		 */
> -		for (i = 0; i < num_cache_leaves; i++) {
> +		for (i = 0; i < get_num_cache_leaves(c->cpu_index); i++) {
>  			struct _cpuid4_info_regs this_leaf = {};
>  			int retval;
>  
> @@ -790,14 +801,14 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
>  	 * Don't use cpuid2 if cpuid4 is supported. For P4, we use cpuid2 for
>  	 * trace cache
>  	 */
> -	if ((num_cache_leaves == 0 || c->x86 == 15) && c->cpuid_level > 1) {
> +	if ((!get_num_cache_leaves(c->cpu_index) || c->x86 == 15) && c->cpuid_level > 1) {
>  		/* supports eax=2  call */
>  		int j, n;
>  		unsigned int regs[4];
>  		unsigned char *dp = (unsigned char *)regs;
>  		int only_trace = 0;
>  
> -		if (num_cache_leaves != 0 && c->x86 == 15)
> +		if (get_num_cache_leaves(c->cpu_index) && c->x86 == 15)
>  			only_trace = 1;
>  
>  		/* Number of times to iterate */
> @@ -993,12 +1004,9 @@ int init_cache_level(unsigned int cpu)
>  {
>  	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
>  
> -	if (!num_cache_leaves)
> -		return -ENOENT;

Why not

	if (!cache_leaves(cpu))
		return -ENOENT;

?

>  	if (!this_cpu_ci)
>  		return -EINVAL;
>  	this_cpu_ci->num_levels = 3;
> -	this_cpu_ci->num_leaves = num_cache_leaves;
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

