Return-Path: <linux-kernel+bounces-198592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6BF8D7AC3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C701C21511
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 04:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093A217BB9;
	Mon,  3 Jun 2024 04:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ufc/Fcf3"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A5910F1
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 04:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717388847; cv=none; b=DKXYTqTbTcJcfhMlLxGW0QglBZLb6IxvdnC42+8W/MRqur25kv2ElmfNq+20rCIeak8RVm3WH/t2NHkv83y2P9JL1UT2zu8Zoo6O9AZbZ3LivMWypX605xuau7IxxWhz766+YPyAGaRfLUpWCN2nc0TZ2XYAPRQ3p0Vc91AVO2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717388847; c=relaxed/simple;
	bh=t9uHrRS4KFkljpjCuYI2/7oYBr0iY+/XkHCfMqpyTYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4wJH7olKGz3gnn6d1CNP1yMCt9/dAG9O0UjFXBa6GyNuz0r+uyUwZFrGn93ttK1TPK17oB+75vYxS3883LgvWVkFEB2DnDgc33swNLldtT1PdBcLQhUyx5FoDnD/SPam6zdCKI4TRgqQkbQZROXQjBYPUPogiyPPPA0aUDrGt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ufc/Fcf3; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52965199234so4377782e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 21:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717388843; x=1717993643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9qPC6w1NV4TD2a+FwRxTwDP6kMv2SLCKMCaWmtBFqU=;
        b=Ufc/Fcf3SDj8SQm6ijscxK5sbGhXKdd5keBMVbPPG36r2mQW1ug5upJxEsgEi2Cg1k
         BiJbcThvmlCvLJQ/Mh+LfbEBxY8djDJFodJqjlFwOomk0UrTDMOTkV0jC42ofEX5cMH6
         ZW0/3euc8/hCxu4TV+Cm1NNt5W8F3+6TtfqjbMSQeQzILRFIduWAwHbqksS9Q9JlDeBh
         tg6pQDfxYQffII2BpH3lNqjWQk6K6T4M74rxYaOWtwQ7rkHhSy63SKYJT3AHJ6tcAGwH
         hBqjvKcMhHnIvZMEO/HSiAxVo7s3HHdSc91CfrlmuxX1PtMUZzJ7wZiq/evQpVFSUkqr
         T5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717388843; x=1717993643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h9qPC6w1NV4TD2a+FwRxTwDP6kMv2SLCKMCaWmtBFqU=;
        b=jF5BJYMfR5U3DWSIhu6IyaEzVgjMtOpBTz+2SPgDqz2n/R7McF3G0aWePZdLfxGKQN
         WGyDMlGUNdyy1VES9Ocqbx9lEv8Lh+Q8wLx1cAlkebgH3VWHsGZW162f3atOGoLrs6Gj
         2V3pvuYsCnIVItmuG+ruy9r44LI0XzXtZnjmWFhTv8vfpVVTZBAyFjMrGugTMNrH4oql
         /ZWrIJE6QBZtE7GuVYzj2tU1iATtqbqmife23g7MHSDEeksqmzvEUyEYmxtt8Jg12yg4
         dBTU1dOccFKxBPktwzDWZ+WYFfyXSWldC1kekDp7xoicS+rgsFVretIAzb+KkxJKLWtu
         hVkw==
X-Forwarded-Encrypted: i=1; AJvYcCUWVwVDVfKjDCi7QnTKp1IkZKFtoTp8uOfghw2mBBlfWIIlht1zYpv/kpE3Xfoszy1fU2GxOcqPdTOSzPWPiu7wmx+xDzkXo75I2CEA
X-Gm-Message-State: AOJu0YwiRBWk+tCqnu7ewR13/W8+WNXcxqEWvIzcTDdxcWX/ZJXmUAMZ
	QRHXJzxDhkhPx8+77w6NeICDQ6ncxtOt3LmDxWBO+mBm5Zwnt1r069LdnWpLmuDK1El0lGXPTar
	h2GmvAwO9gvezAecttzLP2Wz34ig=
X-Google-Smtp-Source: AGHT+IGfPkHs5bDh5yAfeHOJLWnOKEj2ZHrjS6wPzQziS2Fnw04L03cMa96XkUhTXnCZhJ+UwC0E8fmq+ee9Roh9d6s=
X-Received: by 2002:ac2:544c:0:b0:51c:a0e1:2a44 with SMTP id
 2adb3069b0e04-52b8957f627mr4896967e87.26.1717388843141; Sun, 02 Jun 2024
 21:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603033118.76457-1-ioworker0@gmail.com> <CAGsJ_4wxPk+bk9UM+PvA3x=LJG+mWmTD3e2HSEsS83X3vMWTJQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4wxPk+bk9UM+PvA3x=LJG+mWmTD3e2HSEsS83X3vMWTJQ@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Mon, 3 Jun 2024 12:27:09 +0800
Message-ID: <CAK1f24=30RmJ2s0pqVNyj--BuB78k3P_2tXNsezAFQOnmqoa7w@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/mlock: implement folio_mlock_step() using folio_pte_batch()
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com, 
	baolin.wang@linux.alibaba.com, ziy@nvidia.com, fengwei.yin@intel.com, 
	ying.huang@intel.com, libang.li@antgroup.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Barry,

Thanks for taking time to review!

On Mon, Jun 3, 2024 at 12:14=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Mon, Jun 3, 2024 at 3:31=E2=80=AFPM Lance Yang <ioworker0@gmail.com> w=
rote:
> >
> > Let's make folio_mlock_step() simply a wrapper around folio_pte_batch()=
,
> > which will greatly reduce the cost of ptep_get() when scanning a range =
of
> > contptes.
> >
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >  mm/mlock.c | 23 ++++++-----------------
> >  1 file changed, 6 insertions(+), 17 deletions(-)
> >
> > diff --git a/mm/mlock.c b/mm/mlock.c
> > index 30b51cdea89d..1ae6232d38cf 100644
> > --- a/mm/mlock.c
> > +++ b/mm/mlock.c
> > @@ -307,26 +307,15 @@ void munlock_folio(struct folio *folio)
> >  static inline unsigned int folio_mlock_step(struct folio *folio,
> >                 pte_t *pte, unsigned long addr, unsigned long end)
> >  {
> > -       unsigned int count, i, nr =3D folio_nr_pages(folio);
> > -       unsigned long pfn =3D folio_pfn(folio);
> > -       pte_t ptent =3D ptep_get(pte);
> > -
> > -       if (!folio_test_large(folio))
> > +       if (likely(!folio_test_large(folio)))
> >                 return 1;
> >
> > -       count =3D pfn + nr - pte_pfn(ptent);
> > -       count =3D min_t(unsigned int, count, (end - addr) >> PAGE_SHIFT=
);
> > -
> > -       for (i =3D 0; i < count; i++, pte++) {
> > -               pte_t entry =3D ptep_get(pte);
> > -
> > -               if (!pte_present(entry))
> > -                       break;
> > -               if (pte_pfn(entry) - pfn >=3D nr)
> > -                       break;
> > -       }
> > +       const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DI=
RTY;
> > +       int max_nr =3D (end - addr) / PAGE_SIZE;
> > +       pte_t ptent =3D ptep_get(pte);
> >
> > -       return i;
> > +       return folio_pte_batch(folio, addr, pte, ptent, max_nr, fpb_fla=
gs, NULL,
> > +                              NULL, NULL);
> >  }
>
> what about a minimum change as below?

Nice, that makes sense to me ;)
I'll adjust as you suggested.

Thanks again for your time!
Lance

> index 30b51cdea89d..e8b98f84fbd2 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -307,26 +307,15 @@ void munlock_folio(struct folio *folio)
>  static inline unsigned int folio_mlock_step(struct folio *folio,
>                 pte_t *pte, unsigned long addr, unsigned long end)
>  {
> -       unsigned int count, i, nr =3D folio_nr_pages(folio);
> -       unsigned long pfn =3D folio_pfn(folio);
> +       unsigned int count =3D (end - addr) >> PAGE_SHIFT;
>         pte_t ptent =3D ptep_get(pte);
> +       const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRT=
Y;
>
>         if (!folio_test_large(folio))
>                 return 1;
>
> -       count =3D pfn + nr - pte_pfn(ptent);
> -       count =3D min_t(unsigned int, count, (end - addr) >> PAGE_SHIFT);
> -
> -       for (i =3D 0; i < count; i++, pte++) {
> -               pte_t entry =3D ptep_get(pte);
> -
> -               if (!pte_present(entry))
> -                       break;
> -               if (pte_pfn(entry) - pfn >=3D nr)
> -                       break;
> -       }
> -
> -       return i;
> +       return folio_pte_batch(folio, addr, pte, ptent, count, fpb_flags,=
 NULL,
> +                              NULL, NULL);
>  }
>
>
>
> >
> >  static inline bool allow_mlock_munlock(struct folio *folio,
> > --
> > 2.33.1
> >

