Return-Path: <linux-kernel+bounces-294514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1246958E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 21:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7FD284D53
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDF615B57B;
	Tue, 20 Aug 2024 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ea1eb5su"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3163E1586D0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724182194; cv=none; b=LI4KwAr28WCKQLLEKJCPSMFJQK13qSlSF85vlYy7h+Q5ITTwtRTtEAthKCMopdzlKfC3AtkM73+eIo5UX6BdIiRNMB3dKsZrss4SkOsD595K7JZ4nZUEV6/TLh8eJ+0/AeCkVmHXt1hC5CqqztRwG3quw1182kfCnKNXB9s8hYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724182194; c=relaxed/simple;
	bh=0DLiLPd13njmu78yKPrzi8MMekeL0FF9I892fb51s+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9k369Te6uIAmepompv8q+Rdelbx0bGEjXLalBUeNKptXUyIihXk9ywl/QGLer2fAu8mbOWex9UkaG+9yt2c5gAOlm3Wrh68DP/s6lVEhAR7z5qj0PWtA03rqE+NmYBQbw69XIgn/TeEQvMdHd4FaM85cMjh5kgypzzJ2lob8Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ea1eb5su; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aada2358fso7178566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724182191; x=1724786991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TtG5Lka0HNtdGpA1EeQQSE6lBWCGpDbes0Ags1zb6dM=;
        b=ea1eb5su4VagbO3CkJsNqlr/DYIydJM3K733GCnznz9qFaL48gPwro6OuDTCn3Rjve
         glu/5amrSIl4WjOVrQb1fI1nqauFgYvjUPuQRnYa6FWyzb4oAR1/nZqXUU7ezlVjSJMl
         txkIS/99BdJ0ev066ijb5aGJvFSmvdFvL1GIeCO6yZrKr1V9lXSMYqPTX1Ex6bVOhOEp
         zDB2hBUKqKKHud+PsPWOgr/OTLC26xrl7Fzbg8q0HrdiSP+UH8YnCZLcRO6WQSfLLPE/
         CeqLZX0tdy6gA0F2ZhlTj+ArJ/wuVPjDKCi0TPkThiqcFi6DmYZ/HwwRdpvfUXitjr6V
         SGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724182191; x=1724786991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtG5Lka0HNtdGpA1EeQQSE6lBWCGpDbes0Ags1zb6dM=;
        b=KKqzosvqXM1U5ZPhghRDbBeCogQ4+IUoOkWA3EMhTeGDc3jgo+yJ/1vodrVCADFBUC
         k8hu6jT7PQk7Yi1zPBYr16Y7It1jvjl6Za6/YBzyKAz1z8dnxALd3bnIPDNuxtb5Etun
         yHx0PsNymQsbn00PlwVeP52TvxGVZVFlmIFbIPOwPBcrm5EgFbOTjYgMc2XksQP1eED9
         tS14r8U9OiJ8+wcyeLnbZO+zFjXVtz7OuNFVkO95GqAIUpwH5K30zF1EuGP94j+zQHLE
         J8MEXOZLakYc0qxp35OoP0p9/FerMeqHbvSoigFQ/RhuouS4f37Eoel/TwDP9amU+IYA
         BmNw==
X-Forwarded-Encrypted: i=1; AJvYcCUqr+M09HI+XyJ1JEPRsvdonHINymSJ6igjocO/awm4Ynv+BpgOlnbEEXzlsM7a8slllrdijo3OSpmiKFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKPIS5JDUboPR0JHNJiE8qiOjxoV59GAq3Huad8/KdEeO++sby
	We1qDYE2JPxANlSX6OiK1OWEFMqL0CEgzMmmvIhxdw2XSnWONfxHfFr0JPKrrLw=
X-Google-Smtp-Source: AGHT+IETXPjrBHvfjZmAs+zAO1dDalx5QNb/07TUykr+gTYgm5eDKM8K4jqdR+hbv+4h3jvEnLjvGg==
X-Received: by 2002:a17:907:3e8d:b0:a7a:c7f3:580d with SMTP id a640c23a62f3a-a8643fd93a2mr445202966b.25.1724182191308;
        Tue, 20 Aug 2024 12:29:51 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c67d3sm798852766b.1.2024.08.20.12.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 12:29:50 -0700 (PDT)
Date: Tue, 20 Aug 2024 22:29:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: gregkh@linuxfoundation.org, tdavies@darkphysics.net,
	philipp.g.hortmann@gmail.com, garyrookard@fastmail.org,
	linux-staging@lists.linux.dev, skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: Replace strcpy with strscpy in
 rtl819x_translate_scan
Message-ID: <b2efc687-07bd-462a-b0a5-58e09bde32a7@stanley.mountain>
References: <20240820184216.45390-1-abhishektamboli9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820184216.45390-1-abhishektamboli9@gmail.com>

On Wed, Aug 21, 2024 at 12:12:16AM +0530, Abhishek Tamboli wrote:
> Replace strcpy() with strscpy() in rtl819x_translate_scan() 
> function to ensure buffer safety.
> 
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtllib_wx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
> index fbd4ec824084..970b7fcb3f7e 100644
> --- a/drivers/staging/rtl8192e/rtllib_wx.c
> +++ b/drivers/staging/rtl8192e/rtllib_wx.c
> @@ -61,7 +61,7 @@ static inline char *rtl819x_translate_scan(struct rtllib_device *ieee,
>  	iwe.cmd = SIOCGIWNAME;
>  	for (i = 0; i < ARRAY_SIZE(rtllib_modes); i++) {
>  		if (network->mode & BIT(i)) {
> -			strcpy(pname, rtllib_modes[i]);
> +			strscpy(pname, rtllib_modes[i], sizeof(pname));
                                                               ^^^^^
pname is a pointer, not an array, so this doesn't work.

>  			pname += strlen(rtllib_modes[i]);
                        ^^^^^^^^
pname is incremented here.

What this loop is doing is that it's going through all the network modes and
adding to the string.  You should look at the rtllib_modes[] array and ensure
that if we printed every string it would fit into pname.  (Currently that is not
the case.  Probably not all network modes are possible.  But I have looked at
this code and I'm saying that we should just ensure that we could handle it if
they were all possible).

Feel free to re-format the code how ever you want to make that happen.

regards,
dan carpenter


