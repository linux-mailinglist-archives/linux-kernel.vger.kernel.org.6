Return-Path: <linux-kernel+bounces-537337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E353A48AAB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7C5188D41C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A84271285;
	Thu, 27 Feb 2025 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxATs8ob"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F1271260
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692247; cv=none; b=fSynitQgvzM0O80FjNLlYOg5wGFLvuuaqy8akvLO1RPVRgzvFio5WnzCVs6fJlyQcpa5chFC3SYqQ8P8Xm5VkJRCcEpu2nP1OIXAOh5jmvvPkUDTS4KFBxh+1y2JTASsLi/1oZHMOgCdfxm1ZTkVmYyTlSqcssRkhWTGKU1xsQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692247; c=relaxed/simple;
	bh=5YAIDEAQIlp17X0qAKcVjQbHeWTeAeoMEC0RfqDAacI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgPP1uF9NU7M0oRm61qQSiMK+QMTVjZcd4G08qcdv5PocJ0/GtMYlEoKla7gQY+cJ6WDq5s3+HlHVDNyYIc7aAB6OvSIfKP7uEZBtd4Jw5PmBBGkp+la4sDoN8WF7exbXiwkcfCTZgQqzHprz64wm6NqT+4JBj2srhXq8WWiK18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxATs8ob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B88C4CEDD;
	Thu, 27 Feb 2025 21:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740692246;
	bh=5YAIDEAQIlp17X0qAKcVjQbHeWTeAeoMEC0RfqDAacI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jxATs8obU1IWWCZcDpSukolbrGYGGYn/EUd0R4HAK2gbF3hupgFU8xHX0IJRYq3QJ
	 SmlBdDAqON48Ff8rUgW8Umh2OQeZ+7ur0k+gnGdGj0g3lmEmeqTEIv+XDL9NDqBbVf
	 cBqZy9jlY80528uramNisE1Ca9MSVrUcNj/+ojOMMsf14Jj448eh5YFsSSY1Tw84gN
	 IDde9rEFj8uyBGSPhLnZHcDNlklqR1bvO9QD/Rzr1SvFGNAqwR/DUUAxAXee0Tk3Kb
	 avXR95SpgVmSqlJxRnFZcyl7ZO/GfU0C6LPNroJhJV3wwOPwVLDyNEl1QbjNscJW0m
	 tDCc7+k9/Q6GA==
Date: Thu, 27 Feb 2025 22:37:22 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order
 table and accessor macro
Message-ID: <Z8DbEqXaxEB_4wmI@gmail.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250227184502.10288-3-chang.seok.bae@intel.com>
 <Z8C3ZcMgHuBtIjFR@gmail.com>
 <674db309-e206-4bb4-bf99-b3c39bff7973@intel.com>
 <Z8C-xa7WB1kWoxqx@gmail.com>
 <af4ec757-22fd-4438-91fc-d8778998bf07@intel.com>
 <Z8DE0K2EEDe1dQdh@gmail.com>
 <4c71fc86-2d70-4d50-b041-d6ef8c1baf4c@intel.com>
 <Z8DLKj8qdLb7MllO@gmail.com>
 <1fb9325e-4430-4ac8-956f-c5255c9c9971@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fb9325e-4430-4ac8-956f-c5255c9c9971@intel.com>


* Dave Hansen <dave.hansen@intel.com> wrote:

> On 2/27/25 12:29, Ingo Molnar wrote:
> > My '#4' suggestion:
> > 
> >  - On bootup the CPU would not have the MPX/AVX bit enabled. So old 
> >    host kernels are fine as-is.
> 
> Could you be specific about "the MPX bit"? Because, first of all, there
> are a lot more than one bit in play here:
> 	
>  * The MPX state enumeration in CPUID.0DH:EAX[3:4]
>  * The MPX state enabling in XCR0[3:4]
>  * The MPX ISA enumeration CPUID.07H:EBX[14]
> 
> As far as the architecture goes, those XSAVE enabling/enumeration bits
> are rather independent from the _additional_ X86_FEATURE_MPX ISA CPUID bit.
> 
> Like I showed in my earlier example, the CPU enumerates which XSAVE
> features are available. These enumeration bits in CPUID leaf 0xd *ARE*
> set at boot independent of any other enabling or enumeration. In this
> regard, XSAVE enumeration is quite independent of the other parts of the
> ISA. This could, in theory, be changed to become dependent on some kind
> of APX enabling. But that would be novel for an XSAVE feature.

Yeah. That would be novel for an XSAVE feature - but so is the change 
in ordering. With my proposal we'd avoid the 
xfeature_noncompact_order[] indirection table AFAICS.

> Right now, the entirety of CPUID.0DH:EAX/EDX is static. It does not 
> change based on enumeration or other enabling. It can literally come 
> out of the microcode ROM.
> 
> So are you proposing that CPUID.0DH:EAX[3:4] would be 0x0 or 0x3 at 
> CPU reset? Or, that CPUID.0DH:EAX[3:4] would default to 0x0 at reset 
> and then flip to 0x3 based on some other kind of novel APX opt-in?

Yeah, I was thinking of a novel APX opt-in in the CPUID space, 
triggered via an MSR write or so, only triggered by APX-aware
host and guest kernels.

Old kernels would see 0 in all the legacy MPX state bits.

( Assuming this actually works for APX. )

Thanks,

	Ingo

