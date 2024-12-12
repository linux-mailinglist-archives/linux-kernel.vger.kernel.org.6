Return-Path: <linux-kernel+bounces-442766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970D69EE149
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5FB283CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC5A259496;
	Thu, 12 Dec 2024 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iaMktMKZ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4547518643
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733992275; cv=none; b=qykIFblM2Qg/xZycWFzDQlZzsIsmKoQr4pNXOD1973qHgMgcHUu+oUr0IVFO6QK35CF5eZ5X3pAXGeDVywx27x1+TU5Vrm/kBj4iyQNzSUJPhmA6LJ+KsG6tbJtKoGYEOwyBu1bd//woYlWBm0KLW/osaRzx1wWZunScn19TKHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733992275; c=relaxed/simple;
	bh=Nlh6l2I6IYsoFDxqfXBnSMbDN8K+3kan1+aBElEYpQA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tefJRIGhSuAsvvfYqfdWbkGcMjkRzJtM5w8+V3ekFpK/uLEvXMdnZOZowWSL0kQvskdjC0KC5A1WLZqs0z1MZXn08rycprlZHRbMNPA7D2ZMiwZMylbRXrsFO+j9wKxv1slWKNBmaQrmnJP0lljgyyEt6I8Fx/iZhQ69+w9YLhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iaMktMKZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43618283dedso2833795e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733992272; x=1734597072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XYu4I8D9gBdmo7eYgjvc8ss5lWgqbeNPvu7neTItSw=;
        b=iaMktMKZLli8MwMdL3EsdNfiXWbaDpL3Vj2eOl0Hnx+pVSBTO16L6rgMaAax4Q/n/m
         WNGvZDA0/l3gZbSwuGopZ0JjwvAk9L5/McrlXIStsv9Faj3RN/lHliHL/tkAtbj7eNrV
         dG/c+5yvLnteaV5PDjpNJAIlAeNIftbcr0mLBV75cfFSvtI0WTc3nmvO80cSu5DRJTGL
         A+w/ufcguYy4eWXxqhuLx/VHN3Y6AO+mVsIG99DU/yt0+WSPaH15Z/SHJ2kkz7esYjpc
         bt6Z0T/luO/7yLKZIxs5Ug5DdZZPoDGzwCrq48QJVpZSl39eFp2xS3QQ/2/IY+EVWEKj
         ifXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733992272; x=1734597072;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5XYu4I8D9gBdmo7eYgjvc8ss5lWgqbeNPvu7neTItSw=;
        b=anbgYA8sNjMMTWxUjX5g1eWtyGjRBJCzBqXx6qTgHAXTsJh9OB4ewL+b4PDsVbm4ZP
         5701DH6LekVIK0pvqLQ2hzletAt7+UpKcaDhb06/+mcjm+YcSol2yZrEY+rjSHCnKrZS
         qn5x1b74Sy48F4FLytNR93nm8/70hvDIQdaJdWQFaABXJ2CBKXM8Qv2ZMncfK1dwNMGg
         jaQ7ZeLuti6NGYE6gUFr5HzAlG862XlKh5QhSCnetlbxAKSNcocVUZ5sKgBoCTF4wyCD
         UlA99xrBstA2iA33lCw3GfB1Z0Jr6BT8m6ZNaMlH0czdTNp4fVqPKr7OcsWHIh1AvFF4
         B1RA==
X-Forwarded-Encrypted: i=1; AJvYcCVcQz78/GzaTljXIc1SOUm5YiagOZRdCDJuZKtpbDHDGTPdoR3ECYHj9RMoD7iCOm2qVOnXSiOothQt1oY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzt2c95ILatzhtdi6a2EoBU/upUKLKXCjFoaFhQ1I+jX+Dzgzu
	zPx9kjJyK2fq4qefQZ8sAoTl/6TcDYuCaVEuMzWrziHDXolKAHcBBOXeibn7nEM=
X-Gm-Gg: ASbGncvFI/ZVnbYFDnY3f0FnTVPSxWYM4QqkQUMO3M/9frOi8wHwas4WVAo3cqsdTvV
	2C0by3db+iCfBW5lQkzG5ZEfdVjldYmywhT1Rr12U4+GnWwBQvrrUchjX3fHffabP28t+DoBjTJ
	KxgeSzqwL0Vb0P2+15DI0SyyhiNTnhQ6aFtTn23+VnbYlHfr3U0JK+eYlAqcTh8u10uJRtd0LIH
	0EtaYC2Wsga4TCfOPp1OUoSaJ4OLIm/YR5dr861AG4kkmGQ/rsEC7s4oewY9Z+EbabwDXychP8V
	KEsLoJlYDkbXmsJzMKp6lAHkLxUvin8kVQ==
X-Google-Smtp-Source: AGHT+IFg5rVsYNoj1OLL00/jahvhS0YEuapxQEmBGH2dEHoxfZsQpcAyjRpBUgBdyI8WiwrhrVyjPA==
X-Received: by 2002:a05:600c:348e:b0:435:14d:f61a with SMTP id 5b1f17b1804b1-436228638c1mr17805585e9.25.1733992271590;
        Thu, 12 Dec 2024 00:31:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b98a:c6fe:3a5d:f20a? ([2a01:e0a:982:cbb0:b98a:c6fe:3a5d:f20a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436255830b0sm9467275e9.18.2024.12.12.00.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 00:31:11 -0800 (PST)
Message-ID: <0d0a8157-32a4-4e8e-92cd-dac9a4471641@linaro.org>
Date: Thu, 12 Dec 2024 09:31:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 1/4] drm/dp: Add helper to set LTTPRs in transparent
 mode
To: Johan Hovold <johan@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@redhat.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20241211-drm-dp-msm-add-lttpr-transparent-mode-set-v2-0-d5906ed38b28@linaro.org>
 <20241211-drm-dp-msm-add-lttpr-transparent-mode-set-v2-1-d5906ed38b28@linaro.org>
 <Z1mk08SHEd5_vc99@hovoldconsulting.com>
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
In-Reply-To: <Z1mk08SHEd5_vc99@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/2024 15:42, Johan Hovold wrote:
> On Wed, Dec 11, 2024 at 03:04:12PM +0200, Abel Vesa wrote:
>   
>> +/**
>> + * drm_dp_lttpr_set_transparent_mode - set the LTTPR in transparent mode
>> + * @aux: DisplayPort AUX channel
>> + * @enable: Enable or disable transparent mode
>> + *
>> + * Returns 0 on success or a negative error code on failure.
>> + */
>> +int drm_dp_lttpr_set_transparent_mode(struct drm_dp_aux *aux, bool enable)
>> +{
>> +	u8 val = enable ? DP_PHY_REPEATER_MODE_TRANSPARENT :
>> +			  DP_PHY_REPEATER_MODE_NON_TRANSPARENT;
>> +	int ret = drm_dp_dpcd_writeb(aux, DP_PHY_REPEATER_MODE, val);
>> +
>> +	return ret == 1 ? 0 : ret;
> 
> This looks correct, but I had to go look at drm_dp_dpcd_writeb() to make
> sure it never returns 0 (for short transfers).
> 
>> +}
>> +EXPORT_SYMBOL(drm_dp_lttpr_set_transparent_mode);
> 
> This appears to be what the driver currently uses, but why not
> EXPORT_SYMBOL_GPL?

drivers/gpu/drm/display/drm_dp_helper.c is not GPL licenced, so
this is the right macro to use.

Neil

> 
>> +
>> +/**
>> + * drm_dp_lttpr_init - init LTTPR transparency mode according to DP standard
>> + *
>> + * @aux: DisplayPort AUX channel
>> + * @lttpr_count: Number of LTTPRs
>> + *
>> + * Returns 0 on success or a negative error code on failure.
>> + */
>> +int drm_dp_lttpr_init(struct drm_dp_aux *aux, int lttpr_count)
>> +{
>> +	if (!lttpr_count)
>> +		return 0;
>> +
>> +	/*
>> +	 * See DP Standard v2.0 3.6.6.1 about the explicit disabling of
>> +	 * non-transparent mode and the disable->enable non-transparent mode
>> +	 * sequence.
>> +	 */
>> +	drm_dp_lttpr_set_transparent_mode(aux, true);
> 
> Error handling?
> 
>> +
>> +	if (lttpr_count > 0 && !drm_dp_lttpr_set_transparent_mode(aux, false))
> 
> No need to check lttpr_count again here.
> 
>> +		return 0;
> 
> I'd check for errors instead of success here and do the rollback before
> returning -EINVAL.
> 
>> +
>> +	/*
>> +	 * Roll-back to tranparent mode if setting non-tranparent mode failed or
>> +	 * the number of LTTPRs is invalid
>> +	 */
>> +	drm_dp_lttpr_set_transparent_mode(aux, true);
>> +
>> +	return -EINVAL;
> 
> And return 0 explicitly here.
> 
>> +}
>> +EXPORT_SYMBOL(drm_dp_lttpr_init);
> 
> In any case this works well and is needed for external display on the
> Lenovo ThinkPad T14s, while not breaking the X13s which does not need
> it:
> 
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Johan
> 


