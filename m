Return-Path: <linux-kernel+bounces-319335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1306396FB3E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDBB1C225B9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 18:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97203FB8B;
	Fri,  6 Sep 2024 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pmzfwBFC"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E4A1B85C7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725647647; cv=none; b=mFkFH5rk0F80iqR1Ivme/0AovC/ILW/yBoLj4LKMrNo27siKiozZdZLFvI45AP4HX0NzlmYokG8S64yKhnGxIdZN9jf4zFFOiz37RWbrXH2tEQ7ABZhIusrTRPnzt8XYGcJAwUyLPw4s7i+JcXkdycccPu6EUnLd+0uIUSHpevA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725647647; c=relaxed/simple;
	bh=nf+aIalK2xxby+R4HUV8cKl/cjjSgN53qjQYeNriqr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=siNkFr1fATRwMNgHoPi/WgtieZizpxtDeDJ/UDEZbJkAoBXSTOMHjvKStP5sGuvTIBQCPJLC8ICY1a3+LyXibo4XHvEZEEcCTORe2FXqNko/Ex8P9YYuC10KJ2ssyBzvh0YAT3cZ39+CstfSvabCNgIfTTiVCk9zVC9K7MBFj/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pmzfwBFC; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5becfd14353so2270684a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 11:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725647643; x=1726252443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA4jWvAKerLqKGdQGsNhlfRSBHZb9aDWu1i/jhaydx8=;
        b=pmzfwBFCtI2Ke8t8EsApdBBT7DfsW+hXBYpkfAiZq/s2BKQk/UQrVVVU0jGXWIs7Db
         fMWZMNklArIof5LWdXShzPs+i8HtM3oXWBSGXRjMqB1JyVLxsk4f2SVN0tmOXrCncZzL
         giHeIWyui77fmqYGLYBxXr87yoHb+OB+bG8Z/zn4YYI9eCdp7sHOHze2MLRjGfqqPBL0
         IF02ugsGP2+OA7JSNbkSq7HNm7AB/7X9daiQ/1gmjBDleAry2UuKoAsYQXeAn3KsSB0N
         PBg3o+3pfts1KEQuLayc3ENs7PcMgTPgUibtBlapngn1GMPl9nSpUq/X2mHLweWE5j3h
         mM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725647643; x=1726252443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wA4jWvAKerLqKGdQGsNhlfRSBHZb9aDWu1i/jhaydx8=;
        b=HitgNjLxeJTIn9AhdPQB1nDDz1TENrfZDNf0MrY6M/csQ5BdUWZNkFHgZxBnoEEm8O
         h9JCSZ5lhReHRYn0McUawjm5CTNxJyVC9l0p3GFwvWpKSfkUuK/4sznK/xyOmlBiToq4
         FCjMSQt+L+M8F7ldwkZyDx9yK3SdgX+O42Fa2mMesHKpMvuGevULSxJSBOmixVcnOcgq
         xA2CvsbYiG6rWe+iZq+ZW/CWeMF5xxiMMIKkonSdLSyuMwmn7WgYU8/fUTmLZuwwm1x/
         /XvRKF0PTanNTZL7R2lxj9uC21SDBXQM+N4Jz3/Pu4HEfWFtd0JhXHgb6V2EkCu08PuH
         avkw==
X-Forwarded-Encrypted: i=1; AJvYcCU9NyU7BFrhJAu6OXlEl9VGwZYRrmClFxSMzDC+BKjTNzgzWH8q8v8zkmUI2CWhvTt4SkfzjiuOttopK1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPXYIzXFKi1SQBwXdlwagJMCkBMX5TBf9DV0+3/GT9Hey5pIJq
	UDskaIO6Lw7Q8bgX6Q9pDRIUCHSguvUT+gySnR0IdmFzHnRHQF4u7gXIZXWn7tW1y/97Yh/tStN
	tQLBeqzUbExKNxCk3V278MEAZQYLPKK1EOqZV
X-Google-Smtp-Source: AGHT+IHPZtkpY6maXS950f7lChurENnJfJyabHtW/7qxTPqFZIsvXKotGst5TiU8Um040WIhrofijsV9Mr2GmpL7Wh4=
X-Received: by 2002:a17:907:7e89:b0:a86:aded:b089 with SMTP id
 a640c23a62f3a-a897fad808emr2051090266b.68.1725647642749; Fri, 06 Sep 2024
 11:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906001047.1245-1-21cnbao@gmail.com> <20240906001047.1245-3-21cnbao@gmail.com>
In-Reply-To: <20240906001047.1245-3-21cnbao@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 6 Sep 2024 11:33:26 -0700
Message-ID: <CAJD7tkaTe=xuTp56h+58SaGxZTL8dOn4a2TQAiWwaJQd=CSjPg@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] mm: add nr argument in mem_cgroup_swapin_uncharge_swap()
 helper to support large folios
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, hanchuanhua@oppo.com, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hch@infradead.org, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	ryncsn@gmail.com, senozhatsky@chromium.org, shakeel.butt@linux.dev, 
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, xiang@kernel.org, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 5:11=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> With large folios swap-in, we might need to uncharge multiple entries all
> together, add nr argument in mem_cgroup_swapin_uncharge_swap().
>
> For the existing two users, just pass nr=3D1.
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> Acked-by: Chris Li <chrisl@kernel.org>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Gao Xiang <xiang@kernel.org>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Kairui Song <ryncsn@gmail.com>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> ---
>  include/linux/memcontrol.h | 5 +++--
>  mm/memcontrol.c            | 7 ++++---
>  mm/memory.c                | 2 +-
>  mm/swap_state.c            | 2 +-
>  4 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 2ef94c74847d..34d2da05f2f1 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -699,7 +699,8 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *=
memcg, gfp_t gfp,
>
>  int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct=
 *mm,
>                                   gfp_t gfp, swp_entry_t entry);
> -void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
> +
> +void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr_=
pages);
>
>  void __mem_cgroup_uncharge(struct folio *folio);
>
> @@ -1206,7 +1207,7 @@ static inline int mem_cgroup_swapin_charge_folio(st=
ruct folio *folio,
>         return 0;
>  }
>
> -static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
> +static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, un=
signed int nr)
>  {
>  }
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index bda6f75d22ff..c0d36ca20332 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4559,14 +4559,15 @@ int mem_cgroup_swapin_charge_folio(struct folio *=
folio, struct mm_struct *mm,
>
>  /*
>   * mem_cgroup_swapin_uncharge_swap - uncharge swap slot
> - * @entry: swap entry for which the page is charged
> + * @entry: the first swap entry for which the pages are charged
> + * @nr_pages: number of pages which will be uncharged
>   *
>   * Call this function after successfully adding the charged page to swap=
cache.
>   *
>   * Note: This function assumes the page for which swap slot is being unc=
harged
>   * is order 0 page.
>   */
> -void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
> +void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr_=
pages)
>  {
>         /*
>          * Cgroup1's unified memory+swap counter has been charged with th=
e
> @@ -4586,7 +4587,7 @@ void mem_cgroup_swapin_uncharge_swap(swp_entry_t en=
try)
>                  * let's not wait for it.  The page already received a
>                  * memory+swap charge, drop the swap entry duplicate.
>                  */
> -               mem_cgroup_uncharge_swap(entry, 1);
> +               mem_cgroup_uncharge_swap(entry, nr_pages);
>         }
>  }
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 42674c0748cb..cdf03b39a92c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4100,7 +4100,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                                         ret =3D VM_FAULT_OOM;
>                                         goto out_page;
>                                 }
> -                               mem_cgroup_swapin_uncharge_swap(entry);
> +                               mem_cgroup_swapin_uncharge_swap(entry, 1)=
;
>
>                                 shadow =3D get_shadow_from_swap_cache(ent=
ry);
>                                 if (shadow)
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index a042720554a7..4669f29cf555 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -522,7 +522,7 @@ struct folio *__read_swap_cache_async(swp_entry_t ent=
ry, gfp_t gfp_mask,
>         if (add_to_swap_cache(new_folio, entry, gfp_mask & GFP_RECLAIM_MA=
SK, &shadow))
>                 goto fail_unlock;
>
> -       mem_cgroup_swapin_uncharge_swap(entry);
> +       mem_cgroup_swapin_uncharge_swap(entry, 1);
>
>         if (shadow)
>                 workingset_refault(new_folio, shadow);
> --
> 2.34.1
>

