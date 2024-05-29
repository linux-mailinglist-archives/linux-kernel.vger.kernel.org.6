Return-Path: <linux-kernel+bounces-193753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9BA8D3193
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F39E28A896
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C278B16E86F;
	Wed, 29 May 2024 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AG4zH0A9"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD2615CD50
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971433; cv=none; b=nlx9qZToPAFyp8nutAfZ5lBNxaPMNXQwtdAXCurmCP4NZxLM92pA2df+UGdzKkzmzifdPdRmErWTaM8R9tKKlxnUiBQRJHQGHSx1ALWRAL1dHFXVxx8j3aI0xFaTdj2UiXsVbq9stBx5eMCucp2zlD5CX7drHOEsZ1FrRsOPpYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971433; c=relaxed/simple;
	bh=KalOd4VNB9ddnqI5SJEA/fxZiA7LJ85CstT18qQ+mEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiMM0bXE33VA1AgygymoQQt6bhOgG+8JDf8Beytt5roZB/rzP5QR7bD8+GK7p3M3ok/3n21whCmfpWxTMT6Gf5r6H/QPZlzK0pLe7l6oVTXjRI0EMyNpv2eRObeDWlpIHiDaPRp8tXhxoNTlJPEqYmF81Vwuy4v5sp1/hrd3VYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AG4zH0A9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70224f928edso39611b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716971431; x=1717576231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qenqQXhZZCyagreSZ+ZOYO//Et9NuVOjmhUJ/lmfY0=;
        b=AG4zH0A9IWb1LVOZAVTzjwqJpHpt9d4/DKxdxn7HS1+aelMJ0zXazylpAUxuw82fxE
         8xMBPOpyFW9ERkZ3cSSYc5aGcUiPJXoIJ8uY3wrOyRddUseAe5vO73oIPeNykgz/1P72
         iGZUHkFMUTWEPhm/5NJPAXaztaaiNoLUiVSrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716971431; x=1717576231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qenqQXhZZCyagreSZ+ZOYO//Et9NuVOjmhUJ/lmfY0=;
        b=l/G6S+mdF0Lt3pXhyoxY8bwZUq8Y4wC7pChujjsvY72t6DeQQBC/QYSl8WtnOurQ4Q
         nkK86bHtHgE6EFe17udX6v3GmRi3NVzc1UJ1R//CvIJ4WXpOuF79iVo30udgFLbftjF5
         8OzyfZvjX/20cCaljWYMha1TznmIMQx0F6JyxIdFl+XWWDJwEF3tbhpkQkZv6wWXtPYE
         YicKQqjro5rDTpNFOpi6rs8AkpfsctB0je97+BXySuRi0yu7iV/4wUrXgbmye5M754uK
         Xf7bjy0QcOVjpJIO3aWPzs1D0uMIgohVO5uViOqqzDAaSDfmfFQ/kZodpGfAW/M8Yi9q
         WvBw==
X-Forwarded-Encrypted: i=1; AJvYcCVj1nY1eNP/Tz/8lD0EV1E7YYmk2HONa4bVejoEcqWSiGEFaoUVCS8GXJOzmq5zo9oFn+ponsWGErowKg9PDXztrs2ufSa+Iu6fkqwf
X-Gm-Message-State: AOJu0Yx5yXILhgxpQ7OzaCRldMxKu2r3PbxihSGpgfFqcN81vdpPMaeo
	o1WH3witU2KBcx+f6M3/5HI6bmSoAhcdQhd6Zkgmpn1Fea9eqZzMezHnqAqrnw==
X-Google-Smtp-Source: AGHT+IEKKnlncqrQ+kEjd4U5yF4d7zX7PXa2e7lk0PLPAQVbSpQp5HDbTrt3J6bgh2D9uEk1OmzcPw==
X-Received: by 2002:a05:6a00:4405:b0:6f4:3fe7:7aa9 with SMTP id d2e1a72fcca58-6f8f2d6e5f3mr18821491b3a.10.1716971430731;
        Wed, 29 May 2024 01:30:30 -0700 (PDT)
Received: from chromium.org (174.71.80.34.bc.googleusercontent.com. [34.80.71.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbf2e3c8sm7576786b3a.41.2024.05.29.01.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:30:30 -0700 (PDT)
Date: Wed, 29 May 2024 17:30:27 +0900
From: Tomasz Figa <tfiga@chromium.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"hn.chen" <hn.chen@sunplusit.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v10 6/6] media: uvcvideo: Fix hw timestamp handling for
 slow FPS
Message-ID: <djwmp42odw4cre3yzvhlhsaxgp437qcg36kcvqzqadqqtc45zo@mzvernwjawfi>
References: <20240323-resend-hwtimestamp-v10-0-b08e590d97c7@chromium.org>
 <20240323-resend-hwtimestamp-v10-6-b08e590d97c7@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240323-resend-hwtimestamp-v10-6-b08e590d97c7@chromium.org>

On Sat, Mar 23, 2024 at 10:48:07AM +0000, Ricardo Ribalda wrote:
> In UVC 1.5 we get a single clock value per frame. With the current
> buffer size of 32, FPS slowers than 32 might roll-over twice.
> 
> The current code cannot handle two roll-over and provide invalid
> timestamps.
> 
> Remove all the samples from the circular buffer that are more than two
> rollovers old, so the algorithm always provides good timestamps.
> 
> Note that we are removing values that are more than one second old,
> which means that there is enough distance between the two points that
> we use for the interpolation to provide good values.
> 
> Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 24 ++++++++++++++++++++++++
>  drivers/media/usb/uvc/uvcvideo.h  |  1 +
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 5df8f61d39cd1..900b57afac93a 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -471,8 +471,31 @@ static void uvc_video_clock_add_sample(struct uvc_clock *clock,
>  {
>  	unsigned long flags;
>  
> +	/*
> +	 * If we write new data on the position where we had the last
> +	 * overflow, remove the overflow pointer. There is no overflow
> +	 * on the whole circular buffer.
> +	 */
> +	if (clock->head == clock->last_sof_overflow)
> +		clock->last_sof_overflow = -1;
> +
>  	spin_lock_irqsave(&clock->lock, flags);
>  
> +	/* Handle overflows */
> +	if (clock->count > 0 && clock->last_sof > sample->dev_sof) {
> +		/*
> +		 * Remove data from the circular buffer that is older than the
> +		 * last overflow. We only support one overflow per circular
> +		 * buffer.
> +		 */
> +		if (clock->last_sof_overflow != -1) {
> +			clock->count = (clock->head - clock->last_sof_overflow
> +					+ clock->count) % clock->count;
> +		}
> +		clock->last_sof_overflow = clock->head;
> +	}
> +
> +	/* Add sample */
>  	clock->samples[clock->head] = *sample;
>  	clock->head = (clock->head + 1) % clock->size;
>  	clock->count = min(clock->count + 1, clock->size);
> @@ -616,6 +639,7 @@ static void uvc_video_clock_reset(struct uvc_clock *clock)
>  	clock->head = 0;
>  	clock->count = 0;
>  	clock->last_sof = -1;
> +	clock->last_sof_overflow = -1;
>  	clock->sof_offset = -1;
>  }
>  
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index cb9dd50bba8ac..fb9f9771131ac 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -499,6 +499,7 @@ struct uvc_streaming {
>  		unsigned int head;
>  		unsigned int count;
>  		unsigned int size;
> +		unsigned int last_sof_overflow;
>  
>  		u16 last_sof;
>  		u16 sof_offset;
> 
> -- 
> 2.44.0.396.g6e790dbe36-goog
> 
> 

Given that majority of cameras kind of run ~30 fps, this should improve
the timestamps for quite a lot of the users. Thanks.

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

Best regards,
Tomasz

