Return-Path: <linux-kernel+bounces-566134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051BDA673A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4437319A3D51
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B0820ADD1;
	Tue, 18 Mar 2025 12:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="TXTf/7eT"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700B77464
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742300196; cv=none; b=aHKGVhBrjItDiN8AHKXhwgJNrAHSHuk2pOZ1vjB3EMylsDxIhjYQWJ2iEO/FTgaqoDGEhTXjiH3aJw2tsR/igqL3X/wtIxQvHLx6V9faHSXVm7qO0gi5tTJ0sNkS/mW9xxuEaJ2Ja2vDUPEkBVQk36KKlMBu+Mr4xQtECRWC7ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742300196; c=relaxed/simple;
	bh=j/7kdaG0/ubPBGQcsUgHt3pXiKJ+01LdFQoTJdxvvG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqDFmtX7SntxO6NfMldzHqQU7Y1PuFhzWO+DdkPM5WVYNRVz1LFbaD3xlyWWKSd43Z5KocRGEmiIggE7ssv2J7qPbaIStG7rLo8EtQEqVddhcaVHfSjZyl2VaIURtov+yGZFnF5bdFXQIp7QLHHj7UkR3x2ny/LxiWOw8hMyV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=TXTf/7eT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2D01540E0215;
	Tue, 18 Mar 2025 12:16:22 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vJWOEAFDZ0P0; Tue, 18 Mar 2025 12:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742300176; bh=3eAVlL5qgWhGszHtT9PBcwRpuDDf3YupCCJ1z1se1kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TXTf/7eTC85vV8iAz0s9hHE6D6iSrDRtOC/+qEio/v2XM2Rjp8CNSE3LV+PWQf2cE
	 WOD0hYXIAULnCO5ykguH8bTeUCkuKmeqwQcmSareS18njyrZ5u4B4gI00PrSInE6hD
	 wO9HRQ2Sjf8qnFuXrFKGfHDUtoreaIDEWGDfamsYl1ODQ/kNiiPd4vpRa9y8Tpy2j1
	 vY58N9oM86KC2BjwxEtWcEPb1y9VBXf7Y1wynJVKo98njYbwI10MnfnT5aikE5mxZ4
	 QM/q9JAAaTyXzDDUKygle7Rb/sYiZrU5QN6RlcrX4Gdnd2NhFGl0yiTmwUupy7cqwB
	 Ni2Blk9uCgjlqiO+VU3i86tn1lx++RR1/buVtqtAIz/kueRoSK78zyKvw04mdq035r
	 CnKHjCORhUdsXQyIs9dMb5reg0yripaTPZGHkEfkx7wWbg0JJ0f8DobpV1QhZypmnz
	 xIXJQbtjaHHJ7x6ffRYq0vWzkWbsrzuXNypBialyQ7RLipqeveEYbm316yghX9WIfe
	 /y9iMwkq2/F3NB8XQP5loYxqG8tlQCoSF32Vsfgxs58LE4BJHFkxSTB/cVKY+jYmnO
	 f66p9F7oShAQj0tbW5/dEFlGx7MtQzD9wAXrJs4GqWCUPqaYifkZ089Vsx2I09bZW5
	 Ujc/7Q8f77O31DyWS7qJxxlY=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E9B040E015D;
	Tue, 18 Mar 2025 12:16:04 +0000 (UTC)
Date: Tue, 18 Mar 2025 13:15:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/5] x86/cpuid: Use u32 in instead of uint32_t in
 <asm/cpuid/api.h>
Message-ID: <20250318121557.GCZ9lj_UyOqr9Mkaag@fat_crate.local>
References: <20250317221824.3738853-1-mingo@kernel.org>
 <20250317221824.3738853-6-mingo@kernel.org>
 <b7920c2c-1051-4674-994c-d1b681cf7988@zytor.com>
 <Z9kwIYrOwO8nOpAE@gmail.com>
 <20250318093736.GBZ9k-4Fu_CqwhgYt1@fat_crate.local>
 <Z9leoRHkbu8Kgoed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9leoRHkbu8Kgoed@gmail.com>

On Tue, Mar 18, 2025 at 12:53:05PM +0100, Ingo Molnar wrote:
> How is one more word and saying the same thing in a more circumspect 
> fashion a liguistic improvement?

Because it removes the "we" out of the equation. I don't have to wonder who's
the "we" the author is talking about: his employer, his private interests in
Linux or "we" is actually "us" - the community as a whole.

I can't give a more honking example about the ambiguity here.

>   The second sentence, "When a CPU is dying, we cancel the worker and 
>   schedule a new worker on a different CPU on the same domain," is easier 
>   to understand. It uses simpler language and a more direct structure, 
>   making it clearer for the reader.

I disagree with the LLM - it is yet another proof that AI won't replace
humans - if anything it'll make them *think* more. Which is good! :-)

> Few people will understand a generic personal pronoun to apply to a 
> corporate entity magically, unless it's really clear and specific:
> 
> 	"We at Intel believe that this condition cannot occur on Intel 
> 	 hardware."
> 
> in which case it's not a generic personal pronoun anymore.

Except no one says "we at <company>" - they say "we" ambiguously. And I have
had gazillion examples of "we the company want Linux to do this and that
because our use case is bla".

> Or to give another data point: since the v6.13 merge cycle we have 

<snip the stats>

That's why I said

"Is it a hard rule? Ofc not - there are exceptions to that rule depending on
the context."

And we have said "we" for 30+ years so can't change that over night. And not
everyone agrees with that. I understand it all.

I still think that in some cases formulating a commit message in impersonal
style lets you concentrate on the *problem* at hand the commit is trying to
fix - not what we do or want. It removes the person out of the equation
because the person doesn't need to be there.

HOWEVER, it is perfectly fine to say "I did this and that and I've been
wondering for years why the code does what it does." because it adds that
additional coloring about the trials and tribulations of the author.

So no, it is not a hard rule but there is an undeniable merit in writing the
commit messages impersonal.

And that's fine - I fix up things from time to time when they bother me.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

