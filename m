Return-Path: <linux-kernel+bounces-524599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA049A3E503
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2E2421549
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6604224BD1C;
	Thu, 20 Feb 2025 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MhrFpiv4"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EB724BD10
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079705; cv=none; b=kG8p3QAMQh8mFRihAUrDvEsIMlfwjTjUSy8D0Bz7nhaJ1fUnKfnPuAblM8u6D/stqvHJ+eRN9oQLzfwkl1JXgHjL9A+g8jyzLH782SBu/5fWNxgSlQGiJN9YFClnePJHsCEWE92RF3sSo6hu3NLko5hZmlLFVweP68dlWz0EW1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079705; c=relaxed/simple;
	bh=uZc0Vvw+sYnSQ9lrCmIfjQyqVvDzE0cjPbU8SKuGveM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+j+OUgulvxDFxLD3Kd3xDR3e4Cx+b/SC9L5dTBoKKxKf3KL2gJ7FksiZOaHKtBEhw/qr/Oiw0moS6VnwDUFlkC39EiczymwYicveO52YKzw9Zh/r5rohCTROzFsJyUYLiyrFNlWa0DqeYvmoskL1FN4R9VUOAyHGBfyTYv+/Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MhrFpiv4; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7be6fdeee35so232911785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1740079703; x=1740684503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3bAoXj6icIETl691BNDEUKP9/6VrvAsHwv5WY3HYyfY=;
        b=MhrFpiv4pr7/HuJty453Q3xMlV4UG9SshbIv4TfniVr1dnK8ovik9vQhrs7Gi+TNiR
         9ssqnOltzsRvVuHLCrhWZr2FVAxBOr4THJMHtvyp41gfSNXhD6qjrKhQBKWRP7SlvNrg
         EjzUxDdRJ3CLWdxf+Ezjs/zkS9GZPy+mLrJSK6nOg6GOLFFkplu81UJk6q1syvqFzwLK
         R/WVh3CLDvOkcGzM2Y25fdhyTsDRWscwMtoKuAl3PBZpYFglduN7GcqeXBtRlGn02ueu
         OjazzXiVU9Mz3n0xJnOORg6/OiDnnj4VgC0nphWXeNVPWkRnc68G6MbNclo72gRxkpg7
         kIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740079703; x=1740684503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bAoXj6icIETl691BNDEUKP9/6VrvAsHwv5WY3HYyfY=;
        b=LOMkiD29Yb97kZXjjoyNd9wPpPkoTaBZ9e5QtxERG8EbvH9hpQSf1K0PKzGaP9HKTT
         9D17ll2hUQXJ0IoiTmfEiE75heW7DMDDr97yPDySqCAdBPHFd5w1etq5YMzP6FI96MK0
         7h2foOqjv1dXM6NJZpEnup+x0B7UJjNu+qMtLcD4uF6n0nAoSQxli5t7MivQ/dilyDnT
         fYrdlX3+mfmY9ww0xOuoUruwrHjVdo4hn0LsXIT5S5h2c6Ff0oIXf8DkWr/8ah/j6ngo
         AqXfWd26Kp+MF0PEVNwM0M+MMUKScr8tP+rj0vmo0xs1YUv46Gt3ffQzg+XIgkpo9rdy
         GQPg==
X-Forwarded-Encrypted: i=1; AJvYcCUssAIISoTgNwMDXC1wgGaP04WtCRL4mjQjtTXdYUa6tW/cS4WgjAiMZVxzTvCtDnTgzTVlpiP9C6OtnfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbvkM2wDmSd0qs7U+WS40BxAOcLRHjGgj46a4Y7wrU8Oj7ef3S
	DtltRzEXl+nMwQB1wBRERkD63+If4ZsLPUvvjvIB5FbJXQ62kJNHWHRmjB2nXgU=
X-Gm-Gg: ASbGnctV0QsQZ0WG79YQsv9Ek0mPO7s9UYukLJDp03ceqff1Jnvo5ijzLpVWfDkUY4b
	fvssoA7ALS4YrS3FWzn9q9VjNen0+9dpVn2CBtr/ylOPLzXKvQWc5oVUIw1bvliyv8eqgogRVqv
	h8RBiDVONP+OUaTkCYKpfiz1PQHuVA5aGM/znfUlqqRCUyfMdu9kqN6Oj5htrulPPjtJWP4/dl9
	wA6+iwJynkaKRwlpSr/GO/Uh3wbmOnSjfBA/0ebx07/o8EW3fvLiIzYTuCGoX81+gSHLhA41NpO
	GTqwPKK/LIdKkCDKJFVIbCQOP7c7f235AnqIefK82+jsskF7QJmiZxIDs6dnmQ75iFzAyVJs2w=
	=
X-Google-Smtp-Source: AGHT+IEa1R676oQHuTRGhqpovSkZNvRRmrFks88DAX5Y5EkMm1UGg3rbd89nS/D7LHAg9cvaoAYyWg==
X-Received: by 2002:a05:620a:2b97:b0:7c0:b76a:51de with SMTP id af79cd13be357-7c0cef71bf8mr80109985a.51.1740079701294;
        Thu, 20 Feb 2025 11:28:21 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a62e9865sm426571785a.59.2025.02.20.11.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:28:20 -0800 (PST)
Date: Thu, 20 Feb 2025 14:28:19 -0500
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 08/15] cxl/region: Use the endpoint's SPA range to
 find a region
Message-ID: <Z7eCU3njj64GZFsJ@gourry-fedora-PF4VCD3F>
References: <20250218132356.1809075-1-rrichter@amd.com>
 <20250218132356.1809075-9-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218132356.1809075-9-rrichter@amd.com>

On Tue, Feb 18, 2025 at 02:23:49PM +0100, Robert Richter wrote:
> To find the correct region and root port of an endpoint of a system
> needing address translation, the endpoint's HPA range must be
> translated to each of the parent port address ranges up to the root
> decoder.
> 
> Use the calculated SPA range of an endpoint to find the endpoint's
> region.
>
> Signed-off-by: Robert Richter <rrichter@amd.com>

May be worth noting that cxl_endpoint_initialize() will set
cxled->spa_range regardless of whether HPA=SPA or not, and so it will
always contain the correct value at this point - even if translation
was not required.

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  drivers/cxl/core/region.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6d5ede5b4c43..ffe6038249ed 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3535,7 +3535,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  static int cxl_endpoint_decoder_add(struct cxl_endpoint_decoder *cxled)
>  {
> -	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_root_decoder *cxlrd = cxled->cxlrd;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
> @@ -3547,7 +3546,7 @@ static int cxl_endpoint_decoder_add(struct cxl_endpoint_decoder *cxled)
>  	 * one does the construction and the others add to that.
>  	 */
>  	mutex_lock(&cxlrd->range_lock);
> -	cxlr = cxl_find_region_by_range(cxlrd, hpa);
> +	cxlr = cxl_find_region_by_range(cxlrd, &cxled->spa_range);
>  	if (!cxlr)
>  		cxlr = construct_region(cxlrd, cxled);
>  	mutex_unlock(&cxlrd->range_lock);
> -- 
> 2.39.5
> 

