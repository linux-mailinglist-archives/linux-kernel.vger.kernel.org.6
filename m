Return-Path: <linux-kernel+bounces-374595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C239A6CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05BA281114
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7E71F940C;
	Mon, 21 Oct 2024 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KzJIYkmU"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6461EF0B9
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522290; cv=none; b=otf9N9lYn4STIHG0e/yaBj2nP1YjLxl8ZZ1OoBIBW/eVKmMhB6l868h8S29OnhrPtWNwCzNBrQ6nz+0w6v2Tj6cj7JK9PjRGZCDYSG7P3yYa6QlpF4TbgoHnK2+FwqM5AxvNKuBI+vKLC/YyYjxBQ5rhIJ5pxPe0PtHISUvuQoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522290; c=relaxed/simple;
	bh=QVHFdisx4eEjt0lCgGFJr6A8Y0gozB27bbYjgPgKtH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxMYpNZrZPfjYjGQcV5qeyhOBRxuuPjANUPvYm6tWPLhoJ8TRCL5pGegAYzBwFnq6EtUVIjG0DkffKSxWu9IsFWMd7rbWOpS58kkUBn5R1HPWUh/Gl6gfRdLUV3jg5JFuWc2zTAxE2E5+Oas6CWMuQav2ER5NPGvUL+xOJDAEzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KzJIYkmU; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71815313303so2187510a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729522288; x=1730127088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0LCFqGRL1GXXjFNSMHo10rPFkuAROAlT9eOq0w6KPjw=;
        b=KzJIYkmUXxuNGvQRPnh4cruC7wjdBdhg1WM3XaRyMZQ6rE7hq42wVwI3oFgq3imYIL
         Cw5Lz4g2guOURw5q9W8EWChAQR7JQhHxWpH6vWeWGivTHfbNuniMebhoaev9457Julrg
         cnoY1G/akWIPuBqU0+zoFAYjEVSS+9UiB/jVnM6QTJrj5Pw1OEMM0jePqyuPa7mF1CBh
         PIbgrzCbhZKyG0ncXZS8Ec+6xBPagGRaBpwojL05sxyjHKcfMFBwTIQNZT2kMsVqUCsS
         afwew6LeHmxqId5pTXJhXmc7Sh8Iwn6T2vAbW1aqqlLGMMyiEoXh1XbeXHhGv9KcbWv1
         cxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729522288; x=1730127088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LCFqGRL1GXXjFNSMHo10rPFkuAROAlT9eOq0w6KPjw=;
        b=SfuB4rwdpXdrgtTfP0rei7bep5k/kqxZhwgbVJKr8mMmhj2LwZr6GI2nEo6Nant2v6
         VBjFK63yViCVkhY2tO783DWi5wWsVqy+1U0/7lxNM8AneqqU381xHLoBen62SEWBsF7E
         3ExxIFFtk9IcvcXS7ZSLOPm4qMaYrjD3HUmLXoC0JWWq1iilLJqeMGdzjsFnHw40sdDd
         xIJieKrj/heh1+qsiWD6AZVTY/uaEI74RnT4hKP+Uz/NjE7iQeBuXVMcOLwptoYc8NZ5
         kQY2pQuArNye5104qNXY+KpCeFLw4xdsC1JpSp6AOIUHRCr4aqJnIRY6ojMtiGoedvOY
         3PZA==
X-Forwarded-Encrypted: i=1; AJvYcCVIezScNagUph0RQTS2PltbsoX1uhVehppJrutvur/Nt9yurenV4p0dnTM+5nYo0Unu0AksFKH/ujdodNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcdNDcbrtPHjliCZ6a2ApyJvqQPFgEElsoFSRTmBMScaWH5leL
	WeZYYBubGGeJuQusjm0Eh6aYsmUkpu1ZrexPbvpao/0zEXFnQ+4BfRi9R6Mtgjs=
X-Google-Smtp-Source: AGHT+IHcAvHvPa2U3uHHthKi6B0l3wXkXlDgXZwArI+r4vHFC+TJ7ZOjq7ukqAmwUA5y82uIugQ6AQ==
X-Received: by 2002:a05:6830:2703:b0:718:cc7:c6df with SMTP id 46e09a7af769-7181a89ee87mr6856700a34.22.1729522287780;
        Mon, 21 Oct 2024 07:51:27 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce0091bc72sm17782326d6.73.2024.10.21.07.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:51:27 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:51:28 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	dan.j.williams@intel.com, ira.weiny@intel.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	rafael@kernel.org, lenb@kernel.org, rppt@kernel.org,
	akpm@linux-foundation.org, alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com, rrichter@amd.com, ytcoode@gmail.com,
	haibo1.xu@intel.com, dave.jiang@intel.com
Subject: Re: [PATCH v2 0/3] mm/memblock,x86,acpi: hotplug memory alignment
 advisement
Message-ID: <ZxZqcPTPqJkg-ZIH@PC2K9PVX.TheFacebook.com>
References: <20241016192445.3118-1-gourry@gourry.net>
 <c811debe-32db-4c77-a799-ee89427a5174@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c811debe-32db-4c77-a799-ee89427a5174@redhat.com>

On Mon, Oct 21, 2024 at 11:51:38AM +0200, David Hildenbrand wrote:
> 
> 
> Am 16.10.24 um 21:24 schrieb Gregory Price:
> > When physical address regions are not aligned to memory block size,
> > the misaligned portion is lost (stranded capacity).
> > 
> > Block size (min/max/selected) is architecture defined. Most architectures
> > tend to use the minimum block size or some simplistic heurist. On x86,
> > memory block size increases up to 2GB, and is otherwise fitted to the
> > alignment of non-hotplug (special purpose memory).
> > 
> > CXL exposes its memory for management through the ACPI CEDT (CXL Early
> > Detection Table) in a field called the CXL Fixed Memory Window.  Per
> > the CXL specification, this memory must be aligned to at least 256MB.
> > 
> > When a CFMW aligns on a size less than the block size, this causes a
> > loss of up to 2GB per CFMW on x86.  It is not uncommon for CFMW to be
> > allocated per-device - though this behavior is BIOS defined.
> > 
> > This patch set provides 3 things:
> >   1) implement advise/probe functions in mm/memblock.c to report/probe
> >      architecture agnostic hotplug memory alignment advice.
> >   2) update x86 memblock size logic to consider the hotplug advice
> >   3) add code in acpi/numa/srat.c to report CFMW alignment advice
> > 
> > The advisement interfaces are design to be called during arch_init
> > code prior to allocator and smp_init.  start_kernel will call these
> > through setup_arch() (via acpi and mm/init_64.c on x86), which occurs
> > prior to mm_core_init and smp_init - so no need for atomics.
> > 
> > There's an attempt to signal callers to advise() that probe has already
> > occurred, but this is predicated on the notion that probe() actually
> > occurs (which presently only happens on x86). This is to assist debugging
> > future users who may mistakenly call this after allocator or smp init.
> > 
> > Likewise, if probe() occurs more than once, we return -EBUSY to prevent
> > inconsistent values from being reported - i.e. this interaction should
> > happen exactly once, and all other behavior is an error / the probed
> > value should be acquired via memory_block_size_bytes() instead.
> > 
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> 
> Just as a side note, a while ago there was a discussion about variable-sized
> memory blocks -- essentially removing memory_block_size_bytes().
>

If you have any links, happy to do some reading up on it.  Was going to look
into some more memblock behavior in the future so it's worth looking at.

> 
> The main issue is that this would change /sys/devices/system/memory/ in ways
> it could break existing user space. I believe there are other corner cases
> that are a bit nasty to handle (e.g., removing parts of a larger memory
> block), but likely it could be handled.
> 

This is why I wanted to avoid a new interface in the first place and just
piggyback on set_memory_block_size_order - now there are two interfaces to
do the same thing and more hurdles.  But I suppose the suggestive-nature of
this one makes it far less offensive since it can be completely ignored.

~Gregory

