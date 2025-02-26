Return-Path: <linux-kernel+bounces-534873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF5AA46C21
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40FB16D999
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953C3275617;
	Wed, 26 Feb 2025 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2D/zDEX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F98C2755E0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600902; cv=none; b=TbVCUByGg3vXwatuabQEyzXFDlHeOwINtdLqRGN3lnVdk3QODjyqFb3WD0QXU4JkDl7jiJqzIVjTuQGDddhmgG9RZyHxmsr6Ju1x5NyHpjYixr8sTT0CCZDg09ibuHTYeroF1iJShbevi2Aq2AJE49Ejq8aPwJ5xCKml5DXSsno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600902; c=relaxed/simple;
	bh=FMU1UcccTfNtBPIrz9Z0ZcZjiDjQMeBRhzovNeMI+IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqlHS1JWnJAmvds0E0h8jF1zsu27uJLDJCFQBTJDLBxFTmCTp1DX4Sr38d+OEAIo6cqX0a1vRxfQQLZLKvClXY11ryE53Zi0kxG80P369zDRC0LGId4TgRUzEguaAxYa0kIgYs5sIRgQt/VX1iLu4t6PbLnemqvuSw1ZLlXni1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2D/zDEX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740600901; x=1772136901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FMU1UcccTfNtBPIrz9Z0ZcZjiDjQMeBRhzovNeMI+IU=;
  b=U2D/zDEXfwTCGGxFA7sMivIeTvEJZN6HpPUifR48wl3cdxoUP+MyUXWi
   HBZUgc9ciT0uD5kDQtYZk/9Gkg3LfjdOY3Rauvdur/IY52eSZe2Smo3JP
   6nsjD8j5dP6SGrBthmFipkIZePnPKDvpSMYH/+TS8XbFBIFgkNvddJwlK
   bAU+Z/piFPrdFz2FR12Rixaj3eqtiacmDDtIZDrYB7gPOJQZB/Y+QlDn2
   4gpY91rfJNb+PrIbBkbMurQchMo5TSJcmJxw+nxDU4zdGO2SgT879ucBU
   58vjHXeEer/vcUHdPAJC6869uz4fuLR7V0ZtYkqiGlLkj7Y9gReEdA9Zn
   g==;
X-CSE-ConnectionGUID: pfdAXGC+SwesjyrXLPNP2g==
X-CSE-MsgGUID: cdn1nWECR2WxFgsptYGIAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="40645230"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="40645230"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 12:15:00 -0800
X-CSE-ConnectionGUID: 6VTgbGWnSAatsba1vM38rw==
X-CSE-MsgGUID: GNNKMJUeRWW1r2Q08bGslA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="116841118"
Received: from unknown (HELO desk) ([10.125.145.169])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 12:15:00 -0800
Date: Wed, 26 Feb 2025 12:14:53 -0800
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
Message-ID: <20250226201453.jgg6kucaathzmcvs@desk>
References: <LV3PR12MB9265804700AB74A446F5220F94FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <LV3PR12MB926524EFB64F6FB361046C5E94FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217201910.crsu7xucsa4dz3ub@jpoimboe>
 <LV3PR12MB9265249E8D0FD3920C42A1A994FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217233928.k3oem3bm7w63jzfr@jpoimboe>
 <LV3PR12MB9265041C9D8D4F3E5760F0B694FA2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250218070501.7mwcxqgsuxl3meef@jpoimboe>
 <20250218085203.GDZ7RKM6IyPDQAkZ8A@fat_crate.local>
 <20250220220440.ma5yfebhiovkqojt@jpoimboe>
 <LV3PR12MB9265DE3082FA0A7FDF9B587594C22@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265DE3082FA0A7FDF9B587594C22@LV3PR12MB9265.namprd12.prod.outlook.com>

On Wed, Feb 26, 2025 at 06:57:05PM +0000, Kaplan, David wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> > -----Original Message-----
> > From: Josh Poimboeuf <jpoimboe@kernel.org>
> > Sent: Thursday, February 20, 2025 4:05 PM
> > To: Borislav Petkov <bp@alien8.de>
> > Cc: Kaplan, David <David.Kaplan@amd.com>; Thomas Gleixner
> > <tglx@linutronix.de>; Peter Zijlstra <peterz@infradead.org>; Pawan Gupta
> > <pawan.kumar.gupta@linux.intel.com>; Ingo Molnar <mingo@redhat.com>; Dave
> > Hansen <dave.hansen@linux.intel.com>; x86@kernel.org; H . Peter Anvin
> > <hpa@zytor.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Tue, Feb 18, 2025 at 09:52:03AM +0100, Borislav Petkov wrote:
> > > On Mon, Feb 17, 2025 at 11:05:01PM -0800, Josh Poimboeuf wrote:
> > > > IMO, make them generic from the start, then there's less churn and
> > > > it's easy to port the other arches.
> > > >
> > > > If we went with putting everything in "mitigations=", making them
> > > > generic would be the obvious way to go anyway.
> > >
> > > Just to make sure we're all on the same page: we obviously cannot
> > > enable and test and support a mitigaion on another arch like, say, arm64, or so.
> > >
> > > This needs to come from the respective arch maintainers themselves and
> > > they'll have to say, yes, pls, enable it and we'll support it. We
> > > should not go "oh, this would be a good idea to do on all arches"
> > > without hearing from them first, even if it is a good idea on its face.
> > >
> > > That's why those are x86-only as they should be initially.
> >
> > I wasn't suggesting that this patch set should *enable* it on all arches.  Of course
> > that would need to be reviewed by the respective arch maintainers.
> >
> > But looking ahead, this *will* be needed for the other arches, for the same reason
> > we have a generic mitigations=off.  It's a user problem, not an arch-specific one.
> > Users need a simple interface that works everywhere.  That's why I suggested
> > integrating it into "mitigations=".
> >
> 
> Talked with Boris on the side, he is ok with supporting this in mitigations=, with a warning message if you try to use these controls on yet-unsupported architectures.
> 
> Going back to the command line definition, I think that to help make the selection clearer we could consider the following format:
> 
> mitigations=[on/off],[attack vectors]
> 
> For example:
> 
> "mitigations=on,no_user_kernel" to enable all attack vectors except user->kernel
> "mitigations=off,guest_host" to disable all vectors except guest->host

This is a bit ambiguous, mitigations=off,guest_host could be interpreted as
disabling guest->host and enabling all others. Using attack vectors with
both =on and =off seems unnecessary.

Also, we currently don't have mitigations=on option, it's equivalent is =auto.

static int __init mitigations_parse_cmdline(char *arg)
{
        if (!strcmp(arg, "off"))
                cpu_mitigations = CPU_MITIGATIONS_OFF;
        else if (!strcmp(arg, "auto"))
                cpu_mitigations = CPU_MITIGATIONS_AUTO;
        else if (!strcmp(arg, "auto,nosmt"))
                cpu_mitigations = CPU_MITIGATIONS_AUTO_NOSMT;
        else
                pr_crit("Unsupported mitigations=%s, system may still be vulnerable\n",
                        arg);

        return 0;
}

Extending =auto to take attack vectors is going to be tricky, because it
already takes ",nosmt" which would conflict with ",no_cross_thread".

How about we keep =off, and =auto as is, and add:

  mitigations=selective,no_user_kernel,no_cross_thread,...

Requiring the user to explicitly select attack vectors to disable (rather
than to enable). This would be more verbose, but it would be clear that the
user is explicitly selecting attack vectors to disable. Also, if a new
attack vector gets added in future, it would be mitigated by default,
without requiring the world to change their cmdline.

