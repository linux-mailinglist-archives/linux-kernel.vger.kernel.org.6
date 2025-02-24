Return-Path: <linux-kernel+bounces-528403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B14A41751
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69E018823E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D3718C337;
	Mon, 24 Feb 2025 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHvEhz9k"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA501802AB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385740; cv=none; b=jyax/nbW6ZFPXoTvLRtMgDA/mRnKBrttqmRH+5hTHtL3tz6j1OYhffL5YijZECCXBSuEQbJrSeS+mkBzo0HOHKb7CO8XViRvSoyUzQiIj111EXT0KdeetA5YwS7s2WTYCfVAN8ke3i1ZdeXZ/0z+I2giqICki+ZIG+Ct6GTvaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385740; c=relaxed/simple;
	bh=iG/gbpIu8ki+05lXVs5IYA2d2rG5ktSTJr1LC9IwPXs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DFbJloux/9a1Z8MW11Awp6SLQ+d0MMPatrTN9qbCtZ9qLPHAf+7vQqfPVqgswNwaQ2Wqj4rFQRkdtR7rBRj+gBpZr+UlVZVJ5Kz1cXU6UyV4oSAEKZOTuPHuWwQiwY+dxn+igpamkJAZ5OwPZHD1zL4OOTNjXcqNa1GFQrb5PuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yHvEhz9k; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394a823036so39005575e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740385736; x=1740990536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1kQGgjzd05hukTshiy7BWPcG9D//0pTMMM4QHvnA3I=;
        b=yHvEhz9kmV5w5YirGWORuP3M8nsee6kUO5CXKbiZigzvfG3c37a0YU5S2lp4rTctfm
         4/sUbPV5CJcs9M1a5bU/1SgbB/ZxgejgnYBsM2rb6vsJJSO6SxbOYKvlnN05c+GkGD4A
         3JWBQSOt42s54GMX4bWa0kY9XT5+x0qBAKguT/A9tZoYYexnqpZNoejmPiR61IoUTe8y
         wGHLIznJ/oLteDbBB913nuWpQjjRWVYQIda9XQSUcpluHV77RU6+AHq+3/XfDCkZ98Bj
         cW34gzPfb12KomUclLgjNTkAf/gH7ZfVZs1uulGTjcsD8GqflgkWhEC5+NgOKOjaIT18
         dVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740385736; x=1740990536;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l1kQGgjzd05hukTshiy7BWPcG9D//0pTMMM4QHvnA3I=;
        b=t/xWQFj7WqGSPsnI/ICp4qwTHMcsGCBTJD7+KDQiEvHJhxGUzU+PqBqAd+vBy/SvPq
         DGm+XctKyuQlIjDoEDzZVXDJaxISwLO1wQ35aFokdle3OtG26BKv0Q+c5c9RrH/ImiSf
         KqQbNIoyYbyuD9efBoFTMhwpQoKGhsUCqqujyuFSm7Iu6Qr+eYDDj/8JzfgeZ0MqJIBt
         pccPz9I6h5ovrEduibZ//qhqPkr72SQ3uuBF7FQTNoyZVvrTGVOkFb3i4Wx/yH19oGFa
         lIimnjo6MK0PtCWQc/lRwtxQr20RUcLlUtlkBIz5VzKUrArKvd3XIwynqHgOcpwajEC0
         fDRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb1u8bOdrf3qaLSQFgcniYdx0Ecbd4XL5uTjWQUQXHGLv/RWbWXYjJFfzXNvn5UbddzowRVDSI/1TEfZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXgpjBSO2ziB0As/yY8Hf94yoV54oHdlrriCcKUyLMUnR+9JeN
	kcCH3wlDtj9/B3vEBoNdhVJTqWiES2la9KVZvI1OGjxZysG26p1/KsZQe3Hqm80=
X-Gm-Gg: ASbGncsPS9nXaGquk1yRmjHwKsAPvIy7Hu4d89cD0sKerZnKl3d11Po0Zph1tBpj90k
	CZX0sW5PYR58YCqI/fCMl+BvOkw75d8xm5NZyPy8KV1zTFwSP89H/wdRvh6Cq51HisW2YuX+VJS
	sOcT7VvkuirxErYKDOiCX/ZuOpDogXkikTjJQmsLUt39qp+qUPWBaY/kgNPSD062nNoI/PGJ3u/
	Qm+tK7JtCdOJd8jF8/Qoyee5DlXzfqGlH1XR77FYEqLTbgVe0IsUmB85sn0yM8CNsinj1CMag3B
	Yxg0d6/CBeF6KeMTJuDg+7L6PIYpVU/6QpH5aypzKCOKqAvz6XXmvBD0H0VNQwbiYuxZ8zQkuMA
	Vvo8=
X-Google-Smtp-Source: AGHT+IGs12XXB87aYs+IMMh7WTbPwxRKnJrN0p/eD3o6jTaDeh13B2caYsmeyimLto+XK/qJM/dw4A==
X-Received: by 2002:a05:600c:350a:b0:439:9b82:d6b2 with SMTP id 5b1f17b1804b1-439aeb34f86mr114349585e9.16.1740385735936;
        Mon, 24 Feb 2025 00:28:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:825b:5392:ef70:cc0b? ([2a01:e0a:982:cbb0:825b:5392:ef70:cc0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02d519dsm96983365e9.11.2025.02.24.00.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 00:28:55 -0800 (PST)
Message-ID: <6ad69aad-417c-479c-b02f-121faefa722b@linaro.org>
Date: Mon, 24 Feb 2025 09:28:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/2] Input: goodix_berlin - Add support for Berlin-A
 series
To: Jens Reidel <adrian@travitia.xyz>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bastien Nocera <hadess@hadess.net>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Luca Weiss <luca.weiss@fairphone.com>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 phone-devel@vger.kernel.org, linux@mainlining.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20250214052959.222668-1-adrian@travitia.xyz>
 <20250214052959.222668-3-adrian@travitia.xyz>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250214052959.222668-3-adrian@travitia.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 14/02/2025 06:29, Jens Reidel wrote:
> The current implementation of the goodix_berlin driver lacks support for
> revisions A and B of the Berlin IC. This change adds support for the
> gt9897 IC, which is a Berlin-A revision part.
> 
> The differences between revision D and A are rather minor, a handful of
> address changes and a slightly larger read buffer. They were taken from
> the driver published by Goodix, which does a few more things that don't
> appear to be necessary for the touchscreen to work properly.
> 
> Signed-off-by: Jens Reidel <adrian@travitia.xyz>
> Tested-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/input/touchscreen/goodix_berlin.h     | 13 ++++++
>   .../input/touchscreen/goodix_berlin_core.c    | 15 ++++---
>   drivers/input/touchscreen/goodix_berlin_i2c.c |  9 +++-
>   drivers/input/touchscreen/goodix_berlin_spi.c | 45 ++++++++++++++-----
>   4 files changed, 61 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix_berlin.h b/drivers/input/touchscreen/goodix_berlin.h
> index 38b6f9ddbdef..b186a7fb3586 100644
> --- a/drivers/input/touchscreen/goodix_berlin.h
> +++ b/drivers/input/touchscreen/goodix_berlin.h
> @@ -12,6 +12,19 @@
>   
>   #include <linux/pm.h>
>   
> +#define GOODIX_BERLIN_FW_VERSION_INFO_ADDR_A	0x1000C
> +#define GOODIX_BERLIN_FW_VERSION_INFO_ADDR_D	0x10014
> +
> +#define GOODIX_BERLIN_IC_INFO_ADDR_A		0x10068
> +#define GOODIX_BERLIN_IC_INFO_ADDR_D		0x10070
> +
> +struct goodix_berlin_ic_data {
> +	int fw_version_info_addr;
> +	int ic_info_addr;
> +	ssize_t read_dummy_len;
> +	ssize_t read_prefix_len;
> +};
> +
>   struct device;
>   struct input_id;
>   struct regmap;
> diff --git a/drivers/input/touchscreen/goodix_berlin_core.c b/drivers/input/touchscreen/goodix_berlin_core.c
> index 3fc03cf0ca23..f9fbde63ab52 100644
> --- a/drivers/input/touchscreen/goodix_berlin_core.c
> +++ b/drivers/input/touchscreen/goodix_berlin_core.c
> @@ -12,7 +12,7 @@
>    * to the previous generations.
>    *
>    * Currently the driver only handles Multitouch events with already
> - * programmed firmware and "config" for "Revision D" Berlin IC.
> + * programmed firmware and "config" for "Revision A/D" Berlin IC.
>    *
>    * Support is missing for:
>    * - ESD Management
> @@ -20,7 +20,7 @@
>    * - "Config" update/flashing
>    * - Stylus Events
>    * - Gesture Events
> - * - Support for older revisions (A & B)
> + * - Support for revision B
>    */
>   
>   #include <linux/bitfield.h>
> @@ -28,6 +28,7 @@
>   #include <linux/input.h>
>   #include <linux/input/mt.h>
>   #include <linux/input/touchscreen.h>
> +#include <linux/property.h>
>   #include <linux/regmap.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/sizes.h>
> @@ -53,10 +54,8 @@
>   
>   #define GOODIX_BERLIN_DEV_CONFIRM_VAL		0xAA
>   #define GOODIX_BERLIN_BOOTOPTION_ADDR		0x10000
> -#define GOODIX_BERLIN_FW_VERSION_INFO_ADDR	0x10014
>   
>   #define GOODIX_BERLIN_IC_INFO_MAX_LEN		SZ_1K
> -#define GOODIX_BERLIN_IC_INFO_ADDR		0x10070
>   
>   #define GOODIX_BERLIN_CHECKSUM_SIZE		sizeof(u16)
>   
> @@ -297,9 +296,10 @@ static void goodix_berlin_power_off(struct goodix_berlin_core *cd)
>   
>   static int goodix_berlin_read_version(struct goodix_berlin_core *cd)
>   {
> +	const struct goodix_berlin_ic_data *ic_data = device_get_match_data(cd->dev);

This won't fully work, device_get_match_data() will only get the of_device_id match
data, and not the spi_device_id or i2c_device_id ones.

Instead add a const goodix_berlin_ic_data pointer in struct goodix_berlin_core and
store the match data retrieved by spi_get_device_match_data() or i2c_get_match_data()
from the i2c/spi probe and drop any usage of device_get_match_data().

Neil

>   	int error;
>   
> -	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_FW_VERSION_INFO_ADDR,
> +	error = regmap_raw_read(cd->regmap, ic_data->fw_version_info_addr,
>   				&cd->fw_version, sizeof(cd->fw_version));
>   	if (error) {
>   		dev_err(cd->dev, "error reading fw version, %d\n", error);
> @@ -358,6 +358,7 @@ static int goodix_berlin_parse_ic_info(struct goodix_berlin_core *cd,
>   
>   static int goodix_berlin_get_ic_info(struct goodix_berlin_core *cd)
>   {
> +	const struct goodix_berlin_ic_data *ic_data = device_get_match_data(cd->dev);
>   	u8 *afe_data __free(kfree) = NULL;
>   	__le16 length_raw;
>   	u16 length;
> @@ -367,7 +368,7 @@ static int goodix_berlin_get_ic_info(struct goodix_berlin_core *cd)
>   	if (!afe_data)
>   		return -ENOMEM;
>   
> -	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_IC_INFO_ADDR,
> +	error = regmap_raw_read(cd->regmap, ic_data->ic_info_addr,
>   				&length_raw, sizeof(length_raw));
>   	if (error) {
>   		dev_err(cd->dev, "failed get ic info length, %d\n", error);
> @@ -380,7 +381,7 @@ static int goodix_berlin_get_ic_info(struct goodix_berlin_core *cd)
>   		return -EINVAL;
>   	}
>   
> -	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_IC_INFO_ADDR,
> +	error = regmap_raw_read(cd->regmap, ic_data->ic_info_addr,
>   				afe_data, length);
>   	if (error) {
>   		dev_err(cd->dev, "failed get ic info data, %d\n", error);
> diff --git a/drivers/input/touchscreen/goodix_berlin_i2c.c b/drivers/input/touchscreen/goodix_berlin_i2c.c
> index ad7a60d94338..7db234c74db8 100644
> --- a/drivers/input/touchscreen/goodix_berlin_i2c.c
> +++ b/drivers/input/touchscreen/goodix_berlin_i2c.c
> @@ -46,15 +46,20 @@ static int goodix_berlin_i2c_probe(struct i2c_client *client)
>   	return 0;
>   }
>   
> +static const struct goodix_berlin_ic_data gt9916_data = {
> +	.fw_version_info_addr = GOODIX_BERLIN_FW_VERSION_INFO_ADDR_D,
> +	.ic_info_addr = GOODIX_BERLIN_IC_INFO_ADDR_D,
> +};
> +
>   static const struct i2c_device_id goodix_berlin_i2c_id[] = {
> -	{ "gt9916" },
> +	{ .name = "gt9916", .driver_data = (long)&gt9916_data },
>   	{ }
>   };
>   
>   MODULE_DEVICE_TABLE(i2c, goodix_berlin_i2c_id);
>   
>   static const struct of_device_id goodix_berlin_i2c_of_match[] = {
> -	{ .compatible = "goodix,gt9916", },
> +	{ .compatible = "goodix,gt9916", .data = &gt9916_data },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, goodix_berlin_i2c_of_match);
> diff --git a/drivers/input/touchscreen/goodix_berlin_spi.c b/drivers/input/touchscreen/goodix_berlin_spi.c
> index 0662e87b8692..a5e77e6585e8 100644
> --- a/drivers/input/touchscreen/goodix_berlin_spi.c
> +++ b/drivers/input/touchscreen/goodix_berlin_spi.c
> @@ -18,10 +18,14 @@
>   
>   #define GOODIX_BERLIN_SPI_TRANS_PREFIX_LEN	1
>   #define GOODIX_BERLIN_REGISTER_WIDTH		4
> -#define GOODIX_BERLIN_SPI_READ_DUMMY_LEN	3
> -#define GOODIX_BERLIN_SPI_READ_PREFIX_LEN	(GOODIX_BERLIN_SPI_TRANS_PREFIX_LEN + \
> +#define GOODIX_BERLIN_SPI_READ_DUMMY_LEN_A	4
> +#define GOODIX_BERLIN_SPI_READ_DUMMY_LEN_D	3
> +#define GOODIX_BERLIN_SPI_READ_PREFIX_LEN_A	(GOODIX_BERLIN_SPI_TRANS_PREFIX_LEN + \
>   						 GOODIX_BERLIN_REGISTER_WIDTH + \
> -						 GOODIX_BERLIN_SPI_READ_DUMMY_LEN)
> +						 GOODIX_BERLIN_SPI_READ_DUMMY_LEN_A)
> +#define GOODIX_BERLIN_SPI_READ_PREFIX_LEN_D	(GOODIX_BERLIN_SPI_TRANS_PREFIX_LEN + \
> +						 GOODIX_BERLIN_REGISTER_WIDTH + \
> +						 GOODIX_BERLIN_SPI_READ_DUMMY_LEN_D)
>   #define GOODIX_BERLIN_SPI_WRITE_PREFIX_LEN	(GOODIX_BERLIN_SPI_TRANS_PREFIX_LEN + \
>   						 GOODIX_BERLIN_REGISTER_WIDTH)
>   
> @@ -33,6 +37,7 @@ static int goodix_berlin_spi_read(void *context, const void *reg_buf,
>   				  size_t val_size)
>   {
>   	struct spi_device *spi = context;
> +	const struct goodix_berlin_ic_data *ic_data = spi_get_device_match_data(spi);
>   	struct spi_transfer xfers;
>   	struct spi_message spi_msg;
>   	const u32 *reg = reg_buf; /* reg is stored as native u32 at start of buffer */
> @@ -42,23 +47,22 @@ static int goodix_berlin_spi_read(void *context, const void *reg_buf,
>   		return -EINVAL;
>   
>   	u8 *buf __free(kfree) =
> -		kzalloc(GOODIX_BERLIN_SPI_READ_PREFIX_LEN + val_size,
> -			GFP_KERNEL);
> +		kzalloc(ic_data->read_prefix_len + val_size, GFP_KERNEL);
>   	if (!buf)
>   		return -ENOMEM;
>   
>   	spi_message_init(&spi_msg);
>   	memset(&xfers, 0, sizeof(xfers));
>   
> -	/* buffer format: 0xF1 + addr(4bytes) + dummy(3bytes) + data */
> +	/* buffer format: 0xF1 + addr(4bytes) + dummy(3/4bytes) + data */
>   	buf[0] = GOODIX_BERLIN_SPI_READ_FLAG;
>   	put_unaligned_be32(*reg, buf + GOODIX_BERLIN_SPI_TRANS_PREFIX_LEN);
>   	memset(buf + GOODIX_BERLIN_SPI_TRANS_PREFIX_LEN + GOODIX_BERLIN_REGISTER_WIDTH,
> -	       0xff, GOODIX_BERLIN_SPI_READ_DUMMY_LEN);
> +	       0xff, ic_data->read_dummy_len);
>   
>   	xfers.tx_buf = buf;
>   	xfers.rx_buf = buf;
> -	xfers.len = GOODIX_BERLIN_SPI_READ_PREFIX_LEN + val_size;
> +	xfers.len = ic_data->read_prefix_len + val_size;
>   	xfers.cs_change = 0;
>   	spi_message_add_tail(&xfers, &spi_msg);
>   
> @@ -68,7 +72,7 @@ static int goodix_berlin_spi_read(void *context, const void *reg_buf,
>   		return error;
>   	}
>   
> -	memcpy(val_buf, buf + GOODIX_BERLIN_SPI_READ_PREFIX_LEN, val_size);
> +	memcpy(val_buf, buf + ic_data->read_prefix_len, val_size);
>   	return error;
>   }
>   
> @@ -123,6 +127,7 @@ static const struct input_id goodix_berlin_spi_input_id = {
>   
>   static int goodix_berlin_spi_probe(struct spi_device *spi)
>   {
> +	const struct goodix_berlin_ic_data *ic_data = spi_get_device_match_data(spi);
>   	struct regmap_config regmap_config;
>   	struct regmap *regmap;
>   	size_t max_size;
> @@ -137,7 +142,7 @@ static int goodix_berlin_spi_probe(struct spi_device *spi)
>   	max_size = spi_max_transfer_size(spi);
>   
>   	regmap_config = goodix_berlin_spi_regmap_conf;
> -	regmap_config.max_raw_read = max_size - GOODIX_BERLIN_SPI_READ_PREFIX_LEN;
> +	regmap_config.max_raw_read = max_size - ic_data->read_prefix_len;
>   	regmap_config.max_raw_write = max_size - GOODIX_BERLIN_SPI_WRITE_PREFIX_LEN;
>   
>   	regmap = devm_regmap_init(&spi->dev, NULL, spi, &regmap_config);
> @@ -152,14 +157,30 @@ static int goodix_berlin_spi_probe(struct spi_device *spi)
>   	return 0;
>   }
>   
> +static const struct goodix_berlin_ic_data gt9897_data = {
> +	.fw_version_info_addr = GOODIX_BERLIN_FW_VERSION_INFO_ADDR_A,
> +	.ic_info_addr = GOODIX_BERLIN_IC_INFO_ADDR_A,
> +	.read_dummy_len = GOODIX_BERLIN_SPI_READ_DUMMY_LEN_A,
> +	.read_prefix_len = GOODIX_BERLIN_SPI_READ_PREFIX_LEN_A,
> +};
> +
> +static const struct goodix_berlin_ic_data gt9916_data = {
> +	.fw_version_info_addr = GOODIX_BERLIN_FW_VERSION_INFO_ADDR_D,
> +	.ic_info_addr = GOODIX_BERLIN_IC_INFO_ADDR_D,
> +	.read_dummy_len = GOODIX_BERLIN_SPI_READ_DUMMY_LEN_D,
> +	.read_prefix_len = GOODIX_BERLIN_SPI_READ_PREFIX_LEN_D,
> +};
> +
>   static const struct spi_device_id goodix_berlin_spi_ids[] = {
> -	{ "gt9916" },
> +	{ .name = "gt9897", .driver_data = (long)&gt9897_data },
> +	{ .name = "gt9916", .driver_data = (long)&gt9916_data },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(spi, goodix_berlin_spi_ids);
>   
>   static const struct of_device_id goodix_berlin_spi_of_match[] = {
> -	{ .compatible = "goodix,gt9916", },
> +	{ .compatible = "goodix,gt9897", .data = &gt9897_data },
> +	{ .compatible = "goodix,gt9916", .data = &gt9916_data },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, goodix_berlin_spi_of_match);


