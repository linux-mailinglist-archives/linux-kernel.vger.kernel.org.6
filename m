Return-Path: <linux-kernel+bounces-364821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459B599D9DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68ABF1C217ED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98B21D5AB6;
	Mon, 14 Oct 2024 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="sdbVnrpc"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0871CF2AF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728945623; cv=none; b=O6CyKuKjWoz2wa5NgQQOz6DjvQvgs7P5JLQwCo9G+FwXYAg/+guUSvx920HnsPGQvC20IannoM0fPfGyDCdksGtgu8+/avnL6gXEHD7yDoSzHZJBDDEcMDdrXiUDEvYrKqOeghLgSUNvmLXPOKGmkHRAqWAciq051Rx/aGjuYHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728945623; c=relaxed/simple;
	bh=eJB5nm0LGipv6GkGY/aV3TbZ2J8W3GzqGON/tG1P9rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZXemL/k/vwWg1ZgaXShQa/Bv8kjt6Tc9rpSds3trGcuUUV5eDqmtt/fI+lM2h9rf5XzQ02r09Us/nGFstaWCu6Jn7XNA4YHOEx3hTnh5OZY0v7/faCzF3JHr8k+y5n9lelY8bxDrPqu0D8knfKJf6DI6jaH3jBvkt/Tg99S5iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=sdbVnrpc; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbcd8ce5f9so42501566d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728945621; x=1729550421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aYw/DowXMP8iT0vBm8bMBxhj8l9VIuy2ovueWWo/kGY=;
        b=sdbVnrpc4qcOrKPNsoHaC9fqjG9Voe2SSIiI/Cr5MacX/6CVypRYnnq7dEovbpVlxQ
         scyn/jP7ySDvyHgw1FfMaSaqeGQJgz8uRiVNsgyGnm+fXzV+8g6Qt4CLV+w5RGNkZ2CP
         s7WoTnGNvvNO1njtc2IbRub/NFE4TiVYMqghqEJw0hrG9IqrOpt4vMrgGHD4tJj7lisc
         +dwqXsgCV6KQgeSaW0Sd2rXgwtaGdyBaLvbhAGrfaWt18ITeXvRPHH9ulVzHJMjRSdkI
         XQ8Ffz3qk0UQ7R28wWELQim97cIvQJKakWXCwbA7VHoo1Gl8VrUczX1P+9JDyz60MTs0
         hLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728945621; x=1729550421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYw/DowXMP8iT0vBm8bMBxhj8l9VIuy2ovueWWo/kGY=;
        b=qc0SL+0lGiVTeH5Fb47MG4Alb6qvKaex3+62ub8XhPzZIvY0z0kQsEeCPweX14XjWi
         rKfKs5g+8d2tQAWwqFj1GA87XlmJnSfjLKHIoHFT0Gwnu3a/x+zaxV5M0YfUyKbuTiNI
         tyU7wFxVq3x3tSzpKXGk148dMsd518G67dtgtLqb51sKlEV7tuFPtfZzwFGryscGj1Xr
         iS3v5XZDpd5dcEYNFn8fp6gq4Npy571m0sAiA8K/40REFpVyTsZ6n4g4l4zKhesIrZwG
         5ZJe1yTI5KLI/X+89KnX3fqj9ifJDTh9T9ofyD43TBw1teolM18ZSKt+snrTFJGbYmRl
         VW5A==
X-Forwarded-Encrypted: i=1; AJvYcCX+XgD19GHc/a8nWo/S43eFcVKq57ws+6x0ZIuDmlJVGqu/sBM0aKJ/2zO3Fi7V9PNEjTjQOPj82ZrgvCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznf/qxQBD5dSrQricM9OEiD+xDbz5XAviMpvp6tmF6u6IFR/zF
	JiqWe1qSqbSfnG4dxK7RzNrLDOLm53qY3j9M1qIipvbvvR9NZnwZIy9SPu1f5vM=
X-Google-Smtp-Source: AGHT+IEF3dKRKqarTnBYXO5TAih258zYEUVmUl9i+Hckz/OMf3T05ro3fHPweLsgT86eMNWxUx0sCQ==
X-Received: by 2002:a05:6214:33c3:b0:6cc:1dd9:296 with SMTP id 6a1803df08f44-6cc1dd9048bmr26873916d6.0.1728945621142;
        Mon, 14 Oct 2024 15:40:21 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cc22910ecfsm392706d6.23.2024.10.14.15.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 15:40:19 -0700 (PDT)
Date: Mon, 14 Oct 2024 18:40:00 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: linux-cxl@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
	rrichter@amd.com, terry.bowman@amd.com, lenb@kernel.org,
	dave.jiang@intel.com, ira.weiny@intel.com
Subject: Re: [PATCH 1/3] memory: extern memory_block_size_bytes and
 set_memory_block_size_order
Message-ID: <Zw2dwG_rp7Hg-vIa@PC2K9PVX.TheFacebook.com>
References: <20241008044355.4325-1-gourry@gourry.net>
 <20241008044355.4325-2-gourry@gourry.net>
 <039e8c87-c5da-4469-b10e-e57dd5662cff@redhat.com>
 <ZwVG8Z3GRYLoL_Jk@PC2K9PVX.TheFacebook.com>
 <d3203f2c-eff6-4e84-80cd-3c6f58dab292@redhat.com>
 <ZwVOE6JRS8Fd9_a8@PC2K9PVX.TheFacebook.com>
 <2c854e5e-c200-4ed9-bf21-778779af7e5b@redhat.com>
 <Zw0p7-7ymn-0bPiC@PC2K9PVX.TheFacebook.com>
 <01fbdcef-b923-4bb0-80b0-f1d3e57fe515@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01fbdcef-b923-4bb0-80b0-f1d3e57fe515@redhat.com>

On Mon, Oct 14, 2024 at 10:32:36PM +0200, David Hildenbrand wrote:
> On 14.10.24 16:25, Gregory Price wrote:
> > On Mon, Oct 14, 2024 at 01:54:27PM +0200, David Hildenbrand wrote:
> > > On 08.10.24 17:21, Gregory Price wrote:
> > > > On Tue, Oct 08, 2024 at 05:02:33PM +0200, David Hildenbrand wrote:
> > > > > On 08.10.24 16:51, Gregory Price wrote:
> > > > > > > > +int __weak set_memory_block_size_order(unsigned int order)
> > > > > > > > +{
> > > > > > > > +	return -ENODEV;
> > > > > > > > +}
> > > > > > > > +EXPORT_SYMBOL_GPL(set_memory_block_size_order);
> > > > > > > 
> > > > > > > I can understand what you are trying to achieve, but letting arbitrary
> > > > > > > modules mess with this sounds like a bad idea.
> > > > > > > 
> > > > > > 
> > > > > > I suppose the alternative is trying to scan the CEDT from inside each
> > > > > > machine, rather than the ACPI driver?  Seems less maintainable.
> > > > > > 
> > > > > > I don't entirely disagree with your comment.  I hummed and hawwed over
> > > > > > externing this - hence the warning in the x86 machine.
> > > > > > 
> > > > > > Open to better answers.
> > > > > 
> > > > > Maybe an interface to add more restrictions on the maximum size might be
> > > > > better (instead of setting the size/order, you would impose another upper
> > > > > limit).
> > > > 
> > > > That is effectively what set_memory_block_size_order is, though.  Once
> > > > blocks are exposed to the allocators, its no longer safe to change the
> > > > size (in part because it was built assuming it wouldn't change, but I
> > > > imagine there are other dragons waiting in the shadows to bite me).
> > > 
> > > Yes, we must run very early.
> > > 
> > > How is this supposed to interact with code like
> > > 
> > > set_block_size()
> > > 
> > > that also calls set_memory_block_size_order() on UV systems (assuming there
> > > will be CXL support sooner or later?)?
> > > 
> > > 
> > 
> > Tying the other email to this one - just clarifying the way forward here.
> > 
> > It sounds like you're saying at a minimum drop EXPORT tags to prevent
> > modules from calling it - but it also sounds like built-ins need to be
> > prevented from touching it as well after a certain point in early boot.
> 
> Right, at least the EXPORT is not required.
> 
> > 
> > Do you think I should go down the advise() path as suggested by Ira,
> > just adding a arch_lock_blocksize() bit and have set_..._order check it,
> > or should we just move towards each architecture having to go through
> > the ACPI:CEDT itself?
> 
> Let's summarize what we currently have on x86 is:
> 
> 1) probe_memory_block_size()
> 
> Triggered on first memory_block_size_bytes() invocation. Makes a decision
> based on:
> 
> a) Already set size using set_memory_block_size_order()
> b) RAM size
> c) Bare metal vs. virt (bare metal -> use max)
> d) Virt: largest block size aligned to memory end
> 
> 
> 2) set_memory_block_size_order()
> 
> Triggered by set_block_size() on UV systems.
> 
> 
> I don't think set_memory_block_size_order() is the right tool to use. We
> just want to leave that alone I think -- it's a direct translation of a
> kernel cmdline parameter that should win.
> 
> You essentially want to tweak the b)->d) logic to take other alignment into
> consideration.
> 
> Maybe have some simple callback mechanism probe_memory_block_size() that can
> consult other sources for alignment requirements?
>

Thanks for this - I'll cobble something together.

Probably this ends up falling out similar to what Ira suggested. 

drivers/acpi/numa/srat.c
    acpi_numa_init():
        order = parse_cfwm(...)
        memblock_advise_size(order);

drivers/base/memory.c
    static int memblock_size_order = 0; /* let arch choose */

    int memblock_advise_size(order)
        int old_order;
        int new_order;
        if (order <= 0)
            return -EINVAL;

        do {
            old_order = memblock_size_order;
            new_order = MIN(old_order, order);
        } while (!atomic_cmpxchg(&memblock_size_order, old_order, new_order));

        /* memblock_size_order is now <= order, if -1 then the probe won */
        return new_order;

    int memblock_probe_size()
        return atomic_xchg(&memblock_size_order, -1);

drivers/base/memblock.h
    #ifdef HOTPLUG
        export memblock_advise_size()
        export memblock_probe_size()
    #else
        static memblock_advice_size() { return -ENODEV; } /* always fail */
        static memblock_probe_size() { return 0; } /* arch chooses */
    #endif

arch/*/mm/...
    probe_block_size():
        memblock_probe_size();
        /* select minimum across above suggested values */

> If that's not an option, then another way to set further min-alignment
> requirements (whereby we take MIN(old_align, new_align))?
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

