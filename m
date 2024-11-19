Return-Path: <linux-kernel+bounces-414883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B939D2ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87196B2428C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECE91D1E68;
	Tue, 19 Nov 2024 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SrAFckGB"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA40C15443F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732044459; cv=none; b=XVOaDcsYUouYNedSdS08PkfIvfK1PhQUD+qygh6sC8JKt2Y+rKdPKuSjknBafjef7AyhOG1R+RJr++IW3huE2L3KU7u6LhqwrolNh+n+iJLadmXRIPJtvf/OCWlhW1I2xbxp096qW7zLOjCGltqPVPB2+FGdtNWjVdwr+xtI6Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732044459; c=relaxed/simple;
	bh=LdnOOKDy1qaKBP09hAweLnoPW9+Venfz7d431iNqwy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RoCmZazB/eekpKqwcSTLZ5s0/QLYyimc1O4FWPoB3xLcJ6iNUAuKj0b+xtMYBLq17Cw76OzJdLT5B88DseE4+RiZSXN3VsnuMUIt8dv90kDPYBVjYsCUyFB9C7uuPXG5GJEoLV8+eMdbnQ9e3vs/Xop2bzu6drxhcAL9lVCUFRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SrAFckGB; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-460d2571033so9085781cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732044456; x=1732649256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LdnOOKDy1qaKBP09hAweLnoPW9+Venfz7d431iNqwy8=;
        b=SrAFckGBu5GE1WTIqySGoDgdxwGyAN8ykkEM4UXPJD0w/b2s6xbDzCMgFGPRGsz0KE
         1RvgLypD9vGCoqa+48aDEh6oZeo2Y6qOkp1BGIUbvp8E2kv24IFntdw8M+vW5ODa73N/
         cJLpOgijbdi04nh/vN5HjoYA0dGIU5cpX4zA/1ZxT6a3wjzWM/+joyVAexbJW6QQ9/ZN
         emFDM793ql/QzcV4lIt1f6NyEDLFYrfxfrotYN3I75afzhKN3ErhnV5CV3u3vE/8k2j1
         6yGjFpJrrdC9uLWUpEe3IAJeMCTZAoaQr46+B+sjB7d0k8vNZkvmvS8faZEGlDhCNlrz
         w70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732044456; x=1732649256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LdnOOKDy1qaKBP09hAweLnoPW9+Venfz7d431iNqwy8=;
        b=tEnErOhFS60gsRNo1jNLf6aIkkysPJBDexlAadH6bgtZltUQj7OzYc0yg6x9DOqNVt
         cIXbnz0We9XPOKeNV8TaBibZuWC9h9pEW71/LU1hEKad4T/exJt5H2eJXtTDlYVilGuz
         /alTuwwLBvRoi2f8BU45NifiklRyeXzrQEN6tWZsUuiWngBOJI4Nd0hsiIzLqbWEUnCN
         Ov9DBDqMJcMVns7DS6LtPxMD5kgR1IOkczCaoIUWIwvP7K3WxGek51Dc6V/LN9WTAFUY
         cUU36yP8kB/+bldXUsj8uK3fNLM1UT8qZfERftM46RT4PwR2lnxFQf3JAr2FHnCMasy+
         VZsA==
X-Forwarded-Encrypted: i=1; AJvYcCW7YDnPmFnzHUhC+/+LdqEdo1QVsfZ+x6n+KnvYvQRtOzA5yu68SzziG3SO3nyyW0jmOtT92MkcnXkQIWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu1c5bQ8lgg+vEXNXAhWYYyNPQsbgmQEC7R7kXbeJjUQ5qalCS
	wj3K4L2pv00y5T8JiRgWJrVXOi6o8zIiK4K3hEQe2CWdMI+g0C6Ptu8mcZJH6boWfrCswDdeqRJ
	t3qRcU6eOy9qM1BZJlA5Hviy7itsWD7I4Jdsm
X-Google-Smtp-Source: AGHT+IGbLoHVCdG3Fs/zVrFHCKzYptyKu9BqZFl8R7qNn8kIYXx6uLXr9bkoyg0tX9IseZbkx0ZPv/qo8CBsUgri4sc=
X-Received: by 2002:a05:6214:518a:b0:6d4:1f86:b1e1 with SMTP id
 6a1803df08f44-6d4377fff93mr2010626d6.19.1732044456407; Tue, 19 Nov 2024
 11:27:36 -0800 (PST)
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
 <CAJD7tkZ+OM2uiHgHHeNqBeSaptfXw4MG=E280-5PKpeybB=8dQ@mail.gmail.com> <SJ0PR11MB5678C6C693444F64E38CE2EBC9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5678C6C693444F64E38CE2EBC9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 19 Nov 2024 11:27:00 -0800
Message-ID: <CAJD7tkaMMoPjrR7mLNMiFD7nOhUoLBJ22BNQYEPvfPww5d2jTg@mail.gmail.com>
Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in zswap_decompress().
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"usamaarif642@gmail.com" <usamaarif642@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>, 
	"Huang, Ying" <ying.huang@intel.com>, "21cnbao@gmail.com" <21cnbao@gmail.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 11:22=E2=80=AFAM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
>
> > -----Original Message-----
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Sent: Friday, November 15, 2024 1:49 PM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > Cc: Chengming Zhou <chengming.zhou@linux.dev>; Johannes Weiner
> > <hannes@cmpxchg.org>; Nhat Pham <nphamcs@gmail.com>; linux-
> > kernel@vger.kernel.org; linux-mm@kvack.org; usamaarif642@gmail.com;
> > ryan.roberts@arm.com; Huang, Ying <ying.huang@intel.com>;
> > 21cnbao@gmail.com; akpm@linux-foundation.org; Feghali, Wajdi K
> > <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> > Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in
> > zswap_decompress().
> >
> > On Fri, Nov 15, 2024 at 1:14=E2=80=AFPM Sridhar, Kanchana P
> > <kanchana.p.sridhar@intel.com> wrote:
> > >
> > > Hi Chengming,
> > >
> > > > -----Original Message-----
> > > > From: Chengming Zhou <chengming.zhou@linux.dev>
> > > > Sent: Wednesday, November 13, 2024 11:24 PM
> > > > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>; Johannes
> > Weiner
> > > > <hannes@cmpxchg.org>
> > > > Cc: Nhat Pham <nphamcs@gmail.com>; Yosry Ahmed
> > > > <yosryahmed@google.com>; linux-kernel@vger.kernel.org; linux-
> > > > mm@kvack.org; usamaarif642@gmail.com; ryan.roberts@arm.com;
> > Huang,
> > > > Ying <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-
> > > > foundation.org; Feghali, Wajdi K <wajdi.k.feghali@intel.com>; Gopal=
,
> > Vinodh
> > > > <vinodh.gopal@intel.com>
> > > > Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in
> > > > zswap_decompress().
> > > >
> > > > Hello,
> > > >
> > > > On 2024/11/14 14:37, Sridhar, Kanchana P wrote:
> > > > >
> > > > >> -----Original Message-----
> > > > >> From: Johannes Weiner <hannes@cmpxchg.org>
> > > > >> Sent: Wednesday, November 13, 2024 9:12 PM
> > > > >> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > > > >> Cc: Nhat Pham <nphamcs@gmail.com>; Yosry Ahmed
> > > > >> <yosryahmed@google.com>; linux-kernel@vger.kernel.org; linux-
> > > > >> mm@kvack.org; chengming.zhou@linux.dev;
> > usamaarif642@gmail.com;
> > > > >> ryan.roberts@arm.com; Huang, Ying <ying.huang@intel.com>;
> > > > >> 21cnbao@gmail.com; akpm@linux-foundation.org; Feghali, Wajdi K
> > > > >> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.c=
om>
> > > > >> Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak i=
n
> > > > >> zswap_decompress().
> > > > >>
> > > > >> On Thu, Nov 14, 2024 at 01:56:16AM +0000, Sridhar, Kanchana P
> > wrote:
> > > > >>> So my question was, can we prevent the migration to a different=
 cpu
> > > > >>> by relinquishing the mutex lock after this conditional
> > > > >>
> > > > >> Holding the mutex doesn't prevent preemption/migration.
> > > > >
> > > > > Sure, however, is this also applicable to holding the mutex of a =
per-cpu
> > > > > structure obtained via raw_cpu_ptr()?
> > > >
> > > > Yes, unless you use migration_disable() or cpus_read_lock() to prot=
ect
> > > > this section.
> > >
> > > Ok.
> > >
> > > >
> > > > >
> > > > > Would holding the mutex prevent the acomp_ctx of the cpu prior to
> > > > > the migration (in the UAF scenario you described) from being dele=
ted?
> > > >
> > > > No, cpu offline can kick in anytime to free the acomp_ctx->buffer.
> > > >
> > > > >
> > > > > If holding the per-cpu acomp_ctx's mutex isn't sufficient to prev=
ent the
> > > > > UAF, I agree, we might need a way to prevent the acomp_ctx from b=
eing
> > > > > deleted, e.g. with refcounts as you've suggested, or to not use t=
he
> > > >
> > > > Right, refcount solution from Johannes is very good IMHO.
> > > >
> > > > > acomp_ctx at all for the check, instead use a boolean.
> > > >
> > > > But this is not enough to just avoid using acomp_ctx for the check,
> > > > the usage of acomp_ctx inside the mutex is also UAF, since cpu offl=
ine
> > > > can kick in anytime to free the acomp_ctx->buffer.
> > >
> > > I see. How would the refcounts work? Would this add latency to zswap
> > > ops? In low memory situations, could the cpu offlining code over-ride
> > > the refcounts?
> >
> > I think what Johannes meant is that the zswap compress/decompress
> > paths grab a ref on the acomp_ctx before using it, and the CPU
> > offlining code only drops the initial ref, and does not free the
> > buffer directly. The buffer is only freed when the ref drops to zero.
> >
> > I am not familiar with CPU hotplug, would it be simpler if we have a
> > wrapper like get_acomp_ctx() that disables migration or calls
> > cpus_read_lock() before grabbing the per-CPU acomp_ctx? A similar
> > wrapper, put_acompt_ctx() will be used after we are done using the
> > acomp_ctx.
>
> Would it be sufficient to add a check for mutex_is_locked() in
> zswap_cpu_comp_dead() and if this returns true, to exit without deleting
> the acomp?

I don't think this works. First of all, it's racy. It's possible the
mutex gets locked after we check mutex_is_locked() but before we
delete the acomp_ctx. Also, if we find that the mutex is locked, then
we do nothing and essentially leak the memory.

Second, and probably more important, this only checks if anyone is
currently holding the mutex. What about tasks that may be sleeping
waiting for the mutex to be unlocked? The mutex will be deleted from
under them as well.

> If this is an acceptable solution, it would also require us
> to move the mutex_unlock() to occur after the "if (src !=3D acomp_ctx->bu=
ffer)"
> in zswap_decompress(). This would ensure all existing zswap code that's
> within the mutex_lock()-mutex_unlock() will work correctly without
> worrying about the acomp_ctx being deleted by cpu offlining.
>
> Not sure if this would be a comprehensive solution, or if it would have
> unintended consequences to the cpu offlining code. Would appreciate
> comments.
>
> Thanks,
> Kanchana

