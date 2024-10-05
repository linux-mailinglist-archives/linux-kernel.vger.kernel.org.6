Return-Path: <linux-kernel+bounces-351969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3710A991872
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 18:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD6C1C21255
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE7B1586F2;
	Sat,  5 Oct 2024 16:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jmbNPija"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A6514D430
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 16:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728146978; cv=none; b=Vtox+g+Xq3Dw2OoyTAtEF7WXpdl7FjK0XXZnOP4siStnTow2SoEHEPTMpyPer5NUd6chk4oy+Y9CuTddv6xG3Uk3WpYaLfVCFsZASl5y6F4D/B+kNjOVc30AeS0DrV9AWKtQWjBNJB0J2cUWM6mZlPgBbMJh96lHVwE/H1B0cNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728146978; c=relaxed/simple;
	bh=yisxnb0egFsAafRFBnx9JVviGQTOX61NyzBW5Hznt0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J14T9/Npn//UkQ/NXYBG6i2XL+AsR8CP3s/9CyyevkLB/FTb+ntwXG1CmIgkiAsZfJ2zztqkPEBlOG/mdn+/Bg/rU8auBVCbaaMGremJRsYNEXCEhPaP6sSVFetQDVzMU2VCPyfoW8Sj8hhE3dYporRMW1ruIX3CwPvo3KbWreM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jmbNPija; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-286f304f504so1431069fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728146975; x=1728751775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fz5iqWZzkRkSIanhxZ9d0XaTHnZxedcupQv2iL5fXio=;
        b=jmbNPijagwkqX9RW4DGdYHnTvy1X924o+v+jTZ3y8F99PNpID0/fvnXKuIUy+ScEF+
         /CMpXbdTxRYZ4eJfQ6IB+EDunV73yid0tnarUxV1OjUaQZcjKLKoGP/HfK2yY6MwuvXy
         yVStoZlQPTl2OWnFxY1tTjfUbp6c3eo1MGbC3BHlZIKN4ZXaQlqoXEd1biU2pNcn1D0G
         5sQv0pLiDsgy/+Kxf49rH28AY3CIOpYBWt5ce/w0xauO1iZ7ADn+4g4bKjEzM9VU+bQb
         QZhZsD2UOlIDRgCjqR3vz67umKrE7KkNzkxjD6dsJ2ZdAnCRccu5uak8PCS6HN8HRM+9
         4bwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728146975; x=1728751775;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fz5iqWZzkRkSIanhxZ9d0XaTHnZxedcupQv2iL5fXio=;
        b=NhmEAnoW8aIJM4uB/QarGxHCUp8uK0K0w5an9EBO4tyrhtmYZTt31LOUjmKgbY8LRs
         wkwfulKPvyyuoe5+QsBXvS/fPvGLbeXOJFZ4+3uSXqbcrSBbbE++PWmuaAeCv8L596CR
         kO7jkHPJl4hs5UWYcdhJZUWcP3VrdZdZMKJO409/eqOGCdGdnzVJPG1cAk/aJx464Rvj
         5c8KB1i8grdQn2Rtdz3pI9WGJVn/wWvqTeJ6QA9IU+mst+jvqvHFW27JUjCS9u9Kg57E
         odmKAc4rF0uGXAPDGkuasbJhMoAx91e4re+gwW5mK0edO8RMI94X17qNHSQWDwTzfyAP
         ouhw==
X-Forwarded-Encrypted: i=1; AJvYcCUTiJ1uWvtuMWaxaNcQZ39j6sx1aXzO1jl2dSND0dTpnhxB6YzyEgEfRqPtAnO3M9/k6X74uzOZecrYPDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC5QPVQv2ci8eT/Ii/L/EnYDJiasOYw4tanxgBp2eRGAnZYkXW
	PKviUHQgaSTDKvLxzN4wtS1PR00ZYqOB3s3CqI3OnamuZryHdzF4qp4dxKjoWlQ=
X-Google-Smtp-Source: AGHT+IF4ui6OX90k7R7d+bTlwjhjgphmk3o8teENkVkRxgIOY8p/7k54A97SKVFD2tkFMtx6LJlYKw==
X-Received: by 2002:a05:6870:548d:b0:278:15b:8ee0 with SMTP id 586e51a60fabf-287c3aaefb8mr3688679fac.7.1728146974760;
        Sat, 05 Oct 2024 09:49:34 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-287d7067354sm893141fac.6.2024.10.05.09.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 09:49:34 -0700 (PDT)
Message-ID: <2053a2ca-5f76-403c-9add-ed55b478a549@baylibre.com>
Date: Sat, 5 Oct 2024 11:49:32 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] iio: backend: add API for interface get
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Andy Shevchenko <andy@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org
References: <20241004140922.233939-1-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241004140922.233939-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/4/24 9:07 AM, Antoniu Miclaus wrote:
> Add backend support for obtaining the interface type used.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v2:
>  - add IIO_BACKEND_INTERFACE_COUNT in enum.
>  - add trailing commas where applies.
>  drivers/iio/industrialio-backend.c | 24 ++++++++++++++++++++++++
>  include/linux/iio/backend.h        | 11 +++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index efe05be284b6..a322b0be7b2c 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -449,6 +449,30 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, IIO_BACKEND);
>  
> +/**
> + * iio_backend_interface_type_get - get the interace type used.

spelling: s/interace/interface

> + * @back: Backend device
> + * @type: Interface type
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_interface_type_get(struct iio_backend *back,
> +				   enum iio_backend_interface_type *type)
> +{
> +	int ret;
> +
> +	ret = iio_backend_op_call(back, interface_type_get, type);
> +	if (ret)
> +		return ret;
> +
> +	if (*type >= IIO_BACKEND_INTERFACE_COUNT)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, IIO_BACKEND);
> +
>  /**
>   * iio_backend_extend_chan_spec - Extend an IIO channel
>   * @indio_dev: IIO device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index 8099759d7242..34fc76c99d8a 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -63,6 +63,12 @@ enum iio_backend_sample_trigger {
>  	IIO_BACKEND_SAMPLE_TRIGGER_MAX
>  };
>  
> +enum iio_backend_interface_type {
> +	IIO_BACKEND_INTERFACE_LVDS,
> +	IIO_BACKEND_INTERFACE_CMOS,

There are some chips that can do both serial and parallel, so I
think these qualifiers should be included in the enum as well.

	IIO_BACKEND_INTERFACE_SERIAL_LVDS,
	IIO_BACKEND_INTERFACE_SERIAL_CMOS,

> +	IIO_BACKEND_INTERFACE_COUNT,

No comma here, and add a comment that this should always be last
since it is a count and not an interface type descriptor.

> +};
> +
>  /**
>   * struct iio_backend_ops - operations structure for an iio_backend
>   * @enable: Enable backend.
> @@ -81,6 +87,7 @@ enum iio_backend_sample_trigger {
>   * @extend_chan_spec: Extend an IIO channel.
>   * @ext_info_set: Extended info setter.
>   * @ext_info_get: Extended info getter.
> + * @interface_type_get: Interface type.
>   **/
>  struct iio_backend_ops {
>  	int (*enable)(struct iio_backend *back);
> @@ -113,6 +120,8 @@ struct iio_backend_ops {
>  			    const char *buf, size_t len);
>  	int (*ext_info_get)(struct iio_backend *back, uintptr_t private,
>  			    const struct iio_chan_spec *chan, char *buf);
> +	int (*interface_type_get)(struct iio_backend *back,
> +				  enum iio_backend_interface_type *type);
>  };
>  
>  int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
> @@ -142,6 +151,8 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
>  ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
>  				 const struct iio_chan_spec *chan, char *buf);
>  
> +int iio_backend_interface_type_get(struct iio_backend *back,
> +				   enum iio_backend_interface_type *type);
>  int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
>  				 struct iio_backend *back,
>  				 struct iio_chan_spec *chan);


