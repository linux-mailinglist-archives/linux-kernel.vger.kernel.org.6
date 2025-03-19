Return-Path: <linux-kernel+bounces-568748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F72A69A13
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8103C16B78E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7E21B6CE4;
	Wed, 19 Mar 2025 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCuApUfo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20DE155C97
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742415378; cv=none; b=ZBTxgMjYsHE3MYmVzhdw2Ohv4pdprV0YB6ybWNbRh/F82ceZNbaD1Nnlfg+10/egfeqflQ8vpgsKCbFaxhJYah/Ek4NwH+zunft56N9wWSWVDpkW97YCQNURSx4xpV5KjY1DoxtJ1zx/kkfMioLJQ5nH3aSigjquV1WZPJUu4r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742415378; c=relaxed/simple;
	bh=AFln4KqsnQgAVUj/JTjO8+iSg3EjU2odjo/0kxCOE0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mw8ZGgbyONF/QXIJ6COBHQAEGvLGTm9zr9cr52lJH1hT3eMs3+J7l1Rhbzl4MLdbtVJJjUTYZQbL8xge3F8Pzlwnt4exs9dApUifNC0MvIXan5Cw6X1Ls7mjqTW+5HJ8qgf2+u23kAK344I0MmhVjQs2Meur2LNgCZolvWAasO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCuApUfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFEDC4CEE4;
	Wed, 19 Mar 2025 20:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742415378;
	bh=AFln4KqsnQgAVUj/JTjO8+iSg3EjU2odjo/0kxCOE0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kCuApUfowIpjfIfYdIMWeK0csJdD0x2zg9fb5RK/fUsSmjrAQTyULPmQ9Qrv46hsR
	 a9HBdUaT/tWmZXgCk+svZzalrucvoEBGrXOjP0Vcf6MCMNZAjrOjiCRCZg1DjOb3pG
	 gNSP+T2/djWNttFEM3W9qxgrOUgujw4xnIieWecQ5M4+qYNlT7P5J/Nl8Uu6tWhbMr
	 4Xlltuh9rV5aFd3P4QgNnhnJOFjNeCtcSTj8eJVJipQpiGczcws6t/aXjyNRlWy2N9
	 WTYpi+ipiHLE3Pr0kYN3HPIHwy7RBObY5H6L7T+F/EEpNgd4i2Rw4nq6HZa3z0nrrw
	 Jz6/QT6poSxyA==
Date: Wed, 19 Mar 2025 21:16:12 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>, Xin Li <xin@zytor.com>,
	linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/5] x86/cpuid: Use u32 in instead of uint32_t in
 <asm/cpuid/api.h>
Message-ID: <Z9smDLQp4DaKqy_r@gmail.com>
References: <20250317221824.3738853-1-mingo@kernel.org>
 <20250317221824.3738853-6-mingo@kernel.org>
 <b7920c2c-1051-4674-994c-d1b681cf7988@zytor.com>
 <Z9kwIYrOwO8nOpAE@gmail.com>
 <20250318093736.GBZ9k-4Fu_CqwhgYt1@fat_crate.local>
 <Z9leoRHkbu8Kgoed@gmail.com>
 <20250318121557.GCZ9lj_UyOqr9Mkaag@fat_crate.local>
 <Z9m5doW6IBVth-Kz@gmail.com>
 <87iko54f42.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87iko54f42.ffs@tglx>


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, Mar 18 2025 at 19:20, Ingo Molnar wrote:
> > * Borislav Petkov <bp@alien8.de> wrote:
> >> On Tue, Mar 18, 2025 at 12:53:05PM +0100, Ingo Molnar wrote:
> >> > How is one more word and saying the same thing in a more circumspect 
> >> > fashion a liguistic improvement?
> >> 
> >> Because it removes the "we" out of the equation. I don't have to 
> >> wonder who's the "we" the author is talking about: his employer, his 
> >> private interests in Linux or "we" is actually "us" - the community 
> >> as a whole.
> >
> > In practice this is almost never ambiguous - and when it is, it can be 
> > fixed up.
> >
> >> I can't give a more honking example about the ambiguity here.
> >
> > It's a red herring fallacy really. Let's go over the first example 
> > given in Documentation/process/maintainer-tip.rst:
> >
> >     x86/intel_rdt/mbm: Fix MBM overflow handler during hot cpu
> >
> >     When a CPU is dying, we cancel the worker and schedule a new worker on a
> >     different CPU on the same domain. But if the timer is already about to
> >     expire (say 0.99s) then we essentially double the interval.
> >
> > You'd have to be a bumbling idiot to think that the 'we' means an 
> > employer or the person themselves ...
> >
> > Put differently: *the very first example given* uses 'we' functionally 
> > unambiguously so that everyone who can read kernel changelogs will 
> > understand what it says. Ie. the whole policy is based on a false 
> > statement...
> 
> That's complete and utter nonsense.

I love you too! :-)

> 'we cancel the worker, we call kmalloc()' are purely colloquial 
> expressions.

So what? I have no problem with colloquial, familiar, everyday language 
in a technical context as long as it's effective and unambiguous.

The main linguistic advantage of German engineering is the ability to 
construct new, unambiguous words out of thin air:

   "Donaudampfschifffahrtselektrizitätenhauptbetriebswerkbauunternehmenbeamtengesellschaft"

... not the cold, impersonal tone. And I say that as a German, and yes, 
the 87-letter word above is a real, valid German word. :-)

> Liguistically they are factually wrong abominations.
> 
> We can cancel a subscription, an appointment, a booking... We can 
> call a taxi, a ambulance, a doctor, ....
> 
> But as a matter of fact, we _cannot_ cancel a worker or call 
> kmalloc().

Nor can we read a source buffer, nor can we do multiple writes to a 
destination buffer, right?

Tell that to Linus, who arguably writes one of the best changelogs in 
the kernel:

  # 9022ed0e7e65 ("strscpy: write destination buffer only once")

    In particular, the same way we shouldn't read the source buffer more
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    than once, we should avoid doing multiple writes to the destination
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    buffer: first writing a potentially non-terminated string, and then
    ^^^^^^^
    terminating it with NUL at the end does not result in a stable result
    buffer.

And I think the moment you have to argue against the quality of Linus's 
changelogs you've lost the argument really, almost by default.

> Changelogs as any other serious writing in technical context are about
> precision and clarity.

Absolutely, and 'we' in this context unambiguously means the kernel, so 
it's as clear to me as it gets.

I (obviously) agree with most of the stylistic and linguistic 
suggestions in Documentation/process/maintainer-tip.rst, and maybe my 
reaction was a bit hyperbolic (sorry), I just pointed out that this 
silly avoidance of pronouns like 'we' - which started the discussion - 
which results in *sentences with more words*, is *obviously* 
counterproductive.

Longer sentences with the same information content == worse.

To visualize it:

  When a CPU is dying, the worker is canceled and a new worker is scheduled on a different CPU in the same domain.
  When a CPU is dying, we cancel the worker and schedule a new worker on a different CPU in the same domain.

In communication shorter is better, if the information content is 
otherwise equivalent.

Anyway, let's agree to disagree. :-)

Thanks,

	Ingo

