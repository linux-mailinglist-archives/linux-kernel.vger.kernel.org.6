Return-Path: <linux-kernel+bounces-346838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 224BA98C98A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9021F23FF9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC601D4338;
	Tue,  1 Oct 2024 23:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2YP+M3/q"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB3154C1E
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 23:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727825970; cv=none; b=eGCpyzZ6TkTFJvpdukwO10jFm4BPeBb13qIBT0laXTZL2YR6vQ3WN8QOM4l/C8tCCZvoy/cypQng7VJ5El/6byCW721weWde0SNYgZg3ZGrXkOI3n1mIaOVP3c2WZA/evZPC4tM93Nnpz4JRJFFP/zTwa707GcYEb4+/pRQj4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727825970; c=relaxed/simple;
	bh=pFMXIsrKvzMY5TbcUhzpyJnAbB0rtPdNnBEl5H+br2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tT8E8yyGtV7yDoDt6ZiF/SmJGo55xl3RQOzs8/7JpfdSRbjljERQqj1t0OnpodSEfX1VWqLZZwihPaj4Rwvno2hMFxxTu+O3Rpl0PQ8cCWa9iU4Zkydmp7hP9aZ5cnTgGE5dRrB8R9ux9JHF+dpY4M6INtHlRkHGw/YVTILDkyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2YP+M3/q; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8ce5db8668so1047826066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 16:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727825967; x=1728430767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QC9leAnVpIQ+0a8Li0BvdERjab0Ohtpna3h2EZ7AVV8=;
        b=2YP+M3/q6Sn/xmkmXCxlKBesGnN96C5eArzGCI+Yfma7cpr5FK3g2fjp3g4eJ6Hc2n
         Lfzbj9GVFsO+ieXuxjah16vo34sHWv5rGTJVwoz5QqrWCV9VbsUTEFAFGb1hKWDA/Heu
         kc2oo8gl9FTxr91xvQ+I+e0Eyvln9Km5ycT44upmtlcaa+/S3mE1ppvLTaCncPjR9fOH
         zWXZ3mOUJMMJVRoIkwd7yt5h6WGT2jdgcSL6WR/irxBMeB8SuYR/Gbwm5nt7crgcCP8r
         X/7/Im3LndMevKkNqq3atSu1vN5T5v1Z+qGABpQ5mHMfeqzUnMzaO2rGyFPWzICnavy9
         eTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727825967; x=1728430767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QC9leAnVpIQ+0a8Li0BvdERjab0Ohtpna3h2EZ7AVV8=;
        b=vVNS3xXBzo4c58OWbPDRDBfbXaw42Qjf4AFVpJGy1qbRmsyy6coDy/OYt5OkYN8hNJ
         ZZ/1/123TlNiGbxzGc1EW+AfshbHRRm6B21JdGCYHjTG3ZlLpTDw9X80GSLfGNLbKOZ3
         u1TEzThFXgfyqtK/J7Zbi6B1gxYUoLfWZCmlM4knE9xecZurL/lDLlsXlqQOD21biQAB
         eYV3IZfW3d1SNtR23pU1lFb6j1Urga/cZKxee3t5x22aRV/Hs/5UWyzyCmFILpQbN9WM
         bgBoqgq3EOWtjxd9L8+lWBKJJyTVONA0Inc+pUhptaH0SfoG9LKQ4zE172eqleOl2H5h
         /USw==
X-Gm-Message-State: AOJu0Yzkdbc08QEWJScuomc14BqKHUQHCG6am8wr7G6Gx7iX4q3pH5Ww
	dR6/6LhCJnIpvWIE8XOTr+WZGMc451e3X6qRT04gq7AJljvWVlX0zi4/DALvhmJ0y1AOzPAR7DO
	89h4E8J6xYfspWdf/cWnEcxM1Lh6c2LqwijL8
X-Google-Smtp-Source: AGHT+IHsJrzJEvc35ZFGz7GYfG/WCB2Oh7Vz69PPyMNzybiu7Fy/SAfkJMOZoCJ1y9gJxgTFmnRAuPxDsAfr+r4o8Kk=
X-Received: by 2002:a17:907:7e88:b0:a86:b64e:bc4d with SMTP id
 a640c23a62f3a-a98f8371b0amr97137266b.44.1727825966694; Tue, 01 Oct 2024
 16:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
 <20240930221221.6981-7-kanchana.p.sridhar@intel.com> <CAJD7tkZh6ufHQef5HjXf_F5b5LC1EATexgseD=4WvrO+a6Ni6w@mail.gmail.com>
 <SJ0PR11MB567830D47190C55F14CE75AAC9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYF+Q2+f-=OK64C1dUqbnMVLLmWU1RDVrfJ9+rjBgqEbg@mail.gmail.com>
 <SJ0PR11MB567885FD8899DA83FB95DE61C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZk=9Su3vtdFcghD0R+GqSchn5b1L91SgTvxcX79rmdOA@mail.gmail.com>
 <SJ0PR11MB56786A297C3D8DCADC2EF310C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <SJ0PR11MB5678A1858237FBC0DF7A0098C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5678A1858237FBC0DF7A0098C9772@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 1 Oct 2024 16:38:49 -0700
Message-ID: <CAJD7tkZ+mqfKoeJ5d2iCzajoTw8sWduwk4fi20g=wp=4pp_=ig@mail.gmail.com>
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
> > > > > > > >  store_failed:
> > > > > > > >         zpool_free(entry->pool->zpool, entry->handle);
> > > > > > > > -put_pool:
> > > > > > > > -       zswap_pool_put(entry->pool);
> > > > > > > > -freepage:
> > > > > > > > +put_pool_objcg:
> > > > > > > > +       zswap_pool_put(pool);
> > > > > > > > +       obj_cgroup_put(objcg);
> > > > > > >
> > > > > > > I think if we reorder the function we can drop these calls, m=
ake the
> > > > > > > comments positioned a bit better, and centralize the entry
> > > > > > > initializations. I am also not a fan of passing a semi-initia=
lized
> > > > > > > entry to zswap_compress() to get the pool pointer.
> > > > > > >
> > > > > > > Does the following diff improve things or did I miss somethin=
g?
> > > > > >
> > > > > > We shouldn=E2=80=99t be adding the entry to the xarray before i=
nitializing its
> > pool
> > > > > > and objcg, right? Please let me know if I am misunderstanding w=
hat
> > > you're
> > > > > > proposing in the diff.
> > > > >
> > > > > It should be safe. We already initialize entry->lru after we inse=
rt
> > > > > the entry in the tree. See the comment above the call to
> > > > > zswap_lru_add(). Basically we are protected against concurrent
> > > > > stores/loads through the folio lock, and are protected against
> > > > > writeback because the entry is not on the LRU yet.
> > > >
> > > > Thanks for the clarification, Yosry. Since this is a change in the =
entry
> > > > initialization wrt the mainline, is it Ok if this is done in a foll=
ow-up patch?
> > >
> > > Sure. We can discuss it separately. Do you want me to send a patch or
> > > do you intend to?
> >
> > Thanks Yosry! I will send the patch separately.
>
> Hi Yosry,
>
> I am preparing the follow-up patch so I can submit it once this patch-ser=
ies is
> merged to mm-unstable (since these changes have dependencies on my
> existing patch).
>
> Is my understanding correct that the folio lock also protects against swa=
poff
> happening in between addition of the entry to the xarray and initializing=
 its
> members, which will need to be valid for
> swapoff --> ... -> free_swap_slot() --> zswap_invalidate() ? Would apprec=
iate
> it if you can confirm.

Yes, the folio lock should protect against swapoff, as the folio must
be in the swapcache.

For shmem, try_to_unuse() (called by swapoff()) will end up calling
shmem_swapin_folio(), which will lookup the folio in the swapcache,
find it, then lock it before proceeding to delete it from the swap
cache and ultimately freeing the swap entry.

For anonymous memory, try_to_unuse() will call unuse_mm() -> .. ->
unuse_pte_range(), which will also lookup the folio and lock it before
deleting it from the swap cache and freeing the entry.

try_to_unuse() will also loop over any remaining swapcache entries,
lock the folios and then try to free the swap entry.

