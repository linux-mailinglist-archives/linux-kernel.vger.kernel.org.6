Return-Path: <linux-kernel+bounces-273028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFAF946383
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01661281A6A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6B313634B;
	Fri,  2 Aug 2024 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+zWebKB"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F51ABEBD
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722625327; cv=none; b=B1iZhYQb96iig3mfwFd7zLLai4hSAPAPBouvEBQEdQwuQ4tZa83J/f4VqYoP5DtwUDSmIRjYQOUU1OUIv60tEqhq0t5YbHV2A2GXOHrZNA07wUCUKTEo2mrrx9bQTZf9uRWB1KE8gO0BSKikXDhm/THacuIAACZ2RSDsCBZ0zUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722625327; c=relaxed/simple;
	bh=xzkwMCBQyWM3Tf0I+QmHifLWtxH/k5TuWD/8eJJYW+w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRQ+YnTcRbQTMMIh/0FV+Q17p//jFWZ0+bxhjXUZes1a47b0OOJ9k4TJTEaBqOa+ymv3BUBqOzWKxOuriJHzxJDgiFcLMYJetuzd5fXhdE6ahLdSZA+mrO5yWuht4oY4/5cxyH3HfHTH1E9PC6CuJGgmWuNb8QjDNYA6NFDd8kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+zWebKB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd6ed7688cso72134535ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 12:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722625326; x=1723230126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xaPRu7hct9rtRu+ze3cCugybIgVJ/rIQubAhNiOPdcE=;
        b=f+zWebKBVR1yd8Phx49Cgl/tq/ZlX7k2zmOFNh82IpNUdjDVzF/DjbRX5TBEwV245T
         T8VhJEUU11ppOevznjQKWmw1pA7DHz7TlYKAOByErn6S9rR0OKAKhYIh1V+I9y+uJqAU
         miTTvfhpxPYU7r/ZYK6i2XyLsqCOcblIDbdrGDJx07ln9G8gojiXVKrywG//58Q1MoBE
         UPF0o1T3Tau4FvRzshEQ0XUhpvn7SJNExlVLMHU35TAqkYMqAZBppzDdnNYK52DBc8SG
         /NDwYSQGTKFo0DnVFrSXvLRt5QZLLknlM+1F9sjXal6oWFW4ehgRSm5Odks2xQQfCw0O
         J5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722625326; x=1723230126;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaPRu7hct9rtRu+ze3cCugybIgVJ/rIQubAhNiOPdcE=;
        b=Xs0FWX9r5RSy544yaRCmqu9l3xRGlSGsS4+KrQ8pQJ57Z+/6HHBzn6xX6XKxhd8/Ql
         zpPHzKuoXU9seo76F3l9kmTNsrTsXVCDiT5IlTeQRWoemAnLsZty4Lznqgd/bWK/5NZf
         zc0GdDu5dTbvb0YvrX/CYmBJZgBia2q/QQ4/rgnyUNl47DkzX1vlETi0SL8qGEq37Jxq
         AYqMRn8VPlLDm4JBnShb3k8ULfzh909mMo8Loqmz77kQpuMFKJDeCxsoQ+osPvNiJzgV
         lLNPcig+BimI8OCmqchfZz3MRW0V6gZ/5L3PnOmjomKGwNPw3JuFfZoouunKaLzZz70n
         9SaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR7H3u1+nokuEFd/1gE3FVvGtHtlzp4LEj6BsdhRaGdBaJcdpGsdkVnhR7bs9Lghn4qcymWAv1ePhOHGqJuNeYyTMO/TPrbsBMM24y
X-Gm-Message-State: AOJu0YxCOyhWoGr1z6lCjMoKOM9j3/qq8U4MmPTHhcx0f9TWjCUMN2d5
	ualnDctkVDaJhWT50Ei0z0VncI5Z4jpmNtuE09EtfaVB3nLmz5NS
X-Google-Smtp-Source: AGHT+IFTtWPpiX5zilQD7jUgvn/k5ycmash7C+7lavtCrkyuc7txDisExatDGL0C1GCIEv746aY+AA==
X-Received: by 2002:a17:903:234e:b0:1f7:3d0d:4cd with SMTP id d9443c01a7336-1ff57292a32mr56535135ad.24.1722625325543;
        Fri, 02 Aug 2024 12:02:05 -0700 (PDT)
Received: from DESKTOP-DUKSS9G. (c-76-133-131-165.hsd1.ca.comcast.net. [76.133.131.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53c59sm20682765ad.69.2024.08.02.12.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:02:05 -0700 (PDT)
Message-ID: <66ad2d2d.170a0220.668d3.6c80@mx.google.com>
X-Google-Original-Message-ID: <Zq0tKsNhSiAYDO7W@DESKTOP-DUKSS9G.>
Date: Fri, 2 Aug 2024 12:02:02 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	minchan@kernel.org, willy@infradead.org, senozhatsky@chromium.org,
	david@redhat.com, 42.hyeyoo@gmail.com,
	Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
Subject: Re: [PATCH v4 02/22] mm/zsmalloc: use zpdesc in
 trylock_zspage/lock_zspage
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-3-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729112534.3416707-3-alexs@kernel.org>

On Mon, Jul 29, 2024 at 07:25:14PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> To use zpdesc in trylock_zspage/lock_zspage funcs, we add couple of helpers:
> zpdesc_lock/zpdesc_unlock/zpdesc_trylock/zpdesc_wait_locked and
> zpdesc_get/zpdesc_put for this purpose.

You should always include the "()" following function names. It just
makes everything more readable.

> Here we use the folio series func in guts for 2 reasons, one zswap.zpool
> only get single page, and use folio could save some compound_head checking;
> two, folio_put could bypass devmap checking that we don't need.
> 
> Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> ---
>  mm/zpdesc.h   | 30 ++++++++++++++++++++++++
>  mm/zsmalloc.c | 64 ++++++++++++++++++++++++++++++++++-----------------
>  2 files changed, 73 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/zpdesc.h b/mm/zpdesc.h
> index 2dbef231f616..3b04197cec9d 100644
> --- a/mm/zpdesc.h
> +++ b/mm/zpdesc.h
> @@ -63,4 +63,34 @@ static_assert(sizeof(struct zpdesc) <= sizeof(struct page));
>  	const struct page *:		(const struct zpdesc *)(p),	\
>  	struct page *:			(struct zpdesc *)(p)))
>  
> +static inline void zpdesc_lock(struct zpdesc *zpdesc)
> +{
> +	folio_lock(zpdesc_folio(zpdesc));
> +}
> +
> +static inline bool zpdesc_trylock(struct zpdesc *zpdesc)
> +{
> +	return folio_trylock(zpdesc_folio(zpdesc));
> +}
> +
> +static inline void zpdesc_unlock(struct zpdesc *zpdesc)
> +{
> +	folio_unlock(zpdesc_folio(zpdesc));
> +}
> +
> +static inline void zpdesc_wait_locked(struct zpdesc *zpdesc)
> +{
> +	folio_wait_locked(zpdesc_folio(zpdesc));
> +}

The more I look at zsmalloc, the more skeptical I get about it "needing"
the folio_lock. At a glance it seems like a zspage already has its own lock,
and the migration doesn't appear to be truly physical? There's probably
something I'm missing... it would make this code a lot simpler to drop
many of the folio locks.

> +
> +static inline void zpdesc_get(struct zpdesc *zpdesc)
> +{
> +	folio_get(zpdesc_folio(zpdesc));
> +}
> +
> +static inline void zpdesc_put(struct zpdesc *zpdesc)
> +{
> +	folio_put(zpdesc_folio(zpdesc));
> +}
> +
>  #endif
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index a532851025f9..243677a9c6d2 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -433,13 +433,17 @@ static __maybe_unused int is_first_page(struct page *page)
>  	return PagePrivate(page);
>  }
>  
> +static int is_first_zpdesc(struct zpdesc *zpdesc)
> +{
> +	return PagePrivate(zpdesc_page(zpdesc));
> +}
> +

I feel like we might not even need to use the PG_private flag for
zpages? It seems to me like its just used for sanity checking. Can
zpage->first_page ever not point to the first zpdesc?

For the purpose of introducing the memdesc its fine to continue using
it; just some food for thought.

