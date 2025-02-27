Return-Path: <linux-kernel+bounces-537275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5613FA489E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC62166B3B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C7527127D;
	Thu, 27 Feb 2025 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjTej3kl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D3E26F465
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688179; cv=none; b=k1SzlxeVS7Np12MzvseQDLfuPT2SlPRDfVG75RAOmYV+w2KECLjVmBl3jHnN5VlG2YEeVBUHmjCZ37P6jwLGhW2cNwVtDJMoonlYMvyqUrHQpTTdgvgqZmZ9qfKeQ17m1GWLv/jNS6HFg6+rIZeMiE9/9j3cTb2MJmevGFQAdoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688179; c=relaxed/simple;
	bh=MFm1+DS3TOP6bl6ewOGMQ37+q+R/RmAOu71FJuVFXvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooBek5PYMieoXm6un+XGivu7NkDJA1CC4h5d28UsJxOXpHsI4OBjmqbFIjhIILEfSVOZpvVrQp6Z4Z2E03O2QLihyQnn+7ePhjp/5lkuf1HzMGhr9rQPNPW5fiX0pJMu9jqElMLtCNzmvLKHBUIENQCjIdljYHt8oAEjhwLRZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjTej3kl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54814C4CEE4;
	Thu, 27 Feb 2025 20:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740688179;
	bh=MFm1+DS3TOP6bl6ewOGMQ37+q+R/RmAOu71FJuVFXvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NjTej3kll3N8/tb0b/psGGPW+gFGk31EYGfPV+IJXEODZuyxg8Zm8Od1T82f+0Zvo
	 9yBZyZqnEeSXMcia9+s5h56CJ9KpDvlgUQEsDi+BurWYnnziSOfWoJEJsMThD4syN9
	 EqQ5fehpxRkTbvqfTuemvAm6F+lHpwIXaQPB7IaNwTnZTqLd0kkC/Co0zUdz5KwsW8
	 OoYi8Md9Rjl4eSVCKSQDJf0lV5rqDcJ93nc/jswaATU5UiEaqsY/gdrJOeLeufc1xv
	 EmRdBf1odvlRZSzxjTSwSnGIFlDdg5cAO7KbCMpHBJIuzaRpKs3kBKSDRkVsNRlNWB
	 yXUpGtNjmp3XA==
Date: Thu, 27 Feb 2025 21:29:30 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order
 table and accessor macro
Message-ID: <Z8DLKj8qdLb7MllO@gmail.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250227184502.10288-3-chang.seok.bae@intel.com>
 <Z8C3ZcMgHuBtIjFR@gmail.com>
 <674db309-e206-4bb4-bf99-b3c39bff7973@intel.com>
 <Z8C-xa7WB1kWoxqx@gmail.com>
 <af4ec757-22fd-4438-91fc-d8778998bf07@intel.com>
 <Z8DE0K2EEDe1dQdh@gmail.com>
 <4c71fc86-2d70-4d50-b041-d6ef8c1baf4c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c71fc86-2d70-4d50-b041-d6ef8c1baf4c@intel.com>


* Dave Hansen <dave.hansen@intel.com> wrote:

> On 2/27/25 12:02, Ingo Molnar wrote:
> >>> There's a 4th option:
> >>>
> >>>    4. Reuse XFEATURES 3/4 (MPX) only on APX-aware kernels, keep it 
> >>>       disabled for old kernels.
> >>>
> >>> Problem solved.
> >> The worry boils down to code in the kernel or userspace doing this:
> >>
> >> 	if (XGETBV(0) & 0x11)
> >> 		do_mpx_gunk();
> > New, APX-aware kernels wouldn't be doing this, why would they?
> 
> New, updated software is rarely the problem. It would not be a problem
> in this case either.
> 
> The problem is with old OSes/VMMs and even old userspace on new kernels.

So this is the 3rd time I have to repeat that if the MPX/AVX bit is 
disabled in the CPU by default on bootup, these old kernels will work 
fine just like they do today, so I think we might be talking past each 
other.

Let's try again:

> So I'm not _quite_ sure what you meant when you said:
> 
> > Old kernels would *never* see this bit enabled if it's disabled by
> > default on bootup ...
> 
> Because old kernel very much do see the MPX bits in CPUID and very 
> much do enable them by default via XSETBV.

My '#4' suggestion:

 - On bootup the CPU would not have the MPX/AVX bit enabled. So old 
   host kernels are fine as-is.

 - On new, AVX-aware host kernels, the AVX boot code enables the APX 
   bit (via a ususal CPUID discovery mechanism), which is the same as 
   the old MPX bit.

 - Likewise, the APX init code in APX-aware guest kernels would be able 
   to enable the APX bit as well. Old guest kernels will have the 
   APX/MPX bit disabled and will continue to work fine.

 - [ With this approach there's no out-of-order feature bit problem, 
     the APX feature bit lines up with the APX xsave area. Enabling AVX 
     would require very little code - only the CPUID discovery and MSR 
     twiddling to enable it in the FPU init path, plus similar KVM 
     code. ]

Thanks,

	Ingo

