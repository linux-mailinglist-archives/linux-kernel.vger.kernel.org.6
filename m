Return-Path: <linux-kernel+bounces-215360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDA990919A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E67B2409E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C80B1A0B04;
	Fri, 14 Jun 2024 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZWXR3Xo"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD08319AD48
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386353; cv=none; b=fQ9YYuqWla7KHcMxGssH+dYsEH6bLc2cqiAUx0zSHXXkEFxiXLN+oNimrHXPxaLRI+cFRlTPueBZxCYnNq7k9kJg/SIq9Pib1ShAjtCJbRTHLnSrOlTFhQmDwF3T31/oHkJIdq6dB9Ga6nCGB+DOcEIV37L4lbtmf+5dEoreDUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386353; c=relaxed/simple;
	bh=Fyx4oZXYXOt7r5Bmb0RLqriW4Wv4h4xJOeKr4CmCXf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwUFno+v15fRIlbfBpdjgKJFLosFU2DXMsSoMQrsYj8ELkd/3QJCX1GjiM1VnpJkztNDyMmq/4kOO9wwwlt7egtI5e4FjriTJYM912b+Lr3nDcfii59a86Aq6rVLRytw6z3CCDmbE3NWLuUwKZfxyaCDXjm10OWB0CDsBm3jGVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bZWXR3Xo; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ec002caf3eso40268301fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718386350; x=1718991150; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aesDOEiRaG9Aa3dzWhXp6jZ8a3i1f0OGXi6kYr7Lp3g=;
        b=bZWXR3XoxcBYX2qbpkUlX6hYdeLu6aDU0xDCpZU3VQhA1ZWugr0ArTmPA49w3NZ8DJ
         5HykVNTGAKZMuQDgL5/tpZWnNMR/nQPaszPfxaZB56hFEb/LQ0HTRRJhuncB7t76Pn/F
         beGT8c2mt35SkyAp4/HPcUssNMwpcQtkQGPOSpGOzTMPjASldWFmznZL2J/ALZoo0UWm
         j9nwZFcbFVd/ptGQ3sTKe8lGIoJlL3k/+yRYtAT1Bs25+dP4Yaa0Uc/6d1LEMPXyIikz
         9z5cx7s0afJoZTMQcYw5e55tOep1lupWuJfF3bbmG8LZJmjHtkht7FgN9RV/w8kcjzYE
         vq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718386350; x=1718991150;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aesDOEiRaG9Aa3dzWhXp6jZ8a3i1f0OGXi6kYr7Lp3g=;
        b=Squg33nYPFQH2jVrw/QKDvdHHe75bPSHY3ra54ptCJ9hHgyBis3POwmg+bBui+uw01
         16J2QBb6ySv3GjvlLnHjVAyknHicZIlKRUst9kBjcXknA9z4vVRqT7GbzWgg6cxHOpMH
         PlyblFR8GPZdP1ALPgNFu17l44zyKn3rs9CmVFqvlzEJVrG+x7+Xh0EfZbP1T4H0PUPi
         FwlFJ+CQdae+v0y7GeuwTyt25oDslOiswE2XP8jC55H6gIVkuoEaLKnfXFYJ6cmiXOV7
         tds7TPK3TcohwLCN+z5+H0ieYlsO/xJk1olGAgOlnSbb6y3gPrI02fP9ma88CY3ZsjiO
         ynEA==
X-Forwarded-Encrypted: i=1; AJvYcCVGMaPQ+xLQDaZN2/fwAz77BM4UGYT87pOnEoXHEhtnErAJrKteNFTdWWo3mZco7fRB+PFVQvt2vfPCeD0JoPymbTiyWF/NoOffyhsi
X-Gm-Message-State: AOJu0YzDJgNsT/nsvvdiS7pJIQwhjPch43ODZ96OH5i+/CNTTITZEsJ7
	ZKOp3xZe7w68Ci3FycjEQ8qJqvYVefHHv5tkg9czj/HH5f+NlxefjV5MxY26rBQ=
X-Google-Smtp-Source: AGHT+IGLrcrZDaWk6pfDosOul/t/KBqIO2jt9kIWRmffUF1VJ4nmfE1a3L0RBgRcNwyxpKBRaxNgSA==
X-Received: by 2002:a2e:8681:0:b0:2ec:18bc:c455 with SMTP id 38308e7fff4ca-2ec18bcc6a3mr19931571fa.10.1718386349908;
        Fri, 14 Jun 2024 10:32:29 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05d08470sm5669821fa.60.2024.06.14.10.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 10:32:29 -0700 (PDT)
Date: Fri, 14 Jun 2024 20:32:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, kernel-dev@igalia.com, 
	Melissa Wen <mwen@igalia.com>, alexander.deucher@amd.com, christian.koenig@amd.com, 
	Simon Ser <contact@emersion.fr>, Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch, 
	Daniel Stone <daniel@fooishbar.org>, 'Marek =?utf-8?B?T2zFocOhayc=?= <maraeo@gmail.com>, 
	Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com, Xaver Hugl <xaver.hugl@gmail.com>, 
	Joshua Ashton <joshua@froggi.es>, Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Boris Brezillon <bbrezillon@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH v6 2/8] drm: Support per-plane async flip configuration
Message-ID: <ycgax5ulfcdho2ocrqhzwuvrtwjkwuzi4ghnutl72e5ye3wkxf@ajirwgg7ozwp>
References: <20240614153535.351689-1-andrealmeid@igalia.com>
 <20240614153535.351689-3-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614153535.351689-3-andrealmeid@igalia.com>

On Fri, Jun 14, 2024 at 12:35:29PM GMT, André Almeida wrote:
> Drivers have different capabilities on what plane types they can or
> cannot perform async flips. Create a plane::async_flip field so each
> driver can choose which planes they allow doing async flips.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 4 ++--
>  include/drm/drm_plane.h           | 5 +++++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 2e1d9391febe..ed1af3455477 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1079,9 +1079,9 @@ int drm_atomic_set_property(struct drm_atomic_state *state,
>  			break;
>  		}
>  
> -		if (async_flip && plane_state->plane->type != DRM_PLANE_TYPE_PRIMARY) {
> +		if (async_flip && !plane->async_flip) {

So, after this patch async flips becomes disabled until the driver
enables that manually. Whether that's desired or not is a separate
topic, but this definitely should be explicitly mentioned in the commit
message.

>  			drm_dbg_atomic(prop->dev,
> -				       "[OBJECT:%d] Only primary planes can be changed during async flip\n",
> +				       "[PLANE:%d] does not support async flips\n",
>  				       obj->id);
>  			ret = -EINVAL;
>  			break;
> diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> index 9507542121fa..0bebc72af5c3 100644
> --- a/include/drm/drm_plane.h
> +++ b/include/drm/drm_plane.h
> @@ -786,6 +786,11 @@ struct drm_plane {
>  	 * @kmsg_panic: Used to register a panic notifier for this plane
>  	 */
>  	struct kmsg_dumper kmsg_panic;
> +
> +	/**
> +	 * @async_flip: indicates if a plane can do async flips
> +	 */
> +	bool async_flip;
>  };
>  
>  #define obj_to_plane(x) container_of(x, struct drm_plane, base)
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

