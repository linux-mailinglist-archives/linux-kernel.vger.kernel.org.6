Return-Path: <linux-kernel+bounces-411429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5318E9CF943
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D79EB1F21515
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 22:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FF018DF89;
	Fri, 15 Nov 2024 21:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MAO39tM2"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2C241C69
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707385; cv=none; b=Owhp2cti6v8mcE6vLHXOzpUuzUh0n1teqJ2q3c2MM/TZ2mh6s0Z6Tlk+9i+yfPjq9fPhxWqknlTXZFeJM7Acv9mI6dyZVd8aHnGqIWVSZjhTtdcR283IqC6EuC0/YY0bKfDrclFtKKnp8qXcBrB2MT3DxFBqbMZpd/h7swXB2VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707385; c=relaxed/simple;
	bh=2MFOl+reVvqG3gSOiuAKMho/Jj4WzWL6vuFCI/y9WDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USYUgHs1vArmC/Oeqtg/fvhjre4px0f3jJZiXExprOLxSl3ej2uIfynAjgaAKdtviHgRtXKHYdywxHeWNXmfVft2f1KNx/cNoqr7l6NTz48/VC6JUSRnO7yTUToDAriWIK2zvmLcsk06ZW6O422VT+5xMU1USTuNFjm/Yrj4ZUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MAO39tM2; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b15467f383so76758985a.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731707383; x=1732312183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MFOl+reVvqG3gSOiuAKMho/Jj4WzWL6vuFCI/y9WDM=;
        b=MAO39tM2p9dy7tD6c/rFfts6nCOAqZztAgZZplaU/mcFeV5ynMQq37w28sZ1+4sdLu
         oL0w4udzxBltlwjLH54PF1jx6Hac6ciLC+AslHe5Twp7TZ1OKfbkKixtY2e7yuoEwjLy
         7PqinvJg20r6YkDuKVafMb8cfJttpOephNr5/XZUof84XsSfWRDZIHioiP1ou1zQSIBd
         pXzXZDK4uBNuMLTPydGkQF8LiFXb+FYi4SGFj+PRw5BMRoVdrw6oLA4jQYAlLDTfkvPw
         0Y/1+TmsvwI28+scoilxcSTyxHZzptjZktnTp28Gj6UP66skB1rV5lqEE82oQY/30Fht
         tnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731707383; x=1732312183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MFOl+reVvqG3gSOiuAKMho/Jj4WzWL6vuFCI/y9WDM=;
        b=FIi1K0fdl12AOBvuD7xkcG14HK+fDZ7IY66spvzDgHcQvx1Wy9d+Mc4BKQj+lQlxe9
         Bt2jDwj5xNNouZ1UnqwB7qQHX3O3PwRdOGW7w+lgfwqom5y94Hbuq7WJ2d1S+mWvYZp8
         ouNOioOWbY8AMJ7wQvP4T+xs6JIlDR/+UyQnnNs4vumMTaxl5wuk6wNDMZ+ukcaAtvzc
         L6Wknl6Q179b/qMCNS97oFyCynfy3y7xBjEaeqILbZasMKMHndquEY5CFY5TVUuWd4K3
         98qUuBebQR2PTZXaif3YLf+4Aw5cNXEGKG/mLEI/5/dU8B3jTRwwYdYs6sCD/vhsS+zc
         FS3A==
X-Forwarded-Encrypted: i=1; AJvYcCVdLItVuFdKICjGymANPahpYGM8s6A79l8fQIxUGpxnHf6yvkfThyzToh2DhSdflNl5q5+8783VOUe1M8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3AqKDtyATGO5xOwUQWhs7navI++3mlYp3oEqVqtno0Q94RETj
	rJFT22nH76EXOaj1oJ6G43lBffXfecTc+OJMERUDlaTvKzb0JFTGhPT5SrwNRbF/FzMY8KzLMCf
	j8d55OEYlfMMFR+ykpPXps6Ug/zJp8kTb0muG
X-Google-Smtp-Source: AGHT+IEF6dmuT2PB7Z4+bp45BUPpk4Wd27INZddF9AtMW8EKIomFP19UzsYV0c6l3/HQXUfT11/K2tov5YMXcQrAJbo=
X-Received: by 2002:a05:6214:2c06:b0:6d3:fa98:cf4a with SMTP id
 6a1803df08f44-6d3fb885af6mr48930636d6.34.1731707382452; Fri, 15 Nov 2024
 13:49:42 -0800 (PST)
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
In-Reply-To: <SJ0PR11MB567847C73338BC325FE49D11C9242@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 15 Nov 2024 13:49:05 -0800
Message-ID: <CAJD7tkZ+OM2uiHgHHeNqBeSaptfXw4MG=E280-5PKpeybB=8dQ@mail.gmail.com>
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

On Fri, Nov 15, 2024 at 1:14=E2=80=AFPM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
> Hi Chengming,
>
> > -----Original Message-----
> > From: Chengming Zhou <chengming.zhou@linux.dev>
> > Sent: Wednesday, November 13, 2024 11:24 PM
> > To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>; Johannes Weiner
> > <hannes@cmpxchg.org>
> > Cc: Nhat Pham <nphamcs@gmail.com>; Yosry Ahmed
> > <yosryahmed@google.com>; linux-kernel@vger.kernel.org; linux-
> > mm@kvack.org; usamaarif642@gmail.com; ryan.roberts@arm.com; Huang,
> > Ying <ying.huang@intel.com>; 21cnbao@gmail.com; akpm@linux-
> > foundation.org; Feghali, Wajdi K <wajdi.k.feghali@intel.com>; Gopal, Vi=
nodh
> > <vinodh.gopal@intel.com>
> > Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in
> > zswap_decompress().
> >
> > Hello,
> >
> > On 2024/11/14 14:37, Sridhar, Kanchana P wrote:
> > >
> > >> -----Original Message-----
> > >> From: Johannes Weiner <hannes@cmpxchg.org>
> > >> Sent: Wednesday, November 13, 2024 9:12 PM
> > >> To: Sridhar, Kanchana P <kanchana.p.sridhar@intel.com>
> > >> Cc: Nhat Pham <nphamcs@gmail.com>; Yosry Ahmed
> > >> <yosryahmed@google.com>; linux-kernel@vger.kernel.org; linux-
> > >> mm@kvack.org; chengming.zhou@linux.dev; usamaarif642@gmail.com;
> > >> ryan.roberts@arm.com; Huang, Ying <ying.huang@intel.com>;
> > >> 21cnbao@gmail.com; akpm@linux-foundation.org; Feghali, Wajdi K
> > >> <wajdi.k.feghali@intel.com>; Gopal, Vinodh <vinodh.gopal@intel.com>
> > >> Subject: Re: [PATCH v1] mm: zswap: Fix a potential memory leak in
> > >> zswap_decompress().
> > >>
> > >> On Thu, Nov 14, 2024 at 01:56:16AM +0000, Sridhar, Kanchana P wrote:
> > >>> So my question was, can we prevent the migration to a different cpu
> > >>> by relinquishing the mutex lock after this conditional
> > >>
> > >> Holding the mutex doesn't prevent preemption/migration.
> > >
> > > Sure, however, is this also applicable to holding the mutex of a per-=
cpu
> > > structure obtained via raw_cpu_ptr()?
> >
> > Yes, unless you use migration_disable() or cpus_read_lock() to protect
> > this section.
>
> Ok.
>
> >
> > >
> > > Would holding the mutex prevent the acomp_ctx of the cpu prior to
> > > the migration (in the UAF scenario you described) from being deleted?
> >
> > No, cpu offline can kick in anytime to free the acomp_ctx->buffer.
> >
> > >
> > > If holding the per-cpu acomp_ctx's mutex isn't sufficient to prevent =
the
> > > UAF, I agree, we might need a way to prevent the acomp_ctx from being
> > > deleted, e.g. with refcounts as you've suggested, or to not use the
> >
> > Right, refcount solution from Johannes is very good IMHO.
> >
> > > acomp_ctx at all for the check, instead use a boolean.
> >
> > But this is not enough to just avoid using acomp_ctx for the check,
> > the usage of acomp_ctx inside the mutex is also UAF, since cpu offline
> > can kick in anytime to free the acomp_ctx->buffer.
>
> I see. How would the refcounts work? Would this add latency to zswap
> ops? In low memory situations, could the cpu offlining code over-ride
> the refcounts?

I think what Johannes meant is that the zswap compress/decompress
paths grab a ref on the acomp_ctx before using it, and the CPU
offlining code only drops the initial ref, and does not free the
buffer directly. The buffer is only freed when the ref drops to zero.

I am not familiar with CPU hotplug, would it be simpler if we have a
wrapper like get_acomp_ctx() that disables migration or calls
cpus_read_lock() before grabbing the per-CPU acomp_ctx? A similar
wrapper, put_acompt_ctx() will be used after we are done using the
acomp_ctx.

>
> Based on Johannes' earlier comments, I don't think it makes sense for
> me to submit a v2.
>
> Thanks,
> Kanchana
>
> >
> > Thanks.

