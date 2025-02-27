Return-Path: <linux-kernel+bounces-537324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67433A48A83
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57AA43B62FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B5E26FA5D;
	Thu, 27 Feb 2025 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B79W2htB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB331EB5C4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691837; cv=none; b=JAadz/j+3ie1tHGJom2YID/tSZGthzdisUkui0IlHMBkbQNxsmXV8MV4+ssY5jFa2rv+IlCa/yqQPfZh0t30SpZWNGODVS2tOvGj4Z55Rxvdh5PnGJaZhuq7vWy7gV8fQC1LZkm5OLXWrh/VOM9+O/GqryziVnpfmZBIBvgSFvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691837; c=relaxed/simple;
	bh=tB1nOB5VVsj/Ec+EI21lUuJ8yJK/gmGyldkOhcaBZ4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBHys9rO5Dl6zSk+dr03QxzVGR/pPnyQEYLC5aNdmr1eo2VJqWXnQx2TOfYjnhRSF71lewUp8A/3snHeCwKVziVcaMgYlsajWFQ53FH3rcSAlfXCL6twfC1hTmspr6LVuPrfOvbUTrRxt7UcT7NKE9vh6lu9EBB8fGynhUdW0ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B79W2htB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50986C4CEDD;
	Thu, 27 Feb 2025 21:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740691837;
	bh=tB1nOB5VVsj/Ec+EI21lUuJ8yJK/gmGyldkOhcaBZ4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B79W2htB6CNtwY3Jt9E+MSSWOmBigYoEOdXwmDQfSNmSsuX5XmcNpnJs6xqPxj8Qz
	 JEu+HWjjtkC13MvgiYF0sOXkY3k4+9HWGKBfslG3S4yMl9Q/JzVx9SHQdt/o1BY/EY
	 ZHTFlFHlSUJtgVTOHOECGLkwDs04No9GPjO+7sc90rfgKhos/u2Q/MhqedbTGTFE6u
	 K5uCdtXQ6e+dzheUvulCOWWJtzNNPYPvMYntTmUk+PoYZuBPjipIguO7zVmZrGMcFp
	 dH6jCzpKvyYqAOZ2VohhRBcKa/3b08oBgFXExOBApZy6GTjc9e/wSyjqDmuJq+AUmf
	 XzUf1C7RzkVUg==
Date: Thu, 27 Feb 2025 22:30:26 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: bp@alien8.de, chang.seok.bae@intel.com, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
	mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order
 table and accessor macro
Message-ID: <Z8DZcj-jrTJIOat8@gmail.com>
References: <Z8C-xa7WB1kWoxqx@gmail.com>
 <94083f1c-dab1-4b57-bd45-a4d4f8ac262e@citrix.com>
 <Z8DFusMiUYPZ3ffd@gmail.com>
 <ea20d47e-88b9-46ab-9893-26bcf262d8b0@citrix.com>
 <Z8DY7P6UJFyCg47Z@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8DY7P6UJFyCg47Z@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Andrew Cooper <andrew.cooper3@citrix.com> wrote:
> 
> > > There's no incompatibility for a default-disabled feature that gets 
> > > enabled by an AVX-aware host kernel and by AVX-aware guest kernels. 
> > > What ABI would be broken?
> > 
> > I don't understand your question.
> >
> > XSAVE, and details about in CPUID, are a stated ABI (given in the SDM 
> > and APM), and available in userspace, including for userpace to write 
> > into a file/socket and interpret later (this is literally how we 
> > migrate VMs between different hosts).
> > 
> > You simply redefine what %xcr0.bnd_* (a.k.a. XFEATURES 3 and 4) mean, 
> > irrespective of what a guest kernel thinks it can get away with.
> 
> XFEATURES bits 3 and 4 are zero by default in the CPU, so the previous 
> ABI promise has been fully met: MPX is unavailable and disabled.
> 
> I propose a new addition, an extension of functionality: if a new CPUID 
> bit indicates it, and a new MSR is written, XFEATURES bit 3 becomes 
> active again - and the MPX area is now used by AVX. Obviously only 
> AVX-aware host and guest kernels would enable AVX.

Erm, s/AVX/APX ...

Too many acronyms.

Thanks,

	Ingo

