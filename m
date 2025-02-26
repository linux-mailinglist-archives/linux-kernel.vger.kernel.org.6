Return-Path: <linux-kernel+bounces-535060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED16A46E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58A5188A8CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2212B26FA5D;
	Wed, 26 Feb 2025 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hkgn9JwX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853FB26FA4B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740608019; cv=none; b=lGl5FLXobY6tMjCJ1z1dU5ynDptQRWSEBQVby5ldYYNG/rq1a2fyjVWdmuLtCbWOOl+tvBrbwuBFB2vo4RjplahKUk0irnH1HpEHiDhdtsqCy2sgD5ER3bVX78FgaE84C1Y3pngXhjY/YKnY2TWu1QCXRRQgGWa0381Z+IL2mmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740608019; c=relaxed/simple;
	bh=mIyDoJK+vPEhHHCQAXWk7O01IPra6Or14ZIOEHel7hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxtGtwJ2cEW+wGSj9YfTUPvJJ52jNxt8HUR7KpKI9P0FHCf9I4yZMc2raYRnA8DaDvxgu3/oChT7RMgcLim/FbZRvXZ/FJ525iTsxYUC00AlsmieF1YfuVSUxmwyZ9dS+NFfeaW/l/tDyKo199SU4xCEhg0bKHcNVbLXO+DM/RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hkgn9JwX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740608018; x=1772144018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mIyDoJK+vPEhHHCQAXWk7O01IPra6Or14ZIOEHel7hM=;
  b=Hkgn9JwXlG4Jad99Z3+8J4ou0lscavJy3/RJbPgZBlLQdfjktEmQYWBV
   vSTEncZX9a0NCyuouWt1LTrRb4OiZsN8Dpb95VIVdJQs1bBXWFQlklmZ0
   NBA7mozB0jFJclU0liIKcN1LiEy/+WjbDaLFY4FKGayQN/xn5uPByj5c8
   kv9pEbCA6WjSBl0dMFpyjJwqBLgWf5pDyBAmE0lpAcRXKoTPWLiaorv/H
   HQulA6j0cr+A0VC1Y1AUEvbArMwfTFDRxq7rPjed4qIVqzTTBZDYdiZcH
   k5qa+nF8EHnL/ZmI2yC2g7vtAtLqc+90kOM6Bfu+GbcvWpy9xhRqvK0Kh
   w==;
X-CSE-ConnectionGUID: 6xi0wfQvQDWD/p4KXAYcyw==
X-CSE-MsgGUID: x4xV2Fx9RdiU5P6k4ZwJdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45391559"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="45391559"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 14:13:35 -0800
X-CSE-ConnectionGUID: hs6ZizVxQfiJ9+w4Y0ntEQ==
X-CSE-MsgGUID: 4egOe6fBSXKqy1+Tz175Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147757343"
Received: from unknown (HELO desk) ([10.125.145.169])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 14:13:35 -0800
Date: Wed, 26 Feb 2025 14:13:24 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
Message-ID: <20250226221324.hq2nevnnnrpgo75n@desk>
References: <20250217201910.crsu7xucsa4dz3ub@jpoimboe>
 <LV3PR12MB9265249E8D0FD3920C42A1A994FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217233928.k3oem3bm7w63jzfr@jpoimboe>
 <LV3PR12MB9265041C9D8D4F3E5760F0B694FA2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250218070501.7mwcxqgsuxl3meef@jpoimboe>
 <20250218085203.GDZ7RKM6IyPDQAkZ8A@fat_crate.local>
 <20250220220440.ma5yfebhiovkqojt@jpoimboe>
 <LV3PR12MB9265DE3082FA0A7FDF9B587594C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226201453.jgg6kucaathzmcvs@desk>
 <LV3PR12MB9265F875F52317BBCDF953EC94C22@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265F875F52317BBCDF953EC94C22@LV3PR12MB9265.namprd12.prod.outlook.com>

On Wed, Feb 26, 2025 at 09:03:58PM +0000, Kaplan, David wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> > -----Original Message-----
> > From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Sent: Wednesday, February 26, 2025 2:15 PM
> > To: Kaplan, David <David.Kaplan@amd.com>
> > Cc: Josh Poimboeuf <jpoimboe@kernel.org>; Borislav Petkov <bp@alien8.de>;
> > Thomas Gleixner <tglx@linutronix.de>; Peter Zijlstra <peterz@infradead.org>; Ingo
> > Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> > x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Wed, Feb 26, 2025 at 06:57:05PM +0000, Kaplan, David wrote:
> > > [AMD Official Use Only - AMD Internal Distribution Only]
> > >
> > > > -----Original Message-----
> > > > From: Josh Poimboeuf <jpoimboe@kernel.org>
> > > > Sent: Thursday, February 20, 2025 4:05 PM
> > > > To: Borislav Petkov <bp@alien8.de>
> > > > Cc: Kaplan, David <David.Kaplan@amd.com>; Thomas Gleixner
> > > > <tglx@linutronix.de>; Peter Zijlstra <peterz@infradead.org>; Pawan
> > > > Gupta <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar
> > > > <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> > > > x86@kernel.org; H . Peter Anvin <hpa@zytor.com>;
> > > > linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
> > > >
> > > > Caution: This message originated from an External Source. Use proper
> > > > caution when opening attachments, clicking links, or responding.
> > > >
> > > >
> > > > On Tue, Feb 18, 2025 at 09:52:03AM +0100, Borislav Petkov wrote:
> > > > > On Mon, Feb 17, 2025 at 11:05:01PM -0800, Josh Poimboeuf wrote:
> > > > > > IMO, make them generic from the start, then there's less churn
> > > > > > and it's easy to port the other arches.
> > > > > >
> > > > > > If we went with putting everything in "mitigations=", making
> > > > > > them generic would be the obvious way to go anyway.
> > > > >
> > > > > Just to make sure we're all on the same page: we obviously cannot
> > > > > enable and test and support a mitigaion on another arch like, say, arm64, or
> > so.
> > > > >
> > > > > This needs to come from the respective arch maintainers themselves
> > > > > and they'll have to say, yes, pls, enable it and we'll support it.
> > > > > We should not go "oh, this would be a good idea to do on all arches"
> > > > > without hearing from them first, even if it is a good idea on its face.
> > > > >
> > > > > That's why those are x86-only as they should be initially.
> > > >
> > > > I wasn't suggesting that this patch set should *enable* it on all
> > > > arches.  Of course that would need to be reviewed by the respective arch
> > maintainers.
> > > >
> > > > But looking ahead, this *will* be needed for the other arches, for
> > > > the same reason we have a generic mitigations=off.  It's a user problem, not an
> > arch-specific one.
> > > > Users need a simple interface that works everywhere.  That's why I
> > > > suggested integrating it into "mitigations=".
> > > >
> > >
> > > Talked with Boris on the side, he is ok with supporting this in mitigations=, with a
> > warning message if you try to use these controls on yet-unsupported architectures.
> > >
> > > Going back to the command line definition, I think that to help make the selection
> > clearer we could consider the following format:
> > >
> > > mitigations=[on/off],[attack vectors]
> > >
> > > For example:
> > >
> > > "mitigations=on,no_user_kernel" to enable all attack vectors except
> > > user->kernel "mitigations=off,guest_host" to disable all vectors
> > > except guest->host
> >
> > This is a bit ambiguous, mitigations=off,guest_host could be interpreted as disabling
> > guest->host and enabling all others. Using attack vectors with both =on and =off
> > seems unnecessary.
> >
> > Also, we currently don't have mitigations=on option, it's equivalent is =auto.
> >
> > static int __init mitigations_parse_cmdline(char *arg) {
> >         if (!strcmp(arg, "off"))
> >                 cpu_mitigations = CPU_MITIGATIONS_OFF;
> >         else if (!strcmp(arg, "auto"))
> >                 cpu_mitigations = CPU_MITIGATIONS_AUTO;
> >         else if (!strcmp(arg, "auto,nosmt"))
> >                 cpu_mitigations = CPU_MITIGATIONS_AUTO_NOSMT;
> >         else
> >                 pr_crit("Unsupported mitigations=%s, system may still be vulnerable\n",
> >                         arg);
> >
> >         return 0;
> > }
> >
> > Extending =auto to take attack vectors is going to be tricky, because it already
> > takes ",nosmt" which would conflict with ",no_cross_thread".
> >
> > How about we keep =off, and =auto as is, and add:
> >
> >   mitigations=selective,no_user_kernel,no_cross_thread,...
> >
> > Requiring the user to explicitly select attack vectors to disable (rather than to
> > enable). This would be more verbose, but it would be clear that the user is explicitly
> > selecting attack vectors to disable. Also, if a new attack vector gets added in future,
> > it would be mitigated by default, without requiring the world to change their cmdline.
> 
> I kind of like that.
> 
> Note that for the SMT stuff, my new plan had been to use a separate
> option 'mitigate_smt' which will be on/off/auto.

I would avoid that, because we can't drop support for
"mitigations=auto,nosmt" and we also have a separate cmdline parameter
"nosmt":

	nosmt		[KNL,MIPS,PPC,S390,EARLY] Disable symmetric multithreading (SMT).
			Equivalent to smt=1.

			[KNL,X86,PPC] Disable symmetric multithreading (SMT).
			nosmt=force: Force disable SMT, cannot be undone
				     via the sysfs control file.

> But we could also combine that with mitigations=selective perhaps with
> tokens like 'mitigate_smt' (enable all relevant SMT mitigations including
> disabling SMT if needed) or 'no_mitigate_smt' (do not enable any SMT
> mitigation).  If no token is specified, then we'd default to the behavior
> today where SMT won't be disabled but other mitigations get applied.
> Then everything is in one option.

Agree.

> If we like that, then a related question then, do we agree that
> 'mitigations=off' should be equivalent to
> 'mitigations=selective,no_user_kernel,no_user_user,no_guest_host,no_guest_guest,no_mitigate_smt'?
> 
> If so, and we're ok with individual bug cmdlines overriding this, then I
> think we can get rid of cpu_mitigations_off() and just rely on the attack
> vectors as Josh was suggesting.

Does that mean to stop supporting "mitigations=off"?

