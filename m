Return-Path: <linux-kernel+bounces-443971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86C19EFE62
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4DB316C0DA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5041D9329;
	Thu, 12 Dec 2024 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cX7qwcCH"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECAE19995A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 21:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039402; cv=none; b=SCoZde82uhQOTkCRuMs64txcpiu2QVu5x3z0w7bQBY4bipIj0yPosU9P0ZiXZjtgvXsencSwDkyrkydZ377dvKnfNT7fVF/ZLgXHSOJSFOX/Znpl58OQPlzbzwxqXttZdXa5P/Wd1/J4EcRk0BJN4JNwiIMA0yOkHVB2ka9alAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039402; c=relaxed/simple;
	bh=PLtI68SMrlmIfIEWTHP035ZGtqOceO2C3crjewNOrUI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JoNa8J53jRXd8jV+4S05wRZoUqIxR0huk86wlpwF2euq7H+t/83+9br7UvRtM3OE8VtMUkb48ShxBVbJ2kTdRUGbQCb9Q7xV3rtotZN7+z0XP54Skb9gec4lScc7POEEK49t6dK3YfRDTaWSQeKALFPBsVKP2eXnwj+Qzww+3IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cX7qwcCH; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-385eed29d17so618283f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734039398; x=1734644198; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IrqCs7YMF6CRcL8FZmtgSzX0pK8+d3Z/bKsneCeFTBk=;
        b=cX7qwcCHJUj+xo71xwb46NqL5Je7LEtpHW7XBeG3budiGjbD0x3KnVC/lfvZzvrg4v
         dP530wrkml5JNq7EmXj2X9mi8VRdB9kw4BpMW8yMcyJLU5jLGdIrfjkyzLtSS3DPW3Mn
         r01zAH63CRv+hAIpfQYOF9Y6lD2zsD2XII8Z1R5h81eezuY3mlkQ5PbbZjuUbe3eS4Ve
         EpkJnvBWzSTtd9kWpEuAxcSjHWkzrPAAj+aSnbX7Tlvomdt2vAZpftHvvewiAcKVt8eo
         O2WyZu6EcT2d+vuV8LQ2qmpD8dgx00MrZqxzTFt1OpqsJGF9CWILzORnLhsuPOISAKVe
         aHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734039398; x=1734644198;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IrqCs7YMF6CRcL8FZmtgSzX0pK8+d3Z/bKsneCeFTBk=;
        b=I7o9JUHR4wV/GFjel0YjlQ2U8ScuQN+L/7RKw9ypAmWZ7veAhjXzGDPeePSq9KUc+/
         DoN74ZAxxMMk1B3oMMDIKErQofbzFahpb/WBnxfYsvhWhtd9BXqNjmqM8KG6Ja2Q8Oa0
         vJQUen4ciz7mm4b8B28WFojNGscYWfR1ZJkKh+yEwrsS9gyZaHdnprl0U7mrfXIbCqh8
         hKH9GePW6fjcrv53b+xj+2I8cIofOawCypkUlBUVWZju6JmI1jkpQ33rLw6UjM4CMOvA
         jlK9eQRi4L9mZmDFmHZGD4SSRTEM+YsC89FKDg0Apm3ifLTRsGjfPggV/vCmNobJPpgn
         ewXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwAANNWoS693VjIL2+A/Y3rd2wVchu0L2+cs5mrqFnG0JEFpSMyqT/GC4Y6TC3u8QuEbK66PB4jVcCRMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh1xFsIquAezKP67xeBfUe1JX37u3Ua3AmjWAEeSyr9E1xJgKF
	tDvRhQRZNeZ5IIy1m3Y757c9A9E8piiWosX+mHOfbOrz91kQDaHNUVp9DeGaGLo=
X-Gm-Gg: ASbGncvX3L+ykVd9l4mC33MoAPJJpF9eQKQxRKZDJTZ/+QVXJrebNJLASuV8ORv52e/
	dHKubSIZ9mE3WGH53g75K8f58ErWtjlgbaiQ7iot5TJJIXLwR2TAaUWzinnGy4HA40mJqE6mebp
	Xw+wRE2fSYBl/mIru+aRt1WRDVO1GVlnv8Q2S6Ba7MubO+0SNun6PK2Iqze5Vq4DVxJYRF8b/mj
	ysWLF8xCZV5qjqR6Pi29TGH/rWZW/yfwGt6y+/kdwNUZ50bgsx3tUGhmf9HJ9gAyb88/zlbQacZ
	kDnFzTKTuS/0avz1ZTgGdwzPjln9ax2keg==
X-Google-Smtp-Source: AGHT+IECUqq7Q7DBGVoL+Ae1+IU3B5T8MwH58zhnUQtU+qylUsnSU+xpVY+rpOswBvcmGDpakaht2g==
X-Received: by 2002:a05:6000:2ae:b0:386:1cd3:89fa with SMTP id ffacd0b85a97d-38880adb156mr144936f8f.33.1734039397929;
        Thu, 12 Dec 2024 13:36:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b98a:c6fe:3a5d:f20a? ([2a01:e0a:982:cbb0:b98a:c6fe:3a5d:f20a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706c82sm27973335e9.35.2024.12.12.13.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 13:36:36 -0800 (PST)
Message-ID: <76592f0b-85f4-4c84-b45b-859d55c4e87d@linaro.org>
Date: Thu, 12 Dec 2024 22:36:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 5/7] drm/msm: adreno: enable GMU bandwidth for A740 and
 A750
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20241211-topic-sm8x50-gpu-bw-vote-v5-0-6112f9f785ec@linaro.org>
 <20241211-topic-sm8x50-gpu-bw-vote-v5-5-6112f9f785ec@linaro.org>
 <31264e68-2cdc-41b2-8d84-459dc257f0f5@oss.qualcomm.com>
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
In-Reply-To: <31264e68-2cdc-41b2-8d84-459dc257f0f5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/2024 21:32, Konrad Dybcio wrote:
> On 11.12.2024 9:29 AM, Neil Armstrong wrote:
>> Now all the DDR bandwidth voting via the GPU Management Unit (GMU)
>> is in place, declare the Bus Control Modules (BCMs) and the
>> corresponding parameters in the GPU info struct.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Reviewed-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> index 0c560e84ad5a53bb4e8a49ba4e153ce9cf33f7ae..edffb7737a97b268bb2986d557969e651988a344 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
>> @@ -1388,6 +1388,17 @@ static const struct adreno_info a7xx_gpus[] = {
>>   			.pwrup_reglist = &a7xx_pwrup_reglist,
>>   			.gmu_chipid = 0x7020100,
>>   			.gmu_cgc_mode = 0x00020202,
>> +			.bcms = (const struct a6xx_bcm[]) {
>> +				{ .name = "SH0", .buswidth = 16 },
> 
> All a7xx targets use the same BCMs with the only difference being
> the ACV voting mask. You may want to make these non-anonymous structs.

it can be done in a second step

> 
>> +				{ .name = "MC0", .buswidth = 4 },
>> +				{
>> +					.name = "ACV",
>> +					.fixed = true,
>> +					.perfmode = BIT(3),
>> +					.perfmode_bw = 16500000,
> 
> I think perfmode is simply supposed to be set when bw == max_bw

Not for a750

> 
> Konrad


