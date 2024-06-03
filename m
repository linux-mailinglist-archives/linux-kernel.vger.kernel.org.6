Return-Path: <linux-kernel+bounces-198586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0510A8D7AB2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6911C1F214B4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 04:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A942717BD9;
	Mon,  3 Jun 2024 04:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBreszqM"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F1FFBED
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 04:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717388093; cv=none; b=aTHYQfwOM+kqJfuojB4Dgc5VnZA3Ko4DsNge4+iVTQWcYZzq9OYF5vJoCxSh+IjBi0JV9t8TaastNQAEunKHG4Ny9rGoqbQhsbVPm0yLJbrZxQv7rgNQ2KHTuvZAy99Hi9O0NzEbsYYAueWLKKzpCVJAPDkWKf7xORrulfKcNEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717388093; c=relaxed/simple;
	bh=ro04c903RGHhJAmvX5qSgJte8QuVia2PD7ELZhY2L9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqGz34ThEGTSNTjQn0Adf1PYqKjdF7Gu0PEgS1SAeEMcGtmxwBmLqcxH/oUevFXcVGei4GaficJqzvcQWXUeQ/lZOR4YkW+/qIb2J3LRehZrCKpf4K56bz5Og6Tt1mkw2lKmODgMDBcMbHF3SVvuj5qx9eLD5MfsCwCFky2UwyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBreszqM; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-808c613ade5so1326314241.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 21:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717388091; x=1717992891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37IZQZABDOiNZeyUDyoueBUnQROigeKCbWesRBDqED0=;
        b=OBreszqMh6Sk9dwskOg43wtVVh1VwqOqrh+29NZKbEP00ZstJGutLBCF3MPpGELhco
         lgc9+e3D6xBbUfa+MOthJ5P0jg+8IhrcU/sVW0qJ4Y51Vt8XH/M+CzuzHWs023DWJEnI
         QxjoHHWLRs2Nz24YQZLUxca5ZJDtnZyOWdQ847n1D4dnUijPpWC0BjVXK3ZZIblTraIh
         yPVdDenfP6bd+yMwEdYLKuExWZr40iVv8Rps+LR0shLapNTNfxWGEJat/oQ3BxdwB0Tw
         k33OM+j8Mp/4qEXR/tcWxaJmTEr8PKTNSgykPfEZSwp/Zv/6Bct2+PKQJ/rZKv4xV6On
         827g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717388091; x=1717992891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37IZQZABDOiNZeyUDyoueBUnQROigeKCbWesRBDqED0=;
        b=cuOH9E8jljg4qeUyWalM4KRbipS8Bxozzy19m8RqEkPvcB7VXhR6Lh2+JGFy97DjHF
         zFrWVSBiKE3tQ3flMm1tM52yef5bHXZyEUsoFXei4kT3vnNIr6vEx/04GQUXw/xzuDgp
         pDIUq27HsP3Z73abH/0Km7dYpjIrfrfs5JMdCGVPi45h35vUYYsYjhTYSrfGMvGdMsnJ
         mUfvJazmR+51ttoFKnUOfGOWC2+sD4zfFGxEo0ohjQVmZLReBhDMy0dNUIxMhhIwQra3
         7xaY5Rr8dcO/AsncPEutBcd+etJpSwhY1YxKgr5ePcsnEXez0jwPhrWdAZZfoCZ/AjEe
         ngOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRTpFoFnrVB3ZjSceTmger9O408QvK5EJhen991W34FdrqfxM7er1kwxDl4r89WDdwoZe1bb4g/VxskNODFhAdI+ZPWRxRIUcitO2Y
X-Gm-Message-State: AOJu0YyzqSAU+QfZbMf6IQHtTyOegs6tU/54Gw2FjLm9T0d8kC3BQLXw
	ukd0TRWOIxkGLvZ7DCMh3PIoKF8AX2ETh8NjjLMBmETbPMvwqT+XFlbeoHlYs6xl7AsftqCzJU9
	R1P8FzVwekuAckJ5DgGdl1+NKwfw=
X-Google-Smtp-Source: AGHT+IHLgm5hHl+4guZ+jWuNcHq4/8HeEKFBWSVNOcnSXqXSHICiDXYna8aTf1gin+ISl2r1exDJw1ciwMTphRosYh0=
X-Received: by 2002:a05:6102:354a:b0:48b:932a:9603 with SMTP id
 ada2fe7eead31-48bc207ea8fmr7951260137.1.1717388091342; Sun, 02 Jun 2024
 21:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603033118.76457-1-ioworker0@gmail.com>
In-Reply-To: <20240603033118.76457-1-ioworker0@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 3 Jun 2024 16:14:39 +1200
Message-ID: <CAGsJ_4wxPk+bk9UM+PvA3x=LJG+mWmTD3e2HSEsS83X3vMWTJQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/mlock: implement folio_mlock_step() using folio_pte_batch()
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com, 
	baolin.wang@linux.alibaba.com, ziy@nvidia.com, fengwei.yin@intel.com, 
	ying.huang@intel.com, libang.li@antgroup.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 3:31=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wro=
te:
>
> Let's make folio_mlock_step() simply a wrapper around folio_pte_batch(),
> which will greatly reduce the cost of ptep_get() when scanning a range of
> contptes.
>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  mm/mlock.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 30b51cdea89d..1ae6232d38cf 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -307,26 +307,15 @@ void munlock_folio(struct folio *folio)
>  static inline unsigned int folio_mlock_step(struct folio *folio,
>                 pte_t *pte, unsigned long addr, unsigned long end)
>  {
> -       unsigned int count, i, nr =3D folio_nr_pages(folio);
> -       unsigned long pfn =3D folio_pfn(folio);
> -       pte_t ptent =3D ptep_get(pte);
> -
> -       if (!folio_test_large(folio))
> +       if (likely(!folio_test_large(folio)))
>                 return 1;
>
> -       count =3D pfn + nr - pte_pfn(ptent);
> -       count =3D min_t(unsigned int, count, (end - addr) >> PAGE_SHIFT);
> -
> -       for (i =3D 0; i < count; i++, pte++) {
> -               pte_t entry =3D ptep_get(pte);
> -
> -               if (!pte_present(entry))
> -                       break;
> -               if (pte_pfn(entry) - pfn >=3D nr)
> -                       break;
> -       }
> +       const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRT=
Y;
> +       int max_nr =3D (end - addr) / PAGE_SIZE;
> +       pte_t ptent =3D ptep_get(pte);
>
> -       return i;
> +       return folio_pte_batch(folio, addr, pte, ptent, max_nr, fpb_flags=
, NULL,
> +                              NULL, NULL);
>  }

what about a minimum change as below?
index 30b51cdea89d..e8b98f84fbd2 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -307,26 +307,15 @@ void munlock_folio(struct folio *folio)
 static inline unsigned int folio_mlock_step(struct folio *folio,
                pte_t *pte, unsigned long addr, unsigned long end)
 {
-       unsigned int count, i, nr =3D folio_nr_pages(folio);
-       unsigned long pfn =3D folio_pfn(folio);
+       unsigned int count =3D (end - addr) >> PAGE_SHIFT;
        pte_t ptent =3D ptep_get(pte);
+       const fpb_t fpb_flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;

        if (!folio_test_large(folio))
                return 1;

-       count =3D pfn + nr - pte_pfn(ptent);
-       count =3D min_t(unsigned int, count, (end - addr) >> PAGE_SHIFT);
-
-       for (i =3D 0; i < count; i++, pte++) {
-               pte_t entry =3D ptep_get(pte);
-
-               if (!pte_present(entry))
-                       break;
-               if (pte_pfn(entry) - pfn >=3D nr)
-                       break;
-       }
-
-       return i;
+       return folio_pte_batch(folio, addr, pte, ptent, count, fpb_flags, N=
ULL,
+                              NULL, NULL);
 }



>
>  static inline bool allow_mlock_munlock(struct folio *folio,
> --
> 2.33.1
>

