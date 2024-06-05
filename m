Return-Path: <linux-kernel+bounces-202237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C844B8FC9DC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD561F25704
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27680192B94;
	Wed,  5 Jun 2024 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aWYDBVHB"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2219412A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585790; cv=none; b=sPMEhFVHxZk3NGfF3hpGhQfxwCQyRwH0NM/QeciyCHohgVNRAcYlMtA1iyqKsiD8h6Y67jK5L+KbiwIJhgNZhYnF7cCG6+IFf5k8Zew5hGuJI4LD1HqKDI8Pav3+G7dXO2jIWb84fUHxvrs395Gj1adTM5qMmT5v0iPjY49jP3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585790; c=relaxed/simple;
	bh=gHYwV3ZcigYKcTefauABwPWAEb9vyy0l/uk5Qsnin7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8Pzg1HaLYUa/7G80AuK6ri3TFjww5lyPLOMIIcYMawW2wXync9z6GuTDkHL2hhOZsYq/luvjcPAab0HIbGXVikX9EKUYr7Mbltikqib9PyBsTGysLx0RyGguAMEm1tvhtOuo0CMOTMvjKc1xFhxJwmnhM+MeZCXPAumgjEISqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aWYDBVHB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E13B640E0176;
	Wed,  5 Jun 2024 11:09:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id iJf5bq__s4gN; Wed,  5 Jun 2024 11:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717585781; bh=u8G7LlOZuSGdMErqsnXyAGVosfE3DwlKRA2nP23l5K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aWYDBVHBUclEEG1gDdbe+IdXFSR610ZcoZ15fdD8wx7IG52P3H1YvEhtTtsD9nONn
	 EgachKPplm43FJBaLMC5cc6CvfKV8MA6SbwzeUu688pecrXXCwz7NgHD2A/vpnmyDI
	 RyJkAcnNA1Bcw8f8SHu++1GS8A9sSmpx7KeGtYLbr9WzqlMvWymSdqGrctv/FnXRUI
	 /v4rEcLYOYGvvAJI8FsNk9w9gkIU13OJMJIrqITMCtL4fQMOJdLywG351jw+GburS3
	 bBcRign7gnvOvXogKGlvpwebk/wxjW+WltpUQFOHnmWjW7jokjkP0FCJ6m/EvuLDTe
	 BbqVHmANcg2kg0cCHJdFwMhlxCE6azl8xwW2RkRPsTxwRItOuqsMhQDYruReg6HJyR
	 6sUhmNdlZGoCqckVBNJY7ipHisko8EqoNU/rhHcBqsr6g313/KLk9HxSbdYRTdPm8l
	 QEZSleJvDkkR2JwNGSKsLLkuvNMWSJaGpvKCmbqrVHmzI08iJxzauhUwV4ccvI/Zqr
	 hfGKSO2De6TDGnPBS6+11FvEK0QNVZDFIWT6waY8YUuOVx+tr/qnezVh6BEbypjMNU
	 E1DdG2C1jyw2gnmyh3zRSpfjkQ0ZIaHNe1mOzFZIIGKdj2pZQ1JRAAcBC7k+puZ9nn
	 A1smz3yi1mW/YVlSH/e7KPoI=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5225D40E016A;
	Wed,  5 Jun 2024 11:09:11 +0000 (UTC)
Date: Wed, 5 Jun 2024 13:09:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Young <dyoung@redhat.com>, ardb@kernel.org,
	dan.j.williams@intel.com
Cc: "Kalra, Ashish" <ashish.kalra@amd.com>, Mike Rapoport <rppt@kernel.org>,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, rafael@kernel.org, hpa@zytor.com,
	peterz@infradead.org, adrian.hunter@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
	rick.p.edgecombe@intel.com, thomas.lendacky@amd.com,
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com,
	bhe@redhat.com, kirill.shutemov@linux.intel.com, bdas@redhat.com,
	vkuznets@redhat.com, dionnaglaze@google.com, anisinha@redhat.com,
	jroedel@suse.de, kexec@lists.infradead.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Message-ID: <20240605110904.GWZmBHUHSqCJVQYajF@fat_crate.local>
References: <7eb4ca99-679c-4f23-9562-a39b966c28a0@amd.com>
 <20240603165747.GGZl32C9yrmXJ4nhPT@fat_crate.local>
 <2343889c-887a-49ce-86df-343737d70d37@amd.com>
 <20240603171231.GJZl35f-BHvU2Pk3lb@fat_crate.local>
 <ff28e3ea-c492-4db6-8781-abaec6320756@amd.com>
 <CALu+AoQBXv-y43sx6E28UBVeVHUzRkWEzFxK6jsS5NpN2ho3YQ@mail.gmail.com>
 <CALu+AoTY2Xxs_vUzCyfsxtk-ov2mzJhzyTbbA9MYeeVkmKTMsw@mail.gmail.com>
 <CALu+AoSESmasAHqWdCGgQNbsTXfwbfhERBkaqSeaX881zqKtFg@mail.gmail.com>
 <41e085b8-2b45-40ab-9a6f-f4ad975a0b06@amd.com>
 <CALu+AoQ2jNjb+5MZfFtpT_Y=2gJRWwqEeWTpQkwNt0-U5fpO_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALu+AoQ2jNjb+5MZfFtpT_Y=2gJRWwqEeWTpQkwNt0-U5fpO_w@mail.gmail.com>

Moving Ard and Dan to To:

On Wed, Jun 05, 2024 at 10:28:18AM +0800, Dave Young wrote:
> Ok, thanks!  I think the right way is creating two patches,  one to
> remove the __efi_memmap_free,

Yap, that 

  f0ef6523475f ("efi: Fix efi_memmap_alloc() leaks")

needs revisiting.

So AFAIU, the flow is this:

In a kexec-ed kernel:

1. efi_arch_mem_reserve() gets called by bgrt, erst, mokvar... whatever
   to hold on to boot services regions for longer otherwise EFI
   "implementations" explode.

2. On same kexec-ed kernel, we call into kexec_enter_virtual_mode()
   because it needs to get the runtime services regions from the first
   kernel

3. As part of that call, it'll do
   efi_memmap_init_late->__efi_memmap_init():

        if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB))
                __efi_memmap_free(efi.memmap.phys_map,

and the memory which got allocated in step 1 is gone, thus reverting
what efi_arch_mem_reserve() is trying to fix.

IOW, we need a

	EFI_MEMMAP_DO_NOT_TOUCH_MY_MEMORY

flag which'll stop this from happening. But I'd prefer it if Ard decides
what the right thing to do here is.

> another is  skip efi_arch_mem_reserve when the EFI_MEMORY_RUNTIME bit
> was set already.

Can that even happen?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

