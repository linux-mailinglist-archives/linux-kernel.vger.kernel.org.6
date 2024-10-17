Return-Path: <linux-kernel+bounces-370319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 058239A2B11
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ACAA281F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617F01DFDB2;
	Thu, 17 Oct 2024 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FJzkGIHj"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED281DC07D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729186549; cv=none; b=k4NIkT9SHj+f6Q6DbDFQavrB7q+sLyz0tr8d9TVrqSQ38RI6MPQdFCrPY3eTYIuq5jb2Hdn1SQG5VrJ1VmJsjmubqPFhf/Eh4EXZSzFcaJ0qQxqwmoSGmKPXLisLTPaI2xklkTap4+5/sskQtKk2BSPNxYRTlVCVvmcRN2FSrrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729186549; c=relaxed/simple;
	bh=HuLw3XyUw5DMqXb931/MX/8kxOX3NCDGhGfWHIZsYUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTrVPp9YTZmXSzu9RZ/4cl+mL69Z28rwzkiSdYHLb9GRrPIFammfkEuKni68YkcUt8+7A9o2ERbUQQBdSa6incAj42+7MFY554RuQs9ntBcP4fvJXu20uRDuT1f+QTiH/s5YqFnNrbaloU273EMg2zkQU2MKilkN5Mmda9wAZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FJzkGIHj; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4601a471aecso14101cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 10:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729186543; x=1729791343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dURRoBcg5xdc+sfdygcMDdcNIH61rDVf7UQMeP0ptwg=;
        b=FJzkGIHj80CeJYXMnKUMhfmYg/9wAbXJxmDLj00C2PAhETZZ/U3t2NBwLcNDXlA4JO
         KZ8dmvRgVJgNj+CQq0dzXVcOc2gC1+OF2ztrJO6dBrc3PxXr6QbJGh0h82/jYshRaBBD
         +f5g02XA6cgVr6uTH46VwWtb68CojEZiKfCioVBhO76uU8lyTQELcoKSoRfycOMtlgeZ
         /Y750xp3n4o9YoV3HX+yTQF9t3689goBZmSsG+whOvXNch5W1sksaCKVTEWCQ1F3NT9h
         Q/jdYC/S70Fv2kBIQCalBHu28+RbAbSIokp7ogmZLNWhYoZ4L71SXiRDOmUOTKrrotZe
         DTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729186543; x=1729791343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dURRoBcg5xdc+sfdygcMDdcNIH61rDVf7UQMeP0ptwg=;
        b=Vt/9QJCis5/oz2wesK6A4xJV/D2BEgDzxRvBUHsb7ENSyuOzpPxmJN2Q1vpVeN/JhM
         QmO1RKrzPNzjsswQQK/wboxgkVjKHUdV8El4vapHLGm41UEnjJsrdI4euZcM3zurNlXD
         yZUZf3OptZPQ0sFSp7/NpdOVCQtZWb31W5X1PMyEhg+PM0I003a5GAEILpJxZi7beLmw
         JLAmSxD31Ng5Wgy5fXnFmdFN+qpJ+XOPPdiv9aHHaQtjzcH0BC4bq0/ObrNBLEVlXtXD
         Nd9phsTn27S8LvRH9/KOhuO/XKnWktH1+JMFuNyl4p5a9gFXMYRLAayYGziSd0DxaiDW
         7Giw==
X-Forwarded-Encrypted: i=1; AJvYcCU3MtKCAS2U58njeM7ionkZf1afkNqab8k8eLLzLKhaaF1D7IOLNm5gyUESQGqO6HxfgiD1vPyxNfeO0AA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycd5ic3S0dUxhU8xNfzxNHq/y/SP3uKK61JWKkFVLthoMI2PJJ
	Qg+QbH6F14pcoWO7nqHW4Huyzi8V9H/7wjgaj+MojAI2nm/8gEn5HHgY27BBcR3/tH2ffeuuBvX
	RbcgHLyC/Lf8H2Y1rMFX7RVTS/Gz4Co3rCJmy
X-Google-Smtp-Source: AGHT+IEaDSNEXF6UDd2rD0Gd9sSzpU9Rg3eq7jFfKlAmBkK223IeHgDaarxW/TGnC4DSXNdPeOYFY1DS/4zAFx3ebnw=
X-Received: by 2002:a05:622a:a64e:b0:45e:fea6:a3b1 with SMTP id
 d75a77b69052e-4609f69cb5dmr3909251cf.19.1729186543003; Thu, 17 Oct 2024
 10:35:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008183823.36676-21-samitolvanen@google.com>
 <20241008183823.36676-33-samitolvanen@google.com> <13be9260-1799-4255-89d4-65d56358e348@suse.com>
In-Reply-To: <13be9260-1799-4255-89d4-65d56358e348@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 17 Oct 2024 10:35:06 -0700
Message-ID: <CABCJKueKHy9XmpRVG=HkJaJWAQvtN6OvnnW+Aag4Hd1dfif5SA@mail.gmail.com>
Subject: Re: [PATCH v4 12/19] gendwarfksyms: Add symtypes output
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>, 
	Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Petr,

On Thu, Oct 17, 2024 at 7:13=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 10/8/24 20:38, Sami Tolvanen wrote:
> > +     if (symtypes_file) {
> > +             symfile =3D fopen(symtypes_file, "w");
> > +
> > +             if (!symfile) {
> > +                     error("fopen failed for '%s': %s", symtypes_file,
> > +                           strerror(errno));
> > +                     return -1;
>
> Nit: The 'return -1;' statement is not needed since error() doesn't
> return.

Ah, missed this one. I'll fix this in v5.

> > @@ -107,7 +108,8 @@ static void get_symbol(struct symbol *sym, void *ar=
g)
> >  {
> >       struct symbol **res =3D arg;
> >
> > -     *res =3D sym;
> > +     if (sym->state =3D=3D SYMBOL_UNPROCESSED)
> > +             *res =3D sym;
> >  }
>
> What is the reason to check that the symbol is in the unprocessed state
> here?

At this point it's mostly a sanity check to avoid extra work in case
we run into more than one DIE that matches a symbol (or its aliases).
This actually happened in earlier versions because we handled symbol
type pointers (patch 17) as soon as we found them, but now that we
just save them for later in case they're needed, this probably isn't
strictly necessary anymore. I don't see any downsides in keeping this
check though.

Sami

