Return-Path: <linux-kernel+bounces-194244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661DD8D38DC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8975A1C20FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604301459E3;
	Wed, 29 May 2024 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alXnCIxL"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6BE144D34;
	Wed, 29 May 2024 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991888; cv=none; b=PUc0vDmCjqdanm39oxMI7MyKK9jaTH+TmaPVHtknf2S77YFFyRbLscld4MYiY9bznFfpTkb8xY6ibhf/mWgggVwTcvexuTIh6gGTMNy7Ve+Y4KyXPS9iB/aXSaeO0hSL6cLNgRtxItP9kGdJOFcXqQ8V6Kf9EDcP6PW3LE1VGys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991888; c=relaxed/simple;
	bh=nvya7ZlgACfFyatqNIXscH2VuvYtZOyEAo4x90jdgfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7nLEmvqR9+iA+iT0/clLZuxTBXPfGxBwvgAWW8871fHrYk7qG6ugdJQNtjmTJX6rjboe+tj9upUjJT3Ga/nwfFKQ47kQV7+c8O4+rHBNLagrQvoD53LIJ1oEXAOJJHbnRUK8TEZunf4ldONLArVFfAZtyKLLaWZfT8Dv5aKR1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=alXnCIxL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f60a502bb2so1683245ad.3;
        Wed, 29 May 2024 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716991886; x=1717596686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EoBQc0kl6LB1qi1fWgBiA7CgfTFpaSH0Gsxy+hQaR7Q=;
        b=alXnCIxLQpzGzmG5G8tihUjC+OyArhAtte8eIWfQ6U6nRbvdI1RRXrjF4FdURf+i6e
         HeDBvVowCxhpkREQYdr+ijuOQhTQ+MWWWKXiLJIA9Iac+ujt14JYEGGUIuCkv/0kGq6n
         CLEcyNU08KzKnX+3ibm8vHwtB2Ytcu3AIw1G+j42ayW7yTdwfJzCATFyha3qlSYGJqqE
         ixEEUx2+AZhd8LGHBFNl3RyjRu1ncfUayRoXnHrnHGfIAQDm4L6vnCRbGKgmCkaQ6HB3
         lcN7mENe6O9ksbmhPBTTSzU2aRsOJTxfXCXjSsSldM1IdUu+Fuoqj3Ohx5V7Q8IYjv8U
         PwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716991886; x=1717596686;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoBQc0kl6LB1qi1fWgBiA7CgfTFpaSH0Gsxy+hQaR7Q=;
        b=Jn2uGPJ/fKRXvn0JY2lsCVN8LtTsi5oTzfAT1HfWwLApzpc8JEUxHG84A8eiqzsGsN
         VHLjUozNGTYRzaN7yLZ3S3/IphvtGENjU+Ot3FN/wtML4mQ1ksdLzagJrYn664wP1fmE
         XOC2rhwaZTfu/VKdxGqRSZhNvCLHybArrkOnZsY/t55/dw5ZKNfpump0uK6LbBPYhNCg
         gG05SdHg8Eo+IF8bqJV92X7PNhXat7Z7JbUTvZfaH50v9TimHhAqJykfb0ZnBDo7uKGJ
         whuunY+NhRJP/rQCUkpoUhwWKNXSaEL25gFrFU/CR3oDdC7O9qCHfgE6PlW8ORYwolt2
         XG+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmnHVI/qNga0atDM6z75dyeZzRFy5t2qgyTVz6EHZZGFSzgoNntJ5rAFKmgDKG+m+U6pDJO/NK85nEx/sApkgkyiSOr/CaZxEDcPR+UiiaCpmfEuK2pBOvEdkD/Hvo8ASB44/x1f9EGDij6C4qgQbdkrWpSSb9NPkHlHLFiMsvjBuitd9g
X-Gm-Message-State: AOJu0YztkPCCCwpQ2EYcKlRQmAL416nROiub9AmG7JHUP+QAPUokrS8O
	tj/rSNfPjsLcs+7GzKuiSmDoKLMpX180bO6m+erFO+W8fBbXQFa0
X-Google-Smtp-Source: AGHT+IEyG65qZfUUyugq93mgzzLOsIPM+gy0sf3JZ8+G1Pig5602piIwBHJrHow3OJ6kfXdRQBugGg==
X-Received: by 2002:a17:902:e846:b0:1f4:9e85:9d5f with SMTP id d9443c01a7336-1f49e85a1damr90112945ad.19.1716991885357;
        Wed, 29 May 2024 07:11:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c997d0dsm99891065ad.199.2024.05.29.07.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 07:11:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6b87136a-01e7-4b4b-b36f-632cf59b4760@roeck-us.net>
Date: Wed, 29 May 2024 07:11:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: (ina2xx) Add device tree support to pass
 alert polarity
To: Amna Waseem <Amna.Waseem@axis.com>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@axis.com
References: <20240529-apol-ina2xx-fix-v2-0-ee2d76142de2@axis.com>
 <20240529-apol-ina2xx-fix-v2-2-ee2d76142de2@axis.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240529-apol-ina2xx-fix-v2-2-ee2d76142de2@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 02:47, Amna Waseem wrote:
> The INA230 has an Alert pin which is asserted when the alert
> function selected in the Mask/Enable register exceeds the
> value programmed into the Alert Limit register. Assertion is based
> on the Alert Polarity Bit (APOL, bit 1 of the Mask/Enable register).
> It is default set to value 0 i.e Normal (active-low open collector).
> However, hardware can be designed in such a way that expects Alert pin
> to become active high if a user-defined threshold in Alert limit
> register has been exceeded. This patch adds a way to pass alert polarity
> value to the driver via device tree.
> 
> Signed-off-by: Amna Waseem <Amna.Waseem@axis.com>

Please address my earlier comments, and in the future please wait a few minutes
before sending another version to give people time to provide feedback
on the earlier version(s).

> ---
>   drivers/hwmon/ina2xx.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
> index d8415d1f21fc..9afaabdc367d 100644
> --- a/drivers/hwmon/ina2xx.c
> +++ b/drivers/hwmon/ina2xx.c
> @@ -73,6 +73,9 @@
>   #define INA226_READ_AVG(reg)		(((reg) & INA226_AVG_RD_MASK) >> 9)
>   #define INA226_SHIFT_AVG(val)		((val) << 9)
>   
> +#define INA226_ALERT_POLARITY_MASK		0x0002
> +#define INA226_SHIFT_ALERT_POLARITY(val)	((val) << 1)
> +
>   /* bit number of alert functions in Mask/Enable Register */
>   #define INA226_SHUNT_OVER_VOLTAGE_BIT	15
>   #define INA226_SHUNT_UNDER_VOLTAGE_BIT	14
> @@ -178,6 +181,21 @@ static u16 ina226_interval_to_reg(int interval)
>   	return INA226_SHIFT_AVG(avg_bits);
>   }
>   
> +static int ina2xx_set_alert_polarity(struct ina2xx_data *data,
> +				     unsigned long val)
> +{
> +	int ret;
> +
> +	if (val > INT_MAX || !(val == 0 || val == 1))
> +		return -EINVAL;
> +
> +	ret = regmap_update_bits(data->regmap, INA226_MASK_ENABLE,
> +				 INA226_ALERT_POLARITY_MASK,
> +				 INA226_SHIFT_ALERT_POLARITY(val));
> +
> +	return ret;

ret is an unnecessary variable.
	return regmap_update_bits(...);


> +}
> +
>   /*
>    * Calibration register is set to the best value, which eliminates
>    * truncation errors on calculating current register in hardware.
> @@ -659,6 +677,15 @@ static int ina2xx_probe(struct i2c_client *client)
>   	if (ret)
>   		return dev_err_probe(dev, ret, "failed to enable vs regulator\n");
>   
> +	if (!of_property_read_u32(dev->of_node, "ti,alert-polarity", &val)) {
> +		ret = ina2xx_set_alert_polarity(data, val);
> +		if (ret < 0) {
> +			return dev_err_probe(
> +			   dev, ret,
> +			   "failed to set APOL bit of Enable/Mask register\n");

Line split is still as bad as before.

Guenter


