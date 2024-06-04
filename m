Return-Path: <linux-kernel+bounces-199904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312E88FA77F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4AB1F23258
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7685E13C68A;
	Tue,  4 Jun 2024 01:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxNgsIJR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4196D139CFA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 01:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717464224; cv=none; b=hQzy0Cwe7Rhm7V+cctWDIs2MkW8aU8dmQ5MQWklWMtRYer9COFRmzhp+LWDcGo7YdpE72s7tUqUBT+vGiaEiCP6SIX87U3tkz45KyJzOyWzp5mLMrAXbsUHPg9ZC3LKKh8llpoeOPFJlG04uRGh+pBn8xL2OwSVmihGFCLCCp0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717464224; c=relaxed/simple;
	bh=aUtGUjE2Un5r4Ipt2J6GL87oe3xhZsTM6lJ9uypAsl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXlFtZRoCGc7IrO9DjPezMagW2ZqvSqEe/6BzCd/rlNxVJUn4BzQXL+xUDQAnHmDwF5AAjpJdG7MJKwETHyjr+ZfxvvZ7MR41iY7K2dPwVdR/1YkzJ4cUsY92cYN3GGl1Spqv4n1SQX5juR42EsPQGM8wco9ZYgZXJ52QJ0k0ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxNgsIJR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717464222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S2uM4DFyGxLz048gnN/tqwhjQvWlr4twzxXFxXx0Uho=;
	b=bxNgsIJRlwUMF+O0XzAevbZV1bO8tXkiDGrAxfGA8T1fl1TY7taNz5mczWEN31wcqd8MPS
	skpMpLrti9rnV6lpIKOu7esD4xZmAZnip50BF3I4sXBwR7O9K/7Pua0Td3J0Hvl1mZ6awa
	3kqRCSoEzplxF1PFkSW7JE2Dihr/tUw=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-UokcukgwNASv6dc-IEGbqw-1; Mon, 03 Jun 2024 21:23:40 -0400
X-MC-Unique: UokcukgwNASv6dc-IEGbqw-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-374a8187062so1052325ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 18:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717464220; x=1718069020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S2uM4DFyGxLz048gnN/tqwhjQvWlr4twzxXFxXx0Uho=;
        b=elJ1snIALdoWV+KVA1bZQ3y9lynmjpz7qFW5ZuKiIuDqPS7ZRmyeATvsavvna139zz
         /oPUQqCM8ZJ0jeiXSLcGgxZp//jps7WgYOnNKl5Rz13oY44oswdb387N8dLMNObTQ+St
         OX9fa6iQf5bZ25UNctbeB8Tzq/+YFdSupbVtiMr2aMvFRJWOhgKqkzkSmRA/GwBmMWll
         KNMq/+eyvm9NWeER7KyrArABtRxI+xEGiV1l8TcvFgaXhZIx3jk+5yL50BYsaRZBFWtj
         ZmTKsif2xYJOX7WaWpu76PfvoJ4gJtXkvpmgP7oMjEm5WctM1wAUDU7vyjApORxXVqkj
         mm8w==
X-Forwarded-Encrypted: i=1; AJvYcCXtM7v/cSWWc+DC1ek8W2zA4+SnKh/ykw2M+SsiJX9I+D++j07CVXXhBuDPE/nIhzjsptUc2fiTHgQhfhkTtmqAM3tYFVH3uiMPXZGX
X-Gm-Message-State: AOJu0YwvLXsNeYA9UwiDWOB8YuRpvlS2qgHihsuPsebXjuh61F0uzTMh
	4pnzOuJps4IwgTD4n+ExzA4mSpaiDa2Xuolqs8x3T8qtT3/p6kM7A4A+ZHhBML1f8ApKeAxEBfd
	kRxsH1EnoEUCwKnsGZUHKlnrjMqL4P9semh7oUfKSkFLmPGd48sh3eWM7DeO6rrwVCo+Og1HhUP
	jfp6Gfzq8Ds8M53cIJoHmKiJK8d78RswhMWjsu
X-Received: by 2002:a05:6e02:12cf:b0:36d:cb9d:cc9e with SMTP id e9e14a558f8ab-3748b9cfee7mr107650645ab.2.1717464220185;
        Mon, 03 Jun 2024 18:23:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg3MFJebi0AMEiF/DB64qHywmC9po1Ki163doJb0ZzhuVzWAmCpVqYYvMl/8ZsNk38RNQy2ClsQBbegQbN6zk=
X-Received: by 2002:a05:6e02:12cf:b0:36d:cb9d:cc9e with SMTP id
 e9e14a558f8ab-3748b9cfee7mr107650315ab.2.1717464219826; Mon, 03 Jun 2024
 18:23:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
 <cover.1717111180.git.ashish.kalra@amd.com> <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
 <20240603085654.GBZl2FVjPd-gagt-UA@fat_crate.local> <8e3dfc15-f609-4839-85c7-1cc8cefd7acc@amd.com>
 <Zl3HfiQ6oHdTdOdA@kernel.org> <1ef36309-8d7f-447b-a54a-3cdafeccca64@amd.com>
 <20240603144639.GCZl3XTwmFHwi-KUZW@fat_crate.local> <Zl3hwYL2GDiyUfGo@kernel.org>
In-Reply-To: <Zl3hwYL2GDiyUfGo@kernel.org>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 4 Jun 2024 09:23:58 +0800
Message-ID: <CALu+AoSnA4323QbQG7wrNptosz7tfEfztsE1=o6G=FaLbQ_tKQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
To: Mike Rapoport <rppt@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, "Kalra, Ashish" <ashish.kalra@amd.com>, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org, 
	rafael@kernel.org, hpa@zytor.com, peterz@infradead.org, 
	adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com, 
	jun.nakajima@intel.com, rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, 
	michael.roth@amd.com, seanjc@google.com, kai.huang@intel.com, bhe@redhat.com, 
	kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com, 
	dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de, ardb@kernel.org, 
	kexec@lists.infradead.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 23:33, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, Jun 03, 2024 at 04:46:39PM +0200, Borislav Petkov wrote:
> > On Mon, Jun 03, 2024 at 09:01:49AM -0500, Kalra, Ashish wrote:
> > > If we skip efi_arch_mem_reserve() (which should probably be anyway skipped
> > > for kexec case), then for kexec boot, EFI memmap is memremapped in the same
> > > virtual address as the first kernel and not the allocated memblock address.
> >
> > Are you saying that we should simply do
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index fdf07dd6f459..410cb0743289 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -577,6 +577,9 @@ void __init efi_mem_reserve(phys_addr_t addr, u64 size)
> >       if (WARN_ON_ONCE(efi_enabled(EFI_PARAVIRT)))
> >               return;
> >
> > +     if (kexec_in_progress)
> > +             return;
> > +

kexec_in_progress is only for checking if this is in a reboot (kexec) code path.
But eif_mem_reserve is only called during the boot time so checking
kexec_in_progress is meaningless here.
current_kernel_is_booted_via_kexec != is_rebooting_with_kexec

The code change below in the patch looks good to me, but I'm not sure
what caused the memory corruption, it indeed worth some more digging,
maybe SEV/SNP related.
+       if (md.attribute & EFI_MEMORY_RUNTIME)
+               return;

Thanks
Dave


