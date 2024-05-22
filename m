Return-Path: <linux-kernel+bounces-186303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD698CC27B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51EE828316C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21E813E3F4;
	Wed, 22 May 2024 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPqCEfG3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CD613D63D
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386074; cv=none; b=VBwEPMp6gALKf1HhaIYhuVN0L0MSLb5z9zb/VLNntMDbQXSoGRhgChbKgod5GwgSB3LTedcdkFjSDvp0dUiexi5M4u0aFguaA6WgLZFQNlZbNL7M+9hdw/SO2+AG84K7CkhpxxfrtoH09XGElpNjjMyXHk5laS89E0/3Vr/mbcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386074; c=relaxed/simple;
	bh=x4Bd90N5hMqNCQcq1Pdds0uYNSzOYGwEsLTxZZSUWTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETWQTObsQrjXwTxLgtxrHjNTQqq8dVdtX15yQxO++vZfKyrV9jDahq7hG6I2IsQEMHDlu9xa9UejS6CcvKN7VExSs7VJP0tTqgvkjDTGFiFxF8YNtU5amJnNvXe5aZoZfe1F9HDHCWyb3y9tbcP6I9j5rW/nx++hR4tJiS3Zvug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BPqCEfG3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716386068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7c5zLfLdGltfzXtziBtLG00XswaNQs4tKz8cXhsPP9g=;
	b=BPqCEfG3kP9a9tEBkywuJOLgoS4+SQOUIssAxI8P11Ej4fDjK8oMKuPRbFnX4r7TBh79dM
	GL6bpjliMiaU4LT12RdpkxDzIn5nkK4a/YH1BdkMFe1Fv2+2rDAevpWq9Kas9mzJ2MLCtV
	VIH0gq2Hfjd/sdmApWsha489WB2ccm4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-FvJbX80KN-2Cy1zc6y3rWg-1; Wed, 22 May 2024 09:54:27 -0400
X-MC-Unique: FvJbX80KN-2Cy1zc6y3rWg-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-627e4afa326so15505707b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 06:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716386065; x=1716990865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7c5zLfLdGltfzXtziBtLG00XswaNQs4tKz8cXhsPP9g=;
        b=LWpXFetfzT0pQnZTKWEpN/An+6/vgd/DWPYr4GDEcUGmyHwETJ51N4QykF8hXEc61c
         DpqBXpqwMEjjnHWNaDhdIpLzMrrMlaz2l5HDXKA1GFTyDImKawuMb+45oKXFrN8a14mU
         vNT46wecpSfd6qNpqNRr40lJB02efvaEzbMcIG9pqT2tbIR0aR51H9bXqfo0MSlcZou3
         nLH+8Q1fiQDmh9EzkBwVDXB9l2DZEKMFWXeE6p8eCcG+YzwIoGboBSZSsNsBlk1CvUsG
         qUTV7kiUV/aBP7B4waYJQdIzIdNp7RZu/WWUO+/lnwD7kXJ1pQyKam0GKu1te1ppiMo/
         sS5w==
X-Forwarded-Encrypted: i=1; AJvYcCUSei0fsUr8Qi1sUyfII6n5v8dpLYRAdrx5EWOBJeKvO7pRczIjsrm7bV+6kmHr06DFA6/7rBL0L3faDEbCsJCtP3sUy6SFRM8xnp+l
X-Gm-Message-State: AOJu0YzlCcVgKbOZaJWxP2QwfCjZQ7x8CN+RdDz2V/+B3aQIygX21yW2
	8jI8MJa633omm+8mtgXxBzrxB6xFegOf6R9YzCt4B5HZBObyK/MGW/04E5SmgkBHD9uKzihXjww
	Wbhc2R161IcHAJelWErntfqklM70qWLRdyILJD3XsvINvLxcdXXKSk9u6LI60+w==
X-Received: by 2002:a05:690c:c05:b0:617:c383:42ac with SMTP id 00721157ae682-627e4881df3mr20821287b3.51.1716386065138;
        Wed, 22 May 2024 06:54:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7xpeEUmg2uxpdElJ25Mb7knQ6eFjrUw3gOJjJBwd+5WX3qG09NwP0YmI7ax9qVHNRFuqrZA==
X-Received: by 2002:a05:690c:c05:b0:617:c383:42ac with SMTP id 00721157ae682-627e4881df3mr20821107b3.51.1716386064532;
        Wed, 22 May 2024 06:54:24 -0700 (PDT)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6aa10d89780sm33681216d6.94.2024.05.22.06.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 06:54:24 -0700 (PDT)
Date: Wed, 22 May 2024 09:54:23 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Yajun Deng <yajun.deng@linux.dev>, Zhang Jianhua <chris.zjh@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nick Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] arm64: init: override deferred_page_init_max_threads
Message-ID: <4ivthmwoi6xjdu6dxl7wir7xcy34un7cwll5crt7rf5666u4ci@rjliv4emytdr>
References: <20240520231555.395979-5-echanude@redhat.com>
 <ZkzHX-4yYybEJdEQ@kernel.org>
 <xu2rcjwh35zdxx7c52ygep26dox3glnurfcuxuhj3sjqbopzij@zrazmowdb3x2>
 <87plte2ccs.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plte2ccs.fsf@mail.lhotse>

On Wed, May 22, 2024 at 11:41:07PM +1000, Michael Ellerman wrote:
> Eric Chanudet <echanude@redhat.com> writes:
> > On Tue, May 21, 2024 at 07:10:07PM +0300, Mike Rapoport wrote:
> >> (added powerpc folks)
> 
> Thanks Mike.
> 
> >> On Mon, May 20, 2024 at 07:15:59PM -0400, Eric Chanudet wrote:
> >> > This was the behavior prior to making the function arch-specific with
> >> > commit ecd096506922 ("mm: make deferred init's max threads
> >> > arch-specific")
> >> > 
> >> > Architectures can override the generic implementation that uses only one
> >> > CPU. Setting DEFERRED_STRUCT_PAGE_INIT and testing on a few arm64
> >> > platforms shows faster deferred_init_memmap completions:
> >> > 
> >> > |         | x13s        | SA8775p-ride | Ampere R137-P31 | Ampere HR330 |
> >> > |         | Metal, 32GB | VM, 36GB     | VM, 58GB        | Metal, 128GB |
> >> > |         | 8cpus       | 8cpus        | 8cpus           | 32cpus       |
> >> > |---------|-------------|--------------|-----------------|--------------|
> >> > | threads |  ms     (%) | ms       (%) |  ms         (%) |  ms      (%) |
> >> > |---------|-------------|--------------|-----------------|--------------|
> >> > | 1       | 108    (0%) | 72      (0%) | 224        (0%) | 324     (0%) |
> >> > | cpus    |  24  (-77%) | 36    (-50%) |  40      (-82%) |  56   (-82%) |
> 
> How did you measure this, just some printks in page_alloc_init_late() or
> something more sophisticated? Just so I can do some comparable measurements.

I used the existing pr_info in deferred_init_memmap().

> >> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> > index 9b5ab6818f7f..71f5188fe63d 100644
> >> > --- a/arch/arm64/mm/init.c
> >> > +++ b/arch/arm64/mm/init.c
> >> > @@ -158,6 +158,13 @@ static void __init zone_sizes_init(void)
> >> >  	free_area_init(max_zone_pfns);
> >> >  }
> >> >  
> >> > +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> >> > +int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask)
> >> > +{
> >> > +	return max_t(int, cpumask_weight(node_cpumask), 1);
> >> > +}
> >> > +#endif
> >> > +
> >> 
> >> Maybe we should make this default and let architectures that want a single
> >> thread override deferred_page_init_max_threads() to return 1?
> >
> > It would affect more archs than I can try this on. Currently, only x86
> > (with this change, arm64) return more than one thread.
> 
> I can test powerpc and we can find someone to test s390. No other
> arches have it enabled in their defconfig.

Many thanks!

> > I'm happy to send a v2 inverting the logic if you find it preferable.
> 
> That seems preferable. It's a scalability feature, it makes no sense for
> the default to be a single thread AFAICS.

Understood, I'll respin.

-- 
Eric Chanudet


