Return-Path: <linux-kernel+bounces-567463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4724A68667
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56DAC3BDEA4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053842505B2;
	Wed, 19 Mar 2025 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WwdxEd81";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Y+Sedu0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E8F3F9D5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742371714; cv=none; b=Y0L07AzKQXz9cvbzie3zg6VQccsN9DRHjL1vP3/o+T12e5HKP6FXG60T4Zp/fOOl2T5QVwQV8xGHXUo9wEvaRZ4oPMnuYBJXyEYM/eMCkpDjMFTExLls4vRuyNm7tF8f8uf150ObK9Visc92UhB/86shnnnZOlZZbYQ3sAbQgNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742371714; c=relaxed/simple;
	bh=qhvjAxE4p69Rl0RPkMUqqXsB1DoApPUzw6VMvFU5wcc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I9KO/FlRdFsq8iSMUa2nsCIZ+UBoBtUfut0ajFzMYy1y1yT4RyjNQP1XkP8Pw3hSA3rWU8N+O7D48WqKiT/72K6YqUesFquOp/AcSYOqUpKnl5X6fhxYnLrIkQFAs82Ce2IxWeplh1v5egSofAVe56cs3hN1rVIB/nzmyJi6r/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WwdxEd81; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Y+Sedu0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742371709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QrCbfMhSUYGsNZ3hZXQvgKi4jkVsGF4ulmbPc/9cnxY=;
	b=WwdxEd81NGUEvMfLihMZxf1mceXhpNDJ3ZlFFOJA068qThomJsXjGg+lKbxoa4TZc0LbFq
	bf/6MbFOPsddSaOiKM6SPH47ZxjWwAiFwd2JnTypgcZwXKnZJg6Nu5fX3IdpXqwjMJkKxA
	CltudPAYHBizsW2uRCvxN6zK06EJj6B4eLq6xwyJ41KzuntWMwV+shaW8rMH2d9NfWJeQc
	KOnHRG5ociKnU5nRKmbK6ikV54ga7kjW7SiDLQcJVQa90QOJrofDh8xdpdJtX4dEW8t0/V
	garZBMU4jP1Yq4jd2d0qwkPYgMolNIuU5pu0IDe6Hwuyowgo9hN60+C2g/s/Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742371709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QrCbfMhSUYGsNZ3hZXQvgKi4jkVsGF4ulmbPc/9cnxY=;
	b=+Y+Sedu0G69YBqMQWYuQ53sBxuiaYy6DaE+tRULnFz90g3cRpe0i+S7G6uiqxK/UonLRAO
	+0KfYNWhzGDODeDA==
To: Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org, Juergen Gross
 <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, "Ahmed S .
 Darwish" <darwi@linutronix.de>, Andrew Cooper <andrew.cooper3@citrix.com>,
 "H . Peter Anvin" <hpa@zytor.com>, John Ogness
 <john.ogness@linutronix.de>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/5] x86/cpuid: Use u32 in instead of uint32_t in
 <asm/cpuid/api.h>
In-Reply-To: <Z9m5doW6IBVth-Kz@gmail.com>
References: <20250317221824.3738853-1-mingo@kernel.org>
 <20250317221824.3738853-6-mingo@kernel.org>
 <b7920c2c-1051-4674-994c-d1b681cf7988@zytor.com>
 <Z9kwIYrOwO8nOpAE@gmail.com>
 <20250318093736.GBZ9k-4Fu_CqwhgYt1@fat_crate.local>
 <Z9leoRHkbu8Kgoed@gmail.com>
 <20250318121557.GCZ9lj_UyOqr9Mkaag@fat_crate.local>
 <Z9m5doW6IBVth-Kz@gmail.com>
Date: Wed, 19 Mar 2025 09:08:29 +0100
Message-ID: <87iko54f42.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 18 2025 at 19:20, Ingo Molnar wrote:
> * Borislav Petkov <bp@alien8.de> wrote:
>> On Tue, Mar 18, 2025 at 12:53:05PM +0100, Ingo Molnar wrote:
>> > How is one more word and saying the same thing in a more circumspect 
>> > fashion a liguistic improvement?
>> 
>> Because it removes the "we" out of the equation. I don't have to 
>> wonder who's the "we" the author is talking about: his employer, his 
>> private interests in Linux or "we" is actually "us" - the community 
>> as a whole.
>
> In practice this is almost never ambiguous - and when it is, it can be 
> fixed up.
>
>> I can't give a more honking example about the ambiguity here.
>
> It's a red herring fallacy really. Let's go over the first example 
> given in Documentation/process/maintainer-tip.rst:
>
>     x86/intel_rdt/mbm: Fix MBM overflow handler during hot cpu
>
>     When a CPU is dying, we cancel the worker and schedule a new worker on a
>     different CPU on the same domain. But if the timer is already about to
>     expire (say 0.99s) then we essentially double the interval.
>
> You'd have to be a bumbling idiot to think that the 'we' means an 
> employer or the person themselves ...
>
> Put differently: *the very first example given* uses 'we' functionally 
> unambiguously so that everyone who can read kernel changelogs will 
> understand what it says. Ie. the whole policy is based on a false 
> statement...

That's complete and utter nonsense.

'we cancel the worker, we call kmalloc()' are purely colloquial
expressions. Liguistically they are factually wrong abominations.

We can cancel a subscription, an appointment, a booking...
We can call a taxi, a ambulance, a doctor, ....

But as a matter of fact, we _cannot_ cancel a worker or call kmalloc().

Changelogs as any other serious writing in technical context are about
precision and clarity.

The impersonating form is obviously popular and in some contexts, like
tutorials and beginner guides, it makes them seemingly more accessible,
but that does not provide an justification for using it in the context
of change logs.

Change logs are an important documentation of the underlying code
change, because they provide context and technical justification for the
change and therefore have to prioritize precision and clarity.

Aside of that ,writing a change log in neutral and technically precise
language forces you to actually rethink the problem and the approach to
solve it. Dumping your half baked thoughts in impersonating novel style
does not.

From 20+ years of experience on the receiving end of the patch fire
hose, I can clearly proof a very high correlation between the quality of
change logs and the quality of the analysis and the resulting code
change.

Yes, it is work to write a proper and precise change log, but that extra
effort makes the work of people, who review patches, easier and it's
also highly benefitial, when analyising historical changes.

Thanks,

        tglx

