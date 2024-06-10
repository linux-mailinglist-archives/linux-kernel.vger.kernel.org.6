Return-Path: <linux-kernel+bounces-208662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D869027D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673381C2157C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E000014D2A3;
	Mon, 10 Jun 2024 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smQ+bCra"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AD914BF89
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040994; cv=none; b=Lssg8jL2k/jOS9i5Um2p8aWeaRu4xH3yVA0BrefTMpySih7FVRiBeMx705/tgLTa+4QJyWiSb8Zs+viCFshHkZ6wDHybcbakJrHAwUQJ6Eki0Y9J0ajZfnEJnLJlz2TOnviwZmAwi/et/81ngQyed4oV7xmnIyVoVlsK0P22tz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040994; c=relaxed/simple;
	bh=y+uDpOxTiI90Z0rYst7WMhozs021EoRaJXDZTXBdl4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/oAI6CczEug/4B6BToBQGxxpecidbql3fWcIKMcYPCk16WD9iE7NBAJNxPZsPdtCgmW4ICo1gHWjqcLTx/gdcMAZqw/ZoVXv4Gq0KGwibI2Bg0PFSXVgnTsJZecun1QC2oWNip6ds1KYxeojmcliY1CpQTXEZ/0i01xwOUQKmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smQ+bCra; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6f1c4800easo165200266b.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718040991; x=1718645791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dU1wp/8ID9GZkzO9MN6hzBQi84cW9f85LsgOI6MzdBM=;
        b=smQ+bCrax6f2Z50WCDNYyedoxZKyOWqR/CYQ7hJ691CRiXFuslzL4yQ3qW/D+Tvbz3
         XtcmIzAvmCygxmOy5/yOEJh5spMHIHLTdmcRrdW4us8FxFOw1V/1EnyuNkQ9qRkIwZMs
         I5mGJ4AxF34961opHBEvBGBqoDWSFfuazQTyuchEf9D+rv7RE34xKjRrg4+JFSL2HWR+
         28AvUqYNt+EWQOk014ZBILHN3Z1j7puA6Cbu/MkfLr+zoPbB+cHLArZ0g85z4JuJVE52
         gTX0Qghy9GbovsBgcU+tG5VT2qriC+M/iGLefRZYm5EH6g7RYwpXM8Y5jKGuJGPt8UAR
         CrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718040991; x=1718645791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dU1wp/8ID9GZkzO9MN6hzBQi84cW9f85LsgOI6MzdBM=;
        b=opwmJj4uepJ6kBNq2P4fIoY6UjLtZC+DhZqPmZdBfsY5eIqBBRk4tRBsjxH5s3Tolb
         hVAqf6bRbpHDIF116mvtbLumlDlwRh4Uw6r1ns76BJU6OwZvjsn0zgNPvtEtchPmt723
         wZxGoRKQy1P8rKf42OOc55O4gvEAwd/ZbDw0MJMoUDKxCvAC2j0205Cv5cSg7kuzrAsm
         0JtuZxA4fbJmabLq0fArUzo50Li4guKtHG/rJy8JlmkCRmdcOHLbLfcj9HWrlQTTnCo4
         tv6rxDgY3U3DBypytzeXRV9nNyUfcLbkkfv30M6JwBl6wDsgI2DZN1njUcDjEAu2iSpB
         7ivw==
X-Forwarded-Encrypted: i=1; AJvYcCVEtd9oAbIbnkqoZvct+AthRaFNnAU/qmTTHv+2RNTE8Ry8cZtskTFyKXyoU2g4Bff/wVIh1NkU6LOMnDIQQh5JaqmK1Uc1Z2FQTxbP
X-Gm-Message-State: AOJu0YyZPVTNsKjOJe4M0NazeCB6Q2BDPK0ns4oxhDn8W6SXnIkolHD/
	9lbYIh4BCkmXaFvfwnuwSOoO5jJ6tA5a9flnAIHzAV2qKD7isqcbJbeO2jnxc6y8MWTg/aQlvtj
	+LmPUeCb3n/2UWYG+voksGJzz/WXqyTTZTXow
X-Google-Smtp-Source: AGHT+IGFJqcSp8XShUaYALJ4Wx844rcf/dAaD5tsaciA5uNA6+bXzdDsjJKkkmvkFTaD/iDvHjV/GNRzuOlKzPKT1+g=
X-Received: by 2002:a17:906:52d8:b0:a6e:f7b5:3189 with SMTP id
 a640c23a62f3a-a6ef7b539c6mr508030966b.76.1718040990435; Mon, 10 Jun 2024
 10:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608023654.3513385-1-yosryahmed@google.com> <2821278f-bc94-c147-d0fe-8cc52dbdccb1@redhat.com>
In-Reply-To: <2821278f-bc94-c147-d0fe-8cc52dbdccb1@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 10 Jun 2024 10:35:54 -0700
Message-ID: <CAJD7tkYepf6z1Q7HiSRAc7-S9OwYCphx=9NcyHxtW0YrkFv0sQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: handle incorrect attempts to load of large folios
To: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <21cnbao@gmail.com>, 
	Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 9:08=E2=80=AFPM Mika Penttil=C3=A4 <mpenttil@redhat.=
com> wrote:
>
> On 6/8/24 05:36, Yosry Ahmed wrote:
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index b9b35ef86d9be..ebb878d3e7865 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1557,6 +1557,26 @@ bool zswap_load(struct folio *folio)
> >
> >       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >
> > +     /*
> > +      * Large folios should not be swapped in while zswap is being use=
d, as
> > +      * they are not properly handled. Zswap does not properly load la=
rge
> > +      * folios, and a large folio may only be partially in zswap.
> > +      *
> > +      * If any of the subpages are in zswap, reading from disk would r=
esult
> > +      * in data corruption, so return true without marking the folio u=
ptodate
> > +      * so that an IO error is emitted (e.g. do_swap_page() will sigfa=
ult).
> > +      *
> > +      * Otherwise, return false and read the folio from disk.
> > +      */
> > +     if (folio_test_large(folio)) {
> > +             if (xa_find(tree, &offset,
> > +                         offset + folio_nr_pages(folio) - 1, XA_PRESEN=
T)) {
> > +                     WARN_ON_ONCE(1);
> > +                     return true;
> > +             }
>
> How does that work? Should it be xa_find_after() to not always find
> current entry?

By "current entry" I believe you mean the entry corresponding to
"offset" (i.e. the first subpage of the folio). At this point, we
haven't checked if that offset has a corresponding entry in zswap or
not. It may be on disk, or zwap may be disabled.

>
> And does it still mean those subsequent entries map to same folio?

If I understand correctly, a folio in the swapcache has contiguous
swap offsets for its subpages. So I am assuming that the large folio
swapin case will adhere to that (i.e. we only swapin a large folio if
the swap offsets are contiguous). Did I misunderstand something here?

>
>
> --Mika
>
>

