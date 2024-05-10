Return-Path: <linux-kernel+bounces-175436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76538C1FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 10:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0CA1F225B9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452E6160793;
	Fri, 10 May 2024 08:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DN6ouloA"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92C515FCF6
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715329738; cv=none; b=lQKqp6Bb0DXIqNHL9HH1CfeO+rGmSqder9dJMBJi5yQ6Zl4Kfd871QQCOvdznXZLFIt8NPOSseDkqcnNGWICb7dOxrtrbWM3p0EDRBx1gCJ5pcZEwcLXqeuOHR8r5OQfDBaDCqJIzvc5Q0U0YMg5MHqJMrv2SItsud//HT7viEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715329738; c=relaxed/simple;
	bh=Z6vhoN+tJspxH8YJD1gxWYbMt8ljwE4s4VONtOpcAbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBkHxwRHywoZWkZBe9IQgaxilUi0nvNHO4x5+FRpdSVLlQyrlsxwBDiJppnSyaagmCVgDN3Z8tvpyUHn7FXYDoQbBoXgCSIZjbIViuxNoBbaGfL9q8O0ROFOFMnUCEsmHm1uwlrBi4zS7KeRLI3sIaRMDyp7KHvx5YhlSPubW6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DN6ouloA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f4e59191a1so166856b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 01:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715329735; x=1715934535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=doNo3paHA1BbeFdrLe1rWXejPP2AsjlFyEeEAdjWIks=;
        b=DN6ouloArvXITCc3BsGrQctIVvHkAI2AaiWcwqxd+E9EPTJtNisOjztACjtrA+akiG
         w6IposmFKZKZAmEYMo61RHWbnrjQVkC6pq9Qme/ZrqSuQaOrM5npG6RzIsLneXzv9f67
         Rq7EI0oAu//0TgmjT5Ilc4qBJaqWkmF1FNJ0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715329735; x=1715934535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doNo3paHA1BbeFdrLe1rWXejPP2AsjlFyEeEAdjWIks=;
        b=uunXvM5rMrxy06mnr+eHIIxs+A6LdwAUEaPeeJ3ClA3FWE36wyJtQ7bi7ohZ2S4bW3
         smIOJ/PUBMdWR60H4xgxIs8iXX54ctbMT5awKppsV1+M8zFmNlX1aeTxomRkoBJoUTi8
         kRZaVThrgzpGWoyyDs8Vsb/fMcvLSPPk++NehPZEDAOBgYHsV5V2xu5mcqFdDIpX8ygA
         W/M+E8idF9vxhdbR2OR4ei5zZvIlmAigyoSKWbefkZw2CVp6GXj4NtD9NjxN8UN2XVv3
         BCQC6X28dxbP1PFDgm7liZY41Z95gvZRSSNaJJpKBu6uNplp6nh5L84cJFA9ZeExYkgG
         GZdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+kyZt9+Bc3v3KfncdSzKqce2Z9YMrV9UotYKpmj6gY44aXtGZQU4ofBTl0BGeSsyFLQ7RQjUumLt2pCF4FkNBjWuo2+WFUFmryEtL
X-Gm-Message-State: AOJu0YxFKiPR7Ku8Z6KNEl4/rLIFWJSN4k0bbVZWZQgY7fITiWcE83av
	Zpm5lfxzvNXqtl8aLBiZ35NqH2YsupYZ3eMTmXAorGMDM1xheFjyD9l8T46GyeDHQimPylMGJzc
	=
X-Google-Smtp-Source: AGHT+IH64iN8OUks6VlJC0zq7fC1ud3tyaN5WYPieBYiGydCH/XE4nQGKjSlY3rotXNIXuWTAEtq3Q==
X-Received: by 2002:a05:6a00:3d54:b0:6f4:4850:428b with SMTP id d2e1a72fcca58-6f4e0355dacmr2053875b3a.22.1715329735089;
        Fri, 10 May 2024 01:28:55 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:de58:3aa6:b644:b8e9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2f9c5sm2448283b3a.193.2024.05.10.01.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 01:28:54 -0700 (PDT)
Date: Fri, 10 May 2024 17:28:50 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCHv3 00/19] zram: convert to custom compression API and
 allow algorithms tuning
Message-ID: <20240510082850.GC950946@google.com>
References: <20240508074223.652784-1-senozhatsky@chromium.org>
 <ZjzFB2CzCh1NKlfw@infradead.org>
 <20240510051509.GI8623@google.com>
 <Zj3PXKcpqUPuFJRu@gondor.apana.org.au>
 <20240510080827.GB950946@google.com>
 <Zj3W7OK9kDpneKXR@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj3W7OK9kDpneKXR@gondor.apana.org.au>

On (24/05/10 16:12), Herbert Xu wrote:
> On Fri, May 10, 2024 at 05:08:27PM +0900, Sergey Senozhatsky wrote:
> >
> > For some algorithms params needs to be set before ctx is created.
> > For example zstd, crypto/zstd calls zstd_get_params(ZSTD_DEF_LEVEL, 0)
> > to estimate workspace size, which misses the opportunity to configure
> > it an way zram/zswap can benefit from, because those work with PAGE_SIZE
> > source buffer.  So for zram zstd_get_params(ZSTD_DEF_LEVEL, PAGE_SIZE)
> > is much better (it saves 1.2MB per ctx, which is per-CPU in zram).  Not
> > to mention that zstd_get_params(param->level, 0) is what we need at the
> > end.
> 
> For these algorithms where the overhead of allocating a default
> set of parameters and then changing them on a setparam call is
> too high, we could stipulate that the tfm can only be used after
> a setparam call (just as we require a setkey before cipher ops).

OK.  I guess for drivers' params support (dictionaries handling etc.)
we take take some code from this series.  You mentioned acomp, does this
mean setparam is for async compression only?

