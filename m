Return-Path: <linux-kernel+bounces-242632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A2F928AA9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E09C1F27449
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF341581E3;
	Fri,  5 Jul 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZO90tDo"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E05B146A69
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720189518; cv=none; b=lUnBFqW8EGHpU3IATFiKx7D/Zc94/c2kP4rPYEfudf4tfwMMnqX9E8CJ88qjvv9YCgy7hPD6BTBcDfonarbd+ZpXB0onjS1mrAjOTtMZzO/UekOpQRWV03ZDjNp855xfWb3KUYZROHkdT1NMfusAoU69hFoqpZnd4nGxixnYzyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720189518; c=relaxed/simple;
	bh=C4tqAmHM8v4mD3hhTZJZUBWCm1/4vg81FUX8llaVkDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UW0PPRSzrwOafeQhLhPxM+aIEK1uEzm6qQvyZCiTB9JWEo5pCCC6bohwinhlw4fUznIxalCHYzFUsVIV90dMT3RYwtQI2VeDmGbxlsyzMD/f30c8/n5DC4vCEn6/3FQo8JMMOdeyQ3iaGj0ZCBBCjgDcvsVft06HjVKEXG62W7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LZO90tDo; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-25e3bc751daso618015fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 07:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720189516; x=1720794316; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nXc3UlGjeR76mLpFRQ7ArGxbQkbw5AvjaQ5WOZ1mVMs=;
        b=LZO90tDoQpkYiCjah/eBNdundKCGXg/5lM3mmBLTq4oTGMPIF70T2xosVQZcSysImg
         Mxz1EftZEwGcHhi+qDJ2gRd0DM4J0MsmSvIpCv7KcLFo9CruSP4hY2f/3OFzI5ez2n+y
         JNKnqK04I8MPcopXkYx/cXXzUxwLTQv38PtOsXprp7hJoA9utoQtguG8RonQAO5p56jG
         Ld6c7myuTMgDM8AGG6y3F2DR9PbjubAM1HO3uPta6q8zeEUG3mfBOODy2ulvt9QoJEEs
         nXudxSOeWhIpEevDNIb4/wUgQ2LIkwexmQmvB0L08OBeZ9khb+RQJj9CuHHdDE5iOFE0
         0y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720189516; x=1720794316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXc3UlGjeR76mLpFRQ7ArGxbQkbw5AvjaQ5WOZ1mVMs=;
        b=aRIrIMQ530zFMX3rFViv+U0mf2a17CbISgZF0QV0iVYB9xF6e48vNnRAuPHFSrfwKN
         FyeP8QOcmDcQ4P06J2LCsFiLSzQhS8ZgeYSfWvt94bR9TVyoyBJBW1DFRgJLDhngwJcn
         WJL1+PouqQ+MsZ9Z+TZGVy0kiv9lhfms7HBL2iPa11chjSnTXnRPCy5R3E0jNjR4Ns0+
         jtWjZbmhNtYwZUIsQXdIrzoMIdCq5Bd/+fMxaoS3THk+hHL6oHClrKDujte56Trswuaw
         A3Idms1diKEifSkz3M+Pr1dcKCtSM8VQ8udBwmXgiSoLqfN609JLO9Unb5UWEICtyhOr
         HPRg==
X-Forwarded-Encrypted: i=1; AJvYcCXdn7ZquKUCYmiPWl5TKBAyzuuQ2yhZrwKbrbhJ3675skAtZRvwf5BbLSEH7HrVhk1UDSfG0jgCvszT2HRmSHe06UuAU6HGllQIA5Fd
X-Gm-Message-State: AOJu0YwIbO5utN4cyGgmepyFIXVJ8hNh59YzZ9AC1ZomvX0rlZRg5Uku
	b+hCMMppvgXFnAP2G/cGBTInmz/CFM27ihIsr/s03Zi1JruEOBPkhM623ToUV5C7tLPDCU8hsiA
	m
X-Google-Smtp-Source: AGHT+IHPlj4ATuT25r3JDKsOmpgXkUlB9bwlGVA8tDvmU40oqlMbYDXNcAQKERtcZUZ6QmueddNTAQ==
X-Received: by 2002:a05:6870:8182:b0:25e:2208:6c8a with SMTP id 586e51a60fabf-25e2b8cf279mr4072132fac.4.1720189516448;
        Fri, 05 Jul 2024 07:25:16 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:45d:774f:47f7:bb6a])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e4be5ae0fsm209740fac.29.2024.07.05.07.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 07:25:15 -0700 (PDT)
Date: Fri, 5 Jul 2024 16:25:14 +0200
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?=C1gatha?= Isabelle Chris Moreira Guedes <code@agatha.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	patch-reply@agatha.dev
Subject: Re: [PATCH v2] init: staging: Fix missing warning/taint on builtin
 code
Message-ID: <19a4a521-2e68-402d-83d0-618c299f2c10@suswa.mountain>
References: <n5plxnkubcnbuyv7l24i4cwsauh4odwk6g5yiys6oiiwj3i34r@izcjggvv2om2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <n5plxnkubcnbuyv7l24i4cwsauh4odwk6g5yiys6oiiwj3i34r@izcjggvv2om2>

On Thu, Jul 04, 2024 at 09:20:49PM -0300, Ágatha Isabelle Chris Moreira Guedes wrote:
> +#ifdef CONFIG_STAGING
> +/**
> + * staging_init_taint() - We need to taint the kernel whenever staging code
> + * is initialized (from built-in drivers) or loaded (as modules) and issue
> + * a warning the first time it happens.
> + */
> +void staging_taint(const char *code_id, bool module)
> +{
> +	char *code_type = module ? "module" : "builtin driver";
> +
> +	pr_warn("%s %s: The kernel contains code from staging directory"
> +		", the quality is unknown, you have been warned.\n",

I wasn't going to say anything but since you're resending anyway,
please, don't break the line like this so it starts with a comma.  The
comma can go on the line before.  But if it couldn't then we would move
the whole word "directory," to the next line.

regards,
dan carpenter


