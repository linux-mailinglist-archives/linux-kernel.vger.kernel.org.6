Return-Path: <linux-kernel+bounces-260734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5246793AD87
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08546285226
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975F184E1C;
	Wed, 24 Jul 2024 07:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KGgA4v72"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFFB67A0D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807676; cv=none; b=K3DJ5EmulKfJF9owilS4KGyxXIKQI1ODcB/QwBWOZT59mTjMP5KI4hTNGlYAPgVP93LMXjr/ZI73UGoXHf28KC+89jqDC0Ba/uEGbKu51ridA11uGe6rq94Msw/DbQ1C9bfF+oNT7Kp8lsm04ndodE1Np7F9MuUkqLUSL3JFWcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807676; c=relaxed/simple;
	bh=2RRUSTAmAQO0+yPX6sLQpe2LF5FxPK59Cb1vjx7C6FY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kMl74Hy1jns4kOlwbL7woontv710q6k/XhV66hCoWfW15s1UlVsDWPdSyc7G9NtE/ByiXqXeDO1+YOjX1OLGERsv2jh5tsHWXCseDPqlaayolaq/FM8j56Etee0+tBPrAL42HKssRpY/CtT9jWncmu49ytIPEs8MPjNF0cqn6N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KGgA4v72; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-368663d7f80so3539521f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 00:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721807674; x=1722412474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/gAlhU9x34vyOesMYY33jaEx8HM/aSpGhMD3X372qA=;
        b=KGgA4v72DMj5JihqeajxFNpWWOj90nEnOjZpKNTjvEqip9lR83Hyi6BvmRXLYntpdz
         2wBzyqsSWamxpdMOLqpMBZw0IKYEqcOcNGjJt2UjHJ1xEFBGi9ZnYI3+KVaRWXFNxk3M
         ZU3yCPFM2L4IyZHajdZMGXsZr5Dw1fSUqy9dbFgmYD6dushoP/S+uNgrBYsN6e50jmpF
         h48BXxR9aLd4Frc+cbgsZlVNbYHtEkFKXHJgD1dfDvUe/cDak83lbAi+ZtYbY7iXXe4Z
         F3+0QCiBzyHmXfTMF1xaLtW4zHpvPtTSWq0McNfnGk5k2jf09qAI8tRoSmkjpD4BGJeP
         s2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721807674; x=1722412474;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B/gAlhU9x34vyOesMYY33jaEx8HM/aSpGhMD3X372qA=;
        b=CZG/wlEfhSYWcIWuTXpOIHHav2c1s+h1nrc/Ib1lvBrgU1RVJq0Qo96yM8sKOozkcr
         hjJZD0Ru69CsYUi+ItKGKmPSeEzlD4qqcPs0timXSrYCehLNrFYgrdZ2shPkSwM6mEYk
         uTKjRjtjuvapZrrC5DqdwhsqHWpi5Z9LnwosX8SIBjj3kd++qPYwIDfaN/h8TucgsHuW
         cuOQODsS1KNl3m/qvJ5XkRHF9uIJEkhfiPc5NT4GqwdMiM8hPrfH9zeqMcvp1G57k3fP
         tTEpjbdBd2zictkAsJXdzNPVSfhuQ4irWlEQfe8echy7WM5RByw8+WpSb2sZ2tUtDuoI
         PMkw==
X-Gm-Message-State: AOJu0YxzXqeHstxnL1q41Si2RQOqMxHA4pKIQb8oZp/CTtrKgpzsWhS3
	PjmE/ZbUpJejxcAQWI7XF2vhGybhcnQQo9fHj9ODJlR1Gk34K4eMqoOFurSRY2nlkimaxqFt7Pk
	d
X-Google-Smtp-Source: AGHT+IEINaLP4EC8j2JGyw8glYn/Klp3D0U5DMgaW5zZecLjyM/6LmT85iIxjDYOV/jqmliBp+/kWg==
X-Received: by 2002:a5d:6791:0:b0:368:3b1a:8350 with SMTP id ffacd0b85a97d-369f5b2c7ddmr905882f8f.19.1721807673400;
        Wed, 24 Jul 2024 00:54:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:deff:4fa8:5076:b4c7? ([2a01:e0a:982:cbb0:deff:4fa8:5076:b4c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f9359710sm17396355e9.1.2024.07.24.00.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 00:54:33 -0700 (PDT)
Message-ID: <2b970471-114e-4955-811d-592c12b1782f@linaro.org>
Date: Wed, 24 Jul 2024 09:54:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 3/5] dt-bindings: display: st7701: Add Anbernic RG28XX
 panel
To: Conor Dooley <conor@kernel.org>, Hironori KIKUCHI <kikuchan98@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
References: <20240706102338.99231-1-kikuchan98@gmail.com>
 <20240706102338.99231-4-kikuchan98@gmail.com>
 <20240710-showdown-antirust-a3eb8b65c57f@spud>
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
In-Reply-To: <20240710-showdown-antirust-a3eb8b65c57f@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/07/2024 16:01, Conor Dooley wrote:
> On Sat, Jul 06, 2024 at 07:23:34PM +0900, Hironori KIKUCHI wrote:
>> The RG28XX panel is a display panel of the Anbernic RG28XX, a handheld
>> gaming device from Anbernic. It is 2.8 inches in size (diagonally) with
>> a resolution of 480x640.
>>
>> This panel is driven by a variant of the ST7701 driver IC internally,
>> confirmed by dumping and analyzing its BSP initialization sequence
>> by using a logic analyzer. It is very similar to the existing
>> densitron,dmt028vghmcmi-1a panel, but differs in some unknown
>> register values, so add a new entry for the panel to distinguish them.
>>
>> Additionally, the panel only has an SPI instead of MIPI DSI.
>> So add and modify for SPI as well.
>>
>> Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
> 
> With a mention in the commit message about why we are adding a property
> and then immediately forbidding its use:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Can you resend a v4 with this suggestion ?

Thanks,
Neil

> 
> Thanks,
> Conor.


