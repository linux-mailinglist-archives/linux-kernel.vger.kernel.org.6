Return-Path: <linux-kernel+bounces-319084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F3A96F78E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE62C1C225E0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89ABF1D1F70;
	Fri,  6 Sep 2024 14:56:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A9B156880
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634616; cv=none; b=jt4gikTCph7QAaOTEcgx5ti0orJRwu3P+exH7riQl8HgE8BwlF1FZ9KyErfsfomErRfcTppxp1ZiLKCmDxvoK+AhSTOxubr6Tlz2aZohwKjHlyKgR5GxgIG6ghAoQqmVgoFWra/NtvBXVKEvk/HUGstlv9C9xGHPOCRXhcyFXFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634616; c=relaxed/simple;
	bh=+TLPMiAW5HQgT8IRNg4ZsiR6YFeUb9/XQSqDGmgJaZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5/6mzxEmbBFw/Ph/yrjdgwnDQ3oDMGDV+AIeD/ow0ADm66NJ5e1ismoe062gzqa6kh1+fOCPtq8S1UL0jkVI167e4cbEplc2IheI5RwtjB7aI3HLe01nHgpHv15BymtoppA5SyMXuPoaRElpVpsr0xdtQqJKzRyP+9KFmfocHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89D6C4CEC6;
	Fri,  6 Sep 2024 14:56:54 +0000 (UTC)
Date: Fri, 6 Sep 2024 15:56:52 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64/fpsimd: Ensure we don't contend a SMCU from idling
 CPUs
Message-ID: <ZtsYNOTA6ekEa6TE@arm.com>
References: <20240618-arm64-sme-no-cpuidle-v1-1-1de872e1691f@kernel.org>
 <Zo7qzWVXRWulVtCT@arm.com>
 <Zo8ZDBisWJonBVqF@finisterre.sirena.org.uk>
 <Ztnvosf0JHsvCf7-@arm.com>
 <8c625518-7f73-40c9-8c91-3a0b14240003@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c625518-7f73-40c9-8c91-3a0b14240003@sirena.org.uk>

On Thu, Sep 05, 2024 at 07:34:41PM +0100, Mark Brown wrote:
> On Thu, Sep 05, 2024 at 06:51:30PM +0100, Catalin Marinas wrote:
> 
> > OK, so likely the state is already saved, all we need to do here is
> > flush the state and SMSTOP. But why would switching to idle be any
> > different than switching to a thread that doesn't used SME? It feels
> > like we are just trying to optimise a special case only. Could we not
> > instead issue an SMSTOP in the context switch code?
> 
> On context switch the SMSTOP is issued as part of loading the state for
> the task but we only do that when either returning to userspace or it's
> a kernel thread with active FPSIMD usage.  The idle thread is a kernel
> thread with no FPSIMD usage so we don't touch the state.  If we did the
> SMSTOP unconditionally that'd mean that the optimisation where we don't
> reload the FP state if we bounce through a kernel thread would be broken
> while using SME which doesn't seem ideal, idling really does seem like a
> meaningfully special case here.

It depends on why the CPU is idling and we don't have the whole
information in this function. If it was a wait on a syscall, we already
discarded the state (but we only issue sme_smstop_sm() IIUC). With this
patch, we'd disable the ZA storage as well, can it cause any performance
issues by forcing the user to re-fault?

If it's some short-lived wait for I/O on page faults, we may not want to
disable streaming mode. I don't see this last case much different from
switching to a kernel thread that doesn't use SME.

So I think this leaves us with the case where a thread is migrated to a
different CPU and the current CPU goes into idle for longer. But, again,
we can't tell in the arch callback. The cpuidle driver calling into
firmware is slightly better informed since it knows it's been idle (or
going to be) for longer.

> > Also this looks hypothetical until we have some hardware to test it on,
> > see how it would behave with a shared SME unit.
> 
> The specific performance impacts will depend on hardware (there'll
> likely be some power impact even on things with a single FP unit per
> PE) but given that keeping SM and ZA disabled when not in use is a
> fairly strong recommendation in the programming model my inclination at
> this point would be to program to the advertised model until we have
> confirmation that the hardware actually behaves otherwise.

Does the programming model talk about shared units (I haven't read it,
not even sure where it is)? I hope one CPU cannot DoS another by not
issuing SMSTOPs and the hardware has some provisions for sharing that
guarantees forward progress on all CPUs. They may not be optimal but
it's highly depended on the software usage and hardware behaviour.

I'm inclined not to do anything at this stage until we see the actual
hardware behaviour in practice.

-- 
Catalin

