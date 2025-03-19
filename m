Return-Path: <linux-kernel+bounces-568138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAA8A68EAF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F75E4280DE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBC919B5B8;
	Wed, 19 Mar 2025 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Dfb4aP0f"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7D133985
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393433; cv=none; b=PdNcFLgEc2ONj3FKxMzXaePjWjWk19BMo7WGf4pl0uNfC++hs+y1kOCIV6RagzAO2wvrcjwgcfS7jK1ghuBqK9zYL6lYLbGusUC89i7wt7JpoSRBxWk+FVcW7nJE4sbucqlS4yrRM5rkw8mXUT0Egr8C1BfzAolwsD/buvGI2rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393433; c=relaxed/simple;
	bh=RZxZQKNwj3Tru3dXf7Tqfg2p9oWqsYaFjAKfL7Wgx5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFMCbpdKqtsVZ/Urjw1vO+lyG7tWAxYEdG0tfSRrebiQ+IgWj1mXgqKXbFcHsKQ/LMdV+l4ATT4CWfVYTXF05nIHJajulqC8DIbM6T5yxIAV0botsjR/7VdLn/4rsijxp7j3u5z/3sBfR1oLmDsQlcJe9DQkuJfPVXIGYfnjcXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Dfb4aP0f; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2b3680e548aso415193fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742393428; x=1742998228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lCQ7mg9qx8im0TmEXVjeKUfTXL7p1nZHg6BtajIV6Qo=;
        b=Dfb4aP0fDZ2r26shPW+7AebkU4S1Srdo9EeDxDLauEGHN7FG+HL1/kvbnBA6K40vjn
         i0hNO48b6cgUJt8j8uu+Xs92jateavsW+YJ/pbt6Mnd0SUgIXApeAiA0OzBknzZuhPhC
         yueS07yzGmNUol+D0j5PGH6EScEVfNWkFWRQLtTIGdlpRevcjvP8Fn++clW76KuTdyso
         B0cdleCNwUWyXISZCLxp8eryuC14a5Wz2tG7NJn5AIpsF8jts0BfBKrkSBQ7HsePlgPS
         WXsJ8mFbD2f0jU6FtV/+CFEMVVPwHC39LTdFzA6iCTdmpbyfDcrE7vr8DBQfJmelVKDN
         ccSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742393428; x=1742998228;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lCQ7mg9qx8im0TmEXVjeKUfTXL7p1nZHg6BtajIV6Qo=;
        b=F6q2zxk3BbMHBAUtP7cOWS6+Pzlr9ZSCMJEi9PEY8Qc/puCJnnUbHr6r22ytFLP4bt
         WnW+c/Orj7+2OLuEy6ytzz5EwZlb/fbqMMyT5dGCUVOGW1K9XcrDvQiMbaUq8+9vSXdl
         IBTJ8NWRbvLL+DahZUHELlv+I9sZOa40crUNhPCiyckBJ2802g/8WuHcgt0aScBTTv5Z
         ataKoXqjM3nSQDgnuNjFydjhtoQhQq/6BROKwI4UBTR4V7gEwV+R2BM+i1McSCT0jVJs
         BT6eHi1roM/WzPHQFopkqGUiOx03LbJYEI9/iRiWhq+um7OcjjnFUG8fnrh1lW9xB/yP
         sCig==
X-Forwarded-Encrypted: i=1; AJvYcCVM6fuV6eyR9wQBHk7rAlnx3cRshikxmdlP2W/QfoC9ibi5/wU9p2pr2375YOwZ49ZFBvFbbDrwWBlo/vY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7iAVynMbzmmaFg9/qunp9vWIhr+5yp+JMlc0mVdx5dKNlT2f9
	0gUQMadq0p3lKj4UAIbVHrNmCZWLFT0KGLIYCOOHejKvNMiiFFG83/5PnpxRdBk=
X-Gm-Gg: ASbGnctNrssQ8qc0ryt2ZYMFB3TTH7ZkN1XfVbFpVO5jksXeaBnsSEGia6XAu5cmHDr
	xlLgGIJDSU8nOgpVV5kIOkAeQCOo56cdynzj7+7e9DNJgtu82AWIINkjjuQdWN2iHp3Dj1m64eP
	hl/Eb4U8/FGV7O/3ybV14FcFkW08S1o4WwLiAoSsqsg6R6vCZoqg1h4mhTYJpsu4lAh04e5Z/Np
	Gzi1WGBBE/qzT/AyJPrVoWeW4PWzbgDLHK69rvsnS3WoPADV8Y7gKHuyztK03OCfgrCoSonA8L+
	2ZIWw57D/k8CYcI4ZjRJLWBXRWHlstE2mFK71+y1zgVUKtVQAFWIRABnikra287BGFT7XCzpAj2
	ZfWWyp9EYdFpj4o5S
X-Google-Smtp-Source: AGHT+IGLAuT9bruCmg6JLGuhMlyOX5HQi279BRJMsB+YAibz/H/yD22BULxRcvK1dKErXhzR7pgh0A==
X-Received: by 2002:a05:6871:200e:b0:2c3:13f7:2b3d with SMTP id 586e51a60fabf-2c71a1b6563mr4086867fac.13.1742393428113;
        Wed, 19 Mar 2025 07:10:28 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e95dsm2442600a34.52.2025.03.19.07.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 07:10:27 -0700 (PDT)
Message-ID: <a6246dea-738b-48fc-80fc-6676967157eb@baylibre.com>
Date: Wed, 19 Mar 2025 09:10:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: dac: ad3552r-hs: add debugfs reg access
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250319-wip-bl-ad3552r-fixes-v2-1-2656bdd6778e@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250319-wip-bl-ad3552r-fixes-v2-1-2656bdd6778e@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 8:30 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add debugfs register access.
> 

Forgot to pick up Nuno's review tag or explain why not.

> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> Changes in v2:
> - set reg size setup as inline.
> - Link to v1: https://lore.kernel.org/r/20250319-wip-bl-ad3552r-fixes-v1-1-cf10d6fae52a@baylibre.com
> ---
>  drivers/iio/dac/ad3552r-hs.c | 26 ++++++++++++++++++++++++++
>  drivers/iio/dac/ad3552r.h    |  2 ++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index cd8dabb60c5548780f0fce5d1b68c494cd71321d..fdea9984547ae338a51c4671024133be82ed854f 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -7,6 +7,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/debugfs.h>

Is this header actually needed?

>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/iio/backend.h>
> @@ -464,6 +465,30 @@ static int ad3552r_hs_setup_custom_gain(struct ad3552r_hs_state *st,
>  				      gain, 1);
>  }
>  
> +static int ad3552r_hs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +				 unsigned int writeval, unsigned int *readval)
> +{
> +	struct ad3552r_hs_state *st = iio_priv(indio_dev);
> +	int size_xfer, max_reg_addr;
> +
> +	max_reg_addr = (st->model_data->num_hw_channels == 2) ?
> +			AD3552R_REG_ADDR_MAX : AD3551R_REG_ADDR_MAX;

Might as well add max reg to the model_data struct and read it directly instead
of inferring it from other info.

> +
> +	if (reg > max_reg_addr)
> +		return -EINVAL;
> +
> +	/*
> +	 * There is no 3 or 4 bytes r/w len possible in HDL, so keeping 2
> +	 * also for the 24bit area.
> +	 */
> +	size_xfer = (reg > AD3552R_SECONDARY_REGION_START) ? 2 : 1;

If we are reading both bytes of a 16-bit register at the same time, we should
only allow reading the lower of the two addresses, otherwise reading the high
register address could return 1 byte from one register and 1 byte from another
register.

And if we can't read the 24-bit and 32-bit registers all at once, I think we
should read them as 8-bit instead of 16-bit because the 24-bit registers are
not 16-bit aligned.

Or to keep it consistent, just allow accessing everything as 8-bit registers.

> +
> +	if (readval)
> +		return ad3552r_hs_reg_read(st, reg, readval, size_xfer);
> +
> +	return st->data->bus_reg_write(st->back, reg, writeval, size_xfer);
> +}


