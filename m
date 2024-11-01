Return-Path: <linux-kernel+bounces-391787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE259B8BB4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5E5281F61
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EC814E2E6;
	Fri,  1 Nov 2024 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fzGwjPt8"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0941E495
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 07:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730444680; cv=none; b=L//WheTKEodpgtdV/RAlQdG77EbnH8eVKHdMl0bwHeL20JZLrHN7Gf54eJML2+5Mc5tQ11RScNnbpIKm6QbLQ9C0VdPh43KlKyhefux39N0dfyJaekdtF9rLgNAiYYEwAtBPy5SxY+AJxHYehuoSVwbwZe2A5uqdKyXZ9t5Jik8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730444680; c=relaxed/simple;
	bh=WTxmHYSz6nkcudl8SVRgDyLY6dW+TDdeIXWrCxrh9qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hzv9LBMOyvD/narUM8aGq/8Hxje8f541KY4nqI/w4pr5VGOEBvOlda9vx0EuUKsVM71vo+hBGhGU9f0kDc/d4WHHLxVXAt2uhrWcHeTt/5ZnEE0l1wBCprfjWV6zLAULVDw8lZXeidq+y+r+mGup2Bc8h3Sii4OzbxC8+mlZIK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fzGwjPt8; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53b34ed38easo1605607e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 00:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730444676; x=1731049476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gNg1oWFL04qMlPYNEjeyCMQDXxCaSeoTziUXUPiPj6I=;
        b=fzGwjPt8kOi4jvQlb0owJe7GIH8tUEcH8LLa2u8WOtS9qLmob7GUbiLF9BiBzDcYaj
         s3wxqjv0zK6No0dfvsufxiq7WgloH0kRT3opT1QWs6ZRWbB7d47HUIpY+C8tcVMbC0cP
         8vFeD4/07lRAcqqCpkElWzgh+5XpuxIec44LFdY/jPfJKgegn0tSHbc+a2ZhNGqz24N0
         /uy2s54Jx1QAKL2woMr0oWIKKngma+rkfgH//uRwEbCbPooo+AzzbgJ1v0u+017oum1b
         xxq1x+jBdjrsSqxDAGVzlyqL2QFweIK6JuqbHedkbw1ajIWNXoPQLEmwiXjVA/VEJthT
         YneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730444676; x=1731049476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNg1oWFL04qMlPYNEjeyCMQDXxCaSeoTziUXUPiPj6I=;
        b=YlHfxew7dCxP7Emcrt+0cuGf8YUmnURoh929UTLDOloS54IwUicuOpU3d7GVZbxNjJ
         VtmNxpJfj5jc8N8ccRHkCBJux5xKBa3r9TBrw9ngvObLDuxyb43n+NTZvLMZmmlMzM04
         mxUT2dRSKpS5g9BQw9uboq2pbsOu4ApiE4DZ4A9mM/ygIF2o21vkMvJAI6VbU0P7zuc0
         aHJ9PcSIgjrx29KFCl9jz84ITS2mrYwWIf1ZHBDnIP3bUmC//i9Rg58QIWQ6eMubuhnC
         Yo3IvOZSDN0BODsWbPaj8pwE7UbFtBWP4HwJA8wM94hJtU/Mj18LtW5UKxE8GzA5oFWa
         Vkew==
X-Forwarded-Encrypted: i=1; AJvYcCW8vhAzUmCi/GWuGVD42m6MYQu77ZZ8hbrRXopQCVznqrFkP7y0Sd0nrYzJtXbMj+c3R6NSCZXX00sJFaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4AxDOmjLn7oD7E2uPMhTbfEbnNbnjLJnAIN7D663Yc/4g3x2T
	XH7WJDxW4agB1UIUIWp3lWSNoiLy7ijobznV1dkc+CQIuyharG7/zNojAxarQ94=
X-Google-Smtp-Source: AGHT+IHYsu3xMEXVylaSXmd5wYDcYwx7AMgGbkJL9CvXxEoNieVW74Qm38Vw/C6UrcN42x8oH5649g==
X-Received: by 2002:a05:6512:3091:b0:539:ea7a:7688 with SMTP id 2adb3069b0e04-53b348b9130mr10496508e87.1.1730444675965;
        Fri, 01 Nov 2024 00:04:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7a9esm4141047f8f.21.2024.11.01.00.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:04:35 -0700 (PDT)
Date: Fri, 1 Nov 2024 10:04:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, rppt@kernel.org,
	mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com,
	da.gomez@samsung.com, yuzhao@google.com, souravpanda@google.com,
	pasha.tatashin@soleen.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] alloc_tag: fix empty codetag module section handling
Message-ID: <bd5e58fa-4458-4680-be2c-e14d43d32572@stanley.mountain>
References: <20241101000017.3856204-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101000017.3856204-1-surenb@google.com>

On Thu, Oct 31, 2024 at 05:00:17PM -0700, Suren Baghdasaryan wrote:
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 1c74942e6dfd..00ab18ea452a 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -437,7 +437,7 @@ static void *reserve_module_tags(struct module *mod, unsigned long size,
>  
>  	/* If no tags return NULL */
                      ^^^^^^^^^^^

>  	if (size < sizeof(struct alloc_tag))
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>  

Thanks for this.  We'd want to update the comment as well.

regards,
dan carpenter


