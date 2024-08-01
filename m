Return-Path: <linux-kernel+bounces-271801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EB094535C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491821C227B3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DCC14A0B5;
	Thu,  1 Aug 2024 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="TG6p96hA"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFBE1494A4;
	Thu,  1 Aug 2024 19:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722540379; cv=none; b=RLySsFdg2aSMKacQGFsmsk2kcUUrpfbtstP8aqlFSg50M2acCvHQI2EF7a0bmLQQ45GS4VhIlML90xKLVsg4BV85nmNTCFjPXU+HBW48+Jpx6leS3XsL0zEtR+5xt1AvsnE5AFLEwakKaZ8LFbSysYPJJvnYXUH4mX8FC90LsD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722540379; c=relaxed/simple;
	bh=dkvMjFVxxMHIOANC63SZnO280hCKkn3NfceRY503oSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJMFN8QpAUEfhkGUj1podK7EA639UlMqG9Q5BFJk256/ERrTuJsA8kGE6w1DwECPHDyo3po+7jRiYhhcpJGR65XchvYrRBYKKE0ywvKcOsMfIuLPgyFspipKGg8EHaS9SydsW+HMNwgV0JQBCK6Rbyq+0jhFzJY2CVtf6gx/A38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=TG6p96hA; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-65f9e25fffaso61972017b3.3;
        Thu, 01 Aug 2024 12:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722540376; x=1723145176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J11Qeaovp3vBvB3ONtJpOHTf7WqBZrsPZ1ubWHsWNyk=;
        b=odmsLRfS1d9FeXl5U1irDYhzRZe5x8kD0YJwSUPW9vapWKe8bWBSc0styMUsuNWaUr
         jegik/sJo+LFIECu8HsAl8rTRzf8QlfnelMjujlNekDx4Q9kphE7qjOFT887MMa53Mzh
         +4/+LU28yVkY7zR41Qt6VHDp86Vb5OIjHcywcMQ4EJ1Aj/B2oilYz+JkTJeijM1QZxgG
         Yr9YfCWM/APz+RrnTuS6uQY7ApNFy417+0KKr+d+dRHtZvnKUkmhDCdgpG/j2JaqjNWR
         f7FYTj6IJrF5ptHBNFnRLsAXod7u1enaDqIfcnd3OOK0+0DZaAayO5+HKW7UCyoG/mj2
         g4Mg==
X-Forwarded-Encrypted: i=1; AJvYcCV01WI0LDC0LWfEmSvt8/q9XZUGlOPAfCc5mPuxG+ENg6TKn3qp1QoWkXN+jXC+wKHpc/vFaGpq9liYQ4tYvCl186QOgzErQc0XDLNUTe2ZcnE1vEyzELPuNOrzHOwiECTaImGg/0Gw
X-Gm-Message-State: AOJu0YwzKUYzmuQsKZzKxBu/shbBg8i0dH7D3eiF0J55Ph0yR8UVlRc7
	CW8Yh4lwOEtDt2dxl1BWGqoAa4IIr/rJpIaTWhFPBvYZK3p+4tNK
X-Google-Smtp-Source: AGHT+IFgm/r0gFw762FxN6KiDtlRPxI8lDZNAbuJzw0YhbEGOjqYe15+yTqGcwQUfNsMHuNr8hvtTQ==
X-Received: by 2002:a81:ab4e:0:b0:650:9fb3:959f with SMTP id 00721157ae682-68963bda7ccmr13502257b3.40.1722540376526;
        Thu, 01 Aug 2024 12:26:16 -0700 (PDT)
Received: from mail.marliere.net ([2604:a880:4:1d0::7f5:6000])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-689b3bed53asm523967b3.114.2024.08.01.12.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 12:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marliere.net; s=2024;
	t=1722540374; bh=dkvMjFVxxMHIOANC63SZnO280hCKkn3NfceRY503oSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TG6p96hAdlZZDwvQbpmBWM9PfSOAqNMI/BSFfeQhQOiyOMcKghDVtzLKmhEd5Z+DM
	 dO8Z377PoCwUIT5sUBqC66k8lRw7Oq74hTuK4mE7vXVcWEWnTwNCmR2foqE1TrFhSs
	 yELW6Z0glhqhw1IMUhRGJ5okp6tytayE2zlMbhDC/q+RUX+TooJaH8Voj0FdDQPNN+
	 4E7TugdZIZeVa+f2WfEYZ9hz6jvTa/2ylMaF61dgZRPkL/x42IUl+kfKpIZ+B0HhdT
	 elyp9z6eYnbW3tUjEk5GlJWFZvgwKYzqUkzvy0eKlP1OJjhVIKm/nS7YMWlq2IcbhS
	 rolgL6TrxjW/w==
Date: Thu, 1 Aug 2024 16:26:10 -0300
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: gregkh@linuxfoundation.org, skhan@linuxfoundation.org, 
	dan.carpenter@linaro.org, rbmarliere@gmail.com, christophe.jaillet@wanadoo.fr, 
	Chris.Wulff@biamp.com, linux-kernel-mentees@lists.linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: u_audio: Use C99 syntax for array
 initializers
Message-ID: <4866acc8-e86e-4861-8430-4653d8fa5041@marliere.net>
References: <20240801190209.500373-1-abhishektamboli9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801190209.500373-1-abhishektamboli9@gmail.com>

On  2 Aug 24 00:32, Abhishek Tamboli wrote:
> Convert array initializers to C99 syntax by adding the '=' after
> each designated initializer.
> 
> Fix the following smatch warnings:
> 
> drivers/usb/gadget/function/u_audio.c:1117:20:
> warning: obsolete array initializer, use C99 syntax
> drivers/usb/gadget/function/u_audio.c:1124:28:
> warning: obsolete array initializer, use C99 syntax
> drivers/usb/gadget/function/u_audio.c:1131:19:
> warning: obsolete array initializer, use C99 syntax
> drivers/usb/gadget/function/u_audio.c:1138:27:
> warning: obsolete array initializer, use C99 syntax
> drivers/usb/gadget/function/u_audio.c:1145:25:
> warning: obsolete array initializer, use C99 syntax
> 
> Also, fix two checkpatch.pl warnings:
> 
> WARNING: please, no spaces at the start of a line
> +  [UAC_FBACK_CTRL] = {$
> 
> WARNING: please, no spaces at the start of a line
> +  [UAC_MUTE_CTRL] = {$
> 
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>

Reviewed-by: Ricardo B. Marliere <ricardo@marliere.net>

> ---
> Changes in v2:
> - Wrapped commit log to 75 columns
> - Fix checkpatch.pl warnings
> 
>  drivers/usb/gadget/function/u_audio.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
> index 89af0feb7512..0b3b8adf00c0 100644
> --- a/drivers/usb/gadget/function/u_audio.c
> +++ b/drivers/usb/gadget/function/u_audio.c
> @@ -1114,35 +1114,35 @@ static int u_audio_rate_get(struct snd_kcontrol *kcontrol,
>  }
> 
>  static struct snd_kcontrol_new u_audio_controls[]  = {
> -  [UAC_FBACK_CTRL] {
> +	[UAC_FBACK_CTRL] = {
>      .iface =        SNDRV_CTL_ELEM_IFACE_PCM,
>      .name =         "Capture Pitch 1000000",
>      .info =         u_audio_pitch_info,
>      .get =          u_audio_pitch_get,
>      .put =          u_audio_pitch_put,
>    },
> -	[UAC_P_PITCH_CTRL] {
> +	[UAC_P_PITCH_CTRL] = {
>  		.iface =        SNDRV_CTL_ELEM_IFACE_PCM,
>  		.name =         "Playback Pitch 1000000",
>  		.info =         u_audio_pitch_info,
>  		.get =          u_audio_pitch_get,
>  		.put =          u_audio_pitch_put,
>  	},
> -  [UAC_MUTE_CTRL] {
> +	[UAC_MUTE_CTRL] = {
>  		.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
>  		.name =		"", /* will be filled later */
>  		.info =		u_audio_mute_info,
>  		.get =		u_audio_mute_get,
>  		.put =		u_audio_mute_put,
>  	},
> -	[UAC_VOLUME_CTRL] {
> +	[UAC_VOLUME_CTRL] = {
>  		.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
>  		.name =		"", /* will be filled later */
>  		.info =		u_audio_volume_info,
>  		.get =		u_audio_volume_get,
>  		.put =		u_audio_volume_put,
>  	},
> -	[UAC_RATE_CTRL] {
> +	[UAC_RATE_CTRL] = {
>  		.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
>  		.name =		"", /* will be filled later */
>  		.access =	SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
> --
> 2.34.1
> 
> 

