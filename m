Return-Path: <linux-kernel+bounces-345276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3352198B404
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6D11F243A8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E831BD00A;
	Tue,  1 Oct 2024 06:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mX9LxJlJ"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F186C1BC9EE
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 06:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727762459; cv=none; b=MwyUfuAg9RypBmEPsMMZJ11Q409fFbmwn8Eq5AiueHmmhzbcpP2fP3XAPDF8nbTz6LveYkgzaty7Fr7vx083YsmFJFAQTOLwBr6c8CxKQhEr3Y8InNYt/z0CyGwJsq4s8yKweC9HMYaa8747QQCF24+koV8g6U9ug1VcdKyYtFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727762459; c=relaxed/simple;
	bh=6cltZKI/q7uV02tZ2f4p/eK8fyVVeVTleKtXUkWEd98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIpK8aZpjmVNo+exVRq0F2RsG3aJ9QhzUsC14uHwxUvIl3TjbMsl6sowCqmgt0axrv7TMp3uO8uGsdda1J6NL+odUwdou6TxQ79YlgwGvfotskPyJJ/qJUV2jPYH8vzVkWZzJ2dFPq6aIEARHCfLu0vB5C57c8KaS0A9CPUvV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mX9LxJlJ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c88e6926e5so2693263a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727762456; x=1728367256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwlI9QyLO248HwJAU/UvsoCTF/S8s8/o8f7kwB2enIk=;
        b=mX9LxJlJhxgReXjH6VzWeaRDZiIqe7W5f9qKFSz2hkauuNZ3bU2M920oPSXggyelcK
         NV+asiMhR7BQZ7fJS1e0IwgrEoFHi/B+9MwX+Ay/8F0PMOcl8kSbXhIj6jgf9IxxUELm
         YiZNmxmd2cHg7Egnv7CMryqsR54bqx+kDknzp0MjeBoUcMmwLWD0zWwL8VRF9rZ0c/S/
         3bpEdF4uoIUu6Sz/X5qDDeCLEGjVvyfSo5I8PWIaqZcmz8SykPHFPcyQYV0AOobwtR1l
         1+mKuwsaBerVA5lLL4eqHMJiE8EBgoJS/TGE33h4EqfVRHAYTmLzk2uz+AL9lWmcv/8p
         6mCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727762456; x=1728367256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwlI9QyLO248HwJAU/UvsoCTF/S8s8/o8f7kwB2enIk=;
        b=UJLT2/OMx6hYS6v3fNqSUKu2hr8wviOFRQURY8YWmctQVGjx0GqL7KkYhWWDGIafek
         c582EhXP3wvC470UBjZppxlH2S3zUbKE3NOYa+6POxK5/WMFWl9/3VL9YpXfDj6W13F+
         iPmu3G4D/MR5XQPIcP0haq/w+bXIyuGSHqOnehfFBjK3/88C6EgvEwbodfn185/nbrFP
         Sp5iv7Hrp8EJF20chZXOef0is3E/2DcQsv8xZuId0hz/JLl85JRut/SdJw3QjOg3Po6R
         rdkimQy8fv55UYVoWsRH4jjGGJ9jTjbA6yXUJRxgody80tAQbHQ42Udd6iTviK+wbp/z
         j2nA==
X-Gm-Message-State: AOJu0YxD/NPdNziFAMbIZap9DalGvDCO0gWO/32ijiVZKrPtdPP7coKr
	w3C5q0dLaYG0J8/0D/b32CAOzPAoJB4y5/2v3bmELt7yf6kP8RD0INU2ElK8RMu3RaOaibJFtKA
	Ywj13RFeRoav8GKG4hRaHq1egUsuVgPd3uYaiUGjsGdFmxZYoWA==
X-Google-Smtp-Source: AGHT+IFQilgykeE3aCG/7kVPkxptduUjRYi481CZtd6X2JJnlsxz7SKkhuTXukUNkuu24B+Hiu4QvRWFc6VF6+4Vt+U=
X-Received: by 2002:a17:906:4787:b0:a8a:af0c:dba9 with SMTP id
 a640c23a62f3a-a93c49197e0mr1751746566b.16.1727762455925; Mon, 30 Sep 2024
 23:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
 <20240930221221.6981-7-kanchana.p.sridhar@intel.com> <CAJD7tkZh6ufHQef5HjXf_F5b5LC1EATexgseD=4WvrO+a6Ni6w@mail.gmail.com>
 <SJ0PR11MB567830D47190C55F14CE75AAC9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB567830D47190C55F14CE75AAC9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 30 Sep 2024 23:00:17 -0700
Message-ID: <CAJD7tkYF+Q2+f-=OK64C1dUqbnMVLLmWU1RDVrfJ9+rjBgqEbg@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_store().
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>, 
	"chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"willy@infradead.org" <willy@infradead.org>, "Zou, Nanhai" <nanhai.zou@intel.com>, 
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[..]
> > >  store_failed:
> > >         zpool_free(entry->pool->zpool, entry->handle);
> > > -put_pool:
> > > -       zswap_pool_put(entry->pool);
> > > -freepage:
> > > +put_pool_objcg:
> > > +       zswap_pool_put(pool);
> > > +       obj_cgroup_put(objcg);
> >
> > I think if we reorder the function we can drop these calls, make the
> > comments positioned a bit better, and centralize the entry
> > initializations. I am also not a fan of passing a semi-initialized
> > entry to zswap_compress() to get the pool pointer.
> >
> > Does the following diff improve things or did I miss something?
>
> We shouldn=E2=80=99t be adding the entry to the xarray before initializin=
g its pool
> and objcg, right? Please let me know if I am misunderstanding what you're
> proposing in the diff.

It should be safe. We already initialize entry->lru after we insert
the entry in the tree. See the comment above the call to
zswap_lru_add(). Basically we are protected against concurrent
stores/loads through the folio lock, and are protected against
writeback because the entry is not on the LRU yet.

>
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index b74c8de996468..eac1f846886a6 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -881,7 +881,8 @@ static int zswap_cpu_comp_dead(unsigned int cpu,
> > struct hlist_node *node)
> >         return 0;
> >  }
> >
> > -static bool zswap_compress(struct page *page, struct zswap_entry *entr=
y)
> > +static bool zswap_compress(struct page *page, struct zswap_entry *entr=
y,
> > +                          struct zswap_pool *pool)
> >  {
> >         struct crypto_acomp_ctx *acomp_ctx;
> >         struct scatterlist input, output;
> > @@ -893,7 +894,7 @@ static bool zswap_compress(struct page *page,
> > struct zswap_entry *entry)
> >         gfp_t gfp;
> >         u8 *dst;
> >
> > -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> > +       acomp_ctx =3D raw_cpu_ptr(pool->acomp_ctx);
> >
> >         mutex_lock(&acomp_ctx->mutex);
> >
> > @@ -926,7 +927,7 @@ static bool zswap_compress(struct page *page,
> > struct zswap_entry *entry)
> >         if (comp_ret)
> >                 goto unlock;
> >
> > -       zpool =3D entry->pool->zpool;
> > +       zpool =3D pool->zpool;
> >         gfp =3D __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
> >         if (zpool_malloc_support_movable(zpool))
> >                 gfp |=3D __GFP_HIGHMEM | __GFP_MOVABLE;
> > @@ -1435,23 +1436,11 @@ static bool zswap_store_page(struct page
> > *page,
> >         entry =3D zswap_entry_cache_alloc(GFP_KERNEL,
> > folio_nid(page_folio(page)));
> >         if (!entry) {
> >                 zswap_reject_kmemcache_fail++;
> > -               goto reject;
> > +               return false;
> >         }
> >
> > -       /* zswap_store() already holds a ref on 'objcg' and 'pool' */
> > -       if (objcg)
> > -               obj_cgroup_get(objcg);
> > -       zswap_pool_get(pool);
> > -
> > -       /* if entry is successfully added, it keeps the reference */
> > -       entry->pool =3D pool;
> > -
> > -       if (!zswap_compress(page, entry))
> > -               goto put_pool_objcg;
> > -
> > -       entry->swpentry =3D page_swap_entry(page);
> > -       entry->objcg =3D objcg;
> > -       entry->referenced =3D true;
> > +       if (!zswap_compress(page, entry, pool))
> > +               goto compress_failed;
> >
> >         old =3D xa_store(tree, swp_offset(entry->swpentry), entry, GFP_=
KERNEL);
> >         if (xa_is_err(old)) {
> > @@ -1470,6 +1459,16 @@ static bool zswap_store_page(struct page *page,
> >         if (old)
> >                 zswap_entry_free(old);
> >
> > +       /*
> > +        * The entry is successfully compressed and stored in the tree,=
 there is
> > +        * no further possibility of failure. Grab refs to the pool and=
 objcg.
> > +        * These refs will be dropped by zswap_entry_free() when the en=
try is
> > +        * removed from the tree.
> > +        */
> > +       zswap_pool_get(pool);
> > +       if (objcg)
> > +               obj_cgroup_get(objcg);
> > +
> >         /*
> >          * We finish initializing the entry while it's already in xarra=
y.
> >          * This is safe because:
> > @@ -1480,26 +1479,22 @@ static bool zswap_store_page(struct page
> > *page,
> >          *    The publishing order matters to prevent writeback from se=
eing
> >          *    an incoherent entry.
> >          */

I am referring to the comment here ^

> > +       entry->pool =3D pool;
> > +       entry->swpentry =3D page_swap_entry(page);
> > +       entry->objcg =3D objcg;
> > +       entry->referenced =3D true;
> >         if (entry->length) {
> >                 *compressed_bytes +=3D entry->length;
> >                 INIT_LIST_HEAD(&entry->lru);
> >                 zswap_lru_add(&zswap_list_lru, entry);
> >         }

