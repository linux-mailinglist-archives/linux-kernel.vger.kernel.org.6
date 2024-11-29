Return-Path: <linux-kernel+bounces-425986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAFB9DED4D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 23:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E0DD282097
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 22:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06901A4F01;
	Fri, 29 Nov 2024 22:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkJOfrEb"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0421A42D8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732921180; cv=none; b=d6g3eEXiMnE/K3ssTSk1PlEIJ6bjXnqtvYxKF5bkWh1VL2NSN2SagoccQ/97DFrvZ3bzS1TDddhGZ5VrWXh0aem/zbeiamQ9ozD7ebUaaI+EH85YC1/RgprxjUYrnGkq5c2ZxpH6HFNJ2tldaTdW9dwr+tBSTia+sdG9k2i+ruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732921180; c=relaxed/simple;
	bh=liZt4dPqBl03Fh3biExXSgApqB8MHIcVm2M+6pPaReQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WB2rKaEBRPytDqet0492/N1qyukz3pq/xqWdQqNmHk2znrfyNPPwlQALFEeOYdwMhnHCiD8IkYWdPE51L4R3Wf10I9jxc+B2YpuJU7gY6ph8U8SrTYlKpeeh9F4i9cJLzNF5DADJiXYi3YuCERGSUvKTTlWuzui/4935RhMbY6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AkJOfrEb; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4668caacfb2so532861cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 14:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732921177; x=1733525977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQeQsqUlgp8y2/hZiuCT1BLye2JPjA646R1V4XW0+eg=;
        b=AkJOfrEbEyc1FrQqh+EbGkRykaM7ZX43a4yLrY51D+fMsp/F4xOvyjDuOuMmK+ig50
         pFW1kXHbxFMbzZxO0xIwFxtMA8MmwKsc3togptVIkUIYlPp+ok1G0JVpzgnm977wVXMt
         4cLi42JEZGBIH8h+46I/uLVcF4/nan0IP6CSFt+SEjZy33N5CHCQHLCRRRJnCfHSqjEk
         vijNWaXLImhN8rUZYZ0jyDYQMzcENNbXbD/0zbHZGhwD5FU4ypgzC97D+e1rAo38w9ii
         s1TU6VmysKOp1fSTTP9QLTferaKDQWLIpi3JfPEorDC0GLuP+J1hJtBJy+E7WK2ktmeX
         vyow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732921177; x=1733525977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQeQsqUlgp8y2/hZiuCT1BLye2JPjA646R1V4XW0+eg=;
        b=FbUrsBcbX+HUaN+zRKy9jzZPtF7s3tnRlx3RFIWkxGObPwxAC5aezW9cgvElFO12qe
         W9qNSZxWNi+QSL/EX0QOtM8ku6KMsZBZgEmDWcDLYBmInJW3wSmKlz50xgZ15KENyb4t
         vXVIkDktIG49O85GshieE3P11S6VYR4Yq1O8onfN+Ppqu1feclQrw6HBxYcOUXHXa1V2
         Q16MVUf6fZM0xng0txn/nMx9IjX6+r/TW7NrwkOsALn1QMcnTXiwfcwc7YaxO5Dk0xHu
         SB+J78HBrMxAjKzI94Wl6NtSThMBPStkCuf8iJdfSI3cVz5CcYA3ovx4rPRP+5IWUIVy
         hRwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX004sxrL526ztgiWzyn42DhcDLj2hkFNh6bq80H6A+XmUyzJkZcVEO7RTdnzbx2hWmfMWQYe9vaku4SaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt+/vIEtTE2u80YfsEhiz9ixFxD/EImZHWx3h64K4aVw3mROGV
	6HPcTd5a4yJ0dQFwyddhKrNu/6DO8xrkIq/Px+ScE1CIlyGhiWCmC/xg+yKtARCxbfetx6fznFK
	owaZPSctzAtlfYCUwqSSgiDRNmxmvWoRoGGIt
X-Gm-Gg: ASbGncsysYeEMwMPKVvihWwGYgXAiWW+tsE55Sj8isv0ulIKjidF90T0sd0vA+yiIx+
	hNzikwmGTgIYIchhL0FBXCiq0wDpfTsM=
X-Google-Smtp-Source: AGHT+IFXPmGPTiIkD8sKSnOD1M7ROpcfWBHnqRew3JSBmVIjODmOaLP4qZpdKUFs423Vcx3l22udQjYkGnM/hyY4AA4=
X-Received: by 2002:a05:622a:544a:b0:463:6fc7:e7cb with SMTP id
 d75a77b69052e-466c3f50afbmr5801491cf.11.1732921177010; Fri, 29 Nov 2024
 14:59:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128102619.707071-1-00107082@163.com> <20241129025213.34836-1-00107082@163.com>
In-Reply-To: <20241129025213.34836-1-00107082@163.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 29 Nov 2024 14:59:26 -0800
Message-ID: <CAJuCfpGxU8u4X0x1n3Sen206Xpi1ubBK2gyCgYinPV_NFFJNPw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/codetag: swap tags when migrate pages
To: David Wang <00107082@163.com>
Cc: yuzhao@google.com, kent.overstreet@linux.dev, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 6:52=E2=80=AFPM David Wang <00107082@163.com> wrote=
:
>
> Current solution to adjust codetag references during page migration is
> done in 3 steps:
> 1. sets the codetag reference of the old page as empty (not pointing
> to any codetag);
> 2. subtracts counters of the new page to compensate for its own allocatio=
n;
> 3. sets codetag reference of the new page to point to the codetag of
> the old page.
> This does not work if CONFIG_MEM_ALLOC_PROFILING_DEBUG=3Dn because
> set_codetag_empty() becomes NOOP. Instead, let's simply swap codetag
> references so that the new page is referencing the old codetag and the
> old page is referencing the new codetag. This way accounting stays
> valid and the logic makes more sense.
>
> Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
> Signed-off-by: David Wang <00107082@163.com>
> Closes: https://lore.kernel.org/lkml/20241124074318.399027-1-00107082@163=
.com/
> Acked-by: Suren Baghdasaryan <surenb@google.com>
> Suggested-by: Suren Baghdasaryan <surenb@google.com>

Thanks! This looks fine to me but IIRC I did not Ack this patch
before. In the future please do not add Acked-by until you get an
explicit Ack. That said,

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  include/linux/pgalloc_tag.h |  4 ++--
>  lib/alloc_tag.c             | 36 ++++++++++++++++++++++--------------
>  mm/migrate.c                |  2 +-
>  3 files changed, 25 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
> index 0e43ab653ab6..3469c4b20105 100644
> --- a/include/linux/pgalloc_tag.h
> +++ b/include/linux/pgalloc_tag.h
> @@ -231,7 +231,7 @@ static inline void pgalloc_tag_sub_pages(struct alloc=
_tag *tag, unsigned int nr)
>  }
>
>  void pgalloc_tag_split(struct folio *folio, int old_order, int new_order=
);
> -void pgalloc_tag_copy(struct folio *new, struct folio *old);
> +void pgalloc_tag_swap(struct folio *new, struct folio *old);
>
>  void __init alloc_tag_sec_init(void);
>
> @@ -245,7 +245,7 @@ static inline struct alloc_tag *pgalloc_tag_get(struc=
t page *page) { return NULL
>  static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned=
 int nr) {}
>  static inline void alloc_tag_sec_init(void) {}
>  static inline void pgalloc_tag_split(struct folio *folio, int old_order,=
 int new_order) {}
> -static inline void pgalloc_tag_copy(struct folio *new, struct folio *old=
) {}
> +static inline void pgalloc_tag_swap(struct folio *new, struct folio *old=
) {}
>
>  #endif /* CONFIG_MEM_ALLOC_PROFILING */
>
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 2414a7ee7ec7..35f7560a309a 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -189,26 +189,34 @@ void pgalloc_tag_split(struct folio *folio, int old=
_order, int new_order)
>         }
>  }
>
> -void pgalloc_tag_copy(struct folio *new, struct folio *old)
> +void pgalloc_tag_swap(struct folio *new, struct folio *old)
>  {
> -       union pgtag_ref_handle handle;
> -       union codetag_ref ref;
> -       struct alloc_tag *tag;
> +       union pgtag_ref_handle handle_old, handle_new;
> +       union codetag_ref ref_old, ref_new;
> +       struct alloc_tag *tag_old, *tag_new;
>
> -       tag =3D pgalloc_tag_get(&old->page);
> -       if (!tag)
> +       tag_old =3D pgalloc_tag_get(&old->page);
> +       if (!tag_old)
> +               return;
> +       tag_new =3D pgalloc_tag_get(&new->page);
> +       if (!tag_new)
>                 return;
>
> -       if (!get_page_tag_ref(&new->page, &ref, &handle))
> +       if (!get_page_tag_ref(&old->page, &ref_old, &handle_old))
>                 return;
> +       if (!get_page_tag_ref(&new->page, &ref_new, &handle_new)) {
> +               put_page_tag_ref(handle_old);
> +               return;
> +       }
> +
> +       /* swap tags */
> +       __alloc_tag_ref_set(&ref_old, tag_new);
> +       update_page_tag_ref(handle_old, &ref_old);
> +       __alloc_tag_ref_set(&ref_new, tag_old);
> +       update_page_tag_ref(handle_new, &ref_new);
>
> -       /* Clear the old ref to the original allocation tag. */
> -       clear_page_tag_ref(&old->page);
> -       /* Decrement the counters of the tag on get_new_folio. */
> -       alloc_tag_sub(&ref, folio_size(new));
> -       __alloc_tag_ref_set(&ref, tag);
> -       update_page_tag_ref(handle, &ref);
> -       put_page_tag_ref(handle);
> +       put_page_tag_ref(handle_old);
> +       put_page_tag_ref(handle_new);
>  }
>
>  static void shutdown_mem_profiling(bool remove_file)
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 2ce6b4b814df..cc68583c86f9 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -745,7 +745,7 @@ void folio_migrate_flags(struct folio *newfolio, stru=
ct folio *folio)
>                 folio_set_readahead(newfolio);
>
>         folio_copy_owner(newfolio, folio);
> -       pgalloc_tag_copy(newfolio, folio);
> +       pgalloc_tag_swap(newfolio, folio);
>
>         mem_cgroup_migrate(folio, newfolio);
>  }
> --
> 2.39.2
>

