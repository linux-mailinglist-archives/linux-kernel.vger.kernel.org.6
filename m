Return-Path: <linux-kernel+bounces-238195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF899246A1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F400A281B59
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96421BE873;
	Tue,  2 Jul 2024 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z53o8gOP"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E401BB6B0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719942415; cv=none; b=UoRDuOJ49R6gnVMxsjhnlj1/ew5+wSiWBtKCwoLpPXhTWW0xU2PEsx/d7u+5/cpqPniUg0BIyTHF19sNKkAf54fBT8LPR0yDxrskqPMMc6Z8a4jjG19LWql1AFq30VZm6WpURDj7QESnuryNKZ8UkL7SlI8WgLAZ65+6CnETDL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719942415; c=relaxed/simple;
	bh=I9LudFqvhzywM8+PbU1gzhtr4RCksBJHHLnpxcJPyI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHKNlrLURseo0shPMjs8AIcfNXT/yq2A66kdAOWhWgxWWaG0kxJJPgt+4gEZN8j2UFYXUWpQgFEIXgL+4SOFk88Qpby6wDWmuLQVIsqLS+BL2VQOngmzHpFH6nQTHiKR+m5zbX7lNZOsj6aex/Dd9u+8oUfOs1EEDYiVFA1x0qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z53o8gOP; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52e93d1432fso366445e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 10:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719942412; x=1720547212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9LudFqvhzywM8+PbU1gzhtr4RCksBJHHLnpxcJPyI4=;
        b=Z53o8gOPWdn3XAn/YRSoWGzifIL7Un6qj2KMqJD2f0RzyzHJ9YVqhRObI+93SflC/X
         MtHKko9oTYQuPo8y3QAi/7lN2QJgmne1QflXYIkkoLZfDaZTemeM5fPZgiGLB7vNLWzW
         Jt/sHOF6LraXSfD3CZEX6mU2cq/SkV7Vkbxu8QR5LR9XtSNokpFR0NjOwNoLpaq1aitE
         wyEEKBf4goDdWCDzuJ4+hghffb7qt6nScJTK0sInOE4rG/vMhsLcuoRSKUvHru+l59o7
         T2yj6AuiZzh7ji4Nq0kVxHxJv9QrpEYfQCFb9C8qKd9JcVqtG9YJHVXAKK/AqYs+Aw/m
         yQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719942412; x=1720547212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9LudFqvhzywM8+PbU1gzhtr4RCksBJHHLnpxcJPyI4=;
        b=RndA4x/nRJQofedLCiXFX0QvmCeJ2kU2AGx9AIuVMek7z1/7Fhb5ocDDR83fRoP0i4
         wY5Ba47f7l2DWYlJiTT2f7CSRCbGUM1rvaV4i0k8pPPB6ZN9PEs+LopAYCjN20D3wHSv
         ZFpcH70g6S9cayOl0+h5DuZR8BSGzTRwCfHraj3n110RPgsHDQvWsqnEaZ7hDkwnWRGI
         xIGhD43P0RJQyR//fJ5YQ53SuQVI4MoLypJ5VslIMpiDpgVlw5VcKqKIK5OakyB+QgA3
         c1IdpKUe8LKDEeCf1CkWfWdirLvbYaa+D6lmInQ8hOYTGjET0pR2YpS4+IYu1NxkKXhq
         bFow==
X-Forwarded-Encrypted: i=1; AJvYcCWvpQVj/OpsPeiyVPxEK3wZGIPYSchYwrijuOyMkYdUAac+/8H30+Av+Hm4tc3j3yRssTgbQCRxS6Fl1m7dDGN58eM7ZY7tPQ2571sC
X-Gm-Message-State: AOJu0YwGm6RKzxDJUFaphT3aSjy4I5PgA93cJ6rSy83OSwlB0ERg7tBF
	5fK8xA9Hry9wNVlOF7DNPTInw+Z17AT3kppickHP/zaW4tevJrWaBNPx1AzvJqWcaB/Iuzfu4e+
	mNOT0iz8otq+a9VYkHJDd/3aUP6g=
X-Google-Smtp-Source: AGHT+IEBbZsL301fTpokOmoMZTiPUizu1JrFyQ0P6YdSWvW3tyH2OnxtLZJKdilNRvkgjMEV5fLXKoBYn3fajVYprKY=
X-Received: by 2002:a05:6512:234a:b0:52e:9471:e54d with SMTP id
 2adb3069b0e04-52e9471e73dmr138254e87.65.1719942411502; Tue, 02 Jul 2024
 10:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406270912.633e6c61-oliver.sang@intel.com> <lv7ykdnn2nrci3orajf7ev64afxqdw2d65bcpu2mfaqbkvv4ke@hzxat7utjnvx>
 <vgg45kxk2fiyznm44w2saz3qjiwrjp3spvpswsl4ovd2jl5c5g@54dlbd4kdlh4>
 <CAHk-=wgnDSS7yqNbQQ9R6Zt7gzg6SKs6myW1AfkvhApXKgUg4A@mail.gmail.com>
 <CAGudoHGuTP-nv=zwXdQs38OEqb=BD=i-vA-9xjZ0UOyvWuXP_w@mail.gmail.com> <CAHk-=wgVzKtRnvDXAzueJTbgfo1o12Lw6DH97PzRe1cGA_b1oA@mail.gmail.com>
In-Reply-To: <CAHk-=wgVzKtRnvDXAzueJTbgfo1o12Lw6DH97PzRe1cGA_b1oA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 2 Jul 2024 19:46:39 +0200
Message-ID: <CAGudoHH_z1a6MX8Z8Cqbz-jDTUoAjoxdV9KrQ6yvUkNszXO5aw@mail.gmail.com>
Subject: Re: [linux-next:master] [lockref] d042dae6ad: unixbench.throughput
 -33.7% regression
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 7:28=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 2 Jul 2024 at 10:03, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > I was thinking a different approach.
> >
> > A lookup variant which resolves everything and returns the dentry + an
> > information whether this is rcu mode.
>
> That would work equally.
>
> But the end result ends up being very similar: you need to hook into
> that final complete_walk() -> try_to_unlazy() -> legitimize_path() and
> check a flag whether you actually then do "get_lockref_or_dead()" or
> not.
>

Ye, the magic routine to validate if you can pretend the ref was taken
would wrap it.

> It really *shouldn't* be too bad, but this is just so subtle code that
> it just takes a lot of care. Even if the patch itself ends up not
> necessarily being very large.
>
> As mentioned, I've looked at it, but it always ended up being _just_
> scary enough that I never really started doing it.
>

I implemented something like this as a demo in FreeBSD few years back,
it did not blow up at least. The work did not get committed though
because I could not be arsed to productize it.

tbf if anything the only shady things here that I see is that stat et
al do their work without any locks held nor seqc verification in
current kernel.

In FreeBSD this was operating directly in vnodes (here one can pretend
it's inodes). In that system I added sequence counters to the vnode
itself and any state change like write, setattr, unlink or whatever
would bump it. Then something like stat could safely read whatever it
wants in a lockless manner with the final check for maching seqc
indicating nothing changed.

Not having a "someone is messing with the inode" indicator (only with
a dentry) in Linux is definitely worrisome when pushing RCU further,
if that's what you meant.

Again, I'm going to poke around if only for kicks when I find the time
and we will see what happens.
--=20
Mateusz Guzik <mjguzik gmail.com>

