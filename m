Return-Path: <linux-kernel+bounces-252198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F171930FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA31C281BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE30E1849F1;
	Mon, 15 Jul 2024 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLujtTw8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8CF2572
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032255; cv=none; b=BsgKVsNTF+eWcBsbmOzy9XDpHHU9aKdiEdomgYb32p7lDWi88Bp5FN+3FLYRduqJzXaSEf4hfjoAEBvHZU8dSyB6EbZYHXuxyU4fHZZTWYeSb64DT42Mqjhpx18ZPE9zoJpuCWo/xw5PvMSVBbi1ZH5dQgr+D3HrQvIEMJFlxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032255; c=relaxed/simple;
	bh=+1/E7nz2cgztKWaRiX5gV2VSBb3LIiu/RsBICgWkEw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZsyXUsex0CzqdHPYCkKNSsMfnkofRLraLCFRawA8ZSHfX3df5Dt9Y+J79/l4jDXVzUiUye8DfgjYlFE1ttJL31E/Kc/NF0y7lwZDjbNO/CzsVqidvG/J2LDZSiUM4xOMB9sc14GlF1S2AVHIBV2kf61MbNnoCy3w1XnJOwrIJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLujtTw8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721032251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWXi1fxR2pAp3kgUhHC9kifjMGGJD4BLGwaCgaR3j84=;
	b=GLujtTw8vWcA9SUck/4m5gaytLyXP8WwfX5ji9EqGkvkFAzg1Z0cVD8+jmlkrI7Dux5sVs
	Guk9tWvQkvJpRI2cOIaueNvAZ3LjPMAtJejOO1mdx/xBkY26f9mzpoTiwsxuMjAtvwKZIr
	sWvMRKfzgePUYVwOvs32bAzZcikbOCQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-nsUI8LW3Nhu1ZyOt_Ymy9A-1; Mon, 15 Jul 2024 04:30:50 -0400
X-MC-Unique: nsUI8LW3Nhu1ZyOt_Ymy9A-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-58d6fdee657so3858854a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 01:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721032249; x=1721637049;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWXi1fxR2pAp3kgUhHC9kifjMGGJD4BLGwaCgaR3j84=;
        b=QLaEAro/g0sZqF8zn1SuETHmlz2MwyWG5umALtouolzgaAfuytLWf6Kti2K4K0aGaJ
         skEzHNVAUxE2DW9kGmd3fVTSUpwFL94uNHe/HFLHXwscpDEEAXvnRqQpHIwdagzH7pKn
         M5ejVyut+Zc7vsaD2g3iK4QqDx15oDgw9gEZVdyycnDRHeMpbp+h91XUt9m6HIcsm//s
         J5UGUynK8jaYmPndk7G6ThkbPRuxVldP8zMZ2VpBoTp+tf5JUwuDJBGsUoTUAZ4gsEVp
         BIypwpkgv+7c5dHbHpbb4pjm0kkNZQUKQzae90/n+MTFOHp4/1nVFlWg7J68F40p/Jdh
         NKJA==
X-Forwarded-Encrypted: i=1; AJvYcCWl1ettc4O/mSOFVVLEpKPI/SYlP3faGSJpfK5MXyH1AnA9IwVvNMIEomHHl+UgmWaMOUccgLCKipxD+DQMOu8Ez787oyTfB37JZ0TY
X-Gm-Message-State: AOJu0YzT/SK8IeYthm+PznGO88xLtdFh1a1S+HrqD7bQef7XwjumPC/1
	lLnf/107Wbvifvle0J6cWw3VccCwRHENzBT7vEnIxIrioir6GF+ebrHuejj1fR7Ur+S6L3dh1iN
	6xoLzHRtcl6YHHjiVwAaRtWmGSZXgK2eDxKcKcI3KV8s459mzpZMibZqBn76xVg==
X-Received: by 2002:a17:907:94c7:b0:a72:8a75:6559 with SMTP id a640c23a62f3a-a780b884495mr1463542466b.47.1721032248798;
        Mon, 15 Jul 2024 01:30:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEne3HPmwCYIiZcxI0J78LWeiGMHddXNYIBZCspIEDNUlljKwv120zbOJeXr389b8IYutZdAw==
X-Received: by 2002:a17:907:94c7:b0:a72:8a75:6559 with SMTP id a640c23a62f3a-a780b884495mr1463540266b.47.1721032248465;
        Mon, 15 Jul 2024 01:30:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5d00b8sm192741966b.83.2024.07.15.01.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 01:30:48 -0700 (PDT)
Message-ID: <823ce598-dffd-4983-bffa-32559558235d@redhat.com>
Date: Mon, 15 Jul 2024 10:30:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: accel: kxcjk-1013: Add support for KX022-1020
To: Rayyan Ansari <rayyan@ansari.sh>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael@kernel.org>, Robert Yang <decatf@gmail.com>,
 Rob Herring <robh@kernel.org>, Sean Rhodes <sean@starlabs.systems>
References: <20240714173431.54332-1-rayyan@ansari.sh>
 <20240714173431.54332-3-rayyan@ansari.sh>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240714173431.54332-3-rayyan@ansari.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/14/24 7:33 PM, Rayyan Ansari wrote:
> Add compatible for the KX022-1020 accelerometer [1] using the
> KX022-1023 [2] register map as both have an identical i2c interface.
> 
> [1]: https://kionixfs.azureedge.net/en/datasheet/KX022-1020%20Specifications%20Rev%2012.0.pdf
> [2]: https://kionixfs.azureedge.net/en/datasheet/KX023-1025%20Specifications%20Rev%2012.0.pdf
> 
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/iio/accel/kxcjk-1013.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 8280d2bef0a3..b76df8816323 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -173,6 +173,7 @@ enum kx_chipset {
>  	KXCJ91008,
>  	KXTJ21009,
>  	KXTF9,
> +	KX0221020,
>  	KX0231025,
>  	KX_MAX_CHIPS /* this must be last */
>  };
> @@ -580,8 +581,8 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
>  		return ret;
>  	}
>  
> -	/* On KX023, route all used interrupts to INT1 for now */
> -	if (data->chipset == KX0231025 && data->client->irq > 0) {
> +	/* On KX023 and KX022, route all used interrupts to INT1 for now */
> +	if ((data->chipset == KX0231025 || data->chipset == KX0221020) && data->client->irq > 0) {
>  		ret = i2c_smbus_write_byte_data(data->client, KX023_REG_INC4,
>  						KX023_REG_INC4_DRDY1 |
>  						KX023_REG_INC4_WUFI1);
> @@ -1507,6 +1508,7 @@ static int kxcjk1013_probe(struct i2c_client *client)
>  	case KXTF9:
>  		data->regs = &kxtf9_regs;
>  		break;
> +	case KX0221020:
>  	case KX0231025:
>  		data->regs = &kx0231025_regs;
>  		break;
> @@ -1712,6 +1714,7 @@ static const struct i2c_device_id kxcjk1013_id[] = {
>  	{"kxcj91008", KXCJ91008},
>  	{"kxtj21009", KXTJ21009},
>  	{"kxtf9",     KXTF9},
> +	{"kx022-1020", KX0221020},
>  	{"kx023-1025", KX0231025},
>  	{"SMO8500",   KXCJ91008},
>  	{}
> @@ -1724,6 +1727,7 @@ static const struct of_device_id kxcjk1013_of_match[] = {
>  	{ .compatible = "kionix,kxcj91008", },
>  	{ .compatible = "kionix,kxtj21009", },
>  	{ .compatible = "kionix,kxtf9", },
> +	{ .compatible = "kionix,kx022-1020", },
>  	{ .compatible = "kionix,kx023-1025", },
>  	{ }
>  };


