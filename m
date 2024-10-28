Return-Path: <linux-kernel+bounces-385071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4519B3207
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1279B1F21FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F8C1DC19D;
	Mon, 28 Oct 2024 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rKQ2XQka"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F471DDC2A
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123041; cv=none; b=W5kJQwFnhESGqvYlot7vnPq4YdC8MJJt/hCdHld+At4LwbzOcYrP0EdwFLhqHXvCIaJfZRCveUl0r2S9MQouFZ+TLhtESgsINb1XJdG6ZDaKERoAUBvPbftpEI7CToOzV2v/bY2YWED83lFN9WExhxuaVl+2DwS9GIb1PagYzsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123041; c=relaxed/simple;
	bh=WIGSURUd4vPgd0LwhCySLb2u9jRTOO7tEiMoOSxAIFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhkqReYS6LSqm1ZzbjHl0MtyNjayROhovhN+8uoeZ3NwdmGKerkdk6sSesQC6II/bjht2Do8F1Iw35SIlHS2rSaS5az8fwfe+K66Cc+VlLnyYLmnXHa7wgvhTL7O4sF6ooltj4v9Ohia27Z0dsw2IUWJqJHdraSrOliN97o8rrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rKQ2XQka; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so42860981fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730123037; x=1730727837; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/fMezR/kOH2DQBT9AoD8Am6CVmqlmYght41fc7YQIn4=;
        b=rKQ2XQkaDJ4un3MOQMspsHzYNDzhpc4a74ydUj6O0tU1k7wUNe5tBoPpAS6gzwWVPE
         lhROiWP72QSqKWMW6jbgRkiiqFH5KomU8+OK9ttE7ZRltlJjExpLw/6lSwAlOp26kJBI
         u/fQ08jt7U4w/FueUY9kW11QPUdbBQOQRJDU2j2KHPiBSBEe9t39nU4YAqAqdbcIIBF6
         UjVoBLkcd0QUnFW7hLsLf0cBKKgYtlEvYwtS64aJEsr/7Kg1Ul4DTVenDsGU0mneC8GS
         iXGbNqFhNt4qTaPIaKKWkBJ1k4GDIa+jxjDJiWwp7z+6Lei8Y+nlk4aTsvmcvbW9dv7i
         3y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730123037; x=1730727837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fMezR/kOH2DQBT9AoD8Am6CVmqlmYght41fc7YQIn4=;
        b=oKxYs0aDV6zonUsSG4JBFsX+ke0VtadIENS8aP91aH7Xg3DJMYX8jq9d6pO8ZvhmtF
         QmfaF4KfZlIhBEpgyBZ9RtB9FdiAHAHkUzhz27PngoZOMY2iYO9tt7FTpmu/H42t1be1
         2AC+L2frw5TJL7EaH+hXHdNDeABjPfRFy3djGGg2Zk9V0pO8ubaW/kwgoehPGURzD1JD
         Lzfd0SG6DgodnurIvbWZH75I4m8d4WDoOkjjldncoBguNgDHqP8IT5wNgHdwEWjbYTEC
         3FB1e4tVDbqNfyJgH9J1O2URM0+jtIJkjShvmGexYWtNlxFKiVdOKFd759KRbFbKWa1D
         e3VA==
X-Forwarded-Encrypted: i=1; AJvYcCVqmcyBjpjSusf89aNHY7adKAQxm8MTqGRMef0VIZ79Imp1Ycv/wVwlf4K+5qx30LsIbGEBs0X2wG8KSvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpTSHRinRIEAP49gQ2QSlfyIt3XtqIWgytXsqPDQHzelcLHfZq
	8fQcRHGwuw7riNLbOc345j3QEoCn/aY7CgoHaO7dcCpm7Tj5J7paHiFH0SvTffFOG4rEZsv2FK3
	w
X-Google-Smtp-Source: AGHT+IFDCzKfy9vb0H+t7XlbkzhNd21X/z+Uek3eGFqV/jEyV6gcWxJNF6Q+5QcV2YXLsDKfxar/4Q==
X-Received: by 2002:a2e:a590:0:b0:2f6:5921:f35b with SMTP id 38308e7fff4ca-2fcbe0055ffmr39731081fa.27.1730123036398;
        Mon, 28 Oct 2024 06:43:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb4612a5asm11513551fa.122.2024.10.28.06.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:43:55 -0700 (PDT)
Date: Mon, 28 Oct 2024 15:43:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: linux@treblig.org, nouveau@lists.freedesktop.org, 
	Ben Skeggs <bskeggs@redhat.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: encoder_slave: Remove unused encoder functions
Message-ID: <im7gtswtfo6c24waourrtaoeazxuk5paeqblzig73knks735b2@dsj2svieqmur>
References: <20241025203920.244116-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025203920.244116-1-linux@treblig.org>

On Fri, Oct 25, 2024 at 09:39:20PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> drm_i2c_encoder_commit(), drm_i2c_encoder_mode_set() and
> drm_i2c_encoder_prepare() have been unused since 2016's
> commit 7bc61cc5df80 ("drm/arcpgu: Accommodate adv7511 switch to DRM
> bridge").
> 
> Remove them.
> That change makes drm_i2c_encoder_dpms() unused.
> Remove it.
> 
> Remove the comments about those functions wrapping a couple of
> pointers in drm_encoder_slave_funcs.  I can see sil164, ch7006, and nv17
> set those fields, and I can see some nouveau code that calls them
> directly; so i don't think we can remove the fields.
> (Although it's not clear to me if the sil164 or ch7006 code
> can ever get called).
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/gpu/drm/drm_encoder_slave.c | 26 --------------------------
>  include/drm/drm_encoder_slave.h     | 11 ++---------
>  2 files changed, 2 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_encoder_slave.c b/drivers/gpu/drm/drm_encoder_slave.c
> index e464429d32df..0c994a4ef9ae 100644
> --- a/drivers/gpu/drm/drm_encoder_slave.c
> +++ b/drivers/gpu/drm/drm_encoder_slave.c
> @@ -125,12 +125,6 @@ get_slave_funcs(struct drm_encoder *enc)
>  	return to_encoder_slave(enc)->slave_funcs;
>  }
>  
> -void drm_i2c_encoder_dpms(struct drm_encoder *encoder, int mode)
> -{
> -	get_slave_funcs(encoder)->dpms(encoder, mode);
> -}
> -EXPORT_SYMBOL(drm_i2c_encoder_dpms);

I think it might be better to convert nouveau to use these functions
instead of open-coding them. Another option might be to make nouveau use
normal drm_bridge interface to talk to i2c encoders and drop the custom
interface.

Ben, WDYT?

> -
>  bool drm_i2c_encoder_mode_fixup(struct drm_encoder *encoder,
>  		const struct drm_display_mode *mode,
>  		struct drm_display_mode *adjusted_mode)
> @@ -142,26 +136,6 @@ bool drm_i2c_encoder_mode_fixup(struct drm_encoder *encoder,
>  }
>  EXPORT_SYMBOL(drm_i2c_encoder_mode_fixup);
>  
> -void drm_i2c_encoder_prepare(struct drm_encoder *encoder)
> -{
> -	drm_i2c_encoder_dpms(encoder, DRM_MODE_DPMS_OFF);
> -}
> -EXPORT_SYMBOL(drm_i2c_encoder_prepare);
> -
> -void drm_i2c_encoder_commit(struct drm_encoder *encoder)
> -{
> -	drm_i2c_encoder_dpms(encoder, DRM_MODE_DPMS_ON);
> -}
> -EXPORT_SYMBOL(drm_i2c_encoder_commit);
> -
> -void drm_i2c_encoder_mode_set(struct drm_encoder *encoder,
> -		struct drm_display_mode *mode,
> -		struct drm_display_mode *adjusted_mode)
> -{
> -	get_slave_funcs(encoder)->mode_set(encoder, mode, adjusted_mode);
> -}
> -EXPORT_SYMBOL(drm_i2c_encoder_mode_set);
> -
>  enum drm_connector_status drm_i2c_encoder_detect(struct drm_encoder *encoder,
>  	    struct drm_connector *connector)
>  {
> diff --git a/include/drm/drm_encoder_slave.h b/include/drm/drm_encoder_slave.h
> index 49172166a164..3089db10b6fd 100644
> --- a/include/drm/drm_encoder_slave.h
> +++ b/include/drm/drm_encoder_slave.h
> @@ -58,8 +58,7 @@ struct drm_encoder_slave_funcs {
>  	void (*destroy)(struct drm_encoder *encoder);
>  
>  	/**
> -	 * @dpms: Analogous to &drm_encoder_helper_funcs @dpms callback. Wrapped
> -	 * by drm_i2c_encoder_dpms().
> +	 * @dpms: Analogous to &drm_encoder_helper_funcs @dpms callback.
>  	 */
>  	void (*dpms)(struct drm_encoder *encoder, int mode);
>  
> @@ -88,7 +87,7 @@ struct drm_encoder_slave_funcs {
>  			  struct drm_display_mode *mode);
>  	/**
>  	 * @mode_set: Analogous to &drm_encoder_helper_funcs @mode_set
> -	 * callback. Wrapped by drm_i2c_encoder_mode_set().
> +	 * callback.
>  	 */
>  	void (*mode_set)(struct drm_encoder *encoder,
>  			 struct drm_display_mode *mode,
> @@ -223,15 +222,9 @@ void drm_i2c_encoder_destroy(struct drm_encoder *encoder);
>   * Wrapper fxns which can be plugged in to drm_encoder_helper_funcs:
>   */
>  
> -void drm_i2c_encoder_dpms(struct drm_encoder *encoder, int mode);
>  bool drm_i2c_encoder_mode_fixup(struct drm_encoder *encoder,
>  		const struct drm_display_mode *mode,
>  		struct drm_display_mode *adjusted_mode);
> -void drm_i2c_encoder_prepare(struct drm_encoder *encoder);
> -void drm_i2c_encoder_commit(struct drm_encoder *encoder);
> -void drm_i2c_encoder_mode_set(struct drm_encoder *encoder,
> -		struct drm_display_mode *mode,
> -		struct drm_display_mode *adjusted_mode);
>  enum drm_connector_status drm_i2c_encoder_detect(struct drm_encoder *encoder,
>  	    struct drm_connector *connector);
>  void drm_i2c_encoder_save(struct drm_encoder *encoder);
> -- 
> 2.47.0
> 

-- 
With best wishes
Dmitry

