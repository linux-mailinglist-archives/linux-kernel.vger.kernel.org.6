Return-Path: <linux-kernel+bounces-544184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFDFA4DE53
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB10175E3B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C161FC7FD;
	Tue,  4 Mar 2025 12:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="238FYJ17"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4F1202C48
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092624; cv=none; b=fnT7b7vYY17ZvVNl9XB67p4eyDLob9gxuCgFKfdrYNKhctzfw9i/+rzfXo5HqFtya+a+BmC5rYWG/QCMh6N5sCZaHlGdrBZH2Wb8prnbMyE1kLFZsgO66b/I6BF43ma6XxpfIKA7XIfga5M/nupDYIz5u53f4Tg6+f5hlq9LzRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092624; c=relaxed/simple;
	bh=nbGq81EdTNF4OCh1/VvqR49zOJHTP6QV6OWUNCKqC94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQ6/TQh/QEivQfpiEkJqo3b7cM0U2eowrqfDMBlwjdwsK5OdE4ZUQMX6QTq3jgXldCziPcrOnqmogMPLrAAEjqaPnfCyaid6RDNgMgCoDh7aoYygU5hPv03K0EW/YH9DYITlSdpuxTT/vtWG7tQQ9VX16FnDWB0OlsO+PPvBXo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=238FYJ17; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-438d9c391fcso54795e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 04:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741092621; x=1741697421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Za2+1iO7dL31cbQ2NJ7DZYtdHtY7Z5QXUzl1byI/FLw=;
        b=238FYJ17p5fH1SGFthEgGyk4lHbyBZDofFP8JODpwhWrPCOcBb/GKCmfwWyE0Htqo9
         WavmNHF/UlsJfPHurlf7sl45eZF3cI7ZUq18SzHIATV9UskBTfND66+00BZQunPAnkeB
         9gpR1K+a3oHlL9oBsdDCRxPO6BRvW1Js8kxYqD8hI15Se1qBo/0oMyCs8hScNgTmEyio
         dD6LKZV5/tQwHwLy2qVC59o3FwL5qEcay4XO2mmqk7uZuR830//FpSGv0YIcxNfB9jTb
         FS24GKq2+u86l0+NulXlmZM494CG+lufXNLR8aLpzX643B4Hc2S4jimIZyeJhBIb92mP
         9WGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741092621; x=1741697421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Za2+1iO7dL31cbQ2NJ7DZYtdHtY7Z5QXUzl1byI/FLw=;
        b=WzX7dzjV9OutMYB63yeC7XvfOG/YrRiyf+JgjiLF0CCmnCx4lIh+nG+K01qLIwY3+p
         w2jzgKtfhyag1mMSXef+lKGcPP0KH/pvAEkGlQuO/PLFDwMReYjrT6VQbFmgNRLJhyUJ
         WosH39qkyB5tEThAQRjKySIx8LmJECFz44hfsi3YjZ+oI4MO8wW6GZdQ5x1oKhMHl/5J
         hADKvbhTqKcyju0pbBFrdSSt1XTNwgV6PbocGEP3nkWUh5Tyi37/xkomvQk6Nx77lZp3
         ruFs3s4hkn0k30raCGxcKv5/2h2oBGPfOoi8QUWnY4Naul41zNwKyDYUhlcgRXRz2hq7
         tkAg==
X-Forwarded-Encrypted: i=1; AJvYcCUQsC+Qtc1vN9hVFphXjqgTWtYMVgqP9YxsTE6jgoQE5jiJkx29ftDz+xmAhAYNWk8HSm9Ixi1M9hasO7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3jrSgUcYLw6BPWLbgC1lomZnoUr7hBCRstgJs5MEZgaU30Dst
	HBj+/O6OzAElhhX8H/ba8cDjNL768DXWOBScf0V43ybQlTnTNqNmsEW6K+ogAg==
X-Gm-Gg: ASbGncuV49TqT0CjpZfFmNFFI6vKSiLIfLVExI/s6BmS13v7gcJVIKQ4gHIcSQ1Osq7
	gZLbb5vaM6gjymqrtslkFXPIy6rJgHjpTaLzhBGbhqi5oS+BYmUT35E/mNskX8TOfUPyjutq4Ec
	S1XL12nssZ0U7beRqPPK8eiWMp9FuAJcpjQvXNLWQ39dWhYdwkOxwPbRKIw7GSWTC0TEDvojkiX
	Uj7d2a+ixaAIp7Nr1G44CQgJFKPGweGbrv5fjIscMzWjYNiCDFWd8qjrznFcnjLVhvNuAWygig8
	ojQNxxGPsdmjmVK/ji8JyxhIndqBFD5N76+vqon7zvGmpNPfMlIkOIoV62PNgCUQfQDlaZctKLc
	1WEQI
X-Google-Smtp-Source: AGHT+IFhRnrV4mRUTOLd5oZokomaH93RHqi8VEcCLMksncmjcz/Y4Ytn4IeShC2SIGRJbJ1B+LxfNA==
X-Received: by 2002:a7b:c386:0:b0:43b:b106:bb1c with SMTP id 5b1f17b1804b1-43bcb2aefd1mr1168965e9.0.1741092620567;
        Tue, 04 Mar 2025 04:50:20 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba57145esm223586235e9.30.2025.03.04.04.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 04:50:20 -0800 (PST)
Date: Tue, 4 Mar 2025 12:50:15 +0000
From: Brendan Jackman <jackmanb@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: Add lockdep assertion for pageblock
 type change
Message-ID: <Z8b3B42jwRpnPIs7@google.com>
References: <20250303-pageblock-lockdep-v2-1-3fc0c37e9532@google.com>
 <4d0f0bca-3096-4fb4-9e8b-d4dcdf7eeb92@redhat.com>
 <Z8W0v0LjuyH8ztTQ@google.com>
 <3e66875e-a4d5-4802-85b3-f873b0aa3b06@redhat.com>
 <Z8XSCE8goWnEzRSY@google.com>
 <0f120624-3ae9-4273-b349-b10d813a4e65@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f120624-3ae9-4273-b349-b10d813a4e65@redhat.com>

On Mon, Mar 03, 2025 at 06:06:12PM +0100, David Hildenbrand wrote:
> > > But I am not sure why memmap_init_zone_device() would have to set the
> > > migratetype at all? Because migratetype is a buddy concept, and
> > > ZONE_DEVICE does not interact with the buddy to that degree.
> > > 
> > > The comment in __init_zone_device_page states:
> > > 
> > > "Mark the block movable so that blocks are reserved for movable at
> > > startup. This will force kernel allocations to reserve their blocks
> > > rather than leaking throughout the address space during boot when
> > > many long-lived kernel allocations are made."
> > 
> > Uh, yeah I was pretty mystified by that. It would certainly be nice if
> > we can just get rid of this modification path.
> > 
> > > But that just dates back to 966cf44f637e where we copy-pasted that code.
> > > 
> > > So I wonder if we could just
> > > 
> > > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > > index 57933683ed0d1..b95f545846e6e 100644
> > > --- a/mm/mm_init.c
> > > +++ b/mm/mm_init.c
> > > @@ -1002,19 +1002,11 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
> > >          page->zone_device_data = NULL;
> > >          /*
> > > -        * Mark the block movable so that blocks are reserved for
> > > -        * movable at startup. This will force kernel allocations
> > > -        * to reserve their blocks rather than leaking throughout
> > > -        * the address space during boot when many long-lived
> > > -        * kernel allocations are made.
> > > -        *
> > > -        * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
> > > -        * because this is done early in section_activate()
> > > +        * Note that we leave pageblock migratetypes uninitialized, because
> > > +        * they don't apply to ZONE_DEVICE.
> > >           */
> > > -       if (pageblock_aligned(pfn)) {
> > > -               set_pageblock_migratetype(page, MIGRATE_MOVABLE);
> > > +       if (pageblock_aligned(pfn))
> > >                  cond_resched();
> > > -       }
> > >          /*
> > >           * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
> > 
> > memory-model.rst says:
> > 
> > > Since the
> > > page reference count never drops below 1 the page is never tracked as
> > > free memory and the page's `struct list_head lru` space is repurposed
> > > for back referencing to the host device / driver that mapped the memory.
> 
> That comment will be stale soon. In general, ZONE_DEVICE refcounts can drop
> to 0, but they will never go to the buddy, but will get intercepted on the
> freeing path.
> 
> > 
> > And this code seems to assume that the whole pageblock is part of the
> > ZONE_DEVICE dance, it would certainly make sense to me...
> 
> Sorry, I didn't get your final conclusion: do you thing we don't have to
> initialize the migratetype, or do you think there is reason to still do it?

Sorry yeah, I was concluding that I don't see any reason to set the
migratetype here. But, given I didn't even notice this code path until
your review here I am not feeling too confident about changing it.

I can try to stare it some more and hopefully some courage will build
up! I probably also need to find a way to run a system that uses
ZONE_DEVICE for my local testing...

