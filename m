Return-Path: <linux-kernel+bounces-186763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEE38CC8B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 00:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948C1281DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED964145B33;
	Wed, 22 May 2024 22:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyAZPkbn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B1C7E578
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716415420; cv=none; b=O4k3ncsn3+XeWVO56BeVIo+8AXo2ALunbox66km+Kv7dmmkHJ7FqaiK0HrN7a0XOLi6ps3bEnVePrW0JUnykDv5KDlbTY0EUaqwwiNpSVO0Ff5ogiy+z18IcyhO7PclL6WJVOcKDZtI6ulezxCm7Bu2XXGRLN3s7wr6HhoGqhXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716415420; c=relaxed/simple;
	bh=V/OjKPxD4m8dljSxcrsuVphlD92neLpCIPnWiQftobo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aK0ml1YRnC57zgJb0vZiCWsF+T0HzGXqwXrLnDA0uLUYSCdYNAk9/UzzhmIA9U+rI+VaTQNaUV0fLt+uHzB8SK55o1w4W3xD2+fqOnuxUaSArfJe/wi9rJOeb9r0NeZNH7MZZAKvbV8mgTn58gJev/YCxm5yYsb/8+8IHUq7pV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EyAZPkbn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716415417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B4hXJ6JIsSVK9s0rSIg6c+3f6ReWIevwF2URwvf4CAk=;
	b=EyAZPkbnwMMpLVdIhZR0oiTg/LhyUJYXcBgHQ83BhVmYfhsmkkhhFdnS6S9e4egjl0epml
	a0p/hv5qpxY4cyNTjEBJwS9qHVBSU4mRYEw5c43+PnrNIboCA7TcP68VzzXI4LJGMfdULd
	XSnKqL/Czf4tdvZPyStYYIoqcKOogEE=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-N-yJpwBfNaOQBpE50FpuEg-1; Wed, 22 May 2024 18:03:36 -0400
X-MC-Unique: N-yJpwBfNaOQBpE50FpuEg-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-5b212b26f3fso168696eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716415415; x=1717020215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4hXJ6JIsSVK9s0rSIg6c+3f6ReWIevwF2URwvf4CAk=;
        b=sswel6+0Tcr+zgBBw6BSjjeg/DssyneF/sbjzEbzTSmP7dr5ptS7VLZuSVTChUPwWz
         3Xa+yKGmsPrfAeOpm+zhBfSiZRo35k6yqLlubi5b+nIg0Y+yHhtLj1BvWkc7Su8He7MH
         fqUM+hSHnpalDezfJCuCGzMPQhkfCgojWiUD1N4b5z6v/h0Kipj3s3Z6PvG5e5vTQPYd
         QQQQ3MY66+xjUuGG7X9gSpnNtWUybvBSgG3vixnXz5Z7Oamtsviclb0Na7oj5Bjc4bGo
         qmXVWaUmgwf1SjOrKqbaRHzACwMScBr4MKMud8eFuCBzsO7bjSV5ocQ85a739lVVpFeh
         3LiA==
X-Forwarded-Encrypted: i=1; AJvYcCVCg5uYjQYETp0MP6HdjEi7wkWedmDvGbY5jNjiINmpulKD3+7kzOHLQBiUOGi0B32tPm3fGgK3z8oMAQVeSQxlAwSfYM/8eeXh+gY5
X-Gm-Message-State: AOJu0Yz7Gutk0Xi9qKse0oHLp+OrsE2UrQpZvJ5VRRkkeKA9QkOemylM
	DOCwb1kCupQOhTJgRpbgepwkYUd4rVxmB3haO+JPNB+cEYQnFup2KvwpN2G3OQYVh1FsyDNYPNB
	sPI/ukO3V4B5j5pERc2sjI3DqJCXXuVzSbLP/ao79lfxb6ruyrUsZrom4MjPIew==
X-Received: by 2002:a05:6358:998a:b0:190:f30c:3856 with SMTP id e5c5f4694b2df-1979215b528mr285579355d.2.1716415415122;
        Wed, 22 May 2024 15:03:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlZSZyKnZdnEG0+pNanazMyIfCqIlp5QZYYe1QG8gY0ave2/OHUyQlsME1+uHDBoxePLQG5g==
X-Received: by 2002:a05:6358:998a:b0:190:f30c:3856 with SMTP id e5c5f4694b2df-1979215b528mr285573755d.2.1716415414181;
        Wed, 22 May 2024 15:03:34 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1cd266sm136937796d6.80.2024.05.22.15.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 15:03:33 -0700 (PDT)
Date: Wed, 22 May 2024 18:03:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
	Ingo Molnar <mingo@redhat.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Liu Shixin <liushixin2@huawei.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Muchun Song <muchun.song@linux.dev>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 1/1] arch/fault: don't print logs for pte marker
 poison errors
Message-ID: <Zk5rsvMs6qVPAw52@x1n>
References: <20240510182926.763131-1-axelrasmussen@google.com>
 <20240510182926.763131-2-axelrasmussen@google.com>
 <20240515104142.GBZkSRZsa3cxJ3DKVy@fat_crate.local>
 <ZkSUaVx3uCIPkpkJ@localhost.localdomain>
 <CAJHvVchGGJkEX=qroW=+N-RJDMDGuxM4xoGe7iOtRu9YcfxEEw@mail.gmail.com>
 <20240515183222.GCZkT_tvEffgYtah4T@fat_crate.local>
 <CAJHvVcj+YBpLbjLy+M+b8K7fj0XvFSZLpsuY-RbCCn9ouV1WjQ@mail.gmail.com>
 <20240515201831.GDZkUYlybfejSh79ix@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240515201831.GDZkUYlybfejSh79ix@fat_crate.local>

On Wed, May 15, 2024 at 10:18:31PM +0200, Borislav Petkov wrote:
> So if I were to design this, I'd do it this way:
> 
> 0. guest gets hw poison injected
> 
> 1. it runs memory_failure() and it kills the processes using the page.
> 
> 2. page is marked poisoned on the host so no other guest gets it.
> 
> That's it. No second accesses whatsoever. At least this is how it works
> on baremetal.
> 
> This hw poisoning emulation is just silly and unnecessary.

We (QEMU) haven't yet consumed this.. but I think it makes sense to have
such emulation, as it's slightly different from a real hwpoison.

I think the important bit that's missing in this picture is migration, that
the VM can migrate from one host to another, carrying that poisoned PFN.

Let's assume we have two hosts: src and dst.  Currently VM runs on src
host.

Before migration, there is a real PFN that is bad, MCE injected. When
accesssed by either guest vcpu or host cpu / hypervisor, VM gets killed.
This is so far the same to any process that has a bad page.

However it's possible a VM got migrated _before_ that bad PFN accessed, in
this case the VM is still legal to run, the hypervisor will not migrate
that bad PFN data knowing that its data is invalid.  What it does is it'll
tell dst that "this guest PFN is bad, if guest access it let's crash it".
Then what dst host needs is a way to describe "this guest PFN is bad": the
easiest way is to describe "this VA of the process is bad", meanwhile
there'll be no real page backing that VA anyway, and also no real poisoned
pages.  We want to poison a VA only. That's why an emulation is needed.
Besides that we want to get exactly whatever we'll get for a real hwpoison,
e.g. SIGBUS with the address encoded, then KVM work naturally with that
just like a real MCE.

One other thing we can do is to inject-poison to the VA together with the
page backing it, but that'll pollute a PFN on dst host to be a real bad PFN
and won't be able to be used by the dst OS anymore, so it's less optimal.

Thanks,

-- 
Peter Xu


