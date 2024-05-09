Return-Path: <linux-kernel+bounces-174152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 527B08C0AEC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC63282B03
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766241494AB;
	Thu,  9 May 2024 05:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmzWW8zg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD314901B
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 05:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715232289; cv=none; b=ZA88F9KWvS10uRV38IcpMPFgv6hwdxuNSq9EH0pVbDBo8TRD1eGtTWI6SKyinvUvFCHwPrTbBxAe8LtCO2251ldLf9PCjeZfMR6mxa0jNql0uUKlHeTic/x453jcidqm41Y5O5mrkP7G+5mpKTB7otKXicCbhLgcVys2MqSBoxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715232289; c=relaxed/simple;
	bh=ZMwEX+o/EJkHcRC3vFU2GlG5OYSdAKOVflztUOttcbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAjBNVT0FmRV0+GzDOQS4SPj8U67YNb86sj7PR6x33SR6uJ+8vsRcg6HmZ9lVMa4rUNjn9QUnu4ls+q4ionPx3alEG8Nb6pBR87JtRsxR96sOqJD/71kwdYbcryvyNOjCWJt5C07i6/ad6lNMxg9TDOcwku2I18FXcSTefcIEnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmzWW8zg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9B2C116B1;
	Thu,  9 May 2024 05:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715232289;
	bh=ZMwEX+o/EJkHcRC3vFU2GlG5OYSdAKOVflztUOttcbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SmzWW8zg9hGq1aNGq5zj376fYeWWvFV1RPodmTzTuiLXGjPLihiIy4iQh7tP148ba
	 1a0t9C/CKL1hNKXCq6XZC9k8eT6AyD2Na/xCcz9ugr1rEc2DBNwuRe8glbKgGFwoaU
	 50neVaXpRtp0f8YgOHrGm73eAKPRNEtZmkzz0rjrJ4K8vuzXquKydVysgY7kPlsQIp
	 0fk+ibm8nVlwypVXgFUelQ5JZA2bUEbUBxVTtYQZ/N7dANJJNBY4kbuMGbjp8FWGRV
	 m19ee0koBSB3SSOk2KVs5ZcIAUBDvoF5z0eC6vgHUb1YVpLqrcuR15+hFt9pZztZtQ
	 ZGveAl8Wa7gIw==
Date: Wed, 8 May 2024 22:24:47 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
	Maksim Davydov <davydov-max@yandex-team.ru>
Subject: Re: [PATCH v5 3/3] x86/bugs: Add 'spectre_bhi=vmexit' cmdline option
Message-ID: <20240509052447.kwdlruqad7r5h4pi@treble>
References: <cover.1715059256.git.jpoimboe@kernel.org>
 <66327dcf87284a09ed17ac24227695ea3ba1f287.1715059256.git.jpoimboe@kernel.org>
 <f48601e1-e8a6-4161-9a77-32ad10c887de@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f48601e1-e8a6-4161-9a77-32ad10c887de@suse.com>

On Wed, May 08, 2024 at 06:10:21PM +0300, Nikolay Borisov wrote:
> > @@ -1659,19 +1662,22 @@ static void __init bhi_select_mitigation(void)
> >   			return;
> >   	}
> > +	/* Mitigate in hardware if supported */
> >   	if (spec_ctrl_bhi_dis())
> >   		return;
> >   	if (!IS_ENABLED(CONFIG_X86_64))
> >   		return;
> > -	/* Mitigate KVM by default */
> > -	setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
> > -	pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit\n");
> > +	if (bhi_mitigation == BHI_MITIGATION_VMEXIT_ONLY) {
> > +		pr_info("Spectre BHI mitigation: SW BHB clearing on vm exit only\n");
> > +		setup_force_cpu_cap(X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT);
> > +		return;
> > +	}
> 
> nit: How about setting CLEAR_BHB_LOOP_ON_VMEXIT unconditionally, then
> afterwards checking if MITIGATION_VMEXIT_ONLY is set and if yes simply
> return, that way you don't duplicate the setup of the VMEXIT code

I think the duplication actually makes it more readable.  In both cases
it puts the setting of the features together along with the
corresponding pr_info().

-- 
Josh

