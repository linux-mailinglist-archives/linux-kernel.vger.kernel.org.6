Return-Path: <linux-kernel+bounces-193493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5C18D2CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C790B2316E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0C215DBAD;
	Wed, 29 May 2024 06:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ObHQyTi2"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31681D68F
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716963234; cv=none; b=gVAa8r0hIQBQmcsUswhctktU2H8hS1iXaMc1WHY8ptvlVhDYQO2g8Ll1i7vn+hQexgbBYUd8CCp7LJTR30a0seGiqr6So0lolvtdEFz/eYXohnpIT5GlI9xJCfaqsQ166gGMqqXil9TWN7yrauTSAUrXv3hSJytam7RQhGvoytU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716963234; c=relaxed/simple;
	bh=3FSvLZlOgEc+aUu5jFCR372lA79UDHQsiGqRizvsNeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkkoS/RqIC21LBmaE2iFFRdfdHPtFQ1yJ89nbZsqrzxFrJUlDC786Rp2coVVMrafiRHejXE0l5j6KLAbN6bvTVDYAt5cnC8EhxBg0oyhdIzu9MBFSefSUMGks7H7EXwK0LJVptviWCquc6tHK7178wrcIgFyQp/cHfYfUm9gprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ObHQyTi2; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f48e9414e9so4960795ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 23:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716963232; x=1717568032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mb1XJXdu2//C7Xx7gnMlD9T15Ki5dUYRiH8NLKoSURY=;
        b=ObHQyTi2uozW3LJSjuzasfLf5XFeatxXArsoz5kulkjHaV/vtzdFsBE21GyGaxvKw7
         s+k/4A+bGU2bulqQjVdb+2pT1xmVC5vuLMY5Vy9pHN6FBCsBEXUWnT3ufRsTkI4XVZNj
         Qgu2JNJbzpP6vaAUVsOh2G0uWcoMhP7mEOWRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716963232; x=1717568032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mb1XJXdu2//C7Xx7gnMlD9T15Ki5dUYRiH8NLKoSURY=;
        b=RzUrMTbi+PxP16Kletko7JtTgkZnrOlQfvI8+O0Iw3J44eJPNxcl+OPBcLREcUWQfC
         B7WtaW0KxNtkKJm/kGkJbaaajtyJCnMjiP1zIt+WQ+Wklhd0SEFUYeYVyH28cjfpQs5k
         YlrUvktSzJfwdekZfhfLvKo46XHlpfhokdnBnfOQSVtColvNtYHRSfbEG3G6ijs/ZW5y
         nQI6Xpm725MFJDIgeQvVNmlq25hukfTpF+ysJ7MPuXq3HA3HKYZ6rb2berDGv7GDwEQv
         MOzn5NbglWtWjSbTjOaZNhrpIee5DbLs/Xn9SqHRgt1bymdtUH1qHXRtRbWDPwfzfh5S
         larA==
X-Forwarded-Encrypted: i=1; AJvYcCWomkzHYIpIZX3zGSdNmiid085dE2ULO6DSoDaiHRLFav8Vox4fNPH/e4CeVc4FhvNsdGNpUC9n3WPXwoINmvtRszs+kxUKV5WYU3H4
X-Gm-Message-State: AOJu0YzTlNniLdNGgK26qlAziZUg0AjMGQxLnfWLoT/FDkFku2Aea3r1
	1uxVW4nhksXinDMR1JjXkeSrqLQCk/bcXwAiE38TMQZN4dXoYGWnIveiGoUE7A==
X-Google-Smtp-Source: AGHT+IGM70tAxQ5wUXo06dTx7marcWxV7pZaxCusq+1MywGIjjvwFQbPhH0jgK7VJkUjD6z9/QpLMA==
X-Received: by 2002:a17:903:18a:b0:1f4:736a:27fa with SMTP id d9443c01a7336-1f4e95f4709mr20001565ad.0.1716963232293;
        Tue, 28 May 2024 23:13:52 -0700 (PDT)
Received: from chromium.org (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f47efff203sm61305385ad.241.2024.05.28.23.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 23:13:51 -0700 (PDT)
Date: Wed, 29 May 2024 15:13:48 +0900
From: Tomasz Figa <tfiga@chromium.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"hn.chen" <hn.chen@sunplusit.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v10 1/6] media: uvcvideo: Support timestamp lists of any
 size
Message-ID: <ga5jxpqrz33js4nzziuj234vxlkjhcanofqymjcy2vi2x7irjb@bkubcfb43ylm>
References: <20240323-resend-hwtimestamp-v10-0-b08e590d97c7@chromium.org>
 <20240323-resend-hwtimestamp-v10-1-b08e590d97c7@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323-resend-hwtimestamp-v10-1-b08e590d97c7@chromium.org>

On Sat, Mar 23, 2024 at 10:48:02AM +0000, Ricardo Ribalda wrote:
> The tail of the list lives at the position before the head. This is
> mathematically noted as:
> ```
> (head-1) mod size.
> ```
> Unfortunately C, does not have a modulus operator, but a remainder
> operator (%).
> The reminder operation has a different result than the modulus if
> (head -1) is a negative number and size is not a power of two.
> 
> Adding size to (head-1) allows the code to run with any value of size.
> 
> This does not change the current behaviour of the driver, as the size is
> always a power of two, but avoid tedious debugging if we ever change its
> size.
> 
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 7cbf4692bd875..659c9e9880a99 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -732,7 +732,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
>  		goto done;
>  
>  	first = &clock->samples[clock->head];
> -	last = &clock->samples[(clock->head - 1) % clock->size];
> +	last = &clock->samples[(clock->head - 1 + clock->size) % clock->size];
>  
>  	/* First step, PTS to SOF conversion. */
>  	delta_stc = buf->pts - (1UL << 31);
> 
> -- 
> 2.44.0.396.g6e790dbe36-goog
> 
>

It could be worth mentioning that basically head == 0 is the problematic
case here, but otherwise good catch.

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz

