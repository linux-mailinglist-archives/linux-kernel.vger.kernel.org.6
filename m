Return-Path: <linux-kernel+bounces-348175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF02F98E3B7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62256B23712
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F329E216A01;
	Wed,  2 Oct 2024 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0w5dUew"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A9019340F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727898623; cv=none; b=uclZAThag0vZ/KQNBl0q1KiPOII4M2yalekDbf+/1UzlwQMQbdv813VU0A7uUoqzjxbu97dWdNh32iZivtfojdvKs+2jinKlVBE9it3DNv+prXWLoM8w3ZSMgZRxF5gKrsgHAIwYcgs+kZCqbntlTNJM6X+SSlKGQZTeqYx/7fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727898623; c=relaxed/simple;
	bh=X22xA0HVBMdR1IzTT9swdvQ2PUQOGMD8pwumUfbnWOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPGwOGy9eQH4x82p2h+mbeRM5ebe8O/Ka/JQq9JNjMmvVkKrbdjfhJt+AtD+bfDofTOO6SDcc3brHaPzlGZCHfCvln7NvGZXB2o1kEEy5pClP1Jd0QSI0AY7kAmNWI5O5vxEIqZGDHztvliTmgc5GlRXE9xWWHaqtpIJJRNvlb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N0w5dUew; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5398cc8773dso6280e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 12:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727898620; x=1728503420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sb4jGv4oiF+aP2ySUIWh2+NAs6/SQ53nUQHq1ghlQgY=;
        b=N0w5dUewGKzgulhTcX0XyepyvLByJhR4NODp5PnuxJ30Kr5sgc2Wle86Aq53m0fO/m
         WW1yYid/169sBhKwwwmKLisewWV2BfHOZ15sKYz5gBaqg9WDdrzdVYwuBBMD4oscykHJ
         ZMPt2yX5vHDfZJIETKaqXN5Urr+LC/qZGf0fhd17rKh52n5b5naUrmNiCIe5jWACBYcS
         ci/J2CBy2AIaJk0+ef7FYGEXZJiWAq2OS6V0TMtIT8/H9U1gf66Nz66FoOqkyKI0AWeI
         tNG8tBXRQngSVDBPap8vlZkYmpfIkZs/teRp7jIWnSZt2bBlfGvvhYjUEwzEYZDh+IJC
         tzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727898620; x=1728503420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sb4jGv4oiF+aP2ySUIWh2+NAs6/SQ53nUQHq1ghlQgY=;
        b=fEKi0sLOlTZcK1e+pjV9WCuYNDLA67QXSO2mSzEs4WssaGs0CoyvvndDW9zQtEkLzU
         +7W5plHVDz8AK0sCtemUDvlca41aFfL+CwsMiamkRzVxSOrOeLSNP8R7fUnERpYKse7y
         GAPRW+4ojskGPBOsdStqQt7T9c5JXLAxUrGgtdIFuMQw6rlTI1H/1Eh/hbQTPKFkdMg6
         7uH386RJXxS+B49UGMkJLspEJT1M9jnXQFVPdP7oFtFvpVpBD/rAlAv8nGRuzL2D+T/C
         q90zy6HXG76tMkkXfxKrpmM+2pmxloVBy8fktD0mjlJ6fyoIEXL96zHqRwfy2Q75otbg
         jlKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9e4kRqapNqyESUUm1e8cXwLgBP/OkC+cdjorju5OjeB4yItv3RDUcJG3XDtk3p16r7A543/VejPUHgkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqnlqiNl2qcA80xKEogWU8kX0M++mma6AV+kNPtKtKJwaLrHd3
	hQtgezOkg0adL5KId4+cq3me8ObqkRrt0p95vBMnKcwsnOkBnBTBFjxkSnF+Lt8YJLKnHhkuzAm
	7HjqcitaQxdRDh2UNkjPdAnXDJXkJKUZ77TPrU+KeE2PHTuIcsOSrrdxKhQ==
X-Google-Smtp-Source: AGHT+IGN5UynQItc9q1qMYS3sPfmE8YHPi7E0D9y5ZC5A7Q1slUP8RRtIijrFYkR2iXbgCBqJqGkp44KTdfpR/G9fG4=
X-Received: by 2002:a05:6512:b07:b0:52e:8a42:f152 with SMTP id
 2adb3069b0e04-539a6ed8df1mr69482e87.5.1727898619453; Wed, 02 Oct 2024
 12:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929032757.404707-1-gxxa03070307@gmail.com> <f8dde346-8a81-4cca-8497-987f6e4b5e58@redhat.com>
In-Reply-To: <f8dde346-8a81-4cca-8497-987f6e4b5e58@redhat.com>
From: Frank van der Linden <fvdl@google.com>
Date: Wed, 2 Oct 2024 12:50:08 -0700
Message-ID: <CAPTztWY-CD9REdJq_-HeELJ+dX68+OZC76T0F+YMyZKMc-DHug@mail.gmail.com>
Subject: Re: [PATCH v2] mm/cma: print total and used count in cma_alloc()
To: David Hildenbrand <david@redhat.com>
Cc: Xiang Gao <gxxa03070307@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, gaoxiang17 <gaoxiang17@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 2:34=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 29.09.24 05:27, Xiang Gao wrote:
> > From: gaoxiang17 <gaoxiang17@xiaomi.com>
> >
>
> We should add here
>
> "To debug CMA allocations (especially failing ones), it is valuable to
> know the state of CMA: how many pages out of the total ones are
> allocated, and how many were requested to be allocated. Let's print
> some more information."
>
> I assume Andrew can fix that up when applying.
>
> > before:
> > [   24.407814] cma: cma_alloc(cma (____ptrval____), name: reserved, cou=
nt 1, align 0)
> > [   24.413397] cma: cma_alloc(cma (____ptrval____), name: reserved, cou=
nt 1, align 0)
> > [   24.415886] cma: cma_alloc(cma (____ptrval____), name: reserved, cou=
nt 1, align 0)
> >
> > after:
> > [   24.069738] cma: cma_alloc(cma (____ptrval____), name: reserved, tot=
al pages: 16384, used pages: 64, request pages: 1, align 0)
> > [   24.075317] cma: cma_alloc(cma (____ptrval____), name: reserved, tot=
al pages: 16384, used pages: 65, request pages: 1, align 0)
> > [   24.078455] cma: cma_alloc(cma (____ptrval____), name: reserved, tot=
al pages: 16384, used pages: 66, request pages: 1, align 0)
> >
> > Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
> > ---
> >   mm/cma.c | 15 +++++++++++++--
> >   1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/cma.c b/mm/cma.c
> > index 2d9fae939283..90b3fdbac19c 100644
> > --- a/mm/cma.c
> > +++ b/mm/cma.c
> > @@ -403,6 +403,17 @@ static void cma_debug_show_areas(struct cma *cma)
> >       spin_unlock_irq(&cma->lock);
> >   }
> >
> > +static unsigned long cma_get_used_pages(struct cma *cma)
> > +{
> > +     unsigned long used;
> > +
> > +     spin_lock_irq(&cma->lock);
> > +     used =3D bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
> > +     spin_unlock_irq(&cma->lock);
>
> This adds overhead to each allocation, even if debug outputs are ignored
> I assume?
>
> I wonder if we'd want to print these details only when our allocation
> failed?
>
> Alternatively, we could actually track how many pages are allocated in
> the cma, so we don't have to traverse the complete bitmap on every
> allocation.
>

Yep, that's what I did as part of
https://lore.kernel.org/all/20240724124845.614c03ad39f8af3729cebee6@linux-f=
oundation.org/T/

That patch didn't make it in (yet). I'm happy for it to be combined
with this one if that's easier.

- Frank

