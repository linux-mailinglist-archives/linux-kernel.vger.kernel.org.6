Return-Path: <linux-kernel+bounces-209430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5F7903476
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 09:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37FA1C230F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 07:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB19172BD0;
	Tue, 11 Jun 2024 07:57:03 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCD6172BC4;
	Tue, 11 Jun 2024 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092623; cv=none; b=kzdzy4l/9QNa6f8K3QLHgISLG+BHcwLqFP8fPZFdiDW2K96x9v1nbTnktVCPKFX9ovisEAuAy+Rzrc7CkYJHTm16lYibiFD/ONQjSxWDTKEc9npHXrMhxpwV3X8Buu/iMp9xoiGd1OUY9Lqga/ym1deuQZEs8U8fUtyeMRumeNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092623; c=relaxed/simple;
	bh=egIQx8Pw2JM34Ztk3kqZ03upvd4ALAAIxbSYZXBedpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJt4K6C45KNCrcJy9ixEGaysNK7Lf4Z2k1X1fedEVFb+9z/MDGXqsrgqNSIWRGstdxiAeJJKQYiu2QzHqvYHmQBUjRYvGG1YsEhh2ME6Y3m1zG5IESB0u3+xFVkchMNZjWAd2aMikK5mPmokGpEl64jXF997U3JPgNY97tleEcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f47f07aceaso45546985ad.0;
        Tue, 11 Jun 2024 00:57:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718092619; x=1718697419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7WTB6sxQIb2HezZMplqIhvskVuAmbHkFRIiNzNqdzU=;
        b=BIQmD5sVtP3AvioB9q+Xuii3HEZGVARYU85EBrQ9kZ2sHYx0Ta6nroFQ27/MQpQ4/n
         ZcakhXPPQXH4LqbgkmHzgU1anYaWiy2HjJfEuMJMoZRIN2W3u3fEPz1+IiR/7WyJ+2yf
         coL01toMUO/9L3+7NI9PeAPf4E+P6nLKZYvaiuRAovEWkSCyKsCIxDTFWRKb+orBAps1
         TbCsqhl7d1cEcFwtG003Ie2vNgyK7ueKHL1VEEUc7I1MP9zRK2kO75k+WUmA3FdbxEkk
         nhlfXxsXk6s5F09jcnlaKW+cDaELE8T9PBWw15i9TaGIjImvtP7joqviRoOsDkiLT7Rf
         L+qA==
X-Forwarded-Encrypted: i=1; AJvYcCU1U6CYSBPj4IBsBkJuTdEvH9MWfDVxG0eIf1PnNyUlrAU6p9HYpY5ax95vFxhLBFfO9A8+siSLzaFsRUiYJ74Wc7MvDhJ4IoTU10yJs+Enl7b5mUKWwmOPQ9L86cQt3inl4JJmVwQb
X-Gm-Message-State: AOJu0YyNyREX1DWKdWffdtspdDCzcq8Wosku1xhKTnyNbrMzAHkzngDD
	MW/E4vlKj3VaLG9sRSbO5kCvUkljcg6/1Bi8mk6VvI9XXap81Ks9vv/mxxMma+vweovGvACbBaE
	B0Onwl8/5sqFe8kKtm1QpQ9mvonU=
X-Google-Smtp-Source: AGHT+IEeNdLDv9/Rj1l3JJPxAWJDScZNGNGtWzqD7h1KA9MocJXkvLH8iUgeqCxMEWXpwSSGhhrNFb6+HEXGBYFwGSU=
X-Received: by 2002:a17:902:eccb:b0:1f7:c33:aaa5 with SMTP id
 d9443c01a7336-1f70c33acf0mr64714085ad.10.1718092619305; Tue, 11 Jun 2024
 00:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024061112-kilogram-poker-bacf@gregkh> <dc9a785c-f8f1-474d-ba49-31de63dc5e8d@app.fastmail.com>
In-Reply-To: <dc9a785c-f8f1-474d-ba49-31de63dc5e8d@app.fastmail.com>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Tue, 11 Jun 2024 16:56:47 +0900
Message-ID: <CAMZ6RqLtc5jtfjeQO2Su8iSjw4bbPczKMsnW3mCB=SXkSufY-g@mail.gmail.com>
Subject: Re: [PATCH] .editorconfig: move to Documentation/ directory
To: Danny Lin <danny@kdrag0n.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, masahiroy@kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	=?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue. 11 June 2024 at 15:53, Danny Lin <danny@kdrag0n.dev> wrote:
> On Mon, Jun 10, 2024 at 11:49 PM, Greg Kroah-Hartman wrote:
> > Some editors (like the vim variants), when seeing "trim_whitespace"
> > decide to do just that for all of the whitespace in the file you are
> > saving, even if it is not on a line that you have modified.  This plays
> > havoc with diffs and is NOT something that should be intended.
>
> If trim_trailing_whitespace is the only rule that has actually been a pro=
blem,
> how about removing it and leaving the rest of .editorconfig intact?
> The other rules are still useful to have as defaults.

+1

The trim_trailling_whitespace can be removed. IMHO the main point of
the .editorconfig is to set up the correct indentation, that is to say
the indent_style and indent_size parameters, and I don't think that
anyone is having issues with these so far.

> Thanks,
> Danny
>
> >
> > As the "only trim whitespace on modified files" is not part of the
> > editorconfig standard, just move the whole thing off to the
> > Documentation/ directory so that those that wish to use such a thing ca=
n
> > pick it up from there.
> >
> > Cc: Danny Lin <danny@kdrag0n.dev>
> > Cc: =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>
> > Cc: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  .editorconfig =3D> Documentation/.editorconfig | 0

This would not solve the issue, because it would still apply for
anything under Documentation/*

> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  rename .editorconfig =3D> Documentation/.editorconfig (100%)
> >
> > diff --git a/.editorconfig b/Documentation/.editorconfig
> > similarity index 100%
> > rename from .editorconfig
> > rename to Documentation/.editorconfig
> > --
> > 2.45.2

