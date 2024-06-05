Return-Path: <linux-kernel+bounces-201663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113758FC178
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 03:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6602845EF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0E95B1E4;
	Wed,  5 Jun 2024 01:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeGlqOrQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CD455769
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 01:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717552725; cv=none; b=f6X+Ri3xnkA7bWtJjWIxYPnvcK1T6CM82HAK5sQ+hGeL4ybemmj7hP2A2VNGfj571O/GnfEKg8vAI6ZvpzFr7ZiArn6cDLGwXxhAReo/LSV5OHFt98JEj/Ge7X/whgwcn7JZ8y7+OrcZtmiz6eDwqv7X2YS++ch6BHpIUwB3AJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717552725; c=relaxed/simple;
	bh=yQNuo88HfPAS+i2AOQrcrk7UYC8jD7vecHcMZya2xIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzJy8dMw+46KLmp9/QqcRmpxed3O5z8R3EsR1JQhebOwGm67Ropzk8P1JqzZa4HkbqnyA2xHBYM5EX8YvE+vpYIHvxq2UPjvPPvFywedIW88bOyLLH8unU+ephG7jAWwKKQGmugS2Tn84Ed7gsJ2yzg5st/lTmR81ZRDp8WA4uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XeGlqOrQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717552723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bDq7LAUeG1zx3wFqxyw1+1sNdwa7aIwSKaoX8NuYSHg=;
	b=XeGlqOrQhT0xoBx3VybHSAnA5MVeJmKlKQe91TyQlcvPpLE9tfaCXJYPyIDap3vuTddH1C
	87W+4EdKBr5MP1fay/T0GN1bMdWfN/as4itQi4jVfjqBNWg1NPSk848OhBLuMrivLaP2FE
	blbzGN+2p0myhBhf574D0/tKgQQq+7Q=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-lCYCj6QtNGm63WiV2eGNkw-1; Tue, 04 Jun 2024 21:58:40 -0400
X-MC-Unique: lCYCj6QtNGm63WiV2eGNkw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2c22ba3e3b0so714692a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 18:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717552719; x=1718157519;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bDq7LAUeG1zx3wFqxyw1+1sNdwa7aIwSKaoX8NuYSHg=;
        b=s8hnLZPjGEYQrNEoNIcfVtK1p4o99XyxryWCs/4SQREsmD6jOQCTYT9ofmWkd+1Zxe
         p0qMM4AARIim6hbEcAzR3Dr0x/UYwocHTFdR381QDDbQTVJm7mVq4wbkYAB4elQe+gIM
         pn61WIztDRokkpyCkfN88AM/TtcreVlH+pAv6fZN3iZAT6wbMPThWgif/sp9ZY3fQCQg
         h5OeP35glGX8DMITjGms5xuDK5CJ0njwWhD0lS63zKf5I028es4+KW1rHa4PqguwbzWy
         dkQvDouu8ncKXqnwjUPVYnhG7J3iQfiF3Zip7BEjvbNQLE0dM6m+zkyKD/OTMSXuMblu
         kw9A==
X-Forwarded-Encrypted: i=1; AJvYcCVol7Lzon4CNH1zh+OC/NY7tpKmIA6uqll4Zs7Zs7Gko030iGi+9ropcUgMo4cr4tmOLdqA5oGdLMAOcBzXObhOU1isOiD8ZD0pXkm+
X-Gm-Message-State: AOJu0YymmlIl48jKLQYmNl7KLDYvPJV1Em/j0xK029cKRplJVlPnnwOe
	qsV3cr2RXmcvlCmSLfB/rXRkjNs4hXtMS3dyzEhD1XpoYj0Z5+8d7mVr5ykDnNnFyBxEQ8gdoU4
	aMTp4Ajc8XpOcUo3P8nZ5jCdeG+A/bqP3fRwb6RviRMEeLMD+c4OFmdlrvj4rybfV3c82rxY5yt
	D317QWR+eYgPEWAnJekr9AD4poxzaEaqeLBUyx
X-Received: by 2002:a17:90b:484e:b0:2bd:76ee:48c2 with SMTP id 98e67ed59e1d1-2c27da2df29mr1268673a91.0.1717552719001;
        Tue, 04 Jun 2024 18:58:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxFVHjC8YnYbmOndJJgwEmwIfgEgBgMUDA8Tq6Gici14Z5tLZpocEb/9zJxsxUZ9G0QoldR1eiR4+UpxuGzgo=
X-Received: by 2002:a17:90b:484e:b0:2bd:76ee:48c2 with SMTP id
 98e67ed59e1d1-2c27da2df29mr1268665a91.0.1717552718628; Tue, 04 Jun 2024
 18:58:38 -0700 (PDT)
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
In-Reply-To: <CALu+AoTY2Xxs_vUzCyfsxtk-ov2mzJhzyTbbA9MYeeVkmKTMsw@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 5 Jun 2024 09:58:56 +0800
Message-ID: <CALu+AoSESmasAHqWdCGgQNbsTXfwbfhERBkaqSeaX881zqKtFg@mail.gmail.com>
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

On Wed, 5 Jun 2024 at 09:52, Dave Young <dyoung@redhat.com> wrote:
>
> > >         ...
> > >         if (efi.memmap.flags & (EFI_MEMMAP_MEMBLOCK | EFI_MEMMAP_SLAB)) {
> > >                 __efi_memmap_free(efi.memmap.phys_map,
> > >                                 efi.memmap.desc_size * efi.memmap.nr_map, efi.memmap.flags);
> > >         }
> >
> > From your debugging the memmap should not be freed.  This piece of
> > code was added in below commit,  added Dan Williams in cc list:
> > commit f0ef6523475f18ccd213e22ee593dfd131a2c5ea
> > Author: Dan Williams <dan.j.williams@intel.com>
> > Date:   Mon Jan 13 18:22:44 2020 +0100
> >
> >     efi: Fix efi_memmap_alloc() leaks
> >
> >     With efi_fake_memmap() and efi_arch_mem_reserve() the efi table may be
> >     updated and replaced multiple times. When that happens a previous
> >     dynamically allocated efi memory map can be garbage collected. Use the
> >     new EFI_MEMMAP_{SLAB,MEMBLOCK} flags to detect when a dynamically
> >     allocated memory map is being replaced.
> >
>
> Dan, probably those regions should be freed only for "fake" memmap?

Ashish, can you comment out the __efi_memmap_free see if it works for
you just confirm about the behavior.


