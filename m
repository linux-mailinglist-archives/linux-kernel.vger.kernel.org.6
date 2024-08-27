Return-Path: <linux-kernel+bounces-304113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B07C961A63
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6751A284E85
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B050F1D45E1;
	Tue, 27 Aug 2024 23:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB7JMc70"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F59B770F1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800752; cv=none; b=aYgvl8/sHsuGyzCXWYrMeXGwmreQh2lLw610/onDRyP+7KB2letL85Hz9ehtssOJLuJVcK/2HS7k3/whEvQJXxpG53/eJNaCUSG3JXgL9OF2nl74k9LynO93/PIytSJpO+Gn4QCZIxhUp7roXsBKPKjT+Pokyjv5ZppEYXLb6Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800752; c=relaxed/simple;
	bh=S8J1AOYiWHtBGcUyIkIM4EuIpCii+tK1/hIpXKi3EdY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRBuXkRM+trveLTam7nPlxJjFpQhXCTo9Et9MnZCRYmCXG9PAJp8mhHC/bI1MHN4WzehXeaT2X/wDzGenpLBSDTYw6MfH6BM3nqNmUOTOzuJ2apZje5ZA7TSjHg0OyXAij4RfbvG8IQGmixhF2LWf4FoLYVKsyqfHjCbBp51qlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YB7JMc70; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2020ac89cabso55926115ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724800750; x=1725405550; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GUm5gryKKWvBH31Cta/VW4vv8cdFz/H0mtfUOE4BomA=;
        b=YB7JMc70XHaM4b82XF5IbzJ084cfmOhpiXU707yDQ7ICV6qXMmHwtnvwOMA/vRvo6A
         0nY8cTuRFpxwRGF1/Ri33CKnoFKzz5UcoboB+UXxXrLJkb9q3S9k8NVfjqJp+OXteIT/
         FMBOiduVqAclbUHQWdQZmpW3TvBpxxkQrZOCaAPA8tyUxIpmhlqUbJBWj3+pc8C2b8Nv
         R+XJ1tdfe99yGY4IIQTPY8PCk80XHuNTK0IpgaQak2Z1FQdYogLyiSz68Psek0wMjWZy
         KlDauT5lF07XPTq3XUKrV10SzflmA+CApyA5My6CDSIsFhPaSk4JePvssl+eoHyiFolv
         JurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724800750; x=1725405550;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUm5gryKKWvBH31Cta/VW4vv8cdFz/H0mtfUOE4BomA=;
        b=isvqJlkZUYxefKKxuAZDC2exfh14VAJr4igK9GrB4yEq8CObgfolQ2hvZMUI7dwdcF
         fCkov6TukiJ6bOMUzBIIZPE46H9+wzseQ0mJbafpuwkSUamScyr0B1dhebQpOsaiCYwp
         0xCyVmkXhwHktzjbjN8SXjgaH87SlXLqexQq2mSJQ3KwO2SsVEqVKqseD+UNMY8ek++G
         IX+SPaQQcLJoLhYQShv4jwVrLct31amZfqYM9UjAzlFS8o2RCD0nMzenf7GF0v3oTRbm
         t/BNC1/yykRw9Ln7eaHTy6XeN5CEZ5i1eIrwHE4NtseLELxDlSR2pQSM8DedgL9obCUK
         r9ww==
X-Forwarded-Encrypted: i=1; AJvYcCWCBlGTI0Vbwp0fkQn6BkP1VmIFW5tvfpEVQ5uSbQtjieeeLUkEyHE94HpH5sunN8oHcRwuZJImOlRZ/Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg3bs3ixa1zcsHVLHz1v5NIs5NPfHFjRsK2E3adqSMr05Ksd9H
	Ei60I75S3Qq5WmJ4a28Ls+SeHK2F72OHwU5Duhmvn4gFcht1e6oH
X-Google-Smtp-Source: AGHT+IEf+YEAJ3dqp0JamhIxJ8PBWRNIOHv6jz40alBiwcH0BRAtWcl5IrKjA3M7Abz7d20cC5rlLg==
X-Received: by 2002:a17:902:f68a:b0:201:efe7:cb03 with SMTP id d9443c01a7336-2039e4e84b4mr162824265ad.48.1724800749768;
        Tue, 27 Aug 2024 16:19:09 -0700 (PDT)
Received: from DESKTOP-DUKSS9G. (c-76-133-131-165.hsd1.ca.comcast.net. [76.133.131.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560a05dsm87488595ad.214.2024.08.27.16.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 16:19:09 -0700 (PDT)
Message-ID: <66ce5eed.170a0220.387c4d.276d@mx.google.com>
X-Google-Original-Message-ID: <Zs5e6kej4Q7X1jEX@DESKTOP-DUKSS9G.>
Date: Tue, 27 Aug 2024 16:19:06 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, alexs@kernel.org,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, minchan@kernel.org, david@redhat.com,
	42.hyeyoo@gmail.com, nphamcs@gmail.com
Subject: Re: [PATCH v5 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
References: <20240806022143.3924396-1-alexs@kernel.org>
 <20240806022311.3924442-1-alexs@kernel.org>
 <20240806123213.2a747a8321bdf452b3307fa9@linux-foundation.org>
 <CAJD7tkakcaLVWi0viUqaW0K81VoCuGmkCHN4KQXp5+SSJLMB9g@mail.gmail.com>
 <20240807051754.GA428000@google.com>
 <ZrQ9lrZKWdPR7Zfu@casper.infradead.org>
 <20240814060354.GC8686@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814060354.GC8686@google.com>

On Wed, Aug 14, 2024 at 03:03:54PM +0900, Sergey Senozhatsky wrote:
> On (24/08/08 04:37), Matthew Wilcox wrote:
> [..]
> > > So I guess if we have something
> > > 
> > > struct zspage {
> > > 	..
> > > 	struct zpdesc *first_desc;
> > > 	..
> > > }
> > > 
> > > and we "chain" zpdesc-s to form a zspage, and make each of them point to
> > > a corresponding struct page (memdesc -> *page), then it'll resemble current
> > > zsmalloc and should work for everyone? I also assume for zspdesc-s zsmalloc
> > > will need to maintain a dedicated kmem_cache?
> > 
> > Right, we could do that.  Each memdesc has to be a multiple of 16 bytes,
> > sp we'd be doing something like allocating 32 bytes for each page.
> > Is there really 32 bytes of information that we want to store for
> > each page?  Or could we store all of the information in (a somewhat
> > larger) zspage?  Assuming we allocate 3 pages per zspage, if we allocate
> > an extra 64 bytes in the zspage, we've saved 32 bytes per zspage.
> 
> I certainly like (and appreciate) the approach that saves us
> some bytes here and there.  zsmalloc page can consist of 1 to
> up to CONFIG_ZSMALLOC_CHAIN_SIZE (max 16) physical pages.  I'm
> trying to understand (in pseudo-C code) what does a "somewhat larger
> zspage" mean.  A fixed size array (given that we know the max number
> of physical pages) per-zspage?

I haven't had the opportunity to respond until now as I was on vacation.

With the current approach in a memdesc world, we would do the following:

1) kmem_cache_alloc() every single Zpdesc
2) Allocate a memdesc/page that points to its own Zpdesc
3) Access/Track Zpdescs directly
4) Use those Zpdescs to build a Zspage

An alternative approach would move more metadata storage from a Zpdesc
into a Zspage instead. That extreme would leave us with:

1) kmem_cache_alloc() once for a Zspage
2) Allocate a memdesc/page that points to the Zspage
3) Use the Zspage to access/track its own subpages (through some magic
we would have to figure out)
4) Zpdescs are just Zspages (since all the information would be in a Zspage)

IMO, we should introduce zpdescs first, then start to shift
metadata from "struct zpdesc" into "struct zspage" until we no longer
need "struct zpdesc". My big concern is whether or not this patchset works
towards those goals. Will it make consolidating the metadata easier? And are
these goals feasible (while maintaining the wins of zsmalloc)? Or should we
aim to leave zsmalloc as it is currently implemented?

