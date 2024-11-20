Return-Path: <linux-kernel+bounces-415699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE919D39FB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257291F24B64
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929351A38D7;
	Wed, 20 Nov 2024 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltpS2enG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA04B1A2C19
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103569; cv=none; b=ljg+g1hqfpZjEg2viwEUPLkMqT6NgaFiFzs+67UTFED0iNjZZPujP8TKaQLsc2WchAa2olXTLLoB3Z8afsah9tVBESQegp4IyRDiHZpcFKmufrZncrYUjIijAdCnDXG+zW8saDhMVIfH0aujQqLXzt3Vl9X/bKggzWISW1SWz38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103569; c=relaxed/simple;
	bh=wcdGEYpMyguegsuVTB6UdMRDvHPpobEbMN9xgyvXRo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikbw0nGkjG2yYcQ6LFYri1Y10G6hilvoepV6fAyToBdXiZovsSiTbogco0u0HUlI1iWcPQIQEB2vRF3El8zCxtIdHz+icSuL3rTd8shIQdzkz0eT22i8KN6slMxIEqRZN8rARSiMSmcZ8bMi26OrSsxbPfcQwj0QmrmzfbEctnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltpS2enG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45C43C4CECD;
	Wed, 20 Nov 2024 11:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732103568;
	bh=wcdGEYpMyguegsuVTB6UdMRDvHPpobEbMN9xgyvXRo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ltpS2enGDI3Ca4iZHDjsnrlXHY/OBHKAaWBh5U9m96NUvfAZqkvw/xA27v8pPf2b+
	 oUTqI+LXcsM1jGff9HpXlzaZqFvMxBgD5WUt1A0CaKDfdoTJUOZ8sc7e/bcMIgdN/w
	 8NdJk1bx5cswCe4MocztZl1HUemFLUxojh/X/qgPVLhBqjz16ibybjnWhJe3g7PS/g
	 Alq6zNbubaPGJ+uSWVMw+ujFZ8ADlvvak0aQyku+3mZdlb+44CxPace1Hwn5iW+eRD
	 ThMb2pTLX+5ULQgzBytjp2FjqcARWRf1SD23xV/Pk1ajMUnQm92g2Lc7cZhnjtAauR
	 kBsWBcmyFF6+A==
Date: Wed, 20 Nov 2024 12:52:43 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH] headers/cleanup.h: Fix if_not_guard() fragility
Message-ID: <Zz3Ni99LLGufmOjV@gmail.com>
References: <ZzsC7HOiJ8Mwk8D6@gmail.com>
 <CAHk-=wi8C2yZF_y_T180-v+dSZAhps5QghS_2tKfn-+xAghYPQ@mail.gmail.com>
 <Zz3Jsn7Vf8X9ICva@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz3Jsn7Vf8X9ICva@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Mon, 18 Nov 2024 at 01:03, Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > >  - <linux/cleanup.h>:
> > >     - Add if_not_cond_guard() conditional guard helper (David Lechner)
> > 
> > I've pulled this, but I'm unhappy.
> > 
> > This macro generates actively wrong code if it happens to be inside an
> > if-statement or a loop without a block.
> > 
> > IOW, code like this:
> > 
> >     for (iterate-over-something)
> >         if_not_guard(a)
> >             return -BUSY;
> > 
> > looks like will build fine, but will generate completely incorrect code.
> > 
> > Honestly, just switching the order of the BUILD_BUG_ON() and the
> > CLASS() declaration looks like it would have fixed this (because then
> > the '_id' won't be in scope of the subsequent if-statement any more),
> > but I'm unhappy with how apparently nobody even bothered to think
> > about such a fundamental issue with macros.
> > 
> > Macros that expand to statements absolutely *ALWAYS* need to deal with
> > "what if we're in a single-statement situation?"
> 
> How about the fix below?

I also reviewed our other similar macros in <linux/cleanup.h>:

 - scoped_guard() appears to be single-statement safe: it uses a for() 
   statement with a partial body with an open 'else' branch, so if this 
   macro is used within single statements the entire block will be part 
   of the 'else' statement.

 - scoped_cond_guard(): similar construct to scoped_guard().

 - The other remaining multi-statement macros are variable definition 
   macros (DEFINE_CLASS(), et al), which are typically used in file 
   scope or in header scope, and are not expected to be used in single 
   statements.

So it appears to me we should be OK wrt. this class of bugs?

Thanks,

	Ingo

