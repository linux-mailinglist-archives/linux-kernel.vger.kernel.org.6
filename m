Return-Path: <linux-kernel+bounces-510179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E37D6A31960
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FE0167370
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C755B267AF5;
	Tue, 11 Feb 2025 23:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuS2TWtd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32923272910
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 23:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739315923; cv=none; b=YJgC+aS/8Dlg71OFV8CoqL4i1Mptw/MkWbnnMx6zCA3D4oOnhq8f6wUJNKisbV6cvGYXjDESYHRJUDSnPPNyJ1HzzHX3zPkyi5IlhX7Yl6v6MGdnh3jz+NBoisnzH8MN1pBiqBYolspERweC8GxLHj9wOncoocpol7CDw2B5hSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739315923; c=relaxed/simple;
	bh=qziQ6j0kQF17jiRjjP9PrLGl+GCnpO1p+UgtDKBbIYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwcCvuaH6OpuqSTsg5WTYk3xNmjzmvCugXLDNcmNyODLgIkEFxCtRmbMTTgRl1/TON9kahE5MJPeoYLVVf39yL45AM0RuX1uPUsRRNjwhDir9wXObWw133+dHMQBsDWdBYZhhaLJ3kNJOsF+lMUAmLfoaoFSDD6+WhKAdqbsHM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuS2TWtd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A48DC4CEDD;
	Tue, 11 Feb 2025 23:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739315921;
	bh=qziQ6j0kQF17jiRjjP9PrLGl+GCnpO1p+UgtDKBbIYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NuS2TWtdXeKpWr+JZ1BwOhO63BvQc0xlbEaBJLdxpJHFPfaMPoud2L3QIe+uQ1z3c
	 ZK37ov7A/dj/6qvdERVRZP2viOaPxKSHyynVZtNgbHh2oY5DGfaAmOmN1XQTK3oKN0
	 3K9lo25fOzdQJecZVj21pwSpWHli6hi99ifahOlCF5Gr1sGwsoLrYT42FhlTxzyqGj
	 z3NZ35BlcXV2tUQ9TZqbZDVIJa6UGZIvr7Zl04jFqCYA2PqdN+QiVria4Zr1NyazC0
	 0PxaRg9jLZ6eUb7tNG87y5zull+IGGNLMbVBqLT3RjiGToOd65WfWpn5aJ/NUdP4bc
	 QJYeG+LO/zTXg==
Date: Tue, 11 Feb 2025 15:18:39 -0800
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
Message-ID: <20250211231839.bmcgj4vnvjyba74d@jpoimboe>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-7-david.kaplan@amd.com>
 <20250210232951.x4mbmpjy57jpunb5@jpoimboe>
 <LV3PR12MB926503692B759DF39113626294FD2@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB926503692B759DF39113626294FD2@LV3PR12MB9265.namprd12.prod.outlook.com>

On Tue, Feb 11, 2025 at 08:35:27PM +0000, Kaplan, David wrote:
> > > @@ -538,21 +582,6 @@ static void __init mmio_select_mitigation(void)
> > >       if (!(x86_arch_cap_msr & ARCH_CAP_FBSDP_NO))
> > >               static_branch_enable(&mds_idle_clear);
> >
> > Right here it does the following:
> >
> >         /*
> >          * Enable CPU buffer clear mitigation for host and VMM, if also affected
> >          * by MDS or TAA. Otherwise, enable mitigation for VMM only.
> >          */
> >         if (boot_cpu_has_bug(X86_BUG_MDS) ||
> > (boot_cpu_has_bug(X86_BUG_TAA) &&
> >                                               boot_cpu_has(X86_FEATURE_RTM)))
> >                 setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
> >
> > Isn't that a cross-mitigation dependency?  i.e. if
> > X86_FEATURE_CLEAR_CPU_BUF gets enabled here then the other mitigations
> > would need to update their mitigation reporting?
> 
> I don't think so, nobody should be looking at
> X86_FEATURE_CLEAR_CPU_BUF to determine their mitigation selection,
> they should only be looking at the other variables like taa_mitigation
> as done in the verw_mitigation_enabled() function.

But isn't that a bug in the reporting?  AFAICT one of the main
motivations for the cross dependencies (and the *_update_mitigation()
functions) is to fix the reporting if something actually ends up getting
mitigated by something else.

For example, "mds=off tsx_async_abort=full" results in both MDS and TAA
being reported "Mitigated", because they share the same VERW mitigation.

But in the above case, with X86_BUG_MDS, "mds=off mmio_stale_data=full"
shows MDS as vulnerable despite it actually being mitigated by VERW.

>         /*
>          * Enable CPU buffer clear mitigation for host and VMM, if also affected
>          * by MDS or TAA.
>          *
>          * Only enable the VMM mitigation if the CPU buffer clear mitigation is
>          * not being used.
>          */
>         if (rfds_mitigation == RFDS_MITIGATION_VERW ||
>             boot_cpu_has_bug(X86_BUG_MDS) ||
>             (boot_cpu_has_bug(X86_BUG_TAA) &&
>              boot_cpu_has(X86_FEATURE_RTM))) {
>                 setup_force_cpu_cap(X86_FEATURE_CLEAR_CPU_BUF);
>                 static_branch_disable(&mmio_stale_data_clear);
>         } else
>                 static_branch_enable(&mmio_stale_data_clear);
> 
> Does that sound right?

I *think* that's correct, but this still has the same issue that MDS/TAA
are now getting mitigated but not reported as such.

-- 
Josh

