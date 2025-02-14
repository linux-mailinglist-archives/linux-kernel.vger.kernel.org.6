Return-Path: <linux-kernel+bounces-515540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4A1A36607
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC813AF471
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6CD19CD1D;
	Fri, 14 Feb 2025 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="W2ebnsqm"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD3F1946B1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739560471; cv=none; b=blBzJtbUx/zNb7yJ60RVyJK+Gre0dor9aMOmzYxSktM4PG6fNclEvsUeSkt21483jknXLfGinJKhiRa7O7az38rp+vYrHDwfD5zeeJmRAJSOKa3Z7RYN/YBqu6h5TMlbCXmhzLcbs8YA50iFmn3rtBuujb5+n/ly9BHW0kQApD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739560471; c=relaxed/simple;
	bh=ZhBFDuzc3VrwD7Mk5zFi1pXxOZ5GejvRS2vKAIH6C0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvuS2HjT6eiTOFB1gban3ywwV5tOE7t7fVbNaxuomd9ZPriBbkj7ghsTflCTbwb91iFj4r1dNcDj7DueX+SYHlcfh21G3q/DIS9qKK21RGvMO5qgbaFu6tKLnhAEqJyDRtteV5In02Mdna4xEOYm1wJ04rqdrAzWTadnnaPO2nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=W2ebnsqm; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e41e17645dso23312156d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1739560468; x=1740165268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gVF6evkbcSp3Y/Zct50ezsTDsgO/Q3tcJ2yCY7GXSSI=;
        b=W2ebnsqmPTuL7FCodz85Nlolm+I99qNJvED5t6YizbGhXTEipsIsiKHsVDJ9Bqjh6C
         dCTsoDw8l5ous6dgFdw3s4/USVnG8ehZn+CuEVkE7pgML8oMLNq5TM4ytOizv8VaZ4nZ
         RaMY6sNri3JUttlU4n6FGmP8k3isI8jDc62t/Yr85sdVmINTo2bTfLf+C2IAczM7sil7
         i+f3znisqPXDM0LZ5gkhQPd1aI2zdd6W6qIDhwkN5wKNCD3CIMPnQP5gL8G1+otE7IaV
         55pbCBsbt9YMn2Iherc4q7kFDkV2idbnKv4LxaYnqT8Jmdty/12VV7Xy+osSick41lQN
         K2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739560468; x=1740165268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVF6evkbcSp3Y/Zct50ezsTDsgO/Q3tcJ2yCY7GXSSI=;
        b=n4PSliRWZqoXTlL08BZEGXWJX33Sym2CkZeV7DfSddA1pDq5xiQreWCNs3zpOkWK1p
         QOydtIPGxrw50rR5WiP1M7Ijq9DOxvMjmuwympTYiudU3Ph05Ku/u4fy+yzkZHaN+4wf
         hAqhpwwI3+704FlvPhIFazgdi7OgwrvMhp51ejffzj830f9asnP/XSsQThUg/ZrjZMq4
         vfBU0BMyLTwL24RrgEZ+PrmZ+t7LCzpwRKa1Fg3nCz7Ldjk5zf2viZ8liGLpZdVlY4JT
         b8b8CjSS6Vx4NmVHwwRsupQDUb+ttILpU2OW4ukuZW+I5m1pZoyC257zfs6WPmh/e3oI
         M7WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvVIe/Ohht58BUG5H5cWhkg6huHD6xGNBuyN5RXq/fPBAo2D8rzH+0aNJnVeq/dvaEA39fZpYssCkCq3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCLCMwUsKdWDVUKfP0cHLLzLoFD6mhJQwxw/CVAsdOioo/L2fP
	wfLaotKn4tHFNzZl25xiuaUvcUlHsYMwkqHWwz2v0/HUHtqkc3Frn4pYyKZlA/k=
X-Gm-Gg: ASbGncvTvOFOM9FYYTgUqX9mbZGFy/uMVVSL/sxe6DVTXud4aJzuP95HdeiS9p6dURy
	hDhTMFfcBxYuI4BeAjpZzwR8GjmAy0K7LcDhCkBjW5E4TV1uFxhtQXD3GchcGoFKQ9W+SM61JmA
	y7rFZCyZi/OmUu46PbF4u4/g4oaEGmo/rt7LVxiDYHEECzydn31dA4oWnQF6MpbOvSzlQAz5Eol
	tgHdpO9/YR68ApiP1q9tZOVlHYA1I5zqee7hUnMn2aVH9zMZhloo/ZEXdVEhCFSEd/8Bg0gmUwO
	/1EOKIZCR9bs4VaeKKs6fO9hDtznatrT5k+wbi3KBCRkqV52uLnk3TTX7sLdP1Dm
X-Google-Smtp-Source: AGHT+IEpOYBQ8VIbK3Cs4VxKDEg6MhH4pTWCL5ZsktZ4iQ8Aw5votEpuA4RfcaOd/RCz1qokqGTfoA==
X-Received: by 2002:ad4:5fcd:0:b0:6e6:6b99:cd1e with SMTP id 6a1803df08f44-6e66ccda2d0mr5638616d6.26.1739560468280;
        Fri, 14 Feb 2025 11:14:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c5f370esm235072985a.13.2025.02.14.11.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 11:14:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tj18t-0000000GmIy-0YOE;
	Fri, 14 Feb 2025 15:14:27 -0400
Date: Fri, 14 Feb 2025 15:14:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, peterx@redhat.com,
	mitchell.augustin@canonical.com, clg@redhat.com,
	akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/5] mm: Provide page mask in struct follow_pfnmap_args
Message-ID: <20250214191427.GC3696814@ziepe.ca>
References: <20250205231728.2527186-1-alex.williamson@redhat.com>
 <20250205231728.2527186-5-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205231728.2527186-5-alex.williamson@redhat.com>

On Wed, Feb 05, 2025 at 04:17:20PM -0700, Alex Williamson wrote:
> follow_pfnmap_start() walks the page table for a given address and
> fills out the struct follow_pfnmap_args in pfnmap_args_setup().
> The page mask of the page table level is already provided to this
> latter function for calculating the pfn.  This page mask can also be
> useful for the caller to determine the extent of the contiguous
> mapping.
> 
> For example, vfio-pci now supports huge_fault for pfnmaps and is able
> to insert pud and pmd mappings.  When we DMA map these pfnmaps, ex.
> PCI MMIO BARs, we iterate follow_pfnmap_start() to get each pfn to test
> for a contiguous pfn range.  Providing the mapping page mask allows us
> to skip the extent of the mapping level.  Assuming a 1GB pud level and
> 4KB page size, iterations are reduced by a factor of 256K.  In wall
> clock time, mapping a 32GB PCI BAR is reduced from ~1s to <1ms.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  include/linux/mm.h | 2 ++
>  mm/memory.c        | 1 +
>  2 files changed, 3 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

