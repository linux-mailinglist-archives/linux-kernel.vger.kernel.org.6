Return-Path: <linux-kernel+bounces-446142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E84A39F204D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 19:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8BD1888725
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 18:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570F91A8F6B;
	Sat, 14 Dec 2024 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="clT1p39L"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D9C3D96A
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734201016; cv=none; b=SQzc7WC6VBEvJVT5f1wud7mJQfRFX+ntpdZBeaeDZJsb7THr35U7ym0KwDT/9BT8HoWjuBwyxamuX//sE3VPHAyvTVSIdHFr42eh65O++tUZIqyGqXAxI2bzhKuY04Cu3xmvw/uAnsA3nsbOqEdpj5xy4B6KBvw1/3x7Z0mruZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734201016; c=relaxed/simple;
	bh=XjPwGW2BXQKBQtncWKNfynfoEtP44/XabHm/ibJK1gQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWzSxEFSQut58LvMxwJuuXwxNl7Tp6A+8AQ3MWeAoOyQS6k5CF2iwYg4zAPwZ3YUk4M8VLaeFGCFymGn+PA0mQMHFTRJHmG9uW2NRFnZanGn6b5VkIZIlTYEYUaPf8UfBdZYEZaRlPOhMDPb3ZCdTg8FlRCuG1wWqBbgWmqvUac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=clT1p39L; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4afefc876c6so742556137.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 10:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734201014; x=1734805814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfqxcq4wpnphymnU6ypxtGC8QErPdjcXWjyPVc+zgoc=;
        b=clT1p39L7VS0ia9eSf4VzCy6sUIxppdg8GuOTSN1VSxtTa0c/upVnmJQmi8BEjHKR0
         5iawt7xZWdqdOeei8TvGKnXHg0w7wai+hD8JNI/ahBaOJ3mRj3ITQGU6ySq9pOZS4RVW
         /4K5NZBae2mTDgRSHKPJwWohs9awWscQ6WnSASfc3k1CDOq6Pwt0wqdG1E7imcIOQPqT
         J5MBWT76fsmxP3DCRTqts7AwTrDY30qspAKCceoyYbSVepWvBoVY7GAoV4I54/2oRZRw
         OyV4NkYjjQqm7Z6E94j0AxNO9EZ1D4XbgaB4axN/NoXXVgIQzcar1x/09yIjvACdKLMj
         4Nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734201014; x=1734805814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfqxcq4wpnphymnU6ypxtGC8QErPdjcXWjyPVc+zgoc=;
        b=BxEZB2UALRkHWrO4zgGGs21gQTH12NTuKel9PwnSEwpDIdfBvgtc0JnAtzpnIlGwGI
         06+9TN8bGC2WO+7+rrahjzlCR/Q65Sne1j515oQSO/7VqxT0l+DBP7KQ/HfT7nirm+wt
         qeIjZ2kM5Ggj5WQGZ7dbx9IYhcT6shLEivof2LC9n25dRFfmNUfnjGij0Bh5Fa0cj50R
         gg9DLgaTvPHoa+hfd96zCM64Mpn+3fWIh6rTN/dcTvNWHugDnuc7VyJt8bq67kZDUgfd
         VLN38tjs9v5k+cxrpN9LLHrppFYB3RUcZiPT2Ax4oDwrZy5TlxtZU5AayrOep583qNMe
         66gA==
X-Forwarded-Encrypted: i=1; AJvYcCVmd5Lwi9knIM7KDSgl/QMOcFKZDe2BNzJrzOZUWYmnoE5Y+u5u9FPt/yomC61ZQ4zgenJHDfqn21jiqjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLKcTnxkY30tmpK/e007JzjE5uHFHjmqErTPipCvZz2MS1kdQ+
	rTKoBGLvNzrvoIrIjhE8gFzVIC4RbwvIon+/whIWC5RvPKrn28vooGUzIt8OWTsxd6uCmaInmU9
	6l4WmRBqJoyfT4QLGtcnHs+M8qmgIapNFosV2
X-Gm-Gg: ASbGncvpFcZEPacYRtaCKPlR4tZgDDVUcJ/iLJ2ifQuFbLt8m50DNJwB2tDGKijDM9a
	Tfr88B+NpapN/IcPQT11CFT16silOVL4U3xt5hTtWf4ngm9VBLVN2kdP+nuTPMOOHu/ZUfoU=
X-Google-Smtp-Source: AGHT+IERxcx+NGxGXAki+JjzuiZT8JRqTo75tQfQ8B0V4mn4vI3F5BUmfMlrnmFYVn/5gYY3jQjt28miU+4deXcTdtM=
X-Received: by 2002:a05:6102:c90:b0:4af:c58f:4550 with SMTP id
 ada2fe7eead31-4b25d986cafmr8543738137.7.1734201012332; Sat, 14 Dec 2024
 10:30:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1734164094.git.zhengqi.arch@bytedance.com> <1fdb3ee32e6958ad82229941b2213ef76b7c4705.1734164094.git.zhengqi.arch@bytedance.com>
In-Reply-To: <1fdb3ee32e6958ad82229941b2213ef76b7c4705.1734164094.git.zhengqi.arch@bytedance.com>
From: Yu Zhao <yuzhao@google.com>
Date: Sat, 14 Dec 2024 11:29:35 -0700
Message-ID: <CAOUHufaKRXJA=vZucoJMmgQw264LSxWuTtNcFQMLD7UNz_6wyw@mail.gmail.com>
Subject: Re: [PATCH 01/12] Revert "mm: pgtable: make ptlock be freed by RCU"
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, tglx@linutronix.de, david@redhat.com, 
	jannh@google.com, hughd@google.com, willy@infradead.org, 
	muchun.song@linux.dev, vbabka@kernel.org, lorenzo.stoakes@oracle.com, 
	akpm@linux-foundation.org, rientjes@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 14, 2024 at 2:03=E2=80=AFAM Qi Zheng <zhengqi.arch@bytedance.co=
m> wrote:
>
> This reverts commit 2f3443770437e49abc39af26962d293851cbab6d.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Bloating struct pt_lock is unnecessary. Glad to see it's reverted.

Acked-by: Yu Zhao <yuzhao@google.com>


> ---
>  include/linux/mm.h       |  2 +-
>  include/linux/mm_types.h |  9 +--------
>  mm/memory.c              | 22 ++++++----------------
>  3 files changed, 8 insertions(+), 25 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e7902980439cc..5e73e53c34e9e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2988,7 +2988,7 @@ void ptlock_free(struct ptdesc *ptdesc);
>
>  static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
>  {
> -       return &(ptdesc->ptl->ptl);
> +       return ptdesc->ptl;
>  }
>  #else /* ALLOC_SPLIT_PTLOCKS */
>  static inline void ptlock_cache_init(void)
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index df8f5152644ec..5d8779997266e 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -434,13 +434,6 @@ FOLIO_MATCH(flags, _flags_2a);
>  FOLIO_MATCH(compound_head, _head_2a);
>  #undef FOLIO_MATCH
>
> -#if ALLOC_SPLIT_PTLOCKS
> -struct pt_lock {
> -       spinlock_t ptl;
> -       struct rcu_head rcu;
> -};
> -#endif
> -
>  /**
>   * struct ptdesc -    Memory descriptor for page tables.
>   * @__page_flags:     Same as page flags. Powerpc only.
> @@ -485,7 +478,7 @@ struct ptdesc {
>         union {
>                 unsigned long _pt_pad_2;
>  #if ALLOC_SPLIT_PTLOCKS
> -               struct pt_lock *ptl;
> +               spinlock_t *ptl;
>  #else
>                 spinlock_t ptl;
>  #endif
> diff --git a/mm/memory.c b/mm/memory.c
> index d9af83dd86bbf..83765632e20b0 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -7041,34 +7041,24 @@ static struct kmem_cache *page_ptl_cachep;
>
>  void __init ptlock_cache_init(void)
>  {
> -       page_ptl_cachep =3D kmem_cache_create("page->ptl", sizeof(struct =
pt_lock), 0,
> +       page_ptl_cachep =3D kmem_cache_create("page->ptl", sizeof(spinloc=
k_t), 0,
>                         SLAB_PANIC, NULL);
>  }
>
>  bool ptlock_alloc(struct ptdesc *ptdesc)
>  {
> -       struct pt_lock *pt_lock;
> +       spinlock_t *ptl;
>
> -       pt_lock =3D kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
> -       if (!pt_lock)
> +       ptl =3D kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
> +       if (!ptl)
>                 return false;
> -       ptdesc->ptl =3D pt_lock;
> +       ptdesc->ptl =3D ptl;
>         return true;
>  }
>
> -static void ptlock_free_rcu(struct rcu_head *head)
> -{
> -       struct pt_lock *pt_lock;
> -
> -       pt_lock =3D container_of(head, struct pt_lock, rcu);
> -       kmem_cache_free(page_ptl_cachep, pt_lock);
> -}
> -
>  void ptlock_free(struct ptdesc *ptdesc)
>  {
> -       struct pt_lock *pt_lock =3D ptdesc->ptl;
> -
> -       call_rcu(&pt_lock->rcu, ptlock_free_rcu);
> +       kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
>  }
>  #endif
>
> --
> 2.20.1
>

