Return-Path: <linux-kernel+bounces-211353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE44905081
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D8F282395
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62C916EBF3;
	Wed, 12 Jun 2024 10:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gnb14Iib"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9243A763E6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718188605; cv=none; b=RYvTeD9a71EwNxt0XCS/tkfLV7Cqh24fvNHBaSOGoScoWFS1kA8s4DSSPtYBCH5dBJsE0/9y6sVh/5qxwjF1LSfya5iJWjiIfnqXZeAV2SkNeW7RllU4pcejwHVmWHsTOtTWslw2vdtbWyIXYp2h0sCSEhSIAnfDjnkJ3O54i2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718188605; c=relaxed/simple;
	bh=xUsEv98p16mJkz5Y3mLOBoP+P8rFAVzHnMhx4a/MQE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4YPg1Jp32MgaHmbZduHMNntaHqDfSLrhh4WfsHsV69azZIDtN7ZsMnMWva3cy/vybmzDHRv+pRnBQdHH9+yGSGjZCNG1HkDUjqzEhZ4EP1A8HILXFtALC4QrxQaPnf7AG6XpxqO2ed0fbV2JVSdqGOgf2c0UxyvSBryi4bYXX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gnb14Iib; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718188602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VOmfsQaL4/TTB/7eRooNrD2j23r3IPrqMRvbs+Hbk8=;
	b=Gnb14IibbBu3S0wf4WPi6H7HQR3n07CE6K7hAxle770MwuGCjCQ9VtyJpdjbc5DDLoCmoa
	5XKy1nnONUGKX3TlCgPPPrWeNu6ilbZTxUQsqnskXfEkRthj1WpJ5u4kski+JETRqigfB9
	nbuCWzQ1GUKTg2pxMEslN7cX2rLSPCU=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-ANJb1XfNPQeIFEnJqZUznQ-1; Wed, 12 Jun 2024 06:36:40 -0400
X-MC-Unique: ANJb1XfNPQeIFEnJqZUznQ-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-375a21927d5so7215125ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718188600; x=1718793400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VOmfsQaL4/TTB/7eRooNrD2j23r3IPrqMRvbs+Hbk8=;
        b=Taju3BaIQInRFrhnS9ec/e2rUJWOL0Q2XxOfdHIazYaKWI6imxr8eF9buxmSqEL+Hf
         f53vEXWRoHm6w4qlaDxJjMc40uN9vXwCdoO1+PZ0Oi29mfp39LMDUDvvT4nyLjGXQ4c6
         5svtAowCd73GBL905otrGE4oIAbgObFtZchbwWkXptMh/8wTn3lrdUFwQlOf5ms+5g2Y
         lqfhZRtxnjac3mz210qAtZfz+dXWZFFmFblKEKc0nkf8LHK8gSNiQrGCUoOPR5JJTRZL
         FLr8TRSVN9kn6E1vyYBEp3OAlP3ayePpl4oL8oIFXXNBKPtj1BbN0L47I3zwfVntB9ff
         1YSw==
X-Forwarded-Encrypted: i=1; AJvYcCU27XlKzJXfHnvTSa51mL9Fgm7UBoajqQFBjgdPC05yEHHC3mtvAEIXnxJ1QbkMTz0wJce83//NpJiBf6x26zfXacQlSd5SqozKA2nS
X-Gm-Message-State: AOJu0Yw4uNAofitLoC/d7xc1KVYQLLywdv+v+bD2yKYGtvSY/xwNzsm9
	DSJnCvQTUQIarLLDBEAy/UayA4Nl7q4EhSsxBKSRUuS4YpzXrgGBNukANQT53SPMJFxWcW3gXFm
	uC8JmOhquLz2HjtSPkBHvMAIB9j4bNhxGmkEtkli0D2bygOHItYw1dHf7yEU+BUNmtupQYI83lp
	MZq9TyewdVNIhvxPT6Gf1bKD6dhCHcjx1QAAfo
X-Received: by 2002:a05:6e02:164b:b0:375:9f41:f541 with SMTP id e9e14a558f8ab-375cd03c7a0mr15063245ab.0.1718188599837;
        Wed, 12 Jun 2024 03:36:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG3WQ6DRq58t0uIz6LZ4vNEA6l7etlkFjRbiRpbh3CI+3W8VrwE7Gzq/cyKlwp6OShC16WZkWPlFUI3WHT59c=
X-Received: by 2002:a05:6e02:164b:b0:375:9f41:f541 with SMTP id
 e9e14a558f8ab-375cd03c7a0mr15063015ab.0.1718188599428; Wed, 12 Jun 2024
 03:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610140932.2489527-2-ardb+git@google.com>
In-Reply-To: <20240610140932.2489527-2-ardb+git@google.com>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 12 Jun 2024 18:36:56 +0800
Message-ID: <CALu+AoREA7f=UBrmbvH92nDp66LyB99QEu84e_8HSurnjLqdUw@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Free EFI memory map only when installing a new one.
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Ashish Kalra <Ashish.Kalra@amd.com>, Mike Rapoport <rppt@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Jun 2024 at 22:09, Ard Biesheuvel <ardb+git@google.com> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The logic in __efi_memmap_init() is shared between two different
> execution flows:
> - mapping the EFI memory map early or late into the kernel VA space, so
>   that its entries can be accessed;
> - cloning the EFI memory map in order to insert new entries that are
>   created as a result of creating a memory reservation
>   (efi_arch_mem_reserve())
>
> In the former case, the underlying memory containing the kernel's view
> of the EFI memory map (which may be heavily modified by the kernel
> itself on x86) is not modified at all, and the only thing that changes
> is the virtual mapping of this memory, which is different between early
> and late boot.
>
> In the latter case, an entirely new allocation is created that carries a
> new, updated version of the kernel's view of the EFI memory map. When
> installing this new version, the old version will no longer be
> referenced, and if the memory was allocated by the kernel, it will leak
> unless it gets freed.
>
> The logic that implements this freeing currently lives on the code path
> that is shared between these two use cases, but it should only apply to
> the latter. So move it to the correct spot.
>
> Cc: Ashish Kalra <Ashish.Kalra@amd.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Link: https://lore.kernel.org/all/36ad5079-4326-45ed-85f6-928ff76483d3@amd.com
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/platform/efi/memmap.c | 5 +++++
>  drivers/firmware/efi/memmap.c  | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/platform/efi/memmap.c b/arch/x86/platform/efi/memmap.c
> index 4ef20b49eb5e..4990244e5168 100644
> --- a/arch/x86/platform/efi/memmap.c
> +++ b/arch/x86/platform/efi/memmap.c
> @@ -97,6 +97,11 @@ int __init efi_memmap_install(struct efi_memory_map_data *data)
>         if (efi_enabled(EFI_PARAVIRT))
>                 return 0;
>
> +       if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB))
> +               __efi_memmap_free(efi.memmap.phys_map,
> +                                 efi.memmap.desc_size * efi.memmap.nr_map,
> +                                 efi.memmap.flags);
> +
>         return __efi_memmap_init(data);

Nice fix!  but would it be better to save the old addr/size/flag and
free them only when __efi_memmap_init succeed?


>  }
>
> diff --git a/drivers/firmware/efi/memmap.c b/drivers/firmware/efi/memmap.c
> index 3365944f7965..3759e95a7407 100644
> --- a/drivers/firmware/efi/memmap.c
> +++ b/drivers/firmware/efi/memmap.c
> @@ -51,11 +51,6 @@ int __init __efi_memmap_init(struct efi_memory_map_data *data)
>                 return -ENOMEM;
>         }
>
> -       if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB))
> -               __efi_memmap_free(efi.memmap.phys_map,
> -                                 efi.memmap.desc_size * efi.memmap.nr_map,
> -                                 efi.memmap.flags);
> -
>         map.phys_map = data->phys_map;
>         map.nr_map = data->size / data->desc_size;
>         map.map_end = map.map + data->size;
> --
> 2.45.2.505.gda0bf45e8d-goog
>


