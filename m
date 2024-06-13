Return-Path: <linux-kernel+bounces-212619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E26A9063F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD7B1F236D8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E821213B298;
	Thu, 13 Jun 2024 06:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vt0HP0gF"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EA713792E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259529; cv=none; b=hXPEETReFqkbPIxc8P1NxVLmQQYsJEe5zdVc/fl78kfjd9BGF+DrvcHFW7q66JhUrmZcciMHqS9nJQzjBawDvf52fyfR7gRNv0DzX3JyLv4PTKyCgP4m9EKPs+wvVjc05FhH/mHSgsQcvGsqOtG5wVJhkk/NN+Q8skMLUKHsKvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259529; c=relaxed/simple;
	bh=3Z53dCKnXADH8Fw5ImCagIWN6dJCq2ct9xcffJ8kRjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2wNCk+xK4LHn9OAY2oeAb7K1Q06EyNwP1AV4S7eoUG/o+PVlEVnBYWZRJhGf8X4ncY75r6/SJr4sxNmJa2AGRYPZ4bh+ZBGDMe8kZ/7j+in1VfTnLVAymS/2qKz/lVWyI8zufUUB663ygJFepRFT8Qj5MPjOQ9KM/jgdFnlUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vt0HP0gF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35f2d723ef0so660253f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 23:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718259526; x=1718864326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U+orkaLah96MSYcST73OEUrcKzMMY5Uv1LAki9HT0H0=;
        b=Vt0HP0gFxCku7boGCuiVmQs/ZxsbujqngOA1liUur5p0BeaouB6EHht6RP78L8tCAH
         vg2ChfpjCLDAOkfCZKm/dH+RxtrE9KVQjs2u0XxnHBfd7DN5N4CS+cP2d7YysdDwS9uA
         D7KE3HNgOoqlsUpc1BBQww8xXHBZfKH+5dTg8VlFhvEWYT8BgIvPVUjbST8076wj/Gq0
         ENZ62Wjn59VtWuFuTYnXx/2DkOLJNf4yTcfvW3XLRmjY4rlk5SbacuBnoSZdC9VHQIh7
         F11ZhWr5IcYpb94rXhF0N1+8dLDwMy8bNUmkhjf0M0pNJNAT9h6baQIcob5v8Qghtefh
         Sdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718259526; x=1718864326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+orkaLah96MSYcST73OEUrcKzMMY5Uv1LAki9HT0H0=;
        b=xBX3XNOHSrIzSurP855f7U1BYUG6lHdMmBjHNg/ofOGDcLStB75IwRY+sG5JmsgX2G
         8wRyvrXg0LqxOgYs5tDk6qKqUyKClbUfaCGdHrQK132lqDy1oEK5KHk9PKzm+rD1oawj
         q+5PNwTiuZ33TL/TfaRw5W1Lz/PaQ68g6sN8WLUvkneM4A7JdsMEFubSshEuZDAttp36
         DfC45bZUoupNFkhmZiwPCYO9r9YIKF+TnfzPFMeBieEDJIFvo8cszXqvq5A083S4Yqii
         urq/mviU1Rm5Z0d6gdp+ZFUhNNgRVh7MVYtGEgUp6+Ob/uW/6CxmfYZndOilBzwqFuwl
         JL7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV8Gq7o0XC1M7XEfvWEez+sR8JtlHe510Tq4qAosE/2A6qr83qaUpreGX9LqhdPIeFO4VGdbrkm9vqo2DgiN4hdbN3C2kZov/hPUSIs
X-Gm-Message-State: AOJu0YwGOTvlNRSDa1hJbj7BC07j8UnbRSeow+48o03L7/CX4/JcBnQ9
	8sUA0ttETJmVSqTP0GKt4ILAu6tXY5ZtoTV4sKnW5CaTeGAHdPMrndKVvDLpgpE=
X-Google-Smtp-Source: AGHT+IEKdhomx8kt/PH3knZBe5enTq8waWMbEj1dCXb77V0AT8udraQcqI/cxnxbfkjPvMadq95X7A==
X-Received: by 2002:a05:6000:136a:b0:35f:f32:49d7 with SMTP id ffacd0b85a97d-35fe892ea05mr2784940f8f.55.1718259525425;
        Wed, 12 Jun 2024 23:18:45 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c8c2sm706089f8f.31.2024.06.12.23.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 23:18:45 -0700 (PDT)
Date: Thu, 13 Jun 2024 09:18:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joy Chakraborty <joychakr@google.com>
Cc: Sean Anderson <sean.anderson@seco.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rtc: abx80x: Fix return value of nvmem callback on read
Message-ID: <f0dbf963-bfd9-4a0b-8284-d141999da184@moroto.mountain>
References: <20240612180554.1328409-1-joychakr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612180554.1328409-1-joychakr@google.com>

On Wed, Jun 12, 2024 at 06:05:54PM +0000, Joy Chakraborty wrote:
> Read callbacks registered with nvmem core expect 0 to be returned on
> success and a negative value to be returned on failure.
> 
> abx80x_nvmem_xfer() on read calls i2c_smbus_read_i2c_block_data() which
> returns the number of bytes read on success as per its api description,
> this return value is handled as an error and returned to nvmem even on
> success.
> 
> Fix to handle all possible values that would be returned by
> i2c_smbus_read_i2c_block_data().
> 
> Fixes: e90ff8ede777 ("rtc: abx80x: Add nvmem support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joy Chakraborty <joychakr@google.com>
> ---
>  drivers/rtc/rtc-abx80x.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
> index fde2b8054c2e..0f5847d1ca2a 100644
> --- a/drivers/rtc/rtc-abx80x.c
> +++ b/drivers/rtc/rtc-abx80x.c
> @@ -711,9 +711,16 @@ static int abx80x_nvmem_xfer(struct abx80x_priv *priv, unsigned int offset,
>  		else
>  			ret = i2c_smbus_read_i2c_block_data(priv->client, reg,
>  							    len, val);
> -		if (ret)
> +		if (ret < 0)
>  			return ret;
>  
> +		if (!write) {
> +			if (ret)
> +				len = ret;
> +			else
> +				return -EIO;
> +		}

I guess this is the conservative approach.  Ie.  Don't break things
which aren't already broken.  But I suspect the correct approach is to
say:

	if (ret != len)
		return -EIO;

Ah well.  Being conservative is good.  It probably doesn't ever happen
in real life so it probably doesn't matter either way.

I don't really like the if (write) follow by and if (!write)...  It
would add more lines, but improve readability if we just duplicate the
code a big:

	if (write) {
		ret = write();
		if (ret)
			return ret;
	} else {
		ret = read();
		if (ret <= 0)
			return ret ?: -EIO;
		len = ret;
	}

regards,
dan carpenter


