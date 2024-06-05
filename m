Return-Path: <linux-kernel+bounces-201657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F42F8FC16F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 295D2B24F0C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C01855E49;
	Wed,  5 Jun 2024 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VY1uqhLu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395A541E22
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717552315; cv=none; b=kVXySFMgIgsU7nZCaekXWQT5AhlsZ5UA3PN6cnS3vhTXeS5qw6UnlKnHG+dbj41iP5bPIBrFQGGgeMmuRhiRdmh49TATpARpRadcGp93KCeI2a6wZsZIQWslH5dBs/bVoT4GYnzwFXHrWBlEACgs1m0qugHqmQJf7aPUTTNLW48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717552315; c=relaxed/simple;
	bh=OmK2gI8hdD5XbePH08Wp+6onT/YKAAFKoajQb9RoVTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bz4jGJnlMDU29maifUvSXwVq/4E6QjPPXpwS7B+urYfU3xwKk+h2fHqgUGcUjrRzjj7zY4nUOQo4mG+OFKomKe8EN8veFsunfMd1U+EyZbxvrUOnNKeWcSY0z96rl6jqBoraUHeL9ptmEl/i5QlShbCbFusWDqbm0TwDchlyi3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VY1uqhLu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717552313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=upN2cK+0+gJo/KqGs9LW3KxpT5YmqhfYJXwjAOS8ygY=;
	b=VY1uqhLu6QsfvtUU/cjVzyYv7J/Ldb6zRFLbrk/tvpv5pZo59dx8lpRD55AuJ9M0Tlm8O0
	mbqsUbq9qzdt+rOQPtT+XxW4zaUP+X9YL8qJAEIfBxBPmEDn64rqw5ExWWNG2VYHtOClzi
	RlKmKdK/OHuS9SvxH1gyPBOcQsFzsN8=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-HgWkWbDlNI2Aa7pp1sbsFw-1; Tue, 04 Jun 2024 21:51:51 -0400
X-MC-Unique: HgWkWbDlNI2Aa7pp1sbsFw-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-374ae94e856so2120025ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 18:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717552311; x=1718157111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upN2cK+0+gJo/KqGs9LW3KxpT5YmqhfYJXwjAOS8ygY=;
        b=X/sPg6hmKhyKvvpZlD72wmK5Ntn5gzB7CLqJmmNogC2TyPW0ZJqx8owz+7ctI2CICo
         /nO3qLZvz+5oDSBsOdkQRXvSoo8uW+UuUYOR+43aKWDjmtS94xSryLaz7UHC11HJmbwg
         6Ixttn2sm6xs5n9MQzXPWosFBzNMNsBw08OsLRfr+4Jz6l3Lo3HHBQnRtZZ+oYFdL0ut
         rUh9Mnpk+Ou9gf9j0didzqynDRYPHs8jhwrqXWDPc/G8UwtKj6BOKdt8BxhKobN3w+Ps
         OsOnRUr2m12sZKlztSrFWWCOKCjLywTdxXb73aSIWAy68MBpzUcPjcJI6HFLJyPV1+aQ
         rs9g==
X-Forwarded-Encrypted: i=1; AJvYcCXdllG3rGmMYHNvDe5SB3FRdpjARR+8xlj1pgMx3rO0EbRHV3H/VVmDvz6wNWXRGPBhUu7lMl9n8/byqs5xTjuZFQ2WRQVnF4VLCN8X
X-Gm-Message-State: AOJu0YwyFPVOMqZmW1YMnzpA2yPWSPUE7+o0P+l0VG3DsXlT1rrnlLuA
	KEZy6rsU5YNRgcfdSW188W64UAvt+lXGqtM8N42Mf99Q+rz5RSt01U859WJ4oVJdOOjsp+fKocb
	X5OWqzc7j4QEiMCm6FXAG0ssGfo+NvxW1ouVrouBVUScntL7anKJDj1Z3IQVcAHM2FP24sFqqa2
	PzonBtgdbx3wWsisR4PJnSTc+wTW/DDTdCvmKB
X-Received: by 2002:a92:cda2:0:b0:374:aedb:1607 with SMTP id e9e14a558f8ab-374b1e108e4mr11917305ab.0.1717552310722;
        Tue, 04 Jun 2024 18:51:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoAvumzWTEo5FkJ6C3OMbCpE5l3j5iU8XrNVp3YfRyiPEFNZA2Dhz1INdK+vIULCPwAJeNIpjtYyclX4eHIb4=
X-Received: by 2002:a92:cda2:0:b0:374:aedb:1607 with SMTP id
 e9e14a558f8ab-374b1e108e4mr11916935ab.0.1717552310203; Tue, 04 Jun 2024
 18:51:50 -0700 (PDT)
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
In-Reply-To: <CALu+AoQBXv-y43sx6E28UBVeVHUzRkWEzFxK6jsS5NpN2ho3YQ@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 5 Jun 2024 09:52:09 +0800
Message-ID: <CALu+AoTY2Xxs_vUzCyfsxtk-ov2mzJhzyTbbA9MYeeVkmKTMsw@mail.gmail.com>
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

> >         ...
> >         if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB)) {
> >                 __efi_memmap_free(efi.memmap.phys_map,
> >                                 efi.memmap.desc_size * efi.memmap.nr_map, efi.memmap.flags);
> >         }
>
> From your debugging the memmap should not be freed.  This piece of
> code was added in below commit,  added Dan Williams in cc list:
> commit f0ef6523475f18ccd213e22ee593dfd131a2c5ea
> Author: Dan Williams <dan.j.williams@intel.com>
> Date:   Mon Jan 13 18:22:44 2020 +0100
>
>     efi: Fix efi_memmap_alloc() leaks
>
>     With efi_fake_memmap() and efi_arch_mem_reserve() the efi table may be
>     updated and replaced multiple times. When that happens a previous
>     dynamically allocated efi memory map can be garbage collected. Use the
>     new EFI_MEMMAP_{SLAB,MEMBLOCK} flags to detect when a dynamically
>     allocated memory map is being replaced.
>

Dan, probably those regions should be freed only for "fake" memmap?


