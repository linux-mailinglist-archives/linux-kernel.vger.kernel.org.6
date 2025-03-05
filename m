Return-Path: <linux-kernel+bounces-546260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D73B1A4F87F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCBD188BF55
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F581F03D2;
	Wed,  5 Mar 2025 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GN+0IPhy"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6C71547E2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162468; cv=none; b=fqTUEhaueAnDk4wkQ9p82zM0329ZPGPxi+um9Mv8OfaZ97EgFSyVaPiQoMITxK3MTFs2/mL4Wvft7GdX8ZKmaLt6uGED3UMn4LwFI60qh12trcjeOgCVLTCwxtsGLvqarBasBKY3bZGmzmm2U+2KWVwjfmCdzk2QwBs4DrWC2RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162468; c=relaxed/simple;
	bh=r9sQfh9oYVU0EesNgO5DywzyRvKeYQZr5teUq+yJV48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cb4c0IIqCKsLeIJUSy0Gc+E9v2I5Seurxz2c90CDUemf+Weymv8ufQ+yuXE76CoeHOEMRdFe4b/JfiKJux4r2VOXIZPBk9+W5yPg5FwS7yEYHbiXnUuT1vTTRTp8aRInq/fVz7ZqhEAXikIHL6GloInigQN8VaFlTJcBsx8+pRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GN+0IPhy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223378e2b0dso94684695ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741162466; x=1741767266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W1YteWVfDGnb5EcDmFZKeCof+DYJldjdx+9QoVr6L44=;
        b=GN+0IPhyhUJyeA2XEdNDQZUT2VzRv13WLrOCQZVhsWwqtQSjvTOcikkVnw+AR5Q3hR
         CGXmJJbq368ok59MmAZE0m6xROldaC5nMxj/JhVDf8sNqdBpnk9E/TJjAA4ROqlt2sTZ
         uY/6GVLcxnx5dURIV/C3VjXm+EWdwQcp7RLpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162466; x=1741767266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1YteWVfDGnb5EcDmFZKeCof+DYJldjdx+9QoVr6L44=;
        b=M55/fkxYEd3eaxWOcFzuOPGj6tNJExhEY9Mxfwd7TIGdwrpkWL3qut5biNpyXd+mUx
         zXlqZzshXUYzHKsY4xuAk0vyCFotR3P8n306IGgY4CCGigvMNXh5FDCfxobHgxriVdU8
         kHRrTUc8wCmW583Da61ZrQOw0LBcP2OYtWmL6P+cp6rSK9LbJNqXJf8u+V8s9O53gV+z
         P5Pu2e+plw4FqddOUPCxbMba9MHmdN9M8lZj3B1KHaZTrLYQAF5rcjRoKgBFX7APB0eL
         d4A0pTtN6gy+Gowb07/pxvfvWIpv45jmrC6dJOQW97LpZWiyUASiePnog3++ioixTHOY
         vYxA==
X-Forwarded-Encrypted: i=1; AJvYcCVg/JV48YTsfXE7AwITfaGAgrQUyeH3CUcbfPHjE+q1bwmaXoUwL9Axa/owBDO0+cARsQ429b/XSfvmavk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE6I4fdP84Us7fLBuoJtGZsAVwKitDso4ii/HXViCvdDyVf+sh
	lURuXeqMqPYsMNq0oF1Uhfb0tu42iSZ0ExYb1sZ1HyR3uNKVn9LxiEzwMdnbiQ==
X-Gm-Gg: ASbGnctxN2lIkxnMIbBOgPQn3oSfhHRMr5TJFbVKmkccuaRWLb4m6NSR+BycakNOts5
	qS3eUjHCNlXaYehi3dhnGftxatbBlpotdmwZI4C+ERtdIjkIQbax0Gpi85Cj5tVG0dQQSZtkio7
	lfr3ArPYrDO8/QZh8TTWfNizOXFDMYgRKckQ3ibjLegTjMLr0rjcsrqgnXfaZ86u64kD54T0vhl
	krTWcFW+ckKxbEuvKRGC+K9J6AOtD/Ketnr+ZTzZW607oI0Dm7Ffeo/00SUDGMpGpaZbl1JZfhB
	LtZLlABDrg2W2k/YyZkcVR7X6e0uLwUkygAANMhBUnFlaA8=
X-Google-Smtp-Source: AGHT+IFPqdJf3tgOUF39b6Y/GMUWbTERct7zxR8Sli2ModFrDTS1MHPvjGWLdStMrDKmxSOiRHpP0w==
X-Received: by 2002:a17:903:2282:b0:21f:55e:ed71 with SMTP id d9443c01a7336-223f1cb21ecmr49603485ad.5.1741162466568;
        Wed, 05 Mar 2025 00:14:26 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:5a4:b795:7bd9:7ab7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504dc3b7sm108225945ad.173.2025.03.05.00.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 00:14:26 -0800 (PST)
Date: Wed, 5 Mar 2025 17:14:21 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 5/5] mm: zpool: Remove
 zpool_malloc_support_movable()
Message-ID: <dupnxm2f2pr7znuwyrjf54v3zorkcuhuleabp4svgjtiglfkwo@zgsnty5wfjlg>
References: <20250305061134.4105762-1-yosry.ahmed@linux.dev>
 <20250305061134.4105762-6-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305061134.4105762-6-yosry.ahmed@linux.dev>

On (25/03/05 06:11), Yosry Ahmed wrote:
> zpool_malloc_support_movable() always returns true for zsmalloc, the
> only remaining zpool driver. Remove it and set the gfp flags in
> zswap_compress() accordingly. Opportunistically use GFP_NOWAIT instead
> of __GFP_NOWARN | __GFP_KSWAPD_RECLAIM for conciseness as they are
> equivalent.
> 
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

