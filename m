Return-Path: <linux-kernel+bounces-175613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0898C229A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D98280E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C199016D30F;
	Fri, 10 May 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQ25DLgW"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAD4165FBA
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338655; cv=none; b=bq1tIP23CpV3dINU9UzjA4xftI6Aw5COa7r92w9ouB7kKGPk9HOExnWXejEo6JHE8kIeBeQ7PTmsjbj5gqYbSmDgk7s5JKhtuMqpmqJZqfpwMjpFp30R26q1GvW1lSyOLzSONC09dimMmJ/bE3G6e6yc6a/M5TuAT2WItf9RW7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338655; c=relaxed/simple;
	bh=cjgcAWVv5Bo/YeZI3kvikIIsbSgwvMqSIa/FRD6Zxs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnE1RUxp7GEeK0mr4OoARW1oBdxoDOvM9gjmJy47BRgkCcSQQOvOSc0qEH6JeaCowrW8HDDXUpoVT2XWIODYXI8Ix1i367JMeDe7nKtQ1l3JV9SDFAEK4szuhyqU32ieMmK/aMGVIjMlbNxB4LNfI7FJyVFo2SDi2X2h+bOe2tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQ25DLgW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34db6a299b8so1374750f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 03:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715338652; x=1715943452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dp/XMRc3/SUPNon/uFsMVaqZ4kfK6CtKO7+TjQctSZQ=;
        b=aQ25DLgWPj1AE3yNRz1ct4tyqZ1KZ7FupKY+p5kKD7vZ9EQdYecghjM8SuFKu5BNbJ
         TVYHcwC8uHr6syftGnkc0HhbgKykKuBP9YpLL4KJ4zTIuOn/H7O+QZQoQTQufNGm+ARh
         GGh1LIeVzPbnpOfBhKlmlZ/aMeL/Y6zeDc6LEnt0ZrDzjemA/kygojvEGJFcjyZAmBsA
         ZInB11/qTNiisz6RnGhU3D/DjBJFo0el9IHY0h5c9OYKoCRfcfRkm9/oEtUWTQtyV0+v
         0BZYBDJWi/FAIlvNWIxlOyv5RR/uGTQ5JHn+JeOn5x1kflo5Fg9NifHYufx0hXj9Ic+H
         PVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715338652; x=1715943452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dp/XMRc3/SUPNon/uFsMVaqZ4kfK6CtKO7+TjQctSZQ=;
        b=hT0d9gfwOHzoGk9gViRiyiHEwFZzFOuR8pe0C4bUwRibZYF4ENpo4BkUGBk8y/CZTF
         bq46ETp/VnMN8pxwtpJfX6sVg5ZXlXudXJMLIiundU420R87aVH3DShhwC9PcQXRMEbU
         9ypLwZLB5qnc82UMkoynlsaRuhkxsnPFnhczUhixdmNhuHqbXiRVl/uFeZmUAyc62vDB
         eWxmJVWmvDxpZZgsSi7FdviiuYZeCbYLIoFCmbvAF3gATE2pr0HU7wzRE9vQ3I2vRGY+
         1Jo5ZWDJ8D3/WnHfLBwlBU9p6s6bAOTuR0iZvN4YNkwOsHEdqoJmInQjSYyAZssDbrpe
         l35A==
X-Forwarded-Encrypted: i=1; AJvYcCUPNRuQkEUC+Y/sLYV7hdTzJIWJBqDloNr9L/nNmtiWB8/iWqTQDjFEN+mLnsNPHREsGvIznAl9LOwGsuxJchZwfTR2/YNgQS5MGxhB
X-Gm-Message-State: AOJu0Yzr+vHZCheSBZ8dVjZUThfQZJZu0Ww0OdzIMcsPnEck9bTTsw42
	TCBI3Zh4N92a2HH5qgXQTAxH9OBQTiwZD82R7YBZbbUlXPcPqJs/Aa1/hJRIDQ==
X-Google-Smtp-Source: AGHT+IFjcYYXvbW95PWolvFZSTIIDyVPwVIojns7gQV2ajr4PLZuds+mcH1U+86bmvy4Od3CewIhiw==
X-Received: by 2002:a5d:5490:0:b0:34d:95e2:c5cb with SMTP id ffacd0b85a97d-3504a61d36amr1555935f8f.3.1715338651401;
        Fri, 10 May 2024 03:57:31 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bca6sm4238664f8f.12.2024.05.10.03.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 03:57:31 -0700 (PDT)
Date: Fri, 10 May 2024 11:57:27 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	rdunlap@infradead.org, rppt@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v22 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <Zj39l4EKmtNU6Rv6@google.com>
References: <20240430111354.637356-1-vdonnefort@google.com>
 <20240430111354.637356-3-vdonnefort@google.com>
 <20240507223402.206d6ddc@rorschach.local.home>
 <Zjyt-nX3el5nnDPm@google.com>
 <c36689df-cfad-46f5-835e-54073b6454a4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c36689df-cfad-46f5-835e-54073b6454a4@redhat.com>

On Fri, May 10, 2024 at 11:15:59AM +0200, David Hildenbrand wrote:
> On 09.05.24 13:05, Vincent Donnefort wrote:
> > On Tue, May 07, 2024 at 10:34:02PM -0400, Steven Rostedt wrote:
> > > On Tue, 30 Apr 2024 12:13:51 +0100
> > > Vincent Donnefort <vdonnefort@google.com> wrote:
> > > 
> > > > +#ifdef CONFIG_MMU
> > > > +static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
> > > > +			struct vm_area_struct *vma)
> > > > +{
> > > > +	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
> > > > +	unsigned int subbuf_pages, subbuf_order;
> > > > +	struct page **pages;
> > > > +	int p = 0, s = 0;
> > > > +	int err;
> > > > +
> > > > +	/* Refuse MP_PRIVATE or writable mappings */
> > > > +	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
> > > > +	    !(vma->vm_flags & VM_MAYSHARE))
> > > > +		return -EPERM;
> > > > +
> > > > +	/*
> > > > +	 * Make sure the mapping cannot become writable later. Also tell the VM
> > > > +	 * to not touch these pages (VM_DONTCOPY | VM_DONTEXPAND). Finally,
> > > > +	 * prevent migration, GUP and dump (VM_IO).
> > > > +	 */
> > > > +	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_IO, VM_MAYWRITE);
> > > 
> > > Do we really need the VM_IO?
> > > 
> > > When testing this in gdb, I would get:
> > > 
> > > (gdb) p tmap->map->subbuf_size
> > > Cannot access memory at address 0x7ffff7fc2008
> > > 
> > > It appears that you can't ptrace IO memory. When I removed that flag,
> > > gdb has no problem reading that memory.
> > 
> > Yeah, VM_IO indeed implies DONTDUMP. VM_IO was part of Linus recommendations.
> 
> Yes, the VM should recognize that memory to some degree as being special
> already due to VM_MIXEDMAP and VM_DONTEXPAND.
> 
> #define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
> 
> So any of these flag achieve that (e.g., mlock_fixup() checks VM_SPECIAL).
> KSM similarly skips VM_DONTEXPAND and VM_MIXEDMAP (likely we should be using
> VM_SPECIAL in vma_ksm_compatible()). Not sure about page migration, likely
> its fine.
> 
> Thinking about MADV_DONTNEED, I can spot in
> madvise_dontneed_free_valid_vma() only that we disallow primarily VM_PFNMAP.
> 
> ... I assume if user space MADV_DONTNEED's some pages we'll simply get a
> page fault later on access that will SIGBUS, handling that gracefully (we
> should double-check!).

I've just tested and indeed, I get a SIGBUS! All good there.

> 
> 
> > But perhaps, VM_DONTEXPAND and MIXEDMAP (implicitely set by vm_insert_pages) are
> > enough protection?
> 
> Do we want to dump these pages? VM_DONTDUMP might be reasonabe then. 

Somehow I thought this would prevent ptrace as well, but I've just tested it and
this is not the case as well. So let's keep DONTDUMP.

Thanks!

> 
> > 
> > I don't see how anything could use GUP there and as David pointed-out on the
> > previous version, it doesn't event prevent the GUP-fast path.
> 
> Yes, GUP-fast would still have worked under some conditions.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

