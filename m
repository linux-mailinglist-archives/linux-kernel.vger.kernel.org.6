Return-Path: <linux-kernel+bounces-548119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AE6A54040
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 03:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035F0189127E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065A218C930;
	Thu,  6 Mar 2025 02:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wz6R0vb3"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72491BE46
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 02:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741226790; cv=none; b=HPjCMiyv1xdHyqWydGY6oxi/CNe7WYGXNhdwzOYCLJ+zjSx7ju/jEgYmFijkT4MBZUrAQcSL5wr5UaImEHbINtXnS4aMcXKD9sd0Tw6HjERGxGUZzf4p3laBJ2aX0SF1NvUMsUw0V3IcQdvNu0IGfBxgatxmo1FZ2G3tHCWxTNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741226790; c=relaxed/simple;
	bh=+BcOWd+eKkUGYlUjOMq2ynW3kiA0RuDGuslOf3cowCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXpmHcXBEQc/7awZ/5/LKe9a2BHauzJzY5IjHw7gHDUl6fGwXkuqAkTdHn4ArL7oZV2t5lOwX66Xf1gN9KfGpUX0IFeuRokcrvFwWCeW5YOw4MYjya1YSyC9phKjG6Smrf7JJXTZAwBu9I7Sg9Qg8K2Mt3CCySDMVVAMNP9Q/BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wz6R0vb3; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54943bb8006so183770e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 18:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741226786; x=1741831586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oxbxNY786YrsKRIbDHKdRfexTZ85j7EEsRpteNUREfI=;
        b=wz6R0vb3xMS8gAjs0EfBz/IybrNHKPPC47CkZk1mgO5VcrXAImJ7vjDLBB7mhf7MLd
         TVF+udmKiPJ/nf3kcAUDTFeZkE4dQnoudayN1tXzVhLz0eK7Mh2PHlxDyKT4sptz3K9x
         qssEp9vvxJzR5OxxPNM0DfHAg4KcWj5EXFQJNIho1E8RyQkDxQPJxGhCMyFjqwhRg2A5
         xsxnU6zWpj8OOeos+Ru7RRSaNr8KxNCSR1wNxC88Zb+VW4PEbnlBcFMydz9VvJAVM5pP
         B0DHrTrmAt/cCDgvbPxVVFw27TpNIFE8Y1IbnRBiDEE0G9QGQSIcP3zLq8uSUopMk5mH
         PJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741226786; x=1741831586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxbxNY786YrsKRIbDHKdRfexTZ85j7EEsRpteNUREfI=;
        b=YL3WgfKOXq2QND8vbLhPV3P1vKSxqFqxJpVmdjAekifMfHy/d5ojdYqcT98F4GDXze
         EYpXfMiUl0laOEBJkTXp7XhxW2elRjPwST0VvlWvsoNboX0xJDkczXC1acDIK68IZuZR
         wmmG5WlKb6S+rTsh+ETwSorlsvcmePvT8sNqez5gJxhPnSK0Ut1ks0rOCNlTZtlucmsu
         d394WYXFI2d0Mw9g/o1ro6vTPoLjtEUecx91Rn+bst4zwbUuc4Xx8e82Rl221ABv/5za
         HwjFuihCCTyoLHXdvTIQw9E6cB4LtrU6fnCQygxYBXR/sibW5QEH4iwdXkcIhaicshIb
         swAw==
X-Forwarded-Encrypted: i=1; AJvYcCVBufFVq5Chfc0t3BiS61wJw1EWw+2RyyZ5iA/eHoPCX6yly8vX/7We/cLuZrt/CSA7OU5Pn7eNERDG8ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEMLctAcEl2DHrrJaeyd3xtm531YI/2e7ht7a9U/D7izhUIh6b
	0hOZN4V1vynbpo9ZGMyEkI1gfZWopCR0PceKlq1RDXbmnh3S/HXp16waI/FF9c4=
X-Gm-Gg: ASbGncvbMdmnOqTAR5JBFRFvWLiplnMyBjLWN9N6qMHV+0bgi36lOdTM4CgV7peKwzF
	j4zOX4GA/5jaCjTx6P7bfkMj8+jMYnkNqHNDeRMBUNNkgS8U4D+j5oN/5HpK57NRgLaN9ctD+87
	6Iz54094cD52EGqH2pZlunR/tjwN5y+sEZcA77thQj4Jr57KC40+I7oFoAQXP00F5acJhkUXZFY
	PlDkvshQ/ttAZVAtIdkyHyPjnCQJ3Q31cv1Fbftr7D1dWVZw9Q7CsChqL6/FutR699yu4cjlnrC
	7HDI8Mnx7E6ane4EqGnarAIeevMUilOhlkyEIxMqeaeQ8wWdfqdUz3Ox1vPJM9UWuesK7PVfnqA
	i+keWEYm3chummUljdFXBjMr1
X-Google-Smtp-Source: AGHT+IHWHRcySCxYc1B0y6PhF0rI3/lSPzlG5f7R9rUTKQMeZ07z2qQaZyArRoFRqnnRWxqa+VOdOg==
X-Received: by 2002:a05:6512:1386:b0:545:81b:1510 with SMTP id 2adb3069b0e04-5497d32f4ffmr1641136e87.2.1741226786379;
        Wed, 05 Mar 2025 18:06:26 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b0bcf30sm27665e87.115.2025.03.05.18.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 18:06:24 -0800 (PST)
Date: Thu, 6 Mar 2025 04:06:22 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Tejas Vipin <tejasvipin76@gmail.com>, Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] drm/panel/synaptics-r63353: Use _multi variants
Message-ID: <sbimsyq2xrcxpp2ha2vequtwfl5bss7clw2snkqsbgitosnkub@it35hzscp3jc>
References: <20250305-mipi-synaptic-1-v1-1-92017cd19ef6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305-mipi-synaptic-1-v1-1-92017cd19ef6@redhat.com>

On Wed, Mar 05, 2025 at 07:01:41PM -0500, Anusha Srivatsa wrote:
> Move away from using deprecated API and use _multi
> variants if available. Use mipi_dsi_msleep()
> and mipi_dsi_usleep_range() instead of msleep()
> and usleep_range() respectively.
> 
> Used Coccinelle to find the multiple occurences.
> SmPl patch:
> @rule@
> identifier dsi_var;
> identifier r;
> identifier func;
> type t;
> position p;
> expression dsi_device;
> expression list es;
> @@
> t func(...) {
> ...
> struct mipi_dsi_device *dsi_var = dsi_device;
> +struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var };
> <+...
> (
> -mipi_dsi_dcs_write_seq(dsi_var,es)@p;
> +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
> |
> -mipi_dsi_generic_write_seq(dsi_var,es)@p;
> +mipi_dsi_generic_write_seq_multi(&dsi_ctx,es);
> |
> -mipi_dsi_generic_write(dsi_var,es)@p;
> +mipi_dsi_generic_write_multi(&dsi_ctx,es);
> |
> -r = mipi_dsi_dcs_nop(dsi_var)@p;
> +mipi_dsi_dcs_nop_multi(&dsi_ctx);
> |
> ....rest of API
> ..
> )
> -if(r < 0) {
> -...
> -}
> ...+>
> 
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Tejas Vipin <tejasvipin76@gmail.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> ---
> Previous attempt for this change was addressed in:[1]
> The series did not handle returns properly and still
> used msleep() and usleep_range() API.
> It also collided with an Tejas's similar efforts.
> 
> Will be sending the patches per driver instead of
> major haul of changes.
> 
> Following [2] for reference.
> 
> [1] -> https://patchwork.freedesktop.org/series/144824/
> [2] -> https://lore.kernel.org/dri-devel/20250220045721.145905-1-tejasvipin76@gmail.com/#iZ31drivers:gpu:drm:panel:panel-sony-td4353-jdi.c
> ---
>  drivers/gpu/drm/panel/panel-synaptics-r63353.c | 64 +++++++-------------------
>  1 file changed, 17 insertions(+), 47 deletions(-)
> 
>  
> -	ret = mipi_dsi_dcs_set_display_on(dsi);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to set display ON (%d)\n", ret);
> -		goto fail;
> -	}
> -
> -	return 0;
> +	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
>  
> -fail:
> -	gpiod_set_value(rpanel->reset_gpio, 0);
> +	return dsi_ctx.accum_err;

You've lost panel reset in case of an error. The rest LGTM.

>  
> -	return ret;
>  }
>  
>  static int r63353_panel_prepare(struct drm_panel *panel)

-- 
With best wishes
Dmitry

