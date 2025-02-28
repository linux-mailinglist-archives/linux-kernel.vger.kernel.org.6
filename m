Return-Path: <linux-kernel+bounces-537994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE35A4935F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 432D17A3D01
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB86243387;
	Fri, 28 Feb 2025 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wlsOIsU2"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B7B204845
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730962; cv=none; b=bsyWoll73BAqX2fToYfJ9ljAsaoIWmY3qP5oamc5V/B9fLC+K+4V5HTsHXQBwXrfRF0R/KH7FE8JaOAISgt2Qx6t0aSDCdoNuaaKvTY6g1v7R3mfsFsJny2wXBaLzC4zmn0mvEIMvzDoOUTe18H5WhQI9UTPfhiqa9Skb4B4nM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730962; c=relaxed/simple;
	bh=2fDC8q5BPRG+8Lbe1lwlKdfXU4xntYVHW14jlpr/FUQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PyKBqJmnkLHeom6cPMeWIjV0GPmpj18y0yzcLG/VEF6OP99APdCjnSQHIqBSzP0ZI2S7TvmOx3yDTXvTV4oH8247dQVuww+U/8Eh8a9WPef8yRsl/YdeTYi5Q5vhscZbhp3uZ9ZcPggIM7Xp1HaRhrX5DY8O2utSiRONL7V05oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wlsOIsU2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43996e95114so12572855e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740730958; x=1741335758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWBUahnOFyPNyFGFF08VvduuyQVGQsvnK+/x+xqO5Lg=;
        b=wlsOIsU2Sv3t3jUfOvmLRriR3HFUIdLt22bCdhy0kYutYmb+Cy5W4qGcRNtHWqkJLl
         nZWd/CnZuIpYk0KCeRsrHAOEAHCHnlYiW8TyVO576/HGqGRyiHzQ+ePJLoSo5SbGtW9g
         qtjuI2GYI4RAYix8eC2R50j7iFL3UMZB+C0qJ34it/13ySi1hNl292xC15QmolQ0y0AQ
         UYuA+2oJF2EOCZ3rw/Sal7EiS6Ut+8vjjWd0hUMwcciooeoJLdbD4mS2TI0NFJqQQG0c
         HcbIBdf0ARjsteVpOa9Al6Eg4wgNrtGOAskz3QwXbIWPQiLROawr/t47RCsZR0uk/rA0
         H41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740730958; x=1741335758;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RWBUahnOFyPNyFGFF08VvduuyQVGQsvnK+/x+xqO5Lg=;
        b=LWQq25KNIthdzEofpkVQR2eSRQCrDWBzA/XbaLiJCAX8FgeC8gzl1NHg0Czk7akIWP
         /6/X4mIg9TNQvj3bh9zCOVLPoMq282se+QHqdGwO1C8LMSGfS3vIi7nlPj+mzlrwbYo7
         h5HYPmYae0lUorE1vjZseNo1VlV2TTp+qwjZcVeXm+EPjyZymQW1VF4fEO81+SltkB4R
         pIdVOUJLS1lAzN4hEfduT5pFA0D5u5eQRJl/CUENv6wN7h3Z98RXbohlDDcbXpGkM3uD
         w8jSzX5bnfz0Er5mKTwXrn1CMLjR2CeEFOoAFPc2ivDnjFchOtadejM7e0kF7SIdFDDc
         V4Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXNiJwulIJ9Nj8LUFcSkUgz8H6rA/oTkKnoqe4xnRNPRHu/a/DZBLHw6tux+DNknpGnqfh5OE2d2HE4W3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmWZTOVy7eXaVMJdTMbg7MxMIfIFiurJ7ANhbIucZTkKY4nvTG
	odHyrG3PmTECeNcJpmb/ns7ohGECnXruBw+MQcHDka3JdwXoWqzWzxTyliJseNY=
X-Gm-Gg: ASbGncu7uib5l2LbTLp4vqqobVsJj7ScAq6/S8VPpK3Ue0b/0CKkW3Hm/nBBWRas3XD
	j7OcAMuOE5bhvie4ZCFLMIqNt0xzIbMwqaXggIjw2md9IQQTIx06jPUbsWSbmlDnNjpMb6vnahg
	vM2i8N/si6YuYhBdw232NzmezPClqmu016OdFkpmOYNQD+tvO1emtu+xbHIGoUap2bNB63GB6Zu
	QnIbJT5YAZSfJIlUxxrdDQ8096EpH7Z/J/h8n+esyZxPRc1gYi/mgnZ6/Q9Hm//6esYRgax7eaf
	n1mpOzgAVJ2JuIALk1YMTwS4rnzd+z/pPWFE0UBuEWo6KCJoJ4yjuFBqHJDPEtd3CFe60WMygqe
	40Vw=
X-Google-Smtp-Source: AGHT+IFyYei/dEAxk9MKfGVhD1RID7xVrL1ORWSm7J7H0FBPENv6nYFNGtp+2MRGC22AtVbDsUCCuw==
X-Received: by 2002:a5d:64a6:0:b0:38d:e304:7478 with SMTP id ffacd0b85a97d-390eca06cffmr2412164f8f.38.1740730957988;
        Fri, 28 Feb 2025 00:22:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:c728:ed22:3bb8:f351? ([2a01:e0a:982:cbb0:c728:ed22:3bb8:f351])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7c43sm4383676f8f.49.2025.02.28.00.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 00:22:37 -0800 (PST)
Message-ID: <6d0bc02b-5a03-42ee-ad8c-d348b6ebab8d@linaro.org>
Date: Fri, 28 Feb 2025 09:22:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 0/5] Pinctrl: Add Amlogic pinctrl driver
To: Linus Walleij <linus.walleij@linaro.org>, xianwei.zhao@amlogic.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
References: <20250212-amlogic-pinctrl-v5-0-282bc2516804@amlogic.com>
 <CACRpkdZg-9Zr3f7zG36x7jGvT46FRfRJ40khNZDdYb01-BGigw@mail.gmail.com>
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
In-Reply-To: <CACRpkdZg-9Zr3f7zG36x7jGvT46FRfRJ40khNZDdYb01-BGigw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/02/2025 00:07, Linus Walleij wrote:
> Hi Xianwei,
> 
> I applied patches 1, 2, 3 and 5 to the pinctrl tree on this
> immutable branch:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=ib-amlogic-a4
> 
> On Wed, Feb 12, 2025 at 6:24 AM Xianwei Zhao via B4 Relay
> <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
> 
>>        arm64: dts: amlogic: a4: add pinctrl node
> 
> Please funnel this patch through the SoC tree.
> 
> If there are dependencies, they can be pulled in from the immutable
> branch.

Thanks pulled the immutable branch and the patch 4.

Neil

> 
> Yours,
> Linus Walleij


