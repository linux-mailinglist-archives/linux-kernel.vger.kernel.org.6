Return-Path: <linux-kernel+bounces-414085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F1D9D22D4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39DB8B23C69
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8A01C2432;
	Tue, 19 Nov 2024 09:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ublkt8ed"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EBA1C1F00
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009925; cv=none; b=q/Ul5ffytPaWeoitF+o7bktiW9fAsSr8SaPs1oagW1bztRy9yC9kzJ3eSU8gunVYmZzt7HsM47b8WW87Y179ha6tXTR2jZAjHG6mh9zK/CyrG+uSz1t68emmjH08EHXMgUjJ3fHXrqea/nmP1Ojmf2Jf+teOoZhLVaXRNtajCNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009925; c=relaxed/simple;
	bh=8mLQ2rCBH+GAOi6Nk/uqU/Mp5uXAM/2ZRkosO31Nz5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dc/zK7r8lVy0hnl2+cA1IQdO1w1ISTHhcRkahv/Xm/vwHRzgPoXF3diEuD8E73Xt+3oNaJ4U+28ZcJ/M51UuicbeEzxHiJPrrroG+A6MxM7CQwT3caD5ByuOajT2VZR+qmG/tuYGOMLVbylNDIh+L6WOmwEEkyZj8F/sUJUYKO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ublkt8ed; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb388e64b0so50062001fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732009922; x=1732614722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jnf8A/XqBcrdKsiQYU4vdncgVm2DMj0IsCfqAngF824=;
        b=Ublkt8edesJ/WXZ3VtEZuazOwMPFY4EZDPetHXKMW0cbJa1PCTvN5FUR2PnUS1syqh
         UgfZzSNJN3NdrfoQoeUumgeuTXaUhkhyI8i1tp9F0gDMa+Z1xN6r+6Vi0koJKZNKkvuD
         brxn4GxJ7XfX1JzmsWkVgvM0THjoXL5rTQPJle07S8uf2S8vizEb2DTItJWfc50I/pcp
         f15xUBgEnSq18BZGBbvGuaVrWFIFvVWuX8ryuxNXNGuzdejAsHW6h+eLV3WfJN7Z90aS
         mu1xayC1u/6n+vAhNKw3N5UhO+mNFUF8/w9jCBq3Az3kuSdhnxS1AWJPKA2sujbeEDFy
         lwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732009922; x=1732614722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jnf8A/XqBcrdKsiQYU4vdncgVm2DMj0IsCfqAngF824=;
        b=l9uJCITLKKE/2f41iyTrRdXCbIGk2oznNSY5REJ6xDDHFSIZYNlMnpukXOyueYlecE
         ZGQG/Awy16lOftQr/io0CJblbmcAWV8EIH+XGjz6i09rHmbWMqdQupa19mcnHC0K7mEy
         LWDhxhxM0yjl0Wgwi4zHJTxum1Rx7sCigi+PKpGfo0O3Pno5LlRZ9kq9giJ9HlValDHM
         WAXb+7uRlG4nuUDpvVyvYQ92WWKaaXvPOYcdtqqfIcHV3GooDETJ/Q4YRFXt4KBSl/8h
         K0f2jxTIJ63NOAlZlRaK6YafskoU4+dRbS4/1bg8QJMlcQV86LJAvQkB7QFN6ldnHYCd
         +hZw==
X-Forwarded-Encrypted: i=1; AJvYcCWTD5c7+gqlIEx33lgHsyAoR2Fd5rvFgbGLUJ7a3KfDmaMmKRkY74xHLw1ri2n8D6hGPHE3eE++w1bw2Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlKkOdxKSMxGS2rj5t125AkoaavP7ZZulkTGSPf9y7uqpqtAk7
	M0yhlGRQJ6qjk9RyqmAoxVKgpF0L40tn4YnY4P8uDdeYeMWBE3EGRDZQMmDRum0wpcewkE0bf4y
	S
X-Google-Smtp-Source: AGHT+IGaBooF4z57mSfTSSt+M5NqMxgVnmBtpaHdYbGWEwqn6QjzmTszZdYOAtQKpgTJTFo9p6NUTQ==
X-Received: by 2002:a2e:be12:0:b0:2fb:5f9d:c296 with SMTP id 38308e7fff4ca-2ff60610087mr66873961fa.4.1732009920038;
        Tue, 19 Nov 2024 01:52:00 -0800 (PST)
Received: from localhost (109-81-88-120.rct.o2.cz. [109.81.88.120])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfbba90daesm2569211a12.74.2024.11.19.01.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 01:51:59 -0800 (PST)
Date: Tue, 19 Nov 2024 10:51:58 +0100
From: Michal Hocko <mhocko@suse.com>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: core-api/gfp_mask-from-fs-io: indicate that
 vmalloc supports GFP_NOFS/GFP_NOIO
Message-ID: <ZzxfvpvfNz9uzkJC@tiehlicka>
References: <20241119093922.567138-1-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119093922.567138-1-ptikhomirov@virtuozzo.com>

On Tue 19-11-24 17:39:01, Pavel Tikhomirov wrote:
> After the commit 451769ebb7e79 ("mm/vmalloc: alloc GFP_NO{FS,IO} for
> vmalloc") in v5.17 it is now safe to use GFP_NOFS/GFP_NOIO flags
> in [k]vmalloc, let's reflect it in documentation.
> 
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  .../core-api/gfp_mask-from-fs-io.rst          | 20 ++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/core-api/gfp_mask-from-fs-io.rst b/Documentation/core-api/gfp_mask-from-fs-io.rst
> index e7c32a8de126a..858b2fbcb36c7 100644
> --- a/Documentation/core-api/gfp_mask-from-fs-io.rst
> +++ b/Documentation/core-api/gfp_mask-from-fs-io.rst
> @@ -55,14 +55,16 @@ scope.
>  What about __vmalloc(GFP_NOFS)
>  ==============================
>  
> -vmalloc doesn't support GFP_NOFS semantic because there are hardcoded
> -GFP_KERNEL allocations deep inside the allocator which are quite non-trivial
> -to fix up. That means that calling ``vmalloc`` with GFP_NOFS/GFP_NOIO is
> -almost always a bug. The good news is that the NOFS/NOIO semantic can be
> -achieved by the scope API.
> +Since v5.17, and specifically after the commit 451769ebb7e79 ("mm/vmalloc:
> +alloc GFP_NO{FS,IO} for vmalloc"), GFP_NOFS/GFP_NOIO are now supported in
> +``[k]vmalloc`` by implicitly using scope API.
> +
> +In earlier kernels ``vmalloc`` didn't support GFP_NOFS semantic because there
> +were hardcoded GFP_KERNEL allocations deep inside the allocator. That means
> +that calling ``vmalloc`` with GFP_NOFS/GFP_NOIO was almost always a bug.
>  
>  In the ideal world, upper layers should already mark dangerous contexts
> -and so no special care is required and vmalloc should be called without
> -any problems. Sometimes if the context is not really clear or there are
> -layering violations then the recommended way around that is to wrap ``vmalloc``
> -by the scope API with a comment explaining the problem.
> +and so no special care is required and ``vmalloc`` should be called without any
> +problems. Sometimes if the context is not really clear or there are layering
> +violations then the recommended way around that (on pre-v5.17 kernels) is to
> +wrap ``vmalloc`` by the scope API with a comment explaining the problem.
> -- 
> 2.47.0

-- 
Michal Hocko
SUSE Labs

