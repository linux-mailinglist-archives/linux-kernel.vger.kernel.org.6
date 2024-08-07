Return-Path: <linux-kernel+bounces-277995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471ED94A926
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0764E282216
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6894720124F;
	Wed,  7 Aug 2024 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="lc2oidqi"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D65200108
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039000; cv=none; b=OPtPrDuBXUYKDBA7LUSKh5C6TOR8A/wy6oCiOgW7p0CdUGAN4CIek2Vee1QC1VY5cyJKziMY0vOnF98Q3t+rhsN2ni5kPsZ+n+8ZuBhvLB3JkkcrS62dVJupnPzfehkztGA+KJOPlGDnC7hAOyn4DbnIv8bsNUeXlDOlhlZMqD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039000; c=relaxed/simple;
	bh=oyMT0FbvyEUEWDumW0O7TOVW/E8QkS8/DViHTmTG7n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtdPNI3JBYcwaAvh1eEtCLbMnopYp2QwEqqu53bVTR4xa5sOlV0OsuEKADhxZIHW6EhUwbAw7EAvjB2ZwTC/BF4c09TXPa7nNEZkSNaWnFtM3vWTjpVi3qxroeu45s6a/vGRW79OGKSSWj2w4W7V1taIaLPP5gIlaBY6JA2FFJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=lc2oidqi; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-82e2eee5f5cso539299241.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723038997; x=1723643797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JuS59JADbTnnYXSWbhEozGqiA0xSa9BLnZ7t90LFaxE=;
        b=lc2oidqiHK/PZd850fOIITaMn2RGUlKb3BVv7MpS8fFZ9dNtTcJZuKMqQFSg089EE4
         Bns4dZxXHwAZY/CrtRqmIXTfryJxNj4Z6sp5udPe7C2X5SwMy3Ytixf24rK1ROPMHQ2Y
         Um9oo8nOQzmV1QHz2Fj6TEV7pAUfKGJnCzJ2ZDL7HJMbFAMMut4lPwPQZhmV6gDXM4kT
         2Ar14wycSF/0XZavqs4Y+ebs/yXryX8E5UCqq6VBVSM2eYFBKr/Rj3gtru7jUmHoY1XC
         mtKF7pFQMRnZgbU8b5uLtxHO3NEV+Pali+XanCikuJFbyZcgbAZ9TYIYSdqi0WBr2uEd
         yg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038997; x=1723643797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuS59JADbTnnYXSWbhEozGqiA0xSa9BLnZ7t90LFaxE=;
        b=A0G4uh+6xsA8hDeROS5jBNJtgA6VhVk12cMHZqWJ8jnr+dx0v/LJanUGmQALCShkjv
         U0b7KrdvatJHnztvSxvyaOUYiJWfLBCPwjtlyIvFXFHQUwhiJqTOPGHnGzmMydIuhivl
         B1oFZlqHN6Pow97nY8SbnGdcR90VRhVVWYKM0Zu7YY9s10LF187XpTraWPuDLb01LCmd
         WvT8Tnll9ewz81B5AU4hvIwLBc/YjV0fRN/SSGpBMpvxyfLwE0d5crCqRBV7BzWVRaB/
         PXNMpCwXgASVAD9xBETx0lwt4gVZML93T9gd5Ugi7gT/ulNQTv6Z9CgKCMcfsnAXurfk
         6l1g==
X-Forwarded-Encrypted: i=1; AJvYcCVK+1exK6ua0OuPtXyEOnd8b5whO0fd8gyHCJuKlJvl7e8lBRzzDT5je3K5XQS3s25EqfqdQh+6GhfacLQO9/ZuttZzuYRcVGacHdww
X-Gm-Message-State: AOJu0YzIkp7Wf+5hIZr8ItHePqdcbnmZ/e+Bj1kUoov99gq/8eGMXKWh
	O9QLv7fcx+mX32oCU0YMdcTApJC4HswIm14y6746caGPlSpfqkiTXvsPFTLTNSz9raF2g3PvJ4H
	N
X-Google-Smtp-Source: AGHT+IEOWFTdrwiZrbHViifiqbdv+xNaB1znBNizFfr4dGmtnW/qOKfBByKDT2UtyQKnBsMQ2WkouQ==
X-Received: by 2002:a05:622a:4cc4:b0:446:5c58:805d with SMTP id d75a77b69052e-451c79d46dfmr52220451cf.19.1723038986722;
        Wed, 07 Aug 2024 06:56:26 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c870066csm5157471cf.4.2024.08.07.06.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:56:26 -0700 (PDT)
Date: Wed, 7 Aug 2024 09:56:25 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Wouter Verhelst <w@uter.be>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] nbd: correct the maximum value for discard sectors
Message-ID: <20240807135625.GA242945@perftesting>
References: <20240803130432.5952-1-w@uter.be>
 <20240806133058.268058-1-w@uter.be>
 <20240806133058.268058-3-w@uter.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806133058.268058-3-w@uter.be>

On Tue, Aug 06, 2024 at 03:30:56PM +0200, Wouter Verhelst wrote:
> The version of the NBD protocol implemented by the kernel driver
> currently has a 32 bit field for length values. As the NBD protocol uses
> bytes as a unit of length, length values larger than 2^32 bytes cannot
> be expressed.
> 
> Update the max_hw_discard_sectors field to match that.
> 
> Signed-off-by: Wouter Verhelst <w@uter.be>
> Fixes: 268283244c0f018dec8bf4a9c69ce50684561f46
> ---
>  drivers/block/nbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 20e9f9fdeaae..1457f0c8a4a4 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -339,7 +339,7 @@ static int __nbd_set_size(struct nbd_device *nbd, loff_t bytesize,
>  
>  	lim = queue_limits_start_update(nbd->disk->queue);
>  	if (nbd->config->flags & NBD_FLAG_SEND_TRIM)
> -		lim.max_hw_discard_sectors = UINT_MAX;
> +		lim.max_hw_discard_sectors = UINT_MAX / blksize;

We use 512 as the "sectors" measurement throughout the block layer, so our limit
is actually

UINT32_MAX >> 9

since we can only send at most UINT32_MAX as our length.  Fix it to be that for
both patches and you should be good.  Thanks,

Josef

