Return-Path: <linux-kernel+bounces-202054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E59D8FC73B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09672873A1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE5018F2EC;
	Wed,  5 Jun 2024 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfepZjaA"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5561C18F2D5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578431; cv=none; b=IOTfD7teUT7mq/YQU1WuTjn0rjtr9wRsRSNclK/IL0u8xC28tM/71J3+zCZlHYY3yzBKAiB3xrY8ngMdskpzgSWyYn/rmH6vIZVayT9rcBjsZMB6/fV7844r1g8wgkh87RM/EVhPqhIvaOXeYrYUMKTpZsrPFqa5eHJc9mR2zSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578431; c=relaxed/simple;
	bh=loXhM9Yxn9BbLaixu6YPZx5GUPWNlEqzbXT4JwnCZmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r8dpSZpFhIbl2omJ+zZXIA455OG+5u6n8rXXp2KnV2z5Q6i/+vPVjpSCyDnvSaivbksBo9Us8wweCM7fBUInXnEe6MGjgU+qSQC3ViHS/KpL/jjwLTTJBJGHM6/wcSBlLD6OURMqaa3i6/HzCFr+UVZc5LHyCTTieFCtmhAvggA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfepZjaA; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-48bbb95946dso1490288137.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 02:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717578429; x=1718183229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDPYpEdNguVrOTbA9wDGrH7gHwuEPOPL6eF7OUK/zMY=;
        b=JfepZjaA1YCzYz7HfdIUkgokLoYFT796Bj3M6pqzcN7DixYOAjd6sUx375g70lJFuc
         zQw8IPlL0nMtTpx4Fi/rSgn5nXZFLVuJsxsxdmKSdr4KWfs+kvos1AgU1Fp/M7P8wtPG
         AQKSFerahuKCnAZ63H+W3AW7gkK2MYBZbo8eeAg7ppMLaOSef6Hx8LhEXR0SzjvM5kJU
         JyeMwSv4ENADNbbpVvaRRULxrwlEcNSovVfc7Sblg+W+sc/37riklJU2H+bg1ZCnqHnw
         y5e7bmuZvQuRiegEZcA+UZzRWrDR694k0gnmF0AkgD/FJhJc4DXk+8tATAJhjV1yyRxX
         g65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717578429; x=1718183229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDPYpEdNguVrOTbA9wDGrH7gHwuEPOPL6eF7OUK/zMY=;
        b=cuEAhymQ/3xDyw9rYVHD2lKSKXjYS+rQkm+O0UuESrxqxplZnOtiRX20c8esaL9D4G
         N2aEy7tRSu4FaVYKbCMcjf9fj4uPYAJ3YStjtW5x7ksu//Perx+71UUZSH5O+g3RHJht
         dG7+2A2dbWgYAXntQ+0l2a/LRSXcs1IT/WW4lA68x6rR21nXIVmydECc8XvVF+/Ax+JD
         l4+SjG9zcL8RiybFhicHZlnpfhOalp29zOzvISDDYQelyCdVwTCU6gi8lZjO2h+iS4GW
         6CkR00xamrR3LwrQutAgffmiT2WbzAjlle9uZ6U0BaKi3PKHbfMpBVFDiEbZDnZVv+fn
         DjLA==
X-Forwarded-Encrypted: i=1; AJvYcCV79dTF4JoQC1O810/k8mzFlL+2XyVSGbxAvDO2m29aQEHqO1f+1Kuo55EzfFc2pY3CzJizEBzotGX++T4SXLdo2flHTopmYJL2a6Nq
X-Gm-Message-State: AOJu0YzPA85DIlUyTOLr+IhE+G99rvuHcn5VK7AxoePl9bNAUbib/VSu
	qyHS1jAh16W1kTk3igSjgQH6RXGqMNkPh/xSAw65jYnU66m3ihNdRtxLELdvg6l+dck4LuteZn2
	Sr9kmo69G3J2xrLMtX/H1eKzOnsc=
X-Google-Smtp-Source: AGHT+IE+LMSeo6vABeCvVWma4Tfcx9dAAW5DmbgpKCBYyKnzm9w8vFpOcrisjMpQoiCdLvLA/8KdEv+TCRxmUSL+NJ0=
X-Received: by 2002:a05:6102:3a12:b0:485:9a12:ca5 with SMTP id
 ada2fe7eead31-48c0488debdmr2947926137.17.1717578429100; Wed, 05 Jun 2024
 02:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604134738264WKaKYb3q_YTE32hNAy2lz@zte.com.cn>
In-Reply-To: <20240604134738264WKaKYb3q_YTE32hNAy2lz@zte.com.cn>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 5 Jun 2024 21:06:57 +1200
Message-ID: <CAGsJ_4wFyFBTDDfsBpi0sKs1WOH2jaKKoYWWj9Ln_PsNjP2uuA@mail.gmail.com>
Subject: Re: [PATCH linux-next] mm: huge_memory: fix misused
 mapping_large_folio_support() for anon folios
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org, ziy@nvidia.com, v-songbaohua@oppo.com, 
	mhocko@kernel.org, david@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 5:47=E2=80=AFPM <xu.xin16@zte.com.cn> wrote:
>
> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>
> When I did a large folios split test, a WARNING
> "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
> was triggered. But my test cases are only for anonmous folios.
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
> Using /sys/kernel/debug/split_huge_pages to verify this, with this
> patch, large anon THP is successfully split and the warning is ceased.
>
> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> Cc: xu xin <xu.xin16@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> ---
>  mm/huge_memory.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 317de2afd371..4c9c7e5ea20c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3009,31 +3009,33 @@ int split_huge_page_to_list_to_order(struct page =
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
>         if (new_order) {
>                 /* Only swapping a whole PMD-mapped folio is supported */
>                 if (folio_test_swapcache(folio))
>                         return -EINVAL;
> -               /* Split shmem folio to non-zero order not supported */
> -               if (shmem_mapping(folio->mapping)) {
> -                       VM_WARN_ONCE(1,
> -                               "Cannot split shmem folio to non-0 order"=
);
> -                       return -EINVAL;
> -               }
> -               /* No split if the file system does not support large fol=
io */
> -               if (!mapping_large_folio_support(folio->mapping)) {
> -                       VM_WARN_ONCE(1,
> -                               "Cannot split file folio to non-0 order")=
;
> -                       return -EINVAL;
> +
> +               if (folio_test_anon(folio)) {
> +                       /* Cannot split anonymous THP to order-1 */
> +                       if (new_order =3D=3D 1) {
> +                               VM_WARN_ONCE(1, "Cannot split to order-1 =
folio");
> +                               return -EINVAL;
> +                       }
> +               } else {
> +                       /* Split shmem folio to non-zero order not suppor=
ted */
> +                       if (shmem_mapping(folio->mapping)) {
> +                               VM_WARN_ONCE(1,
> +                                       "Cannot split shmem folio to non-=
0 order");
> +                               return -EINVAL;
> +                       }
> +                       /* No split if the file system does not support l=
arge folio */
> +                       if (!mapping_large_folio_support(folio->mapping))=
 {
> +                               VM_WARN_ONCE(1,
> +                                       "Cannot split file folio to non-0=
 order");
> +                               return -EINVAL;
> +                       }

Am I missing something? if file system doesn't support large folio,
how could the large folio start to exist from the first place while its
mapping points to a file which doesn't support large folio?

>                 }
>         }
>
> -
>         is_hzp =3D is_huge_zero_folio(folio);
>         if (is_hzp) {
>                 pr_warn_ratelimited("Called split_huge_page for huge zero=
 page\n");
> --
> 2.15.2
>

Thanks
Barry

