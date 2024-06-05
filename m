Return-Path: <linux-kernel+bounces-201708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7518FC208
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B382283EDD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440A76CDA1;
	Wed,  5 Jun 2024 02:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSEJVtb4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BF76BB26
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 02:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717556015; cv=none; b=q84/Een//T23LX2on0Wpv25IiRaNjwfbfog37rXsxAfZLQSP9xMv/FMHEeI2BN/wBpCOBsW8WrPTVUrPnugGGJgTtKSgAAD3zEIrt0Xbbzt38ct8ypagzG+GYmzU1d+6DyDiXqYbPjSF6iB+O5ILFZGaSQdlgIgbo8hYWfuqsz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717556015; c=relaxed/simple;
	bh=NTjW41dpCDe5qmDI1+6+nnZ1GyVkcO85lhkVK0Nd+uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEmZ2+4ct4Kkn+2Znr1BLk265Jj14tUpxrWYKVz84TO0LbB2xnzYLgS5S/RwEux4GvBseNamBQ5PEIvECv/pCf7x04HC1arxinhB484vAxBIncapXNmemCyVsJ9FjeCGqClTU2ML3x6Q2hmUAHhCxGcLxTQcvd6irn5IjO97LgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SSEJVtb4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717556012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3FTX+9rZeC4z0llUfSKTY9Loz4suuB0WymmiOnqwlu0=;
	b=SSEJVtb4g4H3gpOYspQA/IIBOg/Ivlo3nIhHRTzNOWzxGk2ovKlhIk/7kSQGCVvhk0gf5S
	Wm+39Cwtm7vFlO1zCxNgldCN+AlCaakLoTnqnImki+5T2PqzRARj+7F7PaKkw4IA5ncovA
	WjtUozHawq6asJnQySfMA6FWwDZ4QQ0=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-o7K6kHLjNjCJ1X3HKdEwDA-1; Tue, 04 Jun 2024 22:53:30 -0400
X-MC-Unique: o7K6kHLjNjCJ1X3HKdEwDA-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3748a9f55ebso6506025ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 19:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717556010; x=1718160810;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FTX+9rZeC4z0llUfSKTY9Loz4suuB0WymmiOnqwlu0=;
        b=R2xcPIjbVTo5MiuuTuR+9su3NuuP09Zzs3XZ3HrTp2UvJjY9Pyb0qBaX5FgIc2jKbz
         U+YJbgOrHWuXn60Qi/5szwFUe9hOos08OEDcUhuaZfXW4zMKp3xH2G8BLNiNIK7JmYQF
         yqn7RU8Zt1PwUSZcSsu2Klu1M44q3nA69jIwWwjiitQc62h10hssfainQVGADfhj+a5j
         Qg6izRZ/G4f6Udo89yPs/jx1wgcL/8Vc2Q36He5LXkcWkTYEzYVB1QyDD7yegeklkTG7
         FeaoAMvNurYeX9n/Bak1HQEZOEkKRWfyeDnpPMw0kwqdwMVGsNefOf+Zn+Ay50GdmlIK
         ebcg==
X-Forwarded-Encrypted: i=1; AJvYcCVkRFhm6+U0XW3OrV5TIn6mzaLgavt80WO0djNnmAp55CMOVGLGyHsGwGxhzQdwDH1w8eCCDXcxFX0jZCraDZLDKwKmmRlQA3E/LDqM
X-Gm-Message-State: AOJu0YxiBuzaig51sXZj1DbPhK+AopRt8BepiZB5nqNSi0qWHch0bw3m
	o+p3XLablF3oAxKM9Uo+MlOiJjE0DzlrOlt1jY5SfvXa/8zDQK8EoKds179cBtSofiqjQ1OKKm9
	tpdKESxq4OeqT/bhLFwglaFsxCZmb6UiAcqt2KTbgnzcshEtHfehA0SpPICiituk1AJ6UDaMVKX
	PTDAKbk2FzNta7hk21eC6KmaQQhZSFP1n3nuIS
X-Received: by 2002:a92:c262:0:b0:374:6545:5546 with SMTP id e9e14a558f8ab-374b1f3e5ddmr14071945ab.2.1717556009935;
        Tue, 04 Jun 2024 19:53:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBBqBjje1/Rae28nzKbAjV9C7xlZjBxKlW7978XbuE4RsH8R8NhNUkzBWIWBCLsBy3RsdRYMvU/X86zSTOyEs=
X-Received: by 2002:a92:c262:0:b0:374:6545:5546 with SMTP id
 e9e14a558f8ab-374b1f3e5ddmr14071685ab.2.1717556009574; Tue, 04 Jun 2024
 19:53:29 -0700 (PDT)
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
 <CALu+AoSnA4323QbQG7wrNptosz7tfEfztsE1=o6G=FaLbQ_tKQ@mail.gmail.com>
 <20240604094358.GBZl7h3otTCYJ5rkkt@fat_crate.local> <CALu+AoS=-=PbMRxC-1rpfSTPpMOmM5BGRBjLhDwgOC3=4C71ng@mail.gmail.com>
 <20240604180212.GHZl9WpAfNVERTjMqw@fat_crate.local>
In-Reply-To: <20240604180212.GHZl9WpAfNVERTjMqw@fat_crate.local>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 5 Jun 2024 10:53:44 +0800
Message-ID: <CALu+AoRqNmsWXi+HXYNYTY=pXJ3sLTLKyXNeJz9EoxEsHzFdQA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
To: Borislav Petkov <bp@alien8.de>
Cc: Mike Rapoport <rppt@kernel.org>, "Kalra, Ashish" <ashish.kalra@amd.com>, tglx@linutronix.de, 
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

On Wed, 5 Jun 2024 at 02:03, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Jun 04, 2024 at 07:09:56PM +0800, Dave Young wrote:
> > Anyway there is not such a helper for all cases.
>
> But maybe there should be...
>
> This is not the first case where the need arises to be able to say:
>
>         if (am I a kexeced kernel)
>
> in code.
>
> Perhaps we should have a global var kexeced or so which gets incremented
> on each kexec-ed kernel, somewhere in very early boot of the kexec-ed
> kernel we do
>
>         kexeced++;
>
> and then other code can query it and know whether this is a kexec-ed
> kernel and how many times it got kexec-ed...

It's something good to have but not must for the time being,  also no
idea how to save the status across boot, for EFI boot case probably a
EFI var can be used, but how can it be cleared in case of physical
boot.    Otherwise probably injecting some kernel parameters, anyway
this needs more thinking.

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>


