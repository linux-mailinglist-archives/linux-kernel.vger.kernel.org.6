Return-Path: <linux-kernel+bounces-531705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E126BA443DE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1595A7A43B4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0FF268C7F;
	Tue, 25 Feb 2025 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="wy7aP/JO"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977AE3A27B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495890; cv=none; b=SbtRTi+GRqWY35dA9TKvX+GjXfNRhYghWEa6e1BhGHEOg5Wrpy6yCkWFrBI9MXv4TOPMpGKEN2DsOhvOJ2UES+FLZbIv4TIxLlkfE9PzOimwy89sWgIS9VIeP9UG3eYemldzqCrTXvq2Pp2nqs4vMBB6GnSLhOKc4nwp565ll0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495890; c=relaxed/simple;
	bh=vT53ahoBMOSafvYOD117cJ99F2Z9LH2oLQSGpsKHzsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP/DmzZCLRO/tyzzaFO3GxdANU1Pl5atk/q9/BWBeLCYOxi5LGd+beYPMTauwPf1ccUHXdCmUWg9N4yyJ+fjEJJaU+C7i7UhRJFaLMAiJUofyWQizkLM6g2vJciZU5z9ouXdGDVLJDRKEharxaj/+ExF9h5BoSsJV6/nBSvJANA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=wy7aP/JO; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e41e17645dso59054886d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740495886; x=1741100686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nn6Uxgl3eAo9l3NW1uWYKG21RtNcAXLzEO35VKD04Go=;
        b=wy7aP/JOSZrx/p3hlDrQHrAOSKm7PQHqVbLtihiXLe77jS09lpHNL9r1tgEytiJqQl
         EQqww1jDNqtHSGqJPe1MbfZ6AQZknpxRSh+d/6OTwGosUpQ4HSCu8kTfp/QCvpDlqj8J
         Xq7nBNF0RI+io3ifO0+tZAM+PRaA19P/0HJUOWckRK27HdQyl7u30RCNfQSX6XmgOtLY
         a7tXLanjZ5BDTY1Sclws2T9Uion+GevswV46FF8sxaoaHroRinvejX0drQsMmPSmzoha
         wQfvSdZALn049/hlWtNr0233uFRk6pkxZMKOBPRDoPVDRDXaT07bIKisEAmGJ8LTWPm2
         3T3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740495886; x=1741100686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nn6Uxgl3eAo9l3NW1uWYKG21RtNcAXLzEO35VKD04Go=;
        b=loMnVOJIbOPYYkJqr3W/K/FXAFmw5+cM6cPB8pWqmZyXAE6WItPFMV62x1n1vvmDA3
         P41t2yTwSch8PDPek9lvyUlDpiRADlCBOtBCIkqSCkmsLYOe3V9q0kHlssZN3AoDAd4t
         NiKifbX9ZEybuVokDahfYtnEVIrItEtmM0thbDxNO3zTO5Do6T7ceiJf/1awt2Jq4MGH
         6E+BvVwvA+4QZ/2YxCsM4AkmK6XXER50vX1xEpwgmVxf87zhJlYp/OQkurKaIh5UeyA1
         P5YMT0cIgnAgvL1xWH5K4tadz2/Wgce+XrGkVNGPT/wwMzBTCW0UysW53yoIr3gcXAj9
         GSNA==
X-Forwarded-Encrypted: i=1; AJvYcCVv3AoG6mTNGjbsGHi8JGbkZ2AKqWROT56f3Mde9Id56b3Esc0YbHzfL09TzlHDvMh1HJf2W3bWnzlgwyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxazQeWxvp2GvznVZaWnvAI0vy6+Yvjpe20mFC5UaFV+2tUk9cN
	y6Md9DplQFKIw4ZU11vV8h+OXP5ZnrWJ/E/Gvn3Zu46OUMvelDbVH0LAkA1TNVk=
X-Gm-Gg: ASbGncvQPGBW1zpNQ9qpoNe3nHcdIPwpRyQS17dhDC/iZc53R9IM13z8DcahgoSHfsz
	QH82HL97n3Unq5la5wvkCiO6dYFiIqhMCp2UGVnsFw/PFFbJCINzU80czkHx3wgF09+2LVr3f0B
	bUBMV/LQEQgCjzOuEwbZRS8IJyjQCPM92kOnrD5w+TGWWRgcf6UZQ09fcl15LGRZ0dANMq5NxEo
	3wE/XO5XNhKYbzakQrPyV7MfizhfGVhkCkVVKcR1R4B1Tfj2CQqV05Zw9ZkMvc7l7uLKEqRAoFT
	NBbf7UZy7qGDrFbr08WRjG4R
X-Google-Smtp-Source: AGHT+IGonCnwQEj5UDFxTvMWr15lZ0jTE+5hj5ccntmODdWVtK3zIvgmZ1LmA0sV0c9X2ShiF6SaoQ==
X-Received: by 2002:a05:6214:27e2:b0:6e4:1e16:b63d with SMTP id 6a1803df08f44-6e6ae826c01mr255677666d6.21.1740495886247;
        Tue, 25 Feb 2025 07:04:46 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e87b1564easm10084066d6.72.2025.02.25.07.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 07:04:45 -0800 (PST)
Date: Tue, 25 Feb 2025 10:04:41 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: page_alloc: don't steal single pages from
 biggest buddy
Message-ID: <20250225150441.GA1499716@cmpxchg.org>
References: <20250225001023.1494422-1-hannes@cmpxchg.org>
 <20250225001023.1494422-2-hannes@cmpxchg.org>
 <Z73G6A6asz_KrGTo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73G6A6asz_KrGTo@google.com>

On Tue, Feb 25, 2025 at 01:34:32PM +0000, Brendan Jackman wrote:
> On Mon, Feb 23, 2025 at 07:08:24PM -0500, Johannes Weiner wrote:
> > The fallback code searches for the biggest buddy first in an attempt
> > to steal the whole block and encourage type grouping down the line.
> > 
> > The approach used to be this:
> > 
> > - Non-movable requests will split the largest buddy and steal the
> >   remainder. This splits up contiguity, but it allows subsequent
> >   requests of this type to fall back into adjacent space.
> > 
> > - Movable requests go and look for the smallest buddy instead. The
> >   thinking is that movable requests can be compacted, so grouping is
> >   less important than retaining contiguity.
> > 
> > c0cd6f557b90 ("mm: page_alloc: fix freelist movement during block
> > conversion") enforces freelist type hygiene, which restricts stealing
> > to either claiming the whole block or just taking the requested chunk;
> > no additional pages or buddy remainders can be stolen any more.
> > 
> > The patch mishandled when to switch to finding the smallest buddy in
> > that new reality. As a result, it may steal the exact request size,
> > but from the biggest buddy. This causes fracturing for no good reason.
> > 
> > Fix this by committing to the new behavior: either steal the whole
> > block, or fall back to the smallest buddy.
> > 
> > Remove single-page stealing from steal_suitable_fallback(). Rename it
> > to try_to_steal_block() to make the intentions clear. If this fails,
> > always fall back to the smallest buddy.
> 
> Nit - I think the try_to_steal_block() changes could be a separate
> patch, the history might be easier to understand if it went:
> 
> [1/N] mm: page_alloc: don't steal single pages from biggest buddy
> [2/N] mm: page_alloc: drop unused logic in steal_suitable_fallback()

There are several ways in which steal_suitable_fallback() could end up
taking a single page, and I'd have to mirror all those conditions in
the caller if I wanted to prevent this. That would be too convoluted.

> >  static __always_inline struct page *
> >  __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
> > @@ -2291,45 +2289,35 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
> >  		if (fallback_mt == -1)
> >  			continue;
> >  
> > -		/*
> > -		 * We cannot steal all free pages from the pageblock and the
> > -		 * requested migratetype is movable. In that case it's better to
> > -		 * steal and split the smallest available page instead of the
> > -		 * largest available page, because even if the next movable
> > -		 * allocation falls back into a different pageblock than this
> > -		 * one, it won't cause permanent fragmentation.
> > -		 */
> > -		if (!can_steal && start_migratetype == MIGRATE_MOVABLE
> > -					&& current_order > order)
> > -			goto find_smallest;
> > +		if (!can_steal)
> > +			break;
> >  
> > -		goto do_steal;
> > +		page = get_page_from_free_area(area, fallback_mt);
> > +		page = try_to_steal_block(zone, page, current_order, order,
> > +					  start_migratetype, alloc_flags);
> > +		if (page)
> > +			goto got_one;
> >  	}
> >  
> > -	return NULL;
> > +	if (alloc_flags & ALLOC_NOFRAGMENT)
> > +		return NULL;
> 
> Is this a separate change? Is it a bug that we currently allow
> stealing a from a fallback type when ALLOC_NOFRAGMENT? (I wonder if
> the second loop was supposed to start from min_order).

No, I don't see how we could hit that right now. With NOFRAGMENT, the
first loop scans whole free blocks only, which, if present, are always
stealable. If there are no blocks, the loop continues through all the
fallback_mt == -1 and then the function returns NULL. Only without
NOFRAGMENT does it run into !can_steal buddies.

IOW, the control flow implicit in min_order, can_steal and the gotos
would make it honor NOFRAGMENT - albeit in a fairly non-obvious way.

The code is just a bit odd. While the function currently looks like
it's two loops following each other, this isn't how it's actually
executed. Instead, the first loop is the main sequence of the
function. The second loop is entered only from a jump in the main loop
under certain conditions, more akin to a function call.

I'm changing the sequence so that all types fall back to the smallest
buddy if stealing a block fails. The easiest way to express that is
removing the find_smallest jump and having the loops *actually* follow
each other as the main sequence of this function.

For that, I need to make that implicit NOFRAGMENT behavior explicit.

