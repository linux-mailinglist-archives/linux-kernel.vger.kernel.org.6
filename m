Return-Path: <linux-kernel+bounces-408909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BCF9C84F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E62DAB21649
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BE71F76AD;
	Thu, 14 Nov 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbzdve8/"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1838C1F757C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731573693; cv=none; b=VvrjGSTlUkPdoxae4/6V4r4ckcwKYxEOa1MlZU4SsJiO8z6HbSg5al5Wyqhz2j9pAGQGluq+dy7Jyi2SYhvmqD3FVfs/Z/mtWDqx9MiNzlBOVFmZI/bGqIeKR7/gndWbbOdK1SheuwiVSaCkWCVBqrGBSAhZJODmCjrOio8aUBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731573693; c=relaxed/simple;
	bh=UdXM30Eaq47W0+zS0vBYvZ66OxLpHawzDlCEIhx6fk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMfabKMJRJNzZ17BeQF6+cZmJHYUxw72R7tQOpqmFJsQno21TKzyl6BQegVsUjyeRy4zf9qAjP49xJX8cG/FMhS3aj/FYbYODgkl2HkUxWSFrde1i+Xo8NgdsyNMmYlcal4s3jHup6tCNJQ56YjyGIEJWR7qCpjBFqJA4GcXWqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hbzdve8/; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb5740a03bso3077951fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 00:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731573690; x=1732178490; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0hbYbXTm77yMushKGHFUWiNBHnfNqWh3DD0ZOtWocto=;
        b=hbzdve8/cOLfCW4gKtyen/pbGP8j/umachrb/ndFjCE7Jc34ZJhPhwoX94IpJw0BS7
         1sMuUd7V5k4uWs9RE7bEzwJS6fln3GkcdZ7UuzHPJ7wCYzDStH33LBvqqEEu8GwpNbOL
         vSY8/mUt7krgoVkQRdXWkE3SXL7NJGC9B8jGBlzemRZXcFn/XJgwBer6deuP34ip17oN
         uwxXc0p5chcabgpyV64Zufeo1ABvTEF/gHs1qYwuTY7ZIshTqfRjV9dMcOP5Ho+XlXNy
         iS6ebLd+d/48NFzzyxax4VdX+Bs7fYvidpENOk5ARr+Wpaboyji7bKpNTwsQqocwIurM
         XeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731573690; x=1732178490;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hbYbXTm77yMushKGHFUWiNBHnfNqWh3DD0ZOtWocto=;
        b=CencYzF17QLkIyvy9M84Q0z09zXJLqsyvyz3z3f3qCxQgvOEoH328UpLWbbLtE1K+d
         Nfjt6AMyFUlqnmadlLcJiXPHjKsXWfKodK450ubTMxfI/xY0nl1bokHQTMNKsw2nJASV
         0v4Mx37kBVperGHHTTdvJNh/8PcENn+7MOs3zrQdJ6jVMlG+9GXXTGabPflAswKHYIDt
         oHDt4XrZKfIvRktpkzfRrq0ni7CgFs9UsO0Q0dgqktHbpZLW9aLaHzlGpYTHjnHWHIph
         ex+SITDeA1fiujRjRvCB6Z5nAFqJstw7gY5UErTfsCe9WUUsQG3k+mfbA+fr2xVc7Dty
         n+pA==
X-Forwarded-Encrypted: i=1; AJvYcCU0dAOES2FiBFfYO7UaCdkGLf5L6+ScTqXVLf/mwdQxyNpugdswnpAzn4iobBsi1Kkw2RUdCBFWa8anMhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEH7+M0lQADT9inHvNUDHmadr8ufPzsjCegxs9XkgiaMV+CBbu
	isq7+Vhvv2/U/bq1us3FmjVMdqJheOcQD5OuguEzD3Vqhr7Q5AFqlHTxxTKflb8=
X-Google-Smtp-Source: AGHT+IEIEh/chz16dTEQOl7Jx49f/jl7YA5ju0+fFElhPUVjfo2OXSdETIz0u/SWTsOZWJ4tr4IEZg==
X-Received: by 2002:a2e:be1b:0:b0:2fb:6465:3183 with SMTP id 38308e7fff4ca-2ff426970bdmr53783081fa.3.1731573689125;
        Thu, 14 Nov 2024 00:41:29 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da280018sm15655525e9.26.2024.11.14.00.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 00:41:28 -0800 (PST)
Date: Thu, 14 Nov 2024 11:41:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: stuyoder@gmail.com, laurentiu.tudor@nxp.com, nathan@kernel.org,
	ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] bus: fsl-mc:  Fix the double free in fsl_mc_device_add()
Message-ID: <656ca826-cb81-4b46-8e15-ec0b1044db8d@stanley.mountain>
References: <20241114082751.3475110-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241114082751.3475110-1-suhui@nfschina.com>

On Thu, Nov 14, 2024 at 04:27:52PM +0800, Su Hui wrote:
> Clang static checker(scan-build) warning：
> drivers/bus/fsl-mc/fsl-mc-bus.c: line 909, column 2
> Attempt to free released memory.
> 
> When 'obj_desc->type' == "dprc" and begin to free 'mc_bus' and 'mc_dev',
> there is a double free problem because of 'mc_dev = &mc_bus->mc_dev'.
> Add a judgment to fix this problem.
> 
> Fixes: a042fbed0290 ("staging: fsl-mc: simplify couple of deallocations")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 930d8a3ba722..8d2d5d3cc782 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -905,8 +905,10 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>  
>  error_cleanup_dev:
>  	kfree(mc_dev->regions);
> -	kfree(mc_bus);
> -	kfree(mc_dev);
> +	if (strcmp(mc_dev->obj_desc.type, "dprc") == 0)

This works, but it would probably be nicer to write this as:

	if (is_fsl_mc_bus_dprc(mc_dev))
		kfree(mc_bus);
	else
		kfree(mc_dev);

That way it would match the release function.

regards,
dan carpenter
 

