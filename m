Return-Path: <linux-kernel+bounces-235229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2735891D1DF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 15:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0558281D10
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BC413D532;
	Sun, 30 Jun 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMXTTvDP"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A82F2F877
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719755149; cv=none; b=nHlkqgK/+Xs1O9jF12KBK9RpDVsGIOy/2dSf4OFt36R/bozXnR9ogM090wr8gYmBbXcaBkdb2o9QgQ25mdslgJwYZgoIm/PysVoDexwB+KBFnO6sT4givdPR91yj+YJpzXGh7KQTEPYSwWdLc4OTsHG+50a1GbXiTJFE8riDJxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719755149; c=relaxed/simple;
	bh=vJGzYuH6e1WtN1WB3jo8u5TmEr5fKOAj82dBd4Ya+aU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQ4JBNfvueiT5S+Rhj0e3xJaZ/CoXvbIoLkF9vwy5pnN30o+2rFhUCB7P0n395WwcUCmfedHHdf31jwBAp9F00qIiOSnX0s0QyhlKb+1IrBs1LSvdC5Kn7VvBv7P67dYSYdIiJMuEa//9zANAWDU0qlRhonzqA9zyD6Hlr/cluM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMXTTvDP; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-80f65707b31so563586241.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719755145; x=1720359945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2q4kbqBznkMbLXR5p0F8VTc3UoCm7l/nJGxCVDkHuM=;
        b=ZMXTTvDPJ7TWHR9Cxj7xuK6pBRv7mHuFs1jhq8toITNxuISVWCVuwcc0Ljfx3fVehH
         tfMljYNSJJqPw4r4Y56xGeL/OpWIIE0Um4XpptRW/GFOxS21RtMsWyVPbP+/B2qaR9Ol
         RQv9hBxYsLRf4Q2up+GmlRwihOI5Kq7+8IqjUcCNut3kV5f+CzUO/Y4Fu9ZbbpG1dopy
         RiRwmc3/oOJ8bKqwj6Nw++iXKI1aK4fEIXlTYYYahcMyjugaRie2qWesgsG/Vp614XGU
         kKSFv0ld0wFvdcYuSmndOsheF+/JVhSOAKr6YGPKnGHtl5hMyJR7lypAkaSxU/ctQq6z
         /UZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719755145; x=1720359945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2q4kbqBznkMbLXR5p0F8VTc3UoCm7l/nJGxCVDkHuM=;
        b=bd0LePgaSh1j/ZOmlv1rjxSrK9wMEVYeJWgred4z71Ivsm3JOCkmukg3QY/gcEnjgw
         Owtkae2Vn0TsDFuiOuGRnbOwuQJ5VYs3WTzq4qdZwbUinQ0mnSoy4nNJvH5OkgxToqc0
         4SOhSI5mtpxiCQaXo1h3V/rgE5AorYQ9G5s/+c3YGrB6a9JCKaBAFWwXPfD3UotFhYkN
         /Anrm6x0Y06QIyjshSErDJVkp+z0VGW8cZPFJEoHgUUF5ZgjNk8qGhJnJOnK/MSBUaGB
         ypy9zos88WlrsB7aL0gPGZ2+F2NuEAlfEipjVjtVXME9N807swMsURQfAKafKDQf5DMX
         8kLA==
X-Forwarded-Encrypted: i=1; AJvYcCV/VuxOumYjIjALL8WpWNrqVEMMSN47pklMQmeajTC1riUOjj7VLWzboO7yPF++ImV7l+d6MIXiy4QPCslhMQtF68nQmkabNPZSIbaA
X-Gm-Message-State: AOJu0YwgsgwfDR24aX6IRJBwtGzdYZv1P1Ie150iz07Gf3DgO5cg5WrE
	gJ3sgqMlxn4CfPlSg/lJS0dqVJBUmXDndL5vCapNTJNAMqTdSAYeLH2wfVS+jhp+OTYHiVN39d4
	ZbDz7fkKQ4n0EVTntYDiA7GKL3EQ=
X-Google-Smtp-Source: AGHT+IHDRlhA8CgFly/vJ5nDQCcBIx9wkh5XKEQXnzczSgQoIb4W+7eBfnHh4LNlrXihhYD91/UI5KXToV5GpyJqCDQ=
X-Received: by 2002:a05:6122:430f:b0:4ef:678e:8aa0 with SMTP id
 71dfb90a1353d-4f2a5692d4emr2966558e0c.4.1719755145285; Sun, 30 Jun 2024
 06:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628031138.429622-1-alexs@kernel.org> <20240628031138.429622-2-alexs@kernel.org>
In-Reply-To: <20240628031138.429622-2-alexs@kernel.org>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Sun, 30 Jun 2024 22:45:33 +0900
Message-ID: <CAB=+i9RSCkYyqo-qXJNRKjUig7s5ZMGWCKmur1nNcD3KkFnhUg@mail.gmail.com>
Subject: Re: [PATCH 01/20] mm/zsmalloc: add zpdesc memory descriptor for zswap.zpool
To: alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org, 
	senozhatsky@chromium.org, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 12:06=E2=80=AFPM <alexs@kernel.org> wrote:
>
> From: Alex Shi <alexs@kernel.org>
>
> The 1st patch introduces new memory decriptor zpdesc and rename
> zspage.first_page to zspage.first_zpdesc, no functional change.
>
> Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> ---
>  mm/zpdesc.h   | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  mm/zsmalloc.c | 19 ++++++++---------
>  2 files changed, 66 insertions(+), 9 deletions(-)
>  create mode 100644 mm/zpdesc.h

Hi Alex, thanks for your effort in pushing this forward!

> diff --git a/mm/zpdesc.h b/mm/zpdesc.h
> new file mode 100644
> index 000000000000..a1ab5ebaa936
> --- /dev/null
> +++ b/mm/zpdesc.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* zpdesc.h: zswap.zpool memory descriptor
> + *
> + * Written by Alex Shi <alexs@kernel.org>
> + *           Hyeonggon Yoo <42.hyeyoo@gmail.com>
> + */
> +#ifndef __MM_ZPDESC_H__
> +#define __MM_ZPDESC_H__
> +
> +/*
> + * struct zpdesc -     Memory descriptor for zpool memory, now is for zs=
malloc
> + * @flags:             Page flags, PG_private: identifies the first comp=
onent page
> + * @lru:               Indirected used by page migration

maybe Indirected -> Indirectly?

> + * @next:              Next zpdesc in a zspage in zsmalloc zpool
> + * @handle:            For huge zspage in zsmalloc zpool
> + * @zspage:            Pointer to zspage in zsmalloc
> + *
> + * This struct overlays struct page for now. Do not modify without a goo=
d
> + * understanding of the issues.
> + */
> +struct zpdesc {
> +       unsigned long flags;
> +       struct list_head lru;
> +       unsigned long _zp_pad_1;

for understanding, I think it'd be better to replace _zp_pad_1 with movable=
 ops,
because mops reuses this 'mapping' field.

> +       union {
> +               /* Next zpdescs in a zspage in zsmalloc zpool */
> +               struct zpdesc *next;
> +               /* For huge zspage in zsmalloc zpool */
> +               unsigned long handle;
> +       };
> +       struct zspage *zspage;

There was a discussion with Yosry on including memcg_data on zpdesc
even if it's not used at the moment.

Maybe you can look at:
https://lore.kernel.org/linux-mm/CAB=3D+i9Quz9iP2-Lq=3DoQfKVVnzPDtOaKMm=3Dh=
UPbnRg5hRxH+qaA@mail.gmail.com/

> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index fec1a39e5bbe..67bb80b7413a 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -13,17 +13,17 @@
>
>  /*
>   * Following is how we use various fields and flags of underlying
> - * struct page(s) to form a zspage.
> + * struct zpdesc(page) to form a zspage.
>   *
> - * Usage of struct page fields:
> - *     page->private: points to zspage
> - *     page->index: links together all component pages of a zspage
> + * Usage of struct zpdesc fields:
> + *     zpdesc->zspage: points to zspage
> + *     zpdesc->next: links together all component pages of a zspage
>   *             For the huge page, this is always 0, so we use this field
>   *             to store handle.
>   *     page->page_type: PG_zsmalloc, lower 16 bit locate the first objec=
t
>   *             offset in a subpage of a zspage
>   *
> - * Usage of struct page flags:
> + * Usage of struct zpdesc(page) flags:
>   *     PG_private: identifies the first component page
>   *     PG_owner_priv_1: identifies the huge component page

the comment for PG_owner_priv_1 can safely be removed as it's not used
after commit a41ec880aa7b ("zsmalloc: move huge compressed obj from
page to zspage")

> @@ -948,7 +949,7 @@ static void create_page_chain(struct size_class *clas=
s, struct zspage *zspage,
>                 set_page_private(page, (unsigned long)zspage);
>                 page->index =3D 0;
>                 if (i =3D=3D 0) {
> -                       zspage->first_page =3D page;
> +                       zspage->first_zpdesc =3D page_zpdesc(page);
>                         SetPagePrivate(page);
>                         if (unlikely(class->objs_per_zspage =3D=3D 1 &&
>                                         class->pages_per_zspage =3D=3D 1)=
)
> @@ -1325,7 +1326,7 @@ static unsigned long obj_malloc(struct zs_pool *poo=
l,
>                 link->handle =3D handle;
>         else
>                 /* record handle to page->index */
> -               zspage->first_page->index =3D handle;
> +               zspage->first_zpdesc->handle =3D handle;

FYI this line seems to conflict with
bcc6116e39f512 ("mm/zsmalloc: move record_obj() into obj_malloc()")
on mm-unstable.

Best,
Hyeonggon

