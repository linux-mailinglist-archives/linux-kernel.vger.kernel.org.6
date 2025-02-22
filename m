Return-Path: <linux-kernel+bounces-527490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547E0A40BCA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 22:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2131117EE3F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 21:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12F81EF0B4;
	Sat, 22 Feb 2025 21:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z9RG7vDV"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65990CA5A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740260816; cv=none; b=Gd85MUmNxxNqoTT/pkA5NVnJfPcs9/1c+IjwTG/E5ase4I6q7wjnGPpP/g7xxncwpxPBSOVq/oTvdvRIPh+l/XKwO1qBdHpKWXPx+rrRdkpXug0KkIGCuTIqmtuU2H7DDO+/otlZWl+quVfw1Gnc7yJ3JgmxjCF7wLxJNC1DxK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740260816; c=relaxed/simple;
	bh=R/cqKSeDckVDEF7yPpH+aIK1cWmoP4uCgucXOhuI4zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAYDMlJ7hDivnIXS312XwUQqEWwsxvpX7yJa5dwFkIiXQWU3IXTVaVqqY49/3XZLs6HYsJeIsra1ZBZU8fNZdBSOfQzo/AHCVVFprd0Mv/6NGXhnEsPSbA2sHqvM4hOx2e3qy6MhcIgrU6x0Fu7h3+6jzMxAqbNPZDkKeARGGPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z9RG7vDV; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abb90c20baeso427912866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 13:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740260812; x=1740865612; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TIAnEzzzjax0vkLbj+pBB4HtwVvgwKWI24/rmxYjENo=;
        b=Z9RG7vDVbLuMupBS2SR5QQ+Bw66i7T751C3ROFWiUue+FTSt7eMlgVdpqGBueiDXwh
         xUXu/rtV01xcR+rdnmtU2wl4hidhshqlz9SyBbONPo4s///a6zT717J3Bvsb3UoxZgqW
         irJavQiGiCFWAz93/AiO7u45ZCghvSBzvQq00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740260812; x=1740865612;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TIAnEzzzjax0vkLbj+pBB4HtwVvgwKWI24/rmxYjENo=;
        b=oQHj4Mov5BQQOcvbDZtpNVXp2qBz979kXwUujGjWtBnXBx1tQW04g5tXxtFhK03pvb
         uTUH12cxd6we+skQfSI5iqk2rbSX9fJP/LSugFSoh1I6VLHwBdrnOTtQKQrdPKrMqlOE
         ktCSLWSYp2xEyHcHwrNbtlVthwCwO3rddasbmm6rqj+pGOK79ngpFpTn6vOfBH9mkPt3
         AoQn61hE6I5O+HvnqcYQ+f+sMRH79D5ofw4SmjBBOpPhJbvy3BE2jdjcBFpinKfYrlWA
         1US5JoQTPUctmF0SMDtdW08xzDv3dlWLRYw4FxsPhcD97MlZJEk6T2+I0Ym9/n6LMUvr
         O3mw==
X-Forwarded-Encrypted: i=1; AJvYcCWkcF0xvTkYF0tdXcH/dpkH5qZjHkuQFLaZbt9Llc4B74oNUEMoASrdl8/VjG95C9/dAHkdSIkBqdtRyhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/A0U9pdOtwoTqtRoqoU8qYQcT/Yd/WOEulosTSdNi49vMA40o
	hKGKmF1SEWnAyeX2rehTIOy9+8RFcu436amGWDHXu98OjoO+vBVxAlOIsztWk/KsYt0xAD3C9kd
	K6Vs=
X-Gm-Gg: ASbGncsAsg3oxiykIb93jCpnupH8adNxUS5m5LfuzRNPX5IfyztnBkelI6FLyCtrBli
	ehM5iTztffgpGDV8VQcKBcOkCc0DOW4yxtkIw/ZwqqPtPjSOePlIJ94lA6G+E55CNCL6NK1JHGN
	NejZPq4TTaAM1yX619yXGbzfQTZL/L+nTW9GM2/LUR3iE2tDFda/bsd0iitpyHf6ztZQIq1Lqga
	oJfV1k0mJN0XvDWW7vXlDc8tLKUIgVaXTh2b1MDit3EQx7RZHwIBtR6jQGkeX6cWeSa4jatA707
	70UuJJ0OVYcSDE2njE7SvaQr+UupqYSy9bahGLj8sOstEYRziHVKqV1OXyLa3rdEtxvdCaEVN/p
	Z
X-Google-Smtp-Source: AGHT+IGh3bRilDRJPtYiOAZmi6vhScgs1DkpJT7iOSfQeQWu5f2qWePfuFv1c0icL/CZwk/SpiuzXw==
X-Received: by 2002:a17:907:c28:b0:ab7:bcc0:9050 with SMTP id a640c23a62f3a-abc0da301cfmr944583366b.27.1740260812420;
        Sat, 22 Feb 2025 13:46:52 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532802a1sm1912208566b.76.2025.02.22.13.46.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 13:46:51 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abbda4349e9so467159966b.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 13:46:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+eBD6XUy+rvogBD/k2+gTzQHwsQl4tfnzmIKAqwYczMpatM9gcTKSX839XhxKjXiiroU7DvMuzcxqnP4=@vger.kernel.org
X-Received: by 2002:a17:907:970c:b0:abb:d047:960b with SMTP id
 a640c23a62f3a-abc0d9885e7mr719250966b.4.1740260810677; Sat, 22 Feb 2025
 13:46:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <yuwkqfbunlymofpd4kpqmzpiwbxxxupyj57tl5hblf7vsvebhm@ljz6u26eg5ft>
 <6EFFB41B-9145-496E-8217-07AF404BE695@zytor.com> <c3spwcoq7j4fx5yg4l7njeiofhkaasbknze3byh4dl45yeacvr@rb6u6j5kz7oe>
In-Reply-To: <c3spwcoq7j4fx5yg4l7njeiofhkaasbknze3byh4dl45yeacvr@rb6u6j5kz7oe>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 22 Feb 2025 13:46:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi0UmOAhyDjOeCJcL7eEt+ygKnMqtx+RcHtzZGd7OY4Kw@mail.gmail.com>
X-Gm-Features: AWEUYZlfgH2FWGDgxF-FUknCaXkkoysm8XxdV5A68axeTzsJ2Kz9bsbxjCAZi30
Message-ID: <CAHk-=wi0UmOAhyDjOeCJcL7eEt+ygKnMqtx+RcHtzZGd7OY4Kw@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, 
	airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com, 
	ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Feb 2025 at 13:22, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Power hungry and prone to information leaks, though.

The power argument is bogus.

The fact is, high performance is <i>always</i> "inefficient". Anybody
who doesn't understand that doesn't understand reality.

And I very much say "reality". Because it has nothing to do with CPU
design, and everything to do with "that is how reality is".

Look at biology. Look at absolutely <i>any</i> other area of
technology. Are you a car nut? Performance cars are not efficient.

Efficiency comes at a very real cost in performance. It's basically a
fundamental rule of entropy, but if you want to call it anything else,
you can attribute it to me.

Being a high-performance warm-blooded mammal takes a lot of energy,
but only a complete nincompoop then takes that as a negative. You'd be
*ignorant* and stupid to make that argument.

But somehow when it comes to technology, people _do_ make that
argument, and other people take those clowns seriously. It boggles the
mind.

Being a snake is a _hell_ of a lot more "efficient". You might only
need to eat once a month. But you have to face the reality that that
particular form of efficiency comes at a very real cost, and saying
that being "cold-blooded" is more efficient than being a warm-blooded
mammal is in many ways a complete lie and is distorting the truth.

It's only more efficient within the narrow band where it works, and
only if you are willing to take the very real costs that come with it.

If you need performance in the general case, it's not at all more
efficient any more: it's dead.

Yes, good OoO takes power. But I claim - and history backs me up -
that it does so by outperforming the alternatives.

The people who try to claim anything else are deluded and wrong, and
are making arguments based on fever dreams and hopes and rose-tinted
glasses.

It wasn't all that long ago that the ARM people claimed that their
in-order cores were better because they were lower power and more
efficient. Guess what? When they needed higher performance, those
delusions stopped, and they don't make those stupid and ignorant
arguments any more. They still try to mumble about "little" cores, but
if you look at the undisputed industry leader in ARM cores (hint: it
starts with an 'A' and sounds like a fruit), even the "little" cores
are OoO.

The VLIW people have proclaimed the same efficiency advantages for
decades. I know. I was there (with Peter ;), and we tried. We were
very very wrong.

At some point you just have to face reality.

The vogue thing now is to talk about explicit parallelism, and just
taking lots of those lower-performance (but thus more "efficient" -
not really: they are just targeting a different performance envelope)
cores perform as well as OoO cores.

And that's _lovely_ if your load is actually that parallel and you
don't need a power-hungry cross-bar to make them all communicate very
closely.

So if you're a GPU - or, as we call them now: AI accelerators - you'd
be stupid to do anything else.

Don't believe the VLIW hype.  It's literally the snake of the CPU
world: it can be great in particular niches, but it's not some "answer
to efficiency". Keep it in your DSP's, and make your GPU's use a
metric shit-load of them, but don't think that being good at one thing
makes you somehow the solution in the general purpose computing model.

It's not like VLIW hasn't been around for many decades. And there's a
reason you don't see it in GP CPUs.

                Linus

