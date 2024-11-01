Return-Path: <linux-kernel+bounces-392811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 239119B9863
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4761F1C21006
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398BA1CF7D7;
	Fri,  1 Nov 2024 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HeKgzUQw"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6668D1CF7B5
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488999; cv=none; b=tdQBgaTLcQfpGgqd4ScMzhfja+Twlk4WHA5uWN6bduHnOSg4MmJrLbuWWvBbfB1c5BJToANvmhCcvnPXY75FpFFPfbM982cIt1jI2INQvZbr8lMaiAC9j2qZhazLqxYOshBb0wOMwyFsVR++ULtpx7v2FR15Ejct8VNCOn1jyjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488999; c=relaxed/simple;
	bh=9KuVJFCA9aMDAhgDX9+OqGh+ycx3xkmrl5eFmSHfnzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XbZ++riQacRaj6GiVCXucVGllGJ13oFuBD3dZSdFiGSdj6wfUAefBUUVU/lO6KDdpjPd7hy1CufUeVD4pgGFXVm27vy7LQAD3hqpW8vJpngHgHvepOV1UTNE/uKg5gIjEU0WeNZlYG/QWPqaYVqNixcg1zhncjpCR5W3PPIaA+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HeKgzUQw; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e5f6e44727so1475532b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730488995; x=1731093795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o+y2/B/HXLKWRPWQFM6YRumN/nELJUpkOWTGMGzBZDA=;
        b=HeKgzUQwGs7OgtEtPaDo2NTCNdYxHCHpGxtdmhDrsvA8nD6krH6gGrz27kpSbvmyCr
         aSXPuguApzPo9RUeUdXrdBHXe0lblm0Oit8isiVtYlI/x1Cbf8sldHSq/LXSyBPZz2AK
         nEtsJQJc5N0nkYcdUzZsjBrgk7LsaLhw516stur+LGPBdUVYVtBVuboJGlv9DrOh8pZo
         3Mn1qkHvtkemq67US7cogP/5X2CJgiYXlAH34Ojj0I48BJm+TzmHG2oCoFUHW4jn/C5L
         IePpBFtOoqyVXfnGEIQ3oTHZKfZsi3pM/NGctfjyJY+qNiv+Xl347ZSKwYjhSAsRg44x
         SnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730488995; x=1731093795;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o+y2/B/HXLKWRPWQFM6YRumN/nELJUpkOWTGMGzBZDA=;
        b=iLseNheiL8Dnosb5SXb8nGLaopVS1HBoixbFvJ7wBVp7hmzdsuyhp5MBZvMVgaDmn3
         RZ7NQu2jwoe11BZveSvpfZ7zTSMjekzG+L47VqPVSZDTYeZsMTKeATIcJwU6iN666ETp
         ac5THHE5VG5kcU1Iqt4drCvRA4PHq7dVOQ4SZbY9merz1Y76TBvnfijb0CKn3JGL38Uj
         Qaa31h2lCmfJT7q3Zg0zTg5MbFsTFA0FK2IXp3EzdcNHcy4IujTfZ+ZuYX46+gG7Mav9
         u+PvwC5bx7sihaAE60FdfFoxpsRAVfDYDP3NDQJHinjgOdJ+Ux2Z7X0xgugQpfDouSfn
         2MIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSqT4ZooUTLarGZuqEa1hfqdgpjYBjI0twWc9vSe2smizIBrhoBTZaSkwn4ejF1g0AfPnZ8e7NyNX/iWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcVFzpTBZEDXuJg1c6FE4FjQNOi4C1lEyI9K5rsk5lZvuyXdvS
	9KtIXfIiI3aS01uNNc7c5HDPSqItGXFUoYiFjH2kJma3UJ+OPE8GMYAdEIywnis=
X-Google-Smtp-Source: AGHT+IEeVVtXDvJMfJuvJzYS8wUIRFLm6TtnkzpUAhstqEGm/jbZy5mY2m57zvkvBJnB4oV35t+i3g==
X-Received: by 2002:a05:6808:2108:b0:3e5:fbb9:7a81 with SMTP id 5614622812f47-3e758cb7cb6mr4363291b6e.45.1730488995400;
        Fri, 01 Nov 2024 12:23:15 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e66123f170sm931461b6e.39.2024.11.01.12.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 12:23:15 -0700 (PDT)
Message-ID: <2c831de5-3dc5-4a60-a92e-beef95b023e1@baylibre.com>
Date: Fri, 1 Nov 2024 14:23:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] iio: backend: add support for data size set
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 conor+dt@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241101112358.22996-1-antoniu.miclaus@analog.com>
 <20241101112358.22996-3-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241101112358.22996-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/1/24 6:23 AM, Antoniu Miclaus wrote:
> Add backend support for setting the data size used.
> This setting can be adjusted within the IP cores interfacing devices.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> no changes in v5.
>  drivers/iio/industrialio-backend.c | 21 +++++++++++++++++++++
>  include/linux/iio/backend.h        |  3 +++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index c792cd1e24e8..6f4e38417dfd 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -660,6 +660,27 @@ int iio_backend_interface_type_get(struct iio_backend *back,
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, IIO_BACKEND);
>  
> +/**
> + * iio_backend_data_size_set - set the data width/size in the data bus.
> + * @back: Backend device
> + * @size: Size in bits
> + *
> + * Some frontend devices can dynamically control the word/data size on the
> + * interface/data bus. Hence, the backend device needs to be aware of it so
> + * data can be correctly transferred.
> + *
> + * Return:
> + * 0 on success, negative error number on failure.
> + */
> +size_t iio_backend_data_size_set(struct iio_backend *back, size_t size)

Should be returning int, not size_t.

Also, size_t for size parameter seems a bit much when this is taking bits.
I don't think anything is ever going to need 5 billion bits. :-p

> +{
> +	if (!size)
> +		return -EINVAL;
> +
> +	return iio_backend_op_call(back, data_size_set, size);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, IIO_BACKEND);
> +
>  /**
>   * iio_backend_extend_chan_spec - Extend an IIO channel
>   * @back: Backend device
> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> index e5ea90f1c3e0..83ca4f0124db 100644
> --- a/include/linux/iio/backend.h
> +++ b/include/linux/iio/backend.h
> @@ -93,6 +93,7 @@ enum iio_backend_interface_type {
>   * @ext_info_set: Extended info setter.
>   * @ext_info_get: Extended info getter.
>   * @interface_type_get: Interface type.
> + * @data_size_set: Data size.
>   * @read_raw: Read a channel attribute from a backend device
>   * @debugfs_print_chan_status: Print channel status into a buffer.
>   * @debugfs_reg_access: Read or write register value of backend.
> @@ -130,6 +131,7 @@ struct iio_backend_ops {
>  			    const struct iio_chan_spec *chan, char *buf);
>  	int (*interface_type_get)(struct iio_backend *back,
>  				  enum iio_backend_interface_type *type);
> +	int (*data_size_set)(struct iio_backend *back, ssize_t size);
>  	int (*read_raw)(struct iio_backend *back,
>  			struct iio_chan_spec const *chan, int *val, int *val2,
>  			long mask);
> @@ -180,6 +182,7 @@ ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
>  				 const struct iio_chan_spec *chan, char *buf);
>  int iio_backend_interface_type_get(struct iio_backend *back,
>  				   enum iio_backend_interface_type *type);
> +size_t iio_backend_data_size_set(struct iio_backend *back, size_t size);

This will need to be changed as well.

>  int iio_backend_read_raw(struct iio_backend *back,
>  			 struct iio_chan_spec const *chan, int *val, int *val2,
>  			 long mask);


