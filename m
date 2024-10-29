Return-Path: <linux-kernel+bounces-386142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6CF9B3F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDF91C21D04
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6B042A97;
	Tue, 29 Oct 2024 01:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew+aAWNP"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E11D2B9B4;
	Tue, 29 Oct 2024 01:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730164068; cv=none; b=N+lyWpzV36K2Yy5ZJsaLHbiCLNqW8G6dxNrkDXRforukhIl4Zeobghqq5qdo+ZynyrwxcFy3om9HUQeYaOFBLVGBxq8Z+aLp7aGXvB6VZ5sGddAFNAnWKauOA+kYDSCeLEyr1x5WVvzCj80qPIp5Pj0ZCBOIbIqj1/lsbMCKYYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730164068; c=relaxed/simple;
	bh=5deK5WVVMdJUqtGc3NbiIMg5lxPp68QnobnuNldxSgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+PDjzSIIM9hl7AJ1OaUhoN36K9wyxu76KjL9OKyCP+fJPde+/rrslkEqyo13PbPbf5SXOEKViSCS7znDP6p8TvELIh2B0XnapTq+jz+gvzgcIDosAWZdehmE2b9L7P0aqooa4oXE0j8ttMTgp9o69lwFWkYTSoIHM0R6Lvtc5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew+aAWNP; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4a46b6affeaso1697926137.2;
        Mon, 28 Oct 2024 18:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730164065; x=1730768865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IG0PFS2Vufi1owynRS2sTlDlYx2r2czk9VLiILWiX+U=;
        b=Ew+aAWNPK/BCbMVCqpQ6SzUTENRWvcrZT2GaWRSeGKcaFDZNAUkp5+k+MXXByp5HCP
         /t6tjLtjUnBxlcTsEuLyDF0IAaabfyDVmWuK6UYLHqSDgt//focFp3NE+7VVQJ3Zwljr
         iw8vDw7xYGuV62Flcp0JCtufgXd7HhwXzOH6tXiNjIgz+ZE6P+dEsREd6cpsnu19kD8s
         p+WtzVbWNjOkzgxOG3sxLkpIFoNUB9cn28JV5UYgda0kTqaW8wANme1Yaoz3bxpJyp3Z
         8BtzXSP1nc0Gz7tRB/Noh/+CEy6OYis5fNE+TaEoR/LSG//WQFNKT9kOP00GUubCd7rM
         Ti4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730164065; x=1730768865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IG0PFS2Vufi1owynRS2sTlDlYx2r2czk9VLiILWiX+U=;
        b=wXyYW/XLEqi+6vfh8OW7QVDm+77iL+RiswqlnQ3GQuLxZNYlggPCF3nSzB4AAZS6zF
         5Z0AiMVo2y1qmU9oetYZv6bw+ptBwki8wSBUl9szkjpkIiWqDeyf0iP36yKYfuPEEvCu
         ICUyEmsGSIkGkKDTatSFYfd2kIVuL2wzoQDGOaR3f0jo0pDftUyA8jqdHUcXfAZzSRl+
         n+A6OT4D8qyhTBWQPoyTXcnMMpN910zlm+i4CENl92NI4hKCVWX/ADDUh4tVVrpjdx6K
         XEmjZGJ97Ea07Wob1DqqrgG3SurJgdHDTE0iFFYn9eV5efwpqSWhEX7akQSFs//PA0qR
         a2PA==
X-Forwarded-Encrypted: i=1; AJvYcCW0zjAEOzhuNoJu33OGK1Ayhk7lpSRYePNmQjnZvQx6IPkcqqdJLAu79Cm//5F9NjQeQOZwRcnwakRHOciH@vger.kernel.org, AJvYcCXoDMjsspl/47bFKcStOFTWGggV5XpxXDSdL8GFijA+KhfQWh81dgL3qNvTlDM00fjGkLVPpPl6vqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqnjBN+kezgCepn+6CaTMlnnV+VJBuqbbUuSVnK7JgISEWbsFr
	L5BmAhAd3hMlhzAKpNwaxS/SKmMQ80xKinJV5x9quncttoE9oM2NLBIyifiQAkqtZG91I7m7+9h
	oc01C+YO6VgCqdBoo1SKu55cy00c=
X-Google-Smtp-Source: AGHT+IFAQyuOiDaDWHTzQfoOvYmjnp4EXydCzQUk8uROlSAjxsOCXitgU6klSjw7VOVl8iKqy8ni8sOO5mYp738xB4Q=
X-Received: by 2002:a05:6102:4192:b0:4a7:487d:88e4 with SMTP id
 ada2fe7eead31-4a8cfb443d7mr9031420137.4.1730164064894; Mon, 28 Oct 2024
 18:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029002324.1062723-1-mcanal@igalia.com> <20241029002324.1062723-4-mcanal@igalia.com>
In-Reply-To: <20241029002324.1062723-4-mcanal@igalia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 29 Oct 2024 09:07:34 +0800
Message-ID: <CAGsJ_4yp89one_hoB_87poU2wrpJh_0NVicRKW538eE6yo1kZw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mm: generalize the implementation of ``thp_anon=``
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 8:24=E2=80=AFAM Ma=C3=ADra Canal <mcanal@igalia.com=
> wrote:
>
> Currently, the function ``setup_thp_anon()`` is extremely tied to the
> policies and bitmaps that currently exist for anon THP. This means that
> we can't reuse the function if we implement a ``thp_shmem=3D``.
>
> This commit extracts the behavior of the function to a new generic
> function. The new function is exposed in common headers for future use
> by mm/shmem.c.
>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>

Sorry, Ma=C3=ADra, my mistake. I don't see much value in making
get_order_from_str() a common
API since bootcmd such a small thing. I'd prefer to stick with your
previous code with
just a rename=E2=80=94unless, at some point, we move both shmem and anon co=
ntrols into
mm/huge_memory.c.

> ---
>  include/linux/huge_mm.h |  29 +++++++++++
>  mm/huge_memory.c        | 109 ++++++++++++++++++----------------------
>  2 files changed, 78 insertions(+), 60 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index b94c2e8ee918..b82e9379f2bf 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -471,6 +471,35 @@ void split_huge_pmd_locked(struct vm_area_struct *vm=
a, unsigned long address,
>  bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long add=
r,
>                            pmd_t *pmdp, struct folio *folio);
>
> +static inline int get_order_from_str(const char *size_str,
> +                                    const unsigned long thp_orders)
> +{
> +       unsigned long size;
> +       char *endptr;
> +       int order;
> +
> +       size =3D memparse(size_str, &endptr);
> +
> +       if (!is_power_of_2(size))
> +               goto err;
> +
> +       order =3D get_order(size);
> +       if (BIT(order) & ~thp_orders)
> +               goto err;
> +
> +       return order;
> +err:
> +       pr_err("invalid size %s in boot parameter\n", size_str);
> +       return -EINVAL;
> +}
> +
> +struct thp_policy_bitmap {
> +       const char *policy;
> +       unsigned long bitmap;
> +};
> +
> +int parse_huge_orders(char *p, struct thp_policy_bitmap *policies,
> +                     const int num_policies, const unsigned long thp_ord=
ers);
>  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
>
>  static inline bool folio_test_pmd_mappable(struct folio *folio)
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 832ca761b4c3..c61f4481cb6a 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -958,91 +958,80 @@ static int __init setup_transparent_hugepage(char *=
str)
>  }
>  __setup("transparent_hugepage=3D", setup_transparent_hugepage);
>
> -static inline int get_order_from_str(const char *size_str)
> -{
> -       unsigned long size;
> -       char *endptr;
> -       int order;
> -
> -       size =3D memparse(size_str, &endptr);
> -
> -       if (!is_power_of_2(size))
> -               goto err;
> -       order =3D get_order(size);
> -       if (BIT(order) & ~THP_ORDERS_ALL_ANON)
> -               goto err;
> -
> -       return order;
> -err:
> -       pr_err("invalid size %s in thp_anon boot parameter\n", size_str);
> -       return -EINVAL;
> -}
> -
> -static char str_dup[PAGE_SIZE] __initdata;
> -static int __init setup_thp_anon(char *str)
> +int parse_huge_orders(char *p, struct thp_policy_bitmap *policies,
> +                     const int num_policies, const unsigned long thp_ord=
ers)
>  {
>         char *token, *range, *policy, *subtoken;
> -       unsigned long always, inherit, madvise;
>         char *start_size, *end_size;
> -       int start, end, nr;
> -       char *p;
> +       int start, end, nr, i;
> +       bool policy_set;
>
> -       if (!str || strlen(str) + 1 > PAGE_SIZE)
> -               goto err;
> -       strcpy(str_dup, str);
> -
> -       always =3D huge_anon_orders_always;
> -       madvise =3D huge_anon_orders_madvise;
> -       inherit =3D huge_anon_orders_inherit;
> -       p =3D str_dup;
>         while ((token =3D strsep(&p, ";")) !=3D NULL) {
>                 range =3D strsep(&token, ":");
>                 policy =3D token;
>
>                 if (!policy)
> -                       goto err;
> +                       return 0;
>
>                 while ((subtoken =3D strsep(&range, ",")) !=3D NULL) {
> +                       policy_set =3D false;
> +
>                         if (strchr(subtoken, '-')) {
>                                 start_size =3D strsep(&subtoken, "-");
>                                 end_size =3D subtoken;
>
> -                               start =3D get_order_from_str(start_size);
> -                               end =3D get_order_from_str(end_size);
> +                               start =3D get_order_from_str(start_size, =
thp_orders);
> +                               end =3D get_order_from_str(end_size, thp_=
orders);
>                         } else {
> -                               start =3D end =3D get_order_from_str(subt=
oken);
> +                               start =3D end =3D get_order_from_str(subt=
oken, thp_orders);
>                         }
>
>                         if (start < 0 || end < 0 || start > end)
> -                               goto err;
> +                               return 0;
>
>                         nr =3D end - start + 1;
> -                       if (!strcmp(policy, "always")) {
> -                               bitmap_set(&always, start, nr);
> -                               bitmap_clear(&inherit, start, nr);
> -                               bitmap_clear(&madvise, start, nr);
> -                       } else if (!strcmp(policy, "madvise")) {
> -                               bitmap_set(&madvise, start, nr);
> -                               bitmap_clear(&inherit, start, nr);
> -                               bitmap_clear(&always, start, nr);
> -                       } else if (!strcmp(policy, "inherit")) {
> -                               bitmap_set(&inherit, start, nr);
> -                               bitmap_clear(&madvise, start, nr);
> -                               bitmap_clear(&always, start, nr);
> -                       } else if (!strcmp(policy, "never")) {
> -                               bitmap_clear(&inherit, start, nr);
> -                               bitmap_clear(&madvise, start, nr);
> -                               bitmap_clear(&always, start, nr);
> -                       } else {
> -                               pr_err("invalid policy %s in thp_anon boo=
t parameter\n", policy);
> -                               goto err;
> +
> +                       for (i =3D 0; i < num_policies; i++) {
> +                               if (!strcmp(policy, policies[i].policy)) =
{
> +                                       bitmap_set(&policies[i].bitmap, s=
tart, nr);
> +                                       policy_set =3D true;
> +                               } else
> +                                       bitmap_clear(&policies[i].bitmap,=
 start, nr);
> +                       }
> +
> +                       if (!policy_set && strcmp(policy, "never")) {
> +                               pr_err("invalid policy %s in boot paramet=
er\n", policy);
> +                               return 0;
>                         }
>                 }
>         }
>
> -       huge_anon_orders_always =3D always;
> -       huge_anon_orders_madvise =3D madvise;
> -       huge_anon_orders_inherit =3D inherit;
> +       return 1;
> +}
> +
> +static char str_dup[PAGE_SIZE] __initdata;
> +static int __init setup_thp_anon(char *str)
> +{
> +       struct thp_policy_bitmap policies[] =3D {
> +               { "always",  huge_anon_orders_always },
> +               { "madvise",  huge_anon_orders_madvise },
> +               { "inherit",  huge_anon_orders_inherit },
> +       };
> +       char *p;
> +
> +       if (!str || strlen(str) + 1 > PAGE_SIZE)
> +               goto err;
> +
> +       strscpy(str_dup, str);
> +       p =3D str_dup;
> +
> +       if (!parse_huge_orders(p, policies, ARRAY_SIZE(policies),
> +                             THP_ORDERS_ALL_ANON))
> +               goto err;
> +
> +       huge_anon_orders_always =3D policies[0].bitmap;
> +       huge_anon_orders_madvise =3D policies[1].bitmap;
> +       huge_anon_orders_inherit =3D policies[2].bitmap;
>         anon_orders_configured =3D true;
>         return 1;
>
> --
> 2.46.2
>

Thanks
Barry

