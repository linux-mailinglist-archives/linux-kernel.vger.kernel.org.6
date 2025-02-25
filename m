Return-Path: <linux-kernel+bounces-532143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240B6A44974
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C080B3B7448
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CD619CCF5;
	Tue, 25 Feb 2025 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ebZv8Uuk"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EFE36D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506371; cv=none; b=ptEe2SRu/xJRgC9dh4rvS5WEUo0ZZgc7Y9dXWSeUPpOeK1ozZaDlma8fqs7V79WTAdCS2CimkInb/2ZSBzYbOBlOdc7AVTu//sT55v0QifQtBkmWJheBRD66tAfoIcMsoZSuffs4SgksYpGy4YI15i9KrhbCVz1r2GzepPUG+J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506371; c=relaxed/simple;
	bh=dH+ysp3Gqt2fhg6VD/Lzu70mBlOTfesla2+cjoYPApk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TOkjYaKyMOMXhc7PHL/vLPjcKYvorR8wfQF22VyC5+CvAAdkYLb5mVKcUZRuVPLVXHSpGdwCZ8diPNcXyMwsjEWO4mk19II3paDDyvdhD6f96hn4IuFnabRTLtItAY1w3cKq+QaTQBZO4R6BHwnh1pX9vJIdssgIJGuDDxZuwiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ebZv8Uuk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso60205425e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740506368; x=1741111168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjDMnEpfyvE0/n/R7fglBpQPZZ2H1kPvQ+lYLuofLIk=;
        b=ebZv8UukIkbB7BsKnu5rCcXwm2YK/Y5YUvPAVMguyz3wh9kdvvtd+F7bmH/IhFvp8z
         e0RcOjFZPV7DH3+AJz+Thm7DaGjG07LFCPmSioUphcqwhPZLfspW9dQGH04Gm4gWSYcr
         riNisujxJNN/+FYnXnDBvr97V6So33sFxGAm3J1A2CzpR3B4fXEAatYMi7trRRVJqPi2
         qbyRWIiACceSt7sfJpltu7/mkfpf9UnnVF/PvmG8P2/HizNsI0c6S3ahOgH8rVtO4G2W
         VThe773GCp7bPTOpX9ISKqzpLiKBXL408lWYiD4Ck1MsHCDEDjFzJhVegdn5FVPCLItu
         v7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740506368; x=1741111168;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hjDMnEpfyvE0/n/R7fglBpQPZZ2H1kPvQ+lYLuofLIk=;
        b=WkjrS7IFRHsj9RHt80KDOnNcPSF1h97MivdI8MdhC3JfQ7OETarD1gXMTKFvd7aTjb
         PTgwgqfaxl7ZLU1ZkQOYcQX2tP/SeFByZZtkz1IiHSjgJq3W7oAgpxwK9eElnfOFGzIW
         0T/8z44mh1p4ev8lAzjaXidIpk1MMkE2vAPgGc+YpiFDNErWvgnoOrEb2eS9ivD+cyNk
         uccZr/P4JHTytv2R2EIauuZm6IzWKIiHyQjMK01lyDy6q3hJbbRerUlnkGmEGYdkurzG
         etIcOKliB2qf399bCI9bD1rclqX4PZ/uNJHaReBGVixRyWx4aE/IZARHRdK+GCJCO6PG
         rjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWj5DBNK6ABzbcNH6ffAlS41wHcVYOtATpzuMGUeYpAr+3Na9c++89dw8FfEFml96osWoNmIMGZ8tyLC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo5Gp/sdWbX1JtXc5XjgIUD/qqCT17Kaju0Zku2LrCaviJ/rBc
	y3MtTKNeBWftLVtnzvegLazakPgK+6KZrJ0dLjL99gDLuL4mBgBp5zt9Fx7pUZk=
X-Gm-Gg: ASbGncsPZxetwMXOyMEbzdpddOn7wn2ch1JWx5iGM5L9EUVFnX/JPSXUgtQW+vNfM9g
	k1XufvtSB5LrurHhjpFooJwlOnBvreAlvykUW1t627yyTVPYaaPSJQr4IZK/MY69wCdiinkKDGe
	3uwX2RUySESzVPe0zaOtNeEHdbnETpZhKl1LG9zKKRgPw6WEVm7PxkZPdsCS0O0weK/eAh8OgzP
	SMJ/vAaFMK9Bks5RUbV50an1hl3NHiFK1I28L/BBP0ixjwEGJKLmFz1N10MUnpJrfOn7U0AUiAV
	Q6bjIIHi/q6wVUTGXBq8wZspDszzJO+VLZMHKhPRcIDPvFwAC0nkLnz7iFobPleguWpxAorg13f
	bxnU=
X-Google-Smtp-Source: AGHT+IHtZcIoQJsi5dScv1l8X9lcH5/APbnkiDicrQKXKhdO2SowhVhMLSTlVqGJk0pL3x+gu1om+g==
X-Received: by 2002:a05:600c:1f90:b0:439:8544:1903 with SMTP id 5b1f17b1804b1-43ab0f64430mr41996155e9.20.1740506368036;
        Tue, 25 Feb 2025 09:59:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:23a1:f1ec:7a08:3a2b? ([2a01:e0a:982:cbb0:23a1:f1ec:7a08:3a2b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab2c50dcfsm21371065e9.0.2025.02.25.09.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 09:59:27 -0800 (PST)
Message-ID: <2d51cb9e-b8c5-4cf1-bd7a-751fb633275c@linaro.org>
Date: Tue, 25 Feb 2025 18:59:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: (subset) [PATCH v7 0/5] Driver for pre-DCP apple display
 controller.
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev,
 Janne Grunau <j@jannau.net>, Sasha Finkelstein <fnkl.kernel@gmail.com>,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alyssa Ross <hi@alyssa.is>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Neal Gompa <neal@gompa.dev>, Nick Chan <towinchenmi@gmail.com>
References: <20250217-adpdrm-v7-0-ca2e44b3c7d8@gmail.com>
 <174047913824.2131221.6545389561298332217.b4-ty@linaro.org>
 <CAA8EJpqM8ZQ-ScEtEBXaUF2Nargtp_TBAyMYvbJ49PGbwPWjaQ@mail.gmail.com>
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
In-Reply-To: <CAA8EJpqM8ZQ-ScEtEBXaUF2Nargtp_TBAyMYvbJ49PGbwPWjaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/02/2025 12:37, Dmitry Baryshkov wrote:
> On Tue, 25 Feb 2025 at 12:25, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> Hi,
>>
>> On Mon, 17 Feb 2025 12:39:30 +0100, Sasha Finkelstein wrote:
>>> This patch series adds support for a secondary display controller
>>> present on Apple M1/M2 chips and used to drive the display of the
>>> "touchbar" touch panel present on those.
>>>
>>>
>>
>> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)
>>
>> [3/5] drm: panel: Add a panel driver for the Summit display
>>        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/40115947b59f2ca361a47615304dff0a2b69a2b4
> 
> Without the bindings?!
> 

Bindings will be funneled with the rest of the ADP driver, the panel driver can be applied individually.

Neil

