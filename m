Return-Path: <linux-kernel+bounces-367303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E399A00A0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E13286B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B960218BB9F;
	Wed, 16 Oct 2024 05:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sQMSPRDl"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0B21E3A4
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056567; cv=none; b=sd/LaBdUDRBPs5SXp8ivjN+0vBHALmEjCDPbo/AYZCIWx7UxTVE5KCwnxvOa/F3g3wHDZXXnFsafkI4SN8JJ7yUT/xqxueQxVRLwflnwN/x49P1TrG/eOSPmUAXJ4GXWUSp+b0/spPSQhy+3S6oiL0KoU9oZD3E+6CukRuoAFX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056567; c=relaxed/simple;
	bh=mALp56FhrhW5Ql1pYneoKDFCivUTRhBkwbli2aXDM8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lUjCUfNMvgasFtVVYJDkILhX5TtZpzekXkFvEmGRYgabcK8vK9pGPf8WnXce1IQbNbV/sutVK//y25Uu7CqE/pNZ0zsLQWbtrRKrYG2LEBcziSM3syl1LW7+COpojgwX1UGCqwM4zh/wgM9MitiAxEbISwbOKKoBmYyJe9PIVq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sQMSPRDl; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-84fd01c9defso1544056241.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729056564; x=1729661364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHCRbjbdAz/4L9m7QyVF8NK+nNXYwETwyMu84SQLi/s=;
        b=sQMSPRDleqm6vGnfwGR9Wo7t4b2d260TZAZ/ZzXvyrxp0CDpW3w9/4ZXF1rEd5Sj0z
         PvwQE+/vhhvSU8cp22zAEt/M5PYVQEMWohwKGJ9eKYS6fSMRHvio6VlrBcDVZ5fSJG4/
         aqTqgm5HEZQleen/G4cJyNUzsD4/GjLKXpSh1EN4WpRTvBkneVTFRNnsqxSSVg4H75t/
         YaSK5wYAKi7aursrGv7ItsFZnnj31ty4fSoDyExYCHJ6cEH2lmeacQhDoXmRPEV9FUG9
         Oa+Y4BGB3ieDrB5pi5gEsWTvC7zMY567e2TQDsyAtBJQWNnLaCOKIHi9K8yhiL9acJED
         wH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729056564; x=1729661364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHCRbjbdAz/4L9m7QyVF8NK+nNXYwETwyMu84SQLi/s=;
        b=Ck6rKq6NnTGNvcou04fLYSdKej805C7vPjLdmA4Gh9Nuo47GHBPmHJbqYnQ/gPuwDU
         +ZDjOMjEOTJO1bNCct0Q2Gt7U/fpfEOw6gGQORFAOuFvU4Qjcqj5/8QDxXyeLpcLNZqc
         v/O502VEZgoIwp4f9ej2EXE02cEIeiT1mGQ6iul+O5DLFQHQPEpaihTHe6/QOXWv+f/b
         Yg/dE8ClBLJ4koKoP+7W+GxqkMKEei91rcxb0lCcVtLNPoaQ60/acnezFGu1Z4BQ0jmK
         Xf/CI2aGZlbEamBtDidBmrngA7Jd0K7Qj5eqDfHE4rv+aTiX6LzIHh4xpvQvJFPzHUpS
         XMWA==
X-Forwarded-Encrypted: i=1; AJvYcCXlknelDZUv7nmHMCOS8gCv01/Rw4A/SjSA1G0CoCI3REruuUZ+E2POCTAneq/EthgThr4+WvpkTIea2CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgHnJeTF/GfTo4hfTlKPxmC2ESciLYitrvepAa9vI4f7/fDgj0
	/QD0mvp+zVs9cXbz7MiUVq56Fg24/sBcXzmkgfIqXyQyV/oM4lvZM5CJFiTFvuKAd+GEfJfmI+v
	I7Ef7vX3o44Fd/986kTOOznp6IWqq9hnMjPv7
X-Google-Smtp-Source: AGHT+IHe063J7pXhFLpixFxwYFCOgLDVW7uXhaRIBHNBeflbwaAODLbf8/XMUnernCGwtqA/8rd9MVqwcmkmr63VSIY=
X-Received: by 2002:a05:6102:ccd:b0:4a4:8a29:a902 with SMTP id
 ada2fe7eead31-4a5b59394aemr2515524137.3.1729056564306; Tue, 15 Oct 2024
 22:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014221211.832591-1-weixugc@google.com> <CAOUHufZcmS-RCBf7dY5C5HYXp16GZC0WiaNPugfgTA0XXjMVgQ@mail.gmail.com>
In-Reply-To: <CAOUHufZcmS-RCBf7dY5C5HYXp16GZC0WiaNPugfgTA0XXjMVgQ@mail.gmail.com>
From: Wei Xu <weixugc@google.com>
Date: Tue, 15 Oct 2024 22:29:11 -0700
Message-ID: <CAAPL-u8M4-i=76prAuRws1_Jvp3+fkYY3gHDgEpZ7VP45KY39Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/mglru: only clear kswapd_failures if reclaimable
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 9:57=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Mon, Oct 14, 2024 at 4:12=E2=80=AFPM Wei Xu <weixugc@google.com> wrote=
:
> >
> > lru_gen_shrink_node() unconditionally clears kswapd_failures, which
> > can prevent kswapd from sleeping and cause 100% kswapd cpu usage even
> > when kswapd repeatedly fails to make progress in reclaim.
> >
> > Only clear kswap_failures in lru_gen_shrink_node() if reclaim makes
> > some progress, similar to shrink_node().
> >
> > Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
> > Signed-off-by: Wei Xu <weixugc@google.com>
> > ---
> >  mm/vmscan.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 50dc06d55b1d..9d1e1c4e383d 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -4970,8 +4970,8 @@ static void lru_gen_shrink_node(struct pglist_dat=
a *pgdat, struct scan_control *
> >
> >         blk_finish_plug(&plug);
> >  done:
>
> Nit: the "done:" isn't used anymore, so better just remove it.
>

"goto done" is still used at the beginning of lru_gen_shrink_node().
We can refactor the code to remove it. But it is better to be handled
in a separate change.

> > -       /* kswapd should never fail */
> > -       pgdat->kswapd_failures =3D 0;
> > +       if (sc->nr_reclaimed > reclaimed)
> > +               pgdat->kswapd_failures =3D 0;
> >  }
> >
> >  /*********************************************************************=
*********
> > --
> > 2.47.0.rc1.288.g06298d1525-goog
> >
> >

