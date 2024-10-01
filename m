Return-Path: <linux-kernel+bounces-345311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D4798B473
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4B6282870
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BA71BBBD6;
	Tue,  1 Oct 2024 06:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyNjBOHz"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A84F198842
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 06:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727764346; cv=none; b=B4M35yYNf/fbnfp9DOnR4t/LhX/or2P7PRsnmKz9ADJK9pnSDcyjMwoVAMmx7iXBIS/uz3MyEXmUhfrg0fzPI9Kw8Hu9pZx3PrYrVOH38yym1ZhJVnMQzlMpxk7K32zBixn1Mkk07wgZ6t9TTZh7gcPGTIcPvpVPmbEdMbq1gks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727764346; c=relaxed/simple;
	bh=V6TjkPr9+R6KJJiOq70SGV+fxgdPrkENkBp7L85cO6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmQSIl2EU4vPFdX9nz0akO7Z6CPVC0dwsKk8xtWYpqlqqZN3xYdf0PyJMGaG75wBhpSJF76HgEYhAoZh4hqOfT5evfCJgXnwWXcy7nV+SSma8XO/408xkL8ksmDVLnxIKWgzBi6wfO3FWyWFzvxV8aSA3RiU6Dhnz6GuynZKJS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QyNjBOHz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b7eb9e81eso19955715ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727764343; x=1728369143; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+XSZPD5xW7VFeqBF4W+qcKsdoMfcWLE5iqzfZIrlUcc=;
        b=QyNjBOHzk2fs0H3kk2M3vfRNsqtLMMw9bo7AptxvVqqF7O2GHuPE05UAM/kfuhru0j
         9bHtGDYQIki6ix0PkPXKgVgE0tw5Kg9u/CyPYhQQhVX7d7Hw/D+Nhk8p9NmkkKHd6q5c
         ChuVDGvHSWSOn8y4wMaq+JaU140wwtXWyUhLwzebtMN4QIgF2RMe9UqugGyVTu9P5RSQ
         9t1BQXoCSPeq7ayH49tnoopIhiU8Kj8T6kHwegqPQFbv1dgNFBk1QbMxX11E+ma+LomN
         AqGXZOGFDaNczTdYqtTONqLbAXwz36YTDEhCBHsT0hiusihH7vhhX5QrKVJz9bZWQcyW
         lXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727764343; x=1728369143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XSZPD5xW7VFeqBF4W+qcKsdoMfcWLE5iqzfZIrlUcc=;
        b=KX41GOr5L0gMz2Rui/QEs7IBZdIrq1CvY7vduOp7SbtBpWPXZAxP3fFghyISmrejBc
         qC/8iuuBgYZI15ey5VYNkSnQ02l7lZe641Ba4b6YdpVjHkvA0ZlgA8qdhosj/sY/8k0q
         n9uYyZHipyCPYoACROGqM/RxhZF3WtmgIpi1d9m/jStlJAkFSdDMWxE25NkbGl54mFmS
         mtOOcT5AGiUFiT8N+odT0SWr1lO4+dkWUDQJULu58uu5MF3ZRTaNbES6JO9Txsy+gGUS
         GXV4c/To/TiSlybCsdj6fw/uuSJ+6x/2loz/m+QRy5Sw2Cmw/W6vri0fk0aLAk8bXRdX
         DFmA==
X-Forwarded-Encrypted: i=1; AJvYcCWMXSilacZQxqjW4fPLJTdnT4CX/TAlsWjuU5Bvd8iSI01+e/G5R15bA117awUQhRUWMQG74/m/ZUf2YkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQxlU/OOJyOyvgYHEMjAl8B9VBWxw9gKEygJ3z8tDu21uDfdMO
	33EkZgARkkgNyKAx8CbsgDsLOafiwJffFd0XEvzP/iWKUzMXMCI2YtnJvUzVorE=
X-Google-Smtp-Source: AGHT+IGhD8CqwwDqtINDFXy8AwF4nvh1FlgzTbLa13kA3Pv2DSQX6ig9iYUdAdW8f5pr5cwUEyiVcA==
X-Received: by 2002:a17:902:e5c6:b0:20b:9379:f1f7 with SMTP id d9443c01a7336-20b9379f32fmr59308725ad.40.1727764342760;
        Mon, 30 Sep 2024 23:32:22 -0700 (PDT)
Received: from localhost ([122.172.83.237])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e14defsm63326945ad.131.2024.09.30.23.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:32:22 -0700 (PDT)
Date: Tue, 1 Oct 2024 12:02:20 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Miquel =?utf-8?B?U2FiYXTDqSBTb2zDoA==?= <mikisabate@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Avoid a bad reference count on CPU node
Message-ID: <20241001063220.dj53f3dbdiwnpkrh@vireshk-i7>
References: <20240917134246.584026-1-mikisabate@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240917134246.584026-1-mikisabate@gmail.com>

On 17-09-24, 15:42, Miquel Sabaté Solà wrote:
> In the parse_perf_domain function, if the call to
> of_parse_phandle_with_args returns an error, then the reference to the
> CPU device node that was acquired at the start of the function would not
> be properly decremented.
> 
> Address this by declaring the variable with the __free(device_node)
> cleanup attribute.
> 
> Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>
> ---
>  include/linux/cpufreq.h | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index d4d2f4d1d7cb..aabec598f79a 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -1113,10 +1113,9 @@ static inline int parse_perf_domain(int cpu, const char *list_name,
>  				    const char *cell_name,
>  				    struct of_phandle_args *args)
>  {
> -	struct device_node *cpu_np;
>  	int ret;
>  
> -	cpu_np = of_cpu_device_node_get(cpu);
> +	struct device_node *cpu_np __free(device_node) = of_cpu_device_node_get(cpu);
>  	if (!cpu_np)
>  		return -ENODEV;
>  
> @@ -1124,9 +1123,6 @@ static inline int parse_perf_domain(int cpu, const char *list_name,
>  					 args);
>  	if (ret < 0)
>  		return ret;
> -
> -	of_node_put(cpu_np);
> -
>  	return 0;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

