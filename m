Return-Path: <linux-kernel+bounces-414907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBD59D2F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008B61F23959
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669871D3629;
	Tue, 19 Nov 2024 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JyRDvxEz"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2B61D2780
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045905; cv=none; b=DBN+qnz5gfUjte4ND14FiXXGxSNlcBtKpVTmclBmjfMTZSuSKbAJucXVGJOd802I0rMxH1aFllZ5r1Qjc49UwcINyNL5WvliduQml5qDpC4beV/FtlVkvXfVj35MDPgQUVpbTOzpUe13aotrhywqDFvL2xnJCEApWjXVykLHDwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045905; c=relaxed/simple;
	bh=7JNN3j9AcXK1kn/AArAYx0mr1pUblQFYF/cde5OTfCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGd5BtYuV5e5DKDW4go7D9kesEg4JplUE5ZBG/TLPSjV7NJmQV5yaJWQeZbHerHNeeZUYyInKkQAPXYUx453JvJ4FsZOPFpcje6oPSN2clZyXbbwe3UYfvxndj2AA6J1Sr4BqpuCx7F7TXLROAGYT4g3uhx7jk3BBVAQAD0UInc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JyRDvxEz; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-513de4267d8so1547496e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732045902; x=1732650702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JNN3j9AcXK1kn/AArAYx0mr1pUblQFYF/cde5OTfCM=;
        b=JyRDvxEzDYMRoGFy9A63IWJu5V/EN5/TCo9XG8uswqC+Vi7hT46XUi6a1/VrsK6Da1
         IsUhKl8QJfOjGSA5X7UIjqkQATjAtBKE/iC4eXXNt8Uz1nGboW8xM+R84YehfT+auUnH
         KHwm4w3SUYYvzjd2Y+e0e/MKPq6mzRHDKwiMXhO2Q84bYyDbm/jC5bWPCjhEPaWY/FN2
         nh/HCMiJ7evhq+7F5KC8CNsJjVt54b02h+iwuEIir1X9pHflT+3nn3VKx93BeiKg08gu
         M0gniafNl4Oz1ux2Ql2pQti/EqbIXlIQ7WoR8AX1Ke1J2CwMMDeNKsQwdPp9M3mQfmfO
         Fe+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732045902; x=1732650702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JNN3j9AcXK1kn/AArAYx0mr1pUblQFYF/cde5OTfCM=;
        b=sQy1ayQBtrb0cJL9xvkjy1aa/9eBxeyXESio5T2yk2Kg/Ple5lVaks3Ue2SsuF9SGd
         RdOC/14tPi1OEOaqd8sm4Jb8KPeryGnBrosDLjtg3wWxCalaCUaDKZiXx9riNePs/9ec
         rSFiMOcWLHZRXYrm/qTGjFEn8S1ILbydIYcd44fyz/GuzSgYTgrxH5Ci7mC+nVOKvd9A
         RGZtZvz7gKYh8ea77nIyIQPHue0fpHQiMptmQ8jK/AygwNpMXCPY1IBWsVTVkGHkZHjc
         ivIwgywqxL1kHueYFOkT7WsQSJNwcWp4n6O2dnIB2DA1OjM4owNnKJPyMLLpLERWzmEO
         O5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVILj6PRhBa9tB5llrz/nD+k0EAuCyAZZApdfVETTqx6KoUoORy0sbifjvnZnyM5eG1TSMniLY39Yzfqo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqbU5gNTyS08YL9cxXbshC61r2bQrpH/ObQT4hmE1uNxGXyzA4
	g8BAk8ZWHD/qRzG8p0QDACF1knaHsP0PPOj8yMPLnnpgiT8wkS6+fnUkYHJYK03WKl8fiBLgnaA
	IRo1fd1ZJj2B1TVrfDXFhosjqDFlm45AiG82i
X-Google-Smtp-Source: AGHT+IHjYo0EcDoyKZ19FOw3cRDHm/vybvcM2ZH27pw0uD0NP0HI4IPAjlfOCjC+wSo4kzr42kcPJsBfpaozKXZEaqw=
X-Received: by 2002:ac5:c0c9:0:b0:50a:c7cd:bee4 with SMTP id
 71dfb90a1353d-514cf890574mr170689e0c.1.1732045901091; Tue, 19 Nov 2024
 11:51:41 -0800 (PST)
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
 <CAJD7tkaMMoPjrR7mLNMiFD7nOhUoLBJ22BNQYEPvfPww5d2jTg@mail.gmail.com> <SJ0PR11MB5678A7DF494C3FCB687D620EC9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5678A7DF494C3FCB687D620EC9202@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 19 Nov 2024 11:51:04 -0800
Message-ID: <CAJD7tkYP9c8Dc1+fuG2i=okFbVf=jBph3cdFmOO0+vAvmcApvQ@mail.gmail.com>
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

On Tue, Nov 19, 2024 at 11:42=E2=80=AFAM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
>
> > -----Original Message-----
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Sent: Tuesday, November 19, 2024 11:27 AM
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
> > On Tue, Nov 19, 2024 at 11:22=E2=80=AFAM Sridhar, Kanchana P
> > <kanchana.p.sridhar@intel.com> wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Yosry Ahmed <yosryahmed@google.com>
> > > > Sent: Friday, November 15, 2024 1:49 PM
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
> > > > On Fri, Nov 15, 2024 at 1:14=E2=80=AFPM Sridhar, Kanchana P
> > > > <kanchana.p.sridhar@intel.com> wrote:
> > > > >
> > > > > Hi Chengming,
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Chengming Zhou <chengming.zhou@linux.dev>
> > > > > > Sent: Wednesday, November 13, 2024 11:24 PM
> > > > > > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>; Johanne=
s
> > > > Weiner
> > > > > > <hannes@cmpxchg.org>
> > > > > > Cc: Nhat Pham <nphamcs@gmail.com>; Yosry Ahmed
> > > > > > <yosryahmed@google.com>; linux-kernel@vger.kernel.org; linux-
> > > > > > mm@kvack.org; usamaarif642@gmail.com; ryan.roberts@arm.com;
> > > > Huang,
> > > > > > Ying <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-
> > > > > > foundation.org; Feghali, Wajdi K <wajdi.k.feghali@intel.com>; G=
opal,
> > > > Vinodh
> > > > > > <vinodh.gopal@intel.com>
> > > > > > Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak =
in
> > > > > > zswap_decompress().
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > On 2024/11/14 14:37, Sridhar, Kanchana P wrote:
> > > > > > >
> > > > > > >> -----Original Message-----
> > > > > > >> From: Johannes Weiner <hannes@cmpxchg.org>
> > > > > > >> Sent: Wednesday, November 13, 2024 9:12 PM
> > > > > > >> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > > > > > >> Cc: Nhat Pham <nphamcs@gmail.com>; Yosry Ahmed
> > > > > > >> <yosryahmed@google.com>; linux-kernel@vger.kernel.org; linux=
-
> > > > > > >> mm@kvack.org; chengming.zhou@linux.dev;
> > > > usamaarif642@gmail.com;
> > > > > > >> ryan.roberts@arm.com; Huang, Ying <ying.huang@intel.com>;
> > > > > > >> 21cnbao@gmail.com; akpm@linux-foundation.org; Feghali, Wajdi=
 K
> > > > > > >> <wajdi.k.feghali@intel.com>; Gopal, Vinodh
> > <vinodh.gopal@intel.com>
> > > > > > >> Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory le=
ak in
> > > > > > >> zswap_decompress().
> > > > > > >>
> > > > > > >> On Thu, Nov 14, 2024 at 01:56:16AM +0000, Sridhar, Kanchana =
P
> > > > wrote:
> > > > > > >>> So my question was, can we prevent the migration to a diffe=
rent
> > cpu
> > > > > > >>> by relinquishing the mutex lock after this conditional
> > > > > > >>
> > > > > > >> Holding the mutex doesn't prevent preemption/migration.
> > > > > > >
> > > > > > > Sure, however, is this also applicable to holding the mutex o=
f a per-
> > cpu
> > > > > > > structure obtained via raw_cpu_ptr()?
> > > > > >
> > > > > > Yes, unless you use migration_disable() or cpus_read_lock() to =
protect
> > > > > > this section.
> > > > >
> > > > > Ok.
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Would holding the mutex prevent the acomp_ctx of the cpu prio=
r to
> > > > > > > the migration (in the UAF scenario you described) from being
> > deleted?
> > > > > >
> > > > > > No, cpu offline can kick in anytime to free the acomp_ctx->buff=
er.
> > > > > >
> > > > > > >
> > > > > > > If holding the per-cpu acomp_ctx's mutex isn't sufficient to =
prevent
> > the
> > > > > > > UAF, I agree, we might need a way to prevent the acomp_ctx fr=
om
> > being
> > > > > > > deleted, e.g. with refcounts as you've suggested, or to not u=
se the
> > > > > >
> > > > > > Right, refcount solution from Johannes is very good IMHO.
> > > > > >
> > > > > > > acomp_ctx at all for the check, instead use a boolean.
> > > > > >
> > > > > > But this is not enough to just avoid using acomp_ctx for the ch=
eck,
> > > > > > the usage of acomp_ctx inside the mutex is also UAF, since cpu =
offline
> > > > > > can kick in anytime to free the acomp_ctx->buffer.
> > > > >
> > > > > I see. How would the refcounts work? Would this add latency to zs=
wap
> > > > > ops? In low memory situations, could the cpu offlining code over-=
ride
> > > > > the refcounts?
> > > >
> > > > I think what Johannes meant is that the zswap compress/decompress
> > > > paths grab a ref on the acomp_ctx before using it, and the CPU
> > > > offlining code only drops the initial ref, and does not free the
> > > > buffer directly. The buffer is only freed when the ref drops to zer=
o.
> > > >
> > > > I am not familiar with CPU hotplug, would it be simpler if we have =
a
> > > > wrapper like get_acomp_ctx() that disables migration or calls
> > > > cpus_read_lock() before grabbing the per-CPU acomp_ctx? A similar
> > > > wrapper, put_acompt_ctx() will be used after we are done using the
> > > > acomp_ctx.
> > >
> > > Would it be sufficient to add a check for mutex_is_locked() in
> > > zswap_cpu_comp_dead() and if this returns true, to exit without delet=
ing
> > > the acomp?
> >
> > I don't think this works. First of all, it's racy. It's possible the
> > mutex gets locked after we check mutex_is_locked() but before we
> > delete the acomp_ctx. Also, if we find that the mutex is locked, then
> > we do nothing and essentially leak the memory.
>
> Yes, this would assume the cpu offlining code retries at some interval,
> which could prevent the memory leak.

I am not sure about that, but even so, it wouldn't handle the first
scenario where the mutex gets locked after we check mutex_is_locked().

>
> >
> > Second, and probably more important, this only checks if anyone is
> > currently holding the mutex. What about tasks that may be sleeping
> > waiting for the mutex to be unlocked? The mutex will be deleted from
> > under them as well.
>
> Wouldn't this and the race described above, also be issues for the
> refcount based approach?

I don't think so, at least if implemented correctly. There are a lot
of examples around the kernel that use RCU + refcounts for such use
cases. I think there are also some examples in kernel docs.

That being said, I am wondering if we can get away with something
simpler like holding the cpus read lock or disabling migration as I
suggested earlier, but I am not quite sure.

>
> Also, I am wondering if the mutex design already handles cases where
> tasks are sleeping, waiting for a mutex that disappears?

I don't believe so. It doesn't make sense for someone to free a mutex
while someone is waiting for it. How would the waiter know if the
memory backing the mutex was freed?

