Return-Path: <linux-kernel+bounces-509973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85868A316BB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 283607A30F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 20:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F2E263895;
	Tue, 11 Feb 2025 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAZv/Qzz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C55A265626
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739306073; cv=none; b=lkY1LpOKbJA77gsGEN76XKjO8mnz0NdSYOwbQeQfKOno6GO3cQJa5kzVStcGNIEJutDi770cYDRywLsyJbEfK1LWCVZaF0k/O3lh4ABBU/PXgzWBKHzFa/LCEuEyg4hbTSAPSd26nwG0TgErXAAMZkw0IksYFqtBvXeKNel5P/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739306073; c=relaxed/simple;
	bh=BV+Lq/r5uyY5Q+Lo/NbHTCekbYyPw8scVu2G4AzBOus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISbcyvjbhkxhQgNwQ0V3/eK8EJVNkpLGWGUJaj2GaBl+GOnJDrsNkkxbMk/ei1LFXzc4++nzyzCrqA3cfSUOXRsBP+7xipc+CIlKjfIaSSxEPor0EM6xIAzlLrIhoO80BhtV5gvJY1KpRizsE/vbNTgNEZdp8g8yShy+ts/Hnro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAZv/Qzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39592C4CEDD;
	Tue, 11 Feb 2025 20:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739306072;
	bh=BV+Lq/r5uyY5Q+Lo/NbHTCekbYyPw8scVu2G4AzBOus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RAZv/QzzWzboB74iwy8XJJM019hd7LLbV/xWiNPSSnylEq3jvpeEyA1jnOjTzsB6O
	 J3qdkCp+kifjb6p5cuWYeY2Ra/z5YCsjyT8VR0DSPRCjTxE9N3lDlwdpNQP9wK7/2E
	 V150tixxWTvTU10SVHoEyoLmrLSD8oe4M3gpXTfC0AJr7bzHjrmEWl/gbIB9ZdHHZK
	 alIlm+AYTWeIhLnx3vPLKE/nPEB4ayY0alBS4tOWBMAfr7Eg5s6hj7fx0lU72hsZPW
	 0ujM+AT3+VNU1Sswv/0uNtpiCSPEh2SqmvM0+12INYM5a0q03XoELsXsN07ttjCJOQ
	 vphLAqHsUI4XQ==
Date: Tue, 11 Feb 2025 12:34:30 -0800
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
Subject: Re: [PATCH v3 21/35] x86/bugs: Determine relevant vulnerabilities
 based on attack vector controls.
Message-ID: <20250211203430.vvuf7aks3hrozv5b@jpoimboe>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-22-david.kaplan@amd.com>
 <20250211184130.2fl4jvdwd4e5y32a@jpoimboe>
 <20250211185400.vwu3tkqr4gc2r5tu@jpoimboe>
 <LV3PR12MB9265D7BF6446C2D84414E42C94FD2@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265D7BF6446C2D84414E42C94FD2@LV3PR12MB9265.namprd12.prod.outlook.com>

On Tue, Feb 11, 2025 at 07:04:44PM +0000, Kaplan, David wrote:
> To explain my thinking a bit more, mitigate_cross_thread is intended
> to enable cross-thread mitigations for any vulnerabilities the
> hardware may have.  That does not necessarily require disabling SMT.
> The required cross-thread mitigation is defined by each vulnerability.
> 
> For many vulnerabilities (like MDS), mitigation requires disabling
> SMT.  mds_apply_mitigation() queries the status of the cross-thread
> attack vector and will disable SMT if needed.
> 
> For GDS, mitigating cross-thread attacks does not require disabling
> SMT, just enabling the mitigation in the MSR.
> 
> To be fair, it doesn't make much sense to disable all the attack
> vectors except mitigate_cross_thread, but for correctness it seemed
> like enabling the mitigation in this case was the right thing.
> 
> I don't really want to tie mitigate_cross_thread to SMT disable
> because of cases like this where there is a cross-thread attack
> mitigation that is different from disabling SMT.  You could also
> imagine bugs that might be even more limited, where perhaps they're
> only relevant for say user->kernel but also have a cross-thread
> component.

But that "cross-thread" thing doesn't even make sense as a vector.

Think about it this way.  For cross-thread attacks:

  - CPU thread A is the attacker.  It's running in either user or guest.

  - CPU thread B is the victim.  It's running in either kernel, user, or
    host.

So ALL cross-thread attacks have to include one of the following:

  - user->kernel
  - user->user
  - guest->host
  - guest->guest

So by definition, a cross-thread attack must also involve at least one
of those four main vectors.

So cross-thread can't be a standalone vector.  Rather, it's a dependent
vector or "sub-vector".

If a user wants to be protected from user->user, of course that includes
wanting to be protected from *cross-thread* user->user.

And if they *don't* care about user->user, why would they care about
*cross-thread* user->user?

What users *really* care about (and why there exists such a distinction
in the first place) is the functional/performance impact of disabling
SMT.

So a flag to allow the vectors to disable SMT makes more sense, e.g.,

  mitigate_disable_smt=on

And maybe also an additional flag which says "I've enabled core
scheduling or some other isolation scheme, don't worry about any of the
SMT-specific mitigations like STIBP":

  mitigate_smt_safe=on

But the standalone "cross-thread" vector doesn't fit at all.

-- 
Josh

