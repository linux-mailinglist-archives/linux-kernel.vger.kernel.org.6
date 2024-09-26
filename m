Return-Path: <linux-kernel+bounces-340078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55187986E5A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA06B1F245F9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918AB192586;
	Thu, 26 Sep 2024 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jmZFA1bu"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AA118A6CC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337477; cv=none; b=LI8H1o9/AZgSCeYUvpjXz47eKntUQydEvRuD7CCYUBsXWbU11zzlwIj+IplEfwYSJEp+Q2bBBC9yFpVt9CFIEmOxmnPU3O6zD7AjxFEnH1/hLfS1Eo6Cm9s4TP24Iuwtke9YJC6kzGfdC5aWCr5HH7EpSmijWjrtOVhMZtafBB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337477; c=relaxed/simple;
	bh=/d6LcsiZn04Ovm3kKftMvL7yFaxUYh9FaQ5W8Ihe5nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulArHjD6NFEktNqnMh3Ab/5LnTgAjxmOUCjX4Xhs5Ao6mctTrdV+YazFXv88rdcyyre1ZC8cao1Np4zLQJXrIR0p9GxHh0RHMLI+Eil/oEbWailEp6/EY3fU7DYcciV33Akr1We93/IcWYIP9cLvHusMS+qtBgR9m/InxcEm0pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jmZFA1bu; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53655b9bbcdso821187e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 00:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727337474; x=1727942274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JltK8FDylXTKo1/6yJmtSP0cOpyqmoQs5eQDuy/bKh0=;
        b=jmZFA1bu6EAYA1awOHf5MBszRXh2/q9h3K55FWI3wV9tI084QA4qn5/dKEBuWnsxqK
         X4Kg+WPwncqng7KXE+j4p5oY323ss04gKn75RgxLzZHF9YarcXHIfHPvQu5ttL0Hiog7
         AiwhHP6MeFNRx4KXNRyFgGKrsn4s+lsWgD+NzEpr19rZiy04Dfyy5CrQP232rO42LAU8
         SaqCUN5AAHs90uAhHUJh6UxVXG81cDj4AYgZrSZdhnqYJwq676xbOZSE80xP5qExv8YC
         URdIre1ZT4m8EQpGFlvxTe9qGd00P9JRl42ehQMGfTCmKNUxHjvQZ0jH3COI373nQp+Q
         gQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727337474; x=1727942274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JltK8FDylXTKo1/6yJmtSP0cOpyqmoQs5eQDuy/bKh0=;
        b=A7fOZvbZtJk9v87A4rxgi90e6XugfthHg/aiswaQxcYnA2VgByXgki9P5w9Mlc437i
         dnZnELO0G5vUPN+M7vkztBtIs2NGbAfd23RmtjenqAIG1hTK7LS8bhlk9k66Yco6u6No
         jPF+dDFp00nMblkWm5RjShtQEAJgVdHhO1vl3E2r6Zy0PrLq+5DIRy9rRIRJRUj0TsRL
         GRf0nrjdFOzM7y4FHQO7ahgqUk9kOqLKDGoVUsA7uQa3LytBIGxOmFd0U+Vmo8AW6yIE
         ikgRdUJsnPL44FdZV9Gkez8mwICnGyj2bd7duQw0w4ZGJr6otXSVKBJHmttw+o5acB+d
         dvGg==
X-Forwarded-Encrypted: i=1; AJvYcCX3xUfKZdsrd77r2WT8y8UeXCtv0RlSyKV1I1ql+nTshLaoqqLBOGfdVjy087/jb7fQ3/mzsOu4/h7RCSk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7mUAFv9EHoxUQxJCHZ3bIN7fL/+9sijhPE8aAWF9eL4Y78WBQ
	laK5ZvxN+sf0RiTcUr92wu7q8gTkYEbBMLNbRl3pT9idI+wYez6dVSgCBDiJdt4=
X-Google-Smtp-Source: AGHT+IHjv8z5giLvPlSpFaYEP6Q7nupj2epvJQNRhjI1PxL5nLm16At7qCJFmXaPGU4Ng2B6PHJm/Q==
X-Received: by 2002:a05:6512:3c97:b0:533:45a1:88fc with SMTP id 2adb3069b0e04-53877530d28mr3367434e87.30.1727337474011;
        Thu, 26 Sep 2024 00:57:54 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a864e636sm732879e87.302.2024.09.26.00.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 00:57:53 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:57:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hermes Wu <Hermes.Wu@ite.com.tw>
Cc: Kenneth Hung <Kenneth.hung@ite.com.tw>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Allen Chen <allen.chen@ite.com.tw>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/11] drm/bridge: it6505: add aux operation for HDCP
 ksv list read
Message-ID: <acpumgqlyjyt5ql2imnhrv32apdjzluahnx77xpqu2lzltko4q@j6fhqrb7sxai>
References: <20240926074755.22176-1-Hermes.Wu@ite.com.tw>
 <20240926074755.22176-4-Hermes.Wu@ite.com.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926074755.22176-4-Hermes.Wu@ite.com.tw>

On Thu, Sep 26, 2024 at 03:47:53PM GMT, Hermes Wu wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> Add aux operaction command which supports read DPCD KSV FIFO
> with aux fifo.

Nit: AUX, FIFO. Please be consistent in your commit messages.

> 
> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")

Why is this considered to be a fix? From the commit message it sounds
like a new feature.

LGTM otherwise

> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
>  drivers/gpu/drm/bridge/ite-it6505.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
> index b451d3c2ac1d..0583abdca75f 100644
> --- a/drivers/gpu/drm/bridge/ite-it6505.c
> +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> @@ -324,6 +324,9 @@ enum aux_cmd_type {
>  	CMD_AUX_NATIVE_READ = 0x0,
>  	CMD_AUX_NATIVE_WRITE = 0x5,
>  	CMD_AUX_I2C_EDID_READ = 0xB,
> +
> +	/* KSV list read using AUX native read with FIFO */
> +	CMD_AUX_GET_KSV_LIST = 0x10,
>  };
>  
>  enum aux_cmd_reply {
> @@ -965,7 +968,8 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
>  	it6505_set_bits(it6505, REG_AUX_CTRL, AUX_USER_MODE, AUX_USER_MODE);
>  
>  aux_op_start:
> -	if (cmd == CMD_AUX_I2C_EDID_READ) {
> +	/* HW AUX FIFO supports only EDID and DCPD KSV FIFO aread */
> +	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
>  		/* AUX EDID FIFO has max length of AUX_FIFO_MAX_SIZE bytes. */
>  		size = min_t(size_t, size, AUX_FIFO_MAX_SIZE);
>  		/* Enable AUX FIFO read back and clear FIFO */
> @@ -1030,7 +1034,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
>  		goto aux_op_start;
>  	}
>  
> -	if (cmd == CMD_AUX_I2C_EDID_READ) {
> +	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
>  		for (i = 0; i < size; i++) {
>  			ret = it6505_read(it6505, REG_AUX_DATA_FIFO);
>  			if (ret < 0)
> @@ -1055,7 +1059,7 @@ static ssize_t it6505_aux_operation(struct it6505 *it6505,
>  	ret = i;
>  
>  aux_op_err:
> -	if (cmd == CMD_AUX_I2C_EDID_READ) {
> +	if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST) {
>  		/* clear AUX FIFO */
>  		it6505_set_bits(it6505, REG_AUX_CTRL,
>  				AUX_EN_FIFO_READ | CLR_EDID_FIFO,
> @@ -1079,7 +1083,7 @@ static ssize_t it6505_aux_do_transfer(struct it6505 *it6505,
>  
>  	mutex_lock(&it6505->aux_lock);
>  	for (i = 0; i < size; ) {
> -		if (cmd == CMD_AUX_I2C_EDID_READ)
> +		if (cmd == CMD_AUX_I2C_EDID_READ || cmd == CMD_AUX_GET_KSV_LIST)
>  			request_size = min_t(int, (int)size - i, AUX_FIFO_MAX_SIZE);
>  		else
>  			request_size = min_t(int, (int)size - i, 4);
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

