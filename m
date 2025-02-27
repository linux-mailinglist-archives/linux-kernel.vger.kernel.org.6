Return-Path: <linux-kernel+bounces-537109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AACA4881C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24E817A41F1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BA22356D3;
	Thu, 27 Feb 2025 18:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWZTdLK1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965DC18CC15
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681989; cv=none; b=rQLjw4sFoGvDEm5N9pJJBiAJb/3tEe308HWAol8OXGfSQg1HOMiGZOa3dJ0CUG2E1Hep8fu8gHyEpVV07Fh2Q1bwtJMAnNRJCtiZwVfSoO99I8VeJTTeTpw/aDLjz8N1OvNO8l05i7+7yBMnRVsfFVD+gz9VoqEqRgd9hXLbQVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681989; c=relaxed/simple;
	bh=BjZdXViAG8ZGsrjysMXmH9bmFLZCSMf57ftylZQhXLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z32hBQYcRd9VHoxZPktYPR/jD8YAgPqN69fUaUAClWENtTf9FpjbaighGvgjnptI0P2NIRiOPsikpwIpxCrJMd0r9gInEcIK1PnoQIh4/G/3OoyWrPHB+S5pTuTVJhEjd+QeEMl+QMOLUK2s2MLepqVyf9ielLPQgTymLqrNRYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWZTdLK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F305C4CEDD;
	Thu, 27 Feb 2025 18:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740681989;
	bh=BjZdXViAG8ZGsrjysMXmH9bmFLZCSMf57ftylZQhXLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CWZTdLK1ks3LWoFUL5XgfldOguqz+9Jl4/26OvK8cc1tSHt6oWYk8aMjDsGJ/xyvW
	 UPtIchLAqsTEUTTO91PrHcLggKLC/i2Oq/BVgRUPAMabK+lv9nY0hG6LHsefeWFugL
	 xwqgLX6oAW45rgpsGjF6IUWdEv9Widz+MTTqU9b06DxCa/Q/57LYJ6d5qz+FmhToRm
	 bq4rhlcJW06cuy7ykPLi0bWcCnUsV3eH7/twn8x+dQ2A711l0D0EylCq7o/+OAR5CN
	 0Mu653gXdFH2cZEI/fqcdayAIk95yI+LxnnsKmbuCR0mOTsYdG/rmbLTVzr906iy2E
	 18EOgKwFJvKOw==
Date: Thu, 27 Feb 2025 19:46:16 +0100
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
Subject: Re: [PATCH v4] x86/cpufeature: Add feature dependency checks
Message-ID: <Z8Cy-IonwmCGNkkQ@gmail.com>
References: <20241210224037.3052555-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210224037.3052555-1-sohil.mehta@intel.com>


* Sohil Mehta <sohil.mehta@intel.com> wrote:

> +
> +/*
> + * Return the feature "name" if available otherwise return
> + * the X86_FEATURE_* numerals to make it easier to identify
> + * the feature.
> + */
> +static const char *x86_feature_name(unsigned int feature, char *buf)
> +{
> +	if (x86_cap_flags[feature])
> +		return x86_cap_flags[feature];
> +
> +	snprintf(buf, 16, "%d*32+%2d", feature / 32, feature % 32);
> +
> +	return buf;
> +}
> +
> +void filter_feature_dependencies(struct cpuinfo_x86 *c)
> +{
> +	char feature_buf[16], depends_buf[16];
> +	const struct cpuid_dep *d;
> +
> +	for (d = cpuid_deps; d->feature; d++) {
> +		if (cpu_has(c, d->feature) && !cpu_has(c, d->depends)) {
> +			pr_info("CPU%d: Disabling feature %s due to missing feature %s\n",
> +				smp_processor_id(),
> +				x86_feature_name(d->feature, feature_buf),
> +				x86_feature_name(d->depends, depends_buf));
> +			do_clear_cpu_cap(c, d->feature);
> +		}
> +	}

So let's not disable any CPU features actively for the time being, how 
about issuing a pr_warn() only about the dependency violation?

I think the main problem is when these problems slip through 100% 
unnoticed.

Thanks,

	Ingo

