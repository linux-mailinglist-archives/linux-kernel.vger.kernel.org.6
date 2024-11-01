Return-Path: <linux-kernel+bounces-392853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B90859B98E0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7CB28146F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F1D1D0BA4;
	Fri,  1 Nov 2024 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SBbBgz/T"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51931D0B8B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490404; cv=none; b=oEUsuica7U7hLsVQw10XYK24KXuxjM/4ge/9TJ5X6PmA+Yscu966megIfbNV5o3O90VG3RIcddNVZRbaTCaoOP4RkynMPFeJJyIOUK5rGOsV/UVmc8ci9ErpdspLQ3VHCPKdAHD7TLDLibiQSaTJuZ31knJapp+LiugKd3ozvFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490404; c=relaxed/simple;
	bh=1ofa25jN5S0/5jFGMQVKNon9D7tabgX8zoZiE0MGARQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hfp/iMKBHFQiJY88UnPjCNErth2KlOZzoPBxVXYYYe07oYivQ0VcDV/9pW7UMpxHCvPS74ZJzzL3oAD/fm05SSrcDrYawmIFuOM+ZEXW5FVd9bqhU0pZthleo0HHi4mkXl4AxJfVY86WFmmWWoay8iFvX1AyJD6OxA7lUeXy0Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SBbBgz/T; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43158625112so19646065e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730490401; x=1731095201; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A6CILudmT2OPooc17jg6TSDXbC214+AfvRFA780e2kw=;
        b=SBbBgz/T8xA43cDG+MacZWQMnCfVCK0DzN3T7F+hkEKZjvY/llAKcrmdiOxM3+5Ckb
         CN1BnkZn0a3JdM+ld+rmGy7x0mjI7z/AeWSZ6z6t6XI8flB2v5es8wTLS8ON/gRZemdT
         ojVS2gHIlVzsfFyT3yZ1qE/vQ90KtC9vx/mH2RQJRBUIiRQVKPHA2ujCHmxXEGJrTnMt
         nvqDSNnwAhJ/DHDNmE0XBDZRpunb1dRXAiFMtdeEzIJeDReIov6DBJntb/pzr9Qp2i29
         xDVZqe4B6gBbxnvudqr4pkUYgSMUVBuzFWTHM/BAWmNxsS5Hm8jcbmJTHlSFDIyg/88t
         VAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730490401; x=1731095201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6CILudmT2OPooc17jg6TSDXbC214+AfvRFA780e2kw=;
        b=oV/ta7OWKgVJOHHC1imTzOjASwlACfYAgQgbKjoDEoApyWN+rqcUjhcGH1bRSRAB5w
         ioWlC1WSsRPnVeutmvr9gY2tzw8rxlJOB2eHpuohWoRnCAvTrUb39dGTCUrwjTJdFhWG
         IdDYyh8huRMaV0dNV/27K56dBgi4TwmTODMz5WkjUGq/6pKIxL2mPWV4YtMZ/NWMmeHM
         wFuWD7A9KCsG7eHnNmG6pJFX4kyOdppThQq0UErgYHw6nXVnLcgKdHm5Ce8+GE/E4f8c
         dLdc6K8gVonKUcHQLVEMCWZdCBlFMkdo6pNhnHoOa59E07QWYPq18RnoFTN2CEQpEXp0
         NpqA==
X-Forwarded-Encrypted: i=1; AJvYcCU7ofRomddKqxPbo1wWxKyNPyqbmepMSEL95zshqEopeFbOCZyMiMu9TCMyLn0rLODex7m9EEv9tHk045s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYfqu6ux55vd4I6U2PdwKozjCfKxasYlf5GAxWK3s8OYg3uLOj
	bWORK38RTHQcSB+l2wipDY/CFJeAoJn/xkyQdyaaaSnNh/lZP6hcvWDq0wR1bxQ=
X-Google-Smtp-Source: AGHT+IEYhYUOmuQyVjbDtBBLtbHkZVAdS6CDRVy9twU3Ctv89CCKA3MmA3+rl4sTqEQ9BP8RtdHNBg==
X-Received: by 2002:a05:600c:1909:b0:431:542d:2592 with SMTP id 5b1f17b1804b1-4328327eba3mr38016165e9.27.1730490401007;
        Fri, 01 Nov 2024 12:46:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bb793e51sm101006135e9.1.2024.11.01.12.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 12:46:40 -0700 (PDT)
Date: Fri, 1 Nov 2024 22:46:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	arnd@arndb.de
Subject: Re: [PATCH 1/9] Fix buffer overflow in ni_usb_init
Message-ID: <2cde383b-156f-48f8-a1f5-344561962f37@stanley.mountain>
References: <20241101174705.12682-1-dpenkler@gmail.com>
 <20241101174705.12682-2-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101174705.12682-2-dpenkler@gmail.com>

The subject should have a subsystem prefix:

staging: gpib: Fix buffer overflow in ni_usb_init()

On Fri, Nov 01, 2024 at 06:46:57PM +0100, Dave Penkler wrote:
>   The writes buffer size was taking into accont the number of
>   entries causing random oopses.

Remove the blank lines from the start of the line.

> 
> Signed-off-by: Dave Penkler <dpenkler@gmail.com>

Add a Fixes tag.

> ---
>  drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
> index 571f07800c9a..9ff56b063681 100644
> --- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
> +++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
> @@ -1726,7 +1726,7 @@ static int ni_usb_init(gpib_board_t *board)
>  	unsigned int ibsta;
>  	int writes_len;
>  
> -	writes = kmalloc(sizeof(*writes), GFP_KERNEL);
> +	writes = kmalloc(sizeof(*writes) * NUM_INIT_WRITES, GFP_KERNEL);

Please use kmalloc_array().

regards,
dan carpenter


