Return-Path: <linux-kernel+bounces-553826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF9FA58F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CECC188FADF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C989224896;
	Mon, 10 Mar 2025 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUE2Jbrw"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4B9170826
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598424; cv=none; b=kfvZqtkC06KDqHzs6WU0pUYBdOWrUGUiPEqn0WTKqhvDSLnOc7HJMk6JWjumrZuKKX+sncOrIo7D5k5GptxmapZP5p5C9M1sScIxRUQVYTckkPpU/OvCjXpqkIBUPojPFiIjxQpGW0Vb7Qlxg7ZoxPocrfTS/pOJYLU/ULGltOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598424; c=relaxed/simple;
	bh=d1VfH95fmhrWSe/9MNq2nxfzB3e9yCNC+a/VqQme3Rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTmjtdn/+W9OhEA7mPS1DtgLN1g5dSoJ0UJRjiJarvGyFlJQXLolUtGtSJsHhymGYwpibi39ffEeNc9gHaDL2jexLMeligCpWMQjDL7bkdkWmjj8lhSSsEjPFzEVQWeNOxc2khEVLIe4gM2fQUgL9FyBicSViBOlGs//k/eOQ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUE2Jbrw; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5fe86c16f5dso1860376eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741598422; x=1742203222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8hUQaBWntrhNATBo5/FEWJXi4nQQHSzEudgTZIuU8Y=;
        b=IUE2Jbrws24qt1W2osBcsy0+XcVcClVYBOY+RASkra0q7GEmVgmjadOZi3O511AAIf
         LhUCCa2bPVn8iI4YI9RY7mVN1Sh+f6gj0CHAMxLf1eOjwgENErfllZFVTw9Et5Gb45al
         J17GcZTXTq5NwryaPavxzfqSwH7OAdI6v9tHgvw6LMkbjR4JZAi4BUxlO/AiyNzZEN5h
         syMn2vSTohLZx+N8M0D8qT9dZrSVvyEnW6JbxwZ4DjOLP168TLmOax0ocnqGJEc8UtuK
         Bs/UYj8fn77zrI4gPoaDnHiiUlIGF0PX54xJ1ny6fUMn1a1iPlQrA6wEeNMme9oBJfBL
         JXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741598422; x=1742203222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8hUQaBWntrhNATBo5/FEWJXi4nQQHSzEudgTZIuU8Y=;
        b=vV6F/OiVnYC4auTOoQYPYE5bbPqPJ9lrNhMbyXkthLm1XU0zm40esir6wt8WyUSpiH
         Uus10xBjOT4C8TsX4BNfBsh/xyhl/8tj3N71bC9DAkT4hQGVBCqxsYnTDQB56ZJv0Y/W
         /mhYgwcx/T5juCMd5JHLkI1RX9z0RHPDm6BAxO1BOR1BS5e/Qs+jSSfsjo545VHwZpft
         PsH+p6p2v/yViXQe65Rs27pm0lt0geS8nTIGwXRpPC/aSkk2HXGsCfGzYWO8UdaorEbT
         o+ObVR5aaJzR//QR4M4VAIqpPMND7Mm4wyz3EvFO/j5dvzGiWUsAgFe3bmTP0HcccIGs
         z0Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXqTxYNsl6aoST+um1OiTEXUATO0x4lrmP4eZpkA8FPrUTeDNNs15ophG5sE/+0TV441jzfavTDa+l+AtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXJx65nmS4aIafHGUXMEPDA3k9PT3P7cjzeI1bHGgZ3aKaKdbx
	5ZcyQxntFEp+x5xIddYFpbmEEDRYnSs6clNcEuACX4P0o7F9rr0bTAYDrUdy3towe7uslSlCoKQ
	RatNjTNYdYbPNoWQKlqPSsgv0KGs=
X-Gm-Gg: ASbGncu23wOmLQL37X7whkJxLMu5sZnRQ7HIRE8Xc/3L+/KxZfnp8rrCH1tZgHEJA4g
	OjqrvvLe/PRJ7PrBma0xwmz2QfY85T07xdSENOu+v3czrMshcQBtZCnjRFrH+8tvbQF8zxEPZKA
	viiPsyS8Irvb2u5m7EnMhR14hS
X-Google-Smtp-Source: AGHT+IHlKpNfQ17CORnW4feh4HgPSN5pa0orUf1ds4fgLmew9uDRmnDx96KaSR7W3sZokTY2X/z3FM4DkSrPCJkR7WI=
X-Received: by 2002:a05:6820:992:b0:5fd:50d:49e4 with SMTP id
 006d021491bc7-6004abd3116mr6176682eaf.7.1741598422280; Mon, 10 Mar 2025
 02:20:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308234428.255164-1-linux@treblig.org>
In-Reply-To: <20250308234428.255164-1-linux@treblig.org>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Mon, 10 Mar 2025 10:20:11 +0100
X-Gm-Features: AQ5f1JryzndsgFb-pSg_WhcxWTfnaRxcwrsJfnmRRQa8SA2TF1cLJDFDoCtLJEM
Message-ID: <CAMeQTsYGbFZbx7oG5x2R0mLsyFFbEwOGowDrKghjZCopaZsyrw@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: Remove unused psb_mmu_virtual_to_pfn
To: linux@treblig.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 12:44=E2=80=AFAM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> psb_mmu_virtual_to_pfn() was added in 2011 by
> commit 8c8f1c958ab5 ("gma500: introduce the GTT and MMU handling logic")
> but hasn't been used.
>
> Remove it.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Applied to drm-misc-next
Thanks

> ---
>  drivers/gpu/drm/gma500/mmu.c | 41 ------------------------------------
>  drivers/gpu/drm/gma500/mmu.h |  2 --
>  2 files changed, 43 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
> index 4d78b33eaa82..e6753282e70e 100644
> --- a/drivers/gpu/drm/gma500/mmu.c
> +++ b/drivers/gpu/drm/gma500/mmu.c
> @@ -730,44 +730,3 @@ int psb_mmu_insert_pages(struct psb_mmu_pd *pd, stru=
ct page **pages,
>
>         return ret;
>  }
> -
> -int psb_mmu_virtual_to_pfn(struct psb_mmu_pd *pd, uint32_t virtual,
> -                          unsigned long *pfn)
> -{
> -       int ret;
> -       struct psb_mmu_pt *pt;
> -       uint32_t tmp;
> -       spinlock_t *lock =3D &pd->driver->lock;
> -
> -       down_read(&pd->driver->sem);
> -       pt =3D psb_mmu_pt_map_lock(pd, virtual);
> -       if (!pt) {
> -               uint32_t *v;
> -
> -               spin_lock(lock);
> -               v =3D kmap_atomic(pd->p);
> -               tmp =3D v[psb_mmu_pd_index(virtual)];
> -               kunmap_atomic(v);
> -               spin_unlock(lock);
> -
> -               if (tmp !=3D pd->invalid_pde || !(tmp & PSB_PTE_VALID) ||
> -                   !(pd->invalid_pte & PSB_PTE_VALID)) {
> -                       ret =3D -EINVAL;
> -                       goto out;
> -               }
> -               ret =3D 0;
> -               *pfn =3D pd->invalid_pte >> PAGE_SHIFT;
> -               goto out;
> -       }
> -       tmp =3D pt->v[psb_mmu_pt_index(virtual)];
> -       if (!(tmp & PSB_PTE_VALID)) {
> -               ret =3D -EINVAL;
> -       } else {
> -               ret =3D 0;
> -               *pfn =3D tmp >> PAGE_SHIFT;
> -       }
> -       psb_mmu_pt_unmap_unlock(pt);
> -out:
> -       up_read(&pd->driver->sem);
> -       return ret;
> -}
> diff --git a/drivers/gpu/drm/gma500/mmu.h b/drivers/gpu/drm/gma500/mmu.h
> index d4b5720ef08e..e6d39703718c 100644
> --- a/drivers/gpu/drm/gma500/mmu.h
> +++ b/drivers/gpu/drm/gma500/mmu.h
> @@ -71,8 +71,6 @@ extern int psb_mmu_insert_pfn_sequence(struct psb_mmu_p=
d *pd,
>                                        uint32_t start_pfn,
>                                        unsigned long address,
>                                        uint32_t num_pages, int type);
> -extern int psb_mmu_virtual_to_pfn(struct psb_mmu_pd *pd, uint32_t virtua=
l,
> -                                 unsigned long *pfn);
>  extern void psb_mmu_set_pd_context(struct psb_mmu_pd *pd, int hw_context=
);
>  extern int psb_mmu_insert_pages(struct psb_mmu_pd *pd, struct page **pag=
es,
>                                 unsigned long address, uint32_t num_pages=
,
> --
> 2.48.1
>

