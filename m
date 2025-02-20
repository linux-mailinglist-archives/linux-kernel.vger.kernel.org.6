Return-Path: <linux-kernel+bounces-524647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DAEA3E56D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC306420B81
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4289E264A6E;
	Thu, 20 Feb 2025 19:58:06 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F655214814;
	Thu, 20 Feb 2025 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081485; cv=none; b=rkJ3wEXVF+7r47KruXxGlKA5PeATzqCg4HnBMEDFAvqhYrdDvlOdPQfxHcNSEG7b8LpMeDVSuNF5dEIKg7RSBlWb4MR6/QvFQr/tQHifL3z7nFMgLc8Ii4SKXB3DC/1CGr/a3hST+90m8r0rn+/jz8Iqe+Hmi+1fo1m69d0rKWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081485; c=relaxed/simple;
	bh=q4xMIrlT7iDF4ybjBQddUpy/XmtWWTzJeGWLMdPlYkg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TLiNR1cx/fHIy1e3yXH+Z3L2SWMoZy3po7n5puMtUDVRW2PFQlrSMcgnr4SKW58Pg8vO3voGZzIurI+eBy7CshG+s78EtqFyb89M50EhqGKvO6VkYRwruidHhpbZltNVJvhr9+lpE1sw2iFBZV8p0zyd8MbDUKkpoaX90DmLCtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 4C1F192009C; Thu, 20 Feb 2025 20:57:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 45D1192009B;
	Thu, 20 Feb 2025 19:57:56 +0000 (GMT)
Date: Thu, 20 Feb 2025 19:57:56 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Matt Turner <mattst88@gmail.com>
cc: Richard Henderson <richard.henderson@linaro.org>, 
    Ivan Kokshaysky <ink@unseen.parts>, Arnd Bergmann <arnd@arndb.de>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Magnus Lindholm <linmag7@gmail.com>, 
    "Paul E. McKenney" <paulmck@kernel.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Al Viro <viro@zeniv.linux.org.uk>, linux-alpha@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alpha: Emulate unaligned LDx_L/STx_C for data
 consistency
In-Reply-To: <CAEdQ38FX4M1hKMgmNJD7s_eVa4-_J6e9+xCqTw653wbw8BNPWw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2502201951510.65342@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2502181912230.65342@angie.orcam.me.uk> <CAEdQ38GUr2_0rCiN6GxE8rk6ex5m-Y5do=QdgKi-hb=1jMGj-w@mail.gmail.com> <CAEdQ38FX4M1hKMgmNJD7s_eVa4-_J6e9+xCqTw653wbw8BNPWw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 20 Feb 2025, Matt Turner wrote:

> > On Wed, Feb 19, 2025 at 7:46 AM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
> > >  #define OP_INT_MASK    ( 1L << 0x28 | 1L << 0x2c   /* ldl stl */       \
> > > +                       | 1L << 0x2a | 1L << 0x2e   /* ldl_l stl_c */   \
> > >                         | 1L << 0x29 | 1L << 0x2d   /* ldq stq */       \
> > > +                       | 1L << 0x2b | 1L << 0x2f   /* ldq_l stq_c */   \
> > >                         | 1L << 0x0c | 1L << 0x0d   /* ldwu stw */      \
> > >                         | 1L << 0x0a | 1L << 0x0e ) /* ldbu stb */
> > >
> > >  #define OP_WRITE_MASK  ( 1L << 0x26 | 1L << 0x27   /* sts stt */       \
> > >                         | 1L << 0x2c | 1L << 0x2d   /* stl stq */       \
> > > +                       | 1L << 0x2e | 1L << 0x2d   /* stl_c stq_c */   \
> >
> > stq_c should be 0x2f, not 0x2d. Looks like a copy-n-paste mistake.
> 
> The good news is that OP_WRITE_MASK appears to be unused going all the
> way back to the import into git, so this doesn't indicate a problem
> with any of the testing that's been done.

 Good catch, thank you, and I guess the lack of use is why things haven't 
broken.  I'll make a preparatory change in v2 and remove this macro then.

 FWIW it came with 2.1.36, already unused, so presumably a leftover from a 
WIP version.

 I'll fix the typo in the description as well, thank you.

  Maciej

