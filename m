Return-Path: <linux-kernel+bounces-344923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3D098AFC2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19DFE1C20EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73424188596;
	Mon, 30 Sep 2024 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r9YgZhwV"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B60B15E97
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734738; cv=none; b=g3q88TDJodagz+7Z/D81JjNVgMm9TXAH+9cuJJKqnd3MMCLtoy256zYGhWFyENx+BRNwMcUgDlRxnX4vvuVAu+Cp8EJ04bnphFz4fDWYhbgP2lkYrm+29gF/+fsrJzq8B1SUohJEj70VfWlZ5SRpC+C8C/yVIGKGTApqym9nzkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734738; c=relaxed/simple;
	bh=W/oDXTMCYO6kscx8YbK/vCeuh5c8bFfdtbJ66ErE6ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QdAVnzXZsdhJ/5700vXmtaWh5dzirVJJXxV8q1AJu2VYrmODK49875DNsfEs0irUY5lbsY+B7mzqWkpVdWS67RVvfEBMvkr/jTH6DhfArTqk+S359OBhZf/K6+K2FQmCHJBBR0vUBGPlA1oleM7qKF8TrXrfKK6pdircpYHNC+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r9YgZhwV; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso762483066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727734735; x=1728339535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heICobNBYMwv9PDahOwku+Z5fssVOga50x/P4U0V300=;
        b=r9YgZhwVb/wDfFyMqj2tjuhz4KldeMlOqtgwZyR38JEs+QRCalYWj2c6Wssaum3ZHr
         4yfGmbFEe3V4LiAEaRkNfJQoQzekAS00+FgdJB5tRtgxjVcT7P/E6Ctgzi7ScaZZJDv6
         Gs7mRusYFUaJXLFpR9xf8s8ErOAUKqxy7SkIQoEROMvJ0bkTprNW4WvLJPFo2qr7xVR1
         rgw4ta6SpP5ZwR9eyrmTUNPjCp/JT0g1BnIzDoM2YuA33ZB6NrhM7/lAJJK+0aIu5WeA
         2oLql7bWM/KlwwSP0NF4xaxyP9CHIC0I26DyopH95i1QaaWnvmHkbaD3/NxqhUjO6jmS
         82jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727734735; x=1728339535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=heICobNBYMwv9PDahOwku+Z5fssVOga50x/P4U0V300=;
        b=qJw+dOw/BX1eI/UwgYxJqzEd32K5jEXvrvggdJMm/SsYD0f6qJ4vUaAVLMJvJGCjYL
         qQ4zkw8LhzkPhlLiORaw5HBdhIFzyzDC5+twzPUMrQWGcT2lG8WQh/swStOGG/sRoDC9
         AaN4gwOGHXVPzd7i+jUFsXVgAO0EuEHx7ZEU3Bo1D2idWbsJUnpsIq0Ti6VueV/7sENO
         BCjHOr27j5unYStcdaXj7kMc2GJDgklYJc+O3Bt9CKEnWSW6GJZ6rCsa+xI/SJVOQRjA
         xJikdtR77BtKuECmV3HJJbsz4FoakF7GogcRQI2IjxxrPafbuPqe04f2AsSrxqEUSjEr
         6LMQ==
X-Gm-Message-State: AOJu0YweKrT4fQLqMdn9Aq3MvDXNR1xuHv2N33PUhaMBt5dEI8KEi9XQ
	eN7mMcUCRQDrGiYCsIC7wFkbxUklXVg9h7YawusmZpt150whtI0EUpUfTIdYacwjhx4+9ODO4oP
	0uhz/QRYGwlkUye6DtYFDIheLVntOqG5AKzfL
X-Google-Smtp-Source: AGHT+IHaeSxvBrJy99GOT3SSJsPPagdLkfDvOub+IYZOWAEFcbOG7+eMRwWfmvOeYMg7yBubB4BUV49rQCViiYcPzAM=
X-Received: by 2002:a17:907:9344:b0:a8d:55ce:fb7f with SMTP id
 a640c23a62f3a-a93c4c40561mr1372783966b.62.1727734735219; Mon, 30 Sep 2024
 15:18:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com> <20240930221221.6981-5-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240930221221.6981-5-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 30 Sep 2024 15:18:19 -0700
Message-ID: <CAJD7tkadQ2b8NqUvrSZhJOSm065wfR0qXyb4Q5RLnkc8r9eWsw@mail.gmail.com>
Subject: Re: [PATCH v9 4/7] mm: Change count_objcg_event() to
 count_objcg_events() for batch event updates.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, willy@infradead.org, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 3:12=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> With the introduction of zswap_store() swapping out large folios,
> we need to efficiently update the objcg's memcg events once per
> successfully stored folio. For instance, the 'ZSWPOUT' event needs
> to be incremented by folio_nr_pages().
>
> To facilitate this, the existing count_objcg_event() API is modified
> to be count_objcg_events() that additionally accepts a count parameter.
> The only existing calls to count_objcg_event() are in zswap.c - these
> have been modified to call count_objcg_events() with a count of 1.
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  include/linux/memcontrol.h | 12 +++++++-----
>  mm/zswap.c                 |  6 +++---
>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 15c2716f9aa3..524006313b0d 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1764,8 +1764,9 @@ static inline int memcg_kmem_id(struct mem_cgroup *=
memcg)
>
>  struct mem_cgroup *mem_cgroup_from_slab_obj(void *p);
>
> -static inline void count_objcg_event(struct obj_cgroup *objcg,
> -                                    enum vm_event_item idx)
> +static inline void count_objcg_events(struct obj_cgroup *objcg,
> +                                     enum vm_event_item idx,
> +                                     unsigned long count)
>  {
>         struct mem_cgroup *memcg;
>
> @@ -1774,7 +1775,7 @@ static inline void count_objcg_event(struct obj_cgr=
oup *objcg,
>
>         rcu_read_lock();
>         memcg =3D obj_cgroup_memcg(objcg);
> -       count_memcg_events(memcg, idx, 1);
> +       count_memcg_events(memcg, idx, count);
>         rcu_read_unlock();
>  }
>
> @@ -1829,8 +1830,9 @@ static inline struct mem_cgroup *mem_cgroup_from_sl=
ab_obj(void *p)
>         return NULL;
>  }
>
> -static inline void count_objcg_event(struct obj_cgroup *objcg,
> -                                    enum vm_event_item idx)
> +static inline void count_objcg_events(struct obj_cgroup *objcg,
> +                                     enum vm_event_item idx,
> +                                     unsigned long count)
>  {
>  }
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 0f281e50a034..69b9c025fd47 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1053,7 +1053,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>
>         count_vm_event(ZSWPWB);
>         if (entry->objcg)
> -               count_objcg_event(entry->objcg, ZSWPWB);
> +               count_objcg_events(entry->objcg, ZSWPWB, 1);
>
>         zswap_entry_free(entry);
>
> @@ -1482,7 +1482,7 @@ bool zswap_store(struct folio *folio)
>
>         if (objcg) {
>                 obj_cgroup_charge_zswap(objcg, entry->length);
> -               count_objcg_event(objcg, ZSWPOUT);
> +               count_objcg_events(objcg, ZSWPOUT, 1);
>         }
>
>         /*
> @@ -1576,7 +1576,7 @@ bool zswap_load(struct folio *folio)
>
>         count_vm_event(ZSWPIN);
>         if (entry->objcg)
> -               count_objcg_event(entry->objcg, ZSWPIN);
> +               count_objcg_events(entry->objcg, ZSWPIN, 1);
>
>         if (swapcache) {
>                 zswap_entry_free(entry);
> --
> 2.27.0
>

