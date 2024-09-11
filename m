Return-Path: <linux-kernel+bounces-325329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB4D9757ED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4772E28B2CF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C251B1D5F;
	Wed, 11 Sep 2024 16:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="digjE51U"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1EA19CC05
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070629; cv=none; b=lXlAPJQWf/MoaiEpEW1gb/gmd90iI96t7Ui1JTkt7VVTPRpVjbRe7G/WCggXaprowhoxuVPdaITj4uB8lXI0gZmf6PZIoArWw4dHc6ytb3xouQr3jcTisjOn6UUM+kWNWZYqRGTpTXacOrwR4xBztM0SBHSPjIXNhbHMMVbcoWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070629; c=relaxed/simple;
	bh=9sXB+vF2HaFIBrbpsH0gLpHJzwQVTbseoo4NvxT6HN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWSDNdBS6soWHFsGgOa3ut18DnTTUVsR/K6Dq8p/exSo7zVXJuYAVuERUg3o1xiMVEKI55qgGoyKyV6j67QQDqGyPCClmN8WGoB7rJ4X8zvOZPiJwXCQDuNAueR5ekMursgwTOJDJ6eH28iusn7yQ52RdSFfr78uSlSQCfANW4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=digjE51U; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4582a5b495cso596771cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726070626; x=1726675426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nej+hDXRQGZRY33WrOI2LiHyYN70vRosnPoaBCwRhc=;
        b=digjE51Ua/9wuvOdGLvuOu3Yx0OgfKSGYXG/tLoCN8673ZHKqw3CL65wZere2xEHlL
         CSZF+Dm294ox/O0OVaeJ4J5U1EnTI9cK9IYlwjn/8jrdMUwDT9XvTjV+c1mtWGViu5Pk
         ZPsRf2dTd57MQ3hdymvwrxxJhVohbwoYg0ndIsXsuunPYxbT3DR0INZh45pLQ+xD1+lQ
         vTWSpVYUG1+1edNxMg/nSWVsr4Q/+bzOoQq6GfUJeChIcgn7uYKivv4IZj590wYSJtSW
         PRH9E2BJilIt0TXrnoR9T9WcYmzjNis4Qr+HgcYY5i12LF+r9rS2NWk4p+rdlT+yi9nL
         YFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726070626; x=1726675426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nej+hDXRQGZRY33WrOI2LiHyYN70vRosnPoaBCwRhc=;
        b=ZS59Nz/C378zw2+xE6hXbywkvnnQ8UyS9taIU2+BW36W7qmcv/Y+IAtHq2CpLC6Pu5
         ix6bvxe9Ss/RjgWjvRO8v7nA/Vsh6cUwF4P5r4XoMtPkoe2FQyxRU0iraaEjY7kc8Ird
         ajd0YiIX9+KnmhK13kX72NFL609qfLvh4EZ40dN285aCp3CFqdAeoqJ0lYhXQ1DhhgQi
         lGKW3CG9K/PXDKK3SWbaDU7tuPHWx5gQcFv5gcu1mzAsT/2NqMoU7veCHt8ItWUXUubS
         jwedCMEu/jbXSU5Uia+l3WYAmW+bsSWJJuUPYaQCxsJSkf+uqf4CxAD98Hn+E5Jn5Tph
         7EDw==
X-Forwarded-Encrypted: i=1; AJvYcCW9Qhp0BK0yWkELV/7elR6PKiPO4llBsNfI4L0ZQ/ORtI5k6oQuwXy8qfwO6+kFgPu47R2LtnvKgmW6G8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YweR50QhM8it+Xr+CZX7J2BiCJ8Nso5LH9sg/DmfjC3JnnwjEA6
	zNE7c5H2cffssPCTqgvwKYO03gtUreQ95MxR7dGgTAycMLB7vR+BLYscNDSFwBjN2AayWZE7shs
	y1KOchQiRnadoPar1V4187xrzYfYxJPJ03m8d
X-Google-Smtp-Source: AGHT+IFqdCZ/zpCHMcTbg+wp9DmWUAH6fN0n+S9E0/kdxeU/B33WqP/WHqvn0q9L2zpcH9hRPg20QhMF9dEBajFDZtI=
X-Received: by 2002:a05:622a:d2:b0:456:7513:44ba with SMTP id
 d75a77b69052e-4584f3a33d4mr4259221cf.4.1726070626297; Wed, 11 Sep 2024
 09:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-35-samitolvanen@google.com> <286b1cc5-1757-4f0a-bb66-0875f4608c7e@suse.com>
In-Reply-To: <286b1cc5-1757-4f0a-bb66-0875f4608c7e@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 11 Sep 2024 09:03:07 -0700
Message-ID: <CABCJKudJR13PJgjr9-5Ff9Dzmb7=pSx7JWM5qTyR8oYRdtSDDA@mail.gmail.com>
Subject: Re: [PATCH v2 14/19] gendwarfksyms: Add symbol versioning
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

On Wed, Sep 11, 2024 at 3:08=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 8/15/24 19:39, Sami Tolvanen wrote:
> > +static inline unsigned long partial_crc32(const char *s, unsigned long=
 crc)
> > +{
> > +     while (*s)
> > +             crc =3D partial_crc32_one(*s++, crc);
> > +     return crc;
> > +}
> > +
> > +#endif /* __CRC32_H */
>
> I think the CRC32 code should be ideally shared between genksyms and
> gendwarfksyms. One option would be to stick it under scripts/include,
> not sure if the best one though.

This was carried over from the initial version, which wasn't under
scripts yet. I'm happy to deduplicate this though. Masahiro, any
preferences on where this should go?

> > +static int get_symbol_cache(struct state *state, Dwarf_Die *die,
> > +                         struct die **cache)
> > +{
> > +     checkp(symbol_set_die(state->sym, die));
> > +     check(die_map_get(die, SYMBOL, cache));
> > +
> > +     if ((*cache)->state !=3D INCOMPLETE)
> > +             return 1; /* We already processed a symbol for this DIE *=
/
> > +
> > +     (*cache)->tag =3D dwarf_tag(die);
> > +     return 0;
> > +}
>
> Nit: The "get_" prefix in the name of this function is misleading. It
> isn't a plain getter but has an effect of setting the symbol die.
> A different name would be better.

Sure, I'll clean this up.

> > +static int calculate_version(struct version *version, const char *name=
,
> > +                          struct type_list *list)
> > +{
> > +     check(version_init(version));
> > +     check(__calculate_version(version, list));
> > +     cache_clear_expanded(&expansion_cache);
> > +     return 0;
> > +}
>
> Nit: The name parameter is unused.

Ah, so it is. I'll fix this too.

> More importantly, it made me think which names are included in the CRC
> calculation and which ones are omitted.
>
> If I'm looking correctly, names of structs, enums and enumerators make
> it into the calculation. On the other hand, names of struct members,
> function parameters and exports (functions/variables) are missing.
>
> I think the names of struct members and function parameters should be
> added as well. If the code changes 'struct A { int cols; int rows; }' to
> 'struct A { int rows; int cols; }' then that should be recognized as
> a different API/ABI. The same applies to function parameters.

I did leave out member names because typically renaming a member
doesn't change the ABI, but you're right, it might help capture these
types of changes where fields with identical types are reordered for
some reason. I'll add names.

> I'm not sure about export names. I would probably include them as well,
> if only for consistency.

I would rather leave out the symbol names to have consistent CRCs
between symbols that have identical types. Or is there an actual
benefit in including the symbol name in the CRC? The names are already
rather explicitly involved when symbol versions are checked.

Sami

