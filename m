Return-Path: <linux-kernel+bounces-340835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC9F987862
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35053281D05
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C7E15AD90;
	Thu, 26 Sep 2024 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WbiuCnV3"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBCA4C79
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372131; cv=none; b=FJ+vX2Kj4/KVcQmfl8FHKB/sCW5dNSneNqi+E4RbLNu3C4F86pbFmuCPWYRib+ZR7CEXVTxFJgBp5o81NtaEJkJH5y1GCvpeqWK4I7z1UFmpmNQsPEBhz51ekePxeaTAwgd6nIRMIurPx0j0BBKazYhM0SBpYQ+CzYMzMytCQpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372131; c=relaxed/simple;
	bh=zS86IsArpNHyqGCSkjDVIoWEohbMnW+q5pfpZ5Ynxzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q42EsY3AwujJ2849DA5MLJOHEJuLYv8Xa6+4CiKl+gEx2Ifya9EG/gmGkLBa3IJNDeRQ3liQRyJZXupktEYHY01S44wP9wTjJlsR5Ix5RF+0/s6X6Al4Uajl6ZABxtvltctKeIc/Vpp8rA/ETqvLnCx8NF6JS56UI5K+oBh8FZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WbiuCnV3; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8d446adf6eso172562066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372128; x=1727976928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90Zj4vWTFKM9hGI/ZhiBg+/nwuUtOIRWahkWQsv/IQo=;
        b=WbiuCnV3vLn5oB2j8/t7RVpQCWql+9lmoqsUc7xRT5FfN7SYjMNtb8rfL91WwmeUjT
         Rks5QBkn3JhbtgB39/YZE2mINgY5+yR8kdb7Vsxor0FWG2pSMKNjTG/QfB/4LPHiv4G1
         X+EamEwfxBFlkYKfCtzFA+RJpXoiWokJa1HfudGgEsDrlFQ9BVQAdQegkXK67q6olW+Y
         x1tVYz28BIOo5xRqe/L4rIr+pJix9ymVDXrEk5ysG7+orEKJaITWfQ8kZoRcdAIJ5j8r
         6eZjTUUesRp/GgAnX7HkhTNBrDCEGHaT+KSdXkLf8ODYip8LmZARsbggE66hjlCdkv9c
         RLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372128; x=1727976928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90Zj4vWTFKM9hGI/ZhiBg+/nwuUtOIRWahkWQsv/IQo=;
        b=argwickq/FW8aWW3LXCvK946CploSIIU2MF0qCvN3Uvt8zFc3Gt52Ll1V3LpVjfoyO
         cCBL+zqN/yzC9jpaFnLKN9LqNR8IBSKQ9vJIJzqEH/ymNBURMt2NyHGxqSh/akCdgdEK
         gjIB/zMWm/MymMAoJ6wM7YfQ4MC5fgwD0eB8LBz8QTmsFf8E1oWG1kMeamYEC3ZwxdJO
         HZo3TMdxRTRP5rbkFsEhrSoMz8y3gz16gzwM5UVv3cz/kZb4ZYN6uePkeQ7CATi0QQAH
         hgg7bIrZ2dXpsPHXoPUIUhF21LMUa+dyStkhwL+14KpOraQDOkGFqUpek/Pt985qoQ3t
         YKgA==
X-Forwarded-Encrypted: i=1; AJvYcCUpO8LJ+PjKSR0j64ggkq63pzdxJruK9fM8uueg5/WsaHpOhXkntpYKi3B2cDyU8POYi/cIBpVNNRW9EX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWO7rsRKuhvMvZItQrusovj7AHR4DeHevOzy0pfm9yyuE4Yo/V
	T4bTTZ2EmcW73jNLE5Zyh/U3gVdv/8DZciylCoD2/iXnBZvVCvSdXJxXBgbuLeI9op7kL2L5fpo
	zQr9jfn3/TBGc3zjkiozYl9bZ4UqNlRiP4IIR
X-Google-Smtp-Source: AGHT+IHCP+Zznjpd3YjrmHAE50PhdAm4vSwOqQym8ahagT8NDlpt1wX9i/4gffYt0cbbR2b6ytzqgY8SXtldqDcxqhs=
X-Received: by 2002:a17:907:e91:b0:a7d:c148:ec85 with SMTP id
 a640c23a62f3a-a93c4aa6b89mr25072866b.62.1727372127804; Thu, 26 Sep 2024
 10:35:27 -0700 (PDT)
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
 <CAJD7tkYtVR6fi1R2O+jAxVfj7BJ2EKWbXHke9fkv_m=mf5pkFQ@mail.gmail.com>
 <SJ0PR11MB56785027ED6FCF673A84CEE6C96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkaRjrPTdCCAA0zSVyAZ2sCKiJUC36J0fsajdtp1i_JZeg@mail.gmail.com> <SJ0PR11MB56781678BE55278052EB590CC96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB56781678BE55278052EB590CC96A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 26 Sep 2024 10:34:49 -0700
Message-ID: <CAJD7tkaU4pdGZ4yJrn2z+dECrsbpByrWSc0XcrE6zA_QjSZBSg@mail.gmail.com>
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

On Thu, Sep 26, 2024 at 10:29=E2=80=AFAM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
> > -----Original Message-----
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Sent: Thursday, September 26, 2024 10:20 AM
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
> > On Thu, Sep 26, 2024 at 9:40=E2=80=AFAM Sridhar, Kanchana P
> > <kanchana.p.sridhar@intel.com> wrote:
> > >
> > > > -----Original Message-----
> > > > From: Yosry Ahmed <yosryahmed@google.com>
> > > > Sent: Wednesday, September 25, 2024 9:52 PM
> > > > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > > > Cc: Johannes Weiner <hannes@cmpxchg.org>; linux-
> > kernel@vger.kernel.org;
> > > > linux-mm@kvack.org; nphamcs@gmail.com; chengming.zhou@linux.dev;
> > > > usamaarif642@gmail.com; shakeel.butt@linux.dev;
> > ryan.roberts@arm.com;
> > > > Huang, Ying <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-
> > > > foundation.org; Zou, Nanhai <nanhai.zou@intel.com>; Feghali, Wajdi =
K
> > > > <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> > > > Subject: Re: [PATCH v7 6/8] mm: zswap: Support mTHP swapout in
> > > > zswap_store().
> > > >
> > > > [..]
> > > > >
> > > > > One thing I realized while reworking the patches for the batched =
checks
> > is:
> > > > > within zswap_store_page(), we set the entry->objcg and entry->poo=
l
> > before
> > > > > adding it to the xarray. Given this, wouldn't it be safer to get =
the objcg
> > > > > and pool reference per sub-page, locally in zswap_store_page(), r=
ather
> > than
> > > > > obtaining batched references at the end if the store is successfu=
l? If we
> > > > want
> > > > > zswap_store_page() to be self-contained and correct as far as the=
 entry
> > > > > being created and added to the xarray, it seems like the right th=
ing to
> > do?
> > > > > I am a bit apprehensive about the entry being added to the xarray
> > without
> > > > > a reference obtained on the objcg and pool, because any page-
> > > > faults/writeback
> > > > > that occur on sub-pages added to the xarray before the entire fol=
io has
> > been
> > > > > stored, would run into issues.
> > > >
> > > > We definitely should not obtain references to the pool and objcg af=
ter
> > > > initializing the entries with them. We can obtain all references in
> > > > zswap_store() before zswap_store_page(). IOW, the batching in this
> > > > case should be done before the per-page operations, not after.
> > >
> > > Thanks Yosry. IIUC, we should obtain all references to the objcg and =
to the
> > > zswap_pool at the start of zswap_store.
> > >
> > > In the case of error on any sub-page, we will unwind state for potent=
ially
> > > only the stored pages or the entire folio if it happened to already b=
e in
> > zswap
> > > and is being re-written. We might need some additional book-keeping t=
o
> > > keep track of which sub-pages were found in the xarray and
> > zswap_entry_free()
> > > got called (nr_sb). Assuming I define a new "obj_cgroup_put_many()", =
I
> > would need
> > > to call this with (folio_nr_pages() - nr_sb).
> > >
> > > As far as zswap_pool_get(), there is some added complexity if we want=
 to
> > > keep the existing implementation that calls "percpu_ref_tryget()", an=
d
> > assuming
> > > this is extended to provide a new "zswap_pool_get_many()" that calls
> > > "percpu_ref_tryget_many()". Is there a reason we use percpu_ref_tryge=
t()
> > instead
> > > of percpu_ref_get()? Reason I ask is, with tryget(), if for some reas=
on the
> > pool->ref
> > > is 0, no further increments will be made. If so, upon unwinding state=
 in
> > > zswap_store(), I would need to special-case to catch this before call=
ing a
> > new
> > > "zswap_pool_put_many()".
> > >
> > > Things could be a little simpler if zswap_pool_get() can use
> > "percpu_ref_get()"
> > > which will always increment the refcount. Since the zswap pool->ref i=
s
> > initialized
> > > to "1", this seems Ok, but I don't know if there will be unintended
> > consequences.
> > >
> > > Can you please advise on what is the simplest/cleanest approach:
> > >
> > > 1) Proceed with the above changes without changing percpu_ref_tryget =
in
> > >      zswap_pool_get. Needs special-casing in zswap_store to detect po=
ol-
> > >ref
> > >     being "0" before calling zswap_pool_put[_many].
> >
> > My assumption is that we can reorder the code such that if
> > zswap_pool_get_many() fails we don't call zswap_pool_put_many() to
> > begin with (e.g. jump to a label after zswap_pool_put_many()).
>
> However, the pool refcount could change between the start and end of
> zswap_store.

I am not sure what you mean. If zswap_pool_get_many() fails then we
just do not call zswap_pool_put_many() at all and abort.

>
> >
> > > 2) Modify zswap_pool_get/zswap_pool_get_many to use
> > percpu_ref_get_many
> > >     and avoid special-casing to detect pool->ref being "0" before cal=
ling
> > >     zswap_pool_put[_many].
> >
> > I don't think we can simply switch the tryget to a get, as I believe
> > we can race with the pool being destroyed.
>
> That was my initial thought as well, but I figured this couldn't happen
> since the pool->ref is initialized to "1", and based on the existing
> implementation. In any case, I can understand the intent of the use
> of "tryget"; it is just that it adds to the considerations for reference
> batching.

The initial ref can be dropped in __zswap_param_set() if a new pool is
created (see the call to ercpu_ref_kill(()).

>
> >
> > > 3) Keep the approach in v7 where obj_cgroup_get/put is localized to
> > >     zswap_store_page for both success and error conditions, and any
> > unwinding
> > >     state in zswap_store will take care of dropping references obtain=
ed from
> > >     prior successful writes (from this or prior invocations of zswap_=
store).
> >
> > I am also fine with doing that and doing the reference batching as a fo=
llow up.
>
> I think so too! We could try and improve upon (3) with reference batching
> in a follow-up patch.

SGTM.

