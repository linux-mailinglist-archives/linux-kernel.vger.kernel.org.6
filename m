Return-Path: <linux-kernel+bounces-267054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2952E940BCE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8453286EF0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41BA18FDD7;
	Tue, 30 Jul 2024 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hhgbnNFZ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604AC15ECDB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328726; cv=none; b=FqPCI1fY2OJ0HNrJIKOuMffHNCiemw1rLN+OprEynq5JcUdj6Wa+WYKjqcuX3uBFOA+CmHPiP770awnTY6NrLJg/wzUUc4RzHJEX5WDlFYDBrLMxVNkjmJDRkk8XIv4mTNmBnNd1XFshTQ4VBYohQM61UFqMIGnKCP7+jqws+nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328726; c=relaxed/simple;
	bh=A9nnbPdJv5+0MfMQ/SJaCGweUfaVlv/rna/HQUxQlwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Okq3OU8inoOM+yhcb8kabpvP5Ivkjj5J0wIlw+jsJkwaahEjZ2ip66d7A6a31MqWLC5isU6PszLLfE7pdSYlp8kZsmDfvyryd7NN77O9njxsA0LHfs/YuBh0u1vALNQiN3apgxudCXFt0FW8dYp0I2V/E1JJr/1rv+D4mea8r+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=hhgbnNFZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4280772333eso1518015e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1722328720; x=1722933520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLSHeAzxwq9Akqi4K9srtQYuVjFjLR4YzmJwGGEqqlE=;
        b=hhgbnNFZgHnYRV3VyYQYwV1jeu+yLIbQu9uPvcyrAg66mqrvhjgY/HsSMImW1xkV6e
         qrjJA2QdFmv25GNyBpyU7f5yYqZie6WOCF+HbCIa6oCS/rKSrr08qMdNjwbdCyRnuE+g
         xrWNYCpNlWluhTSwVgXPkuw2XrEnnY1q1Zcac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722328720; x=1722933520;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLSHeAzxwq9Akqi4K9srtQYuVjFjLR4YzmJwGGEqqlE=;
        b=ZUWsdFSqxjHYyVX5YxRilqCrL1DGYGWdc8PbTxwbk05tuf0o8SHeLwTABDItCPVHhl
         DXN9HhzSodl/HHETGhHd9Je/oqAHhgoMb9cBGAmqSE4eST1a+bxZ8vR1LlbRe5JFg0+s
         5TQ+lF3Vh7eg0XYeMvcxIHCpdiXCc7mLAnIiJCSKtPbh/tHG6WldQY2unb/yG8b/wINj
         fDLxgvJpEhrOdR39AsAZhK6/FsZMkX9mKgtcaet2fDuEe1CVBCNl6+TnPABfJMKNtPCX
         1H2MLysnYUvbmeQMyLcmAywMiE8zFM3BJfVhSkHAX+sH6URhSIy3U0sUM5P6UeLZNQCi
         cKXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzjAjZL9doBqwnUe82fwNunFbvzLt3j0ioNskdfG37rUp4wTh3qx53bb985Uc9+Iro0dJ97BK31kNIcgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZZCO3jTuu6+5whKJMoADcUPBBJg9GQDNghZfSkE3L27rOHIcI
	A5EJOrTXVoFXnyET1wCi0e1ygcKkPo+CviwCuv3EIRYiVBdDfz9+a3kMJC/70Ng=
X-Google-Smtp-Source: AGHT+IEHxwvRRVdvTsna5pPYQlLBDyGEKWP6n2hUjZSj5fgD4PVWENljhOK87uALcOP5pl95OHCF7Q==
X-Received: by 2002:a05:600c:1c99:b0:427:9f6c:e4bc with SMTP id 5b1f17b1804b1-4280570b81emr71159635e9.5.1722328719721;
        Tue, 30 Jul 2024 01:38:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281c701619sm72813255e9.36.2024.07.30.01.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 01:38:39 -0700 (PDT)
Date: Tue, 30 Jul 2024 10:38:37 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: oushixiong1025@163.com
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: Re: [PATCH] drm: Add the missing symbol '.'
Message-ID: <ZqimjZT2KAClX7tx@phenom.ffwll.local>
Mail-Followup-To: oushixiong1025@163.com,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
References: <20240729065756.123788-1-oushixiong1025@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729065756.123788-1-oushixiong1025@163.com>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Mon, Jul 29, 2024 at 02:57:56PM +0800, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
> 
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>

Applied to drm-misc-next, thanks for your patch.
-Sima

> ---
>  drivers/gpu/drm/drm_probe_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
> index bb49d552e671..285290067056 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -888,7 +888,7 @@ EXPORT_SYMBOL(drm_kms_helper_is_poll_worker);
>   * disabled. Polling is re-enabled by calling drm_kms_helper_poll_enable().
>   *
>   * If however, the polling was never initialized, this call will trigger a
> - * warning and return
> + * warning and return.
>   *
>   * Note that calls to enable and disable polling must be strictly ordered, which
>   * is automatically the case when they're only call from suspend/resume
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

