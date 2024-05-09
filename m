Return-Path: <linux-kernel+bounces-174437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D758C0EAC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 13:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440D81C21D64
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2C71311B8;
	Thu,  9 May 2024 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zPOaFnk9"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA71A12FB0A
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715252742; cv=none; b=Neh+gCzpQs5jox70nKP7KMMxdr/xL2n6FNpSLRYN25Fp37ZRt7HDo5v6gOgjDmTuhTo6yXiYH9VCI0eRATb4CJCbdo/EV8pp1OymEZmZhb3LuZv9CYW8A7A90tP2hIVANOkQ2ZCIynvL3IkVTdqOZh2JBtRvNHlPOYiqaD9zSLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715252742; c=relaxed/simple;
	bh=qYcuYJcsvd932hxxmJk2Q5337yfwZq0inWZSf6fynXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZo49FeqO1+DYfGAk+3KA6G9fg2O+It/6dyO9jO20JW2k6LSZMy1EI4KTKrZ8bQ7TxjjbyzQQ3YS4rCDDZCbE5d5wdWQJObvbybSxnExuIxEEpXTdP3gNPDfnt1kRqdqg2cg7+VP2mFyuKkI6UJyvA4amdDXO176Phy4DtzjwgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zPOaFnk9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5a1192c664so195782066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 04:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715252739; x=1715857539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=if+Id8ngxnktCMRBldLjA3n7XZopNpgwUvJ4D4xVr5Y=;
        b=zPOaFnk9b6rXGU5RlrZhduk7WdbLkZY/Y2Zt+DyvvyF2p0xKMd6C9PY7EmSNBmnOU0
         TSGR8uymEe8+r/ojrs2fejvhABjDItOI7R1ODT3gkn8AQJvqmTBqQAOL++UtCAqemojX
         u6pa5Dh3Ijit5eKM3gy3+UPn4z30oP116BQp+r61SnoqEec29zCBKd/Cu2RhGkUHYbQb
         nL2DVuveJQ/WFnBd8KhSkLu5T2mb0QyW1SJeIMqx4E3FmoWtGnV4tmq0ROUulpc/n+TI
         znIwD5xAQfxeXidG+a7Q7i3C1F3ScG3NomFGt7YoNv8nLtLWq18oJxhxlsC3GaOSJRHU
         KhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715252739; x=1715857539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=if+Id8ngxnktCMRBldLjA3n7XZopNpgwUvJ4D4xVr5Y=;
        b=qMPZwEVwP39CqfPy6gXUUhtYslbsjjaGBbKfIeodqd+twx3eN4GkNHCMLo11ZM92ix
         CFL+s0MdJHFVaFVwS2CdBK76ZAm+W79K9dfw/8Zi9JoDK/V5f2aUKgwkY6p3ClrhYtzj
         mj2gFsTF5e3Bl6Pg+0Yoqm7BTYcV+GVLPZ++BT8pKhojNVnP0xme4ND6i1e6DUVzgoo2
         ZI2Q/4E8ECH8FELf5UyYdWAtDZ40v7zOIID6RRUW5Xmp2+u2j3wJl0PgepZPTGSEpvz2
         mfzM0KaMlpgI7X/0No1ORaOwg2B7ZyxDTsTop+ZjGkyup2/Y1hVblOJo6/bgxJN31OqR
         A61g==
X-Forwarded-Encrypted: i=1; AJvYcCWirXCZAA93dB07YUKVLIuSOz8kzdDecduK1OFSNUEXdvEdpBswY+7Fxvir6ywUCg34s8b6+2sPwH+pzAxU7B6nvtzenTVmMOH6Ebor
X-Gm-Message-State: AOJu0YzzxirbGxvpeYKemrIQW4Bku6Orbo4s47+H0+4Alg1WxrHRam33
	jqDJFNgDDysLxVr9yhgYz6BMr72BZGdYv95Yn9GubRYz4yHUzHQjDzpUvNQo+w==
X-Google-Smtp-Source: AGHT+IE0nAIbR0Q+rxqoyGrg+GpqFGhchDBkR0I2Wpg9W7zOo88pRNhNnSdEOFZc6wJp37mJt0hKEg==
X-Received: by 2002:a17:907:7084:b0:a59:a64d:c5b9 with SMTP id a640c23a62f3a-a59fb9dcd97mr514760566b.76.1715252738913;
        Thu, 09 May 2024 04:05:38 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17555sm61158766b.189.2024.05.09.04.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 04:05:38 -0700 (PDT)
Date: Thu, 9 May 2024 12:05:30 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, rdunlap@infradead.org, rppt@kernel.org,
	david@redhat.com, linux-mm@kvack.org
Subject: Re: [PATCH v22 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <Zjyt-nX3el5nnDPm@google.com>
References: <20240430111354.637356-1-vdonnefort@google.com>
 <20240430111354.637356-3-vdonnefort@google.com>
 <20240507223402.206d6ddc@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507223402.206d6ddc@rorschach.local.home>

On Tue, May 07, 2024 at 10:34:02PM -0400, Steven Rostedt wrote:
> On Tue, 30 Apr 2024 12:13:51 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > +#ifdef CONFIG_MMU
> > +static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
> > +			struct vm_area_struct *vma)
> > +{
> > +	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
> > +	unsigned int subbuf_pages, subbuf_order;
> > +	struct page **pages;
> > +	int p = 0, s = 0;
> > +	int err;
> > +
> > +	/* Refuse MP_PRIVATE or writable mappings */
> > +	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
> > +	    !(vma->vm_flags & VM_MAYSHARE))
> > +		return -EPERM;
> > +
> > +	/*
> > +	 * Make sure the mapping cannot become writable later. Also tell the VM
> > +	 * to not touch these pages (VM_DONTCOPY | VM_DONTEXPAND). Finally,
> > +	 * prevent migration, GUP and dump (VM_IO).
> > +	 */
> > +	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_IO, VM_MAYWRITE);
> 
> Do we really need the VM_IO?
> 
> When testing this in gdb, I would get:
> 
> (gdb) p tmap->map->subbuf_size
> Cannot access memory at address 0x7ffff7fc2008
> 
> It appears that you can't ptrace IO memory. When I removed that flag,
> gdb has no problem reading that memory.

Yeah, VM_IO indeed implies DONTDUMP. VM_IO was part of Linus recommendations.
But perhaps, VM_DONTEXPAND and MIXEDMAP (implicitely set by vm_insert_pages) are
enough protection?

I don't see how anything could use GUP there and as David pointed-out on the
previous version, it doesn't event prevent the GUP-fast path.

> 
> I think we should drop that flag.
> 
> Can you send a v23 with that removed, Shuah's update, and also the
> change below:

Ack.

[...]

