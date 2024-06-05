Return-Path: <linux-kernel+bounces-201654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF848FC166
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665831F22B4A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6724B5380F;
	Wed,  5 Jun 2024 01:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wf7D3oIc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88059B67A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 01:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717552097; cv=none; b=Ag4bu4sa2WMh1GEdCK3Bo1izqBFjj1zpHc3+2LIzjsWJ0oWKmDb6MCBJWGqiFCp3szhCWTCOM3T+EB7u5P0jp5/LMRJ/7DcqBJruNCuAFif+7H+lPi9aEKeMTZS/RfgiDjPBhtZPzNrqK/I3ISsXYJCuZAPfRtl3z0yxkD5ffa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717552097; c=relaxed/simple;
	bh=FHgVL0KN0Z8vFQ8k0X2nt1lxyb9aBllOgIKRtQ75d04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDx9CIF9ASxeFEJu2N7xFPG5zAxdsOcqjYmRdmdvxdiIi64ELv2sKHHWfL4D52b1BCq7JFX6LKlOCvxm8ACBjTcPhtziFr/30CXWXzlmwwrU7dRvVYUlFM/XhC2z2zLMe3l1MguRBDpYvlX+HZXh/Td/3pRLjxdLIurDH0jvGZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wf7D3oIc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717552094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tgHDm/WuX5wu8O8crNlAs4XjHwwaf5FS68CVvGmTwCU=;
	b=Wf7D3oIcBtf7moaEEcf+J+ISHM+MZ20qTvcNtEvYTwl0W596DfCBsOHr5J53/WoTgZ9zeF
	0OqK2vUzevmsjVMSeu2YciI9PqBP5z7jkcZHQzfZylCKsAmPPJs6bBQxjZSDJL67iul17X
	5ZhNG8TYtqAYz1p7gGYShagZd2jbCXI=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-hLINPGmdOYOIlkqoKEIiVg-1; Tue, 04 Jun 2024 21:48:13 -0400
X-MC-Unique: hLINPGmdOYOIlkqoKEIiVg-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e97da51ef0so99724139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 18:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717552092; x=1718156892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgHDm/WuX5wu8O8crNlAs4XjHwwaf5FS68CVvGmTwCU=;
        b=w1sW3rtYyW55jc0No35lbxu4lRuhF27Coeky7brWpx68M3jPAfzt/2SOIFUTjFMZqq
         G526G2cqGxHbzYYyCrlIjdeWBtYdbq/QOKs6a/vyqaB4FzffvgPuuANkdLDyZGajMtrs
         zVIdJgTr9NIEUx3PCsYgqnos2gzrrGM7uzfpqrmJoGWS2PhzvM4bHt5bOBc2F8OzR1yV
         /VUxLLyafk3dyd3w2OJc+cQKY3W9dP0WEkaH6srbtYV0SNamVweO0mst3T3NRGtX3gRT
         0KuQpQj7g8FPgp7tmHLyjux10lnmXfK55a4+5t+VWFpw5wrqhl2EqWXps54lMs5/uEh2
         f29Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRqyp6vxXcibdVkPYl+Ff9E8jWHvmf9ceor3ZMufyevr5YNO8Gi7lsICk/TSzG3YaBgVjPonsZh5zW6F4E/GOe1ZsV1Mu5c2fyZEug
X-Gm-Message-State: AOJu0Yyct5Neh4nolgK1EpEdy+eCJV28U0UtnVIfDmCfn2spuLCe2x9I
	pBzUtjjhVNqRppzIqOFl0oStdB7Z+CQZHSuBjO0yoepTiTdG59sj/EgRDxAPUItgySqjaocxcCv
	+AUMhGFfeyr6cwmdoEzFpVko48B6+gfbLcdRil5bEu03KwZg060S+20llAESmp3/V5V6jii378n
	1taHcGuZo/QqrZIOn6/8m8AitygbqERJ8x7EsD
X-Received: by 2002:a92:c262:0:b0:374:a021:f1a7 with SMTP id e9e14a558f8ab-374b1f3e6a6mr12844085ab.2.1717552092098;
        Tue, 04 Jun 2024 18:48:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPrmPkKSu7/bxuxQb+vlDcaLfqSrYDwnUemokY5ej5EoiQIxPBQbV1auEQzBdw6MeFuxEabhfdUThXIdgkd3I=
X-Received: by 2002:a92:c262:0:b0:374:a021:f1a7 with SMTP id
 e9e14a558f8ab-374b1f3e6a6mr12843705ab.2.1717552091682; Tue, 04 Jun 2024
 18:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local> <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org> <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local> <Zl3hwYL2GDiyUfGo@kernel.org>
 <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com> <20240603165747.GGZl32C9yrmXJ4nhPT@fat_crate.local>
 <2343889c-887a-49ce-86df-343737d70d37@amd.com> <20240603171231.GJZl35f-BHvU2Pk3lb@fat_crate.local>
 <ff28e3ea-c492-4db6-8781-abaec6320756@amd.com>
In-Reply-To: <ff28e3ea-c492-4db6-8781-abaec6320756@amd.com>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 5 Jun 2024 09:48:30 +0800
Message-ID: <CALu+AoQBXv-y43sx6E28UBVeVHUzRkWEzFxK6jsS5NpN2ho3YQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Mike Rapoport <rppt@kernel.org>, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, rafael@kernel.org, hpa@zytor.com, 
	peterz@infradead.org, adrian.hunter@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com, 
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, michael.roth@amd.com, 
	seanjc@google.com, kai.huang@intel.com, bhe@redhat.com, 
	kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com, 
	dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de, ardb@kernel.org, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Jun 2024 at 06:36, Kalra, Ashish <ashish.kalra@amd.com> wrote:
>
> Re-sending as the earlier response got line-wrapped.
>
> On 6/3/2024 12:12 PM, Borislav Petkov wrote:
> > On Mon, Jun 03, 2024 at 12:08:48PM -0500, Kalra, Ashish wrote:
> >> efi_arch_mem_reserve().
> > Now it only remains for you to explain why...
>
> Here is a detailed explanation of what is causing the EFI memory map corruption, with added debug logs and memblock debugging enabled:
>
> Initially at boot, efi_memblock_x86_reserve_range() does early_memremap() of the EFI memory map passed as part of setup_data, as the following logs show:
>
> ...
>
> [ 0.000000] efi: in efi_memblock_x86_reserve_range, phys map 0x27fff9110
> [ 0.000000] memblock_reserve: [0x000000027fff9110-0x000000027fffa12f] efi_memblock_x86_reserve_range+0x168/0x2a0
>
> ...
>
> Later, efi_arch_mem_reserve() is invoked, which calls efi_memmap_alloc() which does memblock_phys_alloc() to insert new EFI memory descriptor into efi.memap:
>
> ...
>
> [ 0.733263] memblock_reserve: [0x000000027ffcaf80-0x000000027ffcbfff] memblock_alloc_range_nid+0xf1/0x1b0
> [ 0.734787] efi: efi_arch_mem_reserve, efi phys map 0x27ffcaf80
>
> ...
>
> Finally, at the end of boot, kexec_enter_virtual_mode() is called.
>
> It does mapping of efi regions which were passed via setup_data.
>
> So it unregisters the early mem-remapped EFI memmap and installs the new EFI memory map as below:
>
> ( Because of efi_arch_mem_reserve() getting invoked, the new EFI memmap phys base being remapped now is the memblock allocation done in efi_arch_mem_reserve()).
>
> [ 4.042160] efi: efi memmap phys map 0x27ffcaf80
>
> So, kexec_enter_virtual_mode() does the following :
>
>         if (efi_memmap_init_late(efi.memmap.phys_map, <- refers to the new EFI memmap phys base allocated via memblock in efi_arch_mem_reserve().
>                 efi.memmap.desc_size * efi.memmap.nr_map)) { ...
>
> This late init, does a memremap() on this memblock-allocated memory, but then immediately frees it :
>
> drivers/firmware/efi/memmap.c:
>
> int __init __efi_memmap_init(struct efi_memory_map_data *data)
> {
>
>         ..
>
>         phys_map = data->phys_map; <- refers to the new EFI memmap phys base allocated via memblock in efi_arch_mem_reserve().
>
>         if (data->flags & EFI_MEMMAP_LATE)
>                 map.map = memremap(phys_map, data->size, MEMREMAP_WB);
>         ...
>         ...
>         if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB)) {
>                 __efi_memmap_free(efi.memmap.phys_map,
>                                 efi.memmap.desc_size * efi.memmap.nr_map, efi.memmap.flags);
>         }

From your debugging the memmap should not be freed.  This piece of
code was added in below commit,  added Dan Williams in cc list:
commit f0ef6523475f18ccd213e22ee593dfd131a2c5ea
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Mon Jan 13 18:22:44 2020 +0100

    efi: Fix efi_memmap_alloc() leaks

    With efi_fake_memmap() and efi_arch_mem_reserve() the efi table may be
    updated and replaced multiple times. When that happens a previous
    dynamically allocated efi memory map can be garbage collected. Use the
    new EFI_MEMMAP_{SLAB,MEMBLOCK} flags to detect when a dynamically
    allocated memory map is being replaced.


>
>         ...
>         map.phys_map = data->phys_map;
>
>         ...
>
>         efi.memmap = map;
>
>         ...
>
> This happens as kexec_enter_virtual_mode() can only handle the early mapped EFI memmap and not the one which is memblock allocated by efi_arch_mem_reserve(). As seen above this memblock allocated (EFI_MEMMAP_MEMBLOCK tagged) memory gets freed.
>
> This is confirmed by memblock debugging:
>
> [ 4.044057] memblock_free_late: [0x000000027ffcaf80-0x000000027ffcbfff] __efi_memmap_free+0x66/0x80
>
> So while this memory is memremapped, it has also been freed and then it gets into a use-after-free condition and subsequently gets corrupted.
>
> This corruption is seen just before kexec-ing into the new kernel:
>
> ...
> [   11.045522] PEFILE: Unsigned PE binary^M
> [   11.060801] kexec-bzImage64: efi memmap phys map 0x27ffcaf80^M
> ...
> [   11.061220] kexec-bzImage64: mmap entry, type = 11, va = 0xfffffffeffc00000, pa = 0xffc00000, np = 0x400, attr = 0x8000000000000001^M
> [   11.061225] kexec-bzImage64: mmap entry, type = 6, va = 0xfffffffeffb04000, pa = 0x7f704000, np = 0x84, attr = 0x800000000000000f^M
> [   11.061228] kexec-bzImage64: mmap entry, type = 4, va = 0xfffffffeff700000, pa = 0x7f100000, np = 0x300, attr = 0x0^M
> [   11.061231] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M <- CORRUPTION!!!
> [   11.061234] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061236] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061239] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061241] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061243] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061245] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061248] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061250] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061252] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061255] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061257] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061259] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061262] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061264] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061266] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061268] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061271] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061273] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061275] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061278] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061280] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061282] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061284] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061287] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061289] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061291] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061294] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061296] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061298] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061301] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061303] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061305] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061307] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061310] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061312] kexec-bzImage64: mmap entry, type = 0, va = 0x0, pa = 0x0, np = 0x0, attr = 0x0^M
> [   11.061314] kexec-bzImage64: mmap entry, type = 14080, va = 0x14f29, pa = 0x36c0, np = 0x0, attr = 0x0^M
> [   11.061317] kexec-bzImage64: mmap entry, type = 85808, va = 0x0, pa = 0x0, np = 0x72, attr = 0x14f40^M
> [   11.061320] kexec-bzImage64: mmap entry, type = 0, va = 0x14f4b, pa = 0x65, np = 0x1, attr = 0x0^M
> [   11.061323] kexec-bzImage64: mmap entry, type = 85840, va = 0x0, pa = 0x2, np = 0x69, attr = 0x14f59^M
> [   11.061325] kexec-bzImage64: mmap entry, type = 0, va = 0x14f65, pa = 0x6c, np = 0x0, attr = 0x0^M
> [   11.061328] kexec-bzImage64: mmap entry, type = 85871, va = 0x0, pa = 0x0, np = 0x7a, attr = 0x14f7f^M
>
>
> ...
>
> This EFI phys map address 0x27ffcaf80 is being mem-remapped and also getting freed and then in use after free condition (while setting up the EFI memory map for the next kernel with kexec -s) in the above logs confirm the use-after-free case.
>
> Looking at the above code flow, it makes sense to skip efi_arch_mem_reserve() to fix this issue, as it anyway needs to be skipped for kexec case.
>
> Thanks, Ashish
>


