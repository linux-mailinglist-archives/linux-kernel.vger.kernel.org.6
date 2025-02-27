Return-Path: <linux-kernel+bounces-535225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D13A4704E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2A816E033
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A367112E5B;
	Thu, 27 Feb 2025 00:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqP+v7J+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329EAC8EB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616538; cv=none; b=GXsjY4ZqRT/Ovmvz9jY3rJGTFSmSFS/YC+dZo2+nvD4r2WKV69UcraUQJCtiHU6gtva0V4n0wJoW2rFJvZykBcmtKbWhGLdBJRHC2jTB47YUB75rUkkLXEraxGU4HP9sUpJwFk+hxXRuwfzWGk/fO2hWHgBXeT+nKaKCO0CY9kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616538; c=relaxed/simple;
	bh=3AJ9d5rV3h390IdH4wOO16rKMYbgUmA06NdBKs+n/k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJmkgo8lQB7FMiy6x8oUVwSIukmE4NuyiOeYxU9jLf6rFwyr2/Wtz+Iu2SDwCAtr+Y0cSI2E8+bbjpg1W+r+wMutt7YPYrU+hPa/m6Nqx+p30l+KRKCJl4FqVXUeqdbcvevPViZS5AoL+LdH+OClfHTwPjUrhBHu8L7NMM+zfJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bqP+v7J+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740616536; x=1772152536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3AJ9d5rV3h390IdH4wOO16rKMYbgUmA06NdBKs+n/k0=;
  b=bqP+v7J+a4dPUeoGoxWWcmqZ8rzB4DVvNq/1qDax0sKHPCqPXC9nAEmQ
   XrOW6rI0rf0tAwX0DfjHB2VmzY1goPMjkZbzDtwNq6916JB8O3NlbQd6T
   boVVKFPI+2Y2duQVKz23L30ceO86zk7oC2POAMpowsefnsWnKrgZTHmCn
   9YOHscznhYAyh6Y5osBxwv/1Quq33Ia2d0UzjqXHi82JySO/f37q10DWf
   mcWiiaSbC/DLOFNQi95NEqAZkVil0jr/cg5X4Z8KuQkFnqR5KFG+oXWge
   MESRSrMsDY7dzyqzkyoGpX5PSZgJSSZNz5Xj0qdkAelb0jBHC8AR2Cw+O
   Q==;
X-CSE-ConnectionGUID: d1ehmkKARGSn5p0UEmgLiw==
X-CSE-MsgGUID: 98DlFOiaSWiTOLZEu3TBWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52127108"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="52127108"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 16:35:35 -0800
X-CSE-ConnectionGUID: Oa/EQP7aTFahHnpuYImnrQ==
X-CSE-MsgGUID: K8+uyhU4SUKCyMb8Q12T8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="121459600"
Received: from unknown (HELO desk) ([10.125.145.169])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 16:35:34 -0800
Date: Wed, 26 Feb 2025 16:35:28 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: "Kaplan, David" <David.Kaplan@amd.com>, Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
Message-ID: <20250227003528.hnviwrtzs7jc3juj@desk>
References: <20250217233928.k3oem3bm7w63jzfr@jpoimboe>
 <LV3PR12MB9265041C9D8D4F3E5760F0B694FA2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250218070501.7mwcxqgsuxl3meef@jpoimboe>
 <20250218085203.GDZ7RKM6IyPDQAkZ8A@fat_crate.local>
 <20250220220440.ma5yfebhiovkqojt@jpoimboe>
 <LV3PR12MB9265DE3082FA0A7FDF9B587594C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226201453.jgg6kucaathzmcvs@desk>
 <LV3PR12MB9265F875F52317BBCDF953EC94C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226221324.hq2nevnnnrpgo75n@desk>
 <20250226234440.4dk4t3urkzt4zll7@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226234440.4dk4t3urkzt4zll7@jpoimboe>

On Wed, Feb 26, 2025 at 03:44:40PM -0800, Josh Poimboeuf wrote:
> On Wed, Feb 26, 2025 at 02:13:24PM -0800, Pawan Gupta wrote:
> > On Wed, Feb 26, 2025 at 09:03:58PM +0000, Kaplan, David wrote:
> > > > Extending =auto to take attack vectors is going to be tricky, because it already
> > > > takes ",nosmt" which would conflict with ",no_cross_thread".
> > > >
> > > > How about we keep =off, and =auto as is, and add:
> > > >
> > > >   mitigations=selective,no_user_kernel,no_cross_thread,...
> > > >
> > > > Requiring the user to explicitly select attack vectors to disable (rather than to
> > > > enable). This would be more verbose, but it would be clear that the user is explicitly
> > > > selecting attack vectors to disable. Also, if a new attack vector gets added in future,
> > > > it would be mitigated by default, without requiring the world to change their cmdline.
> > > 
> > > I kind of like that.
> 
> While it might be true that we don't necessarily need both opt-in and
> opt-out options...
> 
> I'm missing the point of the "selective" thing vs just
> "auto,no_whatever"?

That was my first thought, but then I realized that in "auto,nosmt" nosmt
is the opposite of disabling the mitigation. It would be cleaner to have
"=selective,no_whatever" which is self-explanatory.

> > > Note that for the SMT stuff, my new plan had been to use a separate
> > > option 'mitigate_smt' which will be on/off/auto.
> >
> > I would avoid that, because we can't drop support for
> > "mitigations=auto,nosmt"
> 
> We wouldn't have to drop support for that...  If there's a conflict
> between the two options then just print a warning and pick one.

Introducing one more option for smt seems unnecessary. We already have
auto,nosmt and nosmt. Trying to guess which one takes precedence would
be confusing.

> > and we also have a separate cmdline parameter
> > "nosmt":
> > 
> > 	nosmt		[KNL,MIPS,PPC,S390,EARLY] Disable symmetric multithreading (SMT).
> > 			Equivalent to smt=1.
> > 
> > 			[KNL,X86,PPC] Disable symmetric multithreading (SMT).
> > 			nosmt=force: Force disable SMT, cannot be undone
> > 				     via the sysfs control file.
> 
> The separate 'nosmt' option is orthogonal to the mitigation stuff.  If
> it disables SMT then there are no cross-thread mitigations to do in the
> first place.

Right.

> > > But we could also combine that with mitigations=selective perhaps with
> > > tokens like 'mitigate_smt' (enable all relevant SMT mitigations including
> > > disabling SMT if needed) or 'no_mitigate_smt' (do not enable any SMT
> > > mitigation).  If no token is specified, then we'd default to the behavior
> > > today where SMT won't be disabled but other mitigations get applied.
> > > Then everything is in one option.
> > 
> > Agree.
> 
> I think that's *way* too subtle.  It's completely unlike the other
> options in that it's not a binary opt-out.  And it sneakily obfuscates
> the mitigate_smt tristate (with the third state being the unspecified
> default).
> 
> However, one of those three states is already represented by
> 'auto,nosmt'.  Why not just piggyback on that by allowing the vectors to
> be combined with it?  Then we only need two more states, which could be
> represented with e.g., "[no_]cross_thread".
> 
> For example, to disable SMT (if needed), along with disabling of
> vectors:
>   
>   mitigations=auto,nosmt,no_user_kernel,etc
> 
> Or to disable all SMT mitigations (e.g., because the user is doing core
> scheduling):
> 
>   mitigations=auto,no_cross_thread,etc
> 
> And combining 'auto,nosmt' with 'no_cross_thread' is nonsensical, in
> which case so it could just pick the former and print a warning.

That seems reasonable. The only thing is now we are mixing enabling and
disabling mitigations in the attack vector list. And that probably is
better than having a separate parameter.

