Return-Path: <linux-kernel+bounces-512044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1B9A3333B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2D2188AA20
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C888C202F7E;
	Wed, 12 Feb 2025 23:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQBkY+C6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AC01DEFDD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739402209; cv=none; b=U9SG2WrEEMXaBv/s2AxGhe8JPLDrnSz2stx2MkGwYK7R9/vxZ7l6+a+EIC2lSvVdv2NDgCtRVxyrd28LE9WoUkUCY/n4Gnc7zN4L7x0GK7LISe4Uz6G+l6h0mdL4EmBx4k2E6+6NSMI6hOb63D5bAn2hdeTmmed/e/tawUlH9tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739402209; c=relaxed/simple;
	bh=z/+SL4rIAN/2IA/ZiryaJKAYAyhRkBg5+EdImslT/xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/8mwxov35BIOv5gG5/djSuv5sCXdiofS1LxyeL83fDKs3uyCJ8sxL4d160Y6aifH5beDVfY6KMHdNWWf7Mbl87t2hcEaufW7yFdLterMihM0wksd3gx1Eh4SQLTzFEcYVfSt5IJk2ueTxnUEgA40SgVizINd9cHoOi0K97YGBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQBkY+C6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179A5C4CEDF;
	Wed, 12 Feb 2025 23:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739402208;
	bh=z/+SL4rIAN/2IA/ZiryaJKAYAyhRkBg5+EdImslT/xA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQBkY+C604/nexvzuUq+AkoquwEShxVsllkQPQ5DG1ELiOqzekL9aM9hkl+IoNgzH
	 KCRVOiLJdhbJI23fPde+3R5V2eICBn2OHZ4+TtwQO7Qs4l93VhgKP62ReXsFB7Es7j
	 gdPh6RYJFF4lasUwh0m1K+7h+ClDpBjphGFpXL+oKdLS25XOhgqYJGRPi9iCpesv9s
	 SXFzL413K6qcwmDW5mx7aKlaS7W1vx8fwz//RRfCBtlVEwbaQDG5jlT5F1/I9FfVJo
	 qo+cQo2YOkPoNZOq7TYEV7Se2YK5izU0+9Y9EssV8dihiieeYVMfgnb1/o2rUkWEjq
	 lpnJFFmvIOR7A==
Date: Wed, 12 Feb 2025 15:16:46 -0800
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
Subject: Re: [PATCH v3 06/35] x86/bugs: Restructure mmio mitigation
Message-ID: <20250212231646.gyf4zbqlq7f6kqqf@jpoimboe>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-7-david.kaplan@amd.com>
 <20250210232951.x4mbmpjy57jpunb5@jpoimboe>
 <LV3PR12MB926503692B759DF39113626294FD2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250211231839.bmcgj4vnvjyba74d@jpoimboe>
 <LV3PR12MB9265E88D27667AE6BAD9F7F394FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265E88D27667AE6BAD9F7F394FC2@LV3PR12MB9265.namprd12.prod.outlook.com>

On Wed, Feb 12, 2025 at 05:28:23PM +0000, Kaplan, David wrote:
> > > > Right here it does the following:
> > > >
> > > >         /*
> > > >          * Enable CPU buffer clear mitigation for host and VMM, if also affected
> > > >          * by MDS or TAA. Otherwise, enable mitigation for VMM only.
> > > >          */
> > > >         if (boot_cpu_has_bug(X86_BUG_MDS) ||
> > > > (boot_cpu_has_bug(X86_BUG_TAA) &&
> > > >                                               boot_cpu_has(X86_FEATURE_RTM)))
> > > >                 setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
> > > >
> > > > Isn't that a cross-mitigation dependency?  i.e. if
> > > > X86_FEATURE_CLEAR_CPU_BUF gets enabled here then the other
> > > > mitigations would need to update their mitigation reporting?
> > >
> > > I don't think so, nobody should be looking at
> > > X86_FEATURE_CLEAR_CPU_BUF to determine their mitigation selection,
> > > they should only be looking at the other variables like taa_mitigation
> > > as done in the verw_mitigation_enabled() function.
> >
> > But isn't that a bug in the reporting?  AFAICT one of the main motivations for the
> > cross dependencies (and the *_update_mitigation()
> > functions) is to fix the reporting if something actually ends up getting mitigated by
> > something else.
> >
> > For example, "mds=off tsx_async_abort=full" results in both MDS and TAA being
> > reported "Mitigated", because they share the same VERW mitigation.
> >
> > But in the above case, with X86_BUG_MDS, "mds=off mmio_stale_data=full"
> > shows MDS as vulnerable despite it actually being mitigated by VERW.
> 
> Does it?  In that case, mds_update_mitigation() will see that
> verw_mitigation_enabled() is true (because
> mmio_mitigation!=MMIO_MITIGATION_OFF) and then enable the mds
> mitigation.

Hrmmm, that's a bit of a maze.

static bool __init verw_mitigation_enabled(void)
{
	return (mds_mitigation != MDS_MITIGATION_OFF ||
		(taa_mitigation != TAA_MITIGATION_OFF &&
		 taa_mitigation != TAA_MITIGATION_TSX_DISABLED) ||
		mmio_mitigation != MMIO_MITIGATION_OFF ||
		rfds_mitigation != RFDS_MITIGATION_OFF);
}

That seems to work by accident.  And I haven't managed to convince
myself it works for all edge cases.

Technically, checking !MMIO_MITIGATION_OFF alone isn't enough: MMIO only
needs global VERW if the MDS or TAA bugs are present.

Also, without ucode, the RFDS mitigation doesn't even attempt VERW for
some unknown reason, so just checking !RFDS_MITIGATION_OFF isn't
sufficient.

I'm thinking it should be something like

static bool __init taa_vulnerable(void)
{
	boot_cpu_has_bug(X86_BUG_TAA) && boot_cpu_has(X86_FEATURE_RTM);
}

static bool __init mmio_needs_verw(void)
{
	return boot_cpu_has_bug(X86_BUG_MDS) || taa_vulnerable();
}

static bool __init rfds_needs_ucode(void)
{
	return !(x86_arch_cap_msr & ARCH_CAP_RFDS_CLEAR);
}

static bool __init verw_mitigation_enabled(void)
{
	return mds_mitigation != MDS_MITIGATION_OFF ||
		(taa_mitigation != TAA_MITIGATION_OFF && taa_vulnerable()) ||
		(mmio_mitigation != MMIO_MITIGATION_OFF && mmio_needs_verw());
		(rfds_mitigation != RFDS_MITIGATION_OFF && !rfds_needs_ucode());
}

-- 
Josh

