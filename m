Return-Path: <linux-kernel+bounces-339752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A33259869E9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC247B24D0A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149C91A42D4;
	Wed, 25 Sep 2024 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E2DB/sBO"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24CD1A3BC0
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307765; cv=none; b=N8924JRTVa1oKvSO+Nv5Rk9D9NvsNgB5ro7TA1X8Hg+l3h+MoDM080jrdgiRls5rfvISQeT0eW5VQW3lxCaeWctZzWhTD8n6IcNtI1foG8gWh1YMdArwLYEvOQH7KaDioOhsMegHrdDazxxCCHY3Jmq0rEWjKpS3DPZCWpjHOvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307765; c=relaxed/simple;
	bh=cwCCg7cjlmVJH30GDf9Cwg6fhR2bbuS17MaqIuOSV0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHLBnq3J7sc6UQ/o1FWVaQa/jBOkS/nsKj+XoigniCmrZw+gU+vGG5S8j0HTZPyE7RRsO93s+25IK4zAFSNoUp8ccpEGL9YZirKbFgQY+0Nqep7FvQSsr6RSJv4n91/iONj0KAJLX0i94flvW/9VjHX3Rxl+Bh7KPFRnzMPbsUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E2DB/sBO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c2460e885dso9895a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727307762; x=1727912562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ek54duFW07igKvK9AQGJRlqEiTdehADtLtBpPhw2agE=;
        b=E2DB/sBOLvarg2yLjBPzCZclNsJO7hUZ6G7JWzC4pwy0KSxVSEd4lwuegmPYuVSQE4
         prcHVOg7GAh69d/EyX0HEVwPNO7OoxLLT1XW9/QLTBTpHNoaawRjhV6Izc8NyK6G7J8g
         yWT+LFnEPZTweXSqF0Az63SGuO4uGNkcw9+B+7ZDCh1lPcuAEmiGtGkKT7vA+yauVohF
         3I/GitalJG7xgdUdG+J/pJVjqu/LMTaS6qysbWg7BKBSXex1Mmr8VhbGOaHL7P8+MlDu
         17kRZ9XoPDATpxO0EUSiqUqOlSRZ5lMf95dG/4z3py4hD1ZCDkd3CV/2P3UQBIVojm1S
         /P1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727307762; x=1727912562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ek54duFW07igKvK9AQGJRlqEiTdehADtLtBpPhw2agE=;
        b=INS5k3j1xSqHu5afkr/CXphbCX87Cw/gpWOCCF1o6v4uG2rxRyyyCqYwnFTYs3yoIS
         VQP6UIbJPDbsFPVo9g1K1nVI0bhA0+dLXwjnuzjCeVQR7ZFaCV+tgt75k01B9Reylbhx
         Svl7HFd87r1jnUwBeEjn57KZr7tNI6hN74buOxPNo+AHdiT8gsXXU27EWZz+fPWT3wCl
         7V4dnSy1bs4gfanIVVj3RO2WMsnrD2TNG1/zyidtxpaVBzkF1pUjq2HDZLPykw3ouzCL
         tGiqwQu9AE+WCpD6HwSCcHlbgn3MigzvDjYlbAGPpkXYdIGGJbPAUWKpnHP2IF+0xONw
         +NKw==
X-Forwarded-Encrypted: i=1; AJvYcCUACsMKlk7whzXMgHQ2N+TeF+yIGTLIFhNFfSdz7IqxRlgTVQ9KO7JnUj+VT5l+VMWtVU+vn8yzPexDW80=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQtrb+l/I0xJFgC8w8ccP007URHrOJ3HC7nhN1Ves14hlpLB5B
	8WO/Hgoxqe9c10TJg1z/jEvako04w3c34bWqs6S0oZO8dm/JCgzlmUBDquTVyq6V70WT0TRSQ3i
	WPhyK+WufqU73kZRERn5HClMhyl9YxkhAWyWp
X-Google-Smtp-Source: AGHT+IEQLkFnBxCVmc+hBCfJCN9xgnB4wVQcVoqAWlHhf+GqjN1sdjtOkK/z88OGPV3GGtu/6kc0Wj3d2hT0sVNu66g=
X-Received: by 2002:a05:6402:524d:b0:5c2:5251:ba5c with SMTP id
 4fb4d7f45d1cf-5c8783c7d8fmr251259a12.0.1727307761901; Wed, 25 Sep 2024
 16:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924212024.540574-1-mmaurer@google.com> <20240924212024.540574-15-mmaurer@google.com>
 <20240925230000.GA3176650@google.com>
In-Reply-To: <20240925230000.GA3176650@google.com>
From: Matthew Maurer <mmaurer@google.com>
Date: Wed, 25 Sep 2024 16:42:30 -0700
Message-ID: <CAGSQo00OqOJ+s3xULXvojXMSCR8y-TQOHAwWqpS2VDxWaDxxQA@mail.gmail.com>
Subject: Re: [PATCH v4 14/16] modules: Support extended MODVERSIONS info
To: Sami Tolvanen <samitolvanen@google.com>
Cc: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Michael Ellerman <mpe@ellerman.id.au>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Naveen N Rao <naveen@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, neal@gompa.dev, 
	marcan@marcan.st, j@jannau.net, asahi@lists.linux.dev, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linuxppc-dev@lists.ozlabs.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the catch. I've sent up v5 to include that fix. I've also
added a changelog and made sure the patches make it to linux-modules@
as Daniel suggested.


On Wed, Sep 25, 2024 at 4:00=E2=80=AFPM Sami Tolvanen <samitolvanen@google.=
com> wrote:
>
> Hi Matt,
>
> On Tue, Sep 24, 2024 at 09:19:56PM +0000, Matthew Maurer wrote:
> > +static void dedotify_ext_version_names(char *str_seq, unsigned long si=
ze)
> > +{
> > +     unsigned long out =3D 0;
> > +     unsigned long in;
> > +     char last =3D '\0';
> > +
> > +     for (in =3D 0; in < size; in++) {
> > +             if (last =3D=3D '\0')
> > +                     /* Skip one leading dot */
> > +                     if (str_seq[in] =3D=3D '.')
> > +                             in++;
>
> Thanks for addressing Michael's comment, this looks correct to me.
>
> Nit: might be cleaner in a single if statement though:
>
>         /* Skip one leading dot */
>         if (last =3D=3D '\0' && str_seq[in] =3D=3D '.')
>                 in++;
>
> > +void modversion_ext_start(const struct load_info *info,
> > +                       struct modversion_info_ext *start)
> > +{
> > +     unsigned int crc_idx =3D info->index.vers_ext_crc;
> > +     unsigned int name_idx =3D info->index.vers_ext_name;
> > +     Elf_Shdr *sechdrs =3D info->sechdrs;
> > +
> > +     /*
> > +      * Both of these fields are needed for this to be useful
> > +      * Any future fields should be initialized to NULL if absent.
> > +      */
> > +     if ((crc_idx =3D=3D 0) || (name_idx =3D=3D 0))
> > +             start->remaining =3D 0;
> > +
> > +     start->crc =3D (const s32 *)sechdrs[crc_idx].sh_addr;
> > +     start->name =3D (const char *)sechdrs[name_idx].sh_addr;
> > +     start->remaining =3D sechdrs[crc_idx].sh_size / sizeof(*start->cr=
c);
> > +}
>
> This looks unchanged from v3, so I think my comment from there
> still applies:
>
> https://lore.kernel.org/lkml/CABCJKufJK0WO92wnW09VTLqZk0ODxhuKQG=3DHbKE-v=
a0urJU1Vg@mail.gmail.com/
>
> Sami

