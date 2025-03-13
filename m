Return-Path: <linux-kernel+bounces-559175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A30A5F066
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272D517CD89
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63419264F8C;
	Thu, 13 Mar 2025 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugcnYxaZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24171EE028
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741860899; cv=none; b=A3uo1BRAifhOKIRpb29i25zAlQkKWuRDD97V90HJXGiNXTNEk52w2LwhtxfQwIjrFu30gGkYgn7n3zs0/hD3ySa4zYbS/qeytqQliL5GwluIonzVqRjAOylM6KzO84XrR6s4FUejwDO4JppPdn4piGw2WUnzcsvLWGr9O4FNQhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741860899; c=relaxed/simple;
	bh=WVTEqUhJ7/BgMAK8ZwgIuXdFji02ZncxR5TKwQmTydA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nv1Xzatok0hkJmcX5EbfpgCysDUlILSMKgT7SgQLEd8745AH2MtpjSvAVj5HIA4DNrN5WUhQGgv5B1OqiPFQntrLfHCXJ63GCoe912pfKPYJ/6zIUnKFUkWpJ6bEAODOpXnITxKsN1WaOYsAuJA2DC9Hq2gbB72cyRsW0jXuk6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugcnYxaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EC6C4CEDD;
	Thu, 13 Mar 2025 10:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741860899;
	bh=WVTEqUhJ7/BgMAK8ZwgIuXdFji02ZncxR5TKwQmTydA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugcnYxaZ4SuG1MgMOz3S0kNiRFbRMTjZmgfV5hzriwytxOlfJ8g1BLLnBGW0YZA/o
	 2plpQsJDhC018QK6x8+RpXRu7pkUFc3tPr+sSt4y8DgGgx9zjAfRRUu1bLQGgk2Nx/
	 H2XV9MYhCho1rcdZq7Qw3s86gINvw4166a4l1Nzrw7UqBEqGoLOI7pdgBlnTFstLUO
	 vhwy0kFjoONtNpexeC7zdPaSecEHFIPFv20aOYPd508hFCSEc+qTQFQBj326CMkh1j
	 ct6x6YZdAVC9nfJT0G9bEj+JWgT7c2/OloXbsMJi6ESQLIkkUjryjh6ncQKInPoUCs
	 onwL5cbu/J5sA==
Date: Thu, 13 Mar 2025 11:14:51 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"H . Peter Anvin" <hpa@zytor.com>, Uros Bizjak <ubizjak@gmail.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Tony Luck <tony.luck@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Eric Biggers <ebiggers@google.com>, Xin Li <xin3.li@intel.com>,
	Alexander Shishkin <alexander.shishkin@intel.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] x86/cpufeature: Warn about unmet feature dependencies
Message-ID: <Z9KwG9t2OVhoapZc@gmail.com>
References: <20250307000204.3581369-1-sohil.mehta@intel.com>
 <Z8resWzgtZaTuzEN@gmail.com>
 <ed81aa4e-6ebc-40ad-af45-289cc7138c0f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed81aa4e-6ebc-40ad-af45-289cc7138c0f@intel.com>


* Sohil Mehta <sohil.mehta@intel.com> wrote:

> On 3/7/2025 3:55 AM, Ingo Molnar wrote:
> 
> >>  
> >> +	/* Scan for unmet dependencies based on the CPUID dependency table */
> >> +	scan_feature_dependencies(c);
> > 
> > s/scane_feature_dependencies
> >  /x86_check_cpufeature_deps
> > 
> 
> How about check_cpufeature_deps() without the "x86" prefix? It would
> blend in with the other function calls in early_identify_cpu() and
> identify_cpu().

Yeah, I suppose that would work too. There's no discernible rhyme and 
reason to the naming choices within the interfaces used by 
arch/x86/kernel/cpu/common.c that I can see, so I suppose the shorter 
one that is still unambiguous wins.

> >> + */
> >> +static const char *x86_feature_name(unsigned int feature, char *buf)
> >> +{
> >> +	if (x86_cap_flags[feature])
> >> +		return x86_cap_flags[feature];
> >> +
> >> +	snprintf(buf, 16, "%d*32+%2d", feature / 32, feature % 32);
> >> +
> >> +	return buf;
> >> +}
> >> +
> 
> I was wondering if it would be better to build the feature name using 
> a macro and reusing it elsewhere? This is all I could come up with:
> 
> /*
>  * Use with a %s format specifier to print the feature name.
>  *
>  * Return the feature "name" if set, otherwise return the X86_FEATURE_*
>  * numerals to make it easier to identify the feature.
>  */
> #define x86_feature_name(feature) \
> 	(x86_cap_flags[feature] ? x86_cap_flags[feature] : \
> 	({ \
> 		char buf[16]; \
> 		snprintf(buf, 16, "%d*32+%2d", feature >> 5, feature & 31); \
> 		buf; \
> 	}) \
> 	)

I'm not sure this is an improvement.

> This would remove the need for callers to explicitly define a buffer. 
> Also, it would help reduce a few lines in the newly merged 
> parse_set_clear_cpuid(). But overall, it doesn't seem worth it. Let 
> me know if you think otherwise or have a better idea.

No good ideas right now.

> > I'd make this a bit less passive-aggressive, something like:
> > 
> >      x86 CPU feature dependency check failure: CPU%d has '%s' enabled but '%s' disabled. Kernel might be fine, but no guarantees.
> > 
> 
> Sure! How about making it slightly shorter?
> 
> "x86 CPU feature check: CPU%d has '%s' enabled but '%s' disabled. Kernel
> might be fine, but no guarantees."

Yeah, so I really wanted to sneak in the 'dependency' part - because 
it's not necessarily obvious from the text, and most syslog readers 
will have no idea what it's all about.

I don't think line length should be an issue for a message we don't 
expect to trigger normally. Clarity is more important.

Thanks,

	Ingo

