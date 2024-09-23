Return-Path: <linux-kernel+bounces-334446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CA497D769
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D901F23F18
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E52156F2B;
	Fri, 20 Sep 2024 15:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wrww4slo"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57F8C13B
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726845957; cv=none; b=CYNTdh51+BmqpLO0PxWdJ950zhcFSwrTtm7EvZJsVhVPEjVwaWFw0uzOrXb3bkezQJwFStDem7qESPXZNLNUPCxVZnCXYWWFIQOVSAkTsN++go3gehT0yeS5vHSioDfkQgmO+mMOzb7PLnLb9t4HfFF+5HzTu18t1fgJAF/wVaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726845957; c=relaxed/simple;
	bh=t8CqPMLnSQlsI0RHzLxrbamU8pvfgnfHvlt60BvUr/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPUmAoATwXRrOGwY3qTLWmo2DYOrEz/nGYBebJAh0PIZQBCXrm0YLu+7e9Hfo85g5ciF99Y2DY5b5GXKukOAPpfSu57NpPs0BvId48sB2BYkPuEMYlWtBIHD0L/RorFJCznTGdKGmd0x56bYdWPbwwHsu1I9QsJKWnfLaqxgrvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wrww4slo; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5365b71a6bdso2630335e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726845953; x=1727450753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HKGVOuHkkDFpeTWe9o2N7pUq8VYne2cI4fc0+if+jh8=;
        b=wrww4sloG7uPKqNGvRbO1L9qZk3wf1rZlVkRYS9D1SnOQ6E8AuGXWyaaQGTKo9T9hT
         yOokmS3alR9A17JppjKvWvslRAVyFHszwM/821JRylnP0upF0DDZfy7Yoy/M14sSo8yN
         cDyx8/vAGCxeN6f4A9p27LYtOgX8Bt7RvUAZsdVweYsLFMEDgUtAubJTTZvjf/r4PqAk
         9xYR6LhFuaDBazIXGZgGgceYcS4xH7d0oId3kS58gxJ9Dh5ifexWj+uEE4TBNUWgacg7
         mtKe3F6qH+FBj7ni5bJTZHxCQjb8i/BMbjvKfwUOAv70pC8TUxOEkIqimaxS2sglAjV/
         aoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726845953; x=1727450753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKGVOuHkkDFpeTWe9o2N7pUq8VYne2cI4fc0+if+jh8=;
        b=tTN4x6wxujh3cLH3OrhFdJIKiTq0hZnMJCqoZ7rgqTgHaXOi0IolXXaMffHFalGOyE
         xoFEZQgaKF0WiAuX4MyAxyjwAWfzYMEFQRl6UzOMZ8HM0x3PFlIw/B31sJLGT8JGyJyn
         1+6H6eJEsOPLDr5aswwozFc8cNRUM+o/uTFB5dwaHdeHWpEXHPFcGms/RQU+o+jYfM2y
         mPoHYKZIdVCXqvYwOK7gNdQgRdBZMoGvfg+tV1JHYu35+ARaCR7/vLtrR5lnnqN2as4W
         XbGWWDzFn5B9tz+g/Xr/BQypCRuJskbtl4TJorkCghzA8MgroVrru691L8rDvw8C61HN
         nqGw==
X-Forwarded-Encrypted: i=1; AJvYcCU0y10Qpdhc30aaEcUdE4ZCn+i7BD+AzwVdbsyP2ivOxjuzQ9xCB1TTyYaplh2mrGCB/afsuF08YOu8XIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxzY30VioXrxfq/lbgSiDpST4cpPD18le7BQ9YX8BKfSg20qpV
	SxW4QZTy2O7ZOP2WRDcqksv/5UrXObuh3z/cf8WpybuSOqSnDahhjC//rVXFGBA=
X-Google-Smtp-Source: AGHT+IHwkZwcwt8eIyxOT+yiny+L8BtaDvrFe9uAysW7T/a/BP2Hr5IavUFDNaRXwlsH+vjL1zo8+A==
X-Received: by 2002:a05:6512:2351:b0:530:e228:779c with SMTP id 2adb3069b0e04-536ac2e5af4mr1654009e87.19.1726845952442;
        Fri, 20 Sep 2024 08:25:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53687046810sm2204772e87.54.2024.09.20.08.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 08:25:50 -0700 (PDT)
Date: Fri, 20 Sep 2024 18:25:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Pin-yen Lin <treapking@chromium.org>, 
	Andrzej Hajda <a.hajda@samsung.com>, Neil Armstrong <narmstrong@baylibre.com>, 
	Robert Foss <robert.foss@linaro.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, 
	Kenneth Hung <Kenneth.hung@ite.com.tw>, allen chen <allen.chen@ite.corp-partner.google.com>
Subject: Re: [PATCH v1 1/2] drm/bridge:  it6505: HDCP CTS fail on repeater
 items
Message-ID: <ctaijeprvqg63vqtm42q57c4geuzvyyxpxjgxbmbxzxrykrqk5@5fcbxaqnkdko>
References: <20240920082451.9240-1-Hermes.Wu@ite.com.tw>
 <20240920082451.9240-2-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920082451.9240-2-Hermes.Wu@ite.com.tw>

On Fri, Sep 20, 2024 at 04:24:46PM GMT, Hermes Wu wrote:
> From: allen chen <allen.chen@ite.corp-partner.google.com>
> 
> Fix HDCP CTS items on UNIGRAF DPR-100.

Fix how? What was broken? Please describe the reasoning for the change.
Also if it a fix, please use Fixes tags as required. If you have
further questions, see Documentation/process/submitting-patches.rst

> 
> Change-Id: I03f0758779f73164c8ae2fdf61e41dc693e27605
> 
> Change-Id: Ib7a8fabaeccd56d3bd7c8adc7384a363b0f7b88d

Please drop Gerrit tags

> Signed-off-by: Hermes Wu <Hermes.Wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 152 ++++++++++++++++++----------
>  1 file changed, 101 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index 7a4608844de3..cef02c8c363e 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -298,11 +298,11 @@
>  #define MAX_LANE_COUNT 4
>  #define MAX_LINK_RATE HBR
>  #define AUTO_TRAIN_RETRY 3
> -#define MAX_HDCP_DOWN_STREAM_COUNT 10
> +#define MAX_HDCP_DOWN_STREAM_COUNT 127
>  #define MAX_CR_LEVEL 0x03
>  #define MAX_EQ_LEVEL 0x03
>  #define AUX_WAIT_TIMEOUT_MS 15
> -#define AUX_FIFO_MAX_SIZE 32
> +#define AUX_FIFO_MAX_SIZE 16
>  #define PIXEL_CLK_DELAY 1
>  #define PIXEL_CLK_INVERSE 0
>  #define ADJUST_PHASE_THRESHOLD 80000
> @@ -326,6 +326,9 @@ enum aux_cmd_type {
>  	CMD_AUX_NATIVE_READ = 0x0,
>  	CMD_AUX_NATIVE_WRITE = 0x5,
>  	CMD_AUX_I2C_EDID_READ = 0xB,
> +
> +	/*extend read ncommand */
> +	CMD_AUX_GET_KSV_LIST = 0x10,
>  };
>  
>  enum aux_cmd_reply {
> @@ -973,7 +976,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
>  	it6505_set_bits(it6505, REG_AUX_CTRL, AUX_USER_MODE, AUX_USER_MODE);
>  
>  aux_op_start:
> -	if (cmd == CMD_AUX_I2C_EDID_READ) {
> +	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
>  		/* AUX EDID FIFO has max length of AUX_FIFO_MAX_SIZE bytes. */
>  		size = min_t(size_t, size, AUX_FIFO_MAX_SIZE);
>  		/* Enable AUX FIFO read back and clear FIFO */
> @@ -1004,7 +1007,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
>  				  size);
>  
>  	/* Aux Fire */
> -	it6505_write(it6505, REG_AUX_CMD_REQ, cmd);
> +	it6505_write(it6505, REG_AUX_CMD_REQ, (cmd & 0x0F));
>  
>  	ret = it6505_aux_wait(it6505);
>  	if (ret < 0)
> @@ -1038,7 +1041,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
>  		goto aux_op_start;
>  	}
>  
> -	if (cmd == CMD_AUX_I2C_EDID_READ) {
> +	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
>  		for (i = 0; i < size; i++) {
>  			ret = it6505_read(it6505, REG_AUX_DATA_FIFO);
>  			if (ret < 0)
> @@ -1063,7 +1066,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
>  	ret = i;
>  
>  aux_op_err:
> -	if (cmd == CMD_AUX_I2C_EDID_READ) {
> +	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
>  		/* clear AUX FIFO */
>  		it6505_set_bits(it6505, REG_AUX_CTRL,
>  				AUX_EN_FIFO_READ | CLR_EDID_FIFO,
> @@ -1084,18 +1087,25 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
>  				      size_t size, enum aux_cmd_reply *reply)
>  {
>  	int i, ret_size, ret = 0, request_size;
> +	struct device *dev = &it6505->client->dev;
>  
>  	mutex_lock(&it6505->aux_lock);
> -	for (i = 0; i < size; i += 4) {
> -		request_size = min((int)size - i, 4);
> +	for (i = 0; i < size; ) {
> +		if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST)
> +			request_size = min((int)size - i, AUX_FIFO_MAX_SIZE);
> +		else
> +			request_size = min((int)size - i, 4);
> +

This looks as if this is also fixing the EDID read, so it probably needs
a separate commit and a separate description.

>  		ret_size = it6505_aux_operation(it6505, cmd, address + i,
>  						buffer + i, request_size,
>  						reply);
> +
>  		if (ret_size < 0) {
>  			ret = ret_size;
>  			goto aux_op_err;
>  		}
>  
> +		i += request_size;
>  		ret += ret_size;
>  	}
>  
> @@ -1186,6 +1196,35 @@ static int it6505_get_edid_block(void *data, u8 *buf, unsigned int block,
>  	return 0;
>  }
>  
> +static int it6505_get_ksvlist(struct it6505 *it6505, u8 *buf, size_t len)
> +{
> +	int i, request_size, ret;
> +	struct device *dev = &it6505->client->dev;
> +	enum aux_cmd_reply reply;
> +
> +	for (i = 0; i < len; ) {
> +		request_size = min((int)len - i, 15);

min_t ?

> +
> +		ret = it6505_aux_do_transfer(it6505, CMD_AUX_GET_KSV_LIST,
> +					     DP_AUX_HDCP_KSV_FIFO,
> +					     buf + i, request_size, &reply);
> +
> +		DRM_DEV_DEBUG_DRIVER(dev, "request_size = %d, ret =%d", request_size, ret);
> +		if (ret < 0)
> +			return ret;
> +
> +		i += request_size;
> +	}
> +
> +	DRM_DEV_DEBUG_DRIVER(dev, "ksv read cnt = %d down_stream_cnt=%d ", i, i/5);
> +
> +	for (i = 0 ; i < len; i += 5)
> +		DRM_DEV_DEBUG_DRIVER(dev, "ksv[%d] = %02X%02X%02X%02X%02X",
> +				i/5, buf[i], buf[i + 1], buf[i + 2], buf[i + 3], buf[i + 4]);
> +
> +	return len;
> +}
> +
>  static void it6505_variable_config(struct it6505 *it6505)
>  {
>  	it6505->link_rate_bw_code = HBR;
> @@ -1927,6 +1966,7 @@ static void it6505_hdcp_part1_auth(struct it6505 *it6505)
>  	it6505_set_bits(it6505, REG_HDCP_TRIGGER, HDCP_TRIGGER_START,
>  			HDCP_TRIGGER_START);
>  
> +	it6505->is_repeater = (hdcp_bcaps & DP_BCAPS_REPEATER_PRESENT);

This looks like a separate change.

>  	it6505->hdcp_status = HDCP_AUTH_GOING;
>  }
>  
> @@ -1963,7 +2003,7 @@ static int it6505_setup_sha1_input(struct it6505 *it6505, u8 *sha1_input)
>  {
>  	struct device *dev = &it6505->client->dev;
>  	u8 binfo[2];
> -	int down_stream_count, i, err, msg_count = 0;
> +	int down_stream_count, err, msg_count = 0;
>  
>  	err = it6505_get_dpcd(it6505, DP_AUX_HDCP_BINFO, binfo,
>  			      ARRAY_SIZE(binfo));
> @@ -1989,17 +2029,12 @@ static int it6505_setup_sha1_input(struct it6505 *it6505, u8 *sha1_input)
>  		return 0;
>  	}
>  
> -	for (i = 0; i < down_stream_count; i++) {
> -		err = it6505_get_dpcd(it6505, DP_AUX_HDCP_KSV_FIFO +
> -				      (i % 3) * DRM_HDCP_KSV_LEN,
> -				      sha1_input + msg_count,
> -				      DRM_HDCP_KSV_LEN);
>  
> -		if (err < 0)
> -			return err;
> +	err =  it6505_get_ksvlist(it6505, sha1_input, down_stream_count * 5);
> +	if (err < 0)
> +		return err;
>  
> -		msg_count += 5;
> -	}
> +	msg_count += down_stream_count * 5;
>  
>  	it6505->hdcp_down_stream_count = down_stream_count;
>  	sha1_input[msg_count++] = binfo[0];
> @@ -2027,7 +2062,7 @@ static bool it6505_hdcp_part2_ksvlist_check(struct it6505 *it6505)
>  {
>  	struct device *dev = &it6505->client->dev;
>  	u8 av[5][4], bv[5][4];
> -	int i, err;
> +	int i, err, retry;
>  
>  	i = it6505_setup_sha1_input(it6505, it6505->sha1_input);
>  	if (i <= 0) {
> @@ -2037,21 +2072,28 @@ static bool it6505_hdcp_part2_ksvlist_check(struct it6505 *it6505)
>  
>  	it6505_sha1_digest(it6505, it6505->sha1_input, i, (u8 *)av);
>  
> -	err = it6505_get_dpcd(it6505, DP_AUX_HDCP_V_PRIME(0), (u8 *)bv,
> -			      sizeof(bv));
> +	for (retry = 0; retry < 3; retry++) {
>  
> -	if (err < 0) {
> -		dev_err(dev, "Read V' value Fail");
> -		return false;
> -	}
> +		err = it6505_get_dpcd(it6505, DP_AUX_HDCP_V_PRIME(0), (u8 *)bv,
> +					sizeof(bv));
>  
> -	for (i = 0; i < 5; i++)
> -		if (bv[i][3] != av[i][0] || bv[i][2] != av[i][1] ||
> -		    bv[i][1] != av[i][2] || bv[i][0] != av[i][3])
> -			return false;
> +		if (err < 0) {
> +			dev_err(dev, "Read V' value Fail %d", retry);
> +			continue;
> +		}
>  
> -	DRM_DEV_DEBUG_DRIVER(dev, "V' all match!!");
> -	return true;
> +		for (i = 0; i < 5; i++) {
> +			if (bv[i][3] != av[i][0] || bv[i][2] != av[i][1] ||
> +				bv[i][1] != av[i][2] || bv[i][0] != av[i][3])
> +				break;
> +
> +			DRM_DEV_DEBUG_DRIVER(dev, "V' all match!! %d, %d", retry, i);
> +			return true;
> +		}
> +	}

And this too. And other chunks are also unrelated.

> +
> +	DRM_DEV_DEBUG_DRIVER(dev, "V' NOT match!! %d", retry);
> +	return false;
>  }
>  
>  static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
> @@ -2059,7 +2101,7 @@ static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
>  	struct it6505 *it6505 = container_of(work, struct it6505,
>  					     hdcp_wait_ksv_list);
>  	struct device *dev = &it6505->client->dev;
> -	unsigned int timeout = 5000;
> +	unsigned int timeout = 2000;

And this.

>  	u8 bstatus = 0;
>  	bool ksv_list_check;
>  
> @@ -2079,21 +2121,18 @@ static void it6505_hdcp_wait_ksv_list(struct work_struct *work)
>  
>  	if (timeout == 0) {
>  		DRM_DEV_DEBUG_DRIVER(dev, "timeout and ksv list wait failed");
> -		goto timeout;
> +		goto hdcp_ksvlist_fail;
>  	}
>  
>  	ksv_list_check = it6505_hdcp_part2_ksvlist_check(it6505);
>  	DRM_DEV_DEBUG_DRIVER(dev, "ksv list ready, ksv list check %s",
> -			     ksv_list_check ? "pass" : "fail");
> -	if (ksv_list_check) {
> -		it6505_set_bits(it6505, REG_HDCP_TRIGGER,
> -				HDCP_TRIGGER_KSV_DONE, HDCP_TRIGGER_KSV_DONE);
> +				ksv_list_check ? "pass" : "fail");
> +
> +	if (ksv_list_check)
>  		return;
> -	}
> -timeout:
> -	it6505_set_bits(it6505, REG_HDCP_TRIGGER,
> -			HDCP_TRIGGER_KSV_DONE | HDCP_TRIGGER_KSV_FAIL,
> -			HDCP_TRIGGER_KSV_DONE | HDCP_TRIGGER_KSV_FAIL);
> +
> +hdcp_ksvlist_fail:
> +	it6505_start_hdcp(it6505);
>  }
>  
>  static void it6505_hdcp_work(struct work_struct *work)
> @@ -2139,7 +2178,7 @@ static void it6505_hdcp_work(struct work_struct *work)
>  	it6505_hdcp_part1_auth(it6505);
>  }
>  
> -static void it6505_show_hdcp_info(struct it6505 *it6505)
> +static void it6505_show_hdcp_info(struct it6505 *it6505, bool repeater_info)
>  {
>  	struct device *dev = &it6505->client->dev;
>  	int i;
> @@ -2150,7 +2189,7 @@ static void it6505_show_hdcp_info(struct it6505 *it6505)
>  	DRM_DEV_DEBUG_DRIVER(dev, "bksv = 0x%*ph",
>  			     (int)ARRAY_SIZE(it6505->bksvs), it6505->bksvs);
>  
> -	if (it6505->is_repeater) {
> +	if ((repeater_info) && (it6505->is_repeater)) {
>  		DRM_DEV_DEBUG_DRIVER(dev, "hdcp_down_stream_count: %d",
>  				     it6505->hdcp_down_stream_count);
>  		DRM_DEV_DEBUG_DRIVER(dev, "sha1_input: 0x%*ph",
> @@ -2251,12 +2290,11 @@ static void it6505_link_training_work(struct work_struct *work)
>  	if (ret) {
>  		it6505->auto_train_retry = AUTO_TRAIN_RETRY;
>  		it6505_link_train_ok(it6505);
> -		return;
>  	} else {
>  		it6505->auto_train_retry--;
> +		it6505_dump(it6505);
>  	}
>  
> -	it6505_dump(it6505);
>  }
>  
>  static void it6505_plugged_status_to_codec(struct it6505 *it6505)
> @@ -2311,14 +2349,22 @@ static int it6505_process_hpd_irq(struct it6505 *it6505)
>  	DRM_DEV_DEBUG_DRIVER(dev, "dp_irq_vector = 0x%02x", dp_irq_vector);
>  
>  	if (dp_irq_vector & DP_CP_IRQ) {
> -		it6505_set_bits(it6505, REG_HDCP_TRIGGER, HDCP_TRIGGER_CPIRQ,
> -				HDCP_TRIGGER_CPIRQ);
>  
>  		bstatus = it6505_dpcd_read(it6505, DP_AUX_HDCP_BSTATUS);
>  		if (bstatus < 0)
>  			return bstatus;
>  
>  		DRM_DEV_DEBUG_DRIVER(dev, "Bstatus = 0x%02x", bstatus);
> +
> +		/*1B-02 ignore when bstatus is 0 */
> +		if ((bstatus & DP_BSTATUS_R0_PRIME_READY) &&
> +				(it6505->hdcp_status == HDCP_AUTH_GOING))
> +			it6505_set_bits(it6505, REG_HDCP_TRIGGER, HDCP_TRIGGER_CPIRQ,
> +					HDCP_TRIGGER_CPIRQ);
> +		else if ((bstatus & (DP_BSTATUS_REAUTH_REQ | DP_BSTATUS_LINK_FAILURE)) &&
> +				(it6505->hdcp_status == HDCP_AUTH_DONE))
> +			it6505_start_hdcp(it6505);
> +
>  	}
>  
>  	ret = drm_dp_dpcd_read_link_status(&it6505->aux, link_status);
> @@ -2431,7 +2477,7 @@ static void it6505_irq_hdcp_done(struct it6505 *it6505)
>  
>  	DRM_DEV_DEBUG_DRIVER(dev, "hdcp done interrupt");
>  	it6505->hdcp_status = HDCP_AUTH_DONE;
> -	it6505_show_hdcp_info(it6505);
> +	it6505_show_hdcp_info(it6505, false);
>  }
>  
>  static void it6505_irq_hdcp_fail(struct it6505 *it6505)
> @@ -2440,7 +2486,7 @@ static void it6505_irq_hdcp_fail(struct it6505 *it6505)
>  
>  	DRM_DEV_DEBUG_DRIVER(dev, "hdcp fail interrupt");
>  	it6505->hdcp_status = HDCP_AUTH_IDLE;
> -	it6505_show_hdcp_info(it6505);
> +	it6505_show_hdcp_info(it6505, true);
>  	it6505_start_hdcp(it6505);
>  }
>  
> @@ -2455,7 +2501,11 @@ static void it6505_irq_hdcp_ksv_check(struct it6505 *it6505)
>  {
>  	struct device *dev = &it6505->client->dev;
>  
> -	DRM_DEV_DEBUG_DRIVER(dev, "HDCP event Interrupt");
> +	DRM_DEV_DEBUG_DRIVER(dev, "HDCP repeater R0 event Interrupt");
> +
> +	it6505_set_bits(it6505, REG_HDCP_TRIGGER,
> +			HDCP_TRIGGER_KSV_DONE, HDCP_TRIGGER_KSV_DONE);
> +
>  	schedule_work(&it6505->hdcp_wait_ksv_list);
>  }
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

