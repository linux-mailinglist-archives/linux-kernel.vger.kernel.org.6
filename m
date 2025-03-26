Return-Path: <linux-kernel+bounces-577419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F9EA71CC3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F96516B311
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1E21F891C;
	Wed, 26 Mar 2025 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xaTzyJ2M"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0117D1E868
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743009258; cv=none; b=PpDBgRy2UrEUCRGkYxBvGupnBOtDFGkJSY9JbaMAoycjfKwO3R1Wx5HD/QRQsviYerCLkxBuLryKvd63w7Y69hY918Xnkg7Iz4xAhIDlvSDfxChOyBDwAzgoQub+X7PZUtqz1PWadtp0mcyGarwtmZlH5oFNKUUt5xyLInyalag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743009258; c=relaxed/simple;
	bh=+whv4evDGy64r+tSDhIokFOzmu0gIBgVUNUDF3GyFx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8Nau2bPyinyo0/cWfu82eHrQj4/YOHlulcemwg2+Ijmi1cH3Zem70zLnwABJrc7jgXoe+dKBrMlU60lMGkEHMrmqLQEOp4hFUtCd/wKCX9B2+oz7byCM+lE+JCmWlBtiGt9Zn1KvTV8fk++GeT+FgGv9xjNCdXFUqd7RExDdw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xaTzyJ2M; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf7c2c351so85445e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743009255; x=1743614055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CuqCGg1eQPAkW/MRbEsK3o8RtVuoVTX78ZnPAJ2tBZg=;
        b=xaTzyJ2MdmqHZVBH3m2mRtHjXWGllH0hhlFWbQsqiIRbkLHlV95pW4nyMRh5/VER42
         P4RbECmWBhihxJf3x1ktwcBBjENd+dRoQFon9Ur7pDAXbMms1hcQDrGb3UQq8A6X4s1E
         nbKZfjcspTy+c5UVLaYtZJ9zvTkUp6f/qgFolI3a73b3ZHzr9QPsxvS0wkd327AtIjBl
         jnkAApQLdH2xKEVduCv65HEuUuRfH3Tj727LiIN4kbRDxlyRYvIq+IvlOCxY+QObBwPQ
         TL6jttFppqiHNA7tVLnBqhfdueREpvgtkJIp3elgAI7S4r27J/Th5O5UZXjBva5Rs3bn
         Ih8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743009255; x=1743614055;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuqCGg1eQPAkW/MRbEsK3o8RtVuoVTX78ZnPAJ2tBZg=;
        b=tTPc7sgRwpRskQ3aP2KnTsoFea3IGzdkmnHllRwLROoizx7eiuu+Gf6kErw9z5Ch8x
         GSlhZYEsKm3LSiw3LEjqtKaB0kfi5sphEce91kL5xpG64fYtWW3bChSghc6i/28w740Y
         CT74sWLzZHLx5QZTWFgo0N436V6NA2Q2+1loYovx484xKAJr9J/0FUkP6s6NsGngP3op
         pJEhDTD0yjNLAfN9uy0P8Cw7l40IRDKpt5LMFMWdNmPU18CyfW1IMEgvOR7FqcKOFq+0
         P6FuY76Uvb3uwQlnkR1mSWFUe/S+KZ3K+BlpSw8RdEFLcRiRsYgXB64bj9u+unEGi+bG
         M4hw==
X-Forwarded-Encrypted: i=1; AJvYcCUuu9rUHCRpxhZQV5ZFn4xi3BPRV3UqGuVA2fkHj0udzZuaMRVbWXgevzZKIHov0W7u3Wf9AgP8Im5XmIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxry0HoSwQHn4bX610JR6YLIHolgmo8PHyfDOYA6eoA5uifaeLw
	YxWDL3SEyzI++L2QQg2tbwkGjn7VKkA7IfoUHv0HydbT9TmVrreBCT7TidfzVBQ=
X-Gm-Gg: ASbGncvtrBGcaGGZ3pAK4idw8xO34D2Vv1Ryoy0Y2QEHo+rMjNQeANS4VBtz8NcEycQ
	Xrt6TWxWUsgrdYhHKJJngqxa5DAVFn3wzQ1RLm8Ru2gRv4kfW+Im1BZcXS16Cthn5L3Yfv5oH+l
	aCrN08Np4k0zSEnm/YZqt+GgPc3FD/SFJwU7UEfhfH39ulv8v5xfLwuFGeum36cdZnJvQ7UK4mv
	sJ5GQHuOtz+H8PUJ5sLt9hJyJiEh2xwJcZXPTi4fPXlj9GSlnWTe8drqEV87KXsJcbOgzJTS4wP
	MM/VUYgFNsZYZxfijXxWNSVDRfHHc2/F9F10vsQ2zoTaV0mjsxZ7TrtgIEwRxLV54jBWQ5vRrA=
	=
X-Google-Smtp-Source: AGHT+IH0pMOmLg52ydzIRAGz+vqzh8QzEr1moG6oYV/aOV0biMkfZdZIZiyHjdO978n0orP9jbTcfg==
X-Received: by 2002:a05:600c:1548:b0:439:9909:c785 with SMTP id 5b1f17b1804b1-43d8529f4d2mr739745e9.7.1743009255291;
        Wed, 26 Mar 2025 10:14:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82efeacasm8472175e9.23.2025.03.26.10.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 10:14:14 -0700 (PDT)
Message-ID: <658c41d0-734b-4397-9687-80b6a219c61c@linaro.org>
Date: Wed, 26 Mar 2025 18:14:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] power: supply: max77705: Fix error code in
 max77705_get_health()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0ea50e87-2b63-4062-8c2a-17537495f481@stanley.mountain>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <0ea50e87-2b63-4062-8c2a-17537495f481@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2025 15:34, Dan Carpenter wrote:
> Return -EINVAL if the health is bad.  Don't return success.
> 
> Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/power/supply/max77705_charger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
> index 329b430d0e50..0e347353c41e 100644
> --- a/drivers/power/supply/max77705_charger.c
> +++ b/drivers/power/supply/max77705_charger.c
> @@ -285,7 +285,7 @@ static int max77705_get_health(struct max77705_charger_data *charger, int *val)
>  	if (is_online) {
>  		ret = max77705_get_vbus_state(regmap, val);
>  		if (ret || (*val != POWER_SUPPLY_HEALTH_GOOD))
> -			return ret;
> +			return -EINVAL;


I don't think this is right. First, your commit msg should mention why
returning -EINVAL in such case.

Second, if get_vbus_state succeeded, but 'val' is not good (e.g.
overvoltage), the callback is supposed to return 0 as success of
retrieving the data, no? So the user-space can read 'val' and figure out
whatever it needs to figure out (overvoltage).

The EINVAL is when the data could not be read, thus user-space should
ignore 'val'.


Best regards,
Krzysztof

