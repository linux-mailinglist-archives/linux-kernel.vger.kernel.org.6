Return-Path: <linux-kernel+bounces-536646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E5A4827F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5FD18940F4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680FE26A0C3;
	Thu, 27 Feb 2025 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Pn6XRNW5"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68411154BF0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668526; cv=none; b=QF23+ky/W/Wgp4NEddzy5csicqjVclt5eSoJJaa6rcsfTQEM2IDEo+iilJznt7n4OmSSJ+IC2lEssBiecNdYUTx0cc1W356i76BOOg61X8KXi9319GdeAvaeuMrWfWODPAi4LV9ATvVddwBJHD6dNlP7N4IIqFh216nSnudOKtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668526; c=relaxed/simple;
	bh=z+Nj3qYcUKKM/dtNHjqvKQPyv6yD2YaLPYv1XpD4e5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jT/CVmWKl9tJXFVR71zUJQHkqfPzNg8RE/t5/V43rmRf3vX5jMV/MmriUjreL6qHhnMorx6kF2knzFQEz1F9bQnGG3M8/Ygb2EKHSc7u4jG0+yQBCUGA1wcAao7hRidgs7Bv8Fi4pKcBxXFDPB9hWTlf+paH9JG7PdSjVayzQSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Pn6XRNW5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0DE4740E0212;
	Thu, 27 Feb 2025 15:02:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DKqSEh8EeHyd; Thu, 27 Feb 2025 15:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740668518; bh=E3ulQVFwquBzi928EN2lwTovsU2b0NQY03QuZAGaIgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pn6XRNW5tzZpRKNIK3gdI6f+/rnCdGk1ERCH2brQhXI7fKCpFmQp+mDn1I8qgcJId
	 z+eN/sU4wS9uVFYNbdkZMx/MbV+rNhxvtyymW0hLU5srPmk3RgNmuwMBJJIwzoXKTm
	 vGalgvvBkDkk3AUjuvdWWr4XerHpK5BRBgmZtwbMN5OOB2Y56qw07shCrvBTn8OSz9
	 Xomn4Rnjq4pD7Tk/owirVkGYLVkWEo43rJlAxor7Z7rLUWup6UQO+p5Btv/ZbTQx7J
	 OsQkYs1XjVXKOIultLBfZ6rxUDfIqwPYqZ1lMMSqqTEeBAaOziS+PTO/vSxGqkXaHP
	 Pkil/SK4h8ellJ1AT6DQy7zxtsHeaiQYvWHx5Rj5RSXxBoJkd4zKFjGXtXP72YvuWp
	 RAf9vOhfsnb4W8Dsk3w64cRwgyS3JRvEPYXsMHPDbwIn+hKU6RsFk4uWpUKxtMO3XF
	 OLca3qkwLr4quSxTk1EpIPWoKW1MR+ZsUhyKtCyO5laml1Wg5tA6+J471GvdqYLcpc
	 rmXwt7u8vyluvkdGuoJJ5BR9zMvGKP0UcI9iCoObLhYD2svD0fHcqZDX+XrFTNsOUe
	 5FeXSREKQu8ct233DcMi3Wyxl3RavEAfm0Q+sN9LaA2hu5eo7U31WyF7dQNoD/NZNn
	 bQJjYMb4+7XP+aW76cFj+fRs=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F50540E01A3;
	Thu, 27 Feb 2025 15:01:48 +0000 (UTC)
Date: Thu, 27 Feb 2025 16:01:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 20/35] x86/bugs: Define attack vectors
Message-ID: <20250227150143.GFZ8B-V8nIdSlV7ng7@fat_crate.local>
References: <LV3PR12MB9265DE3082FA0A7FDF9B587594C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226201453.jgg6kucaathzmcvs@desk>
 <LV3PR12MB9265F875F52317BBCDF953EC94C22@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250226221324.hq2nevnnnrpgo75n@desk>
 <20250226234440.4dk4t3urkzt4zll7@jpoimboe>
 <20250227003528.hnviwrtzs7jc3juj@desk>
 <20250227012329.vbwdmihjlqu6h5da@jpoimboe>
 <20250227034813.booxbhxnff66dnqx@desk>
 <20250227140858.GEZ8Bx-tTaQF8D5WBj@fat_crate.local>
 <LV3PR12MB9265B1854AB766EBB7F098D294CD2@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3PR12MB9265B1854AB766EBB7F098D294CD2@LV3PR12MB9265.namprd12.prod.outlook.com>

On Thu, Feb 27, 2025 at 02:36:37PM +0000, Kaplan, David wrote:

> My 2 cents is I think the negative option form is better.  That's because
> I'd rather err on the side of safety if the user forgets something.
>
> For instance, in the case of 'mitigations=off;guest_host' there would be no
> guest->guest protection.  Did the user really intend for that?  Or did they
> simply forget to think about that attack vector?  In this case, their error
> leaves the system potentially insecure.

Well, good question. It could be that or it could be that the admin only cares
about protecting the host from malicious VMs but not the VMs amongst each
other. Does this use case make sense?

Probably. Maybe.

So if the admin really wants to do that, then she'll have to say:

mitigations=off;guest_host,no_guest_guest

I guess that can be specified with this cmdline.

I guess if she would want to enable both guest_host and guest_guest, then the
cmdline should be

mitigations=auto;no_user_kernel,no_user_user

or the shorter version

mitigations=;no_user_kernel,no_user_user

Hmmm, something still feels weird... I still can't go "oh yeah, this is a good
form." ;-\

> But if we only support the opt-out form, like
> 'mitigations=auto;no_guest_host' and the user forgot about guest->guest, it
> would leave those protections enabled.  Potentially reducing performance
> more than intended, but the system is more secure.

Still don't know for sure what the admin wanted: more perf or more security?
:-P

> Because the existing kernel defaults things to on (the auto setting) and
> requires action to disable mitigations, why not keep the same logic here and
> only support the opt-out form?
> 
> Some specific use case examples might be:
> 'mitigations=auto;no_guest_guest,no_guest_host' -- Running trusted VMs
> 'mitigations=auto;no_user_kernel,no_user_user' -- Running untrusted VMs but trusted userspace (cloud provider setting)
> 'mitigations=auto;no_cross_thread' -- Using core scheduling

I guess those make sense if you write them this way.

With the opt-out-only strategy, enabling a single vector would require you to
specify all others as no_*.

mitigations=auto,no_user_kernel,no_guest_host,no_guest_guest,no_cross_thread

That'll give you user_user.

Yeah, I guess we can't have the cake and eat it too. :-\

Which reminds me: on boot we should printk which attack vector got enabled and
which got disabled.

And then have that same info in

/sys/devices/system/cpu/vulnerabilities/attack_vectors

or so.

So that we can verify what got configured.

> On the SMT piece, I think the proposal is:
> 'auto;<attack vectors>' -- Default SMT protections (enable cheap ones like STIBP, but never disable SMT)
> 'auto,nosmt;<attack vectors>' -- Full SMT protections, including disabling SMT if required

Well, that's the question: cross-thread or nosmt is yet another attack vector.
So if we define the format as I mentioned above, this should be

auto;<attack_vectors>,nosmt or "cross_thread".

Right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

