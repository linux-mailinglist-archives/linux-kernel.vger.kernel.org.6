Return-Path: <linux-kernel+bounces-245112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DAB92AE7B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ADC81F22C1B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E670543AD5;
	Tue,  9 Jul 2024 03:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKHrPRnj"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9379DC5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 03:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720494887; cv=none; b=DTUA9vK+FR22EUj/r8BS0uZYsiqXRB6NPZiI9nFaE742KuXe9jOwx2oUhUoKmwCG9Up5Pl0FhmBjFAbpKa7ZT3kd72OfhIM3Mxx5uGlkDiJj2fWNL0+2WfU6vtjFOHBFtLWP5gWqLxWVtNqobxNXjmuv6oh806DaWQez/FDSgDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720494887; c=relaxed/simple;
	bh=dzRlwYxsrGJ4KIqc7+Icq4MRTAAHtMVVE8IegY0vCAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGgXxz+TqS/TuieqHg8MKz4TbjHdKM+k8Yl74CqME5V6FjGYl3zauLqxWLQS7NDZAv1JORQhF3TB5hTph0wmNMkp+HXCe/bGFhw5Iee1p/rxjNvbTJcwzRluMsFmVPpJUeTBGZfa+jJfrLMoBR+8iBAPzShRMyO6Q5P7syb8JjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SKHrPRnj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c1a4192d55so2659682a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 20:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720494885; x=1721099685; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pvPxOKXTY/4mtLUCkxWUWZxN49J8zpBnSU1X8IK8Sug=;
        b=SKHrPRnjc8m/Vtd9qbTbw1DgzYVKsxjHRY7FwlfEYPR8QMh2YFcggmsdx5aFkIRRCA
         IlLYAaSHEiUYm1vubQaslDgG338fk0y4X30k7A6+GyveBF+SuUis5lP+09AdMNNKnDYh
         z2seNXIHMKhrbnDDhUqgYPPpSLyBvfupzQu/q0ryr7XR43DD2MmswE7gK8ZmDhhusUJz
         TRZCjdPAjAwzTI8mTuhpGTNvK/hHylsGqeX+qxglUYbDf3v/QgDztM0G7As5UH/D29ux
         Frtq+heSH5c4dmLRVhCDP3mTV6nZQqOo5t5cZ9LB4yhd7BFe0z0tlPXVVVoIqvrszg7k
         mLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720494885; x=1721099685;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvPxOKXTY/4mtLUCkxWUWZxN49J8zpBnSU1X8IK8Sug=;
        b=ZB5HR42zzt/At8w9hEHjDCqUeaCLOb2etcH9g9j/b8s8vU3GO2e8VzN4I+2shDNN0G
         4FslGpAXGClFoKxq13ht3vYM0jQgeeYky3MnSx6f7YMXsq5gnGBPTLL8HKuFYBBpDlLX
         9KQ/XT6HPSbPUg4pfETSSmOZ1l7blRHSAf582I2TTOmqiHMlX8RnOyyOkdtTzjT8bLqK
         skaFy39mdF8eirz/HYfPo4sfHQWlN7QwbsJvgLqkGYVHDDQJOp20/lQkgtrwZUxIlwda
         i/56qQOx5KRdZ2n2tHoN7bqc7kijyT1OT549Q02Ur3GZkzySUktuH1uMhsm0+Yy3iPxU
         Ct3A==
X-Forwarded-Encrypted: i=1; AJvYcCUdCGEPlgVCzxnfv0nFLAjN/+ANdUldtk7l+rhvlSV9fNQ928QKrFAkF3V8Fn2KdHtnjnRKS0SlFdg8/5AHjKHOI3l9bLHukBC/5bq7
X-Gm-Message-State: AOJu0YxhZEkb7oMHtsXGpGGGyw4ZJkSyhjTexVGqsjOrQZrPFdN8h2el
	2CT6l8lfWb1tC6EbPO6Y/Gru1e+S8UCYWKFFVKqn3+1cedesnGTdLt6Ei/gX069Q0q7qViyp11A
	0
X-Google-Smtp-Source: AGHT+IEOBq8PuD4oFMJkLh1pFoBgqljC1pxKAEneoVV1FfRnIFMZiqDzLh38CGn0thkn3m/UL8JA9Q==
X-Received: by 2002:a17:90a:6509:b0:2c9:8020:1b51 with SMTP id 98e67ed59e1d1-2ca35be21d9mr1196347a91.3.1720494885035;
        Mon, 08 Jul 2024 20:14:45 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa66582sm8899587a91.37.2024.07.08.20.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 20:14:44 -0700 (PDT)
Date: Tue, 9 Jul 2024 08:44:39 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
	"'Rafael J . Wysocki'" <rafael@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: sti: fix build warning
Message-ID: <20240709031439.llqdyaoxldsevuhc@vireshk-i7>
References: <20240708171434.111623-1-rgallaispou@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708171434.111623-1-rgallaispou@gmail.com>

On 08-07-24, 19:14, Raphael Gallais-Pou wrote:
> Building this driver yields the following:
> 
> .../drivers/cpufreq/sti-cpufreq.c:215:50: warning: ‘%d’ directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
>   215 |         snprintf(name, MAX_PCODE_NAME_LEN, pcode%d, pcode);
>       |                                                  ^~
> .../drivers/cpufreq/sti-cpufreq.c:215:44: note: directive argument in the range [0, 2147483647]
>   215 |         snprintf(name, MAX_PCODE_NAME_LEN, pcode%d, pcode);
>       |                                            ^~~~~~~~~
> .../drivers/cpufreq/sti-cpufreq.c:215:9: note: ‘snprintf’ output between 7 and 16 bytes into a destination of size 7
>   215 |         snprintf(name, MAX_PCODE_NAME_LEN, pcode%d, pcode);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix the buffer size to avoid the warning at build time.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  drivers/cpufreq/sti-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh

