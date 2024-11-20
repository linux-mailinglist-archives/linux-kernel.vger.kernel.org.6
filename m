Return-Path: <linux-kernel+bounces-416212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBF39D4217
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1B2B26FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8738B1ABEA2;
	Wed, 20 Nov 2024 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fYUyzox/"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDE219F13B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732127623; cv=none; b=sOXvWrYJGshe/EBdgz9Y4WGbV+3Du9lhLedqu6BgIrSswLam7T938Xj5En0BViiuNoJF3l2NzPgMtFHGeDzl66cML8/OH2p6p1Sb61obWRNY3K2gO2R2bgUoWh8cg5Wx9ipUW/3Csf8UAhrKb+z6jczN2QexO/FTpptRo8Wu1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732127623; c=relaxed/simple;
	bh=iifBY3pBkQ+vW98uQfy907Av0seAhnpo27VE0vQDWU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oeE0ZWf+JH/0kG3Fixdxukqksls6wf9QotNIq7F5MdFfShrUHEUXEHAivxPmrk7Vu69hIbIuzhsaexBkaJEXV+aLyvVJ4K8RQMMnA40IRvYN4mhZ3ZXW3QJ/d/D96pI4qBey0BJM9baBTZHeScGGIqomk95jpGypV5zEQOFj3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fYUyzox/; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2958ddf99a7so100541fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 10:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732127619; x=1732732419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RJ5gUSV5Ug24/Ag1+xqlRjIyyK7KSpjstJhpPEWCQ0o=;
        b=fYUyzox/0iEyiCzk2P/3h6CfYeblr0m+3lgCMbLX8WvEpQevj4f6t9nDg1X+fYD667
         QflqcfOKUjFFWPnOU8GpPzkCSghxcx42pOi0KCewgT+6CNnIe8WMchELTMalV8sjXhe9
         P9Zd1hvmJWUPouE7f050fSjxxiQPR+6Fa9+9fM2M9U8ZPLvKNqnRa+bxox/IiMcCo+Jf
         NHnBJMVr3ojabrcesePCfjTcoy0EiUZ3B9E+i+qGI5YWUeZewnQ7cwjyR5qj5b2LHAYm
         1tJ0QsnOG+9J6EZnwBCETHzxWGBPSJhc1COG12uMI9In4J4e7Ig/qpyqQrMiK9zcdu1d
         YLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732127619; x=1732732419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RJ5gUSV5Ug24/Ag1+xqlRjIyyK7KSpjstJhpPEWCQ0o=;
        b=ikwHpIgXZLSlgynlqfypvjvUP3NLlgcv9iX0dMC6goqn7shjbLCuHt83oZ0kTic1A+
         IjNTLt3Nc08v+FWlgwK7E9c29FDH6WKtqsY+027p8mxFCnWXoonCGo2JzqYd6hise4Ik
         B3AIB43z5XYqozHxCFeY8WhX69xfis69Rz3oFESEgWikqU7z5+u7ziT4FbJLLem15Brb
         ddQg2qcvAueb03PM3YrMxh2BpvxaGwyr1g+TLFXKUllbNzZh57T8gB8UhdshWDYm5wU6
         t0XIRYWwlu7yLgKGiUMmtn7PPG393agvFyg21GBSJRvcl//ePMgiVHqU4rmvktnqmjx8
         sDWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9m6TyLsn7Vm7S0hyAZoR2bevybBhfwulbb8O7Io9R743h29eAOWEDOIOfvQ1nCIZQ/nX44w4m+1lCpxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/rb1uJCFkk0Mw095Oxu4YuS0jpkCw7hGbOkZ+SPX2+bYeXmAY
	4WiXT4F2UhTmjAuulYTKBjEwZAT92CZSpv3QFZ9vi3fzMtrKufYTr0zcKgYT9pg=
X-Gm-Gg: ASbGncvwcybzVl9JowCgz8E801Ct3ZFPZs9tusdh2e95n/HWQ0AahaaO/aeDD17hzDO
	sUkHRUCYoGB3hVVwK9NcwNcnbkO4EBYCHl1RjmdpYYKTEDCr9lEasyuiJSDbJ1q7uCJI9g6CNeo
	UDLTP/a8Lb+7yfnR9v338hMCTQtUub/kgBi81bjNTycd+7VYCTPoFOY+sMveXC0y2IuWgVgxjwb
	fwzJKZ+myVJ2Rq6yy+o3boAUV3RQun1BPG16QwjS5TjFGFObWdK/76SWnYPRag5ygDzOrJ4sfJs
	jOvNiOBnKeQ=
X-Google-Smtp-Source: AGHT+IErtBHyxlQ4JQhHNAFpJNdFkrZ1twtnq44b4sOJeIPE/rXVkwZ6w3/0MkbAhQrD1Tk016w8+Q==
X-Received: by 2002:a05:6870:4985:b0:296:bbc8:4a82 with SMTP id 586e51a60fabf-296d9ec5dc6mr4728137fac.27.1732127619261;
        Wed, 20 Nov 2024 10:33:39 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651b43415sm4358071fac.49.2024.11.20.10.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 10:33:37 -0800 (PST)
Message-ID: <47ea20d8-444b-4c72-97d3-b04a6918b121@baylibre.com>
Date: Wed, 20 Nov 2024 12:33:36 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] Input: db9 - use guard notation when acquiring mutex
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Erick Archer <erick.archer@outlook.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-kernel@vger.kernel.org
References: <20240904043104.1030257-1-dmitry.torokhov@gmail.com>
 <20240904043104.1030257-2-dmitry.torokhov@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240904043104.1030257-2-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/24 11:30 PM, Dmitry Torokhov wrote:
> Using guard notation makes the code more compact and error handling
> more robust by ensuring that mutexes are released in all code paths
> when control leaves critical section.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/joystick/db9.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
> index 682a29c27832..7ac0cfc3e786 100644
> --- a/drivers/input/joystick/db9.c
> +++ b/drivers/input/joystick/db9.c
> @@ -505,24 +505,22 @@ static int db9_open(struct input_dev *dev)
>  {
>  	struct db9 *db9 = input_get_drvdata(dev);
>  	struct parport *port = db9->pd->port;
> -	int err;
>  
> -	err = mutex_lock_interruptible(&db9->mutex);
> -	if (err)
> -		return err;
> -
> -	if (!db9->used++) {
> -		parport_claim(db9->pd);
> -		parport_write_data(port, 0xff);
> -		if (db9_modes[db9->mode].reverse) {
> -			parport_data_reverse(port);
> -			parport_write_control(port, DB9_NORMAL);
> +	scoped_guard(mutex_intr, &db9->mutex) {
> +		if (!db9->used++) {
> +			parport_claim(db9->pd);
> +			parport_write_data(port, 0xff);
> +			if (db9_modes[db9->mode].reverse) {
> +				parport_data_reverse(port);
> +				parport_write_control(port, DB9_NORMAL);
> +			}
> +			mod_timer(&db9->timer, jiffies + DB9_REFRESH_TIME);
>  		}
> -		mod_timer(&db9->timer, jiffies + DB9_REFRESH_TIME);
> +
> +		return 0;
>  	}
>  
> -	mutex_unlock(&db9->mutex);
> -	return 0;
> +	return -EINTR;

This patch and any others like it are potentially introducing a bug.

From inspecting the source code, it looks like
mutex_lock_interruptible() can return -EINTR, -EALREADY, or -EDEADLK.

Before this patch, the return value of mutex_lock_interruptible() was
passed to the caller. Now, the return value is reduced to pass/fail
and only -EINTR is returned on failure when the reason could have
been something else.



