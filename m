Return-Path: <linux-kernel+bounces-204052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216638FE363
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEDB128714A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8BB17994F;
	Thu,  6 Jun 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHz5Jtrn"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FC8179650
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667387; cv=none; b=XT98vNpc9SedDxmROtkRl/3WW7vbfIrJHvyWwbWh/Eyj775Iv4i9v+LkfA8PMmtfTY/qzmgpYKlwKBacfsWkCmVrH7EK9WbvGKDBYR2P/cQJLrPk8AeaVTXvzA5Rw8z1R6FK8TeWpq6PEOuzlINOaGp6sIWUvTyxxx1GrozEZAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667387; c=relaxed/simple;
	bh=yR6q76cCD6sovahWM0N9HIHzr0RhBzn2YgykJAn/Uoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLj6ofgM9FyqIt+llT98md3txb5s6a4MTbtz2WjjYJTJHkF6JiENNZ4DhJv/mbNe9ZoAlXW4utL48CJXdPSYB4Nue4lpRwtvp5VKqQAhPGceS/P0Ue1JN7P7hxA5xrECvXQWyK9PtX3Yt8hIYcNdecaX8cazByVgDstE2tMAB0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHz5Jtrn; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-48bc7efcc79so256431137.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717667385; x=1718272185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5SFAiI9V1WIFwt0VU4EfhN6CyXh9/bfQ+JmuRJbGSs=;
        b=HHz5JtrnLwPy2eVdei6LTkH29kccatWPYsFI+KYij+99S12qXFZ4ti2qT40goKrZXG
         ecNZLGDuKtRaCGVPfh6IcjO05N1ulK83/K1VQ6S1+hJhIEqxZVcMTKp7axQKdP1o5n9x
         I7H0SExAq19klNX90IfLAXYfuiExjO9/fim/zH605txD7Foo6Nxf1+Lr0wldWZ1wAk4+
         oWrG3IJW8shwaInbjeI8P0ABqSrLeGPB+Dgl1ArhZvh2R6AjCP7mivHKQFI9w5JiMBJL
         AFtOYa+DKck5c88ieotNNFyyZRgqAzvUJHB32Fy7E5iRLml9dAtUb9IOS/P++5kAT9Bu
         44uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717667385; x=1718272185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5SFAiI9V1WIFwt0VU4EfhN6CyXh9/bfQ+JmuRJbGSs=;
        b=JB8Ucgl2DJ0/s4ZxEfp1RzmU9O5AS/uGM382iLIfYLL2RkZ+H8pkxR/UkKGrgW4UeU
         5fyInJXVsXng0bPSDEe+bjWV/ww80yvz5ZbPgi5a2g5brm3XU1y7RVtIv7BkoGvSaTEP
         zpkaLG2mQIrD7h7xTV5jG/c/+fMe72DHDTDytzCHJa4A6fdjkA2HrXr8d1H0jMBcLCYq
         wWDFESls0uuD6YNwep/4P4CmilU9SdvZpKm64NLIQOAIDg7KJ6m4EKHM6PPbPv4fmXPu
         S6N3k95YmC2QcxIxRCDz+93imZCc0XTolZnhVE/wrcRPg814+ivRy62C99UaZnbiPnDx
         j5/g==
X-Forwarded-Encrypted: i=1; AJvYcCUXbrzImBhIfgKpc/V9FOnuWkQ+brAEeeMr/unHvCAfugjnDRb7NJv574j3UDG2l4MRQQfIqlHjnuwn/SoY+oFRIciWI37VoRwcB0at
X-Gm-Message-State: AOJu0YxS66XMufGmk+eqaCe6ZQsqmhzfFCc/2vg5lVj8vXnTMa+AkN7R
	LqnR9JYM1/zGwKSm0GSkyFvKOpaKtJqtAkx7vVZxcCb/8TVhUH3xg0fQzluL+xaiaBL2r3qyfsU
	MygjHZ8OQAwCVkw+FLzmXNsEssLs=
X-Google-Smtp-Source: AGHT+IGcONUDBOI5r+pfKRiVVGW0DOI8UpPIHDE7Yd3D8+dgFdexhME0FzGIv5cKcTMn71K2B4eDQ4MbcD2Lbrg2xco=
X-Received: by 2002:a67:efcc:0:b0:486:9294:c8b3 with SMTP id
 ada2fe7eead31-48c04aa2bbdmr5452652137.29.1717667383182; Thu, 06 Jun 2024
 02:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606174203124_OW-VQZ_ZLm4lGEimA-K9@zte.com.cn>
In-Reply-To: <20240606174203124_OW-VQZ_ZLm4lGEimA-K9@zte.com.cn>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 6 Jun 2024 21:49:32 +1200
Message-ID: <CAGsJ_4x=v0fDN_QVjdHSGVykH2+o_f81NnN_0-SUL+iwe+v84g@mail.gmail.com>
Subject: Re: [PATCH linux-next v2] mm: huge_memory: fix misused
 mapping_large_folio_support() for anon folios
To: xu.xin16@zte.com.cn
Cc: david@redhat.com, ziy@nvidia.com, v-songbaohua@oppo.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mhocko@kernel.org, yang.yang29@zte.com.cn, ran.xiaokai@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 9:42=E2=80=AFPM <xu.xin16@zte.com.cn> wrote:
>
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> When I did a large folios split test, a WARNING
> "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
> was triggered. But the test cases are only for anonmous folios.
> while mapping_large_folio_support() is only reasonable for page
> cache folios.
>
> In split_huge_page_to_list_to_order(), the folio passed to
> mapping_large_folio_support() maybe anonmous folio. The
> folio_test_anon() check is missing. So the split of the anonmous THP
> is failed. This is also the same for shmem_mapping(). We'd better add
> a check for both. But the shmem_mapping() in __split_huge_page() is
> not involved, as for anonmous folios, the end parameter is set to -1, so
> (head[i].index >=3D end) is always false. shmem_mapping() is not called.
>
> Also add a VM_WARN_ON_ONCE() in mapping_large_folio_support()
> for anon mapping, So we can detect the wrong use more easily.
>
> THP folios maybe exist in the pagecache even the file system doesn't
> support large folio, it is because when CONFIG_TRANSPARENT_HUGEPAGE
> is enabled, khugepaged will try to collapse read-only file-backed pages
> to THP. But the mapping does not actually support multi order
> large folios properly.
>
> Using /sys/kernel/debug/split_huge_pages to verify this, with this
> patch, large anon THP is successfully split and the warning is ceased.
>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
>  include/linux/pagemap.h |  4 ++++
>  mm/huge_memory.c        | 27 ++++++++++++++++-----------
>  2 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index ee633712bba0..59f1df0cde5a 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -381,6 +381,10 @@ static inline void mapping_set_large_folios(struct a=
ddress_space *mapping)
>   */
>  static inline bool mapping_large_folio_support(struct address_space *map=
ping)
>  {
> +       /* AS_LARGE_FOLIO_SUPPORT is only reasonable for pagecache folios=
 */
> +       VM_WARN_ONCE((unsigned long)mapping & PAGE_MAPPING_ANON,
> +                       "Anonymous mapping always supports large folio");
> +
>         return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>                 test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
>  }
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 317de2afd371..62d57270b08e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3009,30 +3009,35 @@ int split_huge_page_to_list_to_order(struct page =
*page, struct list_head *list,
>         if (new_order >=3D folio_order(folio))
>                 return -EINVAL;
>
> -       /* Cannot split anonymous THP to order-1 */
> -       if (new_order =3D=3D 1 && folio_test_anon(folio)) {
> -               VM_WARN_ONCE(1, "Cannot split to order-1 folio");
> -               return -EINVAL;
> -       }
> -
> -       if (new_order) {
> -               /* Only swapping a whole PMD-mapped folio is supported */
> -               if (folio_test_swapcache(folio))
> +       if (folio_test_anon(folio)) {
> +               /* Cannot split anonymous THP to order-1 */

This is simply what the code is indicating. Shouldn't we phrase
it differently to explain "why" but not "how"? for example, anon
order-1 mTHP is not supported?

Otherwise, it looks good to me.

Reviewed-by: Barry Song <baohua@kernel.org>

> +               if (new_order =3D=3D 1) {
> +                       VM_WARN_ONCE(1, "Cannot split to order-1 folio");
>                         return -EINVAL;
> +               }
> +       } else if (new_order) {
>                 /* Split shmem folio to non-zero order not supported */
>                 if (shmem_mapping(folio->mapping)) {
>                         VM_WARN_ONCE(1,
>                                 "Cannot split shmem folio to non-0 order"=
);
>                         return -EINVAL;
>                 }
> -               /* No split if the file system does not support large fol=
io */
> -               if (!mapping_large_folio_support(folio->mapping)) {
> +               /* No split if the file system does not support large fol=
io.
> +                * Note that we might still have THPs in such mappings du=
e to
> +                * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the map=
ping
> +                * does not actually support large folios properly.
> +                */
> +               if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> +                       !mapping_large_folio_support(folio->mapping)) {
>                         VM_WARN_ONCE(1,
>                                 "Cannot split file folio to non-0 order")=
;
>                         return -EINVAL;
>                 }
>         }
>
> +       /* Only swapping a whole PMD-mapped folio is supported */
> +       if (folio_test_swapcache(folio) && new_order)
> +               return -EINVAL;
>
>         is_hzp =3D is_huge_zero_folio(folio);
>         if (is_hzp) {
> --
> 2.15.2
>

