Return-Path: <linux-kernel+bounces-201687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B873D8FC1CF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665BE286A5D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308CC5916B;
	Wed,  5 Jun 2024 02:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SveVeORI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D66E17C79
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 02:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717554486; cv=none; b=DSse8pnx+SpTmBM1FDKPDCIAfExuSrclATl6kVSBnAdeiPMjZB3+JVXfDx/fDlumgBPSKk4ZBfEIjylFLmQ9X9bk2xjtDmnbESp9pwEhh/wN4F4/0ra3gURtN8NBRThmMH5m9KB/a+gpOOZK+bvFfEUzrDmdbM4nao/2BbNoBBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717554486; c=relaxed/simple;
	bh=R0Q+d0KNdIo4/1UDPQUotxY23fZjm0IKelJnw2zPQ2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnHIhX3mqdYPvFU6+UPDshF84EGHsJ5Pz4We4z+ZkyuQd8dF3xAEPef1Z8x5FQzwf8fpXqEvph1S4sa+i/nFvubf1GBAlCEGDYfORb6KIIMfHzbcrqibNNjWWp5vxmLOlVlff3K87Z+td4jbaVx3RPHg91j+6k9vQe1Zxf7QV9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SveVeORI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717554483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lOA1MCZJzoxt6GCkNRp4+h7p2tW8g2r7m2il3+oTwSQ=;
	b=SveVeORIIC+GTcMK2S+5KhO7gCOruTog1RuBVUD0rl2wpmR4/VXyM0F3HOxvIs4vk3YoUi
	KL0IpKm6Opu4Xi+IUrd8t5/JGwHjIbVMmUNJbtaiFlLtW2ic8d43vYS6qaRRJAarYtIlG1
	tY00mPUnxJyHQwzhoXQfFPrDqFprWAY=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-foaYi1qzNm-Xm3UWhLBsgg-1; Tue, 04 Jun 2024 22:28:01 -0400
X-MC-Unique: foaYi1qzNm-Xm3UWhLBsgg-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-374ae94e856so2181825ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 19:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717554481; x=1718159281;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOA1MCZJzoxt6GCkNRp4+h7p2tW8g2r7m2il3+oTwSQ=;
        b=Ds1Yh6jdKAeUmq6QZEGMzmPvLvgmifEw3dMSM0aPYCDPrmO3Ot1wrgd3bIWQulzAvb
         KBDSL9VFs/oGuOY072529OUr6KAek0DOJd0MyLRN01mYNG6D4TsbZZAUE3dhXILNtmvt
         q/P9yg9M7S9zvIDFNstPDWcmkt0DHYFdU19zwIHpkaJ997ERklEzBC/d5vA/q2+9HEaa
         pdYhzq2C6zdxFENaV+KB5Lj1gxGUOixpw9rToURY8x2nIcGWDea8BzegQEd06nc4wjU9
         7EOabsLVjh5avr2dYp5nFhOorfUwfHhn8Gi6afLyyQ0OXOYkTpASvr+sOCAIlDCggZbp
         Ei+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1qB1C8LtRQygNU9eEnJq1xeMWuFI6bTPKcGs7ywYjRf+dpMQTLFRMjzgXqvtKi+/HBLHssx1lnIafe+KB3L+qe9/oTUJl76cSiWPA
X-Gm-Message-State: AOJu0YwyhRMaPqmZeAF+aRcsLCe1Xnv7lGS2cmy7oGjwQqELyveElriB
	sUYlbIHktpWUbaoKHCzbksA613Vj8ewY1s7pYFfEZ7UDqIH6dQKwaFfgnyhk6gqrTS7DMRdUV+Z
	hdHps50bAXlcft5xc0p3gm1odH/AcJmjorijg3zSjR68hRdmbocP3lT436z5jlL9BOeWIUENvCT
	FQsl79bBxylTeLls9XhIFmkTPixKdD381JFQT6
X-Received: by 2002:a05:6e02:2186:b0:374:9916:67 with SMTP id e9e14a558f8ab-374b1f581b2mr11523755ab.3.1717554480535;
        Tue, 04 Jun 2024 19:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLK8Z8K1Sf1VYEaO2jfZNFyTUIy/6PgZmMDleVpuyW8h0jbW5z86MOXD9UJxh2ksU0GUTW5kdRKx56WX70gCg=
X-Received: by 2002:a05:6e02:2186:b0:374:9916:67 with SMTP id
 e9e14a558f8ab-374b1f581b2mr11523595ab.3.1717554480186; Tue, 04 Jun 2024
 19:28:00 -0700 (PDT)
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
 <ff28e3ea-c492-4db6-8781-abaec6320756@amd.com> <CALu+AoQBXv-y43sx6E28UBVeVHUzRkWEzFxK6jsS5NpN2ho3YQ@mail.gmail.com>
 <CALu+AoTY2Xxs_vUzCyfsxtk-ov2mzJhzyTbbA9MYeeVkmKTMsw@mail.gmail.com>
 <CALu+AoSESmasAHqWdCGgQNbsTXfwbfhERBkaqSeaX881zqKtFg@mail.gmail.com> <41e085b8-2b45-40ab-9a6f-f4ad975a0b06@amd.com>
In-Reply-To: <41e085b8-2b45-40ab-9a6f-f4ad975a0b06@amd.com>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 5 Jun 2024 10:28:18 +0800
Message-ID: <CALu+AoQ2jNjb+5MZfFtpT_Y=2gJRWwqEeWTpQkwNt0-U5fpO_w@mail.gmail.com>
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

On Wed, 5 Jun 2024 at 10:09, Kalra, Ashish <ashish.kalra@amd.com> wrote:
>
> Hello Dave,
>
> On 6/4/2024 8:58 PM, Dave Young wrote:
> > On Wed, 5 Jun 2024 at 09:52, Dave Young <dyoung@redhat.com> wrote:
> >>>>         ...
> >>>>         if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB)) {
> >>>>                 __efi_memmap_free(efi.memmap.phys_map,
> >>>>                                 efi.memmap.desc_size * efi.memmap.nr_map, efi.memmap.flags);
> >>>>         }
> >>> From your debugging the memmap should not be freed.  This piece of
> >>> code was added in below commit,  added Dan Williams in cc list:
> >>> commit f0ef6523475f18ccd213e22ee593dfd131a2c5ea
> >>> Author: Dan Williams <dan.j.williams@intel.com>
> >>> Date:   Mon Jan 13 18:22:44 2020 +0100
> >>>
> >>>     efi: Fix efi_memmap_alloc() leaks
> >>>
> >>>     With efi_fake_memmap() and efi_arch_mem_reserve() the efi table may be
> >>>     updated and replaced multiple times. When that happens a previous
> >>>     dynamically allocated efi memory map can be garbage collected. Use the
> >>>     new EFI_MEMMAP_{SLAB,MEMBLOCK} flags to detect when a dynamically
> >>>     allocated memory map is being replaced.
> >>>
> >> Dan, probably those regions should be freed only for "fake" memmap?
> > Ashish, can you comment out the __efi_memmap_free see if it works for
> > you just confirm about the behavior.
>
> Yes, i have already tried and tested that, if i avoid __efi_memmap_free(), then i don't see this memory map corruption.

Ok, thanks!  I think the right way is creating two patches,  one to
remove the __efi_memmap_free, another is  skip efi_arch_mem_reserve
when the EFI_MEMORY_RUNTIME bit was set already.  But the first one
should be the fix for the root cause.

efi fake mem is only for debugging purposes,  the "memleak" mentioned
in commit 0f96a99dab36 should be solved in another way if needed (are
they really leaked? or just not useful anymore)

Anyway this is my opinion, please wait for x86 and efi reviewer's inputs.

>
> Thanks, Ashish
>


