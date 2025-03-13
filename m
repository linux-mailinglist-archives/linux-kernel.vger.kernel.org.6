Return-Path: <linux-kernel+bounces-560260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0AFA60123
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E31217EDD4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69481F1932;
	Thu, 13 Mar 2025 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSbFWKsW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67891F37C3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741893977; cv=none; b=gQpBnI+N7S+cVRSCHA7e8le0RVPF/Zxbjt2nkjyevCmGCLlmFyto2HQcjOGzWMf72Vpq3yvlGg/4TiTytYPllzWYiCCQot+Fk1tbMIM5xxC484/bOYc8tg8Ygw63Jnah5cRjNT2Xy5rX5nhSSSRoHZLP4tf6HuJy4R7so8okiEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741893977; c=relaxed/simple;
	bh=STE3EP1T2rA3Vl8u/qi1S6RDvOni8tomKBFZSMRjP4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNLRffOB2FaVakr9JyNUkJ5rSjUVdlLjQLqJzTCpEVEEFDnDZSpwzG15Lpkras36Dc1b6lIyXzI2mnEP8ZqOGOfstC0OATy6LNrFsb0YlCWoY3XYHRXrBh42R7gW4uP6bCnxS9wO4pvXtBByA/zKIA7CnQr+ABF0PlBHTUA1cT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSbFWKsW; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741893975; x=1773429975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=STE3EP1T2rA3Vl8u/qi1S6RDvOni8tomKBFZSMRjP4w=;
  b=jSbFWKsWzvwqBQNYZiWlY9LHwwPWwMD21AU0cv/YKKU1Gi/lsVCt7hPa
   u1EAax7qMM8OECAii1nDTPiAynNNckq9SrZf0uxjJ5I3dGriyTY+sHQCh
   1gsm6sFYj9w/7wKFOXLtC0i5iO3r21mAHPJOkEREgBpsjXst/O01zzZw5
   xeMpObnZjQ01v+0YRLMQx7fkWUpbxeIY5Jbsgw99YukoILOOdhd+t8ruI
   oBKWXRLiDq0I+jGiLFxYJA7E0AMOa7VW2bzuAqlpMUOrmYopM8R7BVJ67
   UqzjvD7DVXmM947tlFZ8LpiQFeU/tzSYuZK4TQoYuvTpU3soxQLwO3Gyd
   g==;
X-CSE-ConnectionGUID: afJg6xJ3T2+ITCtkhujSZg==
X-CSE-MsgGUID: 5yeOt/7EQvy6tki76bRSSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43135136"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="43135136"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 12:26:15 -0700
X-CSE-ConnectionGUID: SIEaDluVRDSqy2NLYjRDlQ==
X-CSE-MsgGUID: B4vUpEeYQZOF0L1kSk4CdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="158200422"
Received: from trinityj-mobl2.amr.corp.intel.com (HELO desk) ([10.125.145.187])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 12:26:14 -0700
Date: Thu, 13 Mar 2025 12:26:06 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: David Kaplan <david.kaplan@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Brendan Jackman <jackmanb@google.com>,
	Derek Manwaring <derekmn@amazon.com>
Subject: Re: [PATCH v4 03/36] x86/bugs: Restructure mmio mitigation
Message-ID: <20250313192606.iijythngqtpx4tyy@desk>
References: <20250310164023.779191-1-david.kaplan@amd.com>
 <20250310164023.779191-4-david.kaplan@amd.com>
 <20250313093617.GHZ9KnEXpdM4dwLYFz@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313093617.GHZ9KnEXpdM4dwLYFz@fat_crate.local>

On Thu, Mar 13, 2025 at 10:36:17AM +0100, Borislav Petkov wrote:
> I'd expect to see:
> 
> 	if (mmio_mitigation == MMIO_MITIGATION_AUTO) {
>                 mmio_mitigation = MMIO_MITIGATION_VERW;
> 		verw_mitigation_selected = true;
> 	}
> 
>         if (boot_cpu_has_bug(X86_BUG_MDS) || taa_vulnerable())
>                 verw_mitigation_selected = true;
> 
> because the above branch already selected MMIO_MITIGATION_VERW so we might as
> well set verw_mitigation_selected, right?

There is a subtle difference between setting verw_mitigation_selected and
MMIO_MITIGATION_VERW. The former is a system-wide switch that indicates
VERW is needed at both kernel-exit and VMenter. MMIO Stale Data is
different from other VERW based mitigations because it only requires VERW
at VMenter, when not affected by MDS/TAA. So, turning the system-wide knob
here would be wrong.

> > +static void __init mmio_update_mitigation(void)
> > +{
> > +	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) || cpu_mitigations_off())
> > +		return;
> > +
> > +	if (verw_mitigation_selected)
> > +		mmio_mitigation = MMIO_MITIGATION_VERW;
[...]
> > +	if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
> 
> Btw, that UNKNOWN thing is just silly. Looking at git history:
> 
> 7df548840c49 ("x86/bugs: Add "unknown" reporting for MMIO Stale Data")
> 
> this was added just so that it doesn't say "Not affected" about those CPUs but
> "unknown."
> 
> But
> 
>   "Mitigation is not deployed when the status is unknown."
> 
> so if it is only about reporting, I think we can synthesize the logic of this:
> 
>         if (!arch_cap_mmio_immune(x86_arch_cap_msr)) {
>                 if (cpu_matches(cpu_vuln_blacklist, MMIO))
>                         setup_force_cpu_bug(X86_BUG_MMIO_STALE_DATA);
>                 else if (!cpu_matches(cpu_vuln_whitelist, NO_MMIO))
>                         setup_force_cpu_bug(X86_BUG_MMIO_UNKNOWN);
>         }
> 
> into a separate function and get rid of that X86_BUG_MMIO_UNKNOWN thing.

Hmm, that would not be straightforward, specially for sysfs status. The
above logic requires parsing the cpu_vuln_whitelist which is not available
after init. Moreover, sysfs reads would become slower if it has to read an
MSR and parse tables.

Also, cpu_show_common() by default shows "Not affected" in the absence of
bug bit. So setting X86_BUG_MMIO_UNKNOWN is simpler overall.

cpu_show_common(bug)
{
	if (!boot_cpu_has_bug(bug))
		return sysfs_emit(buf, "Not affected\n");

