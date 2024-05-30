Return-Path: <linux-kernel+bounces-195649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2108D4FC0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9CB1C232DF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FA0210F8;
	Thu, 30 May 2024 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WBY2wW0l"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A33F22EE4
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086049; cv=none; b=niCJM9WnMfbgonr9v495CIQdu07ed+KxgV4Dv/Gr+rAwbIiU5p1XRskAgUe3lzY0BWxw7y4vTCSxMV7nd/uhPlroY1Zjs/YC/fhtUaXTLzQE7HK9a7bGr54HJ41DBLhKEbKbyffFxpZ4fliB+VnbqqsgSUEEZZy73pCxwHhFi/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086049; c=relaxed/simple;
	bh=3B7ZQyZk5/+5h/jcTSOJgwlHgMzpB3t0tzQ4xhvru0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4MgznIPmWJj0qPElrjnEJWLpGBEWdZnI/GPXapTcKwAR19LkNeJJEBMMAA7kMUPHgeMYILk6P47v81QbScqiYYVbqgXJCjgP+MBdYB7ci7q8oZxoUh+KjzhoBLSc4XGcPwGwWLhhX31oOSMdp6HhWpgzQotQMM0PH3XiD6IBfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WBY2wW0l; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a5dcb5a0db4so113920266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717086046; x=1717690846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kl/GGM9FEQNmC7lNrCDznGozkd6NHwhfF13Ha04rMtw=;
        b=WBY2wW0l1DDjIzqCJuEBe2r3/DXZMSt9MYNsmIgTSadfdJEpMuommo/bv12yAykeNc
         Zpkw/fqy5i/5zQZqk6Nbq5Ay/CfnBa+XXW8GVBa8WLRRbfgEzrn/9PsXavoqcSxLSm+e
         pRbys0CXx3C6EpoRRi+s+sOPiYZ/nXhQRy0eem92YqvBmiW0RyS0FyTR05n0eEzM8fTE
         /UlVe5abGYvUFftuOH4O/gu48FW/xRpSZ2wJG7lOANDY1R4KAMWJDhnz3n+20GudfEqg
         DOq02V/xedD5YZuykRD5OtzV1hOrgETVXUaVb1CeVha3jo8CcR00FkkBXdFljvoEtPzG
         6KYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717086046; x=1717690846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kl/GGM9FEQNmC7lNrCDznGozkd6NHwhfF13Ha04rMtw=;
        b=kKmyq7hpZKB6oBmT6O13W59ZYmbEzSQaI2lyVkXktiGzWvqTK8zlRc7sNr+f3ct+4t
         dt9eXHEGVuUb49GuWSWzj94Xdh/rfOiRuR8iZ+mtpqdIjERyorVxowjHekyqOhVgJAOO
         mzVnDxYFV++mWqhf/ACUkTsI0eyj5crZolN3VOB2QTXN1nFIHQFHw5qndpJwdPsvOd7D
         Et6R/axjalbSGv6d1EQ+lGPNamAc9yZQ4Qe7QH6ncWVWKCuglqpxCwRk9y+Y1/3nodMl
         MOOpshNSBrKa+BcDREsMQ612eAWoLbBoACKjYrX9L/I+3tclDhVwXg7v2H/ZOp5XQ6VB
         DcJA==
X-Forwarded-Encrypted: i=1; AJvYcCXyO0gNVjWAxKZS2UNOTar45nKlbWqmb54NL4zv8O1Kgl6t8WLcvNHUlvdprG+IysE59ecN8JSo3dCrfhWvsn4cHqCRZni13Npe0frB
X-Gm-Message-State: AOJu0YywMOTYceRkTNj+uyjJepu9Qnyfx4vYgCzuNp/A3R6cJ+K1F3zi
	re1xOYk5Th1Sr5Lvb3GlYsddKIHfvsB5wUtVwI5VoJhZX11dEdYdbbZHOsKxZkZEmH7BqnYe0/v
	oAIri7slGYn28GuK6l1PF9sHLtmOdOjCjRkbf
X-Google-Smtp-Source: AGHT+IE99vKgOVmVQYgmhzEBWXRWfHbQ0PozVSW5DerT4/50qVdSiaudvPuYP6CQetEqvnOnFqyicngxT1Zw39JQ8gI=
X-Received: by 2002:a17:906:11d2:b0:a59:c62c:212d with SMTP id
 a640c23a62f3a-a65e8d36768mr160285466b.14.1717086045429; Thu, 30 May 2024
 09:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530102126.357438-1-usamaarif642@gmail.com> <20240530102126.357438-2-usamaarif642@gmail.com>
In-Reply-To: <20240530102126.357438-2-usamaarif642@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 30 May 2024 09:20:06 -0700
Message-ID: <CAJD7tkbn-Nb54aiCKQshb9HjBCQAZ_63FH4vic072kcV+ZxHrA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: store zero pages to be swapped out in a bitmap
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 3:21=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> Approximately 10-20% of pages to be swapped out are zero pages [1].
> Rather than reading/writing these pages to flash resulting
> in increased I/O and flash wear, a bitmap can be used to mark these
> pages as zero at write time, and the pages can be filled at
> read time if the bit corresponding to the page is set.
> With this patch, NVMe writes in Meta server fleet decreased
> by almost 10% with conventional swap setup (zswap disabled).

Great work. I thought about doing this after my attempt to drop some
of the same-filled pages handling in zswap, now we can drop all of it
:)

Make sure to CC other non-zswap folks on next iterations like Ying. I
see Johannes already did that in his response. I suspect
get_maintainers will give you a few extra names.

>
> [1]https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d=
1344dde9fce0@epcms5p1/
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  include/linux/swap.h |  1 +
>  mm/page_io.c         | 86 ++++++++++++++++++++++++++++++++++++++++++--
>  mm/swapfile.c        | 10 ++++++
>  3 files changed, 95 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index a11c75e897ec..e88563978441 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -299,6 +299,7 @@ struct swap_info_struct {
>         signed char     type;           /* strange name for an index */
>         unsigned int    max;            /* extent of the swap_map */
>         unsigned char *swap_map;        /* vmalloc'ed array of usage coun=
ts */
> +       unsigned long *zeromap;         /* vmalloc'ed bitmap to track zer=
o pages */
>         struct swap_cluster_info *cluster_info; /* cluster info. Only for=
 SSD */
>         struct swap_cluster_list free_clusters; /* free clusters list */
>         unsigned int lowest_bit;        /* index of first free in swap_ma=
p */
> diff --git a/mm/page_io.c b/mm/page_io.c
> index a360857cf75d..ab043b4ad577 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -172,6 +172,77 @@ int generic_swapfile_activate(struct swap_info_struc=
t *sis,
>         goto out;
>  }
>
> +static bool is_folio_page_zero_filled(struct folio *folio, int i)
> +{
> +       unsigned long *page;

I just recently renamed this variable in the zswap version of this
function because it is very confusing, especially when looking for
struct page references. 'page' is usually used for struct page. Let's
use a different name here.

> +       unsigned int pos;
> +       bool ret =3D false;
> +
> +       page =3D kmap_local_folio(folio, i * PAGE_SIZE);

In the zswap version, we compare against the end of the page first
before the loop, in case the page just has a bunch of zeros at its
beginning. The patch that added it to zswap reported better
performance in some cases [1].

You can also use memchr_inv() to compare the range against 0 instead
of the loop.

[1]https://lore.kernel.org/all/20230205190036.1730134-1-taejoon.song@lge.co=
m/

> +       for (pos =3D 0; pos < PAGE_SIZE / sizeof(*page); pos++) {
> +               if (page[pos] !=3D 0)
> +                       goto out;
> +       }
> +       ret =3D true;
> +out:
> +       kunmap_local(page);
> +       return ret;
> +}
> +
> +static bool is_folio_zero_filled(struct folio *folio)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < folio_nr_pages(folio); i++) {
> +               if (!is_folio_page_zero_filled(folio, i))
> +                       return false;
> +       }
> +       return true;
> +}

Is there value in splitting this into two functions and having a
separate loop here? Can we just have a single function that kmaps the
entire folio and loops over it in one go?

> +
> +static void folio_page_zero_fill(struct folio *folio, int i)
> +{
> +       unsigned long *page;
> +
> +       page =3D kmap_local_folio(folio, i * PAGE_SIZE);
> +       memset_l(page, 0, PAGE_SIZE / sizeof(unsigned long));
> +       kunmap_local(page);
> +}
> +
> +static void folio_zero_fill(struct folio *folio)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < folio_nr_pages(folio); i++)
> +               folio_page_zero_fill(folio, i);

I think you can just use clear_highpage() here and drop
folio_page_zero_fill(). It should be more optimized as well in some
cases.

I don't have further comments about the rest beyond Johannes's comments.

