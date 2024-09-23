Return-Path: <linux-kernel+bounces-335715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A06397E987
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5E931C21801
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EB1198830;
	Mon, 23 Sep 2024 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cly3TFnQ"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9941E197A99
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086060; cv=none; b=SbOoTDUcrDElX4AeOvVTmIkgCk03k4KgCu3xEKAKBhWfWe2Np7x43Is2d/7Dpy/Z6YXo36EQ03tqZz6rnEqBuMTAutKSfFT+8Fva9uYuBo3MGhX3IqmWDQv5W7V877GwNMmvQZO3MqB5qKBOdsypZLOXrOTb6ryC/utYlF/+eGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086060; c=relaxed/simple;
	bh=rVPLPnj8h8uSerwkdTVIZhtMGVx2Pwdr/aHJ+ByL0YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgDMClFDcVFzJDfYLG8Nsm9mZMTyNNt72dNx72Znz2L9+M3tblxd6AB4Y+HSy5vrSL8VyxnxHsiMdxhFpJAyvktS/AHLo6BycO7D3xOVu4N+y3s37SbDLiUvEodyZY/a1MIoemdUMKbGuLk2QBX1mgbL+BfAafcwYM3GJPSAVxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cly3TFnQ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-536748c7e9aso4947948e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727086057; x=1727690857; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K7dtQZJAov3/a7TX9eVZXV4fMdnBS4uFPMH+c/TD/5g=;
        b=cly3TFnQbD0NlmPGdRTIWaRT+byRiSDpT7BOrfLX7DwP1BytOhOV1fDn106LcU6Lzi
         HAfSlID2Z7jCFOX+YvBVDtGlt55uX7gClTCvSJ6MG0weBm0mqiIdw+m8A/qvNaFBuk/k
         XYQAxdxlbgTM5OUs8sea8avavEC2GO8F+PUWJOgQU0h2LWFdCZq6kvx0U0ip1bmDnJoB
         BjomzoW5FqMv3xx87LB++vyBOfRfk7pSWu2PANfQFT3QkEx5n9fdHNrFcyJxNDOVGKsr
         TQq7u2FmC81jatbFgh/9tDHGGF9kp3GRma0bqCetAnTnuEXFYrK5HjCr++428MpTUyn4
         GxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727086057; x=1727690857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7dtQZJAov3/a7TX9eVZXV4fMdnBS4uFPMH+c/TD/5g=;
        b=KqO96UOWGLjJW3kzwycc8pXkFiFo5lWmP5VVbpc+1bjNBjYsZVIsg1fE2Ssv0i2c3h
         xTlhJDYviM2ctnzJMhEEZWDbsneHFh0EcZmmSol2v6UXzsgk3rO2mX9q1T3XHz5Wq0TM
         JBlU6qE8KTZjA6KzvHeU+ldOdB0K3x6XQZ0sGZrg+Kn8dLTziiKTVWkABDqyZeGLjFKQ
         Qm8fGzeEBhLO/b15PHk5EKOq2zMlLyLyYCsr5lvW65ndWeayNSEU0rZSYuIP1ykq7944
         aRbZCj1KUkC4jDaxF9Fnkvy6mWFqw6FJ/OyJgQrkzCytWlT9CWqqzSR+oy9Eb4pvI+gn
         8ZYA==
X-Forwarded-Encrypted: i=1; AJvYcCVs4BAU+Pd9P3NL1iySHrhMzM+d39F+F4iFi0G95UroKnHy39NgB6yRcck628WOWe25VG2fdFR5jT7cvh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuRizu1fT0wDCgGcr5MJZyu1iCDMppnQlxC136gsVgW0EExhHv
	zSNEnrOiVok49bkPyZ3u7wzJlN9gYiq+Cvy7aaTQceHaFSxWz/F13cOjxc5gTP8=
X-Google-Smtp-Source: AGHT+IF59Nkw7itqeJpwOtNBEGRLjgAMfimJSIEXby1vuyjxkdHTTnZhlSiDpS5TrVBpejoMzMT7Ew==
X-Received: by 2002:a05:6512:230b:b0:536:55a3:70ad with SMTP id 2adb3069b0e04-536ac2e5c5dmr5190414e87.22.1727086056657;
        Mon, 23 Sep 2024 03:07:36 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53687046847sm3262687e87.11.2024.09.23.03.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 03:07:36 -0700 (PDT)
Date: Mon, 23 Sep 2024 13:07:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Pin-yen Lin <treapking@chromium.org>, 
	Kenneth Hung <Kenneth.hung@ite.com.tw>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] drm/bridge: it6505: fix AUX read use aux fifo
Message-ID: <wub2lb7eeswh4ztvyyofb7sajcqv6fkgzjuv7fmo22ykv5jj54@locn6d4mldjs>
References: <20240923094826.13471-1-Hermes.Wu@ite.com.tw>
 <20240923094826.13471-2-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923094826.13471-2-Hermes.Wu@ite.com.tw>

On Mon, Sep 23, 2024 at 05:48:26PM GMT, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> Changes in v3:
>  -New in v3
> 
> 
> it6505 AUX FIFO mode only 16 byte.
> AUX FIFO mode only supports EDID read and DPCD KSV FIFO area.

ENOTREADABLE. It should be a text, not a set of phrases.
Also changelog comes afterwards.

> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 87b8545fccc0..d8b40ad890bf 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -300,7 +300,7 @@
>  #define MAX_CR_LEVEL 0x03
>  #define MAX_EQ_LEVEL 0x03
>  #define AUX_WAIT_TIMEOUT_MS 15
> -#define AUX_FIFO_MAX_SIZE 32
> +#define AUX_FIFO_MAX_SIZE 16
>  #define PIXEL_CLK_DELAY 1
>  #define PIXEL_CLK_INVERSE 0
>  #define ADJUST_PHASE_THRESHOLD 80000
> @@ -324,8 +324,13 @@ enum aux_cmd_type {
>  	CMD_AUX_NATIVE_READ = 0x0,
>  	CMD_AUX_NATIVE_WRITE = 0x5,
>  	CMD_AUX_I2C_EDID_READ = 0xB,
> +
> +	/* KSV list read using AUX native read with FIFO */
> +	CMD_AUX_GET_KSV_LIST = 0x10,

Don't mix two changes in a single patch. There should be one patch
fixing FIFO_MAX_SIDE (and then it should have Fixes tag) and another
patch adding CMD_AUX_GET_KSV_LIST. I keep on pointing to
Documenation/process/submitting-patches.rst, which you didn't seem to
have read. Please do it first. Ask any questions if you don't understand
something.

>  };
>  
> +#define GET_AUX_CONTROL_CODE(cmd) ((cmd) & 0x0F)
> +
>  enum aux_cmd_reply {
>  	REPLY_ACK,
>  	REPLY_NACK,
> @@ -965,7 +970,8 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
>  	it6505_set_bits(it6505, REG_AUX_CTRL, AUX_USER_MODE, AUX_USER_MODE);
>  
>  aux_op_start:
> -	if (cmd == CMD_AUX_I2C_EDID_READ) {
> +	/* HW AUX FIFO supports only EDID and DCPD KSV FIFO aread */
> +	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
>  		/* AUX EDID FIFO has max length of AUX_FIFO_MAX_SIZE bytes. */
>  		size = min_t(size_t, size, AUX_FIFO_MAX_SIZE);
>  		/* Enable AUX FIFO read back and clear FIFO */
> @@ -996,7 +1002,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
>  				  size);
>  
>  	/* Aux Fire */
> -	it6505_write(it6505, REG_AUX_CMD_REQ, cmd);
> +	it6505_write(it6505, REG_AUX_CMD_REQ, GET_AUX_CONTROL_CODE(cmd));

Looks like a separate fix.

>  
>  	ret = it6505_aux_wait(it6505);
>  	if (ret < 0)
> @@ -1030,7 +1036,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
>  		goto aux_op_start;
>  	}
>  
> -	if (cmd == CMD_AUX_I2C_EDID_READ) {
> +	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
>  		for (i = 0; i < size; i++) {
>  			ret = it6505_read(it6505, REG_AUX_DATA_FIFO);
>  			if (ret < 0)
> @@ -1055,7 +1061,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
>  	ret = i;
>  
>  aux_op_err:
> -	if (cmd == CMD_AUX_I2C_EDID_READ) {
> +	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
>  		/* clear AUX FIFO */
>  		it6505_set_bits(it6505, REG_AUX_CTRL,
>  				AUX_EN_FIFO_READ | CLR_EDID_FIFO,
> @@ -1078,8 +1084,11 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
>  	int i, ret_size, ret = 0, request_size;
>  
>  	mutex_lock(&it6505->aux_lock);
> -	for (i = 0; i < size; i += 4) {
> -		request_size = min((int)size - i, 4);
> +	for (i = 0; i < size; ) {
> +		if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST)
> +			request_size = min_t(int, (int)size - i, AUX_FIFO_MAX_SIZE);
> +		else
> +			request_size = min_t(int, (int)size - i, 4);

And this one is also separate.

>  		ret_size = it6505_aux_operation(it6505, cmd, address + i,
>  						buffer + i, request_size,
>  						reply);
> @@ -1088,6 +1097,7 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
>  			goto aux_op_err;
>  		}
>  
> +		i += request_size;
>  		ret += ret_size;
>  	}
>  
> @@ -2257,7 +2267,6 @@ static void it6505_link_training_work(struct work_struct *work)
>  		it6505->auto_train_retry--;
>  		it6505_dump(it6505);
>  	}
> -

And this is just a noise. Leave it as it is until somebody has to touch
these lines.

>  }
>  
>  static void it6505_plugged_status_to_codec(struct it6505 *it6505)
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

