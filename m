Return-Path: <linux-kernel+bounces-422851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C703D9D9EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 22:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48476B22079
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC431DFD9D;
	Tue, 26 Nov 2024 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dAF5SO5u"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1B3160884
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 21:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732657886; cv=none; b=i8UyTEcGBVTinR7lWbrVKSvxIJCYEpJG72QaB2B6KlCeb7A57guagMQkm7kE8uG61x/ecvMdXavYQkaOGu+OsefWZnGL0qmYWrgCS3gVTgs78FBBrSjcAn6DOIIs6czF79w0YeUmNQDNKxSTymYMMDpjekZXxLSdvAPl96wpXyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732657886; c=relaxed/simple;
	bh=845xXqnB33nlJjULLO/nrCqGOfiZyHwIgYSmqaNLCHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScYU4joY2OOi3iMsTtxKEf8T0neZA7UjRTj5kMzmP+nyd/Goz5921dJNAYoM6o1MbeE1TfuP+firQagUcv2Y9TurVGBVtCuE0wLvDx9Y30dvwNDPFePmfZdXXBu0M3xa1ZPfOohNkm8hGkPD1saBz6NckzyZmqUpMnl+9O/8mGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dAF5SO5u; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4668194603cso12791cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732657883; x=1733262683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4n8OSPqRkLvx2KI0lecepo254y3Ft1HLiSCqdymG99Q=;
        b=dAF5SO5ucAefSepms13lo3ST4YpuQjgkSHLNKPlhs4aUmKbCELCSmotfi/3f4+5cMx
         aZcqp0bTR1zuENQ2BXm2BEEWjBitIu7LC+TxrBWu57Ro+RRac9hWX+J+AJPVObkpYzGg
         PWjq2W7xvF1s6ElP00pulcIddpyr3eLPcoLHD1VKKoNDx3m4FynbKJUJLchLm7kBAwIB
         szKgjOOX8C5J89oXaYcvEOxirJN2PVVp3Q41882qprGO64pOL1ugj5XSujYQLwYPxRW/
         h9Y9l94jerxzfjfqAJvpBdg0+0+bxuZOwDNBU5zlRbxvSFTaQSz7GKdlZhKDStmsEXT/
         kL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732657883; x=1733262683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4n8OSPqRkLvx2KI0lecepo254y3Ft1HLiSCqdymG99Q=;
        b=reSQegqOjF3JrVZhUtIau4SzYRK7tf11Jt66MIN//VqPReE9agG0fL/xm+bhh5jzXq
         MeX8KszYy5fbTpM6TfBQ2059zA3Wqn9Zer2ibkqmF2RP68eNNuA+FS4oj3aUbmTMncHg
         TBvMh4T/s5b2ZrZK5Y0MfwZiCnROSeFHsqOj9Glt0zKIq8OaE1YLHxgtioC4G0/7RDo4
         EB6I+1gQfkk4bkwv7WwO1a7Uds0xxiyRKQ6vgO0j3Sg9v88Bi+dI9dYnvWM1tExh7Dtl
         C3hhaU5O7Pal75YQtRr07T8En20cjV3j4O+Zymc5NH20KFE/JAWog7Z8rJPIppyu98CH
         N8SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAZ25nmh0H6zhVVrdGPu2RYu0/2TvzAo/92/bqrI2Om3iXXsSCdmRjOSTqrolDEqTGwCUyyeMuywaFT3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQzEInfB42CpFpXmnls4jHOZtYgYLQDZU4vQiaP0be5GwtzSAU
	RblCbqvVaRfF8k4PeSXcEqAs5BW7RFqxizsy1FQaa+GSVGCWl9sCqM4mk5H6Sr86Bqg5jlIZU9F
	8gV7+82ixibpI+wUwrbsqRqU3I3lNCrR3f6Ym
X-Gm-Gg: ASbGncvnHlGsY4hdxmTTdiH0ZbYlacBB5g4XssWPGtnU2+8CtkevzTcBZSSXHYZRugi
	BoHPuwukMa74zJX3qK9vaDOgr3DSydLp9qRSHRu0qtEKxYgVVkvurAM+Ub1y7Qw==
X-Google-Smtp-Source: AGHT+IEEk5aN1eOwnEFKq2VpTSyQGdQBHpkfnICA0k0tDUjJ3oDS7OJn1bkFEhhsrwVy9UKRgNHio5nOyVpIPjmGRwc=
X-Received: by 2002:a05:622a:5e83:b0:461:48f9:4852 with SMTP id
 d75a77b69052e-466b3dc63bcmr655761cf.28.1732657883030; Tue, 26 Nov 2024
 13:51:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120103456.396577-1-linyunsheng@huawei.com>
 <20241120103456.396577-3-linyunsheng@huawei.com> <3366bf89-4544-4b82-83ec-fd89dd009228@kernel.org>
 <27475b57-eda1-4d67-93f2-5ca443632f6b@huawei.com>
In-Reply-To: <27475b57-eda1-4d67-93f2-5ca443632f6b@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 26 Nov 2024 13:51:11 -0800
Message-ID: <CAHS8izM+sK=48gfa3gRNffu=T6t6-2vaS60QvH79zFA3gSDv9g@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/3] page_pool: fix IOMMU crash when driver has
 already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, liuyonglong@huawei.com, fanghaiqing@huawei.com, 
	zhangkun09@huawei.com, Robin Murphy <robin.murphy@arm.com>, 
	Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 12:03=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.c=
om> wrote:
>
> On 2024/11/20 23:10, Jesper Dangaard Brouer wrote:
> >
> >>       page_pool_detached(pool);
> >>       pool->defer_start =3D jiffies;
> >>       pool->defer_warn  =3D jiffies + DEFER_WARN_INTERVAL;
> >> @@ -1159,7 +1228,7 @@ void page_pool_update_nid(struct page_pool *pool=
, int new_nid)
> >>       /* Flush pool alloc cache, as refill will check NUMA node */
> >>       while (pool->alloc.count) {
> >>           netmem =3D pool->alloc.cache[--pool->alloc.count];
> >> -        page_pool_return_page(pool, netmem);
> >> +        __page_pool_return_page(pool, netmem);
> >>       }
> >>   }
> >>   EXPORT_SYMBOL(page_pool_update_nid);
> >
> > Thanks for continuing to work on this :-)
>
> I am not sure how scalable the scanning is going to be if the memory size=
 became
> bigger, which is one of the reason I was posting it as RFC for this versi=
on.
>
> For some quick searching here, it seems there might be server with max ra=
m capacity
> of 12.3TB, which means the scanning might take up to about 10 secs for th=
ose systems.
> The spin_lock is used to avoid concurrency as the page_pool_put_page() AP=
I might be
> called from the softirq context, which might mean there might be spinning=
 of 12 secs
> in the softirq context.
>
> And it seems hard to call cond_resched() when the scanning and unmapping =
takes a lot
> of time as page_pool_put_page() might be called concurrently when pool->d=
estroy_lock
> is released, which might means page_pool_get_dma_addr() need to be checke=
d to decide
> if the mapping is already done or not for each page.
>
> Also, I am not sure it is appropriate to stall the driver unbound up to 1=
0 secs here
> for those large memory systems.
>
> https://www.broadberry.com/12tb-ram-supermicro-servers?srsltid=3DAfmBOorC=
PCZQBSv91mOGH3WTg9Cq0MhksnVYL_eXxOHtHJyuYzjyvwgH
>

FWIW I'm also concerned about the looping of all memory on the system.
In addition to the performance, I think (but not sure), that
CONFIG_MEMORY_HOTPLUG may mess such a loop as memory may appear or
disappear concurrently. Even if not, the CPU cost of this may be
significant. I'm imagining the possibility of having many page_pools
allocated on the system for many hardware queues, (and maybe multiple
pp's per queue for applications like devmem TCP), and each pp looping
over the entire xTB memory on page_pool_destroy()...

My 2 cents here is that a more reasonable approach is to have the pp
track all pages it has dma-mapped, without the problems in the
previous iterations of this patch:

1. When we dma-map a page, we add it to some pp->dma_mapped data
structure (maybe xarray or rculist).
2. When we dma-unmap a page, we remove it from pp->dma_mapped.
3 When we destroy the pp, we traverse pp->dma_mapped and unmap all the
pages there.

I haven't looked deeply, but with the right data structure we may be
able to synchronize 1, 2, and 3 without any additional locks. From a
quick skim it seems maybe rculist and xarray can do this without
additional locks, maybe.

Like stated in the previous iterations of this approach, we should not
be putting any hard limit on the amount of memory the pp can allocate,
and we should not have to mess with the page->pp entry in struct page.

--=20
Thanks,
Mina

