Return-Path: <linux-kernel+bounces-194279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446998D3966
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F298B2805D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C244F159214;
	Wed, 29 May 2024 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OiZShIOy"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C85C15920B
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716993285; cv=none; b=W4yTJLxLiYolh8d9Y0zB8j0rl+CNLrg7PbwN50Wg5aU6Z0L6wAuoj/+LQFVjye/gEKnTvEflZhN/toqn1z27UxMC6c9oMtAbCeRcX2f38QMzYH5hTTILNJ7jXOZHviX4pjxjRuBwDgpi3uSbEvyCtph5g/7s4H5HeRMS7uhM4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716993285; c=relaxed/simple;
	bh=kA7CXxgdm0m1foHK3IR+qoqDJrbO6cKUy0Fh4VXhYZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apud1GjrtLRTGhTBbZNQknlriQ2Okn8yMMFoetHC05Tl+aWzBYlWA2x+UCWCKK8H3qd1Z6aAmcsUbYy6oqDVkJNdLoh/LuXJfP158YwNW9Vz68IACHHNJxYoh96E9i2GCET6yMT0502IXHS4/epQmZZx74+hzWEKINC0O3ObMHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OiZShIOy; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a653972487fso65457266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716993282; x=1717598082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cd5Jaltzw12rjCKy5wbs74zqw1sF+7oimZgG7BDaEa4=;
        b=OiZShIOyKEFduqaeZrGuGp9mNLwOrN+IIXfAqH5a5CdmZg6xdB1CZluwEUG02Vptwc
         aQBqk59MANjHtkxkpWt/X9V6Tzza+NshNAdwT1klNEkicZrUNl2P8/e32vykBg6nZ+80
         NeucUgG+HH0CAMh/q23GubfhacN96+Sqn6IZWekkEWE+iZpcoNKsUIiwfyOgWgj1bN8/
         fVs8yBoEhF9mCQer+IzYrT4AV/SJH6rYNbw+QvDW1qN2/rncynf/fAoxWhOVJqf2olad
         dolyqP0/6ocoy9vw5wOPPWkLD7BLhaXR3/KiwDuQnu6cyUcgJ4d1bjV+1SJXeujDwDbd
         JMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716993282; x=1717598082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cd5Jaltzw12rjCKy5wbs74zqw1sF+7oimZgG7BDaEa4=;
        b=Oak6HrOu0SlBI6VTq3Yddp5z/OEseU/WCUzl2RB3rWywrS3/9N5ZcKBC0/HRQHAesl
         UaE2e+9KudS3DbeoT+yb6OwztP9iWMlNX4yQNERESB6eLFmlrzFlMMUKYeoutXdoWDFd
         MXgoqWQpuLhXHp7tD3qI3i9oB5jcJSq7NgK7P1SfiB7UpdiAzZBTzK7ZgTCJi9F51boE
         NV9AR5ZTLw4mUZAz+L4YkxItQ4eR04Y7iSa8Mt8pPOEdEW+ObFMpYO4AxMCLXy5SceEl
         Dc+35Asf8/8ZHu+/fUf2APq4XwqP5XGU+zTHEPl+xApAx+nTygq+d5YqOokncW2grgAA
         fNXg==
X-Forwarded-Encrypted: i=1; AJvYcCVowtF+x+iMTIAEgEEo1fkX/6D4GuxfXDgSuPCfVWEzAvLn1EeluBeQRaXqznbnpdQSENFDxekeOoqhVQRxvn+nGwAwhSWy68wsY/sw
X-Gm-Message-State: AOJu0YzSaCZpcK8EFyHEMkCUQH/x8PQmlyR0Vrx+uJBOxMgDMq+Gpbrz
	AJ5zWIsS2qpIUEDH94rSmVN0p9O/ZqXZUGjAvGZMFjDOXdk70E0yjDVLGFRUSHo=
X-Google-Smtp-Source: AGHT+IHzDIOEvIZTdtVtvHtAQQImy8QQq+8Ht/4nvi42XIhMSlQyREMA7uCbQ/iCpAaEW85rsjw9JA==
X-Received: by 2002:a17:906:abd0:b0:a5a:896f:9be0 with SMTP id a640c23a62f3a-a62642eb70bmr1169713166b.27.1716993281816;
        Wed, 29 May 2024 07:34:41 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a64255dc8cesm83208466b.186.2024.05.29.07.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:34:41 -0700 (PDT)
Date: Wed, 29 May 2024 17:34:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: linux@treblig.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adt7316: remove unused struct
 'adt7316_limit_regs'
Message-ID: <d9a3c974-8a13-43f8-a0d1-0e55f6e1f3ef@moroto.mountain>
References: <20240528233008.191403-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528233008.191403-1-linux@treblig.org>

On Wed, May 29, 2024 at 12:30:08AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'adt7316_limit_regs' has never been used since the original
> commit 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9
> driver").
> 
> The comment above it is a copy-and-paste from a different struct.
> 
> Remove both the struct and the comment.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/staging/iio/addac/adt7316.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 79467f056a05..23d036d2802c 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -209,14 +209,6 @@ struct adt7316_chip_info {
>  #define ADT7316_TEMP_AIN_INT_MASK	\
>  	(ADT7316_TEMP_INT_MASK)
>  
> -/*
> - * struct adt7316_chip_info - chip specific information
> - */
> -
> -struct adt7316_limit_regs {
> -	u16	data_high;
> -	u16	data_low;
> -};
>  

Could you delete the blank line as well?  Otherwise we have two blank
lines in a row and checkpatch will complain.

regards,
dan carpenter



