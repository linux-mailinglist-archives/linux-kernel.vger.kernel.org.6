Return-Path: <linux-kernel+bounces-434622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9329E690D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8691882BBD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36121DF742;
	Fri,  6 Dec 2024 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DI24DCuB"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BF51D47A2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474147; cv=none; b=F/mUhmfx7oArl0eVxJMSKPej11AgVOiM1Fu/f+d8eRmQo7r2HPrSybJ2//KhaFP6DgAD6uxZqqpE0pd4mAEDifo8A0iaDFvvUP4ZTveB2nsFMGZH1jcHjDxkS0+ijouoo+DXH9o1WP8v7B6WthM7W4lqgQ8TVdRpmawmYbhdEKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474147; c=relaxed/simple;
	bh=tyV3aeBb3H+L8vka8fd6IfbEidjXxk9uSvKPms+gNNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYJy1PGE55YCDN6TGb7QCeL9LRdh3UEa6y0H/WGAhUuuCECTfhSfaIwZN4n9xYXuE5f+fzMMm3BZE6e3GXbX/IfqN1tofD1r9sGoOeTiXgVj4XtSHG+LCchLxjcVfaeY743RTwem13+gQcpaw9H0vGHlXsYtgWeVZLre3YsBGE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DI24DCuB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa6332dde13so169119666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 00:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733474144; x=1734078944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyV3aeBb3H+L8vka8fd6IfbEidjXxk9uSvKPms+gNNQ=;
        b=DI24DCuB86ioTqscK73N24J7QlrDC4h/BjnR6/r0uxJiuFcXTuw1yNqNXnn9PeEroo
         OYSQeCsQFSOIj3SjS77n1669pUXfLl1vXFNXTJnRbU3CvyROaBd4Oi8X38vuVseouqsj
         iWXr+oP+2Lj44L1UAml/4gaue+zCvr5esw7orUNGvMfRCQzuqasKuqV9sCvPgIiTZ+58
         /ZaGRvCSOovaHpmwU7Azt2dlEOKoFL7Bxor/p1D+j/NcPaja6D6vWyoisF4GPIjAoO5n
         a34WuPvWr2Htl2PbiN+u5LspgIYRKy6vLVaqc+mK5WSSfgbkh7fxHB2vGaleZIOMgtQO
         n3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733474144; x=1734078944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyV3aeBb3H+L8vka8fd6IfbEidjXxk9uSvKPms+gNNQ=;
        b=g/NT2hCmCj6Jzzxr0pJseQe5AElDnkXQEOP/UUeP1A0V12+fsEi2OjM2YZupsiso4o
         0KBHsLz8fvkULMyElCOLoZI22krJKrf0WYn0YTbw2MXNRizVBIshxuIo42MFGbrJF4By
         QUeNl8XoflDd3lCrjOu4s2Xx6ooiiaDVCvvycm/f3dw84FALHjGAf2Gr4oM8js4j8i90
         1B51j2L9v34sBo630t479rTlNOBOEpx1PZhPit+vEeBYf7T9EtbiD3TNfGooG2cthfZa
         8i/NwdCiuNd/EE2Uooq5/sKsh8vFXGwiEICWh/F3O0zzztQF9ao2gGY3yeqVG94Wxy2+
         SZfg==
X-Forwarded-Encrypted: i=1; AJvYcCWmlaCpyAylAshyqRU5hYu2tGfUVr/JkagV87BxhsJsA1/pAsDOGgdvhi3xkgo2opqnz0WQE4YyrLCyHpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFy7d3sGkIjb4EvBucsWGAliEDq48jOgdyv3YsMiczonPgRal
	lCKuMgZsB0gXoNqHs0qjB9qNjk+FIf2TytlKJ5HbmBnhH2Ce5c6PNnr0J7CiPQZsYUZW2VOm1eB
	noaGzbeYl9BqABQJ0i+s07AkE9IcMAnlpIZYH
X-Gm-Gg: ASbGncsIZTVRWsnDWvU3Taa+974ofBbtFkhwlizMMkZp6SBAkIwwjdjNF283NBM9uS4
	87OACvixWFkZ+8v/Ql3py9ehGhX1EtX4=
X-Google-Smtp-Source: AGHT+IHYWCLKzl+1ai5/0VY/dsR4Y37O8FXJK5ZxL4AViOO5nHkFxdd2BFCBbttLt2LfJWz6rkbcIMRAYDFqMCkFPyw=
X-Received: by 2002:a17:907:9508:b0:a9a:1a6a:b5f5 with SMTP id
 a640c23a62f3a-aa63a2c7029mr148739366b.56.1733474143412; Fri, 06 Dec 2024
 00:35:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
 <20241203081247.1533534-1-youngmin.nam@samsung.com> <CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
 <CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
 <20241203181839.7d0ed41c@kernel.org> <Z0/O1ivIwiVVNRf0@perf>
 <CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com> <Z1KRaD78T3FMffuX@perf>
In-Reply-To: <Z1KRaD78T3FMffuX@perf>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 6 Dec 2024 09:35:32 +0100
Message-ID: <CANn89iKOC9busc9G_akT=H45FvfVjWm97gmCyj=s7_zYJ43T3w@mail.gmail.com>
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
To: Youngmin Nam <youngmin.nam@samsung.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	dujeong.lee@samsung.com, guo88.liu@samsung.com, yiwang.cai@samsung.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, joonki.min@samsung.com, 
	hajun.sung@samsung.com, d7271.choe@samsung.com, sw.ju@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 6:50=E2=80=AFAM Youngmin Nam <youngmin.nam@samsung.c=
om> wrote:
>
> On Wed, Dec 04, 2024 at 08:13:33AM +0100, Eric Dumazet wrote:
> > On Wed, Dec 4, 2024 at 4:35=E2=80=AFAM Youngmin Nam <youngmin.nam@samsu=
ng.com> wrote:
> > >
> > > On Tue, Dec 03, 2024 at 06:18:39PM -0800, Jakub Kicinski wrote:
> > > > On Tue, 3 Dec 2024 10:34:46 -0500 Neal Cardwell wrote:
> > > > > > I have not seen these warnings firing. Neal, have you seen this=
 in the past ?
> > > > >
> > > > > I can't recall seeing these warnings over the past 5 years or so,=
 and
> > > > > (from checking our monitoring) they don't seem to be firing in ou=
r
> > > > > fleet recently.
> > > >
> > > > FWIW I see this at Meta on 5.12 kernels, but nothing since.
> > > > Could be that one of our workloads is pinned to 5.12.
> > > > Youngmin, what's the newest kernel you can repro this on?
> > > >
> > > Hi Jakub.
> > > Thank you for taking an interest in this issue.
> > >
> > > We've seen this issue since 5.15 kernel.
> > > Now, we can see this on 6.6 kernel which is the newest kernel we are =
running.
> >
> > The fact that we are processing ACK packets after the write queue has
> > been purged would be a serious bug.
> >
> > Thus the WARN() makes sense to us.
> >
> > It would be easy to build a packetdrill test. Please do so, then we
> > can fix the root cause.
> >
> > Thank you !
> >
>
> Hi Eric.
>
> Unfortunately, we are not familiar with the Packetdrill test.
> Refering to the official website on Github, I tried to install it on my d=
evice.
>
> Here is what I did on my local machine.
>
> $ mkdir packetdrill
> $ cd packetdrill
> $ git clone https://github.com/google/packetdrill.git .
> $ cd gtests/net/packetdrill/
> $./configure
> $ make CC=3D/home/youngmin/Downloads/arm-gnu-toolchain-13.3.rel1-x86_64-a=
arch64-none-linux-gnu/bin/aarch64-none-linux-gnu-gcc
>
> $ adb root
> $ adb push packetdrill /data/
> $ adb shell
>
> And here is what I did on my device
>
> erd9955:/data/packetdrill/gtests/net # ./packetdrill/run_all.py -S -v -L =
-l tcp/
> /system/bin/sh: ./packetdrill/run_all.py: No such file or directory
>
> I'm not sure if this procedure is correct.
> Could you help us run the Packetdrill on an Android device ?

packetdrill can run anywhere, for instance on your laptop, no need to
compile / install it on Android

Then you can run single test like

# packetdrill gtests/net/tcp/sack/sack-route-refresh-ip-tos.pkt

