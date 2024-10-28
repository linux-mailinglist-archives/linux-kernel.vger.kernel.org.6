Return-Path: <linux-kernel+bounces-385605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A04C9B3949
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1130EB21D11
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CB01DF99B;
	Mon, 28 Oct 2024 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoZH+JwG"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7C1DFDB2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140683; cv=none; b=EBNretS/vSPvxVzzQY9lbjnz+jLpBIeLGerKJEEudgJxZEwfTMJmSJLPkv20TGuSFtc+JxpTSSFvQ1eiCdT4EMHIZ2uAR5QZ48tlpNtIGz+R+HhMG7Yi3s478uNT9QXXthredxfwcfzAxpL8MnJZcQeiRoHBZxi22buXzaN1DuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140683; c=relaxed/simple;
	bh=YI12pm3tkB3Vc8m/bTmlRrn6TtIngqpFTRtQCUc/kM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ToQLXhiIz2c8i7jIh2Tr+SlTnoipbRs2NpV4UD8p9c/KoqPD6QeUwrAcsIC83B63yG9Y+HVvWikFte7dU6uV7NepcapWhaTUfnyE4b80vuwYdsvpnion4+BEJYfql21YAaDqQrjc4EtKWqnExYHCXU2y7B9x4Jmj0YVJabJuz9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoZH+JwG; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso41581651fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730140679; x=1730745479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mCmmrBqrwBBNHAYFi5nvtCwYkQdKfmKUY6CuxD0pIc=;
        b=aoZH+JwGF/sZbPCQhELo/t54GFPx6fwWfalBzRUywPyvjJnQEbVLLDdLDHs2f1P46/
         DzGNSnZ7CbclSPZH/EQqXuDVk1oaL4aN6lfwh4bcsPR+DdCbqKBC3PUxab5zoV/0uUoL
         D6iS9YTzIAjLaU1u8uSNAfViVi5UBkpsL0Y08gGEhwM04+qfrw20ODkvuC55/knJD1HI
         ChapqMvvHW4cP1hgF1AqrL4l6hKBN9oMuiYoc3vGc8gQB9/j/SJZJUVvOjkOprSqBVS4
         SEacq+l1Gl+W05HfWqixccmNdkiaDdO3BaM0exyJHBgAvij1Abg0sO9spa21hwG8WvPB
         S42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730140679; x=1730745479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mCmmrBqrwBBNHAYFi5nvtCwYkQdKfmKUY6CuxD0pIc=;
        b=sUN56OVN/37UnwXODvi9MeZNCuUWB5tDMrqKxDt8lE1KThguqx3OD9uVLxc/xmgKV8
         cr1cEpU+8fdqMqAkkKGb5/GX/P4qH4PDISgE97dF0HrIsTmF857mvaSE0fPFNjV5npzx
         QdEA5f1KQva2kxxYk6OJgEhKxLNjvnpqGdDG80au//2kbr6JQWNXyOAJjIsZ3EBPmyuf
         onsGQUsUR6+j0Y/b5ls2xmKg4DA++vS69IYM9cYXkKFWjWxkRVGBZuJOPbg3ivNfwE0c
         bl2xc4pIxCvUz0DM7YjUlLg+T9p5lN+EUoJK/vdufWrnTSxDoehz0FaqLi3mimsYKjc+
         Ppow==
X-Forwarded-Encrypted: i=1; AJvYcCU3lZbonFV9bKLAPgL4DxlAu4yzibjcOrNvXrs8iI7D9oL7zMb4P9lxcQRMpEx9EqQvuRRSSX76YghA7bI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQBUmNf+FG4riggAwaG3DiI5LNuszzHf/Sb6DUu4uZD72tSGi
	xJQknmmQ7ABIXJHjtEHwVJe94MkZpJoyf9qftPCg5K91hj+vCKL6GZMEEnSkqFRFdNw+CqCYZYK
	HxmRIsEiGbnnUcHp7l3OTTechu+7+1A==
X-Google-Smtp-Source: AGHT+IGj9vDsgFF7Rl8j8yeOh9b8zyNZNy8GvabiZtXorwUqfIqcxNgE+yeFuonlz9qIHRk/d8tczdt7WFJYEdw6ywo=
X-Received: by 2002:a2e:80a:0:b0:2fb:8df2:13eb with SMTP id
 38308e7fff4ca-2fcbe063702mr33376021fa.36.1730140678504; Mon, 28 Oct 2024
 11:37:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d9985d6a-293e-176b-e63d-82fdfd28c139@google.com>
In-Reply-To: <d9985d6a-293e-176b-e63d-82fdfd28c139@google.com>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 28 Oct 2024 11:37:46 -0700
Message-ID: <CAHbLzkq+0GPckUWXZ0-DLkOhVv7JyuKfdUbXWGVEn5fcBfGmHQ@mail.gmail.com>
Subject: Re: [PATCH] mm: delete the unused put_pages_list()
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 1:15=E2=80=AFPM Hugh Dickins <hughd@google.com> wro=
te:
>
> The last user of put_pages_list() converted away from it in 6.10 commit
> 06c375053cef ("iommu/vt-d: add wrapper functions for page allocations"):
> delete put_pages_list().
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  include/linux/mm.h |  2 --
>  mm/swap.c          | 31 -------------------------------
>  2 files changed, 33 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ecf63d2b0582..8524bf86dd74 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1286,8 +1286,6 @@ static inline struct folio *virt_to_folio(const voi=
d *x)
>
>  void __folio_put(struct folio *folio);
>
> -void put_pages_list(struct list_head *pages);
> -
>  void split_page(struct page *page, unsigned int order);
>  void folio_copy(struct folio *dst, struct folio *src);
>  int folio_mc_copy(struct folio *dst, struct folio *src);
> diff --git a/mm/swap.c b/mm/swap.c
> index b8e3259ea2c4..638a3f001676 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -127,37 +127,6 @@ void __folio_put(struct folio *folio)
>  }
>  EXPORT_SYMBOL(__folio_put);
>
> -/**
> - * put_pages_list() - release a list of pages
> - * @pages: list of pages threaded on page->lru
> - *
> - * Release a list of pages which are strung together on page.lru.
> - */
> -void put_pages_list(struct list_head *pages)
> -{
> -       struct folio_batch fbatch;
> -       struct folio *folio, *next;
> -
> -       folio_batch_init(&fbatch);
> -       list_for_each_entry_safe(folio, next, pages, lru) {
> -               if (!folio_put_testzero(folio))
> -                       continue;
> -               if (folio_test_hugetlb(folio)) {
> -                       free_huge_folio(folio);
> -                       continue;
> -               }
> -               /* LRU flag must be clear because it's passed using the l=
ru */
> -               if (folio_batch_add(&fbatch, folio) > 0)
> -                       continue;
> -               free_unref_folios(&fbatch);
> -       }
> -
> -       if (fbatch.nr)
> -               free_unref_folios(&fbatch);
> -       INIT_LIST_HEAD(pages);
> -}
> -EXPORT_SYMBOL(put_pages_list);
> -
>  typedef void (*move_fn_t)(struct lruvec *lruvec, struct folio *folio);
>
>  static void lru_add(struct lruvec *lruvec, struct folio *folio)
> --
> 2.35.3

