Return-Path: <linux-kernel+bounces-285909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C34FB951423
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390091F258B5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B437172F;
	Wed, 14 Aug 2024 06:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dU+rat+E"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E5B2901
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723615443; cv=none; b=kDkOCVzWIVIP/Q3j805G6djjZGL6U6+I9TUKMUmSXvMcAIyfAXgPF7e3YU0TzlMCQMuZPA2I/lYCIHO6taUba0dg8c0ACsj0RjTeFfkrsJ28H7OBB3d0YR4paESvADmaE+/sjsKiAPwH48dF3iBQIg1Vh2/LFGOwy8gIErB6ZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723615443; c=relaxed/simple;
	bh=ENEqJv0aGi7nwLDCeum12jIyP8XO+cUSUOKOWThnEv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XS22+BlpjlG7UPEjn3SNArwS8Q1BMGJUpWX31c7nRIySjIp8+a5OMQpKRGaG8IwuOSpXtLb0QQzgzoQuFSIiuVUzxGt/4YZogqSYwyk8yQIVoBIBTCgwedgEWfnB3Idk2r/Xo4YVeHI3sLFI1+sl3L0/gS+B46J/aiVHLybew3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dU+rat+E; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc52394c92so56954495ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 23:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723615440; x=1724220240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pNj8LuYKX9xbINVTD2P2mQ4u/TEZvTfYpMXCeQReyaE=;
        b=dU+rat+Es2moQ4A35moPb8wulnW559xCRuIshGfz7QXRfPKnIivLL70Z9TmmENd2UX
         SVOXxKr/j91cu6dMVn79yCPAzxS1z3//c+cIrAb8P6E3egaqR2wTq7CYnfBr405KX0lB
         q568W77ZM+NU/YA0a62I5SgSlNGqu59oIFcUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723615440; x=1724220240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNj8LuYKX9xbINVTD2P2mQ4u/TEZvTfYpMXCeQReyaE=;
        b=kPrLRPZDy1NujZc9ZyUVpEinu5htcfielrh7G+GjwadZzSOMLk5yKkFdXGCTcNWqlx
         iGyKnMEz4MzNU5v8dAoBmFqv4oZrzwh0BqFhk838aLHuGDrtGZZUwto6UHjWWaKImEcm
         HSfG5Gzst08tUn2I6s8pV1szy/cfraKLxmkqIR/CbqscniPXgrmGlNqwLmye4+qntRCG
         IBKCAKslzBzCZ0GdKJHpLjrqtS0wETOpwdkQKj+R65LztouHqahkYnCco0V3cwPqiP1N
         JOrNzN8Da5J/8oqNBAhU7XnFmrzrTwBSXuJTHncyRI7PBlL2fim8NH1IwZAj2SvBun1m
         3GKg==
X-Forwarded-Encrypted: i=1; AJvYcCVhODnhOdp1v/XlgxfvTvnuAWMprEBkMgJH2QnfvZv9n/6yeJGKxDn8E5cjy9mdCgibMoeMEFGhOZeicJaD/xOG5jMJ3iCD9pyOI74Q
X-Gm-Message-State: AOJu0Yx7ZqpYUs+gdebPr9GCP9WEWrsIvfI/ZsncGtD8p4goO+iOK3G3
	FdeATLRUspL5wavS7MsffLzOdH5Y+HglPqSDbUQ0z13F03B8lZnKroDbd6BPmw==
X-Google-Smtp-Source: AGHT+IF6nPUX3LCtvUGfeZRm+NxInxBIPLi+d3Evei1ICMnde3/q1+4sAiFuM5J9B4IoD13HbnBgBg==
X-Received: by 2002:a17:903:18b:b0:1fd:a360:4469 with SMTP id d9443c01a7336-201d64880eemr22567825ad.42.1723615440421;
        Tue, 13 Aug 2024 23:04:00 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:1432:35df:53f:489f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1cff62sm22403315ad.292.2024.08.13.23.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 23:03:59 -0700 (PDT)
Date: Wed, 14 Aug 2024 15:03:54 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, alexs@kernel.org,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, minchan@kernel.org, david@redhat.com,
	42.hyeyoo@gmail.com, nphamcs@gmail.com
Subject: Re: [PATCH v5 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
Message-ID: <20240814060354.GC8686@google.com>
References: <20240806022143.3924396-1-alexs@kernel.org>
 <20240806022311.3924442-1-alexs@kernel.org>
 <20240806123213.2a747a8321bdf452b3307fa9@linux-foundation.org>
 <CAJD7tkakcaLVWi0viUqaW0K81VoCuGmkCHN4KQXp5+SSJLMB9g@mail.gmail.com>
 <20240807051754.GA428000@google.com>
 <ZrQ9lrZKWdPR7Zfu@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrQ9lrZKWdPR7Zfu@casper.infradead.org>

On (24/08/08 04:37), Matthew Wilcox wrote:
[..]
>
> I don't know if it's _your_ problem.  It's _our_ problem.  The arguments
> for (at least attempting) to shrink struct page seem quite compelling.
> We have a plan for most of the users of struct page, in greater or
> lesser detail.  I don't think we have a plan for zsmalloc.  Or at least
> if there is a plan, I don't know what it is.

Got you, thanks.  And sorry for a very delayed reply.

> > > Do you allocate a per-page struct zpdesc, and have each one pointing
> > > to a zspage?
> > 
> > I'm not very knowledgeable when it comes to memdesc, excuse my
> > ignorance, and please feel free to educate me.
> 
> I've written about it here:
> https://kernelnewbies.org/MatthewWilcox/Memdescs
> https://kernelnewbies.org/MatthewWilcox/FolioAlloc
> https://kernelnewbies.org/MatthewWilcox/Memdescs/Path

Thanks a lot!

> > So I guess if we have something
> > 
> > struct zspage {
> > 	..
> > 	struct zpdesc *first_desc;
> > 	..
> > }
> > 
> > and we "chain" zpdesc-s to form a zspage, and make each of them point to
> > a corresponding struct page (memdesc -> *page), then it'll resemble current
> > zsmalloc and should work for everyone? I also assume for zspdesc-s zsmalloc
> > will need to maintain a dedicated kmem_cache?
> 
> Right, we could do that.  Each memdesc has to be a multiple of 16 bytes,
> sp we'd be doing something like allocating 32 bytes for each page.
> Is there really 32 bytes of information that we want to store for
> each page?  Or could we store all of the information in (a somewhat
> larger) zspage?  Assuming we allocate 3 pages per zspage, if we allocate
> an extra 64 bytes in the zspage, we've saved 32 bytes per zspage.

I certainly like (and appreciate) the approach that saves us
some bytes here and there.  zsmalloc page can consist of 1 to
up to CONFIG_ZSMALLOC_CHAIN_SIZE (max 16) physical pages.  I'm
trying to understand (in pseudo-C code) what does a "somewhat larger
zspage" mean.  A fixed size array (given that we know the max number
of physical pages) per-zspage?

