Return-Path: <linux-kernel+bounces-428759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 105549E12FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC34282B8F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70C715CD78;
	Tue,  3 Dec 2024 05:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUyIupNy"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2485AD51
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 05:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733205012; cv=none; b=MGDBo7pToSIe31JQEvhd5VqHg+Tas6qMkH38p3Y6FjfhuInheulzBigAmf4J/3f0xJJzfpcn8a6yhHxic36Ex0FC1V3k74N2nj1INe2YpTAkH44eUHr4tdYVyZRWKNhNJ+jmsbMvbWSKY2XxM3k+q3bbh+KGdqfV7v6WUVPD8BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733205012; c=relaxed/simple;
	bh=YBvjOJ+T6VRPfqIKEQcQh9ly9nPaJOt1XyHka7uloLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0XkTs6lDnqp6ZMwzuDkXRFX5M16E2SDb7Bki+Z903HffjizK2YC5i57Q1WdS8e9Sc/dYJHh0fqzj60JuYRURbysHBxpAE9VGSWTZeGaYsvwAMZpFsRFpTPra1Gz3uWe2IYR20GvoisuDJS9nypmJCSM8SyrIwrnRqrKMaeVI00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bUyIupNy; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ef7f8d4f30so23822247b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 21:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733205009; x=1733809809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCNIMTjnW7Pm1TEcHWt8TE+HaVex4OhWuGsdWimbvkM=;
        b=bUyIupNys/vy6x3411NPqI3fLv+KMWJ0tZH3WkEepAEyModiFfaofHX6UHHY6nvhlj
         Fijz9hgJBG7THWLD3ONo2r+BukOWytUUzyb5hHJeS2TjCiCuZRj18mh5Q3W5sQs6Ca53
         w4eTA47xlQrLDOv/U2m9tcdvTkthPIzBcpZZ9CmhKeB4V9LFibhnNeUjUCAgkYuOGGhC
         d0rtdTGBdSKYF+ndKtJ/EiFk1WzfnXXTqusNbxA/AKmeEg9GiuWHRUENde/pBKY0jyEE
         C9fnB3Vm9RH/v3bwGbQ1qdhm229HQd/aHfFGfpT2QipM/Lm2L4Kyhb1Od7MEHW4rCpKt
         IO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733205009; x=1733809809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCNIMTjnW7Pm1TEcHWt8TE+HaVex4OhWuGsdWimbvkM=;
        b=JvsYzz71VSiJyC8n5yFCasPVi3OSXT6bQFAPGRc1FknGMXgxdm70JQ2ISB9LISpzIy
         Yl36g6Evd3HBqj+TWvCGdTGTs7Swp/Q8fBP0s8rcQrqTh0awsdErAvx7AmF0HVVQx3/9
         fO4EdG+R9ZfJHTgs6fXsKZgtC1YJ6lFmCOi3D1FXVq8u39FZq/LCG//0VTJYRKDdKtWK
         Au9tzuCSPg0nK9fGYQLNfaYtOy5Psg+ZLmA+3Y9JJ03O5ze8YsNYWVuhuXxp1aoF79uE
         qpqt8GCrE/k4Cfl3kH9PHJneiLFk2wV3YWCHBwXxghvu6ISJRUEgH0INFLi7oCXq0hy4
         wYWw==
X-Forwarded-Encrypted: i=1; AJvYcCVJDIzBMktvkoTT7kUYLCkYJBZ8GHJ3yxSBQdQ5VCdtfYJn2wrO8S3KAaSrQVQKdbJ0PqsKeyHI3fulrMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCk9gZKt3bdHRz8N8hdw1ipeu8hsigctiEM42eHlbmnOkRAdnt
	5AK3VDpbZAlzqjJUvqB3xm+pNpwsN2riCEWgd1tHLb+mS79SRVHSwvsb1O0gH/Nx7waNemTNrAY
	6SMSM8S6Jni/zewQYFTIJMP+NonvDlT9RrzSy
X-Gm-Gg: ASbGncuJ6PWHiAPVgrK7SOOdDu10+3NWnhVjHTcsNUufT5KygrezfD64U2xm9JWu5A6
	L+QpK6di9O65gWSl1/phHH5r/IZv6
X-Google-Smtp-Source: AGHT+IEq1Q7mg2nIVMC3+8erBp1HUADTRiSvUDUhWnHUsl3QRlIpAyS2mgoMhULUC+gMf0vav1/SIz/BYf6AfpCRQLs=
X-Received: by 2002:a05:690c:6108:b0:6ef:4ba4:ecb0 with SMTP id
 00721157ae682-6eface01549mr20286037b3.6.1733205008633; Mon, 02 Dec 2024
 21:50:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127225324.6770-1-kanchana.p.sridhar@intel.com>
 <20241127225324.6770-3-kanchana.p.sridhar@intel.com> <c9a0f00b-3aeb-467a-8771-a4ebb57fbba0@linux.dev>
 <CAJD7tkbPSQguHegkzN65==GHuNN9_RPm1FonnF8Bi=BsQDhxng@mail.gmail.com>
 <SJ0PR11MB56781233ABFE772C5991AB01C9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <045a786d-7b13-4127-82ce-57510565bd15@linux.dev> <SJ0PR11MB56780123C601DFD5FF46C2A1C9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB56780123C601DFD5FF46C2A1C9362@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 2 Dec 2024 21:49:32 -0800
Message-ID: <CAJD7tkYM=6Mp7zdmrCf1rdQZUg4B2+_oLKVE3hQ0t8vEFqdH=w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mm: zswap: zswap_store_pages() simplifications for batching.
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 8:19=E2=80=AFPM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
>
> > -----Original Message-----
> > From: Chengming Zhou <chengming.zhou@linux.dev>
> > Sent: Monday, December 2, 2024 7:06 PM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>; Yosry Ahmed
> > <yosryahmed@google.com>
> > Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org;
> > hannes@cmpxchg.org; nphamcs@gmail.com; usamaarif642@gmail.com;
> > ryan.roberts@arm.com; 21cnbao@gmail.com; akpm@linux-foundation.org;
> > Feghali, Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vinodh
> > <vinodh.gopal@intel.com>
> > Subject: Re: [PATCH v1 2/2] mm: zswap: zswap_store_pages() simplificati=
ons
> > for batching.
> >
> > On 2024/12/3 09:01, Sridhar, Kanchana P wrote:
> > > Hi Chengming, Yosry,
> > >
> > >> -----Original Message-----
> > >> From: Yosry Ahmed <yosryahmed@google.com>
> > >> Sent: Monday, December 2, 2024 11:33 AM
> > >> To: Chengming Zhou <chengming.zhou@linux.dev>
> > >> Cc: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>; linux-
> > >> kernel@vger.kernel.org; linux-mm@kvack.org; hannes@cmpxchg.org;
> > >> nphamcs@gmail.com; usamaarif642@gmail.com; ryan.roberts@arm.com;
> > >> 21cnbao@gmail.com; akpm@linux-foundation.org; Feghali, Wajdi K
> > >> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> > >> Subject: Re: [PATCH v1 2/2] mm: zswap: zswap_store_pages()
> > simplifications
> > >> for batching.
> > >>
> > >> On Wed, Nov 27, 2024 at 11:00=E2=80=AFPM Chengming Zhou
> > >> <chengming.zhou@linux.dev> wrote:
> > >>>
> > >>> On 2024/11/28 06:53, Kanchana P Sridhar wrote:
> > >>>> In order to set up zswap_store_pages() to enable a clean batching
> > >>>> implementation in [1], this patch implements the following changes=
:
> > >>>>
> > >>>> 1) Addition of zswap_alloc_entries() which will allocate zswap ent=
ries for
> > >>>>      all pages in the specified range for the folio, upfront. If t=
his fails,
> > >>>>      we return an error status to zswap_store().
> > >>>>
> > >>>> 2) Addition of zswap_compress_pages() that calls zswap_compress() =
for
> > >> each
> > >>>>      page, and returns false if any zswap_compress() fails, so
> > >>>>      zswap_store_page() can cleanup resources allocated and return=
 an
> > >> error
> > >>>>      status to zswap_store().
> > >>>>
> > >>>> 3) A "store_pages_failed" label that is a catch-all for all failur=
e points
> > >>>>      in zswap_store_pages(). This facilitates cleaner error handli=
ng within
> > >>>>      zswap_store_pages(), which will become important for IAA comp=
ress
> > >>>>      batching in [1].
> > >>>>
> > >>>> [1]: https://patchwork.kernel.org/project/linux-
> > mm/list/?series=3D911935
> > >>>>
> > >>>> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> > >>>> ---
> > >>>>    mm/zswap.c | 93 +++++++++++++++++++++++++++++++++++++++++-
> > ---
> > >> ---------
> > >>>>    1 file changed, 71 insertions(+), 22 deletions(-)
> > >>>>
> > >>>> diff --git a/mm/zswap.c b/mm/zswap.c
> > >>>> index b09d1023e775..db80c66e2205 100644
> > >>>> --- a/mm/zswap.c
> > >>>> +++ b/mm/zswap.c
> > >>>> @@ -1409,9 +1409,56 @@ static void shrink_worker(struct work_struc=
t
> > >> *w)
> > >>>>    * main API
> > >>>>    **********************************/
> > >>>>
> > >>>> +static bool zswap_compress_pages(struct page *pages[],
> > >>>> +                              struct zswap_entry *entries[],
> > >>>> +                              u8 nr_pages,
> > >>>> +                              struct zswap_pool *pool)
> > >>>> +{
> > >>>> +     u8 i;
> > >>>> +
> > >>>> +     for (i =3D 0; i < nr_pages; ++i) {
> > >>>> +             if (!zswap_compress(pages[i], entries[i], pool))
> > >>>> +                     return false;
> > >>>> +     }
> > >>>> +
> > >>>> +     return true;
> > >>>> +}
> > >>>
> > >>> How about introducing a `zswap_compress_folio()` interface which
> > >>> can be used by `zswap_store()`?
> > >>> ```
> > >>> zswap_store()
> > >>>          nr_pages =3D folio_nr_pages(folio)
> > >>>
> > >>>          entries =3D zswap_alloc_entries(nr_pages)
> > >>>
> > >>>          ret =3D zswap_compress_folio(folio, entries, pool)
> > >>>
> > >>>          // store entries into xarray and LRU list
> > >>> ```
> > >>>
> > >>> And this version `zswap_compress_folio()` is very simple for now:
> > >>> ```
> > >>> zswap_compress_folio()
> > >>>          nr_pages =3D folio_nr_pages(folio)
> > >>>
> > >>>          for (index =3D 0; index < nr_pages; ++index) {
> > >>>                  struct page *page =3D folio_page(folio, index);
> > >>>
> > >>>                  if (!zswap_compress(page, &entries[index], pool))
> > >>>                          return false;
> > >>>          }
> > >>>
> > >>>          return true;
> > >>> ```
> > >>> This can be easily extended to support your "batched" version.
> > >>>
> > >>> Then the old `zswap_store_page()` could be removed.
> > >>>
> > >>> The good point is simplicity, that we don't need to slice folio
> > >>> into multiple batches, then repeat the common operations for each
> > >>> batch, like preparing entries, storing into xarray and LRU list...
> > >>
> > >> +1
> > >
> > > Thanks for the code review comments. One question though: would
> > > it make sense to trade-off the memory footprint cost with the code
> > > simplification? For instance, lets say we want to store a 64k folio.
> > > We would allocate memory for 16 zswap entries, and lets say one of
> > > the compressions fails, we would deallocate memory for all 16 zswap
> > > entries. Could this lead to zswap_entry kmem_cache starvation and
> > > subsequent zswap_store() failures in multiple processes scenarios?
> >
> > Ah, I get your consideration. But it's the unlikely case, right?
> >
> > If the case you mentioned above happens a lot, I think yes, we should
> > optimize its memory footprint to avoid allocation and deallocation.
>
> Thanks Chengming. I see your point. Let me gather performance data
> for the two options, and share.

Yeah I think we shouldn't optimize for the uncommon case, not until
there's a real problem that needs fixing.

>
> >
> > On the other hand, we should consider a folio would be compressed
> > successfully in most cases. So we have to allocate all entries
> > eventually.
> >
> > Based on your consideration, I think your way is ok too, although
> > I think the patch 2/2 should be dropped, since it hides pages loop
> > in smaller functions, as Yosry mentioned too.
>
> My main intent with patch 2/2 was to set up the error handling
> path to be common and simpler, whether errors were encountered
> during compression/zpool_malloc/xarray store. Hence, I initialize the
> allocated zswap_entry's handle in zswap_alloc_entries() to ERR_PTR(-EINVA=
L),
> so it is easy for the common error handling code in patch 2 to determine
> if the handle was allocated (and hence needs to be freed). This benefits
> the batching code by eliminating the need to maintain state as to which
> stage of zswap_store_pages() sees an error, based on which resources
> would need to be deleted.
>
> My key consideration is to keep the batching error handling code simple,
> hence these changes in patch 2. The changes described above would
> help batching, and should not impact the non-batching case, as indicated
> by the regression testing data I've included in the cover letter.
>
> I don't mind inlining the implementation of the helper functions, as I
> mentioned in my response to Yosry. I am hoping the error handling
> simplifications are acceptable, since they will help the batching code.

I think having the loops open-coded should still be better than
separate helpers. But I understand not wanting to have the loops
directly in zswap_store(), as the error handling would be simpler if
we do it in a separate function like zswap_store_pages().

How about we just move the loop from  zswap_store() to
zswap_store_page() and call it zswap_store_folio()? When batching is
added I imagine we may need to split the loop into two loops before
and after zswap_compress_folio(), which isn't very neat but is
probably fine.

