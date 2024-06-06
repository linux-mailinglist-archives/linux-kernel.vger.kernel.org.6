Return-Path: <linux-kernel+bounces-203439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B338FDB1A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975511F29863
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9AB7E6;
	Thu,  6 Jun 2024 00:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="iuol3VcH"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2CC364
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 00:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717632105; cv=none; b=VAVWDH6UUXRHNer5BO7vDYA7J0ECDXQihB53VX5nPyh/XAM7C+aZvf1HuKB6sHipSH1v8M5lHjaTEQl8Td6sFFyXJ/CSNkXQW2UHQtc4hj2HTofMHTmpecxGApuq5tIgx+Nw33l88Zm+Rd2xGm0YQuMvD9lEUYMaqsVhLMCgMrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717632105; c=relaxed/simple;
	bh=V1vIqUI3m0Ze4AdpE4HZq9TKkx1u03kCbm5TP7h8YiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiiujU7rCCpaOH92f4Dznp0P+4YeZ0vKfhFHXxVPMrrHTKo1BpmeVH50aJSsMlSsY2eTGAtnIQzP74+ZAQ8VcuHDg6r1nXTO+ZuvEdj+iWTJZLTagFHmN56KAZdZUMXmPON3GhhOdQpRMLRLgCpR2HWx9mRkuOauaDe0nwivCTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=iuol3VcH; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ae1b3274e5so1725286d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 17:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1717632103; x=1718236903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmBd4TBTVdAZlOWe2QN0nlhgeqjZ470lPTg1Yj5xMSg=;
        b=iuol3VcH14gC9Z+SaOFoHzoRCDxzkwxgIPPUm1q6RW2HBYQrfG3iuN9E6IWalKwhH3
         R9Kop3cAqWanu3TVgK3ECONVMVkCLtddOsnhKDYzMFT/wTck+puJuq9me9R7tzKSEOK0
         RIA93bZ73olGrY2vhaQJOe6QNpoRLI/5TT/fLF+noTuILh8DiOsTvgeSahzbicNyTXNd
         +W7jmy57Yj6Y2TAvpW+LYTRiime0LzklQvbs5U4gfE0tLUjK+nGLINYHJA+DtgTE0W7s
         W8i8vbkAGSRhaN0y+90YyzIOtWRJsr8s9y78HXggrXJyjFn04kVtxv5HfYtNd1VszpXo
         VgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717632103; x=1718236903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmBd4TBTVdAZlOWe2QN0nlhgeqjZ470lPTg1Yj5xMSg=;
        b=FOY25vEALs5LwWrhreUs8h5gSaOT6nEA9K0ncte7ViLJ2B/KtLs141Qyb6QFObtHD7
         1icIEmtDYq5ybUZVmaRbUUSGNB0aa0T3sT7/YGXluCu21Bm1MhuKZ9d7zPeTdjR1EmaZ
         FPC2oYIVu4Q8MyAOzFsc/2rhjtsjKSp4JYj78RUuzCOJ74mOTpFuHsCxAa8jHtlew7gK
         VytpbteCeMItavIzDUtvtjRaJ4TRBfPFj6S1wb/QKfg/5JMyhpFVdM3P2O5UADxkAfba
         AjCcBf0P4xHPKimD4d+p84ubC58QVbD9b6ZyADaI1cRroLSbo8H1X0Bha4eXWHXrZP2w
         Rbag==
X-Gm-Message-State: AOJu0YyegUXVnpVzNkZn+4nN0re2sjFJhXx7jVpEWPPCcEXxVOsjaD3B
	8uTPD8RjhYksvhCYB0BmPj1UKyz93CeLsnWrD1Q58b0ndkc5K9o3UBvlfTooLusRd5fmyIegky/
	2izojHdFie9A4o1agqDv4dMxDNRz1RQvArSfdhQ==
X-Google-Smtp-Source: AGHT+IG6IICf6mTVqLB93orADYYEOVxNKlJMd+eKfZHuB3dGiodlXANXWrNyQLOjhqIbklOO4rkMwE+AIB/9mOC0zmw=
X-Received: by 2002:a05:6214:588a:b0:6ab:9884:1a82 with SMTP id
 6a1803df08f44-6b030a9dc13mr38708276d6.51.1717632102803; Wed, 05 Jun 2024
 17:01:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605212146.994486-1-peterx@redhat.com>
In-Reply-To: <20240605212146.994486-1-peterx@redhat.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 5 Jun 2024 20:01:05 -0400
Message-ID: <CA+CK2bCCeamiaoTFybTd5nW39ixVPDM2gV2rMmK+2PfFAyE+9w@mail.gmail.com>
Subject: Re: [PATCH] mm/page_table_check: Fix crash on ZONE_DEVICE
To: Peter Xu <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 5:21=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> Not all pages may apply to pgtable check.  One example is ZONE_DEVICE
> pages: they map PFNs directly, and they don't allocate page_ext at all ev=
en
> if there's struct page around.  One may reference devm_memremap_pages().
>
> When both ZONE_DEVICE and page-table-check enabled, then try to map some
> dax memories, one can trigger kernel bug constantly now when the kernel w=
as
> trying to inject some pfn maps on the dax device:
>
>  kernel BUG at mm/page_table_check.c:55!
>
> While it's pretty legal to use set_pxx_at() for ZONE_DEVICE pages for pag=
e
> fault resolutions, skip all the checks if page_ext doesn't even exist in
> pgtable checker, which applies to ZONE_DEVICE but maybe more.

Thank you for reporting this bug. A few comments below:

>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/page_table_check.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index 4169576bed72..509c6ef8de40 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -73,6 +73,9 @@ static void page_table_check_clear(unsigned long pfn, u=
nsigned long pgcnt)
>         page =3D pfn_to_page(pfn);
>         page_ext =3D page_ext_get(page);
>
> +       if (!page_ext)
> +               return;

I would replace the above with the following, here and in other places:

if (!page_ext) {
  WARN_ONCE(!is_zone_device_page(page),
                          "page_ext is missing for a non-device page\n");
  return;
}

> +
>         BUG_ON(PageSlab(page));
>         anon =3D PageAnon(page);
>
> @@ -110,6 +113,9 @@ static void page_table_check_set(unsigned long pfn, u=
nsigned long pgcnt,
>         page =3D pfn_to_page(pfn);
>         page_ext =3D page_ext_get(page);
>
> +       if (!page_ext)
> +               return;
> +
>         BUG_ON(PageSlab(page));
>         anon =3D PageAnon(page);
>
> @@ -140,7 +146,10 @@ void __page_table_check_zero(struct page *page, unsi=
gned int order)
>         BUG_ON(PageSlab(page));
>
>         page_ext =3D page_ext_get(page);
> -       BUG_ON(!page_ext);
> +
> +       if (!page_ext)
> +               return;
> +
>         for (i =3D 0; i < (1ul << order); i++) {
>                 struct page_table_check *ptc =3D get_page_table_check(pag=
e_ext);
>
> --
> 2.45.0
>

