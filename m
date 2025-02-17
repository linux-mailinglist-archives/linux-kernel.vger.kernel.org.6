Return-Path: <linux-kernel+bounces-518474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AD8A38FB0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 00:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE4EE7A257C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 23:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BB71ACECB;
	Mon, 17 Feb 2025 23:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOSrAO+5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCE71A8404
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 23:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739835571; cv=none; b=NjDPwiBmASxZik3z/JmRIEx8sIDwl+D7/8QaznWwEC+oeWX11IDtnKIoqBOUnsek9XJ0y3D0V57pvJS155FYyYlUjITPvwiC4Cxw4TgOnDRvcsFOo8nHIlMdzIIiWKuW3jITYE0X+drrgFadFenr41iRsQJFSr6DK9Hiyl5Ga3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739835571; c=relaxed/simple;
	bh=PRI0HMOLIiDUbWV9Hm727cn06w1P0us9O2inE2GPtJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrolIRKu2bpxdsFedoByf0tLLGJzo8xZtpwlatW8s0DsKKZW3DfECuQivMuc1z5aXBorZGXbsWLzae6wbrgM4QIkkAMHZF4EZsk0CTEMciXdmVs93oPMYKALNVCGaK9m3r2QkBO8nhdGmOba0LJhvAFDDITbRMY0chnc/ldfbfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOSrAO+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4DAC4CED1;
	Mon, 17 Feb 2025 23:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739835570;
	bh=PRI0HMOLIiDUbWV9Hm727cn06w1P0us9O2inE2GPtJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOSrAO+5V+76AYOqoWasRkQu8utaCjrNH8GX6wu5i75THR3WsnkUmlYDPxxtijKWm
	 /660IYvwsLE/Gherofyjfnfylsf55XJnElfrQClUm1SJqFUljQBkLUdMIeEX11vMEo
	 +4Myb1snjdrHRJEd72E781DAs9JgXzw37driWCDGm/0vTBiyiDeSc3njKtfYAysvvB
	 28ZpE5MHK4Y1YpDB5kemXhrXsEI7yz+T6HXxrhFgn6pHGla/K2/8M3sTqrX7OXaAF5
	 bHJRUsr6/h9aLUmIsK9ENjjvUF9NwYJQIs2rojR+Db2s4bgt4HTTB9wOcEthL8JGCL
	 rUwvElGSNFLeg==
Date: Mon, 17 Feb 2025 15:39:28 -0800
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
Message-ID: <20250217233928.k3oem3bm7w63jzfr@jpoimboe>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-21-david.kaplan@amd.com>
 <20250211180752.pfsjvz62bztpnmoi@jpoimboe>
 <LV3PR12MB9265804700AB74A446F5220F94FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <LV3PR12MB926524EFB64F6FB361046C5E94FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217201910.crsu7xucsa4dz3ub@jpoimboe>
 <LV3PR12MB9265249E8D0FD3920C42A1A994FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265249E8D0FD3920C42A1A994FB2@LV3PR12MB9265.namprd12.prod.outlook.com>

On Mon, Feb 17, 2025 at 08:38:07PM +0000, Kaplan, David wrote:
> > However... should these not actually be arch-generic options, like mitigations=
> > already is?  It would make for a more consistent user interface across arches.
> 
> That's what I had in my patch series up until this one.  Boris said to
> move them to x86-specific code because nobody else is using them yet
> and somebody down the road could move them.

Ah, I guess I missed the previous versions.  Sorry :-/

> I do agree that they can be arch-generic (hence why I originally put
> them in kernel/cpu.c) but I also don't know when (if ever) anyone from
> other archs will want to pick them up.

Well, for example, we already have the generic
prctl(PR_SET_SPECULATION_CTRL) which is used by arm64.  If somebody
boots with mitigate_user_user=off on arm64, they could reasonably expect
those context switch mitigations to be disabled.

> > They could even be integrated into the "mitigations=" interface.  The options could
> > be combined in any order (separated by commas):
> >
> >   mitigations=user_kernel,user_user
> >   mitigations=guest_host,user_kernel
> >   ...etc...
> >
> > And e.g., "mitigations=off" would simply disable all the vectors.
> 
> Hmm, that's an interesting idea.  I assume that any vectors not listed
> would be considered 'off', unless no mitigations= was specified, or
> mitigations=auto was specified in which case they'd default to 'on'
> like they do today.
>
> In other words:
> mitigations=auto
>   => all 4 vectors are 'on'
> mitigations=user_kernel
>   => user_kernel is 'on', all others are 'off'
>
> That would also imply that:
> mitigations=user_kernel mitigations=user_user
> 
> Would actually mean that user_user is 'on' and everything is 'off'.
> Not sure if that's an issue or would be sufficiently obvious.

Hm, so I was actually thinking that multiple "mitigations=" options
would combine.  I guess either way is confusing.  The problem is that
they have side effects.  Another idea below.

> Then a question is how to integrate the mitigate_smt option we were
> just discussing since that needs a 3-way select.  Or perhaps keep that
> one as a separate command line option.

Yeah, the smt tri-state would need some kind of interface as well.

> > That would remove ambiguity created by combining mitigations= with
> > mitigate_* and would make it easier for all the current
> > cpu_mitigations_off() callers: only one global enable/disable interface to call instead
> > of two.  Any code calling cpu_mitigations_off() should probably be calling something
> > like cpu_mitigate_attack_vector() instead.
> >
> > cpu_mitigations_off() and cpu_mitigations_auto_nosmt() could be deprecated in
> > favor of more vector-specific interfaces, and could be removed once all the arches
> > stop using them.  They could be gated by a temporary
> > ARCH_USES_MITIGATION_VECTORS option.  As could the per-vector cmdline
> > options.
> >
> > Thoughts?
> >
> 
> I'm not sure there is really that much ambiguity...the global
> mitigations=off is the big button that disables everything.

Well sure, but that's because you already know it's the big button ;-)
If you don't know that, it's nonobvious.

Joe Admin might assume the cmdline options are processed in order, e.g:

  mitigations=off mitigate_user_kernel=on

in which case they might reasonably expect to have only user->kernel
mitigations enabled.  Otherwise there would be no point in combining
them in the first place.

How about negative and positive versions of each:

  mitigations=[no_]user_kernel
  migitations=[no_]user_user

etc.

And then the mitigations= cmdline could simply be processed in order,
without side effects, to give the user full flexibility.  To opt-in to
specific vectors:

  mitigations=off mitigations=user_kernel,host_guest

which is equivalent to:

  mitigations=off,user_kernel,host_guest

Or, if one prefers to opt-out:

  mitigations=auto,no_user_user,no_guest_guest

where the "auto" is optional for default configs.

> I think the other issue here may be that the attack vectors are
> defined to be rather low-priority in terms of selection.  That is, you
> can disable all the attack vectors but then still enable an individual
> bug fix.
> 
> In other words, if you were to replace cpu_mitigations_off() with a
> function looking for all attack vectors to be off, that isn't quite
> correct because of the priority difference.

Hm.  So IIUC, the priority (in descending order) is:

  1) mitigations=

  2) individual mitigations, e.g. spectre_v2=

  3) mitigate_*=

  4) defaults

That seems overly complex and nonobvious, where most of the complexity
comes from handling rarely (or never?) used edge cases.

Does the current "big button" behavior for mitigations=off even make
sense?  Why would somebody do "mitigations=off spectre_v2=eibrs" and
expect the spectre_v2 mitigation to be *disabled*?  Do we really think
anybody relies on that and gets the result they were expecting?

The priority could be simplified:

  1) individual mitigations (=auto means use system-wide default)

  2) system-wide defaults (tweaked by mitigations=/mitigate_*=)

So the system-wide defaults would be defined by mitigations=whatever,
and those can be overriden by the individual mitigations.  That seems a
lot more simple and logical.

And since you're already introducing "=auto" for the individual
mitigations, I think that would be easy enough to implement.

-- 
Josh

