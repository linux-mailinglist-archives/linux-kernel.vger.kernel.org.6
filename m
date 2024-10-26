Return-Path: <linux-kernel+bounces-383268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DE19B193E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 17:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044802828FD
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 15:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DDC224CC;
	Sat, 26 Oct 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rxAG5WYL"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3426069959
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729957061; cv=none; b=kiQ1UH0ny95ULE/c6oiA5JoNV1KR1UMcFtJId+/R9zfnHZC19zGCsSrngNZJMFviGokbD+nf9N97xekDwGbgkkjwUp0GcSV5rTgLWIPGBzZ8zycZrdDGgprV9u9eYzXVOKQ3v23DgyVvgosU4ZgxLPsMvwYQCHPvW0fFY5T3TVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729957061; c=relaxed/simple;
	bh=Yz8u2ESFooN7cEwtwgwhL4iRFPtOhKxkIhiEheuqmbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLcdBosiMadyIZHCBSswO+1Q1P39eHaWjfH2C6rAITJlHaVJadH3DOQcsmd0nJbGYvCIhTWcb4CFHKP8gDt6P6Ri7eBOPQEsesf48IT7NIigKtdUdLv2NRZeU4icgzT37hkc2XyLmQNjNk20iv0VKFisc0V/kjvbph8mYaUBPSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rxAG5WYL; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4a487a7519fso1031257137.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729957058; x=1730561858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GanVEa8cxLQoFBTsvQcEmQf1/zCR9K0WFuLJ4NsXrxc=;
        b=rxAG5WYLcuA50d5UZwnEjqtEzKoN+FJk+cM3vBywEI4v8Qyfr6Ah2c35zDjT3hlIDi
         IqigO6OL82dWE7oqCkgeYeTZVtY0n0In8i3v/jbOpZf8YofsLT7JR0mSOBdrmJDXdntl
         nrVQ4vLlNL531JYSH+2ioAaWLzXjGiix4gSFHzObuPPc8UPGxmUfuvNXY+X7wHR7lShi
         jon45Nj/LyooOkB5rCTk9j2kNK1PUk7QFuiystLzX6xi8pipZWrF58M0b965+MZcJ6Q4
         3VBGTqBVYH/+07Zxm/VVxj4WuyhLT5QmBcwisKYVApRve3kQK7tnhA/uxbiaQ59Q+N89
         kbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729957058; x=1730561858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GanVEa8cxLQoFBTsvQcEmQf1/zCR9K0WFuLJ4NsXrxc=;
        b=v818F/j/YgW4ZrqTKmaZf3npkHqxt6EA8grZp9GiwdPwH9lkEo31UXInm/4RjcgVju
         1k895Ng1RCACZa0KVr0Pv0J3k7WGhvENohcZxfrYlAEd8bqSrjXkK9LzCbL/gJ6U10ul
         0nP3CWkDu4mmj6cv5pwg2VOeUBtupJ/dZHv0gTSIIOngNxCToMdN0g6kGS/LLxsDFKbq
         ubFpyVMeFyw+p9OlwuO4aCvJVhP/p1ozNO4p6ayhcB35wkUJIZ04gtL2G5PyYSJIHSnD
         4q/lV6CbVBjL0oDA/qzK0ZWLEhvM6ukb9q3Wlykn9HAJJMpwVLPjEd3OTiMZ4hLeLwuG
         G4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjI7omycJ/puBjSrWPQZT3bIEtY4B4t9P/G/eK6uGgsiAVp5n6icUMI4AAwkiPn4CYhkpA69cjEfQ4JXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjP/9FzGkdpxhOmjTOu9gBXhtGHWGsYuih7oENp8sHy+bydy+7
	tCZfCjfY4XpR2iI/ZZFz1qAwp4D5Tk60Wfy/kO6A79Y7TpbKrz2f2V3tT0H/7DWYB8owf3l8kSu
	q8HfOEGyeKfpPObDYDRLFT28d8IWkimEEqiSk
X-Google-Smtp-Source: AGHT+IG2RGgBmdZacmDvK+ZXfc1orwt5wJxlOHkWOH534qXUZnG23pX4f5qZaNSJZCpJ6+484snWzRlS7OBe2bIA/4c=
X-Received: by 2002:a05:6102:2ad2:b0:4a3:b506:56ac with SMTP id
 ada2fe7eead31-4a8cfb44d52mr1991537137.7.1729957057835; Sat, 26 Oct 2024
 08:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026071145.3287517-1-shakeel.butt@linux.dev>
In-Reply-To: <20241026071145.3287517-1-shakeel.butt@linux.dev>
From: Yu Zhao <yuzhao@google.com>
Date: Sat, 26 Oct 2024 09:37:00 -0600
Message-ID: <CAOUHufYjLWJ6WgHjmRrBTNLFyFSaMG8tSV4JExqMTKADnd=sDg@mail.gmail.com>
Subject: Re: [PATCH] memcg: workingset: remove folio_memcg_rcu usage
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Hugh Dickins <hughd@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 1:12=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> The function workingset_activation() is called from
> folio_mark_accessed() with the guarantee that the given folio can not be
> freed under us in workingset_activation(). In addition, the association
> of the folio and its memcg can not be broken here because charge
> migration is no more. There is no need to use folio_memcg_rcu. Simply
> use folio_memcg_charged() because that is what this function cares
> about.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Suggested-by: Yu Zhao <yuzhao@google.com>
> ---
>
> Andrew, please put this patch after the charge migration deprecation
> series.
>
>  include/linux/memcontrol.h | 35 -----------------------------------
>  mm/workingset.c            | 10 ++--------
>  2 files changed, 2 insertions(+), 43 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 932534291ca2..89a1e9f10e1b 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -443,35 +443,6 @@ static inline bool folio_memcg_charged(struct folio =
*folio)
>         return __folio_memcg(folio) !=3D NULL;
>  }
>
> -/**
> - * folio_memcg_rcu - Locklessly get the memory cgroup associated with a =
folio.
> - * @folio: Pointer to the folio.
> - *
> - * This function assumes that the folio is known to have a
> - * proper memory cgroup pointer. It's not safe to call this function
> - * against some type of folios, e.g. slab folios or ex-slab folios.
> - *
> - * Return: A pointer to the memory cgroup associated with the folio,
> - * or NULL.
> - */
> -static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
> -{
> -       unsigned long memcg_data =3D READ_ONCE(folio->memcg_data);
> -
> -       VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
> -
> -       if (memcg_data & MEMCG_DATA_KMEM) {
> -               struct obj_cgroup *objcg;
> -
> -               objcg =3D (void *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
> -               return obj_cgroup_memcg(objcg);
> -       }
> -
> -       WARN_ON_ONCE(!rcu_read_lock_held());
> -
> -       return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
> -}
> -
>  /*
>   * folio_memcg_check - Get the memory cgroup associated with a folio.
>   * @folio: Pointer to the folio.
> @@ -1084,12 +1055,6 @@ static inline struct mem_cgroup *folio_memcg(struc=
t folio *folio)
>         return NULL;
>  }
>
> -static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
> -{
> -       WARN_ON_ONCE(!rcu_read_lock_held());
> -       return NULL;
> -}
> -
>  static inline struct mem_cgroup *folio_memcg_check(struct folio *folio)
>  {
>         return NULL;
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 4b58ef535a17..c47aa482fad5 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -591,9 +591,6 @@ void workingset_refault(struct folio *folio, void *sh=
adow)
>   */
>  void workingset_activation(struct folio *folio)
>  {
> -       struct mem_cgroup *memcg;
> -
> -       rcu_read_lock();
>         /*
>          * Filter non-memcg pages here, e.g. unmap can call
>          * mark_page_accessed() on VDSO pages.
> @@ -601,12 +598,9 @@ void workingset_activation(struct folio *folio)
>          * XXX: See workingset_refault() - this should return
>          * root_mem_cgroup even for !CONFIG_MEMCG.

The "XXX" part of the comments doesn't apply anymore.

>          */
> -       memcg =3D folio_memcg_rcu(folio);
> -       if (!mem_cgroup_disabled() && !memcg)
> -               goto out;
> +       if (mem_cgroup_disabled() || !folio_memcg_charged(folio))
> +               return;
>         workingset_age_nonresident(folio_lruvec(folio), folio_nr_pages(fo=
lio));

 if (mem_cgroup_disabled() || folio_memcg_charged(folio))
    workingset_age_nonresident()

We still want to call workingset_age_nonresident() when memcg is
disabled. (We just want to "Filter non-memcg pages here" when memcg is
enabled, as the comment above says, which I assume still applies?)

> -out:
> -       rcu_read_unlock();
>  }
>
>  /*
> --
> 2.43.5
>

