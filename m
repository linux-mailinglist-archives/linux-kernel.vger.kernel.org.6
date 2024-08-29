Return-Path: <linux-kernel+bounces-306716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF2E964279
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233A32837EE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA17190471;
	Thu, 29 Aug 2024 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sY1hJq6B"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6807189F3E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929224; cv=none; b=l9tuHMvWxDaLK+C/RdPex24MVjJhqyAB9KPxMMQxgeaedguWWcWUfSdoooqjpDD9SEq1RnCOEpIFCaI9D9+Bhw3KGXOFLLku90C7lOxO41640ZlltiBP4vmvSrWsZpVtjrHigb3O+5f8HLJjMyQGfVJucxHkLmSuLU+kZYvlbc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929224; c=relaxed/simple;
	bh=9xkfAMc/uuwZYQ37bHBXTmu16483mcW9Lf7uJ33vxNc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TKumGZu8PeeG2BuKurjPDjjRMZPWbkaMe0WUM4OECDhWnod7+eCKVhsrFCObNN8QLThPLXZdWVEBF+u7yonymhceEtUuGIxREZLeCMu+Yk2wQdGI/vcoswn0dyV7zRlMbKpYaaAKgZjah+gC73Bjx2isH3fDjHWcEVveCIwt0GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sY1hJq6B; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3717de33d58so311187f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724929221; x=1725534021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCBO2fXDMFuHjibYZ90lcTzSffCRMYyprDRaor954cw=;
        b=sY1hJq6B0xbdf4/BVAvZphd+xhhKI3nPVEOmrhG5tM2bnvuWktJVsz+pZod9fpaseZ
         aPNoPCyMRYKm/zG+prkzKxoq2jHqMvzcxy1ReFaqRUQjcZexusFjXz7g5zUKSI2EefV+
         sk+WDvgeEePMd57DsYf4FxJWYBfyYp/mGZt2MGjhcBTSDs5yhBt01KkcLJaJvBC0Q724
         EjIS4tnD60BmfAlJouEFuXJGRCnUQI/FFsZhz9+MEdmXBWzxrK5m138iWpCRnx+tGlfY
         mIpf/zjHnLF2G04Cth8mRI2VKUA/50wBqf7zBuzp2bktSCul3897lzEigLJvN5K6nFB7
         mxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724929221; x=1725534021;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zCBO2fXDMFuHjibYZ90lcTzSffCRMYyprDRaor954cw=;
        b=FCzM1zItqIDPc9sBkv7lMmExfiOeRE1TBBjdBKdlywOck1Yp5i/fXJFjc7+fYMQs+1
         1azilziV/LUtnAtjWaQXdATZ/d46eT8o5l5eKoj3IH8zwWLy4TV+3VaxM87ZhmGE6N38
         fa2eT7B4raQS+iTIQiPf4kCUSnvS2BTIYhMJTszBEtVCOzpm9EFEU8qULAhUJh3vn/Fg
         6T+DrQqbgPP2EvA8F3DQrU95wmX6btiu3at1RMPNmSlLwFJmgkDV5HmubEGebE+zr3Zr
         McyHYoz5LMxZWXjuSrdDKDOebLr22zL3aMQBQMdG/UFp6zKOlqEXmwtf8pQOpPEOKrji
         y6/A==
X-Forwarded-Encrypted: i=1; AJvYcCUHLz6eQmEhgm7W7iDEZa4jNxlSUv8vduqRaPYLJ1EfQ0SXE8+PHCGYITz3ut16QjuYv/JzEZMYVO8cKg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy68ulZ7AmU/YXqFQJHj9f0jshEJMeeU4/isttPlDdfWUAWdQms
	SssU+fL8WTSbkIxRWB2/37jh5sIcQlg3Obd/vDqcVKeWN4gfdPIEzYoZe+evkSQ=
X-Google-Smtp-Source: AGHT+IGG76SR3oNW+HCIychd+P3LUXVnADqBzPZBXBpifnY7av308etEvxlverR30bjayZZkQv+6vw==
X-Received: by 2002:a05:6000:88d:b0:368:420e:b790 with SMTP id ffacd0b85a97d-3749b5447aamr1570845f8f.14.1724929220635;
        Thu, 29 Aug 2024 04:00:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:12f5:c9c:a0e1:6915? ([2a01:e0a:982:cbb0:12f5:c9c:a0e1:6915])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee6f76asm1100153f8f.25.2024.08.29.04.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 04:00:20 -0700 (PDT)
Message-ID: <de807810-ab84-49eb-a96a-080f44452205@linaro.org>
Date: Thu, 29 Aug 2024 13:00:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] drm/panel: visionox-vtdr6130: switch to mipi_dsi
 wrapped functions
To: Doug Anderson <dianders@chromium.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240828-topic-sm8x50-upstream-vtdr6130-multi-v1-0-0cae20d4c55d@linaro.org>
 <20240828-topic-sm8x50-upstream-vtdr6130-multi-v1-1-0cae20d4c55d@linaro.org>
 <CAD=FV=Wke51vmTy7zZ+RV7oDoCGSeszOarhLGapdDrkByNyi-g@mail.gmail.com>
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
In-Reply-To: <CAD=FV=Wke51vmTy7zZ+RV7oDoCGSeszOarhLGapdDrkByNyi-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/08/2024 18:32, Doug Anderson wrote:
> Hi,
> 
> On Wed, Aug 28, 2024 at 9:03 AM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
>>
>> Make usage of the new _multi() mipi_dsi functions instead of the
>> deprecated macros, improving error handling and printing.
>>
>> bloat-o-meter gives a 12% gain on arm64:
>> Function                                     old     new   delta
>> visionox_vtdr6130_unprepare                  208     204      -4
>> visionox_vtdr6130_prepare                   1192     896    -296
>> Total: Before=2348, After=2048, chg -12.78%
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 186 +++++++++++-------------
>>   1 file changed, 82 insertions(+), 104 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
>> index 540099253e1b..ebe92871dbb6 100644
>> --- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
>> +++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
>> @@ -40,120 +40,103 @@ static void visionox_vtdr6130_reset(struct visionox_vtdr6130 *ctx)
>>   static int visionox_vtdr6130_on(struct visionox_vtdr6130 *ctx)
>>   {
>>          struct mipi_dsi_device *dsi = ctx->dsi;
>> -       struct device *dev = &dsi->dev;
>> -       int ret;
>> +       struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>>
>>          dsi->mode_flags |= MIPI_DSI_MODE_LPM;
> 
> This isn't something you introduced in your patch, but I wonder if we
> should avoid setting the "MIPI_DSI_MODE_LPM" bit when the function
> returns an error?

Yeah it's unrelated to this change, but I'll investigate.

> 
> In any case:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks,
Neil

