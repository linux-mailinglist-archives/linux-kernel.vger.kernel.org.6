Return-Path: <linux-kernel+bounces-569367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7D3A6A1F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6B81894C16
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6392021D5A9;
	Thu, 20 Mar 2025 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unbtsvZd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FCE213245
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461175; cv=none; b=ruIIMlK5LTVgtYolWhhiSL68bqboFtNJGMYBRkg6biVojlicgA5Fn6A4GMAARJUg++k7derJdyOJaDPDR+oDEycvxQtfiWYgTB+3o2sutoZoOKDLW3gcdoSTFKl8hqNVnQT4Q+y2CBRFa3PcktAIIb3lYCCxAV7wXitcAMVRwAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461175; c=relaxed/simple;
	bh=xEK8S5NZZN0srSXWfnFdrZtCwFS9xhoDzVumA0xsMvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzU8+GwZgUue4kWc1Wtjp/8oQqGLWxKnChIq7GoJIyLWUYkVGfGlUJueiTc6KSg3SOmi/PAcykTc7EfVZQZQ96sTFiEMWaKEQa/ofAS9a+3ZLcRlrF1rEr/CVsdR/MvHfuwJtHVIV9p2tY6DgcysjsyX9/g+BN9bHHtAZ1K4cQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unbtsvZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C240C4CEDD;
	Thu, 20 Mar 2025 08:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742461174;
	bh=xEK8S5NZZN0srSXWfnFdrZtCwFS9xhoDzVumA0xsMvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=unbtsvZduzn/wwWsYZ0/KuBAD2EISYzZCOlPTWe/+neTapvDJH5kEuWnMlnuP9a+p
	 rmf0J7TI6LwBKVDWXj2zYKC0diP2YvQOLy+4D6YXGKffv4kE0Dvrio+273XUal4ZId
	 BX2GFqomNFQKrWgtPTy6xYqzk5+xVnKPFJ0UgKwaypS71sfAERc4P7VmhrvbaBnO3o
	 r9QeAKRW5+urlTJWT3WeNUtOWIR1jqPE1g7FJWThs1EZ36eyf0GRGzq7cPYfk3tnPc
	 KMcGCkQ/ctsC3CJ4UtuNlUJoIKf/Me9vkzd4OoVQykdRkP2jOkixRN8A9kQPO3ny8V
	 rTuwb/kGGWCmg==
Date: Thu, 20 Mar 2025 09:59:28 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	John Ogness <john.ogness@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] compiler/gcc: Make asm() templates asm __inline__() by
 default
Message-ID: <Z9vY8Bm1Wv1vkqNO@gmail.com>
References: <20250317221824.3738853-1-mingo@kernel.org>
 <5A417EE0-8DF3-4C6E-A7E9-9EE6705282F1@zytor.com>
 <Z9m1rtmlk1PxGIQA@gmail.com>
 <CAHk-=whAUHyXM29_9w_T26=15D1KZnuR3R+f4MT9f-C89oukvA@mail.gmail.com>
 <Z9m_kUqxqMPfU8Fl@gmail.com>
 <Z9nTfFiPv0-Lxm-_@gmail.com>
 <CAFULd4aFUun7+1izxbDM8nTEEta5PApysyTGsn1hjvQND=2UtQ@mail.gmail.com>
 <Z9tGh0Fa96gACmpQ@gmail.com>
 <CAFULd4bxUOiPLQ9aaZFx2jsLUwEPH0h=XiCOtxYn+Z8JEAeHUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4bxUOiPLQ9aaZFx2jsLUwEPH0h=XiCOtxYn+Z8JEAeHUw@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> > > > I haven't looked at code generation much yet, but text size changes are
> > > > minimal:
> > > >
> > > >       text         data     bss      dec            hex filename
> > > >   29429076      7931870 1401196 38762142        24f769e vmlinux.before
> > > >   29429631      7931870 1401200 38762701        24f78cd vmlinux.after
> > > >
> > > > Which is promising, assuming I haven't messed up anywhere.
> > >
> > > Please use bloat-o-meter, it is more precise.
> >
> > Here's the bloat-o-meter output between vanilla and patched vmlinux:
> 
> [...]
> 
> > A lot fewer functions are affected than I expected from such a
> > large-scope change.
> 
> Interestingly, I got *many* more changes just from converting atomic
> locking functions to asm_inline, as reported in [1].
> 
> [1] https://lore.kernel.org/lkml/CAFULd4YBcG45bigHBox2pu+To+Y5BzbRxG+pUr42AVOWSnfKsg@mail.gmail.com/

Have you used a pristine x86-64 defconfig for your build tests?

Could you perhaps check my patch against your patch in your build 
environment and figure out why there's such unexpected differences?

As you noted my patch should be a blunt-instrument superset of your 
changes so if then it should affect *more* functions, not fewer.

Thanks,

	Ingo

