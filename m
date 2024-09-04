Return-Path: <linux-kernel+bounces-315870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6FE96C7F6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD99C2864AE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D12F1E6DE1;
	Wed,  4 Sep 2024 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msJj4iZZ"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B21940C03
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725479510; cv=none; b=Onr6ktB/LjEmXL42IZV+YDdIZoevWpHc021qXzydPCsTuMcerqNqUli+W3zuvOpdlidfoq2tNqqz2gAssJYe3ppYann4QangTPU6KfrmB7P9QkaEpYgqHTaihUum188E/HR6dpPUCdWiHa9Ab7m6I/vmavS7OEC5JfdaY8RClQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725479510; c=relaxed/simple;
	bh=bS8UinF/guuv2EDroZyGwvbri6V9Nnlswq54TD3u3qY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4O89+DjVFcE+c/SopJMLfKQQVZiJGYOdsceiB1dFtIB5Hr2f0fKAjmlxaaNaBIRxQwklPL6fhUm+OPbHfFgIgoUlSEVn9EuXkWEyDsEA5v/7F3KuBzKe8JJuiP4a1xCOlv1M1Vn5Un1edLz0AGMQiLu2Uw7CX0CRNe88vnYJt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msJj4iZZ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7c1324be8easo845507a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 12:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725479508; x=1726084308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SlOmg5zgF2+yf7PiIjOBjN942jtPLLMdWv+krlSsj6A=;
        b=msJj4iZZDo5XxG+lM4RTJTZsyHvfyhLhPtCAI4awZtssFIafzzwuLMbtkKS8fAZjAU
         3a7bJwlKEzJsiBm/CCNIoQhdbLt/yNmqhk6vhT9Uii2m1CzQNXnP+OoRNHJWeMsp/DcV
         KIWVti1PKKnhxl9rcrQ50GQjWXm5fUTuupTDLwCsI03lAuJWU/NH68zi7lznUifyq3U1
         QjihSB3P/loh2Cr1l6/jUtK4P03YdVeeZqPWvogzXlgLTucS6WIDxV28xsH95lP5tUoc
         icUSbSAdSxt4+pAQ0z5u3eqETqzHKRxLavOQCXdieWMCEznxEB5D0wEbPCxkFQiXIjJ7
         qqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725479508; x=1726084308;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlOmg5zgF2+yf7PiIjOBjN942jtPLLMdWv+krlSsj6A=;
        b=cupCAysSIMHPHhs8AYNslXx5d10J8QggzdSNUBgB7RICYMM4HST1z+lNfsIVZ92eSb
         ef24xdhIImEvimw4WVKV6h2QYLoP2S/9urlgDshI63V59p5DytQq1pjfyJiGARyT6BI7
         6LIyaNr82g9Iv7CmWchd4n/dULzNOExeO9xE9PwH89RHbI2F8zRautAwUd+1Wy5+ruAA
         nXzM4pDhQswVkT1uaSYRGIPDNxBZ3t5Dxn1JsGnYJdfStc2Zv9P+ekx/l6rADZesLp9e
         KXteS+mN+eWM2pQLBzwGoOXYA/HHIS/9IDOPVZbxJ2xjJHr93Da28Q4ZwNWFYOce50j8
         T8fg==
X-Forwarded-Encrypted: i=1; AJvYcCWSCE0UElGZdZH6G3qis4SXQRmQShK2xtis/CL6+wtaW1q5T21YwsH7jkwWKFgt1rsQ0VGluYclb2ifFKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnvr87wM8x3w1NpDyw0coAUT6vZd8jfGpNT+DLTRoIxQ3iQX8z
	8epO8prXt6H67BgLWbXDjGMFEeP1Wwn5W0uF+UiTlgL9wjn+SK94
X-Google-Smtp-Source: AGHT+IEEduUCOiywKQwIwI6xvxJTly9F9XAvRUraSNTzhT5RKwxVR3PEheBdkJTaYWes1HDYN+dOvQ==
X-Received: by 2002:a17:90b:3007:b0:2d3:acbd:307b with SMTP id 98e67ed59e1d1-2da8ede7c4fmr5396846a91.10.1725479508281;
        Wed, 04 Sep 2024 12:51:48 -0700 (PDT)
Received: from DESKTOP-DUKSS9G. (c-76-133-131-165.hsd1.ca.comcast.net. [76.133.131.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b0fdbd8sm14040061a91.5.2024.09.04.12.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:51:47 -0700 (PDT)
Message-ID: <66d8ba53.170a0220.844a7.1d81@mx.google.com>
X-Google-Original-Message-ID: <Zti6UH2JrV727CWd@DESKTOP-DUKSS9G.>
Date: Wed, 4 Sep 2024 12:51:44 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Alex Shi <seakeel@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Matthew Wilcox <willy@infradead.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, alexs@kernel.org,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, minchan@kernel.org, david@redhat.com,
	42.hyeyoo@gmail.com, nphamcs@gmail.com,
	Dan Streetman <ddstreet@ieee.org>,
	Seth Jennings <sjenning@redhat.com>
Subject: Re: [PATCH v5 00/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
References: <20240806022143.3924396-1-alexs@kernel.org>
 <20240806022311.3924442-1-alexs@kernel.org>
 <20240806123213.2a747a8321bdf452b3307fa9@linux-foundation.org>
 <CAJD7tkakcaLVWi0viUqaW0K81VoCuGmkCHN4KQXp5+SSJLMB9g@mail.gmail.com>
 <20240807051754.GA428000@google.com>
 <ZrQ9lrZKWdPR7Zfu@casper.infradead.org>
 <20240814060354.GC8686@google.com>
 <66ce5eed.170a0220.387c4d.276d@mx.google.com>
 <9a6e3169-2ebd-47a5-b2e6-953a8a6730db@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a6e3169-2ebd-47a5-b2e6-953a8a6730db@gmail.com>

On Thu, Aug 29, 2024 at 05:42:06PM +0800, Alex Shi wrote:
> 
> 
> On 8/28/24 7:19 AM, Vishal Moola wrote:
> > On Wed, Aug 14, 2024 at 03:03:54PM +0900, Sergey Senozhatsky wrote:
> >> On (24/08/08 04:37), Matthew Wilcox wrote:
> >> [..]
> >>>> So I guess if we have something
> >>>>
> >>>> struct zspage {
> >>>> 	..
> >>>> 	struct zpdesc *first_desc;
> >>>> 	..
> >>>> }
> >>>>
> >>>> and we "chain" zpdesc-s to form a zspage, and make each of them point to
> >>>> a corresponding struct page (memdesc -> *page), then it'll resemble current
> >>>> zsmalloc and should work for everyone? I also assume for zspdesc-s zsmalloc
> >>>> will need to maintain a dedicated kmem_cache?
> >>>
> >>> Right, we could do that.  Each memdesc has to be a multiple of 16 bytes,
> >>> sp we'd be doing something like allocating 32 bytes for each page.
> >>> Is there really 32 bytes of information that we want to store for
> >>> each page?  Or could we store all of the information in (a somewhat
> >>> larger) zspage?  Assuming we allocate 3 pages per zspage, if we allocate
> >>> an extra 64 bytes in the zspage, we've saved 32 bytes per zspage.
> >>
> >> I certainly like (and appreciate) the approach that saves us
> >> some bytes here and there.  zsmalloc page can consist of 1 to
> >> up to CONFIG_ZSMALLOC_CHAIN_SIZE (max 16) physical pages.  I'm
> >> trying to understand (in pseudo-C code) what does a "somewhat larger
> >> zspage" mean.  A fixed size array (given that we know the max number
> >> of physical pages) per-zspage?
> > 
> > I haven't had the opportunity to respond until now as I was on vacation.
> > 
> > With the current approach in a memdesc world, we would do the following:
> > 
> > 1) kmem_cache_alloc() every single Zpdesc
> > 2) Allocate a memdesc/page that points to its own Zpdesc
> > 3) Access/Track Zpdescs directly
> > 4) Use those Zpdescs to build a Zspage
> > 
> > An alternative approach would move more metadata storage from a Zpdesc
> > into a Zspage instead. That extreme would leave us with:
> > 
> > 1) kmem_cache_alloc() once for a Zspage
> > 2) Allocate a memdesc/page that points to the Zspage
> > 3) Use the Zspage to access/track its own subpages (through some magic
> > we would have to figure out)
> > 4) Zpdescs are just Zspages (since all the information would be in a Zspage)
> > 
> > IMO, we should introduce zpdescs first, then start to shift
> > metadata from "struct zpdesc" into "struct zspage" until we no longer
> > need "struct zpdesc". My big concern is whether or not this patchset works
> > towards those goals. Will it make consolidating the metadata easier? And are
> > these goals feasible (while maintaining the wins of zsmalloc)? Or should we
> > aim to leave zsmalloc as it is currently implemented?
> 
> Uh, correct me if I am wrong.
> 
> IMHO, regarding what this patchset does, it abstracts the memory descriptor usage
> for zswap/zram. 

Sorry, I misunderstood the patchset. I thought it was creating a
descriptor specifically for zsmalloc, when it seems like this is supposed to
be a generic descriptor for all zpool allocators. The code comments and commit
subjects are misleading and should be changed to reflect that.

I'm onboard for using zpdesc for zbud and z3fold as well (or we'd have to come
up with some other plan for them as well). Once we have a plan all the
maintainers agree on we can all be on our merry way :)

The questions for all the zpool allocator maintainers are:
1) Does your allocator need the space its using in struct page (aka
would it need a descriptor in a memdesc world)?

2) Is it feasible to store the information elsewhere (outside of struct
page)? And how much effort would that code conversion be?

Thoughts? Seth/Dan, Vitaly/Miahoe, and Sergey?

> The descriptor still overlays the struct page; nothing has changed
> in that regard. What this patchset accomplishes is the use of folios in the guts
> to save some code size, and the introduction of a new concept, zpdesc. 
> This patchset is just an initial step; it does not bias the potential changes to 
> kmem_alloc or larger zspage modifications. In fact, both approaches require this
> fundamental abstract concept: zpdesc. 

