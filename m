Return-Path: <linux-kernel+bounces-537320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A1FA48A78
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952C6188AEC5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19D6271271;
	Thu, 27 Feb 2025 21:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roEuPkyH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A821E51D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691698; cv=none; b=k7KD52jTc/vgBh7D7sl+20yfR0cRVT/f8TRyngdwgIN2FcpPCm3CdcjVy691rdwP8AP+rq+V5nYegqWgIaTxSlKNEReBMbV0PREbNx+kCmtIkfmTmQYUN5TXxZ3qA8imZn9fkEpsdGWlEQVqylhqOw+gT0s0pwUnX3eSbiqio8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691698; c=relaxed/simple;
	bh=Lisq9vSohjz+gAft57tJmPFBOCX3wlnuInjHm+rEYS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZlHp7C0FZoFDYBmTqC2ACphIOK+ZD2S5/aOtVUK2ZR4JClsOm7H4rsDaDJBiKby/BU2DcARwKPQ+Ht0Go6Fc1KByzdE/jbYtNJGrZ+FyooNSXn+s50HMqp6aDIlyilKUbddZcVPek5twnEuMSmnBngGQoEeCHbk9E3ES0ogxuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roEuPkyH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB47C4CEDD;
	Thu, 27 Feb 2025 21:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740691697;
	bh=Lisq9vSohjz+gAft57tJmPFBOCX3wlnuInjHm+rEYS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=roEuPkyHxUt5iKjYQMrBuRjvL3/9LDy00mVFxgC5tsvT5Uo3v5VejDbBgDd22AGli
	 jYSVk+IOGxpT0mCXXgMBeterOb5mlYn6jQJD+TFVsO1/ms0damDCni8H0llLIh5Wbv
	 bQW9fKjbUwe3NExm1nw3gjsVHm0kt60QAgc/4+m2UVxtQhu+1J9d9xMG16RmjANSyV
	 XVQxX4IzoZj70DWz/H0TYArLPNNzHlbKN8JrAE1UoDfWfxSTMBSAohxqNyE5EQmacc
	 ra78xzLdFtY53m36OO1HpZiztvmo3pTrjnAfVMZec1CluuEbcp/EVEpfyO9S7frbcr
	 81UEqdAvHit7g==
Date: Thu, 27 Feb 2025 22:28:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: bp@alien8.de, chang.seok.bae@intel.com, dave.hansen@intel.com,
	dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
	mingo@redhat.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order
 table and accessor macro
Message-ID: <Z8DY7P6UJFyCg47Z@gmail.com>
References: <Z8C-xa7WB1kWoxqx@gmail.com>
 <94083f1c-dab1-4b57-bd45-a4d4f8ac262e@citrix.com>
 <Z8DFusMiUYPZ3ffd@gmail.com>
 <ea20d47e-88b9-46ab-9893-26bcf262d8b0@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea20d47e-88b9-46ab-9893-26bcf262d8b0@citrix.com>


* Andrew Cooper <andrew.cooper3@citrix.com> wrote:

> > There's no incompatibility for a default-disabled feature that gets 
> > enabled by an AVX-aware host kernel and by AVX-aware guest kernels. 
> > What ABI would be broken?
> 
> I don't understand your question.
>
> XSAVE, and details about in CPUID, are a stated ABI (given in the SDM 
> and APM), and available in userspace, including for userpace to write 
> into a file/socket and interpret later (this is literally how we 
> migrate VMs between different hosts).
> 
> You simply redefine what %xcr0.bnd_* (a.k.a. XFEATURES 3 and 4) mean, 
> irrespective of what a guest kernel thinks it can get away with.

XFEATURES bits 3 and 4 are zero by default in the CPU, so the previous 
ABI promise has been fully met: MPX is unavailable and disabled.

I propose a new addition, an extension of functionality: if a new CPUID 
bit indicates it, and a new MSR is written, XFEATURES bit 3 becomes 
active again - and the MPX area is now used by AVX. Obviously only 
AVX-aware host and guest kernels would enable AVX.

Thanks,

	Ingo

