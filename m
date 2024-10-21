Return-Path: <linux-kernel+bounces-374733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DF09A6F30
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95EF51C22742
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B769E1C7B8F;
	Mon, 21 Oct 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NRtPB5xQ"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D05405FB
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 16:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729527430; cv=none; b=rhe3mIUyaD8Rrunw77N57N+Kz548c1Pz03R5bP085vRojjaDO5pyeyqYhes0DXVi/Ob4udfaQ3rdVNSR0BOyFZhC59K7FdLoMC1ea3fNq1uT3gbB7dd7rfH9OXP6kgo01pRhDE09CK6Ln1ihYJgNblITeMkd4MnfK0jhTzgSpeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729527430; c=relaxed/simple;
	bh=nX/1rDDEMfdGbK4oP/qb8TFBYHJGcq4PCXVIxP7Du+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyFEizt/59zBBcPFclRYai4iXeJCrZsCuDNqfbw8bl4yZeJkvRBKtd574gtePxCvPnXwJxz//c11IDRat50421gkKBo12iAWXsodd//wkMZVavJADKRKdmVme/FH+X3lm7V/KEgJVUyIq8RvbHZ0GbxMILfFnbClYPrLu2/KYTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NRtPB5xQ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4609c96b2e5so27570281cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729527427; x=1730132227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gEfONzhDqFGNtDvGcVV2OjNwgNeswu1gnCdcntMBt+E=;
        b=NRtPB5xQ4M+w3j2vJ+NviNHxBPeKP8euHOHsnTTWraogv25IbRUdZgGMYcjrGsmsZK
         veScMkNzTPCGHbmWAuXqhMfRc4dHJSUi6dUW5WZ3UrKvd7esfS8xakYalOaLQRAzMGLx
         4+UmPc4zA4dehDhDLH8q3+9/yTAxwniqN9tM55sD10BP4cIMN1i7PvK9SYSWRg+LHpVY
         kaSutnLuF3J0wYOsXTz70NMG4UjRNeAo8+jaz32L/35z/opJEJjwWl+ZcBgLFbbAhB7V
         Q/K4zN0tlz/C6GHpGZNVcHyXxDVMhrCFRo2YFV4xa7wTVnnIm3VTgY/2Q4uRKTHdu4de
         aCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729527427; x=1730132227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEfONzhDqFGNtDvGcVV2OjNwgNeswu1gnCdcntMBt+E=;
        b=YUrVVfFPks06XNcWoEERpA8hJPDVEUVN7+QZAqZkRRGljs6EDzJsSc9hVfQ61TpLd0
         Y72sjjRWuH0YyrFGVmAEHxiZ3ABB3SO+6PrfD77c1cLO0N8VGsHF3BniioOHEdtFghb6
         7WTQVj7QyoGaGza3Imfels2cflPj0+d/ftpHvzyWG/GKj8CLVgtxwgGusUNjPekIDCgS
         Z909z0A5/ibGKtUtrDEFbpC8MpNmZ5aHM1EKSlzjw3zZgLd9oarBTZ6YYcpeceIhVSRn
         uQnQ7PZUubWmIPsgH6MBfMk8+GXUUaW9e4yORe+Ba0MRSi4TLVP9JhfkX1bEovWQ3abT
         o2sw==
X-Forwarded-Encrypted: i=1; AJvYcCWKF2Lga8UYsDArUx66xrgwi7OmKUVjJNmnZYzzWe8VEpmmpTV11IZ7CFbK3QN+qOZqEd0tZbP0k3OjPjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxOdkKOonTww5xBZy7oSZT3YvZTJs6Qoohvi3GmFE54LFT35pb
	WLV7WL5mf/6mj1jJRU2H3q5TsmLUE8kSFZPR2BBq1vLIMfQY9x9QZnaYj9GUDTM=
X-Google-Smtp-Source: AGHT+IFlwa+hY7tlLp1VVOtE4ZB+LHnzpcwpYzAHWBfO5e5xtdUCSHXs+mU0bRAc7fVRuYNN4H/eYw==
X-Received: by 2002:a05:622a:1992:b0:45f:8ee:1859 with SMTP id d75a77b69052e-460aeba0e48mr203414481cf.0.1729527426826;
        Mon, 21 Oct 2024 09:17:06 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3cbb3c3sm19515151cf.52.2024.10.21.09.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 09:17:06 -0700 (PDT)
Date: Mon, 21 Oct 2024 12:17:08 -0400
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
Subject: Re: [PATCH v2 2/3] x86: probe memblock size advisement value during
 mm init
Message-ID: <ZxZ-hOrVp52seena@PC2K9PVX.TheFacebook.com>
References: <20241016192445.3118-1-gourry@gourry.net>
 <20241016192445.3118-3-gourry@gourry.net>
 <7b877356-f5c5-4996-904b-6c3b71389255@redhat.com>
 <ZxZpTlnhYPqg-tGh@PC2K9PVX.TheFacebook.com>
 <eb380e90-f5f5-40d5-b0a7-54b2bb50f7a3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb380e90-f5f5-40d5-b0a7-54b2bb50f7a3@redhat.com>

On Mon, Oct 21, 2024 at 05:57:28PM +0200, David Hildenbrand wrote:
> On 21.10.24 16:46, Gregory Price wrote:
> > On Mon, Oct 21, 2024 at 01:12:26PM +0200, David Hildenbrand wrote:
> > > 
> > > 
> > > Am 16.10.24 um 21:24 schrieb Gregory Price:
> > > > Systems with hotplug may provide an advisement value on what the
> > > > memblock size should be.  Probe this value when the rest of the
> > > > configuration values are considered.
> > > > 
> > > > The new heuristic is as follows
> > > > 
> > > > 1) set_memory_block_size_order value if already set (cmdline param)
> > > > 2) minimum block size if memory is less than large block limit
> > > > 3) [new] hotplug advise: lesser of advise value or memory alignment
> > > > 4) Max block size if system is bare-metal
> > > > 5) Largest size that aligns to end of memory.
> > > > 
> > > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > > Signed-off-by: Gregory Price <gourry@gourry.net>
> > > > ---
> > > >    arch/x86/mm/init_64.c | 16 ++++++++++++++++
> > > >    1 file changed, 16 insertions(+)
> > > > 
> > > > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > > > index ff253648706f..b72923b12d99 100644
> > > > --- a/arch/x86/mm/init_64.c
> > > > +++ b/arch/x86/mm/init_64.c
> > > > @@ -1439,6 +1439,7 @@ static unsigned long probe_memory_block_size(void)
> > > >    {
> > > >    	unsigned long boot_mem_end = max_pfn << PAGE_SHIFT;
> > > >    	unsigned long bz;
> > > > +	int order;
> > > >    	/* If memory block size has been set, then use it */
> > > >    	bz = set_memory_block_size;
> > > > @@ -1451,6 +1452,21 @@ static unsigned long probe_memory_block_size(void)
> > > >    		goto done;
> > > >    	}
> > > > +	/* Consider hotplug advisement value (if set) */
> > > > +	order = memblock_probe_size_order();
> > > 
> > > "size_order" is a very weird name. Just return a size?
> > > 
> > > memory_block_advised_max_size()
> > > 
> > > or sth like that?
> > > 
> > 
> > There isn't technically an overall "max block size", nor any alignment
> > requirements - so order was a nice way of enforcing 2-order alignment
> > while also having the ability to get a -1/-EBUSY/whatever out.
> 
> I see. But we (MM) just call it "order" then, like pageblock_order,
> max_order, compound_order ... but here we use "size everywhere" so I prefer
> to just sticking to that.
> 
> > 
> > I can change it if it's a big sticking point - but that's my reasoning.
> 
> Simply enforce it when setting the size. We call it "memory_block_size"
> everywhere and it's also a power-of-2 etc and sanity-check that in
> memory_dev_init().
> 
>

Disregard my other email.  Didn't see this one come through.

I'll switch to a size and check alignment. Probably i need to play
with the locking mechanism to avoid changing after it's probe the
first time, but i'll poke at it.

So probably i change to an ssize_t for the arg and return value.

~Gregory

