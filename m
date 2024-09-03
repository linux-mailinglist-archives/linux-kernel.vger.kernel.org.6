Return-Path: <linux-kernel+bounces-313482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B92896A5F4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B8E2815E4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29E318FDAB;
	Tue,  3 Sep 2024 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="YwkqFwpN"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D492175D45
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725386134; cv=none; b=D7nPokESv5662oevatTR3bUXLiMSJJKaYd5LdZ1IIEOjnunu2OVAFq175+AAhNVCW9ZkHo+oGHoYbsYc2AwG72UzAa2lhSvACPte/dOZpaRK7HQNju5LdOLILSm+qFr1tRwuvihHZCIe7T8FDuFYY64x1ZmCeOLLfXC12hm6yHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725386134; c=relaxed/simple;
	bh=li/3d7Z75HftVMUUZtfQuhrF3OBX0UDj0AUSWtpGMOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nj0yvGyAyI8qQob4Z+aIPKfJNsdP3Z7eRLeaZqxD7w7sbHQbYMOalfluZ723Z3ODDn6I6YkejRWiHD7zzjEKkWIK+E3gtI9p3NoAJXLszzmHuvKZ/uX03ELqPLWau/nhBmARVMF+HpExXQ8wLPIKrFv9on5P6ephNb66qiNFHPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=YwkqFwpN; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a7f94938fcso365576885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1725386131; x=1725990931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N/Q1h4ajHNabaJYI3kmNs7vt5x1dUD7YjNa66CSW5iI=;
        b=YwkqFwpN/vmk5QHWtGjK60lhPWPVkkRHiz41t762xnm9EzQb7baIzzhPNdTdpOAQXH
         3ZvCJQk/w4kxSgNt4J0bHfDV+zgsM5MrQJtV20SwgnxP3/LlzKTbIzrC8XZ/Q3h19VOn
         rI8kMrhmBRKv6zBwxq5wERXRavdnq2zEhBup2xVWpO0//2Vroh8RCEYV+qdcJlVyCvPu
         Y8/6z9ebdtRexXxQIqLqFphDlD7yNga0SbPh1h8yMarGPaiTG6kWMdSQuOK4Q+1wmE/J
         FtprYuRaRaQAgIF2xn+Cwhh3wmYbJZnAnlJPTgYrSgV+SVDgCDMBdqxzSel5FarIh2iN
         3S9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725386131; x=1725990931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/Q1h4ajHNabaJYI3kmNs7vt5x1dUD7YjNa66CSW5iI=;
        b=Jn9CkCCeCT5LUsrnuXE52Sh7vtHkkKAI7z0qmJKvXgxTEwoBNdURINn46l/eN9MYKk
         ktcppRapORqk5vkPhHELFzZoVvQv6tQ4vnadtcNdK5t3phifUmFNU/7+BM3MjlN0c/Ji
         SzbDL4uRupB6lzElv1mrcE8xxEZ/eTsYkdahy2tsEc1L/hmvzCDIDJqjAhDXiyo1WAGM
         hG9s+J1tSppzKJWclW8USL459KKyir7s66RGiwFyRq9ZsJsy8K1tu+XwL1+ZSYHjJI0s
         QAO+f5flb37OQ6+gNuMI7WuKIqpkddmdH91QOFRxdeIfXB0pGz66CkGao4vyEmSUPCUT
         gCHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWyFyUzV1L9KHFmvl/jJ9vCheRnZQI3SoNyhS4AmXcqA8IxlRTLt/Lrk/28lk/wcrNIQEgsas1aQzjwvw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2be4eDhSqu6Q47Q4vDXZEyIUrTudAU52EqtkobOgRR43oEq1O
	Iyk4ModV/Vh0qsoCfc0dyrHXlUyx1cKF/kjn4yI4DrVDLSe0Qr3YaKIH8w/kSGh8NqVXXndTDnk
	6
X-Google-Smtp-Source: AGHT+IFgxYH4P9t/++E4OuacuCZCjGeccSamQH/800JhD0AraoieCe4tQyyQDrgXM82aAx9boW2//g==
X-Received: by 2002:a05:620a:3909:b0:7a7:faf4:9aab with SMTP id af79cd13be357-7a804186b9amr2000159185a.4.1725386130760;
        Tue, 03 Sep 2024 10:55:30 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d60b35sm547183985a.118.2024.09.03.10.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 10:55:30 -0700 (PDT)
Date: Tue, 3 Sep 2024 13:55:28 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Kconfig: fixup zsmalloc configuration
Message-ID: <20240903175528.GA1190078@cmpxchg.org>
References: <20240903040143.1580705-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903040143.1580705-1-senozhatsky@chromium.org>

On Tue, Sep 03, 2024 at 01:00:22PM +0900, Sergey Senozhatsky wrote:
> zsmalloc is not exclusive to zswap. Commit aa3ba6d72ce0
> ("mm: Kconfig: fixup zsmalloc configuration") made CONFIG_ZSMALLOC
> only visible when CONFIG_ZSWAP is selected, which makes it
> impossible to menuconfig zsmalloc-specific features (stats,
> chain-size, etc.) on systems that use ZRAM but don't have ZSWAP
> enabled.
> 
> Make zsmalloc depend on both ZRAM and ZSWAP.
> 
> Fixes: Fixes: aa3ba6d72ce0 ("mm: Kconfig: fixup zsmalloc configuration")

I can't find this commit upstream.

It looks like this was actually broken by

commit b3fbd58fcbb10725a1314688e03b1af6827c42f9
Author: Johannes Weiner <hannes@cmpxchg.org>
Date:   Thu May 19 14:08:53 2022 -0700

    mm: Kconfig: simplify zswap configuration

instead?

The patch itself looks good to me.

> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  mm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index b23913d4e47e..1aa282e35dc7 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -188,7 +188,7 @@ config Z3FOLD
>  
>  config ZSMALLOC
>  	tristate
> -	prompt "N:1 compression allocator (zsmalloc)" if ZSWAP
> +	prompt "N:1 compression allocator (zsmalloc)" if (ZSWAP || ZRAM)
>  	depends on MMU
>  	help
>  	  zsmalloc is a slab-based memory allocator designed to store
> -- 
> 2.46.0.469.g59c65b2a67-goog
> 

