Return-Path: <linux-kernel+bounces-203512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37DB8FDC5B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 03:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C72B81C23861
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6347D171A7;
	Thu,  6 Jun 2024 01:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSuX9gwb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234F0623
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 01:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717638747; cv=none; b=UiA9KAVXWYmPxuVmK2ryqz63xsBQREM76ym0V34hvyHtYhNAcgtcpPv+a6nJ0qtuY2W3YFBtJE85PXnWE83eAqzVPE2Y4wrf+cN7CJeKT6QFrM6TQ2As+rFIGKW8VKZBECFWFxBHAbrT/ZI9kNZNp8TjuVuDqnjbCRgOlWL3kFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717638747; c=relaxed/simple;
	bh=tX9yrJbc8ty7d7Zfg70MPHzZODjknVGIO0Z8Ox9NU4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HTy8UwWCxPCFnhDlpofJaSHo0UBp+d0XIfvgj1OF9YEAg+E47IDejzAd67ITxpaGKSYQLmUIIZpTL7Op8RXfWZrPAp+8zpK4cza8x1egFqXYNN1TtqXWkmKPcjgUP9hneSBlmRNaa0N986BOHRQ8A8/+EBJJ3jHflQj3vhthAHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iSuX9gwb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717638745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xp+MGNVSlLui2uLO7pwydVnV86tn/dw5jvwhKRhoHdg=;
	b=iSuX9gwb0qY0oGvzJCz38QoqTwLrZy20iIzjLTV4pU3O0kmwVDIs9dN9uKng9Fh9CFQ8a6
	cOgVeFaZlSAwPMhp4spsrV4xiqLFUztSj0t9dBcfkQw2373tg5HYJADmZBHUoKi6Feo0No
	GFi/J9BSi2yiAKOdER2I/PjffXfp9eg=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-nYqttCgmOs-wqpCFjVi-xg-1; Wed, 05 Jun 2024 21:52:22 -0400
X-MC-Unique: nYqttCgmOs-wqpCFjVi-xg-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3748f3510b2so947235ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 18:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717638742; x=1718243542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xp+MGNVSlLui2uLO7pwydVnV86tn/dw5jvwhKRhoHdg=;
        b=WJIQPk/L2OlGz55C0TyuiGJ4Yd5Xp1zghz7NkhV1TUiBj1YvLq4FY5omyGCx6l2OPp
         7ru2ijC60TuwxFXiLR9FHA9CSnmjDzqWdqm6wF2NFqMSR3d/O0jz5/WbjAEB6WD8jbQY
         zRmlvuAavUm8o8Nx4ueYvK477Koq4BTR7VQ2wpQoTFkL2LZ/bkIjwVo+4A7OH+i3Knzc
         Dq5FPJJlKu35/CDSajTwQWYHfOsUvn9RMlBOzzqJyIwR/0nDwmAM1bxQ+/ipDqJrrLdY
         X/6suwvWlKcrm15dCZ/n8lMBui/Swwe/uIuDLWzLyCWiv1gA5JmuWftFPNDSzoDkAdHL
         wGfw==
X-Forwarded-Encrypted: i=1; AJvYcCXMyi9nkxcnb95T48WBp8zw/mkLNkNf594mbPIie6NSXKSLaNbcx3jwF11EP/lfzYN+gNK6zK2412Xk6BcsaREhgq56Is987LPfXh51
X-Gm-Message-State: AOJu0YxkB7OEJ5JGHxbiWx6ZW/zX52uI39rK/Ye4zpMpFCZM8TdSm5Tp
	a5aczDIDfAmE0dpBjjhN5AK/6sni5PO5mvldJtXrTnO3N+l0q0Y1/rDlmi/Fu9Ru47nfm6ZS+1q
	3DEtbCi2NjAAOpeqqbi2Agk6czVdjteDL4c5zJkdc1yZtKPjbmOgjg01UgXn70fdJovnDInZKu6
	db+g1sDj3phizGeQjPVUWK+iYwPFMziZkHmTk2
X-Received: by 2002:a05:6e02:2194:b0:374:a102:2948 with SMTP id e9e14a558f8ab-374b1f75c83mr44372815ab.3.1717638742058;
        Wed, 05 Jun 2024 18:52:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOj8R29jCyD6uOUyfLwEBMdBJR/YcAvObT1kSbriveNteQJnjE6dpOttRKqAAbOTQ16AYsTtRhV6iMhVxvGOw=
X-Received: by 2002:a05:6e02:2194:b0:374:a102:2948 with SMTP id
 e9e14a558f8ab-374b1f75c83mr44372615ab.3.1717638741676; Wed, 05 Jun 2024
 18:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com> <20240603165747.GGZl32C9yrmXJ4nhPT@fat_crate.local>
 <2343889c-887a-49ce-86df-343737d70d37@amd.com> <20240603171231.GJZl35f-BHvU2Pk3lb@fat_crate.local>
 <ff28e3ea-c492-4db6-8781-abaec6320756@amd.com> <CALu+AoQBXv-y43sx6E28UBVeVHUzRkWEzFxK6jsS5NpN2ho3YQ@mail.gmail.com>
 <CALu+AoTY2Xxs_vUzCyfsxtk-ov2mzJhzyTbbA9MYeeVkmKTMsw@mail.gmail.com>
 <CALu+AoSESmasAHqWdCGgQNbsTXfwbfhERBkaqSeaX881zqKtFg@mail.gmail.com>
 <41e085b8-2b45-40ab-9a6f-f4ad975a0b06@amd.com> <CALu+AoQ2jNjb+5MZfFtpT_Y=2gJRWwqEeWTpQkwNt0-U5fpO_w@mail.gmail.com>
 <20240605110904.GWZmBHUHSqCJVQYajF@fat_crate.local>
In-Reply-To: <20240605110904.GWZmBHUHSqCJVQYajF@fat_crate.local>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 6 Jun 2024 09:52:39 +0800
Message-ID: <CALu+AoRvNC9zMFwC+-T7eJDcTkPNUKPdsg5PNEJc11CVb22gUg@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
To: Borislav Petkov <bp@alien8.de>
Cc: ardb@kernel.org, dan.j.williams@intel.com, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Mike Rapoport <rppt@kernel.org>, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	rafael@kernel.org, hpa@zytor.com, peterz@infradead.org, 
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, 
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com, bhe@redhat.com, 
	kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com, 
	dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Jun 2024 at 19:09, Borislav Petkov <bp@alien8.de> wrote:
>
> Moving Ard and Dan to To:
>
> On Wed, Jun 05, 2024 at 10:28:18AM +0800, Dave Young wrote:
> > Ok, thanks!  I think the right way is creating two patches,  one to
> > remove the __efi_memmap_free,
>
> Yap, that
>
>   f0ef6523475f ("efi: Fix efi_memmap_alloc() leaks")
>
> needs revisiting.
>
> So AFAIU, the flow is this:
>
> In a kexec-ed kernel:
>
> 1. efi_arch_mem_reserve() gets called by bgrt, erst, mokvar... whatever
>    to hold on to boot services regions for longer otherwise EFI
>    "implementations" explode.
>
> 2. On same kexec-ed kernel, we call into kexec_enter_virtual_mode()
>    because it needs to get the runtime services regions from the first
>    kernel
>
> 3. As part of that call, it'll do
>    efi_memmap_init_late->__efi_memmap_init():
>
>         if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB))
>                 __efi_memmap_free(efi.memmap.phys_map,
>
> and the memory which got allocated in step 1 is gone, thus reverting
> what efi_arch_mem_reserve() is trying to fix.
>
> IOW, we need a
>
>         EFI_MEMMAP_DO_NOT_TOUCH_MY_MEMORY
>
> flag which'll stop this from happening. But I'd prefer it if Ard decides
> what the right thing to do here is.
>
> > another is  skip efi_arch_mem_reserve when the EFI_MEMORY_RUNTIME bit
> > was set already.
>
> Can that even happen?

Yes, let's say we have two different cases both go through
drivers/firmware/efi/efi-bgrt.c -> efi_mem_reserve ->
efi_arch_mem_reserve
1. normal boot (non kexec-ed)
    The bgrt region is reserved and mark as EFI_MEMORY_RUNTIME with a
new efi mem range which is inserted in the memmap, later kexec will
carry over to 2nd kernel (drop those boot service areas without
EFI_MEMORY_RUNTIME)
2. kexec-ed boot
     In the same call path, the previous kernel saved bgrt region has
already set EFI_MEMORY_RUNTIME, but it is re-reserved with a new mem
entry in memmap, this is not necessary and duplicate.   I did not
check the efi boot code if it will de-duplicate the memmap later, but
anyway this is useless and it should be skipped.

Thanks
Dave


