Return-Path: <linux-kernel+bounces-238206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B6C9246C3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879A41F24146
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335841C232A;
	Tue,  2 Jul 2024 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItL1MjS7"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D255A1C005A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943097; cv=none; b=O3wBMjqPSOEdaaknbLt/C98zc8kLUADyikRAIPNY32XSYpgMhcn+zFhb2g+dvdWDiOmxi/jZnb5TKsobCdiaIXtCvkT+s6byRmofxvlMSL1cxe4rJYmMgXGyI0JJ8VM6zIKttka6PXQYELWrZQ7+1TGSfPZZtEFgBu+ePjlT9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943097; c=relaxed/simple;
	bh=6GV0ZhDNGPCuwYUPJDb43qoIpqlccrEfWt2pjGeAkCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSkTp5u6hKeM6gvvPLaYIKy9NQLJUmj4NPsbJaMn4Eo5jHHwuHRQVHDjLRX7ic2+pc/VosMWZn2BAzJKAivWFL/9cQpK+tBcJH5xzKlMH+qRU08sq9PDjYGiCM6yVWZkKuj8ob6h9vi5zt2HY3HhMUZZDPdBY/mwN97S5EZ64Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItL1MjS7; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a751ed17b1eso482003866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 10:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719943094; x=1720547894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GV0ZhDNGPCuwYUPJDb43qoIpqlccrEfWt2pjGeAkCk=;
        b=ItL1MjS7WKvLAHUYEz5EjOVOuwL+cbR5wljw5gI+oX7XEMbBUBrRKuF9c5iNWJZ9Ve
         pU9PAzPYp8+6fVAPbGjr0WwpLNGPxGpwDKDHn26lRx1866Q7jiPaBt3+X35r0E4KD80Y
         8M5EM8d/1D5ih5rr7DunMrFhuz48yXw5tuRQy4ANLtH/5DC8KGmFEzDLkwTaxNYKSgTA
         KNmmCeUtytw8rAIhKjwphhvz5Ru8sYLhgb02bMoGvkAMbtBbnUGUhMWrL9LJBIiYwR97
         IFGLYGRkh/S91YFpYDNYwGtQViMLWX9rMsTRy5kDiQvJjFwMcxdfeekbyk+waOGxWCyj
         roJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719943094; x=1720547894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GV0ZhDNGPCuwYUPJDb43qoIpqlccrEfWt2pjGeAkCk=;
        b=WXK2kpbRsGs9hktXPPYGYCThsGGqyW//qzCK3yUMalWwJVzIAMKCIrfKjsP/zVjuSg
         uTHj0Ux8jYN6q5CMm1iBd7FvzeZ7WBFK28DI3Amg93NyK+lRDy5ARm6V7DkwEN5r+XB1
         EDuI79aw2DJ/rj0gMk68MDel1uZQ/bbSuT1+HpSLwTLOcP+YtzY9EYAKR287lG+z9BWo
         lZwHXWPituXlEQg4FtiSrqwMUwZUSHLOL/R6ylo3KBAsMLmrHcOz4tmmfr3ErBbmx0F7
         DRMzwwCGJrbiRNaicsJIQgxWPMuT9JTwiN7myZqdf1XCOVLjRTGDAprX4RvArctuJrDP
         S5gw==
X-Forwarded-Encrypted: i=1; AJvYcCVP06Kdcpmnnl92CI0/Ka3V8k1e3JE3c8nih7Fb5Ko8T24HLD5UyS5e7NqehPHilg5Sh5FTAIucxgbm/BO2GKI64O05qW7ASSQ04C4d
X-Gm-Message-State: AOJu0YyKILbl5TpG6LzexLIpMPHrUZO3WVc0YTjQAhUayzv7ogmDrjQL
	jG5IXmlhyXaE34fNz6z1QmcZuq9vge4Gha7t9gwuFK25IGjoeTyEo9V9nrWhqMFBiBRd/RpFLN6
	iZ1wEHsuZAsUnvwGSdpbHVzdvScvNjA==
X-Google-Smtp-Source: AGHT+IHI8nHlXGtLgZucq/ZQPSk2r2VMZ8lQcnPCPPR3PyRgxYqNVt/2Qu+XeyFvQ5tUdULGlIastBJNp96WssLMxB8=
X-Received: by 2002:a17:906:5acb:b0:a6f:c24a:721e with SMTP id
 a640c23a62f3a-a7513935e17mr752283766b.30.1719943094018; Tue, 02 Jul 2024
 10:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406270912.633e6c61-oliver.sang@intel.com> <lv7ykdnn2nrci3orajf7ev64afxqdw2d65bcpu2mfaqbkvv4ke@hzxat7utjnvx>
 <vgg45kxk2fiyznm44w2saz3qjiwrjp3spvpswsl4ovd2jl5c5g@54dlbd4kdlh4>
 <CAHk-=wgnDSS7yqNbQQ9R6Zt7gzg6SKs6myW1AfkvhApXKgUg4A@mail.gmail.com>
 <CAGudoHGuTP-nv=zwXdQs38OEqb=BD=i-vA-9xjZ0UOyvWuXP_w@mail.gmail.com>
 <CAHk-=wgVzKtRnvDXAzueJTbgfo1o12Lw6DH97PzRe1cGA_b1oA@mail.gmail.com> <CAGudoHH_z1a6MX8Z8Cqbz-jDTUoAjoxdV9KrQ6yvUkNszXO5aw@mail.gmail.com>
In-Reply-To: <CAGudoHH_z1a6MX8Z8Cqbz-jDTUoAjoxdV9KrQ6yvUkNszXO5aw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 2 Jul 2024 19:58:02 +0200
Message-ID: <CAGudoHHg-T+ZOTm0fSpW0Hztfxn=fpfnksz5Q3=3YeCeEPo7LQ@mail.gmail.com>
Subject: Re: [linux-next:master] [lockref] d042dae6ad: unixbench.throughput
 -33.7% regression
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 7:46=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On Tue, Jul 2, 2024 at 7:28=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, 2 Jul 2024 at 10:03, Mateusz Guzik <mjguzik@gmail.com> wrote:
> > >
> > > I was thinking a different approach.
> > >
> > > A lookup variant which resolves everything and returns the dentry + a=
n
> > > information whether this is rcu mode.
> >
> > That would work equally.
> >
> > But the end result ends up being very similar: you need to hook into
> > that final complete_walk() -> try_to_unlazy() -> legitimize_path() and
> > check a flag whether you actually then do "get_lockref_or_dead()" or
> > not.
> >
>
> Ye, the magic routine to validate if you can pretend the ref was taken
> would wrap it.
>
> > It really *shouldn't* be too bad, but this is just so subtle code that
> > it just takes a lot of care. Even if the patch itself ends up not
> > necessarily being very large.
> >
> > As mentioned, I've looked at it, but it always ended up being _just_
> > scary enough that I never really started doing it.
> >
>
> I implemented something like this as a demo in FreeBSD few years back,
> it did not blow up at least. The work did not get committed though
> because I could not be arsed to productize it.
>
> tbf if anything the only shady things here that I see is that stat et
> al do their work without any locks held nor seqc verification in
> current kernel.
>
> In FreeBSD this was operating directly in vnodes (here one can pretend
> it's inodes). In that system I added sequence counters to the vnode
> itself and any state change like write, setattr, unlink or whatever
> would bump it. Then something like stat could safely read whatever it
> wants in a lockless manner with the final check for maching seqc
> indicating nothing changed.
>
> Not having a "someone is messing with the inode" indicator (only with
> a dentry) in Linux is definitely worrisome when pushing RCU further,
> if that's what you meant.
>
> Again, I'm going to poke around if only for kicks when I find the time
> and we will see what happens.

Suppose the rcu fast path lookup reads the dentry seqc, then does all
the legitimize_mnt and other work. Everything, except modifying the
lockref. The caller is given a mnt to put (per-cpu scalable), dentry
seqc read before any of the path validation and an indication this is
rcu.

Then after whatever is done if the seqc still matches this is the same
as if there was lockref get/put around it.

The only worry is pointers suddenly going NULL or similar as
dentry/inode is looked at. To be worked out on per-syscall basis.

Unless I'm missing something.
--=20
Mateusz Guzik <mjguzik gmail.com>

