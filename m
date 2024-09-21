Return-Path: <linux-kernel+bounces-334756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D402597DBC7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 07:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A256F1C20FA5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 05:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31C22F46;
	Sat, 21 Sep 2024 05:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+r4x3zc"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823F7224DC
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 05:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726897534; cv=none; b=clXubtIU22HnJctHvwvbkct1AF5EjiuvSe0Bk7z09e67GwuyyjJNaNqvwUWQPut0/yQTPZh+Tl789kV/pxplP3IjYaRDmv3h+HIpKXLzVg+BppKwh9As2JfzMFa6bEahQyokPVVrQMnTCKF4eJm2D8uZU/JVpLLHZPkutgGDCsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726897534; c=relaxed/simple;
	bh=mRY+u52b0HS9G77V1X6KCObW5QNyLv/D/xsBI18z748=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwBDnv7wpx8WpAyVIxjdFPRKarioZ1Pp+JaNSIvgw4yztFGyZMBEI0jDDgpI+05nzfyNuj+iojTVz4xiMlHpBNlVFZYLTGg6Aht6p9bFczOrV8ni9xjKEPeqJZPEnyRvcxN6mDKlrc8M982gXsSUv0frVbRMHwp/GfhQE8/mxpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d+r4x3zc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso460999866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 22:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726897531; x=1727502331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt91zIU78UembNOoavBRGKqs4HCoYoTrI5Z7h5+MO2c=;
        b=d+r4x3zcsKbS96WYeYwjG7kWQnDToW8sf9GSrSyY9Spl00aIxwMTRVdYWYQ4vTC5qm
         aAfbc5kNJSFxHs9XLPu4vxXCq03vQq7nTRSn7AUVpAqlYNgFZC9QSColu8ArlKgajcQ0
         6HghqeKEXworXsgwR+pIEFvHjpKr7S++LHLiGgNBA4z6h/kgXKQnc36/MWTNzCdE1x3K
         5vPnYOi3b6vA0E4+ouPtj1gRf6UHli9WUoWieb3NlV1MnXg0H6ZnyVJirHfMQQYer2St
         FWVk8UU17R+4nFRxU6SMVY8UIwxWJfGT/tZe4qvdvaRxy3JIAp9r8EAZv5Ndjw2NsVXd
         x+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726897531; x=1727502331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tt91zIU78UembNOoavBRGKqs4HCoYoTrI5Z7h5+MO2c=;
        b=sKxStrLlLM9lLUOfc9QVLN6vfLvoKqb27rWT8+V5fNyJwz9IbHYJx4i40pKsNL8FsM
         1SxpEx7ZtuVtT6ZvFT6NxLX1yoDJZzdbmwKq0cdj65/kSdqkcYIbEZVMtgUw+1dA6WQt
         ygF7/pltOj/FvPnyCU4RUdUfdRZ0jnFdGnm6DsyXFcnDSBLbNCz6LnZEAt5jmcpxBhdR
         XSPZosiuMtZxb8YlAKrDYQAWQIyREGMJsujOOq8ofrk7DWeiJa5Dm7CVoOwdNRlfrS5o
         N2Ey0ALhYTNQnB3vAnr3DRFS5Xetp68D6lozgkJGcZup0HEf5dRYzflw7p/R3go/Vn2U
         MZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxilNoq4rBFBJ95c8oHX4965yx6jVJRIU2w6+i+gBPu8x+zJ7cdl/f90+oIFbybmwHZDi1Yr67VqkMhfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMZLTsA7/I1L7rkFq+srT0pDC0tbnA7JyYFc/RC64/trLIF9kh
	EwIb2MVdJxwge89PY6I2klD56y6aWwcKEK273dk9LOWcL2ar2wzGCr31phL2nF0=
X-Google-Smtp-Source: AGHT+IG7vuSvZQQrOANcGu/QBcXt2ctzgd+JxbXK3wqq7h22fBgHCfoWtmF7mHf8rru4jQdl1tYn1g==
X-Received: by 2002:a17:907:f1dd:b0:a8d:42ec:e65d with SMTP id a640c23a62f3a-a90c1c384b1mr880535466b.7.1726897530859;
        Fri, 20 Sep 2024 22:45:30 -0700 (PDT)
Received: from localhost ([83.68.137.68])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061096a3fsm943697866b.15.2024.09.20.22.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 22:45:29 -0700 (PDT)
Date: Sat, 21 Sep 2024 08:45:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] container_of: add container_first() macro
Message-ID: <694a8a87-cc98-4c04-8228-d399133fdd39@suswa.mountain>
References: <Zu1vekikKNR5oUoM@elsanto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zu1vekikKNR5oUoM@elsanto>

On Fri, Sep 20, 2024 at 02:50:02PM +0200, Gustavo A. R. Silva wrote:
> This is like container_of() but it has an assert to ensure that it's
> using the first struct member.
> 

I just remembered that Greg wanted this based on container_of_const().

Really container_of_const() should be renamed to container_of() and
container_of() should be renamed to container_of_helper() and we
would add a #define container_of_const container_of for the transition.

> Co-developed-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  include/linux/container_of.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> index 713890c867be..928c5865c1b4 100644
> --- a/include/linux/container_of.h
> +++ b/include/linux/container_of.h
> @@ -22,6 +22,24 @@
>  		      "pointer type mismatch in container_of()");	\
>  	((type *)(__mptr - offsetof(type, member))); })
>  
> +/**
> + * container_first - cast first member of a structure out to the containing
> + *		     structure
> + * @ptr:	     the pointer to the member.
> + * @type:	     the type of the container struct this is embedded in.
> + * @member:	     the name of the member within the struct.
> + *
> + * WARNING: any const qualifier of @ptr is lost.
> + */
> +#define container_first(ptr, type, member) ({				\
> +	void *__mptr = (void *)(ptr);                                   \
> +	static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
> +		      __same_type(*(ptr), void),                        \
> +		      "pointer type mismatch in container_of()");       \
> +	static_assert(offsetof(type, member) == 0, "not first member");	\
> +	((type *)(__mptr - offsetof(type, member))); })
> +
> +

I added too many blank lines.

regards,
dan carpenter


