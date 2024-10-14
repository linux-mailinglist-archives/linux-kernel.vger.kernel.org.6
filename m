Return-Path: <linux-kernel+bounces-363989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F27E99C96F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3266E1C2157E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E70919E98B;
	Mon, 14 Oct 2024 11:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eH/HXgZb"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F4519340F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906771; cv=none; b=FjGjK+2ruJhJied5tHdptJeOcudrSc7QbvYkUjUtvV/+80d/PRYaf7kRIUNyErPJ8GeVduxXbSiErPj7Xwn9/mIP6B2ZoppCJNBrSMgkPDh6Kcb5Srks1ycrUWsdagx6Ygdx8Pk6YymzhrWGs9pFdgzbYdnlCIZv6XpwV4mvLiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906771; c=relaxed/simple;
	bh=Ea+mqTjEURNHHEAwyekm0Gan3YTWCmqnZhSkTvou0Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVSHepNsr5THfD77NyZx3T1Nk4gkxsLVvaGoJovXAf27wvRDNs3MfmzXL77nbGChjSCBpBCnl2S6IkLtKsBDhUN39pS2QbWcBhb0VlriBuOncxInh8vjQqHTGeZEs9iQsWvR8YzbL0SdSW4kGEJb2UUDIRc1p48HUMF4AzAkqZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eH/HXgZb; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso7305001fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728906768; x=1729511568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FasUY+27JFwaZjFeTC/WhRBPBBVBy6YfkzShBDyclc0=;
        b=eH/HXgZbfQbbLjS77K395ReeUszx+ABiWjlumJpwYcXXTUzA1vB9tfVEgK1+VgVZmi
         twnn4lm7A1rw0R6/6dVTIqorD7d2UfIUQwVx/ENFu4SVhYDcAyEDIi+9tazJjjEMHP4D
         w4FxHyTze68WYAVtbsX0MA69q39N65kcrp0pr4kPVSEr9CfsZ2SD5FQsR41UIyaGgqse
         toEDQckCYwouVndsCO1NmvWhRbSCxRgcmhykZ4PlsuOPi7tuiWpIptYEsUkgSbhMWqRy
         XIjxzmK68IIH9z54gxjE4LxousmH/Qg6F/h9b4sfDSjCtcQ75kXBGqFyrpMyA9wN6pSa
         6KlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728906768; x=1729511568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FasUY+27JFwaZjFeTC/WhRBPBBVBy6YfkzShBDyclc0=;
        b=IDFHPUdPKsjUrNlQJSr6wvZHY8VFNQp2rp1QkL8AVXNF35neu9sp9qzBOp1xUhSxDR
         VOb4btD7U04bqqjkQYZmnkpw82BHZXsAOkhtwBjfCyCBsnrYxJkr8H0+x7Vq6tSYOWgy
         sE+zHxLEw8er9Oju3c120U8MKqR83GBm9NCUEhMs3IIRXniMDe7vX4mNNOjrnG4T0v27
         v7/GXkb1zODIyZrMSt8uTEi7ZX3O8gxzsNZERcGKdRwNQAKw9cCJMnkwvqsGMHLYpJw5
         F/pjR5pMoaenNKXE9770OoeChRzyJTk4sNRfsH0RXrk7xkNwsP7iQUsyzuBe4iLhGCn9
         Z+Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ/HHBFA/QDGPM8E18geYIfFkkacZhXNqnbEW/pXEXDNLxglEvxP3T0UAA4crdfO8ghHMH862vLhb42M8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgag/qqkXHIM1uITYeK69NZO7CkVWAMq/mVOEwuoOmk/+c7q2q
	JGMd04OF+HCQxOR0rNKWeUNMz9naLznd6ae2io9XAu09BGsXMoXGLf73NIPRHVs=
X-Google-Smtp-Source: AGHT+IHvOIGeABb4m0MJqsfhsfRK0zmSYZ2zkqLdCAdpl0opDqTIu+xf0BdvG/swZBDSwYCHy0q1Ag==
X-Received: by 2002:a05:651c:211b:b0:2fb:5786:251f with SMTP id 38308e7fff4ca-2fb57862748mr7762271fa.37.1728906767868;
        Mon, 14 Oct 2024 04:52:47 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb24706343sm14556531fa.77.2024.10.14.04.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 04:52:46 -0700 (PDT)
Date: Mon, 14 Oct 2024 14:52:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Pin-yen Lin <treapking@chromium.org>, 
	Kenneth Hung <Kenneth.hung@ite.com.tw>, Pet Weng <Pet.Weng@ite.com.tw>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 03/10] drm/bridge: it6505: add AUX operation for HDCP
 KSV list read
Message-ID: <2nceoodtqfspaxs5ipmrezivknexqwi4yc4mr4lak6yjgowpz5@evhz3vy45lb4>
References: <20241001064305.32180-1-Hermes.Wu@ite.com.tw>
 <20241001064305.32180-4-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001064305.32180-4-Hermes.Wu@ite.com.tw>

On Tue, Oct 01, 2024 at 02:43:02PM +0800, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> HDCP KSV list readback can choose to use AUX FIFO or general data register.
> For some DisplayPort devices, the KSV list must be read in 5 byte boundaries.
> The original AUX read command does not support these devices.
> 
> The AUX command operation control register "REG_AUX_CMD_REQ" uses b[3:0] as AUX operacion control, and b[7:4] are status bits and read only.
> To change KSV read operation uses "CMD_AUX_NATIVE_READ" from using the data registers to using AUX FIFO.
> The extended command "CMD_AUX_GET_KSV_LIST" is added as "CMD_AUX_NATIVE_READ" with the 0x10 flag which selects AUX FIFO mode.

Please keep the commit message wrapped at 72-75 chars.

Other than that:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 864fab7e388f..9a022c095af4 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -126,6 +126,7 @@
>  #define REG_AUX_OUT_DATA0 0x27
>  
>  #define REG_AUX_CMD_REQ 0x2B
> +#define M_AUX_REQ_CMD 0x0F
>  #define AUX_BUSY BIT(5)
>  
>  #define REG_AUX_DATA_0_7 0x2C
> @@ -324,6 +325,9 @@ enum aux_cmd_type {
>  	CMD_AUX_NATIVE_READ = 0x0,
>  	CMD_AUX_NATIVE_WRITE = 0x5,
>  	CMD_AUX_I2C_EDID_READ = 0xB,
> +
> +	/* KSV read with AUX FIFO extend from CMD_AUX_NATIVE_READ*/
> +	CMD_AUX_GET_KSV_LIST = 0x10,
>  };
>  
>  enum aux_cmd_reply {
> @@ -965,7 +969,8 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
>  	it6505_set_bits(it6505, REG_AUX_CTRL, AUX_USER_MODE, AUX_USER_MODE);
>  
>  aux_op_start:
> -	if (cmd == CMD_AUX_I2C_EDID_READ) {
> +	/* HW AUX FIFO supports only EDID and DCPD KSV FIFO area */
> +	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
>  		/* AUX EDID FIFO has max length of AUX_FIFO_MAX_SIZE bytes. */
>  		size = min_t(size_t, size, AUX_FIFO_MAX_SIZE);
>  		/* Enable AUX FIFO read back and clear FIFO */
> @@ -996,7 +1001,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
>  				  size);
>  
>  	/* Aux Fire */
> -	it6505_write(it6505, REG_AUX_CMD_REQ, cmd);
> +	it6505_write(it6505, REG_AUX_CMD_REQ, FIELD_GET(M_AUX_REQ_CMD, cmd));
>  
>  	ret = it6505_aux_wait(it6505);
>  	if (ret < 0)
> @@ -1030,7 +1035,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
>  		goto aux_op_start;
>  	}
>  
> -	if (cmd == CMD_AUX_I2C_EDID_READ) {
> +	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
>  		for (i = 0; i < size; i++) {
>  			ret = it6505_read(it6505, REG_AUX_DATA_FIFO);
>  			if (ret < 0)
> @@ -1055,7 +1060,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
>  	ret = i;
>  
>  aux_op_err:
> -	if (cmd == CMD_AUX_I2C_EDID_READ) {
> +	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
>  		/* clear AUX FIFO */
>  		it6505_set_bits(it6505, REG_AUX_CTRL,
>  				AUX_EN_FIFO_READ | CLR_EDID_FIFO,
> @@ -1076,7 +1081,8 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
>  				      size_t size, enum aux_cmd_reply *reply)
>  {
>  	int i, ret_size, ret = 0, request_size;
> -	int fifo_max_size = (cmd == CMD_AUX_I2C_EDID_READ) ? AUX_FIFO_MAX_SIZE : 4;
> +	int fifo_max_size = (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) ?
> +						 AUX_FIFO_MAX_SIZE : 4;
>  
>  	mutex_lock(&it6505->aux_lock);
>  	i = 0;
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

