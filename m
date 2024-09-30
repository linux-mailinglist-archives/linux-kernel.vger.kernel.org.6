Return-Path: <linux-kernel+bounces-344967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AB098B0C0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27322B21AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A98188A1F;
	Mon, 30 Sep 2024 23:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ipbJPBC+"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E19188A0C
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738439; cv=none; b=f1aeAZ7x4NlRQGTPLxyzEG/8anphh5YsjYY2Eno/8tFMOBifCX3AH4fRA8tACsWUGS7X2BSAertBIA1mpxdW+H453v6Fy84MctJnZ0jRkvEMEE/S+sM0ulmItz1MxeEMRi9QAtTGPoLSWXJQ8mFFwAb95jtxRS3WtL3jqVJW6pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738439; c=relaxed/simple;
	bh=cgKP+ylaYqXeiYOQTNibzPkxHqgJeQJCXBe2+rsOvUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jk9bt/hHjTR7pM5x4d37bA6zvnLQUBvICIYoa2eLx1PNxP/ai2qw4tfEYUiV+7RsDSb6uuVhzbCTbK0qYihqr6ZUsxyuaEHXNBTWXTHqQDtEb8zBsHZz5wPrLbKtsWOnBL2JUAukEFqqIGIxPkDknlEFLwB+GhFkwy53K6yYhUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ipbJPBC+; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fad6de2590so11692031fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727738435; x=1728343235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAJSE2zeBZI18Uj9l0WKwOhvWKBTD7MyyyFR4HUEG44=;
        b=ipbJPBC+ISBTGvtNgh2e5MWAQqhb8jQ5jTUZ+8X96h6ZmR2+VHpvPnzn7Qc31t7o0J
         GeS/WVPdOc7UpUkJMxFQEvsnQX/HcI291Gclsff0fTQpTqHTMgRclEooA6O0PIRTWQuj
         0L8YKPUpUh+LB71W6mI0PuOa/XxF08lXsP0C46rg7KtdrtJvLEmXF0oOyXuvtqshpwTE
         ZEPrLof5lSt991pipPhsn28i0+0t+IKDbUStjC1mrOJ+uqYu50VwpbAkmyz83nV4NJDj
         5r/Obk0iOW/s+TMnOwmvc35817t1+jXuMQbTssOozmpy24miKjm7fZ9fA+TpDMWbFXf3
         99mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727738435; x=1728343235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAJSE2zeBZI18Uj9l0WKwOhvWKBTD7MyyyFR4HUEG44=;
        b=WEhzZn1qyk2qr48/hrF5znPcFyVdcZTIwnW4PwR4tOFF7JpSyoiIjcGCJBubB/8Ije
         DcjSHykF1tfS1LeQgpdFLMjBfOuw+DB0d6LBvK/+YOGl/oFjwAtx19v+VrzAG+wb4PHF
         zl8Mocwp83QqC8J8UX2sZX8kUGFpPB8HYa3ETF8nI8SqE64UfaNvhUTQBgB6pue1Je0S
         3tqgAZI62JVO19Vprto5RKmxsh/1kQxqUDrQ2ijdgrlE8TXMAlG7pFaiSeCca0FCFaG1
         6fdUYrM0NNU6YbRT+7w+/m9OraJg/kbfMDtDB/1skBueW4Hu8WTQfe4OnVcXoJiG2E9Z
         7UGg==
X-Forwarded-Encrypted: i=1; AJvYcCWJfsDN5yvkbfLvKw3O4pd8zKMkQThjVBhcGQr9MC6zY0Myi+kL4Lo2g/71BAVjJJ+QyY7A0x5GSpC7epM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcyMsh+aJF3oUUCHA6zApu1qw/umG2u1TV5B/hYafgzs5L9Ndu
	+4ps+oT+MNlgu5/ZFjFYYxUmhnB82/eCQgzVJF/i44JWm1COqRuipM26CL2w0vlbtp11inwvYwF
	IxN+cTDtIBOVoMntyu9VI5vpNdDuJmmo3zxfvXoIfjcXMgRgroI5r
X-Google-Smtp-Source: AGHT+IGrDGkvUFcbfHQ/qglc6QYEHNqe87No4ZKeqpbYddNUEt+aYD2dPsoXcEoglHVeF9rlz+D86pLWW798AJxKZTM=
X-Received: by 2002:a05:6512:31c1:b0:536:5625:511f with SMTP id
 2adb3069b0e04-5389fc7d145mr9717836e87.45.1727738434697; Mon, 30 Sep 2024
 16:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
 <20240930221221.6981-7-kanchana.p.sridhar@intel.com> <CAKEwX=Podz0XkX4=sutZk_nRTPy_aQ3JSVUZ9GNxPbX=t7R2kg@mail.gmail.com>
In-Reply-To: <CAKEwX=Podz0XkX4=sutZk_nRTPy_aQ3JSVUZ9GNxPbX=t7R2kg@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 30 Sep 2024 16:19:57 -0700
Message-ID: <CAJD7tkadrmzUHMXRbeScq+ekY1AJhjrSZ_mZtt4H7x1Z=Ad=UQ@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_store().
To: Nhat Pham <nphamcs@gmail.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	willy@infradead.org, nanhai.zou@intel.com, wajdi.k.feghali@intel.com, 
	vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 4:11=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Mon, Sep 30, 2024 at 3:12=E2=80=AFPM Kanchana P Sridhar
> <kanchana.p.sridhar@intel.com> wrote:
> >
> > zswap_store() will store large folios by compressing them page by page.
> >
> > This patch provides a sequential implementation of storing a large foli=
o
> > in zswap_store() by iterating through each page in the folio to compres=
s
> > and store it in the zswap zpool.
> >
> > zswap_store() calls the newly added zswap_store_page() function for eac=
h
> > page in the folio. zswap_store_page() handles compressing and storing e=
ach
> > page.
> >
> > We check the global and per-cgroup limits once at the beginning of
> > zswap_store(), and only check that the limit is not reached yet. This i=
s
> > racy and inaccurate, but it should be sufficient for now. We also obtai=
n
> > initial references to the relevant objcg and pool to guarantee that
> > subsequent references can be acquired by zswap_store_page(). A new func=
tion
> > zswap_pool_get() is added to facilitate this.
> >
> > If these one-time checks pass, we compress the pages of the folio, whil=
e
> > maintaining a running count of compressed bytes for all the folio's pag=
es.
> > If all pages are successfully compressed and stored, we do the cgroup
> > zswap charging with the total compressed bytes, and batch update the
> > zswap_stored_pages atomic/zswpout event stats with folio_nr_pages() onc=
e,
> > before returning from zswap_store().
> >
> > If an error is encountered during the store of any page in the folio,
> > all pages in that folio currently stored in zswap will be invalidated.
> > Thus, a folio is either entirely stored in zswap, or entirely not store=
d
> > in zswap.
> >
> > The most important value provided by this patch is it enables swapping =
out
> > large folios to zswap without splitting them. Furthermore, it batches s=
ome
> > operations while doing so (cgroup charging, stats updates).
> >
> > This patch also forms the basis for building compress batching of pages=
 in
> > a large folio in zswap_store() by compressing up to say, 8 pages of the
> > folio in parallel in hardware using the Intel In-Memory Analytics
> > Accelerator (Intel IAA).
> >
> > This change reuses and adapts the functionality in Ryan Roberts' RFC
> > patch [1]:
> >
> >   "[RFC,v1] mm: zswap: Store large folios without splitting"
> >
> >   [1] https://lore.kernel.org/linux-mm/20231019110543.3284654-1-ryan.ro=
berts@arm.com/T/#u
> >
> > Also, addressed some of the RFC comments from the discussion in [1].
> >
> > Co-developed-by: Ryan Roberts
> > Signed-off-by:
> > Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> > ---
> >  mm/zswap.c | 220 +++++++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 153 insertions(+), 67 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 2b8da50f6322..b74c8de99646 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -411,6 +411,12 @@ static int __must_check zswap_pool_tryget(struct z=
swap_pool *pool)
> >         return percpu_ref_tryget(&pool->ref);
> >  }
> >
> > +/* The caller must already have a reference. */
> > +static void zswap_pool_get(struct zswap_pool *pool)
> > +{
> > +       percpu_ref_get(&pool->ref);
> > +}
> > +
> >  static void zswap_pool_put(struct zswap_pool *pool)
> >  {
> >         percpu_ref_put(&pool->ref);
> > @@ -1402,68 +1408,52 @@ static void shrink_worker(struct work_struct *w=
)
> >  /*********************************
> >  * main API
> >  **********************************/
> > -bool zswap_store(struct folio *folio)
> > +
> > +/*
> > + * Stores the page at specified "index" in a folio.
> > + *
> > + * @page:  The page to store in zswap.
> > + * @objcg: The folio's objcg. Caller has a reference.
> > + * @pool:  The zswap_pool to store the compressed data for the page.
> > + *         The caller should have obtained a reference to a valid
> > + *         zswap_pool by calling zswap_pool_tryget(), to pass as this
> > + *         argument.
> > + * @tree:  The xarray for the @page's folio's swap.
> > + * @compressed_bytes: The compressed entry->length value is added
> > + *                    to this, so that the caller can get the total
> > + *                    compressed lengths of all sub-pages in a folio.
> > + */
> > +static bool zswap_store_page(struct page *page,
> > +                            struct obj_cgroup *objcg,
> > +                            struct zswap_pool *pool,
> > +                            struct xarray *tree,
> > +                            size_t *compressed_bytes)
> >  {
> > -       swp_entry_t swp =3D folio->swap;
> > -       pgoff_t offset =3D swp_offset(swp);
> > -       struct xarray *tree =3D swap_zswap_tree(swp);
> >         struct zswap_entry *entry, *old;
> > -       struct obj_cgroup *objcg =3D NULL;
> > -       struct mem_cgroup *memcg =3D NULL;
> > -
> > -       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > -       VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> > -
> > -       /* Large folios aren't supported */
> > -       if (folio_test_large(folio))
> > -               return false;
> > -
> > -       if (!zswap_enabled)
> > -               goto check_old;
> > -
> > -       /* Check cgroup limits */
> > -       objcg =3D get_obj_cgroup_from_folio(folio);
> > -       if (objcg && !obj_cgroup_may_zswap(objcg)) {
> > -               memcg =3D get_mem_cgroup_from_objcg(objcg);
> > -               if (shrink_memcg(memcg)) {
> > -                       mem_cgroup_put(memcg);
> > -                       goto reject;
> > -               }
> > -               mem_cgroup_put(memcg);
> > -       }
> > -
> > -       if (zswap_check_limits())
> > -               goto reject;
> >
> >         /* allocate entry */
> > -       entry =3D zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(folio))=
;
> > +       entry =3D zswap_entry_cache_alloc(GFP_KERNEL, folio_nid(page_fo=
lio(page)));
> >         if (!entry) {
> >                 zswap_reject_kmemcache_fail++;
> >                 goto reject;
> >         }
> >
> > -       /* if entry is successfully added, it keeps the reference */
> > -       entry->pool =3D zswap_pool_current_get();
> > -       if (!entry->pool)
> > -               goto freepage;
> > +       /* zswap_store() already holds a ref on 'objcg' and 'pool' */
> > +       if (objcg)
> > +               obj_cgroup_get(objcg);
> > +       zswap_pool_get(pool);
>
> Should we also batch-get references to the pool as well? i.e add a
> helper function:
>
> /* The caller must already have a reference. */
> static void zswap_pool_get_many(struct zswap_pool *pool, unsigned long nr=
)
> {
>        percpu_ref_get_many(&pool->ref, nr);
> }
>
> then do it in a fell swoop after you're done storing all individual subpa=
ges
> (near atomic_long_add(nr_pages, &zswap_stored_pages)).
>
> Do double check that it is safe - I think it should be, since we have
> the folio locked in swapcache, so there should not be any shenanigans
> (for e.g no race with concurrent free or writeback).
>
> Perhaps a fixlet suffices?

I suggested this in a previous version, and Kanchana faced some
complexities implementing it:
https://lore.kernel.org/lkml/SJ0PR11MB56785027ED6FCF673A84CEE6C96A2@SJ0PR11=
MB5678.namprd11.prod.outlook.com/

Basically, if we batch get the refs after the store I think it's not
safe, because once an entry is published to writeback it can be
written back and freed, and a ref that we never acquired would be
dropped.

Getting refs before the store would work, but then if the store fails
at an arbitrary page, we need to only drop refs on the pool for pages
that were not added to the tree, as the cleanup loop with
zswap_entry_free() at the end of zswap_store() will drop the ref for
those that were added to the tree.

We agreed to (potentially) do the batching for refcounts as a followup.

