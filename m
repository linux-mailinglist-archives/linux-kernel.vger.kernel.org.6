Return-Path: <linux-kernel+bounces-537203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACB5A4891C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E353A6392
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B1726E96C;
	Thu, 27 Feb 2025 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktPg4lcH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A169F1C07E6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740685008; cv=none; b=cX8aOiaot1lTIyr+JpXNRphTvWB/Ps28zC9u18jplPCPpRq7HWMnCj6+NkHl7H29JEjRJWIks9oS+Y0qE1urlVgSm12RQPzJQAqBu/4PQU4YLv45sbfDabgqwMjdzWreZsXQEo2gREA/elvSPssc5HbEnu590imt4H1Qcr83c5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740685008; c=relaxed/simple;
	bh=NW2VP4OhgJwM3Ch6o8WX6ig/5EYrb1LIEQiz2uKICQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARbLai14I2w0HJaHb5wG37p/M26ZYp5achuBlcwbL6CVriUs9KJxUvB3Ifsvc8dS1lBmbFP3aguacjMeqXkpJsvP3u4l1h6GktH8VbsNI4OnrEl/TLr0kwp1WI8XyvZ8+BztrBt1CjEwhrE4Yks5TLsjrdOcrswqnAk+ZIj5a6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktPg4lcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10369C4CEDD;
	Thu, 27 Feb 2025 19:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740685008;
	bh=NW2VP4OhgJwM3Ch6o8WX6ig/5EYrb1LIEQiz2uKICQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ktPg4lcHeDYtqzsVG2+XmNF/mTjFuI0zcpFGwVhpodkpTqBScerIbLCM1r+3ijwKo
	 XiBqvQmjfpY6/SXQHtHlMQqIiq4/Tf5g8qLI7z/WRGzyg6zZSPTSKGMyXfN9kpMpkF
	 B1zT76ZSGb+aupWWyDmVesUwBDLYtXsmzTYPjAcZsYSw5j/JX0HNcJofcDh0xFkeCo
	 IzKSwwSEATnZggPG/2WQSelONSJke4I4T6iFswjenOTw1VsX1Tv+UV+wBpCVXV+c53
	 HloW5u4Czjj8HdBUbyMHEKadREh466fNH87YiXW6Oh/SETjAdEq/cIBIB1ZTtG6jTB
	 HWmbSjMNPqhYg==
Date: Thu, 27 Feb 2025 20:36:37 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order
 table and accessor macro
Message-ID: <Z8C-xa7WB1kWoxqx@gmail.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250227184502.10288-3-chang.seok.bae@intel.com>
 <Z8C3ZcMgHuBtIjFR@gmail.com>
 <674db309-e206-4bb4-bf99-b3c39bff7973@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674db309-e206-4bb4-bf99-b3c39bff7973@intel.com>


* Dave Hansen <dave.hansen@intel.com> wrote:

> On 2/27/25 11:05, Ingo Molnar wrote:
> > So why not just reuse the MPX feature number and have some sort of 
> > extended feature bit that tells us and userspace that it's APX? The 
> > xsave area is getting reused anyway - causing all this indirection and 
> > trouble ...
> > 
> > Since we don't really do much for MPX in the kernel, and APX is not 
> > supposed to be used by the kernel either, it should be pretty much a 
> > shoe-in, right?
> 
> Theoretically, yes.
> 
> In practice, no.
> 
> MPX didn't have hardware enabling separate from the XSAVE enabling. So
> there is software out there that assumes that if it can see the MPX bits
> set in XCR0 that MPX is around. Take a look at kvm_mpx_supported() as an
> example. Would you be comfortable having an old kernel which had
> kvm_mpx_supported()==1 and X86_FEATURE_MPX==0? What about other VMMs?

I'd absolutely be comfortable if the APX bit was only enabled by newer, 
APX-aware kernels. Older kernels would see a non-MPX CPU and would 
handle it properly.

I really don't see the issue:

> There were basically three choices:
> 
>  1. Reuse XFEATURES 3/4 (MPX)
>  2. Create a new out-of-order XFEATURE 19 that reuses MPX space
>  3. Create a n in-order XFEATURE 19 that needs XFD and an opt-in
> 
> #1 risks breaking old MPX code in weird ways.

This is a false trichotomy. ;-)

There's a 4th option:

   4. Reuse XFEATURES 3/4 (MPX) only on APX-aware kernels, keep it 
      disabled for old kernels.

Problem solved.

> Is that what you were asking?

Yeah, thanks!

Thanks,

	Ingo

