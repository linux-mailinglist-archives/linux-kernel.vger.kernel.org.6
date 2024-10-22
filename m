Return-Path: <linux-kernel+bounces-376238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 894A79AA1FA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09E0C1F23A72
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE5A19C56C;
	Tue, 22 Oct 2024 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ggfX4saB"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17813A89B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729599361; cv=none; b=th9Ucss4300J5EufiKGrjPVsKdtAFyzA1HoYDQfzd/83MT9VGFU6wBROwhbqUiwRt/OI/6fHUuCj+FHD+P8hHo6MxpWu4gocbqZzyLMLbYepWyWloD+8Qs4zfAeepGlLMhxl3UbELsdH9EAje9M1Ao2EucqKFywXthC7va+iVmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729599361; c=relaxed/simple;
	bh=UcHGpO9lcLjMqqUEy6P77LD/fPioXokhQWlO5SxkQGI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=N2orB8SIyLrAxShFhvxYYl9Yl+ag4Lb35eVCQ6sUuatNMSrksW0qy7JjmHxiZixtKzzlWQ45jSo/e1INjk04zaNGPGFYg4T5isMLRmbe/kjCi94uHS+V++gea7+A9QgCayVK5YZ6toNOk/Ae2Xzu2RjeWw7mYl7zG7PJm/3XAhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ggfX4saB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4314c452180so43824965e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 05:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729599358; x=1730204158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzfBBiQZO/3JmQPAp3trpD9H/FhA5SSKZP4PSmekS78=;
        b=ggfX4saBia7aQO7WVO2E1fEpAK2YaG0SMDseigVM+oHawHdCq0i2W0Ho+Q9d4t9tI3
         7ROFWyV/7toj6LTCyIDTWVDNx2JftkEfJIX6z89XyHdIfSDv3qKNq5/dDTg9S2ezNIB/
         ryMm5tLH8vnU5XGXbcpgXrpbjVL2VXkXTFrC2P+VJMw3l96wYovXsi909OCzJ3xxKSU2
         aSVZyrhAL1L2P3xJO1Mvv9B2p+IVBbsV/Y82Rs6klmQ/A1eb1vLvNhNejEBVjsKzl+g1
         AGKLD29jzEG0kaS15h51moGpe3SxkuqWcjvwS4kBjDtwJZTovT0zV/zvddyo/38ID0//
         Ogpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729599358; x=1730204158;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hzfBBiQZO/3JmQPAp3trpD9H/FhA5SSKZP4PSmekS78=;
        b=dthAuDK6Vijpi/r+wKq0RxgiN0+E0N6ZuJqUfy3OWHq7i+B2AxGNuEzsEvmfwl1PRg
         bSS9o6rxnClF9UlvV/Q4fujPUSX0bkYG0BstyfoYD4g6dzJ64UXN4nY8wR7mELU+kwKO
         bH0bvaHOIReveahOhm/mWlYQllkCXBWwOELd24ucOe+qf7mtgP8M/zDHkcY1xM9Kf5hc
         mGG0p2tsw+TIPFL2oYALvAzLwQfipNxWUBr+az2WW+CJerrtTiP+KY6r/PTgSknRlFCC
         tmfkU53aduRn5lp4eODUWULJC8B8ZaT7YMCFq3oAh2C0bQQoiY50VO/72QiDotC63bYH
         sNBw==
X-Forwarded-Encrypted: i=1; AJvYcCUiwtqIZWR8NHsEzBPPMo1mV5vuCsEtLWqGRLfbkeCZ/gupaWwvwA10Rwc5zsk0ps58AFVcZlJ1fiVPIcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI7qJdiPNhOL8cMuwFAbrFTBNhWieGpufBEJyHg6VaWfDxqM+L
	AzcBAda2nDBLnQH5uOc1kzeUr5pReIaK0oC8B/Xv08yRS0MUrUaciHfQ4tm1dOI=
X-Google-Smtp-Source: AGHT+IHT8U2le7TP7Fhl0aRlnvkTfgE3DG0+6uSqVHO9u7XR2ZILafOv7A3oM9rdGHL/IP38m1XIAA==
X-Received: by 2002:a05:600c:1d8e:b0:431:4e33:98b6 with SMTP id 5b1f17b1804b1-4317bd858camr19814435e9.5.1729599358069;
        Tue, 22 Oct 2024 05:15:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:43af:403f:2c26:9ea7? ([2a01:e0a:982:cbb0:43af:403f:2c26:9ea7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cbe64sm86619065e9.40.2024.10.22.05.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 05:15:57 -0700 (PDT)
Message-ID: <ad1d1208-fb0d-4656-80e7-1af0e8a4e421@linaro.org>
Date: Tue, 22 Oct 2024 14:15:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/6] drm/bridge: add ycbcr_420_allowed support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Stein <alexander.stein@ew.tq-group.com>
References: <20241019-bridge-yuv420-v1-0-d74efac9e4e6@linaro.org>
 <a2d20619-0724-4b16-a9a5-4a3680f21c99@linaro.org>
 <CAA8EJpoy=nYMix3m2n7KkwemCNoh_qg8FH0ENaa8VNcLtqZuww@mail.gmail.com>
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
In-Reply-To: <CAA8EJpoy=nYMix3m2n7KkwemCNoh_qg8FH0ENaa8VNcLtqZuww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/10/2024 20:22, Dmitry Baryshkov wrote:
> On Mon, 21 Oct 2024 at 15:32, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> Hi,
>>
>> On 18/10/2024 23:49, Dmitry Baryshkov wrote:
>>> One of the features that drm_bridge_connector can't handle currently is
>>> setting of the ycbcr_420_allowed flag on the connector. Add the flag to
>>> the drm_bridge struct and propagate it to the drm_connector as AND of
>>> all flags in the bridge chain.
>>>
>>> As an example of the conversion, enable the flag on the DW HDMI bridge,
>>> MSM DP bridge, display connector drivers (for DisplayPort and HDMI
>>> outputs) and AUX bridges.
>>>
>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>> Dmitry Baryshkov (6):
>>>         drm/display: bridge_connector: handle ycbcr_420_allowed
>>>         drm/atomic: add interlaced and ycbcr_420 flags to connector's state dump
>>>         drm/bridge: display-connector: allow YCbCr 420 for HDMI and DP
>>>         drm/bridge: aux: allow interlaced and YCbCr 420 output
>>>         drm/msm/dp: migrate the ycbcr_420_allowed to drm_bridge
>>
>> How do you plan to merge this serie ?
> 
> Once Abhinav ack's the msm/dp change, I'd like to land it through
> drm-misc. I think it's the most logical way to go.

Yup, Abhinav acked it, LGTM

Neil

> 
> 


