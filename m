Return-Path: <linux-kernel+bounces-421022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAAA9D85E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5992B2D6F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D62199947;
	Mon, 25 Nov 2024 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+KkSO/s"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432201474DA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539476; cv=none; b=hBXdk+LqKYQLtiaijGSR7BHhGkon4md4ipM1tRGlKSwFnDwPKe5xORrcoa/N1/ZncgPGEVxnypaQM6bLdAYKyscPxzSMLH27jc4Wl2PPsKKQgAXcBE5KYancpW+QJ0wWEjOtWJk0sgrUdBF75/yM9Cuaos2751R5lO1omGTarzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539476; c=relaxed/simple;
	bh=NmAtDEeeHIbvNgfXMeLVH7ObwbLrSZk2z7XkoWcaSms=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=N9ed+w+XKdJKoucrMoPW2Nk72nPzqElUzB4zGHWh/gdkOmoqcI9Sh9gIPjT/giemC7qVAeRM5rSjj1gstzgptNR4qf1zy75bTLMa5YZQyKCVk/9VWq0J7uBxcWzDWG/4tApf1OrpZAhVqLcuuR9UDgqFp3B6r+jvYs10EN2CEQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j+KkSO/s; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-432d9b8558aso30721385e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 04:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732539474; x=1733144274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LK/o3FUGaKRZErsXHi8EyRs052osGciSWNJJ6Un26Ds=;
        b=j+KkSO/sRQXLuWXPraVis7P3zDCOWFMOfi7zlbZVM8mlGWELtg0OAJgaIlkMwA4jZ8
         cyWVh3mtMD0udmxaAlyqXORUgzSXzGVgjzvbF+nDbVgBTA1c3qD64qlzMqjNqZjgGccs
         43X4MC4HgLJNUgPIujSGZHootPUEFhg+1F3Qsu1XC+P/qPnfL+51TB+cuTwgBZ7Ab94Y
         2anvfNL1NfhlhWt6wn/4KYvkPeSG/yfvGsywVA5MbUDmK1iIo4yY1aXALukUCiJtFcD2
         hCD4S/IdFC+H9aC383NRalr+ZDow7V0SbXSHhyDKzihg5YyLs1zKGfZDnaTMSLLA/Nqm
         k7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732539474; x=1733144274;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LK/o3FUGaKRZErsXHi8EyRs052osGciSWNJJ6Un26Ds=;
        b=l44GYPIr3j9Klnfsapg5AoKzdhv7lpasmEymsNXrKAo5UjKU0db5KrDL8Sk8ey5cM5
         8xGbM0Hky+ra2czFPf73RkA47g65V4FSD6MEGkG+5118Wg89DELYUuaQJTBuTs+rqsGE
         5lvUesdlxnMg3bI7hHNOgaDzShLUCN98uDWuDXlTmDWRUsneq116tLEdEcoa91j2Z/5R
         c0qjH2hh65wCs0A2P0miIhHTcmXPRXnxCGwSCTJqWCX5n0Twnr92njK7Qk6VOgrjl8AR
         pr+mZPZ+xEyQqTPQ2QJZlSLZyqM34fF7X0jc1k1fj5z2QMOqwWowS0iARACDRD8spqb2
         iLKA==
X-Forwarded-Encrypted: i=1; AJvYcCUGWXW5/wKBAy2o2VXMGSI7A/hCZj36YfERpsfRGZ/deRut9d+T/pKnhfP6MNzVc+icIBc2u1JkPF8N44U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS4yaa9w+Zgr12rU1uD52XKwf2qqz/TrpDX12hW9dRKXhCAAT8
	BSO/FzGdPmRRHyX2dZAWFnDpEdi0pUKbn3KeUwg9V0slF+RncvMSgBRyVL+OyWQ=
X-Gm-Gg: ASbGncsHr1qeRpKy7KcdfOL2VKvViw8BdJBemaUosEEJjSbEhYu6CrlYIiydaTTWJJh
	M2Ojvmm3oG5EZQB+ola2+WcEBmHHJ9oDY3mbz3J6ablSC3xxeS0Ali9tw19WaHPUQjwyZDQc1xe
	0SbycbVmK1rc1xYUuMbtXGAgCuFZxjq7xfIVcSnzbJF+IIXHGG0JBzNYwgW3ror83JIbUsYmLhB
	/zwwPMOQRUNoS5UEpP/tPUu24RM1Lut7UYp3Il1TFqu8ik9A/QFsEd445PnJv2bLSJ/z41Bl+a6
	evBUwscJgMMxBJ/u9nWoNkGi5pg=
X-Google-Smtp-Source: AGHT+IHp9ZbYEEuOqvzmzN9bYFgBoyUQCliRxucIR2i6oG6nzBgRHtwS7cuLaCKRHjn/8s+t8OKggQ==
X-Received: by 2002:a05:600c:1e1e:b0:42c:b603:422 with SMTP id 5b1f17b1804b1-433cdb0b504mr101998665e9.8.1732539473751;
        Mon, 25 Nov 2024 04:57:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9dc0:6c46:415c:5f8b? ([2a01:e0a:982:cbb0:9dc0:6c46:415c:5f8b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349dc19fd3sm52076065e9.39.2024.11.25.04.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 04:57:53 -0800 (PST)
Message-ID: <c6b0273f-16f3-4469-a4b8-9564f7355400@linaro.org>
Date: Mon, 25 Nov 2024 13:57:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/5] gpu: drm: adp: Add Apple Display Pipe driver
To: Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Janne Grunau <j@jannau.net>
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com>
 <20241124-adpdrm-v1-2-3191d8e6e49a@gmail.com>
 <10d0aa88-de2e-4856-a137-301519e58b2d@linaro.org>
 <CAMT+MTRWZWj=3AP7wyooXr49-W4vcm0ZbAoqPyEuNkQBMOaJfw@mail.gmail.com>
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
In-Reply-To: <CAMT+MTRWZWj=3AP7wyooXr49-W4vcm0ZbAoqPyEuNkQBMOaJfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/11/2024 12:24, Sasha Finkelstein wrote:
> On Mon, 25 Nov 2024 at 09:50, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> So this controller only supports a single mode ???????
>>
> Most likely. On all devices it is connected to a single built-in display.
> 
> Ack on all other changes, will be fixed for v2.

OK, so instead make the panel driver return this single mode
and from the display driver just filter out anything that's
not ADP_SCREEN_VSIZE & ADP_SCREEN_HSIZE.

Neil

