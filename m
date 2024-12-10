Return-Path: <linux-kernel+bounces-440245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6F89EBAA8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BF8D16669D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A7222688F;
	Tue, 10 Dec 2024 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P1RvnxuT"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2842E226862
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733861447; cv=none; b=AM3MNPzGXwh3GfcK/TjEZSCIha5kyL1esm4kidD++4grJ36bE8PflQCxpiVt/a8/UnUOml/f7CQDeI3mcWaCqfDUcdaN1/DzbEkmYkF5VtRPe6IZ0bEaMW0n/H1nVJBtWDk7S8FvrlxX2M5qdG4UCchwMP9v7ew9tbrfA5681FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733861447; c=relaxed/simple;
	bh=pgdam1Kba/SebTFx28LbifHH3hvl4vU9OMMR6CYA1NM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wd4JOCZjn5nz45ifkhm/l9hwgM6hkmlxsqrI4oqLMKtW3ZnW/N3KXI7V9g6jHKUcoRFAnAsPHr2xZQoOJ0zX4Og6TsHKR62rmaCYAwBcGMyLgyH3PXe5cyuIX9m5oynQx9gMKDc4qAT2n0Q/iAjI1lcZs/0YD7kK8pj3Z388TP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P1RvnxuT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a852bb6eso57395725e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733861444; x=1734466244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPtrTBQ90IaccJGz4IZBBGAyKUoeJEbJUQ/eUbyV1xI=;
        b=P1RvnxuTsPuSoziSzWcgekW5c/eTBAVX5Ssz7FLg+dqJ1No0tWYtXW8kQwiRUkq8Zk
         UPOruenuzd1mrOFJJZ0wNhF0QI/xcfUx50X7OAXxTL1IuUBsXXE3iK4BW9xgZz/8Vh/d
         IW8O0GLI/CuzfnS+qwLHeo+tzNzHMWm/H8W0XBeKPDpxBNXLPeYs+te5f0+JoxBj6KPL
         hgbTp/NoUM05Sb27IUfBhmGLQypFLuBRUIv0SpXEsXZ+5EDa7+o2t+YTWnKxg47oL/8Y
         hlRFGXb/QWut0wb6S/kF/po3Q1pNqmYwYnbX3sc5Lu/mbz022GXMpkELjmIpa7Nc80TS
         nVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733861444; x=1734466244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dPtrTBQ90IaccJGz4IZBBGAyKUoeJEbJUQ/eUbyV1xI=;
        b=ps0sfOLLjEQsgWV3XXSm8O8+rUnqOpxfGRDKsYnuFf722Ig2DC0lvVOaGHuJwV9umw
         2y9DPyrb6W1pVxCtYdzz7BlY5NNqoHSdq2jkokqop8XGR4YlD0fPr13NFIYbVRuip0mZ
         S0H0BCGamryJBWs3FFG6C5TMI9LVHcVfkw87+gyZ9u7uzDV+xqkUAupaz3i8WFNHfMtM
         rMuai6egeAEo24Vgu14Qwu97oIg7Hudnj5WUj8CBzz7kbPUDSkhU7fD51MbOo/tV1r2O
         IaYoiQ0dic7k5bejOZrUIp1F6z1V536nracE+Rv6JdmpLuHeCcyOXFLkFosZDHF+g/at
         TYlQ==
X-Gm-Message-State: AOJu0YylHin8x0vOee98xiwi61vhoqs1/KEaNrh7YVNk/ncPBfdTMLix
	CoO+vmiCeTQZuMBzh7I3+8XWRgNNY5TyyOkmf5sGEJVvQFZqEETdfK1+uQ1SyyMnpWBsP2eVbyd
	V3d5dp/zH91D7RwRXd6ymhCQ8ksBvn6r2CpnY
X-Gm-Gg: ASbGncsfEkS50ock5HGd3rLNFZiwfjFYAW2ifXD4XPWAW60kNE//599cglj44f4UsxB
	2U5p+xE80lVGQteVuoMxqfby/CHDAJ3Q+6w==
X-Google-Smtp-Source: AGHT+IHGL7TXNI6LOxLmu6eJ2gcaZqYF452DNRBUtOoXXHdNF4/wBcezYzQeBBhEKXAoCsOvAfsT+ItnwjJ7tRRFTy8=
X-Received: by 2002:a05:6000:1885:b0:385:ec89:2efd with SMTP id
 ffacd0b85a97d-3864ce9247bmr284150f8f.22.1733861444329; Tue, 10 Dec 2024
 12:10:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209200104.870531-1-ctshao@google.com> <20241209200104.870531-2-ctshao@google.com>
 <Z1dy2Svj6gddulHf@google.com>
In-Reply-To: <Z1dy2Svj6gddulHf@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 10 Dec 2024 12:10:33 -0800
Message-ID: <CAJpZYjUks3Mv2rFJivQV45etfxHoEYKsjhPBMZzvA3CL2rTAFQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] perf lock: Fix the wrong name percpu-rwsem
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Namhyung! Please check my v5 patchset:
https://lore.kernel.org/all/20241210200847.1023139-1-ctshao@google.com/T/#t

On Mon, Dec 9, 2024 at 2:44=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Mon, Dec 09, 2024 at 12:01:01PM -0800, Chun-Tse Shao wrote:
> > In `perf lock --help`, the name of `percpu-rwsem` should be
> > `pcpu-rwsem`. This patch fixes the naming in `lock_type_table`, and als=
o
> > replaces the mismatched name `percpu-rwsem` before parsing it for
> > backward compatibility.
> >
> > Tested `./perf lock con -ab -Y pcpu-sem` and `./perf lock con -ab -Y
> > percpu-rwsem`
> >
> > Fixes: 4f701063bfa2 ("perf lock contention: Show lock type with address=
")
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  tools/perf/builtin-lock.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index 7e36bbe3cb80..264acfa648e4 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> > @@ -1587,8 +1587,8 @@ static const struct {
> >       { LCB_F_RT,                     "rt-mutex",     "rt-mutex" },
> >       { LCB_F_RT | LCB_F_READ,        "rwlock-rt:R",  "rwlock-rt" },
> >       { LCB_F_RT | LCB_F_WRITE,       "rwlock-rt:W",  "rwlock-rt" },
> > -     { LCB_F_PERCPU | LCB_F_READ,    "pcpu-sem:R",   "percpu-rwsem" },
> > -     { LCB_F_PERCPU | LCB_F_WRITE,   "pcpu-sem:W",   "percpu-rwsem" },
> > +     { LCB_F_PERCPU | LCB_F_READ,    "pcpu-sem:R",   "pcpu-sem" },
> > +     { LCB_F_PERCPU | LCB_F_WRITE,   "pcpu-sem:W",   "pcpu-sem" },
>
> It'll change the output of perf lock con -l.
>
>
> >       { LCB_F_MUTEX,                  "mutex",        "mutex" },
> >       { LCB_F_MUTEX | LCB_F_SPIN,     "mutex",        "mutex" },
> >  };
> > @@ -2365,7 +2365,11 @@ static int parse_lock_type(const struct option *=
opt __maybe_unused, const char *
> >               /*
> >                * Otherwise `tok` is `name` in `lock_type_table`.
> >                * Single lock name could contain multiple flags.
> > +              * By documentation, `percpu-rwmem` should be `pcpu-sem`.
> > +              * For backward compatibility, we replace `percpu-rwmem` =
with `pcpu-sem`.
> >                */
> > +             if (!strcmp(tok, "percpu-rwsem"))
> > +                     tok =3D (char *)"pcpu-sem";
>
> I think you can do this in the other way around.
>
> Thanks,
> Namhyung
>
>
> >               for (unsigned int i =3D 0; i < ARRAY_SIZE(lock_type_table=
); i++) {
> >                       if (!strcmp(lock_type_table[i].name, tok)) {
> >                               if (add_lock_type(lock_type_table[i].flag=
s)) {
> > --
> > 2.47.0.338.g60cca15819-goog
> >

