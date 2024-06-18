Return-Path: <linux-kernel+bounces-219645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9723C90D73A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16FC7B30EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF9D15B120;
	Tue, 18 Jun 2024 14:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mBpQKWsK"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D3315B12E
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721757; cv=none; b=Pmaf9WJwt6GhWSQvOeAsD6oN614E4xpuPcslr4UvKKjl+FNBU8Va7+VQX+/UqxF1zRzzmXNXSxESXwGlYuKb2Q3QcszHLgH9ZUxXxUK/ARXcTmC1M13HHettG41+G/t2Wmxz/1nuTGGaGIg58uoyId3ub4Zj+0g6CqDWc37qiTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721757; c=relaxed/simple;
	bh=aQI0Bglp7m6AzomkjhrVyjNcylcXNCxXHrGQHRVGQyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFsv+P8wQq/T5h1bOnMdH5YlTq3D+yrSB3lauH0K9Rj2r18AN+wQnNmw/cCZUvFdWCJ2LpvEoX47o+lTP+uiHDzxKtK7WozEiDOKKubFwcVqwUhORcMy5GzNDkvfQTnEYrSv1qRW4W/WMY9kpd8orJ9snwQYKv6CJDF++twIOJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mBpQKWsK; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7955f3d4516so574040085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718721753; x=1719326553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yu4vXVj4mN6mk3P8b69LMGaDAOhCuHbfRYytMDO4e7I=;
        b=mBpQKWsK2uSyUXrv++yFOXWkZQnzI1E8RdSf8Sretuy00mzYPlbI2+shpusH/KA3Wy
         /Q7tdTGyyaGxvPOwBGbPD8CimjIP7a7R0MbUqBqYsRl03ftsf4FU5Ys/wMMf8vQYZYLl
         9Ev4kqL/y4I41azXTHw36L/mpJ8g4Bmo6oRXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718721753; x=1719326553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yu4vXVj4mN6mk3P8b69LMGaDAOhCuHbfRYytMDO4e7I=;
        b=GNXX6MulC9k6vxAM8XYqN/0uKI0yCG9GXt7bv+b7WTWxOBO1EoJb9oRfpCS0OcKloF
         3sqUnYttrkr3D6jYjC1qNOixj0Kkh3u7O16zdA1Yg2mHhXUAe+2Dbgwbd0Mrp7PVHgth
         I4F8voTlnfc/g0O4bed4pywsjAzjDLWfpLo/uZmq4skpACLsqN8Z8ub6YIxlL7rnfDjF
         myj37C28cA1pX5gWPjrGbtEeac6RDasuRpovUFmWtHnUeo19w7IyHcTNBUrepoNLsdeR
         l8b0cV+Tr6b1opYFrewoAeFLzTEPmglIMhbR78l8cuUE2lIdJfI5ZRKZbjfo+HwsqGqK
         pniA==
X-Forwarded-Encrypted: i=1; AJvYcCUFZaBr7pr1TaOYpJdCjV8ZpYqKgpEBsUlB0p9AIXb3859BVxjN9hi20MCHvSZ5vYFtbmX/I3LscJHFkckDPvF9ndl+h3ti6YktptW5
X-Gm-Message-State: AOJu0YypDhNIq1bWoYwSBERPi2GO09uYd5pYnvA9ffhJXLO0olbeVMfW
	qM9LK8ZP5pm30OQGwph+l4lybskCrX6Xn0y/+a7aqYZ8WF7Tj03efgLsDlx8x4kclisG/Fredxg
	=
X-Google-Smtp-Source: AGHT+IHHJnZ+dRYX8Snd6YsbLnQJ5p14+1qKZeAfbrcvdPWCpccPrXIMSmAwyrDZMcot2R4r6SEOoA==
X-Received: by 2002:a05:620a:191f:b0:795:5de4:6625 with SMTP id af79cd13be357-79bb343fademr16249485a.5.1718721752847;
        Tue, 18 Jun 2024 07:42:32 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe4f35dsm525220085a.122.2024.06.18.07.42.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 07:42:32 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-443586c2091so473831cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:42:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHtbdCF6+gNcZDfjV+okNKNXWjXu7F8gMl5ZFiJtod1fOT56w0sxpcFJqS0W6G+aPXuEBMp9ccpylXCYhqMwGb2jUSqGWTUKcu+gK/
X-Received: by 2002:a05:622a:1113:b0:441:53bc:4f8f with SMTP id
 d75a77b69052e-4449daab6b7mr3324501cf.27.1718721751289; Tue, 18 Jun 2024
 07:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618003546.4144638-1-dianders@chromium.org>
 <20240617173426.2.I5621f286f5131c84ac71a212508ba1467ac443f2@changeid> <20240618112402.GB11330@aspen.lan>
In-Reply-To: <20240618112402.GB11330@aspen.lan>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 18 Jun 2024 07:42:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WjQjGgGeH5BiC7cc93OVuka+Fx+0BVHjdem2px_N=Y=g@mail.gmail.com>
Message-ID: <CAD=FV=WjQjGgGeH5BiC7cc93OVuka+Fx+0BVHjdem2px_N=Y=g@mail.gmail.com>
Subject: Re: [PATCH 02/13] kdb: Document the various "md" commands better
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Jason Wessel <jason.wessel@windriver.com>, 
	Thorsten Blum <thorsten.blum@toblux.com>, Yuran Pereira <yuran.pereira@hotmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 18, 2024 at 4:24=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Jun 17, 2024 at 05:34:36PM -0700, Douglas Anderson wrote:
> > The documentation for the variouis "md" commands was inconsistent
> > about documenting the command arguments. It was also hard to figure
> > out what the differences between the "phys", "raw", and "symbolic"
> > versions was.
> >
> > Update the help strings to make things more obvious.
> >
> > As part of this, add "bogus" commands to the table for "mdW" and
> > "mdWcN" so we don't have to obscurely reference them in the normal
> > "md" help. These bogus commands don't really hurt since kdb_md()
> > validates argv[0] enough.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  kernel/debug/kdb/kdb_main.c | 39 ++++++++++++++++++++++---------------
> >  1 file changed, 23 insertions(+), 16 deletions(-)
> >
> > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > index cbeb203785b4..47e037c3c002 100644
> > --- a/kernel/debug/kdb/kdb_main.c
> > +++ b/kernel/debug/kdb/kdb_main.c
> > @@ -1516,14 +1516,9 @@ static int kdb_mdr(unsigned long addr, unsigned =
int count)
> >  }
> >
> >  /*
> > - * kdb_md - This function implements the 'md', 'md1', 'md2', 'md4',
> > - *   'md8' 'mdr' and 'mds' commands.
> > + * kdb_md - This function implements the guts of the various 'md' comm=
ands.
> >   *
> > - *   md|mds  [<addr arg> [<line count> [<radix>]]]
> > - *   mdWcN   [<addr arg> [<line count> [<radix>]]]
> > - *           where W =3D is the width (1, 2, 4 or 8) and N is the coun=
t.
> > - *           for eg., md1c20 reads 20 bytes, 1 at a time.
> > - *   mdr  <addr arg>,<byte count>
> > + * See the kdb help for syntax.
> >   */
> >  static void kdb_md_line(const char *fmtstr, unsigned long addr,
> >                       int symbolic, int nosect, int bytesperword,
> > @@ -2677,26 +2672,38 @@ EXPORT_SYMBOL_GPL(kdb_unregister);
> >  static kdbtab_t maintab[] =3D {
> >       {       .name =3D "md",
> >               .func =3D kdb_md,
> > -             .usage =3D "<vaddr>",
> > -             .help =3D "Display Memory Contents, also mdWcN, e.g. md8c=
1",
> > +             .usage =3D "<vaddr> [<lines> [<radix>]]",
> > +             .help =3D "Display RAM using BYTESPERWORD; show MDCOUNT l=
ines",
>
> I'd prefer "memory" over "RAM" because it's what the mnemonic is
> abbreviating. This applies to all of the below but I won't be adding a
> "same here" for all of them.
>
> Where we have to crush something to fit into one line we'd than have to
> break the pattern and choose from thing like:
>
> 1. Show memory
> 2. Display RAM
> 3. Display mem
>
> Personally I prefer #1 but could probably cope with #2.

I'm not dead set on RAM, but at least for me RAM was more clarifying.
Specifically when it said "memory" I always assumed it would take in
any memory address and when I first looked at this I tried to figure
out why memory addresses in the IO space didn't work with these
commands. I figured I was holding it wrong only to find out that the
commands specifically limit you to just the RAM range of memory
addresses.

That being said, I don't feel strongly so if you really like "memory"
I'll change it back.


> >               .flags =3D KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
> >       },
> > -     {       .name =3D "mdr",
> > +     {       .name =3D "mdW",
> >               .func =3D kdb_md,
> > -             .usage =3D "<vaddr> <bytes>",
> > -             .help =3D "Display Raw Memory",
> > +             .usage =3D "<vaddr> [<lines> [<radix>]]",
> > +             .help =3D "Display RAM using word size (W) of 1, 2, 4, or=
 8",
>
> We need an "e.g. md8" in here somewhere. Otherwise it is not at all
> obvious that W is a wildcard.
>
> I guess that alternatively you could also try naming the command with
> hint that W is a wild card (what happens if you register a command
> called md<W>?).
>
>
> > +             .flags =3D KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS,
> > +     },
> > +     {       .name =3D "mdWcN",
> > +             .func =3D kdb_md,
> > +             .usage =3D "<vaddr> [<lines> [<radix>]]",
> > +             .help =3D "Display RAM using word size (W); show N words"=
,
>
> Same here.

Sure, so:

.name =3D "md<W>",
.help =3D "Display RAM using word size 1, 2, 4, or 8; e.g. md8",

.name =3D "md<W>c<N>",
.help =3D "Display RAM using word size W; show N words; e.g. md4c6",

...or changing RAM to "memory" if you don't buy my argument above.

We're definitely ending up over the 80 character mark here, but I
assume that's OK. We were even before my change.

I'll assume that I don't need the "e.g." for all the followup (mdp,
mdi) variants introduced in later patches?


Random question: for the mdWcN variant, should I make specifying
<lines> illegal? It's pretty silly to let the user specify a word
count and then immediately override it. In that case, do I bump
"<radix>" to the 2nd argument or just don't allow "<radix>" for mdWcN?
That would need to be done in a later patch, obviously...

-Doug

