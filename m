Return-Path: <linux-kernel+bounces-279989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C127094C438
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBF3BB2102F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2749147C86;
	Thu,  8 Aug 2024 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1EEyJE+"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D25579F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141314; cv=none; b=RsCXQK6nsxGvFuHpLxe0Nk8JPhz7cGGzqpnNjW/5fNzjNFEFovuLIyg0lpGRJCOQ/ktmTGRc64SCNLMLoxLklpreLQOhHd9rSv0kd2nlcJLHzDY1GC45ytts5w9SwVpQOSBUEx+LRxFNXDfRvBMVQsGtF/hkaIe4gCikKLylq00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141314; c=relaxed/simple;
	bh=be38RH9/6rENiiGDVRUWSle/+DxeJk+1XnRo9ue+rlg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLLBOI7sSi6aZgcyHZ9HACBJjv1GaXLB6KT+MBFBnLCnT2im5KhSPXOrSvEOQoHx5H5//McAKyQmKy4ZhD86poSQjr8eQnTiIyXbEcxbAYkPAzRm9lP/FdME46NpeVFuBsZS6n6m5snd1FbVe9WnHPEGnz28Uwpiam23fVvGWfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1EEyJE+; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7a130ae7126so884458a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723141312; x=1723746112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9aSbHOOUDRiYGkhz9BOTUbCs/lEIFPObTfL4lVQxdF8=;
        b=h1EEyJE+EYzYhJ+04oMXzxE2NxS3RlVpOeMgWrHEDYOHhhvNWDLRysXkZZOWsLaegn
         rAOL3e4hCYO5woS+dTe2NzhEcyz4ntsi58NtiKW5Kx36leEy3jRfY4wZd81+vom1QDVG
         cmPCQgH8eVHYGTPJ7MpmNYEmgHDCU3mGZN6HRRugnhXfaPn9pG/+poP7UgtTNHyBzBbV
         ud2jA5Z8YX/6+HGkOumPxSFTnFroWDL6hnibsLMmJYzVnytDQchSTCjHG/2ANTSZ1o7O
         bLzJBxEUEzNt4LCokayLOVtCCFJtt2ymKUpS2AYyFPoUhoG3CQ6p1cicTgmub5wJRiMT
         cBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723141312; x=1723746112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aSbHOOUDRiYGkhz9BOTUbCs/lEIFPObTfL4lVQxdF8=;
        b=dFBIdPJW/vg3mrOYJqeKL7bccc/R3QSNWZvqTwrBF++zsDQs+K9AU+nPEEFaT5JBhL
         isdqlb628NB3KBkYNainG+H6ncCkuJ+2+jYZ5z+F3cvml7GUdPBAi1oFtja6NbZ0TGcy
         lHzqKKrU3xIxjOBgVyYc6M0B1wJZHcO45ybmpzKOMDSKKKdfyBw11d822/1/5+r+9C4I
         vKQNMY5DZdURO0BfQaEd5kregQJFAb1cRZiAWQwhj2W2vT2pi4FLluxF1hePLZnxfXkP
         7e/9c4lknY87LIumSNDTDwE20iV0l2H3PFXpzTHdNesVbyL5U25RJrGxdF21BFDDKC6j
         8mzA==
X-Forwarded-Encrypted: i=1; AJvYcCWA77ntdG5/o70BnLvXp7ER/rOe5zW0BnPlbPYH13p9jIOyNpVQk28x2VfmnLVHKCVRQECKXQyp8kUfx6EVJFsQUurT/ICTd6eliQ9d
X-Gm-Message-State: AOJu0YyIxdqW0d/iFncTRawLIgxEMP5IscSODDJwVAUvauiLTahYfqBp
	H0ArcUaaWfR3ojr3VCPp711CSIGqjx8UiDIJizLwe89qhybQnhq6US8p6Q==
X-Google-Smtp-Source: AGHT+IEwGbAfp8itp7DTPG+D/aPGMklHOj82vNPaeVIempJywapAWb9LqSHl8wezOQ+qguYBJNxS9Q==
X-Received: by 2002:a17:902:cf0f:b0:1fd:67c2:f97a with SMTP id d9443c01a7336-200952bef9bmr36038805ad.47.1723141311956;
        Thu, 08 Aug 2024 11:21:51 -0700 (PDT)
Received: from DESKTOP-DUKSS9G. (c-76-133-131-165.hsd1.ca.comcast.net. [76.133.131.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905b3f3sm127324945ad.136.2024.08.08.11.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 11:21:51 -0700 (PDT)
Message-ID: <66b50cbf.170a0220.295f9d.891b@mx.google.com>
X-Google-Original-Message-ID: <ZrUMvjfkpPPy40do@DESKTOP-DUKSS9G.>
Date: Thu, 8 Aug 2024 11:21:50 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Alex Shi <seakeel@gmail.com>
Cc: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	minchan@kernel.org, willy@infradead.org, senozhatsky@chromium.org,
	david@redhat.com, 42.hyeyoo@gmail.com,
	Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
Subject: Re: [PATCH v4 01/22] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-2-alexs@kernel.org>
 <66ad2ad7.170a0220.3a8e93.6a32@mx.google.com>
 <c591405b-3034-4a55-8664-e0c8ea393b79@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c591405b-3034-4a55-8664-e0c8ea393b79@gmail.com>

On Mon, Aug 05, 2024 at 12:06:24PM +0800, Alex Shi wrote:
> 
> 
> On 8/3/24 2:52 AM, Vishal Moola wrote:
> > On Mon, Jul 29, 2024 at 07:25:13PM +0800, alexs@kernel.org wrote:
> >> From: Alex Shi <alexs@kernel.org>
> > 
> >> +	static_assert(offsetof(struct page, pg) == offsetof(struct zpdesc, zp))
> >> +
> >> +ZPDESC_MATCH(flags, flags);
> >> +ZPDESC_MATCH(lru, lru);
> >> +ZPDESC_MATCH(mapping, mops);
> >> +ZPDESC_MATCH(index, next);
> >> +ZPDESC_MATCH(index, handle);
> >> +ZPDESC_MATCH(private, zspage);
> >> +#ifdef CONFIG_MEMCG
> >> +ZPDESC_MATCH(memcg_data, memcg_data);
> >> +#endif
> >> +#undef ZPDESC_MATCH
> >> +static_assert(sizeof(struct zpdesc) <= sizeof(struct page));
> >> +
> >> +#define zpdesc_page(zp)			(_Generic((zp),			\
> >> +	const struct zpdesc *:		(const struct page *)(zp),	\
> >> +	struct zpdesc *:		(struct page *)(zp)))
> >> +
> >> +#define zpdesc_folio(zp)		(_Generic((zp),			\
> >> +	const struct zpdesc *:		(const struct folio *)(zp),	\
> >> +	struct zpdesc *:		(struct folio *)(zp)))
> >> +
> >> +#define page_zpdesc(p)			(_Generic((p),			\
> >> +	const struct page *:		(const struct zpdesc *)(p),	\
> >> +	struct page *:			(struct zpdesc *)(p)))
> >> +
> >> +#endif
> > 
> > I'm don't think we need both page and folio cast functions for zpdescs.
> > Sticking to pages will probably suffice (and be easiest) since all APIs
> > zsmalloc cares about are already defined. 
> > 
> > We can stick to 1 "middle-man" descriptor for zpdescs since zsmalloc
> > uses those pages as space to track zspages and nothing more. We'll likely
> > end up completely removing it from zsmalloc once we can allocate
> > memdescs on their own: It seems most (if not all) of the "indirect" members
> > of zpdesc are used as indicators to the rest of core-mm telling them not to
> > mess with that memory.
> 
> Yes, that is also my first attempt to skip folio part, but I found we could got
> 6.3% object size reduced on zsmalloc.o file, from 37.2KB to 34.9KB, if we use
> folio series lock and folio_get/put functions. That saving come from compound_head
> check skipping.
> So I wrapped them carefully in zpdesc series functions in zpdesc.h file.
> They should be easy replaced when we use memdescs in the future. Could we keep them
> a while, or ?

IMO, Its alright to keep both pages and folios due to the size reduction.
However if we do keep both, it should be clearer that we Want zpdescs to
be order-0 pages, and the only reason we have folios is that
compound_head() size reduction (and nothing more). I think a comment by
the zpdesc_folio() macro will suffice.

> Thanks
> Alex
>  

