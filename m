Return-Path: <linux-kernel+bounces-290722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B549557D7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 14:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12BD1F223B5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 12:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D3314D457;
	Sat, 17 Aug 2024 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGNnyzzj"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14558145B37
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723898523; cv=none; b=it+wYkUt2m1F6SaETOEWhVGPH39P/hzNIUNJe1WXzHv7t6AeZiQwlByOT4jV2/KyKgPPs35+zG8pUzxS4WSs0qRclt70COgh8PGJIYefu35K1uAKcSV7ktFDC/HxRCRY/uDFsjfoloxr73KWN61sH9r+HFGS02NHkwHW3QS58VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723898523; c=relaxed/simple;
	bh=zawVGMi36NR05FYscXVAShSiMsJ6gTMPq8l6RNLvSrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKR9jJ2miZBgvtVb1xUS1/t7O+YBA6DR0jljOs1Ufsg1NRLB2u2JtF0hc78JQlfKd0YD+ZNfR5+Ei3DDmrn/ichVmsc8TvPONgq6XWSb15SFf3cDdLTbI625KRY9qLgTL+psAxHLbyEGKELCk5SUz+aaav5Ue8UgjKIDq05YX/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGNnyzzj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42812945633so23158515e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 05:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723898520; x=1724503320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=28ncRbCpnkLJ5/D26aUzNQlA5NCqwwwLXApZ4Hr03aA=;
        b=PGNnyzzjMUIV8l/hA0bVULk4QI6blC2ezemfXfKrEraJR0qh/oqaOW9rz58oi0DyCn
         AaVSi7xyaIFhjJWi12uqdlL14eQA/6uzP4j0V4DdtsSyzBC6vLvPhumySFKZQh6IFlHk
         aoyD6c/KQy58/58oYNnS1lxrHVttx2oPkrcI3MeRK53HaTEv2aSOqoJiP9ekSzo1fX0g
         C4YdPHqGTT/eYt7hmzkce2LKic4AyiAmtvH/TmSg7B6t3K5oR0bkEhvh9ctJ3xDRKmgc
         ZovLhWpSp2BgqmJq/aNSEvY6rdkYxWK7CuFRwdQR9CQJSai34KVqYMQC5Y50p4UB4k1x
         bsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723898520; x=1724503320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28ncRbCpnkLJ5/D26aUzNQlA5NCqwwwLXApZ4Hr03aA=;
        b=EWtiw/UlKk3ypLPwDeT7BLr4h4P6g6wloKUZM+gqcRng0so19FL1Vsu0qPy6rLrPes
         SboXCKn9H0SzH3yml2metQI0i6NmmIRNTWJcKa6b8piDEtpMKIwiKpww/idTGsZ989Vu
         lkAI6jqv2HqCOjyAa6GfS+e2QF09uZBrhwbWUnidUFEVcpxbd7s+D84+jxqWOgdRMjMc
         fBcLBnmo6KnxbUi5b3+EfOCkM9XDw+RCpu8cuylMyp/PlTPv0EsbFpvjVGLSNt/SYz33
         GkYorsssyOJIEL15Fs230kWwYiL1w0ZqzRZYm8v3fr0ePLLsk3mq3mvDi3YxcJLv5VTE
         2+Yg==
X-Gm-Message-State: AOJu0YwdMEIwpGJ74Hdd7QhsroSAkH1hBy659aCMTihMk0i9mzVBhr5b
	xZbER+DKA42GFNZmnuHHDUiQPb5jKFhhefSUeRKS1sZpYIV/nFv9jYv1XQ==
X-Google-Smtp-Source: AGHT+IF8JcFonXeS5BqsGkaj2afPjHM0G8puSOTREdxaWXTjGQ+eOU2zmGVd5/Y5DyiGsw7uW5UPyQ==
X-Received: by 2002:a05:600c:3509:b0:426:6b92:387d with SMTP id 5b1f17b1804b1-429ed7b8860mr41405695e9.21.1723898519944;
        Sat, 17 Aug 2024 05:41:59 -0700 (PDT)
Received: from f (cst-prg-76-86.cust.vodafone.cz. [46.135.76.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d781047asm117761715e9.0.2024.08.17.05.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 05:41:59 -0700 (PDT)
Date: Sat, 17 Aug 2024 14:41:52 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] ratelimit: convert flags to int to save 8 bytes in size
Message-ID: <w65wgoyfu65xzeftqcc2xyrikvrq2nfmmqiq3z5jqytt65g3wu@2kykf4kwra3z>
References: <20240817123754.240924-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817123754.240924-1-mjguzik@gmail.com>

On Sat, Aug 17, 2024 at 02:37:54PM +0200, Mateusz Guzik wrote:
> Only bit 1 is used, making an unsigned long a total overkill.
> 
> This brings it from 64 to 32 bytes, which in turn shrinks user_struct

sigh, 40 to 32 bytes of course

this is embedded into user_struct, avoidably pushing it past 128 bytes
of size

> from 136 to 128 bytes. Since the latter is allocated with hwalign, this
> means the total usage goes down from 192 to 128 bytes per object.
> 
> No functional changes.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> ./scripts/get_maintainer.pl --git was most unhelpful showing nothing
> 
> I have no idea who to prod about it, I think it is pretty trivial not
> needing any discussion.
> 
> Andrew Morton pulled in some of the changes to the file, so that's my
> primary recipient.
> 
>  include/linux/ratelimit_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/ratelimit_types.h b/include/linux/ratelimit_types.h
> index 002266693e50..765232ce0b5e 100644
> --- a/include/linux/ratelimit_types.h
> +++ b/include/linux/ratelimit_types.h
> @@ -19,8 +19,8 @@ struct ratelimit_state {
>  	int		burst;
>  	int		printed;
>  	int		missed;
> +	unsigned int	flags;
>  	unsigned long	begin;
> -	unsigned long	flags;
>  };
>  
>  #define RATELIMIT_STATE_INIT_FLAGS(name, interval_init, burst_init, flags_init) { \
> -- 
> 2.43.0
> 
> 

