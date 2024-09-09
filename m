Return-Path: <linux-kernel+bounces-322077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0B99723A9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863E21F231DA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D9318A948;
	Mon,  9 Sep 2024 20:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="py7t7zZy"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA4518A6B7
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913804; cv=none; b=c1T89uf9yjtNv5bnJBWwWhgC0yuVGgTn4i6kK6XAaygsDbI0ylNnwQG2/Dd0Rg4vxu2gMt8QqmYQ2Zj87Srq8O4ukYanoveaLoEDDOrYuYcpImPa64UkqN0aI5EuxRkJwnnxgzgiHUedIPj1o2hk+q6L25SSP+1ORVva93SnLsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913804; c=relaxed/simple;
	bh=68qqOGIZcIVgGIZMz4ZrT0iVCLoiWQqyOW/klR7ZnO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwBcW9LwIABVdw8SyS2g+IY1KnWRgFCpX2qDCVebw/wBgIdDpoOdSD6aeXL4UPm0T88zdpwxsT+et7Lxbg5dmgoCEoaSS5h50Dvwlxgju0yHVfVIYjbJhGoc3Nxax7rSQez2Ber2lp0xViPez2o00OM7N8Dum7/ltKoGkgWh/qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=py7t7zZy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so20770305e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 13:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725913801; x=1726518601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XaeSQCeGfBRdIaHorPwBFNBXhIKm2efh/hZk06eZftc=;
        b=py7t7zZySWiteqppZDLqe4R7ZOOuVX/gc/iGMlZjKO/3nNUVtw5TYKKr1v7pxbV+Zt
         Mz7ycAJd12W7RC6xQTc7awWoVYRTDhARs39w0GvUX9faJzR/CJd5uh4GJvDentkWaLs1
         w70iowSrTIh4fvYD2LAlIPSpAXkCoqllnDQM0hbwDoXXzXawrUYkIXtLMNg1BJIK7/wC
         eROUFs6Q3L1EmwAj5Do0USf0F+EODamYlf5aTb9g76/fq+h/QfWQdA74ZFl9FHuxrCrQ
         ejjTVGJPIOsXrf23/egEMDnmhEZtKAI0QTxLktegxQUYuapo6ObLeTaCar002/IRz5eE
         cv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725913801; x=1726518601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XaeSQCeGfBRdIaHorPwBFNBXhIKm2efh/hZk06eZftc=;
        b=MUKCYQfl1LtvVd666vAX5mP/KPDYFUBovJtojPPu4r3tWQQnsYgz97+Josi27N1OXv
         iPJXYXHFjU/2kuvogWKPU2TPws4HKGWgfyeCu3/M8hdSolQ9AmfgZ6EQFWN2Be+q4utk
         06dZAV1klF8gaIS/X8w1YFlfMcLyiyAjtvo1bS/1sHSPD9UD7Kgz463Gd2YVnTLTP+6H
         ZV8L1sT6zpGVS6f/egpZlwva7bqsU17v/Ov1uuzYKmCygAi3IpU0bkvi3DT3wfsK2FO7
         jR0X0+QtMRTT0lTUhRazLN7UYaJfQ6IkD2aF8Wm4h8HzFEXVPG/YI9nj19deIbxIy4TZ
         wB4A==
X-Forwarded-Encrypted: i=1; AJvYcCVlbj4O5rBerqQWslCAH2/Im2IHGqxZfWkrrp7nxMQtJ6XNH+5xBtZ/vOAo4rZXyufaSK6a40+jEACSWk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyWgQYghUZxxu9Nr7rM8qcQRTrAbBjk4kRZfzvUzpLK+wbSBYc
	9hJIOMdCE1NAO+P6o5HoBq4dXS7e2/2gAluYT/eFXWJBHez7xeHq2clGbyx7rqn3ytLLjJPaBzT
	0wyadFxyJOFlN6LSugtkohwWmvPIozHS2xjKX
X-Google-Smtp-Source: AGHT+IGGDgVrgTdXrGeSeuVyKgWmJPMNqrnV8Gr/pbVAU/1kji99wC4S9pU3ses1bfxjWm712k8Ob7/H1W5GgkPQXfg=
X-Received: by 2002:a5d:4d4c:0:b0:374:c6af:1658 with SMTP id
 ffacd0b85a97d-3789229bbd1mr7700608f8f.1.1725913800042; Mon, 09 Sep 2024
 13:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909202625.1054880-1-arnd@kernel.org>
In-Reply-To: <20240909202625.1054880-1-arnd@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 9 Sep 2024 13:29:24 -0700
Message-ID: <CAJD7tkb9q-_MHFWdM7+KueFS9LJUWsvqHdDmFnpgNahyjv+8+A@mail.gmail.com>
Subject: Re: [PATCH] mm: z3fold: deprecated ZSWAP_ZPOOL_DEFAULT_Z3FOLD as well
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Down <chris@chrisdown.name>, Arnd Bergmann <arnd@arndb.de>, 
	David Hildenbrand <david@redhat.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 1:26=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Randconfig builds that use ZSWAP_ZPOOL_DEFAULT_Z3FOLD
> now cause a harmless warning:
>
> WARNING: unmet direct dependencies detected for Z3FOLD
>   Depends on [n]: Z3FOLD_DEPRECATED [=3Dn]
>   Selected by [y]:
>   - ZSWAP_ZPOOL_DEFAULT_Z3FOLD [=3Dy] && ZSWAP [=3Dy]
>
> Avoid the warning by selecting Z3FOLD_DEPRECATED instead,
> but rename this symbol to ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED
> in the process so it no longer automatically gets used with
> old defconfigs while still allowing users to select it
> manually.
>
> Fixes: c68c1bed014d ("mm: z3fold: deprecate CONFIG_Z3FOLD")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/Kconfig | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 7c9930bf8a9d..09aebca1cae3 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -146,12 +146,15 @@ config ZSWAP_ZPOOL_DEFAULT_ZBUD
>         help
>           Use the zbud allocator as the default allocator.
>
> -config ZSWAP_ZPOOL_DEFAULT_Z3FOLD
> -       bool "z3fold"
> -       select Z3FOLD
> +config ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED
> +       bool "z3foldi (DEPRECATED)"
> +       select Z3FOLD_DEPRECATED

Thanks for looking into this!

I was going to fix this by changing "select Z3FOLD" to "depends on
Z3FOLD" instead. It makes the warning go away in my builds. Does this
work for you?

FYI I will send a new version of "mm: z3fold: deprecate CONFIG_Z3FOLD"
as a hotfix after v6.12-rc1 is out as there are currently conflicts,
so I plan to squash the fix into the next version if that's okay with
you.

>         help
>           Use the z3fold allocator as the default allocator.
>
> +         Deprecated and scheduled for removal in a few cycles,
> +         see CONFIG_Z3FOLD_DEPRECATED.
> +
>  config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
>         bool "zsmalloc"
>         select ZSMALLOC
> @@ -163,7 +166,7 @@ config ZSWAP_ZPOOL_DEFAULT
>         string
>         depends on ZSWAP
>         default "zbud" if ZSWAP_ZPOOL_DEFAULT_ZBUD
> -       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD
> +       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD_DEPRECATED
>         default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
>         default ""
>
> --
> 2.39.2
>

