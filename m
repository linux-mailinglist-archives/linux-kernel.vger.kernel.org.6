Return-Path: <linux-kernel+bounces-345263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D387B98B3BD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B9E2828A8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99E51BBBC6;
	Tue,  1 Oct 2024 05:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0bH1mhA"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8053818E02D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 05:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727761151; cv=none; b=CFW7j0JUUW2B3XHpeR0fvAvGJZNeisCTHdRIyv4StMSTl0hl+e3RN3JHkFHo98Y78onng5FVKkqbwZZU9Wrhp64hkECZqaOk9nGGkzeDJgBm3meP5jZQPmQO4GL/iIZqS5ZLVqdCNm+GBLyzi9hsEZ3gwnpPcIJSl1fseN9A9Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727761151; c=relaxed/simple;
	bh=PSWndesvJ7yJyGk/yJtHyhnoG+WNuz5qX9vmAMwK3B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcdLp7w4In74YNx18o5g3dpiyyqKs1QoJv15QRu08vAGVX9ie/Cyiocnzh74An/yqa9PY+oFGwcH3Fd+6TZj80ZghcsKDFljsNrM6UgoshtsOAzI4+ckJS7xKLB2nP8SRBh6poC+InVpNu9GaNHEjEDUYsCSPemwTmPr9wGWmiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d0bH1mhA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b833f9b35so16376795ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727761149; x=1728365949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xKD6JCL1iwudh6MLQ1Gdb0k45/waP7oTn9UitGRpXvQ=;
        b=d0bH1mhAv5LTa/Tqe/DsYcQJVkoQ8ekrE8iHn6Vsq9rwEtfRWpxOpicPoOyWBF062S
         LfBqPBm7XC0gC8OOxMuGTuhVO6IXPADbQCdtK91BzIJtJiJV+IaczRINNY3zwBZmgWta
         dmc5UZGp0vy7LCLXUolpgJtOvJYac4ik2u8HX79umdlZTknJl/iwE6UVnezNYKBgLhjK
         5Og7B6jx4UkTSMzlmv5NxOCXNjKNSthhjgDkr7+XB/okHopzRD85ZSUcbfAXZLlDyoRU
         FdQmFEzMceWu3tUjvOJ8fLYvj12QQXaPULfAcwiG7u8yLryBK8F5d88WCqmHQGBza9zX
         e1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727761149; x=1728365949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKD6JCL1iwudh6MLQ1Gdb0k45/waP7oTn9UitGRpXvQ=;
        b=qO+FyfwdpUaML3GVqtkuXLUlq87Z33eL6QtQ4c9stA1+NpaAPv+RKXWwWGHt/mKP69
         0Pv2EWRtSnVjSbyMFKiGcf3HQIfvFR6mBT+VR+QLphlwVaJR5Un7yT5uBB5vOLGxNJ+S
         FDXxK8ZfTrb1rVHQTx1I+xObmpHnrPdkg0uvszvYMET3co5gUrOH4cJUK0fN+2cyzmz7
         zQ3jD7Fyfqa38N7NFEw2TR2xjeoOoyE2pawKjKoKjWoLhkV49XEVLmxlHlNU1L4SegOl
         EyVCNrf6lKuoXgfPwSctLSU00VZMvIWBEdJFXwNK+lmfZlr608xZDxbgPa3HHBRUpSr5
         55Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXXR9xKbhQmqYoc329dMNJNoQoBdFL+tTy7cH2vlI//CX50gkdXe/gN0kWMTf3WrxUz9JDkGz+nfd+L1aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU0LxpPghXcs/oqSQgIAOpYunsea//s7uchgrEFPoxXzNhWyXX
	0TN6M9rR4H/cqkmxN/pvrYnGqE5qfvUB5+X+OHrU24cyRtvMZvVuoM8IawyCpmw=
X-Google-Smtp-Source: AGHT+IGuQTnEiNq6WG05WnssIERz/H9PyuSRBd8Z8h9yhGxjZnJ0UnrgjRzAUznsvXKsr/PxKZBNzw==
X-Received: by 2002:a17:903:904:b0:20b:9088:6545 with SMTP id d9443c01a7336-20b908868f3mr75454105ad.46.1727761148784;
        Mon, 30 Sep 2024 22:39:08 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d61d5esm62709075ad.27.2024.09.30.22.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 22:39:08 -0700 (PDT)
Date: Tue, 1 Oct 2024 11:09:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Riyan Dhiman <riyandhiman14@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: mediatek: Fix resource leaks on
 mtk_cpu_create_freq_table() failure
Message-ID: <20241001053906.mkhld5ufrmpdhfud@vireshk-i7>
References: <20240907163630.55704-1-riyandhiman14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240907163630.55704-1-riyandhiman14@gmail.com>

On 07-09-24, 22:06, Riyan Dhiman wrote:
> If mtk_cpu_create_freq_table() fails then there is a potential resource leak because 
> memory region is not released and IO memory is not unmapped. 
> Added error handling to ensure proper cleanup of all resources on failure, preventing potential leaks.
> 
> Fixes: d776790a5536 (cpufreq: mediatek-hw: Fix double devm_remap in hotplug case)
> 
> Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
> ---
> It is more of a extension of the above commit as this error handling was missing in that commit.
> 
> v2: Fix commit message.
> v1: Added error handling.
> 
>  drivers/cpufreq/mediatek-cpufreq-hw.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
> index 8925e096d5b9..3b1303f350ec 100644
> --- a/drivers/cpufreq/mediatek-cpufreq-hw.c
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -207,13 +207,15 @@ static int mtk_cpu_resources_init(struct platform_device *pdev,
>  	ret = mtk_cpu_create_freq_table(pdev, data);
>  	if (ret) {
>  		dev_info(dev, "Domain-%d failed to create freq table\n", index);
> -		return ret;
> +		goto unmap_region;
>  	}
>  
>  	policy->freq_table = data->table;
>  	policy->driver_data = data;
>  
>  	return 0;
> +unmap_region:
> +	iounmap(base);

Since this driver already uses devm_* APIs, what about using them
instead ?

-- 
viresh

