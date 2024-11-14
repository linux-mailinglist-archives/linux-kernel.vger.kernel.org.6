Return-Path: <linux-kernel+bounces-409728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863179C9179
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1727FB39D74
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC31188714;
	Thu, 14 Nov 2024 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FLxjt2H1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AE740849
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604464; cv=none; b=KV40AGXS+fnF/aFtj3opt9/AQHr6Nu63XaMVcW1YfYosneXoMQ0n/LEyYWM4ekJN1Ks46sho21eAx0+SfPOiUM4Tunnck5iBi+fKfKMNxZuco2RNRfIiWfvj+R9mAWPBEOVIQNyEgCDCeJfFGoPu1xyGmW5BIYG0tFem6755bG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604464; c=relaxed/simple;
	bh=GfbwiVlG53kf6Ta/MknbcVSyZikUrPkCIpRNxJDMo+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aONG/aEFdthnGzsyoC7Tgj+163+W8Hbn+cFtqU7f/rgFNJc+Y5U+Jb6XHOmx1ozGiXz76QveZJYZzRnJtqao4WmEj0/KTAO2EzLpgJJgXHMzsG9unKQcfxoM8rG526ZIxWhovDG/W0tNhHHLpb8qT2olDAwSGf+PS7qVHogFYrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FLxjt2H1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731604463; x=1763140463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GfbwiVlG53kf6Ta/MknbcVSyZikUrPkCIpRNxJDMo+4=;
  b=FLxjt2H1dK7x6Ud7EM75pwrACcqVy/Xo/N9d3sR21Wd95eiyTCfp1vvr
   lBJlZuX4iliE3ipiehUpZCB7aICNlZ2uvWRhUa7BpCYcmc3iMCz/ElsHD
   3nNX0szbiZOwP1bwF1Iql9YpYkwPwhRo0fETyTa2PlzlZ5Qwbs+KGdflX
   6Eozy/BndZNwh8B5BgvWw2hY4lFco1N/GskovdZ/UemhtflfGjhDYn1W6
   dL+Rx87x+0leIkbuCgD9kWBZ3RV9SJJUCHN64kMDACx3GG2TAv+TvJVJr
   nEviiA+u/5/qf5IBKVsDLEiGXtP9l2Do6oN30svpKbcFq5xd+2jIm762O
   w==;
X-CSE-ConnectionGUID: Upjb5duBQWim/DkuKExMbQ==
X-CSE-MsgGUID: Vy4erQroSzqMxDI19Yl4Zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="42194552"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="42194552"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 09:14:22 -0800
X-CSE-ConnectionGUID: o/vZVvl8RpaljcW+V1YRzg==
X-CSE-MsgGUID: Up38afsiSyelrG3SIxwDdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="88693123"
Received: from eareitsc-mobl.amr.corp.intel.com (HELO desk) ([10.125.149.35])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 09:14:21 -0800
Date: Thu, 14 Nov 2024 09:14:11 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/35] x86/bugs: Add AUTO mitigations for
 mds/taa/mmio/rfds
Message-ID: <20241114171411.om2djgzbmrkxj2ph@desk>
References: <20241105215455.359471-1-david.kaplan@amd.com>
 <20241105215455.359471-4-david.kaplan@amd.com>
 <20241114022654.qr35ebyspjh4zayj@desk>
 <LV3PR12MB92654DE00F67C170DE47B575945B2@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV3PR12MB92654DE00F67C170DE47B575945B2@LV3PR12MB9265.namprd12.prod.outlook.com>

On Thu, Nov 14, 2024 at 02:59:34PM +0000, Kaplan, David wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> > -----Original Message-----
> > From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Sent: Wednesday, November 13, 2024 8:27 PM
> > To: Kaplan, David <David.Kaplan@amd.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>; Borislav Petkov <bp@alien8.de>; Peter
> > Zijlstra <peterz@infradead.org>; Josh Poimboeuf <jpoimboe@kernel.org>; Ingo
> > Molnar <mingo@redhat.com>; Dave Hansen <dave.hansen@linux.intel.com>;
> > x86@kernel.org; H . Peter Anvin <hpa@zytor.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 03/35] x86/bugs: Add AUTO mitigations for
> > mds/taa/mmio/rfds
> >
> > Caution: This message originated from an External Source. Use proper caution
> > when opening attachments, clicking links, or responding.
> >
> >
> > On Tue, Nov 05, 2024 at 03:54:23PM -0600, David Kaplan wrote:
> > > @@ -1995,6 +2004,7 @@ void cpu_bugs_smt_update(void)
> > >               update_mds_branch_idle();
> > >               break;
> > >       case MDS_MITIGATION_OFF:
> > > +     case MDS_MITIGATION_AUTO:
> >
> > This implies AUTO and OFF are similar, which is counter intuitive.
> > While mitigation selection code ...
> >
> > > +     if (mds_mitigation == MDS_MITIGATION_AUTO)
> > > +             mds_mitigation = MDS_MITIGATION_FULL;
> > > +
> >
> > ... indicates that AUTO is equivalent to FULL. So, I think AUTO should be handled
> > the same way as FULL in cpu_bugs_smt_update() as well.
> >
> > Same for TAA and MMIO below.
> >
> 
> The mitigation is never actually AUTO by the time we call
> cpu_bugs_smt_update(), since this happens after cpu_select_mitigations().
> I had to add the case statement here so the switch statement was
> complete, but this case will never be hit.
> 
> Should I put a comment here about that?  Or is a default case the better
> way to handle this?

My suggestion would be to treat AUTO as FULL, and move it up with FULL:

         switch (mds_mitigation) {
         case MDS_MITIGATION_FULL:
+        case MDS_MITIGATION_AUTO:
         case MDS_MITIGATION_VMWERV:
                 if (sched_smt_active() && !boot_cpu_has(X86_BUG_MSBDS_ONLY))
                         pr_warn_once(MDS_MSG_SMT);
                 update_mds_branch_idle();
                 break;
         case MDS_MITIGATION_OFF:
                 break;
         }

