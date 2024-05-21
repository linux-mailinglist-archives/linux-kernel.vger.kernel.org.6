Return-Path: <linux-kernel+bounces-185501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2158CB5F0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 00:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1F11C21A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902D9149E05;
	Tue, 21 May 2024 22:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTn8NoLr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285A81865A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716330106; cv=none; b=uHrffkj2PNhfWLSZTumeS7XEqaTJStVt0oHa/eVrPIebHvCfU3DMyvY/yTX4KcLC97Ul8n2oh+Y4TRucxfY4rwo0vHay2BEsJLyjPjB9cxuZIlr/NA97emuMZ/i7D/NHXkNtcDR4DEXAYtcz0RX0ltW/Dddhg1xlAwtbrp0g7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716330106; c=relaxed/simple;
	bh=YcvDZqU/P46ZTkDSYssag9qjA1oPeYrDrhINEr556sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Il/eodNF+odwQv418VNH0fHjjyEZobj2GsELyjqzDTU0lfL6zHs3e1vSdk+HHnbxytX3rhy84TxzSSIDQLtk0vBJzmc2Yuz25rp4VUiY/6RePzHq/vFRFa+2yBET4ZHaFdgliYC3A3Q8Ktoylc3+im1LFKx79Jv/r5fPpOKhwnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GTn8NoLr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716330103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8RWybJhhMR6yLC10OGnOp+yHf/Jzy4lTuvgT0noPzW0=;
	b=GTn8NoLrtQFewKlko67rtQSL3GyI+hRYr6i7eYMkpUCJorld6dYqBTDTtG3Ep4UCgwC/U7
	kmEitR57CLHgBN4JrnN25cqeMw6Un6lUei+spKuO6xSMnyPznTeVJ6Br/XneCBNpdymd72
	y3G36wojNZArP24JaRcaX1Zn+C+r3hc=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-NPvid_X4NPyC2st9COIaJA-1; Tue, 21 May 2024 18:21:42 -0400
X-MC-Unique: NPvid_X4NPyC2st9COIaJA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3c9a6d6a8dbso6851807b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716330102; x=1716934902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RWybJhhMR6yLC10OGnOp+yHf/Jzy4lTuvgT0noPzW0=;
        b=T678KQh1zI+7ZX1N3nlYv8+WFuKgjyqYbAf1mF1RuSHZ2aDSSMmU2kS4F7frooB1oD
         Lq7qloaw6tCnHClwIOma0dmGFkJm2Nm91eXN5yFhFAKeMcGM/bNyS1EmPVe69AB/yuY0
         lDAQb+AqqD7HgV2co3p1Im2mV2njkpnVwf4kFN13B6TMvtTY9+ndhRkA47h3HYWy2OTs
         1e01bsonPfdVHBYo36RLs3Q0MFpklqBCARYTZTLafvA+Dz+PLQdSSM3pTaVmD0g/0NDP
         DKiiFxlzxJtknc6EVcqVtCmSrT10pkwNP5Avq1TDfQKOVXZ4NSdstqp9SMQWegM0i+UL
         rmgA==
X-Forwarded-Encrypted: i=1; AJvYcCWejga0h/lJnYYAMGh1pm7JGIS2N7zrjgsYkgzTDpZulL+Pb1JF/hJDKlp56GnWBtZL07DZ7YLQeKI7M+TblpEJ/2/2fxJVr/7iDxYJ
X-Gm-Message-State: AOJu0YwUidFyWu+bKL7+sxOky43jkaZupB2xNR9eiAMISc0fT1NMl6dr
	lsY8rPP92wlIFYgPsb9XQCN9RdgXzhU9V7DCTNi0y+CvNXl0l1Rg6XqtSHwoGjyLzqleKP+ORpf
	jlbuYEFfqTkT7o55VFq4PDznqn+RuFEdcyKbrcaUXJnwfyK9dNweBxlMcC8MC9g==
X-Received: by 2002:a05:6808:3af:b0:3c9:9378:f812 with SMTP id 5614622812f47-3cdb9d39ff8mr398767b6e.39.1716330101699;
        Tue, 21 May 2024 15:21:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZjyboiqH7UQvgyK4AKU1tUuDW+gGANTnn6z4ncSTCw9M4SbeMnP15PyLRdiW9PhMlpk62Eg==
X-Received: by 2002:a05:6808:3af:b0:3c9:9378:f812 with SMTP id 5614622812f47-3cdb9d39ff8mr398736b6e.39.1716330100982;
        Tue, 21 May 2024 15:21:40 -0700 (PDT)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf275861sm1330673485a.19.2024.05.21.15.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 15:21:40 -0700 (PDT)
Date: Tue, 21 May 2024 18:21:39 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Baoquan He <bhe@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Yajun Deng <yajun.deng@linux.dev>, Zhang Jianhua <chris.zjh@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Nick Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] arm64: init: override deferred_page_init_max_threads
Message-ID: <xu2rcjwh35zdxx7c52ygep26dox3glnurfcuxuhj3sjqbopzij@zrazmowdb3x2>
References: <20240520231555.395979-5-echanude@redhat.com>
 <ZkzHX-4yYybEJdEQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkzHX-4yYybEJdEQ@kernel.org>

On Tue, May 21, 2024 at 07:10:07PM +0300, Mike Rapoport wrote:
> (added powerpc folks)
> 
> On Mon, May 20, 2024 at 07:15:59PM -0400, Eric Chanudet wrote:
> > This was the behavior prior to making the function arch-specific with
> > commit ecd096506922 ("mm: make deferred init's max threads
> > arch-specific")
> > 
> > Architectures can override the generic implementation that uses only one
> > CPU. Setting DEFERRED_STRUCT_PAGE_INIT and testing on a few arm64
> > platforms shows faster deferred_init_memmap completions:
> > 
> > |         | x13s        | SA8775p-ride | Ampere R137-P31 | Ampere HR330 |
> > |         | Metal, 32GB | VM, 36GB     | VM, 58GB        | Metal, 128GB |
> > |         | 8cpus       | 8cpus        | 8cpus           | 32cpus       |
> > |---------|-------------|--------------|-----------------|--------------|
> > | threads |  ms     (%) | ms       (%) |  ms         (%) |  ms      (%) |
> > |---------|-------------|--------------|-----------------|--------------|
> > | 1       | 108    (0%) | 72      (0%) | 224        (0%) | 324     (0%) |
> > | cpus    |  24  (-77%) | 36    (-50%) |  40      (-82%) |  56   (-82%) |
> > 
> > Signed-off-by: Eric Chanudet <echanude@redhat.com>
> > ---
> >  arch/arm64/mm/init.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 9b5ab6818f7f..71f5188fe63d 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -158,6 +158,13 @@ static void __init zone_sizes_init(void)
> >  	free_area_init(max_zone_pfns);
> >  }
> >  
> > +#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
> > +int __init deferred_page_init_max_threads(const struct cpumask *node_cpumask)
> > +{
> > +	return max_t(int, cpumask_weight(node_cpumask), 1);
> > +}
> > +#endif
> > +
> 
> Maybe we should make this default and let architectures that want a single
> thread override deferred_page_init_max_threads() to return 1?

It would affect more archs than I can try this on. Currently, only x86
(with this change, arm64) return more than one thread.

I'm happy to send a v2 inverting the logic if you find it preferable.

Best,

> >  int pfn_is_map_memory(unsigned long pfn)
> >  {
> >  	phys_addr_t addr = PFN_PHYS(pfn);
> > -- 
> > 2.44.0
> > 
> 
> -- 
> Sincerely yours,
> Mike.
> 

-- 
Eric Chanudet


