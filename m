Return-Path: <linux-kernel+bounces-254843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B13933860
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02FB283D5B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D7F1CD16;
	Wed, 17 Jul 2024 07:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2wuJnYs"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666D522616
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721203022; cv=none; b=Hgua6nrnLsS0t6iPh9Apd7Rv9L/ld8sHqCrmuRmfpENr++M0l6Ndzpc7onJKpGnkiJoUErCMTeSUM8GMXG+GOyr3uaXDp5W/CW/wsJKaOC3kBbfRqGJFn31z90L7MXm0XHtjW8HHv0wDrbOVGNAKWIRRaxlM7lD4iSSdiRqd2Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721203022; c=relaxed/simple;
	bh=gOQIhVwlUv2eV47vH5ppdulwGYt5SzMln0kAJPHsrV0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kw9ExEoQlh9AOTzBmk+hn5vB39Ccdh0Ckgxuh/9iYlhFA77f3lp4XI9c8Hz9WfSO8UKWf5mERbbFDmyUTP/8O4o5saqR0TrXBPLkSXMp0xYTxjxcZ9KVfpdhxMF9Kq4eJ2HtR4Oj8DhZS4I97ByGmSoZ2/W83ebk3sBcn6w5jc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A2wuJnYs; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4266fd395eeso45275875e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721203019; x=1721807819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/z2Dk0w9xhkDO1EnnbnjHajHb+TSL/Zs7A5uSiMV1RU=;
        b=A2wuJnYsL9HLX/fWL7Z2JOG0ArV9wkSaoT+pQKHZv7luPUiaMoT9j0R9bK/pQINcEZ
         EfJ+CNMyf6rjtTHt6RdPGHawHBK1QPC4DvNqTwbzls1ok4gzAUxd86KfRpX0zObMPPaZ
         DScMq44UUu27WJURwUCzwHBhwOw3zbkiKe7y9EJOy2u3N3Zs4DqMjTm4DGBQpnxn8CTx
         j2EkiWQybO6/Vd3oL91zbLDWknhByFrSRWPKsd9Tbldz27eURPb6F2rYPR204QHLp3Ap
         uq89+FqsS+qIleHXdmREqnh2pPiprtp9PVpWsFz09WUMfXX95ZsToIyXgEiBV2GQ2uw9
         /O0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721203019; x=1721807819;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/z2Dk0w9xhkDO1EnnbnjHajHb+TSL/Zs7A5uSiMV1RU=;
        b=njPxT3LtrqGDcjYbir4lfE/14sdg5OwxEjrEkMsqu/9g6YXgyBOtjhRzsgz4qa8/mP
         OgmdT6k2EynSxujnRXrzI5jMx5lt/lDHiJavAEWybgbujYbAZ/Ir5djilBvTEsw8hcNW
         2xGXcTnGLpdj5U7Ej0aVt5oTgjqpwVOKmR6+D2WuQMgtKlUo+b5wy/gzkD4Ia0JmJfF+
         DJ4JD4S6tTNOWIgq62kKDrjALKjP6JiqNsNSUwvaxghVTkvEIIFsEbri0+dgKkJxMbXE
         nqbwe8fS0xQ6pLyAAdshQxSuhDtWvCWMWCr106v/WMxuJgOZ1XMe6yJdJIWoEl93JzPW
         HOoA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ7o/aVRXilwMnoJlNtefdrMnJLYmzPD6NAzK+o/PP56YyjPMNpCakcy3pxhLzOiMdyZg2XGeiTQLHQpmBSF01iAF/+xokEIYqiS4L
X-Gm-Message-State: AOJu0YxXDZ0pAKX+CSbJIgxAsHzFV/BrHBsS8PgLqSvUL5ppB4fGleil
	9psUcp3l0rNFWbBS6ayeDYIQubHNCv1HhzTNZxCU5JGLvts32Lgtkwm8FhHSsN0=
X-Google-Smtp-Source: AGHT+IFTy8c9UCCsxgJAFU5uC3fKaWL8SWqf1jjti9B5styvGlmZXCFH7iXEA2pTbA1qsBmrijZl8Q==
X-Received: by 2002:a05:6000:1fa6:b0:368:38af:9a2e with SMTP id ffacd0b85a97d-36838af9ceemr398786f8f.21.1721203018298;
        Wed, 17 Jul 2024 00:56:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:c5b9:9b90:b1c4:1a1d? ([2a01:e0a:982:cbb0:c5b9:9b90:b1c4:1a1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafba03sm11005798f8f.76.2024.07.17.00.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 00:56:57 -0700 (PDT)
Message-ID: <06f1b509-220e-415b-a24b-7fe8dc796328@linaro.org>
Date: Wed, 17 Jul 2024 09:56:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 4/4] usb: typec: ucsi: Fix SET_PDR typo in UCSI header
 file
To: Jameson Thies <jthies@google.com>, heikki.krogerus@linux.intel.com,
 linux-usb@vger.kernel.org
Cc: bleung@google.com, abhishekpandit@chromium.org, andersson@kernel.org,
 dmitry.baryshkov@linaro.org, fabrice.gasnier@foss.st.com,
 gregkh@linuxfoundation.org, hdegoede@redhat.com,
 rajaram.regupathy@intel.com, saranya.gopal@intel.com,
 linux-kernel@vger.kernel.org
References: <20240717004949.3638557-1-jthies@google.com>
 <20240717004949.3638557-5-jthies@google.com>
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
In-Reply-To: <20240717004949.3638557-5-jthies@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/2024 02:49, Jameson Thies wrote:
> Fix SET_PDR typo in UCSI header file.
> 
> Signed-off-by: Jameson Thies <jthies@google.com>
> ---
>   drivers/usb/typec/ucsi/ucsi.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
> index 57129f3c0814..375f1881c1e2 100644
> --- a/drivers/usb/typec/ucsi/ucsi.h
> +++ b/drivers/usb/typec/ucsi/ucsi.h
> @@ -152,7 +152,7 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num);
>   #define UCSI_SET_UOR_ROLE(_r_)		(((_r_) == TYPEC_HOST ? 1 : 2) << 23)
>   #define UCSI_SET_UOR_ACCEPT_ROLE_SWAPS		BIT(25)
>   
> -/* SET_PDF command bits */
> +/* SET_PDR command bits */
>   #define UCSI_SET_PDR_ROLE(_r_)		(((_r_) == TYPEC_SOURCE ? 1 : 2) << 23)
>   #define UCSI_SET_PDR_ACCEPT_ROLE_SWAPS		BIT(25)
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

