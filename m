Return-Path: <linux-kernel+bounces-537251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E24A489AC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812A0188B362
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEADE26A0FD;
	Thu, 27 Feb 2025 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpbRLRIF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488C01C07E6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687477; cv=none; b=nTE6M7BK10bYSebCdY4Vv1MZChFcWV02QnuZYVGK+yQLIeXyUbq2h0qvwPnQ3slwRC/PLAgRm5x95n01PDe7J4YJSB22y+RTOi4NXybIbQW7Yufbduk2lvUZtd0c/uSHhHlwXWx5xKhKtD6RvnTr6jD2c4UmU8RFvvAebh/T+N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687477; c=relaxed/simple;
	bh=G/054Nv3DeDkCI6uFnnAcRJt0QJ+9qUsRTrMWf+Ayi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjoLmYWkMJEbVb1gh/wW6ny8lfbxf5naNBnmyLwapnAX95n/gstumNKsFl+VNTlxJoohuY4ypkqfLoULrEK0+txijAcvzPEqVb1uUl1wjYFx5rKJzJCr7iAMvCsNFE+EzwcFBAd7ITD4PogpZo/EjihwxI92MK1Krry3v6K8pQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpbRLRIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599FDC4CEDD;
	Thu, 27 Feb 2025 20:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740687475;
	bh=G/054Nv3DeDkCI6uFnnAcRJt0QJ+9qUsRTrMWf+Ayi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DpbRLRIF+KR68tniydOvRXbQ5JVa/T1O/frJZrvpWmV1JlDNJJwjyszjCqDHWl0nA
	 n8jVQ2d4xc5n1UMd7KdmmRE77txsGv8Wj1w2Qt4InwklIPmLKMpTreTYDuyPcV8uUu
	 TDW16JHaBEDmFpTO9XyX6jjjPguCZL6Zc/wqG4M1VfH8JTXn3pi7NWR2oopEJXhXqO
	 pkyAe0AGGayIIznw2/Di1CLhKtrXGq8EkIq6Aonj5vfhuh85T2WEzGzbaEqASnIrC/
	 3ttJVsaR2g9AR/NVqS1wt5sxbUYLOegG9LKzzSks2vNxLbfXqfv6meIAILu2sbDEEn
	 lWjEppu87rsww==
Date: Thu, 27 Feb 2025 21:17:48 +0100
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
Message-ID: <Z8DIbMcUWEQYlL5w@gmail.com>
References: <20241210224037.3052555-1-sohil.mehta@intel.com>
 <Z8Cy-IonwmCGNkkQ@gmail.com>
 <8b174f56-191b-45bd-93ec-4c6444c770a5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b174f56-191b-45bd-93ec-4c6444c770a5@intel.com>


* Sohil Mehta <sohil.mehta@intel.com> wrote:

> On 2/27/2025 10:46 AM, Ingo Molnar wrote:
> 
> >> +void filter_feature_dependencies(struct cpuinfo_x86 *c)
> >> +{
> >> +	char feature_buf[16], depends_buf[16];
> >> +	const struct cpuid_dep *d;
> >> +
> >> +	for (d = cpuid_deps; d->feature; d++) {
> >> +		if (cpu_has(c, d->feature) && !cpu_has(c, d->depends)) {
> >> +			pr_info("CPU%d: Disabling feature %s due to missing feature %s\n",
> >> +				smp_processor_id(),
> >> +				x86_feature_name(d->feature, feature_buf),
> >> +				x86_feature_name(d->depends, depends_buf));
> >> +			do_clear_cpu_cap(c, d->feature);
> >> +		}
> >> +	}
> > 
> > So let's not disable any CPU features actively for the time being, how 
> > about issuing a pr_warn() only about the dependency violation?
> > 
> > I think the main problem is when these problems slip through 100% 
> > unnoticed.
> > 
> 
> I guess you are right. Highlighting the issue is the main part. Beyond
> that we can leave the system behavior as-is for now.
> 
> Most of the listed dependencies seem to be spec-driven, though the
> kernel might create arbitrary dependencies for security reasons such as
> making LAM depend on LASS[1]. I think those can probably be handled on a
> case by case basis during specific feature enabling.
> 
> For the new pr_warn(), I am considering printing it only once per
> feature instead of printing it on every CPU (which could be 100s).

Yeah.

> But that would mean tracking it in a global feature_warn bitmap.
> 
> 	DECLARE_BITMAP(feature_warn, MAX_FEATURE_BITS);
> 
> Another option would be run the scan only on the BSP. But that could
> cause some issues to be missed[2].

Just use pr_warn_once().

Yes, this might cause subsequent CPU feature dependency problems to 
stay unreported, but the hope here is that these are rare and get 
fixed, right?

Thanks,

	Ingo

