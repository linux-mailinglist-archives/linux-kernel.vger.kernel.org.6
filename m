Return-Path: <linux-kernel+bounces-535157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E7AA46FA1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DFB18889F2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF9927002C;
	Wed, 26 Feb 2025 23:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQZcgyGn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3533270021
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613482; cv=none; b=SKumEF2trcHxPRWyOhesbazDZJN4ucPeCdthKBZ8N8AAmSHxiTzwNhQ6seMlJi3yZZyxEYMGshXLBC5zp0Rf5kMgzGagd4gGOopHl/7cUuX3b622nM6Lcmpj3oJ6Wzr8BCEbgxM1eJQJT555GLRbsRkE3m+bOQrVTzJ7HiebI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613482; c=relaxed/simple;
	bh=OYOX2uiCvkUWkRn0XXSTHXXyZoWRB9OUt3GwfbVNKHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAwGHg0B38sZPdAO9BeFCjolO0GORjvgqyhC4pbzaHXv2cbIm0kDofXREzVchD88P6uS+i2j16VN2hDhB9hYmoBAyoOQXLLKIPHoH5OSTZ3i9SpdQt7xEqFCJXRl/6HdSwwSdrwd5Sm53xAUtGTV14hFGM0wLI2avZ6+blWEF1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQZcgyGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E840BC4CED6;
	Wed, 26 Feb 2025 23:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740613482;
	bh=OYOX2uiCvkUWkRn0XXSTHXXyZoWRB9OUt3GwfbVNKHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BQZcgyGnxvtMcqIGzvimFzamruEPabqKmvW56JvlAmQKuHAwUach5wgNBEiPaH7+M
	 Kw4Yk9isUcpYqvY8P+Ii74OQatkvu4waCqtTcxPLMsls4hlV+VZxcWbPX34eqPqo8X
	 9WFb4HsJaz1Eq2pPHHLDYx33xwOce3pubtCtbIQZb3r6uv4pJGdxBeO7tfw+7N1ZXd
	 FJ8cj+mVATtnw6ytrBu4g0JovfCEA7ZpL7mJWV3NNZxh/CNS6YHHX8dDovRI9vgYnQ
	 dyZvw3nQiZ6KoT3BGBootz+v4W2giM1cvqHzZBdGDHlc36RvUJS1lNJZ78+6+joSsz
	 b8+y5An7Z2ufQ==
Date: Wed, 26 Feb 2025 15:44:40 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: "Kaplan, David" <David.Kaplan@amd.com>, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
Message-ID: <20250226234440.4dk4t3urkzt4zll7@jpoimboe>
References: <LV3PR12MB9265249E8D0FD3920C42A1A994FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217233928.k3oem3bm7w63jzfr@jpoimboe>
 <LV3PR12MB9265041C9D8D4F3E5760F0B694FA2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250218070501.7mwcxqgsuxl3meef@jpoimboe>
 <20250218085203.GDZ7RKM6IyPDQAkZ8A@fat_crate.local>
 <20250220220440.ma5yfebhiovkqojt@jpoimboe>
 <LV3PR12MB9265DE3082FA0A7FDF9B587594C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226201453.jgg6kucaathzmcvs@desk>
 <LV3PR12MB9265F875F52317BBCDF953EC94C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226221324.hq2nevnnnrpgo75n@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226221324.hq2nevnnnrpgo75n@desk>

On Wed, Feb 26, 2025 at 02:13:24PM -0800, Pawan Gupta wrote:
> On Wed, Feb 26, 2025 at 09:03:58PM +0000, Kaplan, David wrote:
> > > Extending =auto to take attack vectors is going to be tricky, because it already
> > > takes ",nosmt" which would conflict with ",no_cross_thread".
> > >
> > > How about we keep =off, and =auto as is, and add:
> > >
> > >   mitigations=selective,no_user_kernel,no_cross_thread,...
> > >
> > > Requiring the user to explicitly select attack vectors to disable (rather than to
> > > enable). This would be more verbose, but it would be clear that the user is explicitly
> > > selecting attack vectors to disable. Also, if a new attack vector gets added in future,
> > > it would be mitigated by default, without requiring the world to change their cmdline.
> > 
> > I kind of like that.

While it might be true that we don't necessarily need both opt-in and
opt-out options...

I'm missing the point of the "selective" thing vs just
"auto,no_whatever"?

> > Note that for the SMT stuff, my new plan had been to use a separate
> > option 'mitigate_smt' which will be on/off/auto.
>
> I would avoid that, because we can't drop support for
> "mitigations=auto,nosmt"

We wouldn't have to drop support for that...  If there's a conflict
between the two options then just print a warning and pick one.

> and we also have a separate cmdline parameter
> "nosmt":
> 
> 	nosmt		[KNL,MIPS,PPC,S390,EARLY] Disable symmetric multithreading (SMT).
> 			Equivalent to smt=1.
> 
> 			[KNL,X86,PPC] Disable symmetric multithreading (SMT).
> 			nosmt=force: Force disable SMT, cannot be undone
> 				     via the sysfs control file.

The separate 'nosmt' option is orthogonal to the mitigation stuff.  If
it disables SMT then there are no cross-thread mitigations to do in the
first place.

> > But we could also combine that with mitigations=selective perhaps with
> > tokens like 'mitigate_smt' (enable all relevant SMT mitigations including
> > disabling SMT if needed) or 'no_mitigate_smt' (do not enable any SMT
> > mitigation).  If no token is specified, then we'd default to the behavior
> > today where SMT won't be disabled but other mitigations get applied.
> > Then everything is in one option.
> 
> Agree.

I think that's *way* too subtle.  It's completely unlike the other
options in that it's not a binary opt-out.  And it sneakily obfuscates
the mitigate_smt tristate (with the third state being the unspecified
default).

However, one of those three states is already represented by
'auto,nosmt'.  Why not just piggyback on that by allowing the vectors to
be combined with it?  Then we only need two more states, which could be
represented with e.g., "[no_]cross_thread".

For example, to disable SMT (if needed), along with disabling of
vectors:
  
  mitigations=auto,nosmt,no_user_kernel,etc

Or to disable all SMT mitigations (e.g., because the user is doing core
scheduling):

  mitigations=auto,no_cross_thread,etc

And combining 'auto,nosmt' with 'no_cross_thread' is nonsensical, in
which case so it could just pick the former and print a warning.

-- 
Josh

