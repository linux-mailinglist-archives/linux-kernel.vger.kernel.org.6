Return-Path: <linux-kernel+bounces-315580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0419096C469
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2915D1C2143F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C021E0B97;
	Wed,  4 Sep 2024 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gXfvhCAj"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A0D1E00AE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468663; cv=none; b=aeCMEIbGmyxmzKfiKW9qBtwl8U3c9F8C0OhcPuUx0PuCqxCWOVRJSJ0iRcq2ny3Wv+z4d4nALxZtehy1JzpTPaVgaf5QTfztMRyFrp7j2aJhpDbhuSm5catlgntabJUolZ96IEFfrubXxLO1ln66EC1k2Wh0/kGHDuxoFqQLWA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468663; c=relaxed/simple;
	bh=WwVr4F4mSwbuuwBtGzRHAzok6+2DiB0wAP1mGFWeJ0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/2BgJ2tcdns9MBC8KjdUTwrA+1wdgSp2HEQ1oB/61FNQ/mxXQx/qvdEjsvJfQ5DQCRReFi6vc6Az5gDi0yl1ugPd4YTsyqAFM1CuCkR1DGZX9lZWWxHEMvlmWOkEpo2seT1ZBwJRqyHsNOYfKH/OQiqyyu+viBLQt7nYnKTaL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gXfvhCAj; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c3c3b63135so949041a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 09:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725468660; x=1726073460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7rWeV+NWCdRf81fBZfPtxM1G+LxfG7gp5nBcYV4V5A=;
        b=gXfvhCAjOyqQ0FZRYVWS4+qUu77o8Mkc0zsELc/C/piYH0JETtKGQYiknR6Vlp+ic8
         W6+xnSvTWTCKGd9G8z42Gj+taeSkR4xalftE48UTaT/2Sp/B2LE1oLMGCjzYkUIvSNKj
         3GnerN2W69yhvaQ4r8VpXLZJx+n8gJegb0SGlYxIdyUYLRDDrMX+j96mD64VXfErIR1C
         7olRGNF9vUrdEOvWyASHqYlPcAT6ac0a5DUCAFCJ024SAuLwuLXpU81My7UK5k7m820i
         xKsZUvIWgBEuHgiwULzGEG9uO5zuK9GOar3VGfwZ0NZiQzVLurXQWgkn8pI1S7E4lk+c
         pAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725468660; x=1726073460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7rWeV+NWCdRf81fBZfPtxM1G+LxfG7gp5nBcYV4V5A=;
        b=LJVY1KEv83j7N3B2K5tTNg5sq0wlyZJbB/qqucZbTdcEiNASQTTIG3T+z2KPYQbyKz
         KT2M0ONQltPC5quV/RtZG/wdf9bNBvVIwear6sSzZPaIQ8XSZJsVmvrHY639j/VuOG3C
         GfJZOqNwHV8QGcUdK7ssBJvPV38qEeXwR+WhWFYBv5HZSQvPhXvMxo2Fz1IADzBvaEpa
         K8D1x3HUYL7nPeQY+XKatd1+FxaMnKgNeFoxETTd64xwqRHXQ/DU1sgZgKCMld+7M2yo
         ChUZgI0pkQxmljV4wBhEQGJBgpVIEWcPBBmlMEOYXWd24lHiz7eGTEdM2YyvM4GUciJX
         c/Lw==
X-Forwarded-Encrypted: i=1; AJvYcCU7KQIpJbDmCNmeCjsxaFMziV0DVI+mtkan3qUG+1dxXo6rb5ywX2LNQtaBJ0uy6l3SVqMd1ZVLSdnRw2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHnFUf0mXplfYiqbPlpO4Jab1GMGtxckvOjVbXO2aCsWZ0FeC+
	QNUgOK1RUr10CyCruHpHY00ZY5gopIefPSBiB9TFmlBfENtPdOvH1cut5GUO35o=
X-Google-Smtp-Source: AGHT+IFALtAoVHEjAWS0GLsxnXTvv0LRQZ1z3Mh6tmtAzZy/u4Bi8AQyayThPfA0wkbnRHgLuqmbGA==
X-Received: by 2002:a17:907:2da1:b0:a72:69e8:f039 with SMTP id a640c23a62f3a-a8a32df36f9mr369433266b.12.1725468659495;
        Wed, 04 Sep 2024 09:50:59 -0700 (PDT)
Received: from localhost (109-81-94-33.rct.o2.cz. [109.81.94.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236d089sm13263566b.123.2024.09.04.09.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 09:50:59 -0700 (PDT)
Date: Wed, 4 Sep 2024 18:50:58 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	jack@suse.cz, Vlastimil Babka <vbabka@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-ID: <ZtiP8h4U7X_XV-yI@tiehlicka>
References: <20240902095203.1559361-1-mhocko@kernel.org>
 <ggrt5bn2lvxnnebqtzivmge3yjh3dnepqopznmjmkrcllb3b35@4vnnapwr36ur>
 <20240902145252.1d2590dbed417d223b896a00@linux-foundation.org>
 <yewfyeumr2vj3o6dqcrv6b2giuno66ki7vzib3syitrstjkksk@e2k5rx3xbt67>
 <Zta1aZA4u8PCHQae@tiehlicka>
 <zdrwzpzbe5oqawyklyb4gmdf6evhvmw3on5w2ewjyqfmdv2ndy@w7kdgpakbqv3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zdrwzpzbe5oqawyklyb4gmdf6evhvmw3on5w2ewjyqfmdv2ndy@w7kdgpakbqv3>

On Wed 04-09-24 12:15:15, Kent Overstreet wrote:
> On Tue, Sep 03, 2024 at 09:06:17AM GMT, Michal Hocko wrote:
> > On Mon 02-09-24 18:32:33, Kent Overstreet wrote:
[...]
> > > For bcachefs: I try really hard to minimize tail latency and make
> > > performance robust in extreme scenarios - thrashing. A large part of
> > > that is that btree locks must be held for no longer than necessary.
> > > 
> > > We definitely don't want to recurse into other parts of the kernel,
> > > taking other locks (i.e. in memory reclaim) while holding btree locks;
> > > that's a great way to stack up (and potentially multiply) latencies.
> > 
> > OK, these two patches do not fail to do that. The only existing user is
> > turned into GFP_NOWAIT so the final code works the same way. Right?
> 
> https://lore.kernel.org/linux-mm/20240828140638.3204253-1-kent.overstreet@linux.dev/

https://lore.kernel.org/linux-mm/Zs9xC3OJPbkMy25C@casper.infradead.org/

> > > But gfp flags don't work with vmalloc allocations (and that's unlikely
> > > to change), and we require vmalloc fallbacks for e.g. btree node
> > > allocation. That's the big reason we want MEMALLOC_PF_NORECLAIM.
> > 
> > Have you even tried to reach out to vmalloc maintainers and asked for
> > GFP_NOWAIT support for vmalloc? Because I do not remember that. Sure
> > kernel page tables are have hardcoded GFP_KERNEL context which slightly
> > complicates that but that doesn't really mean the only potential
> > solution is to use a per task flag to override that. Just from top of my
> > head we can consider pre-allocating virtual address space for
> > non-sleeping allocations. Maybe there are other options that only people
> > deeply familiar with the vmalloc internals can see.
> 
> That sounds really overly complicated.

Let vmalloc people discuss viable ways to deal with that. You as vmalloc
consumer want to get NOWAIT support. Ask them and see what kind of
solution they can offer to you as a user. This is how we develop kernel
in a collaborative way. We do not enforce solutions we work with domain
experts to work out a maintainable solution.

-- 
Michal Hocko
SUSE Labs

