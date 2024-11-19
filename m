Return-Path: <linux-kernel+bounces-414773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBCE9D2D18
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568CF2817EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93621D2202;
	Tue, 19 Nov 2024 17:54:11 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E121D1F63;
	Tue, 19 Nov 2024 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038851; cv=none; b=MiRixee6cwHQnhdfKLlqtjVc/aXXSiN3T+F+qaAx6PAZwW0rKjKlf4ON9v9ti+ga3nwlkrup/g/8qg8pIPKMfIJuLphjxKIwNY+1FGfttqz5hwPi3qIRyaCj72WrcXVtbVf9MaEdcIAYszUEigtg1nQaXeQHaP/EImMM66ih+rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038851; c=relaxed/simple;
	bh=6oUYhmuUPQB+FQ4f9rBZXmpbu2nKEUV8PP/o3q4T4Y4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=to3/TMYs+wwC26VhWPV6aFUm3P4j2prNAvMr/xL4T9l8nu5qFGhhqbQvx2uJ6e58HTH/04ex5u5ZravtcaQc8g/NHgKROh3JsGPRRa7QBZeGzDhbww+YstG1tXv1R/JKcYfa853J/MNGbmulslMj4tHfvAHtUj2WxZt3NFXx4lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8B7F192009C; Tue, 19 Nov 2024 18:54:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 871ED92009B;
	Tue, 19 Nov 2024 17:54:00 +0000 (GMT)
Date: Tue, 19 Nov 2024 17:54:00 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: "Paul E. McKenney" <paulmck@kernel.org>, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
    Arnd Bergmann <arnd@kernel.org>, linux-alpha@vger.kernel.org, 
    Arnd Bergmann <arnd@arndb.de>, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
    Matt Turner <mattst88@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
    Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
    Michael Cree <mcree@orcon.net.nz>, Frank Scheiner <frank.scheiner@web.de>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
In-Reply-To: <alpine.DEB.2.21.2406302009050.43454@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2411191511110.10887@angie.orcam.me.uk>
References: <20240503081125.67990-1-arnd@kernel.org> <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de> <alpine.DEB.2.21.2405280041550.23854@angie.orcam.me.uk> <aa397ad5-a08a-48a1-a9c0-75cfd5f6a3a5@paulmck-laptop>
 <alpine.DEB.2.21.2405291432450.23854@angie.orcam.me.uk> <CAHk-=wi7WfDSfunEXmCqDnH+55gumjhDar-KO_=66ziuP33piw@mail.gmail.com> <alpine.DEB.2.21.2405302115130.23854@angie.orcam.me.uk> <CAHk-=whiH6g+T7+YWSYgAhJ9HsJ2bUUDJfLLo_Yhbi8CVgkHDg@mail.gmail.com>
 <alpine.DEB.2.21.2405310457060.23854@angie.orcam.me.uk> <CAHk-=wha2rH2UcTvHUYK+dNnP6UCDRkYM0atvw_GTP5Sz3OZrQ@mail.gmail.com> <alpine.DEB.2.21.2406302009050.43454@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 2 Jul 2024, Maciej W. Rozycki wrote:

> > >  Anyway, back to my point.  A feasible solution non-intrusive for Linux
> > > and low-overhead for GCC has been found.  I can expedite implementation
> > > and I'll see if I can regression-test it too, but I may have to rely on
> > > other people to complete it after all, as I haven't been prepared for this
> > > effort in the light of certain issues I have recently suffered from in my
> > > lab.
> > 
> > Yeah, if compiler support makes us not have to care, then I don't
> > think the difference between pre-BWX and BWX is going to matter much
> > for the kernel.
> > 
> > The real pain with alpha has been that it's special enough that it
> > affects non-alpha code, and BWX was one big piece of that.
> 
>  Understood, that's burden beyond justification for an obsolete legacy 
> platform.

 FTR a proposed implementation of the solution is now discussed here:
<https://inbox.sourceware.org/gcc-patches/alpine.DEB.2.21.2411141652300.9262@angie.orcam.me.uk/>.

  Maciej

