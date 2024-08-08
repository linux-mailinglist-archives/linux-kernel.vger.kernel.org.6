Return-Path: <linux-kernel+bounces-279992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79E094C443
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E941F24E0F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DAC14A4F5;
	Thu,  8 Aug 2024 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R96/Nfxt"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932B40C03
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141506; cv=none; b=hxVdrOPl45igaywSHeZFaR8bOC0hkqFfIC/h1a21zF6V/qMIlxshrKJdBZ5+CEIMsu9OUgsBQEK0bNkHe3V3nHF0ww/nb81FAev2Qvta5oJQdmttK+9mjzPMRYRrLZ/ayD+pkOroGdS8CcOGEYh7w05bGpdDq5X8AE+VeG2hir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141506; c=relaxed/simple;
	bh=rdLaFp5CLPi6Tl65R2m3ajVCXFNvi3FjOatLRFqP1HU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWv1gS/n1gvhjiVjSvWFdEqhnc5QGd8/dYNwijpuwroVbzeDA21dAlNiRqCLk0DvJLBqjtOQyfeifeugkq0j0XmbxpY7ai1TBh2v+keywmepxzO8gRZsn3A1IA+zm8PLhFdAt1S7qZWYQd4GfzoJZnK0yaZe5XUpO6bh6h5vH9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R96/Nfxt; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc52394c92so12509905ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 11:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723141504; x=1723746304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/fTbmpLXTeoTX+77gSmITn/afs+9LM7Rg5nbvfvJvVw=;
        b=R96/NfxtrnIICQ9li0KXD5O7R0zKPx0KH7f/tfRcgBDNCrWw6Zwfy4VM2Nr0LhLvve
         xZhcgDtNDMeREb4T/g0cxPAJwbSoGzqDr9zIqFfucnR6oCDQn+KllrCog/73gN74AnQY
         aevAVRfyDnVxuyCLQ/QbyH6/lEauTfzVAyz2OkCTuhbPE56cFvt1kyqIBsqyu+G9LlD7
         QBFc8z/CKixH6SimK1xrNaaAsa2bvF4A5yTJeYGUoaQ39gwtDSmhsHTgluGIfhny7p8C
         fn3UE/bYBPezIf5NIh0baz7N1uWQTM4hVlYeLmN7kXMRMB0w0kZt6i8g2neR4Om/2QDq
         IoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723141504; x=1723746304;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fTbmpLXTeoTX+77gSmITn/afs+9LM7Rg5nbvfvJvVw=;
        b=KYAKnbSnb5MaRJMX0BTUe4zxRm/ycamVzE8dDBds5t3AziecaVXP845JCl6i2YghXe
         xjBxArB46pbRc4APudG2DJq7ecYNJ+2Pdaq0Kbbc8a5PWPo0F3EXgiyUGmtFpCiGwO0E
         12kFA46In9lWzg5ysdwq6YqvolScUu2Q8RW4MHDDvxFwoK5o0gdgD7eHXgPRp7PoG6J2
         iBzkHU5qYYSS9t3xnbf39HE9FGKjUDXqz1AQhJegzwgQHVFa2yijVUWgWOaDYa7UvjIl
         CTLSLvxtN4s1NuuBiw5RMHuOTG/ZIJf0mrspeboHPJNks0Ki+Upbqi9HQ7M9j+Au12ph
         RmwA==
X-Forwarded-Encrypted: i=1; AJvYcCUoMeWGHx7aVNDxGx+u8UOnogHHDUagYVnoAnSqSB4O7Aan6RklBgObL1U1uvOE+C8BB2brEEKTQuUdAZhNJr0QQbbTle1/kTpvoYws
X-Gm-Message-State: AOJu0Yzon+STWCXodJZkO0s+53aoaBPLnUDhMut00FCl4V6QU5puEDOo
	GUAGN+5g/GpsE8YJSrUFggpvISw7xQv5k7k8kJPAGS5/tQCxNNIL
X-Google-Smtp-Source: AGHT+IH9n6BhdAJw7G4F2+YydKXN+rz1liwwXPHOVQDO7HdvFCozclXvs26Kk/AtYPZGnDfGPiK3nA==
X-Received: by 2002:a17:903:2345:b0:1fb:8620:c0bd with SMTP id d9443c01a7336-2009526a7a2mr30143725ad.15.1723141504027;
        Thu, 08 Aug 2024 11:25:04 -0700 (PDT)
Received: from DESKTOP-DUKSS9G. (c-76-133-131-165.hsd1.ca.comcast.net. [76.133.131.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59176c89sm127786065ad.192.2024.08.08.11.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 11:25:03 -0700 (PDT)
Message-ID: <66b50d7f.170a0220.2171ed.8a4f@mx.google.com>
X-Google-Original-Message-ID: <ZrUNfp4_HbcWRmDc@DESKTOP-DUKSS9G.>
Date: Thu, 8 Aug 2024 11:25:02 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Alex Shi <seakeel@gmail.com>
Cc: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	minchan@kernel.org, willy@infradead.org, senozhatsky@chromium.org,
	david@redhat.com, 42.hyeyoo@gmail.com,
	Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
Subject: Re: [PATCH v4 06/22] mm/zsmalloc: convert create_page_chain() and
 its users to use zpdesc
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-7-alexs@kernel.org>
 <66ad2ef0.170a0220.8fae7.6e38@mx.google.com>
 <a3cc7157-6ea0-4493-8baf-c988b9fa4dcb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3cc7157-6ea0-4493-8baf-c988b9fa4dcb@gmail.com>

On Mon, Aug 05, 2024 at 04:20:15PM +0800, Alex Shi wrote:
> 
> 
> On 8/3/24 3:09 AM, Vishal Moola wrote:
> > On Mon, Jul 29, 2024 at 07:25:18PM +0800, alexs@kernel.org wrote:
> >> From: Alex Shi <alexs@kernel.org>
> >>
> >> Introduce a few helper functions for conversion to convert create_page_chain()
> >> to use zpdesc, then use zpdesc in replace_sub_page() too.
> > 
> > As a general note, I've been having trouble keeping track of your helper
> > functions throughout your patchset. Things get confusing when helper
> > functions are "add-ons" to patches and are then replaced/rewritten
> > in various subsequent patches - might just be me though.
> 
> Right, maybe too much helper doesn't give necessary help.
> 
> > 
> >> Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> >> Signed-off-by: Alex Shi <alexs@kernel.org>
> >> ---
> >>  mm/zpdesc.h   |   6 +++
> >>  mm/zsmalloc.c | 115 +++++++++++++++++++++++++++++++++-----------------
> >>  2 files changed, 82 insertions(+), 39 deletions(-)
> >>
> >> diff --git a/mm/zpdesc.h b/mm/zpdesc.h
> >> index 79ec40b03956..2293453f5d57 100644
> >> --- a/mm/zpdesc.h
> >> +++ b/mm/zpdesc.h
> >> @@ -102,4 +102,10 @@ static inline struct zpdesc *pfn_zpdesc(unsigned long pfn)
> >>  {
> >>  	return page_zpdesc(pfn_to_page(pfn));
> >>  }
> >> +
> >> +static inline void __zpdesc_set_movable(struct zpdesc *zpdesc,
> >> +					const struct movable_operations *mops)
> >> +{
> >> +	__SetPageMovable(zpdesc_page(zpdesc), mops);
> >> +}
> >>  #endif
> >> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> >> index bbc165cb587d..a8f390beeab8 100644
> >> --- a/mm/zsmalloc.c
> >> +++ b/mm/zsmalloc.c
> >> @@ -248,6 +248,41 @@ static inline void *zpdesc_kmap_atomic(struct zpdesc *zpdesc)
> >>  	return kmap_atomic(zpdesc_page(zpdesc));
> >>  }
> >>  
> >> +static inline void zpdesc_set_zspage(struct zpdesc *zpdesc,
> >> +				     struct zspage *zspage)
> >> +{
> >> +	zpdesc->zspage = zspage;
> >> +}
> >> +
> >> +static inline void zpdesc_set_first(struct zpdesc *zpdesc)
> >> +{
> >> +	SetPagePrivate(zpdesc_page(zpdesc));
> >> +}
> >> +
> > 
> > I'm not a fan of the names above. IMO, naming should follow some
> > semblance of consistency regarding their purpose (or have comments
> > that describe their purpose instead).
> > 
> > At a glance zpdesc_set_zspage() and zpdesc_set_first() sound like they
> > are doing similar things, but I don't think they serve similar purposes?
> 
> zpdesc_set_zspage() only used in one place, a helper maynot needed. Let me remove it.
> Same thing for the alloc_zpdesc() and free_zpdesc(), they could be merge into using place.

alloc_zpdesc() and free_zpdesc() are fine as is. The helper functions
will be useful whenever memdescs can be allocated on their own, so its
better to introduce it now.

> Thanks
> Alex
> > 
> >> +static inline void zpdesc_inc_zone_page_state(struct zpdesc *zpdesc)
> >> +{
> >> +	inc_zone_page_state(zpdesc_page(zpdesc), NR_ZSPAGES);
> >> +}
> >> +
> >> +static inline void zpdesc_dec_zone_page_state(struct zpdesc *zpdesc)
> >> +{
> >> +	dec_zone_page_state(zpdesc_page(zpdesc), NR_ZSPAGES);
> >> +}
> >> +
> >> +static inline struct zpdesc *alloc_zpdesc(gfp_t gfp)
> >> +{
> >> +	struct page *page = alloc_page(gfp);
> >> +
> >> +	return page_zpdesc(page);
> >> +}
> >> +
> >> +static inline void free_zpdesc(struct zpdesc *zpdesc)
> >> +{
> >> +	struct page *page = zpdesc_page(zpdesc);
> >> +
> >> +	__free_page(page);
> >> +}
> >> +
> >  

