Return-Path: <linux-kernel+bounces-273030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D616D946391
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635631F2254F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AAE1547C6;
	Fri,  2 Aug 2024 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB8fPxff"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FEF1ABED6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722625779; cv=none; b=mgRRBePiDNbQ5/SRuKOw1P8OizbOJHulu4ZMIp/wNKoZPq4WaKGrCzGX4vNYU6eQ7FepeaOEsqQKDJ4M6+451wP3n+ehS88imdMfOGLcxElDIbK0BTHwJ3NpiocV3+5WD3pF7x2V0xIvFxkIutbSV2+7QbtRSipRAChiq4avAjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722625779; c=relaxed/simple;
	bh=pMbs9x2ajC+7hccL7a8IVX/TiDzmM07Y7YbgRggqSFg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZS+v4au2fEBef2Wph75QQgavFjC8CVusvLAMkUmVq19vEH0TA8dS/DwHgAVLaV+72HxDpTGkHS/o3dpSsZXuV1fExeHX2HQXfgFrGIt0wIOQDmWo/S+/4uIHTnC4akTEtuhsYLx4LyHny4IKZvgS6uBJsngcytpuVAf3b7DhCyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GB8fPxff; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc5549788eso68780955ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 12:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722625777; x=1723230577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JCgArWjWpFDrL4jHS2ovm6vU+UN1u75TOXE4f9e32Mc=;
        b=GB8fPxff1BIDiXY+oaIwsu3Kt7QJzYIK4WhovrCLFWSGxAJIwMScVXk7YApZy6kJsy
         z5/thYeAJg+sWlPmOh9q6lNrB/qAtXtBiZ+YBvGso4eKFS8yoOrJ6RdjHaH9YcnK+wd1
         o+tXvkABQtY8lP1hp+DUmQMpCzV8LYIAXK6EGLvweRW/zzOz3KwKJ9rGq3BhNZlGqMzD
         Pdc2FdDbDawT4WyQtSKpO3EqsubzeEKZsREydArhRetZvRwDpqzn81+P2PC0q8G9mEDi
         6N2rvuLTvQi4bgVy7QemUNlD6AzkYTC+/MQrB0WXXsS1NWqZ8sLwGq12jjlWMUxRAFSr
         5NlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722625777; x=1723230577;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCgArWjWpFDrL4jHS2ovm6vU+UN1u75TOXE4f9e32Mc=;
        b=gl/9I6Om6tR4P5kLMqivZbwQDHpdqnugKCyaVAzDDPUFmudHa85+ZJfSzWbkAnR4K4
         /Yd0J0flrVEtRLQU4dVLzDRnSR9cP3j0zFSjuYWQROTVUyVccysCf75mdo2l0KBmiiGj
         0xOCeiGGZ6a8bNcCr3ytsKfGcwtByjYmsmjyezVH1b1wL5W476S0u32Txd5/VZhHF+Dx
         Ln7Ei0bIzjK0pMvMqv4XGuHfIONwNLysS33pVDdK1vdCmh2Ee+6pBmyikxoHiTeW2Cn6
         SdijcUeDJVcnZWsQNobHhf7ViQLGY/TgkuPFdYQOTv67aZywDY08py+3Yqj/EKrfN/aV
         f+TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjPEW1mx3Jb6/P8/cpQIT35AlzxmEYweNc++kKxs3V4iyceUOelwcNAEQkWMm97N1jIHwZSSHtO+phQoJEDtJBySSVaGt0fDdkvgH0
X-Gm-Message-State: AOJu0YwamPJuJc89U7m8htTo+KjPxHcR2sio8Y1VK8U0Nzuu6CNw17ow
	2ssHaNJcwhGiOrzarE4bz/bQKpZaM9+Qn80gmz25zocqeEdvFM9D
X-Google-Smtp-Source: AGHT+IGT6lvas/msTmacqMQ0wghizGXob7PE44eFUwtJmmUETTwfgNk0Daqo4+P9v7p0rToX6O5djA==
X-Received: by 2002:a17:902:f68c:b0:1fd:6848:bc35 with SMTP id d9443c01a7336-1ff572fa64fmr55783935ad.33.1722625777181;
        Fri, 02 Aug 2024 12:09:37 -0700 (PDT)
Received: from DESKTOP-DUKSS9G. (c-76-133-131-165.hsd1.ca.comcast.net. [76.133.131.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f57160sm20907425ad.96.2024.08.02.12.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 12:09:36 -0700 (PDT)
Message-ID: <66ad2ef0.170a0220.8fae7.6e38@mx.google.com>
X-Google-Original-Message-ID: <Zq0u7sJOiu0j5k3V@DESKTOP-DUKSS9G.>
Date: Fri, 2 Aug 2024 12:09:34 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>,
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729112534.3416707-7-alexs@kernel.org>

On Mon, Jul 29, 2024 at 07:25:18PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> Introduce a few helper functions for conversion to convert create_page_chain()
> to use zpdesc, then use zpdesc in replace_sub_page() too.

As a general note, I've been having trouble keeping track of your helper
functions throughout your patchset. Things get confusing when helper
functions are "add-ons" to patches and are then replaced/rewritten
in various subsequent patches - might just be me though.

> Originally-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> ---
>  mm/zpdesc.h   |   6 +++
>  mm/zsmalloc.c | 115 +++++++++++++++++++++++++++++++++-----------------
>  2 files changed, 82 insertions(+), 39 deletions(-)
> 
> diff --git a/mm/zpdesc.h b/mm/zpdesc.h
> index 79ec40b03956..2293453f5d57 100644
> --- a/mm/zpdesc.h
> +++ b/mm/zpdesc.h
> @@ -102,4 +102,10 @@ static inline struct zpdesc *pfn_zpdesc(unsigned long pfn)
>  {
>  	return page_zpdesc(pfn_to_page(pfn));
>  }
> +
> +static inline void __zpdesc_set_movable(struct zpdesc *zpdesc,
> +					const struct movable_operations *mops)
> +{
> +	__SetPageMovable(zpdesc_page(zpdesc), mops);
> +}
>  #endif
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index bbc165cb587d..a8f390beeab8 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -248,6 +248,41 @@ static inline void *zpdesc_kmap_atomic(struct zpdesc *zpdesc)
>  	return kmap_atomic(zpdesc_page(zpdesc));
>  }
>  
> +static inline void zpdesc_set_zspage(struct zpdesc *zpdesc,
> +				     struct zspage *zspage)
> +{
> +	zpdesc->zspage = zspage;
> +}
> +
> +static inline void zpdesc_set_first(struct zpdesc *zpdesc)
> +{
> +	SetPagePrivate(zpdesc_page(zpdesc));
> +}
> +

I'm not a fan of the names above. IMO, naming should follow some
semblance of consistency regarding their purpose (or have comments
that describe their purpose instead).

At a glance zpdesc_set_zspage() and zpdesc_set_first() sound like they
are doing similar things, but I don't think they serve similar purposes?

> +static inline void zpdesc_inc_zone_page_state(struct zpdesc *zpdesc)
> +{
> +	inc_zone_page_state(zpdesc_page(zpdesc), NR_ZSPAGES);
> +}
> +
> +static inline void zpdesc_dec_zone_page_state(struct zpdesc *zpdesc)
> +{
> +	dec_zone_page_state(zpdesc_page(zpdesc), NR_ZSPAGES);
> +}
> +
> +static inline struct zpdesc *alloc_zpdesc(gfp_t gfp)
> +{
> +	struct page *page = alloc_page(gfp);
> +
> +	return page_zpdesc(page);
> +}
> +
> +static inline void free_zpdesc(struct zpdesc *zpdesc)
> +{
> +	struct page *page = zpdesc_page(zpdesc);
> +
> +	__free_page(page);
> +}
> +
 

