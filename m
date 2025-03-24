Return-Path: <linux-kernel+bounces-574257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42095A6E2B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6487C3B399A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2D7266EFB;
	Mon, 24 Mar 2025 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xb38XE9m"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E5266EFC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842403; cv=none; b=CaUdSTqduiU2LO+mfImmGAVE8EezJktSzBd+DeGGrYJ4zlNlo4F55ZPZs8FbulDGgcvDHWvuEwbm46KJvP16mf5LWxBT2abruJxUFcXndO41DaxA87k/QK5tBs0JlveprRKgTe6WTGQoaag8Qksvm2Erhe/YyAg12p/9GZQpT/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842403; c=relaxed/simple;
	bh=9Et+bejBKOhYPrG+RLIDdB0IB0BGiirDMd/wt2M4F8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZxqI1qAy2PFMcpRXjLDGmqgiQByRpsbV0fsuDLk/bn5XihJfv0XdMoc5EF6SP7BV0A0ChKUGokC7JpTFEPp5IEsCtq5e8O7rwRJPAZNnBNS3Krc9iHn34fdZxR0l4SxNd+HwXwRua0yLCoy2+HSMWLxTuWHFH4nAMw227YnJ+7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xb38XE9m; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72c173211feso797664a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742842400; x=1743447200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IZA6ZpsiQTf1qeWnuqFjmneHdX8zeg+LaVhzQbpBn2E=;
        b=xb38XE9mLRztHaEIdj18E+GP0M6qhI1LxnYODqJGtvxcXfnNhuhkEo4ain0supuID2
         yzA1xdwRPaFKvdOvWNW/yjR6S9jRzXQwC6+OXO9GTPYvYIb2aFTwGfXH9I/ZtpybGlH0
         qlZV/Vi/64gqy3Wpdfvw2pp5uu54lcyAC5jrAEWVpKYkCcBbRSj3mRm3HTn3SOsW+uQA
         6eFt8FRAs8ydcFZACun1CsclsQvVNO45Dn/AajS1UxoIYgy9WP3ADZ3HDD/XZDbZSgcS
         Ju1LpoOatGdFvAiwzq7TLnsnBNA/lXMhvrTFrWABP4nTJv6Q+3cumvrOhQVZhkja5ul6
         7s6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742842400; x=1743447200;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZA6ZpsiQTf1qeWnuqFjmneHdX8zeg+LaVhzQbpBn2E=;
        b=wAB7TPPT67C39+853jmUNDw/HFm0IAgcs/7LOmbYXzL6RivRBAKpLWoT1/qG4lKHvC
         etziHrzEt7fQROo/P7YP5XU0nj/m0vkqDiRuIBEo5uMWA1DbTubxQN+X/YmhpqK6onC/
         n8i917xEaYk5KcLL+Xey6GI19d6IVR9McP0MQm7S0wdqvZx6aHQzq0j/6S/g2rvQpbPu
         AWfeC4x+bfhlqSES18T971CyCetDfQXF6SFuyYqfTUJwYVilr0ZUwPYt2O2CyU2NEpKF
         M3rbGLDesJsTqLDGShXHCdU1pS/wtVVYQrFr2AhUCyMNduHxcR0YbgqhxPHsBQSsWub7
         zraw==
X-Forwarded-Encrypted: i=1; AJvYcCUxZRGst6BXAXvxhGQ48uEGWZpZXGiZLR4V3/CDCuYUc+eficZ0pPKKe0BxO0jLMB42AbIldDGHH061iS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlM35FbOe0BZHrJ9HGpoH5Edc5nc4gwXUHWQFUpkzL9DNPFOxm
	OqnL2vmugkoZfAkD0O6qD0RPwp2cF5SmEIviDzsbcPEqRmP9qPMTWaR4CRWxXDs=
X-Gm-Gg: ASbGncttmXMkTMD3PW0zW7rZG8ipl5cNiOtqlmnsksUVceyRXNz3RvhMBisH8BoGfYJ
	ZyBzK3hcVTPWM4qgOiA5CJjCFwv5FSO3sOcscHI4DWw7jb1gFo1q2RkKe6B9rdxaLxgUdsO6QNR
	IlXRHy/2EC3HprURNHWBtLGIRg/kMm/BURA+l/3vwEXaD2nLL34Bye8xrCC0jGVX+8YwhaUJ7l/
	wYHXnXMS2YdNbfeMRtQao8DbCbGbLIR3OrNs+GkhH2ZScwMe43LiIjlLtp7b/d2bk7GOgdktP7X
	tnSPHlRbU20ofo5L1WBNI26sW02XM7xkoGmYK0mdbAtgT2VqiGOtRLKKGkPrkDsFenBUZPBhMXJ
	vCx9mEw==
X-Google-Smtp-Source: AGHT+IF6cN3R+AuP+yrpCG8uySpNH6oMp8tp8ZKnKYMSbTLqIU4c2Zi4NYw2RNf6jlvZs1qwrYXK/g==
X-Received: by 2002:a05:6830:6217:b0:72b:8a8b:e032 with SMTP id 46e09a7af769-72c0ae4658fmr9534102a34.2.1742842399668;
        Mon, 24 Mar 2025 11:53:19 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c0ac6c76esm1630781a34.49.2025.03.24.11.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 11:53:19 -0700 (PDT)
Message-ID: <9b565cb2-815b-4ca9-a7dc-8ca2e8eb5f72@baylibre.com>
Date: Mon, 24 Mar 2025 13:53:18 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iio: backend: add support for decimation ratio set
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Guillaume Stols <gstols@baylibre.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
 <20250324090813.2775011-2-pop.ioan-daniel@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250324090813.2775011-2-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/25 4:07 AM, Pop Ioan Daniel wrote:
> Add backend support for setting the decimation ratio used.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
>  drivers/iio/industrialio-backend.c | 18 ++++++++++++++++++
>  include/linux/iio/backend.h        |  3 +++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> index 363281272035..f4db6514944a 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -417,6 +417,24 @@ int iio_backend_test_pattern_set(struct iio_backend *back,
>  }
>  EXPORT_SYMBOL_NS_GPL(iio_backend_test_pattern_set, "IIO_BACKEND");
>  
> +/**
> + * iio_backend_set_dec_rate - set decimation ratio

In [1], we decided that for a similar chip we could use "decimation rate" and
"oversampling ratio" interchangeably. And in [2], we recently added a backend
op for setting the oversampling ratio. Would it make sense to use that here
as well instead of introducing a new function? If not, we'll want more of an
explanation here on what the difference is. But from what I can tell, this
sounds very similar to the other case where they are essentially the same thing.
On the other hand, this is internal API and not userspace ABI, so having a
separate name might not be so bad, especially if there is a chance we would ever
have both at the same time.

[1]: https://lore.kernel.org/linux-iio/20250112122047.1e1978e0@jic23-huawei/
[2]: https://web.git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/drivers/iio/industrialio-backend.c?h=testing&id=22894e0be908791e3df011cdfac02589c2f340bd

> + * @back: Backend device
> + * @rate: Rate in decimal
> +
> + * Return:
> + * 0 on success, negative error number on failure.
> + */
> +
> +int iio_backend_set_dec_rate(struct iio_backend *back, unsigned int rate)
> +{
> +	if (!rate)
> +		return -EINVAL;
> +
> +	return iio_backend_op_call(back, set_dec_rate, rate);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_set_dec_rate, "IIO_BACKEND");
> +

