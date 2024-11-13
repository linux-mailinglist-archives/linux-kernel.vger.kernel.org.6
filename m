Return-Path: <linux-kernel+bounces-408083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011F89C7A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41456B2B347
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7385C202F80;
	Wed, 13 Nov 2024 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q5agB2me"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C211A2010F4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520134; cv=none; b=czbtCQU1VhVVhDKPuud04MI7n0iu0s97+RdYZ5f0bXTBL7D06LhjCDwzlUf77Fyk36F/b82RMUgY4w4wLcGkL2xBMCWnuxP8VrA0m0NHrNjzIMxQGryg/W/i9UblLqy012yu4uCdk21RUoV9pa4gqecm4t3weltQvEohb53k9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520134; c=relaxed/simple;
	bh=2vvecHebovoeGzhdxA64vP0FIVcZsrzn6/S2UuTdzUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEMWnNsZV6gB76EgqqMzlwxS+IBsV/3YyP76q1qFgDVGkbHiI5tDQTAYHk0zw8Bk+Q49gRbleYzdBNxCxxO3xAiPTqwnWxs1DXvchXhaCXQyPrMHfVP2Mk9DyZm8v/byu1lw8ilzlJCvivRWbNR1PjjOneppqfndvG3E0DI4MFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q5agB2me; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so9052a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731520131; x=1732124931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ut09l0p4ejZD65rK22Do5DdJADgIGvLTdDvLpb35Lpg=;
        b=q5agB2mexx2fJ5p1z3Xx8YR2q/Zt3BQwdxy3HYl87xBtWPT1NCrsUcJwV6KeCrgi82
         WmYboHZe532UOtuz5eBh3dBn7+H62L9QIzWHI4ugSiHfSY/Cp4JfVBTEzpMdo6VBc0OJ
         nokiwrPS/IYH2YvLIe2RLaINnfd9xlryIEZi4OEEEHZOmmHIvrGY+4gIlj9vS49nQHdO
         7RrXs/TA3AeBBd9p0iNXut3YiDw6reUo5V41UaqgTPgnm0YPZoWox3Zm7N2USLs9B42M
         fZgUNn0qA1J0AgtmWtf9UD/hhLfAqbq2jTNX6NFMzM2LgmE3au5sZc16sLkg6VXvJ9KW
         uG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731520131; x=1732124931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ut09l0p4ejZD65rK22Do5DdJADgIGvLTdDvLpb35Lpg=;
        b=eJ5kVKU288zEFCycUyGaIAoHwInlFS44v8uZpY8GeBbZcQBwXqtrg8IJgXsahjrl/z
         kwAhO9EZ0ha/pcqxdv6lBK+fwnuITCDyghs/G7qU444CDwH2voUJ+Cm8i0sKJifiLUU4
         rcQxJpNV5o9dG+6KzZxOJ+wZSUNKTGiLVdzsNMF+74b7cHFHW1kHBUoJlD2H5vZ+Bf1m
         sI39oUjTuUDvVl1RTTBX868V9hsRT1xBYy8cWhJz0JBGE9F97ivEgVJN6cenh0SCNiZD
         0zW4jGdn3KtyfeljayO1HC1Ta3gUOTnhxhW82tvHY0Rly4FI2vZ3kJkO1jiFPLgFILT7
         6sGA==
X-Forwarded-Encrypted: i=1; AJvYcCWBImt8Uc+as6F/wnQyNic/r1Eg/chbgJmyYr1SB5Wx4Sy81Bf666unXwCHeEIyBsImQvU+/KyTrtmleqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBNHQjkHSQxJeXQ+EILMep90B2JSiU8BdPSnt9ADIujtUC30Wu
	+Rul+fXplM0n6umid+tWwHrCY7Ytmwu3LncdyEdY77hgApHsSYiPXbXe/BUQTdFaE2n8s9pDgSX
	TvRw9qW7EVoJQGSLfj8thqPfLBTBubBsuvoaz
X-Gm-Gg: ASbGnctxSo3C3Eebigp1BHeg2ljoP6p3TR1Vk37gqOTsyw985Mu6i9GaYVccz4UAsvT
	zEnKIUHFXtFEbAahZ8Mmy1foeq/3V
X-Google-Smtp-Source: AGHT+IF+3cQN9o21cQiIysZAB4NJwFjVHmftEWZ1JWnUJZdbBdxTB+kUQux093XqXmTqkJPQ2rghtkSNf6aJlDPPoDk=
X-Received: by 2002:a05:6402:886:b0:5cf:7145:be96 with SMTP id
 4fb4d7f45d1cf-5cf7145bfa8mr145258a12.2.1731520130908; Wed, 13 Nov 2024
 09:48:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030170106.1501763-21-samitolvanen@google.com>
 <20241030170106.1501763-39-samitolvanen@google.com> <CAK7LNAR9c+EEsOvPPn4qSq3gAFskYOXVd=dg8O+bKeeC-HMifw@mail.gmail.com>
In-Reply-To: <CAK7LNAR9c+EEsOvPPn4qSq3gAFskYOXVd=dg8O+bKeeC-HMifw@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 13 Nov 2024 09:48:13 -0800
Message-ID: <CABCJKudWUBE2ZboktcBEykBReor4T1Cf8dfRCWJYEryoT81OEQ@mail.gmail.com>
Subject: Re: [PATCH v5 18/19] kbuild: Add gendwarfksyms as an alternative to genksyms
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthew Maurer <mmaurer@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, 
	Asahi Linux <asahi@lists.linux.dev>, Sedat Dilek <sedat.dilek@gmail.com>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Mon, Nov 11, 2024 at 8:09=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Oct 31, 2024 at 2:01=E2=80=AFAM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
> >
> >  # These mirror gensymtypes_c and co above, keep them in synch.
> > -cmd_gensymtypes_S =3D                                                 =
        \
> > -   { echo "\#include <linux/kernel.h>" ;                              =
      \
> > -     echo "\#include <asm/asm-prototypes.h>" ;                        =
      \
> > -     $(NM) $@ | sed -n 's/.* __export_symbol_\(.*\)/EXPORT_SYMBOL(\1);=
/p' ; } | \
> > -    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - | $(genksyms)
> > +getasmexports =3D                                                     =
           \
> > +   { echo "\#include <linux/kernel.h>" ;                              =
 \
> > +     echo "\#include <linux/string.h>" ;                              =
 \
> > +     echo "\#include <asm/asm-prototypes.h>" ;                        =
 \
> > +     $(call getexportsymbols,$(2:.symtypes=3D.o),EXPORT_SYMBOL(\1);) ;=
 }
> > +
> > +ifdef CONFIG_GENDWARFKSYMS
> > +cmd_gensymtypes_S =3D                                                 =
   \
> > +       $(getasmexports) |                                             =
 \
> > +       $(CC) $(c_flags) -c -o $(2:.symtypes=3D.gendwarfksyms.o) -xc -;=
   \
> > +       $(call getexportsymbols,$(2:.symtypes=3D.o),\1) |              =
   \
> > +       $(gendwarfksyms) $(2:.symtypes=3D.gendwarfksyms.o)
>
>
> I do not want to see crazy suffix replacements like this.

Yeah, I agree. It does get a bit ugly.

> I decided to delete this.
> https://lore.kernel.org/linux-kbuild/20241111171753.2917697-2-masahiroy@k=
ernel.org/T/#u

Cool, thanks! I'll rebase v6 on top of your patch.

Sami

