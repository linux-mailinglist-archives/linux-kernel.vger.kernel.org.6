Return-Path: <linux-kernel+bounces-518712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B4DA393A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E44A7A390F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2091ACEB5;
	Tue, 18 Feb 2025 07:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M217Hu5I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BA433E4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739862303; cv=none; b=sO0AjkEzs4sHgoKy7PecgWyWH05INjumDtzSxYwD5DZXR4yu8La/8+n6IBhVfg2rOxXgxM87HYHK8ZyyBpJP2C+eQQg9u+/HiWf3g3ZVdmKmZqcBfhPh0r2meWPEhz6GpBS3lh98rFcUEKVzXuvofDBb1ZaNXkwh1GUf/jKM/Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739862303; c=relaxed/simple;
	bh=2rpxJgyouZ9eSsOh6PhY4BxbMZeNfYOzEbn3FxOFH84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxYU5lO2D4e70C3b4h3Mh77Y9FMlXOYXd7kOr95WgSAuQ6+SlGhSbdmCTOHqQ6dQD17RPSr2uC2miXy62piQtYV9p85AdXAlEH2kX/YXWYDVpNSDPKE12ilAC7cJC3lukCdzFlLOYOFSvcvK0B4hZqO6umP+nTRSPEpvh1FiDsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M217Hu5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC870C4CEE2;
	Tue, 18 Feb 2025 07:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739862303;
	bh=2rpxJgyouZ9eSsOh6PhY4BxbMZeNfYOzEbn3FxOFH84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M217Hu5IzvuOxg1Ua6VH8M7vwZVQXHjNW7QSBDQmC4XMHbjrIuYhFLCD/6UaO3Y2S
	 eWzL3cfAEK6JH2iPpAIBpf3oT9Nm/RxuI2L6CgUXCgEA2EvaTCEcakB/RIOQnu+D8u
	 YGt/IiDYm6jfKZYYD5bmuwdAaCcvJtIGJPDYicwDwyyQOfIR6t4iinlNVEasiAaUPc
	 AiTFrZ2CfHq9z1VkuLp1AeR3F//lm5RXf1NNZeEcxrKRR3KM79Lzp2hSey3DbG59Uf
	 FB7NXR6ToCRF3tUbtFNoGCjrmd2Zx19Sq5V8zaLqMAGfFxEVsZ1WabiBUNC8lpc8/7
	 RpM0og+xth7MA==
Date: Mon, 17 Feb 2025 23:05:01 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
Message-ID: <20250218070501.7mwcxqgsuxl3meef@jpoimboe>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-21-david.kaplan@amd.com>
 <20250211180752.pfsjvz62bztpnmoi@jpoimboe>
 <LV3PR12MB9265804700AB74A446F5220F94FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <LV3PR12MB926524EFB64F6FB361046C5E94FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217201910.crsu7xucsa4dz3ub@jpoimboe>
 <LV3PR12MB9265249E8D0FD3920C42A1A994FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217233928.k3oem3bm7w63jzfr@jpoimboe>
 <LV3PR12MB9265041C9D8D4F3E5760F0B694FA2@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265041C9D8D4F3E5760F0B694FA2@LV3PR12MB9265.namprd12.prod.outlook.com>

On Tue, Feb 18, 2025 at 02:24:01AM +0000, Kaplan, David wrote:
> > > I do agree that they can be arch-generic (hence why I originally put
> > > them in kernel/cpu.c) but I also don't know when (if ever) anyone from
> > > other archs will want to pick them up.
> >
> > Well, for example, we already have the generic
> > prctl(PR_SET_SPECULATION_CTRL) which is used by arm64.  If somebody boots
> > with mitigate_user_user=off on arm64, they could reasonably expect those context
> > switch mitigations to be disabled.
> 
> I'm not sure which this is an argument for actually :)
> 
> That is, I do agree that mitigate_user_user makes sense in an
> arch-agnostic way and a user might expect context switch mitigations
> disabled.  However this patch series doesn't implement these attack
> vector controls for anything other than x86.  So I guess I'm not sure
> if your argument is that because they aren't yet implemented for
> arm64, then keeping them x86-specific is better...or if we should make
> them generic to more easily support extension to other architectures.

IMO, make them generic from the start, then there's less churn and it's
easy to port the other arches.

If we went with putting everything in "mitigations=", making them
generic would be the obvious way to go anyway.

> > And then the mitigations= cmdline could simply be processed in order, without side
> > effects, to give the user full flexibility.  To opt-in to specific vectors:
> >
> >   mitigations=off mitigations=user_kernel,host_guest
> 
> I don't like this idea as much as the next, because as noted above, I
> think with most other command lines, a later version replaces an
> earlier one, it doesn't append to it.
>
> That is, something like "spectre_v2=retpoline spectre_v2=ibrs" ends up just meaning ibrs.

Yeah, that makes sense to me.

> > which is equivalent to:
> >
> >   mitigations=off,user_kernel,host_guest
> >
> > Or, if one prefers to opt-out:
> >
> >   mitigations=auto,no_user_user,no_guest_guest
> >
> > where the "auto" is optional for default configs.
> 
> This seems more appealing to me because I think it's clearer what 'on'
> vs 'off' is.  It retains the more compact form of the command line
> while also allowing for opt-in or opt-out style.  And if you specify
> multiple "mitigations=" command lines, the new one replaces the old
> one, like with most other options.
> 
> So I rather like this, and would be interested in what others think too.

+1

> > The priority could be simplified:
> >
> >   1) individual mitigations (=auto means use system-wide default)
> >
> >   2) system-wide defaults (tweaked by mitigations=/mitigate_*=)
> >
> > So the system-wide defaults would be defined by mitigations=whatever, and those
> > can be overriden by the individual mitigations.  That seems a lot more simple and
> > logical.
> >
> > And since you're already introducing "=auto" for the individual mitigations, I think that
> > would be easy enough to implement.
> >
> 
> Yes it wouldn't be very hard, and it does make logical sense.  But I
> think the big caveat is the change to the existing mitigations=off and
> that it would no longer override individual mitigations.  Changing
> that would seem to be a risk, and is that risk worth taking?

Honestly I don't see it as much of a risk.  AFAICT that behavior isn't
documented anywhere.  I'd view it as more of an implementation detail.

And we have to weigh that risk against better maintainability and ease
of use going forward.  These bugs are going to continue to be found
across all the major arches for a long time, let's get the interfaces
right.

-- 
Josh

