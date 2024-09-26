Return-Path: <linux-kernel+bounces-340820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CFB987838
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA4572865C1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E429215B10E;
	Thu, 26 Sep 2024 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YUs7WZCt"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC67136337
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727371238; cv=none; b=c40QEdGqdMUHkObC+EdHxfIADIXHVOuISosBBajLA8GuAYMln5oABoZMtgs7HRq8CFmH14udXLpoUcUA82mx/fR2Eqn5y1czq2o4OTM6nH4GMYwtQGbTPolIAYxDoaIyIAKs2jADkbP+U41g0yl23K0+oClfX1MZLRnpDbEAcKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727371238; c=relaxed/simple;
	bh=EeVkK+aamMNpkfJJMmx0HD/2VfWi42CHM0rx1Ke7xbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jijims7GRH193a9IrIRc84bmCh+VLypWefjy1g13o6N4liTebI6fX2qWOzyR5p7jmzsqwsp/JH1q+Id9BM244n5D6zcGJhLeWXGKyYF97CkOMs6daw9sYpp5vGY5OPji+T4uq958gTKFG5EblN0rsFNxA1eqw059n7eovqdU0/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YUs7WZCt; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8a7b1c2f2bso183817766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727371235; x=1727976035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fpb1W6vwxoW1hWsG2h/K4P1/JC6iKH9peyNxcKy1+dU=;
        b=YUs7WZCtdbOVvDSBZX/BbCV1GgV8uRonq93Irq3OvhaN4idxTgr0DFVsWAaF2oG3Ni
         2Fe069r5gqzI2VnZOPJgiiWRFmyzYHOuoEgG83g4Az9OPkn9QsTrWhA6YsRoc/AA/kqz
         4wegIn6VSPZVaUoNZftYb65nzLWQUh/Kgg0SA9Uq3WpaipBWDN5ypit4v13TNGHY/Zne
         jLLmSr96YQXKrjOzm12Dsu8JdcKJFwHEwGBrD1uXSVTg+rGFd3kSEe/d0WepobzafaH0
         WGjAdjeuNLCmezc/u/Nog7nt1DoEuJV/c9Zz5V3caaC2jRostfQaS4c14EQDmSH58KjZ
         gEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727371235; x=1727976035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fpb1W6vwxoW1hWsG2h/K4P1/JC6iKH9peyNxcKy1+dU=;
        b=BEP272YMUVjmHgaut2557+wjdhkNYUFESKv/B8g4M1uMFujBgd5cMbgA4Kwld9cjTA
         y7eDwLBE7qPb6L0kf7KzmqlfXy6DmY6H5/DvWsMqjUSQsi4OOC7cIpmP2goPZ57je38v
         rNrN1qQFkV8Op5UonDhvbhX6pD+DwoJ7P1ABYlGPnanFXoir1UdRiejbTZdPxSWaAoww
         PfwAe5Aa4f2vIrT9CfgXmCTo/LySfKKJ6p4b9EVjVvF93bcF7wtYdZaWFet6CYmF8uS4
         7iJv1rfe5JuyVE6GxZw5SyDY4QoALkXbsgDBWYlzruJ1KSUIZVFfqcEayLgIMfgvegqR
         HULw==
X-Forwarded-Encrypted: i=1; AJvYcCXH4X0Q604psRXioaoTJUeliWbWYlIJaOo1lN+aYxtwr65UVHGEMlBNzPEg3Ij7JqHptUHgw3m7X3kUu3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvWeMl4pA5zzPOnrnxAlpIBOYzNGU69Dg+9Ow/vW99q4GJIZJN
	UCj0XXWj5HpPXut/sOX+EAan/pIC0j1dnmIxzpXNFtCvvxGIzicU4/8czf5D3A5vlLAzK0agtbU
	PheQ6LTg7VCAhr/qrFIxhk5ytjoVIb00moz/m
X-Google-Smtp-Source: AGHT+IGJ1h2EgjDzUQwlEw1o2SrgKLQprJ5V21GaPR7Z0lFepQ5iNyhr2ykAWOfMLdYEpmfRWp90wQbonNZq0VhBdAc=
X-Received: by 2002:a17:907:7f28:b0:a8a:8de6:a605 with SMTP id
 a640c23a62f3a-a93c4908226mr24113166b.17.1727371234479; Thu, 26 Sep 2024
 10:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com>
 <20240924011709.7037-7-kanchana.p.sridhar@intel.com> <CAJD7tkbd=H+=wx0gnu8sh44hOmx7BE3G3oSxi7zt+o3HKJthkA@mail.gmail.com>
 <20240925134008.GA875661@cmpxchg.org> <CAJD7tkY8D14j-e6imW9NxZCjTbx8tu_VaKDbRRQMdSeKX_kBuw@mail.gmail.com>
 <20240925192006.GB876370@cmpxchg.org> <CAJD7tkY-ayU3Ld+dKTLEEG3U72fGnCbiQgZursK+eGMXif_uzA@mail.gmail.com>
 <20240925201323.GA880690@cmpxchg.org> <CAJD7tkbCDe1Y__0vUKt9q0dz_sXM74fKGQo2Zgq9CJ8=FEjH3w@mail.gmail.com>
 <SJ0PR11MB5678EC9681960F39427EABFFC9692@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <SJ0PR11MB56781A134838ADDD04731AA3C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYtVR6fi1R2O+jAxVfj7BJ2EKWbXHke9fkv_m=mf5pkFQ@mail.gmail.com> <SJ0PR11MB56785027ED6FCF673A84CEE6C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB56785027ED6FCF673A84CEE6C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 26 Sep 2024 10:19:56 -0700
Message-ID: <CAJD7tkaRjrPTdCCAA0zSVyAZ2sCKiJUC36J0fsajdtp1i_JZeg@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in zswap_store().
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"nphamcs@gmail.com" <nphamcs@gmail.com>, "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 9:40=E2=80=AFAM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
> > -----Original Message-----
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Sent: Wednesday, September 25, 2024 9:52 PM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>; linux-kernel@vger.kernel.org;
> > linux-mm@kvack.org; nphamcs@gmail.com; chengming.zhou@linux.dev;
> > usamaarif642@gmail.com; shakeel.butt@linux.dev; ryan.roberts@arm.com;
> > Huang, Ying <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-
> > foundation.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi K
> > <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> > Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in
> > zswap_store().
> >
> > [..]
> > >
> > > One thing I realized while reworking the patches for the batched chec=
ks is:
> > > within zswap_store_page(), we set the entry->objcg and entry->pool be=
fore
> > > adding it to the xarray. Given this, wouldn't it be safer to get the =
objcg
> > > and pool reference per sub-page, locally in zswap_store_page(), rathe=
r than
> > > obtaining batched references at the end if the store is successful? I=
f we
> > want
> > > zswap_store_page() to be self-contained and correct as far as the ent=
ry
> > > being created and added to the xarray, it seems like the right thing =
to do?
> > > I am a bit apprehensive about the entry being added to the xarray wit=
hout
> > > a reference obtained on the objcg and pool, because any page-
> > faults/writeback
> > > that occur on sub-pages added to the xarray before the entire folio h=
as been
> > > stored, would run into issues.
> >
> > We definitely should not obtain references to the pool and objcg after
> > initializing the entries with them. We can obtain all references in
> > zswap_store() before zswap_store_page(). IOW, the batching in this
> > case should be done before the per-page operations, not after.
>
> Thanks Yosry. IIUC, we should obtain all references to the objcg and to t=
he
> zswap_pool at the start of zswap_store.
>
> In the case of error on any sub-page, we will unwind state for potentiall=
y
> only the stored pages or the entire folio if it happened to already be in=
 zswap
> and is being re-written. We might need some additional book-keeping to
> keep track of which sub-pages were found in the xarray and zswap_entry_fr=
ee()
> got called (nr_sb). Assuming I define a new "obj_cgroup_put_many()", I wo=
uld need
> to call this with (folio_nr_pages() - nr_sb).
>
> As far as zswap_pool_get(), there is some added complexity if we want to
> keep the existing implementation that calls "percpu_ref_tryget()", and as=
suming
> this is extended to provide a new "zswap_pool_get_many()" that calls
> "percpu_ref_tryget_many()". Is there a reason we use percpu_ref_tryget() =
instead
> of percpu_ref_get()? Reason I ask is, with tryget(), if for some reason t=
he pool->ref
> is 0, no further increments will be made. If so, upon unwinding state in
> zswap_store(), I would need to special-case to catch this before calling =
a new
> "zswap_pool_put_many()".
>
> Things could be a little simpler if zswap_pool_get() can use "percpu_ref_=
get()"
> which will always increment the refcount. Since the zswap pool->ref is in=
itialized
> to "1", this seems Ok, but I don't know if there will be unintended conse=
quences.
>
> Can you please advise on what is the simplest/cleanest approach:
>
> 1) Proceed with the above changes without changing percpu_ref_tryget in
>      zswap_pool_get. Needs special-casing in zswap_store to detect pool->=
ref
>     being "0" before calling zswap_pool_put[_many].

My assumption is that we can reorder the code such that if
zswap_pool_get_many() fails we don't call zswap_pool_put_many() to
begin with (e.g. jump to a label after zswap_pool_put_many()).

> 2) Modify zswap_pool_get/zswap_pool_get_many to use percpu_ref_get_many
>     and avoid special-casing to detect pool->ref being "0" before calling
>     zswap_pool_put[_many].

I don't think we can simply switch the tryget to a get, as I believe
we can race with the pool being destroyed.

> 3) Keep the approach in v7 where obj_cgroup_get/put is localized to
>     zswap_store_page for both success and error conditions, and any unwin=
ding
>     state in zswap_store will take care of dropping references obtained f=
rom
>     prior successful writes (from this or prior invocations of zswap_stor=
e).

I am also fine with doing that and doing the reference batching as a follow=
 up.


>
> Thanks,
> Kanchana
>
> >
> > >
> > > Just wanted to run this by you. The rest of the batched charging, ato=
mic
> > > and stat updates should be Ok.
> > >
> > > Thanks,
> > > Kanchana
> > >
> > > >
> > > > Thanks,
> > > > Kanchana

