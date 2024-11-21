Return-Path: <linux-kernel+bounces-417503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B48CC9D54D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B831F218A9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C634C1D958E;
	Thu, 21 Nov 2024 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPAx1iPK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA141C232B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225214; cv=none; b=ZHEPLQD4kS+rTNfy/dFrXX1x+hVWJ7WPKWwHpB5ksHHEKG4RC6/81GS0lgKJUzJQSpRtgb+HtpIpBc86A6mv+wnoHGP9FitUv0mbpvMjBuYD1ElS4utIUzEUZcityI2P8apxQeElpSSjxeHGUhLxVcQ3O/wKTCw+D/Y3GgnP9bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225214; c=relaxed/simple;
	bh=kUQoBpfy9drWBz+xkzp4tToFKNmUtfxu9U4gcNzJquY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DToTOL8EyshgZF4h8j/rsZXTcAX+n7D25ABTvehLeWGxQ0wTVzK5ko2yoBUh4pt4qv5xApLOrjYnyou6vTJBL2yg43DH4vfEbqU9wf8sjqPo2sQ9j08rnD79M3ownD8RBQ5tZGIeIC8MOzVE2DSBdaY0v9vzV4zwg1lUNe9E7+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPAx1iPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1210BC4CECC;
	Thu, 21 Nov 2024 21:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732225213;
	bh=kUQoBpfy9drWBz+xkzp4tToFKNmUtfxu9U4gcNzJquY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lPAx1iPKIWYlSUmgWbfqfbeot57JMkGh/1uNUBmkDIyv5bBAf4HmIiUcszb24ykkq
	 xs9P/xjLF4kKANQTlhmfnvGi5miDKWm9710SkmX+0CipOcUrv37yuXmArLABZ5/SUs
	 hW0DP/12rKdpnT9SdpPx6sPkYQhkS+R5a2nHRhTQjBorsfcim10M1Xw1v4m6Y3UJ55
	 ViKKbr2Eq2F8GohAiQQxH1b0lXqtl/4GmjeNE0HY54AKjW7sJ5t5hpCKEvhXvpv0Nx
	 A96TF4+jJxr0dnJUJ5c+ozhLb0nqm0wEeRJcNMlqq8G7JFVbFMhR4m6A8jWf1p5jgH
	 Mt112xwNmSuuA==
Date: Thu, 21 Nov 2024 13:40:11 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Laight <David.Laight@aculab.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Waiman Long <longman@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 2/6] x86/uaccess: Avoid barrier_nospec() in 64-bit
 __get_user()
Message-ID: <20241121214011.iiup2fdwsys7hhts@jpoimboe>
References: <cover.1730166635.git.jpoimboe@kernel.org>
 <82cbb9983fef5ecf6f1cb33661e977172d40a7e6.1730166635.git.jpoimboe@kernel.org>
 <20241029032735.pw3bg64bpneqnfhk@treble.attlocal.net>
 <76bb85ceeb854e3ab68d87f846515306@AcuMS.aculab.com>
 <20241115230653.hfvzyf3aqqntgp63@jpoimboe>
 <CAHk-=wgLCzEwa=S4hZFGeOPjix-1_fDrsqR-QLaBcDM-fgkvhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgLCzEwa=S4hZFGeOPjix-1_fDrsqR-QLaBcDM-fgkvhw@mail.gmail.com>

> On Fri, 15 Nov 2024 at 15:06, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> So I think the thing to do is
> 
>  (a) find out which __get_user() it is that matters so much for that load
> 
> Do you have a profile somewhere?
> 
>  (b) convert them to use "unsafe_get_user()", with that whole
> 
>                 if (can_do_masked_user_access())
>                         from = masked_user_access_begin(from);
>                 else if (!user_read_access_begin(from, sizeof(*from)))
>                         return -EFAULT;
> 
>      sequence before it.
> 
> And if it's just a single __get_user() (rather than a sequence of
> them), just convert it to get_user().
> 
> Hmm?

The profile is showing futex_get_value_locked():

int futex_get_value_locked(u32 *dest, u32 __user *from)
{
	int ret;

	pagefault_disable();
	ret = __get_user(*dest, from);
	pagefault_enable();

	return ret ? -EFAULT : 0;
}

That has several callers, so we can probably just use get_user() there?

Also, is there any harm in speeding up __get_user()?  It still has ~80
callers and it's likely to be slowing down things we don't know about.

It's usually only the regressions which get noticed, and that LFENCE
went in almost 7 years ago, when there was much less automated
performance regression testing.

As a bonus, that patch will root out any "bad" users, which will
eventually allow us to simplify things and just make __get_user() an
alias of get_user().

In fact, if we aliased it for all arches, that could help in getting rid
of __get_user() altogether as there would no longer be any (real or
advertised) benefit to using it.

-- 
Josh

