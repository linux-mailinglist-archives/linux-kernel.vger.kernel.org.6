Return-Path: <linux-kernel+bounces-400288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9769C0B73
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000451F2410F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2355B2161EC;
	Thu,  7 Nov 2024 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YkBt+DBq"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FAC215F78
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996347; cv=none; b=MdR9gFlSgLHDerpNy1sqSUCcYj3ZzAcTuDMAClvXYIoT9+frHJxWxNqGZgMESV2JgvzuWLy0ecTVILAdNi1e7TBGsQOMZCA+VAms14V89W0LLNWdUkIgEl7JLodXehW9P3HQwzqneQSAf4P0akspg6GIHZ85F1/GDu9zJAkMdng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996347; c=relaxed/simple;
	bh=fxNSOG8CLykhInf6lpAriC5rIjy2ASm0d0cDklLfS6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFV+EDZQMIkTmVosFu5lmnCfnNVqeKtTtu/BiHsJaPMcAFeCV5hjcp8bCKaYgXo3NJmot3OX1JkK7Ps8JVciz1kLG5QgVS6AKaSsrnvb3oBRQvInDacWxLhZzSp2Pea62sjxRZcXlV6HwL0DOdsgx769K+lQPpHfYLamwLeqmR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YkBt+DBq; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a4e54d3cefso264675ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 08:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730996345; x=1731601145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qKfKuK+A7EueXZiHYZlyKWp/m1H88iPKOG6YnI7WIM=;
        b=YkBt+DBq5mt97O0nShHizydBrt0R2xQcIx5h0XLVhd07LAeSICG0UGBURSxXSSdxbN
         gFQ/QkSVOkjrI883sTpP0Wt0AUEcdQ5GiXS4e/JM0wT20WuBAW+447HMud6AvHaDm3fy
         fto0PMu/dc3Sxdv5HkGPoZWLXJ1H5yj+Wbv0ynl39Raazb3m/3vlloqiZQcZngmHRPoe
         Y0j5OiICc/fGMw2zrpXCJdYW7JEOBAGOJuHBan6SK8feIh6TDKoTKBOGqzV2yvoYrexg
         7dkIZgYeJ/aree1+vNZ86fQXohB9jSTutrIojimFCNs+1O9KLOfLU9ZtaoyoxdaL7nrM
         cnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730996345; x=1731601145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qKfKuK+A7EueXZiHYZlyKWp/m1H88iPKOG6YnI7WIM=;
        b=cT2fO+tdu6I0FFKG/KoQCsTgO8fS0vd7HusoLOkai6QLbQMbJINELphD8jT9MsDn59
         l49a3q6HtSMXkeaFb9mMUlu82nA+QXHYbcyzLPn7EZvkMFFrbHi2JHfKT7Xq+i2h162b
         vvtAzP8xBjg6BT7rGq/XCoTOMFVnSmkbh8TfZqfAz3OzykVxAuMA1oTng5MGdYUuls1f
         zHFN8uG8SNQBP218wkS9jkjOb5q0JcG9lZNUkN4EXH33hmmACpgNlkAx+FmUIZ5wgXpZ
         qEpB43Qx+k6aY0SMBbaxlueZ6QjkkwaYnLICiz7ifwWuoMJmiZXXmBhtJMHhgNmHw4zF
         EtlA==
X-Forwarded-Encrypted: i=1; AJvYcCXx/lGXgCK4yHAycFQ9Z1WIOqXC9NIIUSyV6MfnX7QLPea3C3y/qPsU6dXln9ZHc40QQV8tCz/we7GBqg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVCW+5+ChayUUhtuLdoDAqJd+l7DSFtXT3FRv9ka8gdDKT79iv
	dWg2bHc6Kic1cOzSHewuXk2r51h/4plVuV6NXeGdjMghQ2N0EpBpyEsd4E72lrTPMAKY+uck7+u
	/qIDCS9YKConSksYzzBS8tK1JiUqit1oe9uxe
X-Gm-Gg: ASbGncsYtPHrs8EhbZa409QeaEv1W6IVnD9WteXo4N/3+hUgl9Gn8qkmcmzIX7a5VYu
	ozsQOKQaJJzBEmRkMflEI8B5qWPyRlmTASAUqy948/3f/xrBmj4tjQOgyyFeQ
X-Google-Smtp-Source: AGHT+IGZXcyh/61yeMnJ7Q4+aVIzTqTQxQxJyJgWUwBBuePoju1MHMxNcWbmOWfcdJGey7sY09WTvMFuN7V1+rznx+U=
X-Received: by 2002:a05:6e02:20ec:b0:39f:83dd:5672 with SMTP id
 e9e14a558f8ab-3a6e7a3d79amr5119695ab.16.1730996344539; Thu, 07 Nov 2024
 08:19:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107040239.2847143-1-cmllamas@google.com>
In-Reply-To: <20241107040239.2847143-1-cmllamas@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 7 Nov 2024 08:18:53 -0800
Message-ID: <CAJuCfpHmwwOXMfuM3K32U+KedUYiZBXC_rbTG288gPy1kQs46A@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] binder: faster page installations
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, Alice Ryhl <aliceryhl@google.com>, 
	David Hildenbrand <david@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Minchan Kim <minchan@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Todd Kjos <tkjos@google.com>, 
	Viktor Martensson <vmartensson@google.com>, Hillf Danton <hdanton@sina.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 8:02=E2=80=AFPM Carlos Llamas <cmllamas@google.com> =
wrote:
>
> The main focus of these patches is to improve the performance of binder
> page installations, primarily by reducing contention on the mmap_lock.
> The idea is to allow concurrent page insertion by leveraging per-vma
> locking and get_user_pages_remote().
>
> Unfortunately, this required reverting the alloc->lock spinlock back
> into a mutex in order to serialize with the shrinker. At least until
> finding a better solution e.g. support page zapping with a spinlock.
> The trade off is still quite worth it though.
>
> Other patches are also included that remove unsafe and redundant things
> such as the alloc->vma pointer or the struct binder_lru_page concept.
>
> Note: I'll work on setting up a page fault handler for binder next.
> I believe an idea from Alice Ryhl to deferred the page insertions will
> make this finally feasible. I only need to figure out a few performance
> bits but if/when done most of the manual page insertion code in binder
> could be dropped. :)
>
> Changelog:
>
> v2:
>  * fix locking order when upgrading from vma lock to mmap lock
>  * switch folio_walk_start() for get_user_pages_remote()
>  * release vma/mmap locks and mmput() right after vm_insert_page()
>  * add binder_page_alloc() helper for binder_install_single_page()
>
> v1:
> https://lore.kernel.org/all/20241105200258.2380168-1-cmllamas@google.com/
>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Viktor Martensson <vmartensson@google.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Some nits but overall looks quite good.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> Carlos Llamas (8):
>   Revert "binder: switch alloc->mutex to spinlock_t"
>   binder: concurrent page installation
>   binder: select correct nid for pages in LRU
>   binder: remove struct binder_lru_page
>   binder: use alloc->mapped to save the vma state
>   binder: remove cached alloc->vma pointer
>   binder: rename alloc->buffer to vm_start
>   binder: use per-vma lock in page installation
>
>  drivers/android/binder.c                |   2 +-
>  drivers/android/binder_alloc.c          | 322 ++++++++++++++----------
>  drivers/android/binder_alloc.h          |  35 +--
>  drivers/android/binder_alloc_selftest.c |  18 +-
>  drivers/android/binder_trace.h          |   2 +-
>  5 files changed, 212 insertions(+), 167 deletions(-)
>
> --
> 2.47.0.199.ga7371fff76-goog
>

