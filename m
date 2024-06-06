Return-Path: <linux-kernel+bounces-204815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D7F8FF3DA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E852E1C27A32
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E8C1990BE;
	Thu,  6 Jun 2024 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="YJO1Diat"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A195938DC7
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695278; cv=none; b=FYq9Vk/7o9yZWPPN2i8Aby4ByGP7gHPoGXb+1ss/OMEUvKJSs2bXMtIvHpEo4FkigI1lZ+n4GjbI+XMCiSNGUUVD3lx9EwOyqbCyaWeMraoamg89jTGGT2Ph9MxtwIm8TUWlh4b/obllDe+7OLEqM/73bP5ymKJYoqHx0qdIkhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695278; c=relaxed/simple;
	bh=Mwm44gSX2pJSO1DQZKq/bU47/WAyUUvkVlSXQ5KADlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSR5HRhkc6tRVgGrs9EMScMs3s6jYlyhBMmPdMwaq1SAryHCEw0XztjGPYCjGlXo3k+clFjV6wVH8LzhbGiWsBSM/KMaBQ7/ZdkScvlAv78bnIDdXcndFYlxhomJIPhyqISX/kG7oXgY07LOSEFXvRYxCFy7UJbOAcuNmDFImug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=YJO1Diat; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f692d6e990so12785915ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1717695276; x=1718300076; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AAulxVnYL/xyKaB3vnDRoKBoF0F084Ubuhab5n7H9jo=;
        b=YJO1Diat12qRHgRFZWWqBb3KbE33vc5ktBSHZTqYRHvyq4z4Z+2fKwebosbdoHGZsq
         fd04O80vSJ4FLQsa5wbXmUmbbS5Izkx0Bpaz17aO+Zqt/mSyAGq7iuBbABhW6CIsZszR
         WJyq6aE02SrNBKBkwctYJLM9dqZV0zGIlBgN9bHVxyXtYcpACpUtSmABkPUv7n4U+nxd
         hn8J7rcTf6Dy4YyqEX/c9OzGhgJtp+uVmuLNU/DOWCjNqmxIYPDKPoWRr9HmCXKcAXja
         SebV03S5FUqTRloqn2Zl6tXQyeG9rUmBCHu/gL0VYBLR8ACtPAkazyB6mhvb8OiCREKF
         0A7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717695276; x=1718300076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAulxVnYL/xyKaB3vnDRoKBoF0F084Ubuhab5n7H9jo=;
        b=u0FU+ftgWYttmr3u0xcr76nGmzoaG3D83Ap/bVGakP1UlJkp8B/5WJk8LsP2HJhQai
         NP7H9gmu0jHuky5p+3oLArnsq1Goviqm5DY8u+yBbGcbeMV0oYwpqbJzMWUxpqIShAiu
         p2OcYDvFjrrgwV2Yd/lcoptdc5FXrQ312oYuS5M0gEG7leUTKjc7Mcvt1D0znAqLpYk8
         lofZK2ekedfM4URZayn8ZzMoo+Emd3QY3IpDB8js1pnqfWep+kTaYBZf70W/VE2kA9I/
         qJPFD2XimCAN4uERK1ewukH2PPq5AJDBlLPdAeVZjc6fe+ukJKfACxjemKqYIVNT4N37
         ++5g==
X-Forwarded-Encrypted: i=1; AJvYcCVUlBQC9oKO3ifQBWBHTImQRyMBBXf8YsoeHNw7NL+VLOzj/tHTRTK//gjHiyuGzS62NYObnkrMMBqpE5c48hpnsKqhnYIFKyKz+KQX
X-Gm-Message-State: AOJu0Yx3rLVwhvJxw3EIcPXntIWSEQwY3MaRZyfGa8dG/XrfHcb/NzEF
	SikHHQ8wcZd7ipokhy8ElGxuqTxqUAmAujuGR7jjlaZFKvIEiOMaMQHcJKNO40iauFQ7Mdrq0MR
	gXeg=
X-Google-Smtp-Source: AGHT+IFF5YghgVig/RYReBOoP5uz9DUPAWXJpwtPKtVnFV4hSzqDyvhiRUIt9MC0+IujJ6KGfql9Zw==
X-Received: by 2002:a17:902:dac6:b0:1f6:678c:9e8c with SMTP id d9443c01a7336-1f6d03be125mr2564165ad.67.1717695275716;
        Thu, 06 Jun 2024 10:34:35 -0700 (PDT)
Received: from telecaster.dhcp.thefacebook.com ([2620:10d:c090:400::5:ae4b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76aa80sm17769735ad.69.2024.06.06.10.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 10:34:35 -0700 (PDT)
Date: Thu, 6 Jun 2024 10:34:33 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
	Hao Ge <gehao@kylinos.cn>, Vlastimil Babka <vbabka@suse.cz>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-debuggers@vger.kernel.org
Subject: Re: [PATCH] mm: convert page type macros to enum
Message-ID: <ZmHzKRkgKOGW8Xmk@telecaster.dhcp.thefacebook.com>
References: <20240606172530.829790-1-stephen.s.brennan@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606172530.829790-1-stephen.s.brennan@oracle.com>

On Thu, Jun 06, 2024 at 10:25:29AM -0700, Stephen Brennan wrote:
> Changing PG_slab from a page flag to a page type in commit 46df8e73a4a3
> ("mm: free up PG_slab") in has the unintended consequence of removing
> the PG_slab constant from kernel debuginfo. The commit does add the
> value to the vmcoreinfo note, which allows debuggers to find the value
> without hardcoding it. However it's most flexible to continue
> representing the constant with an enum. To that end, convert the page
> type fields into an enum. Debuggers will now be able to detect that
> PG_slab's type has changed from enum pageflags to enum page_type.
> 
> Fixes: 46df8e73a4a3 ("mm: free up PG_slab")
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>  include/linux/page-flags.h | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 104078afe0b16..64fc191a75e8d 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -947,12 +947,15 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
>  #define PAGE_TYPE_BASE	0xf0000000
>  /* Reserve		0x0000007f to catch underflows of _mapcount */
>  #define PAGE_MAPCOUNT_RESERVE	-128

Adding linux-debuggers to Cc.

Can we also get PAGE_TYPE_BASE and PAGE_MAPCOUNT_RESERVE as enums? That
would make it possible for debuggers to implement PageType() and
page_has_type().

> -#define PG_buddy	0x00000080
> -#define PG_offline	0x00000100
> -#define PG_table	0x00000200
> -#define PG_guard	0x00000400
> -#define PG_hugetlb	0x00000800
> -#define PG_slab		0x00001000
> +
> +enum page_type {
> +	PG_buddy	= 0x00000080,
> +	PG_offline	= 0x00000100,
> +	PG_table	= 0x00000200,
> +	PG_guard	= 0x00000400,
> +	PG_hugetlb	= 0x00000800,
> +	PG_slab		= 0x00001000,
> +};
>  
>  #define PageType(page, flag)						\
>  	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
> -- 
> 2.43.0
> 

