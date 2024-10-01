Return-Path: <linux-kernel+bounces-346607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A666698C6AA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58BB71F22860
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E881CEAAD;
	Tue,  1 Oct 2024 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rzTnF5cE"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C241CCED2
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813934; cv=none; b=pRLW0ueDl2qOYKFbTanaE8cS9aasKeLWAlg90/CtEvHiE4qC6XljIvHUq+MBwFAcu5T+fXIC6Lv+uRBkVKT9EN2yhxnAVddgAQR5p+I+ygHo982r0BQIhsQGWwKB2aDpLL9HCl22Jjq/v8Jc2O4B/MnLK1Q4+bUkKWIkCrTiQeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813934; c=relaxed/simple;
	bh=RyRRva46Au0EaG06flnXvPQqiLcxe9w3qwxQucSjMPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6Y2PsVBJs63Y+9iXZPhzRb1F/OF5MMtGYwxQr5fxbJ051lnYy306bLHPJPiICzGphSV/TrlirpdM3e3S7YYy4HyVdsM5tAcxCDPDnQ2TVwUtawfjX+KDzIejV3QTBAcYfIZPiIum8oAwb44HhWPVSJLFa53vz85b1MpQMCkytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rzTnF5cE; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-45b4e638a9aso17281cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 13:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727813932; x=1728418732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/GuuFkapqTR185OUWCoLZGw0BcekQwTFJers3DxjmY=;
        b=rzTnF5cEbvkLP3sY1Oina7JAfndb9xo6iCeNvSZzD/T0fNhc5ecL66L1LeCRf06fn/
         /rkOpdhuX87DWewavvVEowvxAl2bpxLzqz4E1D2yLi0IWMLcbfa5XLd41e5C4ervULd3
         23uOf3mRlaxLNpE8DM+XewZUT0q8U5cU7cJie1izHZM84GUAFA8ybkYfheYlywR0rB26
         rYN/SyaZR8yWdrD0wKZX40hiYKhZU7i0hYEigo4jcFLeOelDeIXZ87w2JMVLSYpCSpr5
         947ywT4jloqMC9W8fMnDdIHeASufDuB5simirHdKygm+fRLjG1K/LKSsTvSvfykHPcb/
         yVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727813932; x=1728418732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/GuuFkapqTR185OUWCoLZGw0BcekQwTFJers3DxjmY=;
        b=DzWGXGseSDI1ScDRO4zlody4cKBhb2INhTx0SFKN2afNwVK8rXijIcRFZ0DIZ86+he
         bDEbTKnR15Pt8ZHYN2aRzVoKXGzUG+e8zbOXct82Ha6dc81NuJ7WS3YZCjKtrxWgyPj2
         anyHbY32ILvKrX/7OvbZ5pYlXX0UpzplajNmgdURL93eU0rcWtWqivYekV45hnaYn4uA
         z9qOlEMLD4fLxE/G1R3Bhk5omaJht5yqgldEhGDkBLI6n2R6xtiMK+m2Ajxt3Tcaa6kc
         cdJQisUcd89SqQAA4hO90Z9R1MXdaCq4NjcoiVzA8Fd8LAD4tIvpbEY4PGgrzQjWm41I
         LSUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB9SAuAOZ2KA4pOmY4SjAX+nGU6toODWTUC3Y+/GS8w15Bto6gkrl6CP8zFPeoTSnc00yC0kEEKB54OSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyYAFwmMepRwQgQj0hRu8AQJQ5voPNns08Ppt7Viwb6P0zLFDH
	amE68Q6w7a8SCcniWlCZ9n2LISoTqlv038gA7KyebgzDdaKplCz1GQEJgBBjcJQ7Y01mAelcwcu
	WTQGzSgpNWhfdjuyo2KmCl5akn1fQmS32LDxO
X-Google-Smtp-Source: AGHT+IGgt6P2UjzCfEsFRuOsqPPi1mqlprj6DD1mDyXiUt6hrKmTWvB7O34383hQFNSzxcqc9hke5vvwb8pZ2vx7XYc=
X-Received: by 2002:a05:622a:8612:b0:453:5b5a:e77c with SMTP id
 d75a77b69052e-45d81709cf4mr770761cf.10.1727813932030; Tue, 01 Oct 2024
 13:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923181846.549877-22-samitolvanen@google.com>
 <20240923181846.549877-28-samitolvanen@google.com> <a71e018b-1dc6-4427-8f10-399d8a9a5243@suse.com>
In-Reply-To: <a71e018b-1dc6-4427-8f10-399d8a9a5243@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 1 Oct 2024 20:18:15 +0000
Message-ID: <CABCJKuf4G0=XjOkagTBah+u6V7ZxbY9qdGYdqX__45bE0SeN8Q@mail.gmail.com>
Subject: Re: [PATCH v3 06/20] gendwarfksyms: Add a cache for processed DIEs
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Neal Gompa <neal@gompa.dev>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, 
	Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 2:10=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wro=
te:
>
> On 9/23/24 20:18, Sami Tolvanen wrote:
> > +static void update_fqn(struct die *cache, Dwarf_Die *die)
> > +{
> > +     if (!cache->fqn)
> > +             cache->fqn =3D get_fqn(die) ?: "";
> > +}
>
> When is update_fqn() called with cache->fqn being already non-NULL?

In patch 16, because we need the name before process_fqn() is called,
and if we end up outputting the name after that, cache->fqn is already
non-NULL.

> In general, I find handling of cache->fqn slightly confusing, mostly
> because the member has three states: NULL initially,
> a statically-allocated empty string if the DIE doesn't have a name and
> a dynamically-allocated non-zero-length string otherwise.
>
> I wonder if it would be possible to reduce it to two states: NULL
> initially and when the DIE doesn't have a name, or a regular string.

I also thought about it, but using an empty string to represent an
unnamed DIE and NULL to represent an uninitialized value seemed the
most reasonable option.

> > +static inline const char *die_state_name(enum die_state state)
> > +{
> > +     switch (state) {
> > +     default:
> > +     CASE_CONST_TO_STR(DIE_INCOMPLETE)
> > +     CASE_CONST_TO_STR(DIE_COMPLETE)
> > +     }
>
> Nit: I suggest to move the default case out of the switch statement:
>
>         switch (state) {
>         CASE_CONST_TO_STR(DIE_INCOMPLETE)
>         CASE_CONST_TO_STR(DIE_COMPLETE)
>         }
>         error("unexpected die_state: %d", state);
>
> This way, if someone adds a new value in die_state and forgets to handle
> it in die_state_name(), they get a compiler warning.. or a runtime error
> later.

Sure, I'll change this.

Sami

