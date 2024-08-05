Return-Path: <linux-kernel+bounces-275493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7FF948676
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF242B230E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76FA16EBF4;
	Mon,  5 Aug 2024 23:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOhRcbcq"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617D016D9DD
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 23:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902325; cv=none; b=uKSIxU2EP2zcvHXNTk+r5VJZWDlimXeaDcV4pFHUiVnoghcIrPpl0OSh7dKRSi2epQwqr/tH14YcvNLFAVVsZ7+Fj8OD7oR6TdXsKPlEWYx+ffXqFqrMAddlkrmd5M30KDegn3dPFXV1Rj4EmDXcP5dIEj2h7dGtWU9pIHuQtTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902325; c=relaxed/simple;
	bh=HE7iNn2NDlUw1mc8XnNzsxOuK2NZD3N1Yoq1DReuLqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kepAfVN/VEtFZauGD247IV2s6RH/fLyptJJSZZO7JIu+VAj0T71WeVacEWHWxxRWOWYIdqNFHShBkGU/eq2z+pduvEeXO/MNYXNdT8TTflUD5b3Vkqkk/PTNJYXYvylz6MvPNkyxMpx8KWE455azrl3e9k29YgTCMhOrFbBMBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QOhRcbcq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso10163566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 16:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722902322; x=1723507122; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cQU7vbPtaOjGnv/hbhN+ll2t7sFr0pUqNwdbWYE25jw=;
        b=QOhRcbcqtaUD01DMVdYVJ8FwjRlmnOcU0nKx9x7SLqj8uxAd73/UjsjAuP6w22k0bh
         InNEExnmMOtJvtQgZ/S+s3Sy0CRaObyM9BEKuVJU012t9o07Im2cNaseDk1yCoYqZwvQ
         cN2R7jdeQTAEqS11NmEvYfmIQEGxAzLpqAkYZgAu7dDoUZyp5/ypp5vipb47GWYL+jsM
         nbADFt923+DtP6iX45dKhWsnGe4heqzXyXA6+kZig/CoDWaP7uD3YOZBeg5CbaDHRMwY
         79Uv7Md/xYvePrFapUS3L4nZS5TZHVywr7lC/FT6e1aTrqWJ4Yxkh6YHEeKExjp5ZOoW
         X/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722902322; x=1723507122;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQU7vbPtaOjGnv/hbhN+ll2t7sFr0pUqNwdbWYE25jw=;
        b=E6plh+/+KzmtTAFnb2uB5XRyY/r1ZnLjNKL+jqnF3NvyGVQpMwAakqh0Rsv+hn1699
         F78j8XKAN1hDIFFEaf5JOpS7nszQg+kcq7o2+3Hmnz4mGepTzKj76KCV93e/eWpnez19
         9ub0FlAkCbp7PMHSyoUmtP8Ypnwx2fpg9JfJ5XfI8Qbm5UDBbe+sagy58XclECj1+I7N
         JpFSn9xk4uS4fN1kUMIoqK1CEpDFWjnCHpyx5zCAGT/b6OWjCLedFkeO50KUAdyfVk/h
         rIHufva94BUKLsBuieEZHhy2qu8/52yetlXq6hgY9EeO+H597ZQvDrRdlzVlpB5J5374
         Ounw==
X-Forwarded-Encrypted: i=1; AJvYcCXSPD83NGSImATAoz2wbFDNE39o9i9h83TlnEZY3sdk0ZOjQh45xRfXW1HkQaAcHl+ebacJPmetco4h9CQFX0yVdgLGWSqg6qptqL7S
X-Gm-Message-State: AOJu0YxVLq/jema5nXaRJ1f1QIAU4S1yQ4PI8SyafXHF+4n4AUaRZvcX
	3qm16fWima6R975Dm77w7cSNFs7jSp38ZxSxSjTc8408jLtqCe8betUiyqbsKGYKk0VY2HTrUbs
	mwVj9fzoI1J0sJtpjpIG3JBJAEnPKORO9h452
X-Google-Smtp-Source: AGHT+IFhzRWuwR+Bscc36sL5v+77kZ17PKyFf336ahwHyrg3XZAIIO4MGEqH31ONzuCB1w/8YnlnkSEK4Uq5DsRxr2s=
X-Received: by 2002:a17:907:7e87:b0:a7a:ab8a:391 with SMTP id
 a640c23a62f3a-a7dc509fc5dmr1018125166b.45.1722902321079; Mon, 05 Aug 2024
 16:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730222707.2324536-1-nphamcs@gmail.com> <20240730222707.2324536-2-nphamcs@gmail.com>
 <CAJD7tkYujNCPzrXfmRqFYESeAnrzgJYys-R_=Ftx=rJkUuhBWw@mail.gmail.com> <CAKEwX=M24GgiAHbwEqef=rBT94SvSnHwX-zKz78WO+C9HjJjOQ@mail.gmail.com>
In-Reply-To: <CAKEwX=M24GgiAHbwEqef=rBT94SvSnHwX-zKz78WO+C9HjJjOQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 5 Aug 2024 16:58:04 -0700
Message-ID: <CAJD7tkbE+RihoMWG2hKt4PmSoHGmYxeoaz5fmwiQifDGbqU56Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] zswap: implement a second chance algorithm for
 dynamic zswap shrinker
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	flintglass@gmail.com, chengming.zhou@linux.dev
Content-Type: text/plain; charset="UTF-8"

[..]
> > > @@ -1167,25 +1189,6 @@ static unsigned long zswap_shrinker_scan(struct shrinker *shrinker,
> > >                 return SHRINK_STOP;
> > >         }
> > >
> > > -       nr_protected =
> > > -               atomic_long_read(&lruvec->zswap_lruvec_state.nr_zswap_protected);
> > > -       lru_size = list_lru_shrink_count(&zswap_list_lru, sc);
> > > -
> > > -       /*
> > > -        * Abort if we are shrinking into the protected region.
> > > -        *
> > > -        * This short-circuiting is necessary because if we have too many multiple
> > > -        * concurrent reclaimers getting the freeable zswap object counts at the
> > > -        * same time (before any of them made reasonable progress), the total
> > > -        * number of reclaimed objects might be more than the number of unprotected
> > > -        * objects (i.e the reclaimers will reclaim into the protected area of the
> > > -        * zswap LRU).
> > > -        */
> > > -       if (nr_protected >= lru_size - sc->nr_to_scan) {
> > > -               sc->nr_scanned = 0;
> > > -               return SHRINK_STOP;
> > > -       }
> > > -
> >
> > Do we need a similar mechanism to protect against concurrent shrinkers
> > quickly consuming nr_swapins?
>
> Not for nr_swapins consumption per se, and the original reason why I
> included this (racy) check is just so that concurrent reclaimers do
> not disrespect the protection scheme. We had no guarantee that we
> wouldn't just reclaim into the protected region (well even with this
> racy check technically). With the second chance scheme, a "protected"
> page (i.e with its referenced bit set) would not be reclaimed right
> away - a shrinker encountering it would have to "age" it first (by
> unsetting the referenced bit), so the intended protection is enforced.
>
> That said, I do believe we need a mechanism to limit the concurrency
> here. The amount of pages aged/reclaimed should scale (linearly?
> proportionally?) with the reclaim pressure, i.e more reclaimers ==
> more pages reclaimed/aged, so the current behavior is desired.
> However, at some point, if we have more shrinkers than there are work
> assigned to each of them, we might be unnecessarily wasting resources
> (and potentially building up the nr_deferred counter that we discussed
> in v1 of the patch series). Additionally, we might be overshrinking in
> a very short amount of time, without letting the system have the
> chance to react and provide feedback (through swapins/refaults) to the
> memory reclaimers.
>
> But let's do this as a follow-up work :) It seems orthogonal to what
> we have here.

Agreed, as long as the data shows we don't regress by removing this
part I am fine with doing this as a follow-up work.

>
> > > -        * Subtract the lru size by an estimate of the number of pages
> > > -        * that should be protected.
> > > +        * Subtract the lru size by the number of pages that are recently swapped
> >
> > nit: I don't think "subtract by" is correct, it's usually "subtract
> > from". So maybe "Subtract the number of pages that are recently
> > swapped in from the lru size"? Also, should we remain consistent about
> > mentioning that these are disk swapins throughout all the comments to
> > keep things clear?
>
> Yeah I should be clearer here - it should be swapped in from disk, or
> more generally (accurately?) swapped in from the backing swap device
> (but the latter can change once we decoupled swap from zswap). Or
> maybe swapped in from the secondary tier?
>
> Let's just not overthink and go with swapped in from disk for now :)

Agreed :)

I will take a look at the new version soon, thanks for working on this.

