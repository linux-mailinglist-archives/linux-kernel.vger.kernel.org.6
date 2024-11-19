Return-Path: <linux-kernel+bounces-415047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0219D310B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4E3E1F23471
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4FA1C729E;
	Tue, 19 Nov 2024 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pLvYgxxv"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DF319E83C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732059923; cv=none; b=CkHx+EzM4e6J2qpD3Cl/gJhmAlLpH7I1P78p5bsxkfHL3VMeqEFaxVVqg6ie6HBKy8z+CIoHjFqoEbgISmROYhQKS3LyEfOWyLAvu5kES5YRvxXdgq5L8YoqCQhN/t8FTj7SWdqMqgDSosAvd56kofH1AD1MC5FXBMY0sndIjd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732059923; c=relaxed/simple;
	bh=cWlUuRMKiApRmaxAbXuXbiTLO2hmGeeb6kTTIbzYnVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XY2wPV7RjBQn+9mDHP8VlkWNFGDl4vJS3+hQTv/lnpJmPYeurNQxh9WBohxxc5NmUCHUIYX+WhR1FBtS2LWAWH/wbLI2HiBW5K5/+MEhs9UfK+74PZX7zQFYbgTr7FyEbvvgICw1z5VPcdELVbpQBRmma25ZcOxdOiSL4rgXpY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pLvYgxxv; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-50d399891d6so1515968e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 15:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732059920; x=1732664720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWlUuRMKiApRmaxAbXuXbiTLO2hmGeeb6kTTIbzYnVg=;
        b=pLvYgxxvH6WBMAxDkubp1N+dLOI9mPSEK0KJ7gLubrivEM9nPEMq/lrQvKHVSP+E+l
         haOFu+wp4uAz6qB1XC75HmWbrNjicb+15fW3XiOqmcsr7xXY/wWAL/gAntJaxvlgqq+q
         RoIA9DE8Ea/P35i2y6wHaDpNz06fmDB5J7nKo0KXgviOz12oRWLqdapLQlEWZ3j4YpIj
         7TzQxawipAsztCPOcqqEW6cmvkVAV/GgKcjpuXPhB7m/pMOvu4a6zSaF20aSMsB6Pdv7
         /LQR3DI7lfp6oI8CXvhpotG7ap8PzBAaGkdLHegvEGLz2Uft/NVTtiUOY7pc7fYAtv2c
         fTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732059920; x=1732664720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWlUuRMKiApRmaxAbXuXbiTLO2hmGeeb6kTTIbzYnVg=;
        b=XuJvuHLw9/yVK/uq9p4V73sGezFs/ETqkiwHr4mp8W5BOd4Y06+XnCBWkw7tVuNKR4
         /xYWBauZDzdGOXyXhV0ljApbaOrbH2Itbopu0Dxa09gJDj7W0ncrd2iJhWQEI4V1MUzs
         0n/ok1kkxtX7rQO00NCs+LTSDSjUVxWa9PMYyF8heSynCaiHgvbVjn8YWyxKHIih0Xnt
         n6WG1aZ0e9oxMJpBYSxmydDpskeWDNJybwuhAH+7U8Vl+BBWtHQ8whFAlhg+A8fkdHlh
         M5OktwjUzJExh9Tz5ReAB6sIo8ua1lGbcwFh8cLuG7lHtGAsMDcxEjKq8TkDnKYXs858
         1yxA==
X-Forwarded-Encrypted: i=1; AJvYcCXhDtgjYYYdnvKqEwX8GwnwO1rhPxwgUEkngTLG/VlXyhxo8V9iMwNMuG6Uh80011RRIdvtDqXoBkzMjaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVezYRdcyqyQJbvUBg1C+81eZv2cS19HynStjjif6kkIAQSJ0u
	Ch/BvAMd1xnn8GFvIP+0P7M1MOylGY2hgV91ut1bCGf7E7k4Qn6MR0JaBy2wp6aDwg5naOHKQIM
	mXBnorI8pjLs50Zw93yTYYRlkOWO6HjyFyAEn
X-Google-Smtp-Source: AGHT+IEiyvDLitEaGAqt71fDospHnsnVYuKxpk76DhOs0+vvYOYhS+67eX7noEcBYj784G6tFdvXmAoy7R1dRc5/Ues=
X-Received: by 2002:a05:6122:1da5:b0:50c:55f4:b529 with SMTP id
 71dfb90a1353d-514cf965221mr883450e0c.8.1732059920404; Tue, 19 Nov 2024
 15:45:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113052413.157039-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZWDhOXyyZnEYFiS7F4tSV+z6TYXUYiEcrZrRuy_3R=ZA@mail.gmail.com>
 <DM8PR11MB567179534CEE154369CCA174C95A2@DM8PR11MB5671.namprd11.prod.outlook.com>
 <CAJD7tkbLtjQqR-uf8EBoFCWbkYOLHsVh6vJoMZUj+z4eN0GKAQ@mail.gmail.com>
 <SJ0PR11MB56781940E69ABE93FF9076F6C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241113213007.GB1564047@cmpxchg.org> <SJ0PR11MB5678C24CDF6AA4FED306FC71C95A2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=P6mxZ+-5UcunRHeoAVwtZD=UMfKqCGUeun-krJeT8ekg@mail.gmail.com>
 <SJ0PR11MB56785F052557B685054AF74AC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <20241114051149.GC1564047@cmpxchg.org> <SJ0PR11MB56780DD2A8EB343627FE94FCC95B2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <9a807484-6693-4e2a-a087-97bbc5ee4ed9@linux.dev> <SJ0PR11MB567847C73338BC325FE49D11C9242@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkZ+OM2uiHgHHeNqBeSaptfXw4MG=E280-5PKpeybB=8dQ@mail.gmail.com>
 <SJ0PR11MB5678C6C693444F64E38CE2EBC9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkaMMoPjrR7mLNMiFD7nOhUoLBJ22BNQYEPvfPww5d2jTg@mail.gmail.com>
 <SJ0PR11MB5678A7DF494C3FCB687D620EC9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAJD7tkYP9c8Dc1+fuG2i=okFbVf=jBph3cdFmOO0+vAvmcApvQ@mail.gmail.com> <SJ0PR11MB56780456B6808A54954D9EC9C9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB56780456B6808A54954D9EC9C9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 19 Nov 2024 15:44:43 -0800
Message-ID: <CAJD7tkZiE3PeRF=9_-ySMr7rDogGQtG9aHuwfZvpMF3uPN6aJQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in zswap_decompress().
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, "Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 2:35=E2=80=AFPM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
>
> > -----Original Message-----
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Sent: Tuesday, November 19, 2024 11:51 AM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > Cc: Chengming Zhou <chengming.zhou@linux.dev>; Johannes Weiner
> > <hannes@cmpxchg.org>; Nhat Pham <nphamcs@gmail.com>; linux-
> > kernel@vger.kernel.org; linux-mm@kvack.org; usamaarif642@gmail.com;
> > ryan.roberts@arm.com; 21cnbao@gmail.com; akpm@linux-foundation.org;
> > Feghali, Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vinodh
> > <vinodh.gopal@intel.com>
> > Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in
> > zswap_decompress().
> >
> > On Tue, Nov 19, 2024 at 11:42=E2=80=AFAM Sridhar, Kanchana P
> > <kanchana.p.sridhar@intel.com> wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Yosry Ahmed <yosryahmed@google.com>
> > > > Sent: Tuesday, November 19, 2024 11:27 AM
> > > > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > > > Cc: Chengming Zhou <chengming.zhou@linux.dev>; Johannes Weiner
> > > > <hannes@cmpxchg.org>; Nhat Pham <nphamcs@gmail.com>; linux-
> > > > kernel@vger.kernel.org; linux-mm@kvack.org; usamaarif642@gmail.com;
> > > > ryan.roberts@arm.com; Huang, Ying <ying.huang@intel.com>;
> > > > 21cnbao@gmail.com; akpm@linux-foundation.org; Feghali, Wajdi K
> > > > <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> > > > Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in
> > > > zswap_decompress().
> > > >
> > > > On Tue, Nov 19, 2024 at 11:22=E2=80=AFAM Sridhar, Kanchana P
> > > > <kanchana.p.sridhar@intel.com> wrote:
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Yosry Ahmed <yosryahmed@google.com>
> > > > > > Sent: Friday, November 15, 2024 1:49 PM
> > > > > > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > > > > > Cc: Chengming Zhou <chengming.zhou@linux.dev>; Johannes Weiner
> > > > > > <hannes@cmpxchg.org>; Nhat Pham <nphamcs@gmail.com>; linux-
> > > > > > kernel@vger.kernel.org; linux-mm@kvack.org;
> > usamaarif642@gmail.com;
> > > > > > ryan.roberts@arm.com; Huang, Ying <ying.huang@intel.com>;
> > > > > > 21cnbao@gmail.com; akpm@linux-foundation.org; Feghali, Wajdi K
> > > > > > <wajdi.k.feghali@intel.com>; Gopal, Vinodh
> > <vinodh.gopal@intel.com>
> > > > > > Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak =
in
> > > > > > zswap_decompress().
> > > > > >
> > > > > > On Fri, Nov 15, 2024 at 1:14=E2=80=AFPM Sridhar, Kanchana P
> > > > > > <kanchana.p.sridhar@intel.com> wrote:
> > > > > > >
> > > > > > > Hi Chengming,
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Chengming Zhou <chengming.zhou@linux.dev>
> > > > > > > > Sent: Wednesday, November 13, 2024 11:24 PM
> > > > > > > > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>;
> > Johannes
> > > > > > Weiner
> > > > > > > > <hannes@cmpxchg.org>
> > > > > > > > Cc: Nhat Pham <nphamcs@gmail.com>; Yosry Ahmed
> > > > > > > > <yosryahmed@google.com>; linux-kernel@vger.kernel.org; linu=
x-
> > > > > > > > mm@kvack.org; usamaarif642@gmail.com;
> > ryan.roberts@arm.com;
> > > > > > Huang,
> > > > > > > > Ying <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-
> > > > > > > > foundation.org; Feghali, Wajdi K <wajdi.k.feghali@intel.com=
>;
> > Gopal,
> > > > > > Vinodh
> > > > > > > > <vinodh.gopal@intel.com>
> > > > > > > > Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory l=
eak in
> > > > > > > > zswap_decompress().
> > > > > > > >
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > On 2024/11/14 14:37, Sridhar, Kanchana P wrote:
> > > > > > > > >
> > > > > > > > >> -----Original Message-----
> > > > > > > > >> From: Johannes Weiner <hannes@cmpxchg.org>
> > > > > > > > >> Sent: Wednesday, November 13, 2024 9:12 PM
> > > > > > > > >> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > > > > > > > >> Cc: Nhat Pham <nphamcs@gmail.com>; Yosry Ahmed
> > > > > > > > >> <yosryahmed@google.com>; linux-kernel@vger.kernel.org;
> > linux-
> > > > > > > > >> mm@kvack.org; chengming.zhou@linux.dev;
> > > > > > usamaarif642@gmail.com;
> > > > > > > > >> ryan.roberts@arm.com; Huang, Ying <ying.huang@intel.com>=
;
> > > > > > > > >> 21cnbao@gmail.com; akpm@linux-foundation.org; Feghali,
> > Wajdi K
> > > > > > > > >> <wajdi.k.feghali@intel.com>; Gopal, Vinodh
> > > > <vinodh.gopal@intel.com>
> > > > > > > > >> Subject: Re: [PATCH v1] mm: zswap: Fix a potential memor=
y
> > leak in
> > > > > > > > >> zswap_decompress().
> > > > > > > > >>
> > > > > > > > >> On Thu, Nov 14, 2024 at 01:56:16AM +0000, Sridhar, Kanch=
ana
> > P
> > > > > > wrote:
> > > > > > > > >>> So my question was, can we prevent the migration to a
> > different
> > > > cpu
> > > > > > > > >>> by relinquishing the mutex lock after this conditional
> > > > > > > > >>
> > > > > > > > >> Holding the mutex doesn't prevent preemption/migration.
> > > > > > > > >
> > > > > > > > > Sure, however, is this also applicable to holding the mut=
ex of a
> > per-
> > > > cpu
> > > > > > > > > structure obtained via raw_cpu_ptr()?
> > > > > > > >
> > > > > > > > Yes, unless you use migration_disable() or cpus_read_lock()=
 to
> > protect
> > > > > > > > this section.
> > > > > > >
> > > > > > > Ok.
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Would holding the mutex prevent the acomp_ctx of the cpu =
prior
> > to
> > > > > > > > > the migration (in the UAF scenario you described) from be=
ing
> > > > deleted?
> > > > > > > >
> > > > > > > > No, cpu offline can kick in anytime to free the acomp_ctx->=
buffer.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > If holding the per-cpu acomp_ctx's mutex isn't sufficient=
 to
> > prevent
> > > > the
> > > > > > > > > UAF, I agree, we might need a way to prevent the acomp_ct=
x
> > from
> > > > being
> > > > > > > > > deleted, e.g. with refcounts as you've suggested, or to n=
ot use
> > the
> > > > > > > >
> > > > > > > > Right, refcount solution from Johannes is very good IMHO.
> > > > > > > >
> > > > > > > > > acomp_ctx at all for the check, instead use a boolean.
> > > > > > > >
> > > > > > > > But this is not enough to just avoid using acomp_ctx for th=
e check,
> > > > > > > > the usage of acomp_ctx inside the mutex is also UAF, since =
cpu
> > offline
> > > > > > > > can kick in anytime to free the acomp_ctx->buffer.
> > > > > > >
> > > > > > > I see. How would the refcounts work? Would this add latency t=
o
> > zswap
> > > > > > > ops? In low memory situations, could the cpu offlining code o=
ver-ride
> > > > > > > the refcounts?
> > > > > >
> > > > > > I think what Johannes meant is that the zswap compress/decompre=
ss
> > > > > > paths grab a ref on the acomp_ctx before using it, and the CPU
> > > > > > offlining code only drops the initial ref, and does not free th=
e
> > > > > > buffer directly. The buffer is only freed when the ref drops to=
 zero.
> > > > > >
> > > > > > I am not familiar with CPU hotplug, would it be simpler if we h=
ave a
> > > > > > wrapper like get_acomp_ctx() that disables migration or calls
> > > > > > cpus_read_lock() before grabbing the per-CPU acomp_ctx? A simil=
ar
> > > > > > wrapper, put_acompt_ctx() will be used after we are done using =
the
> > > > > > acomp_ctx.
> > > > >
> > > > > Would it be sufficient to add a check for mutex_is_locked() in
> > > > > zswap_cpu_comp_dead() and if this returns true, to exit without
> > deleting
> > > > > the acomp?
> > > >
> > > > I don't think this works. First of all, it's racy. It's possible th=
e
> > > > mutex gets locked after we check mutex_is_locked() but before we
> > > > delete the acomp_ctx. Also, if we find that the mutex is locked, th=
en
> > > > we do nothing and essentially leak the memory.
> > >
> > > Yes, this would assume the cpu offlining code retries at some interva=
l,
> > > which could prevent the memory leak.
> >
> > I am not sure about that, but even so, it wouldn't handle the first
> > scenario where the mutex gets locked after we check mutex_is_locked().
> >
> > >
> > > >
> > > > Second, and probably more important, this only checks if anyone is
> > > > currently holding the mutex. What about tasks that may be sleeping
> > > > waiting for the mutex to be unlocked? The mutex will be deleted fro=
m
> > > > under them as well.
> > >
> > > Wouldn't this and the race described above, also be issues for the
> > > refcount based approach?
> >
> > I don't think so, at least if implemented correctly. There are a lot
> > of examples around the kernel that use RCU + refcounts for such use
> > cases. I think there are also some examples in kernel docs.
> >
> > That being said, I am wondering if we can get away with something
> > simpler like holding the cpus read lock or disabling migration as I
> > suggested earlier, but I am not quite sure.
>
> Another idea to consider is how zsmalloc avoids this issue through
> its use of the local_lock() on the per-cpu mapping area. This disables
> preemption from zs_map_object() through zs_unmap_object().
> Would changing the acomp_ctx's mutex to a local_lock solve the
> problem?

This is similar to disabling migration as I suggested, but disabling
preemption means that we cannot sleep, we spin on a lock instead.

In zswap_compress(), we send the compression request and may sleep
waiting for it. We also make a non-atomic allocation later that may
also sleep but that's less of a problem.

In zswap_decompress() we may also sleep, which is why we sometimes
copy the data into acomp_ctx->buffer and unmap the handle to begin
with.

So I don't think we can just replace the mutex with a lock.

>
> >
> > >
> > > Also, I am wondering if the mutex design already handles cases where
> > > tasks are sleeping, waiting for a mutex that disappears?
> >
> > I don't believe so. It doesn't make sense for someone to free a mutex
> > while someone is waiting for it. How would the waiter know if the
> > memory backing the mutex was freed?
>
> Thanks Yosry, all good points. There would need to be some sort of
> arbiter (for e.g., the cpu offlining code) that would reschedule tasks
> running on a cpu before shutting it down, which could address
> this specific issue. I was thinking these are not problems unique to
> zswap's per-cpu acomp_ctx->mutex wrt the offlining?

There are a few reasons why zswap has this problem and other code may
not have it. For example the data structure is dynamically allocated
and is freed during offlining, it wouldn't be a problem if it was
static. Also the fact that we don't disable preemption when accessing
the per-CPU data, as I mentioned earlier, which would prevent the CPU
we are running on from going offline while we access the per-CPU data.

I think we should either:
(a) Use refcounts.
(b) Disable migration.
(c) Hold the CPUs read lock.

I was hoping someone with more knowledge about CPU offlining would
confirm (b) and (c) would work, but I am pretty confident they would.

