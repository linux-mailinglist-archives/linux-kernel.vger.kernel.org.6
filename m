Return-Path: <linux-kernel+bounces-180684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989BD8C71BF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500A42823CD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9BA28E11;
	Thu, 16 May 2024 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NquOSk2n"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBA025778
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715842523; cv=none; b=j4sk9cTYYTN6gL3U6NzyiFUB4FwVGDcS0Atm/8dmv3/YfRR5wQVC7P2nqjP7G5ldSWS04SGvEo8sLATYHJcSU1zcPA44+2tpD18uScE7/2bjSSCGwNA/rOXM88z9IXQWq5bNp9Fk3230DBQbLBJlY0S/n9u5izYPrXzcoT9kFXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715842523; c=relaxed/simple;
	bh=AvgdCoHfSzIMek2YyD7gcjmptyQmLQh6/OM/iTS71lI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mEvy7iHg4bCwbkAIRmmQOp8dll6q1r7d7MLpP9IfSYZo9caBNZBPGlo/OGwr19DRNtt0Dz+UCpP8Ec47TYdycRSEY5FRKJhLtOW7V1LVFJe+hRt7zJ//zROmRsdKLjhpPXWP8m7ksqJEbOk5BMyX7jfMajYfv0tV0A27tTxIhCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NquOSk2n; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4202959b060so3598755e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 23:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715842519; x=1716447319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zApq4EhEn1SkxpN84kRXwF8kImjxLliRj17breW4Is4=;
        b=NquOSk2nT/1cX6TWm/O4WVUquLLWEv7k2TC8w65nbnWEhA44dAU2wgqlyJqHiMVoNv
         Me696o9LKp4BfpLFco8ojgdbu6+JInhq96YuWOE+nW6nkEUWUNoXTjktG8giOZDSlFqO
         ic3ZeWSBUfD7mavVM4yvf8Dcb+RaExBzGiRGQFdQUFr3B7W79aEaucTjmw3uD7I8Pomt
         VUjwXaIMX/mD8Po/CMTqHZbJlti4aZvdOwbBMhPk+EXCAuxH6jcnJSS63zcyRtyWUQub
         SGZgc+AOh2ioNZPq/iUVk0IKZl+6OrdNuIlUATmggDzOd8g175s07yOlCxLMJlHorCEo
         g6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715842519; x=1716447319;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zApq4EhEn1SkxpN84kRXwF8kImjxLliRj17breW4Is4=;
        b=NSqd0ZY0syTWbO8u86phVp9NIb8Aky//zYX/RdGzj3eCROtWHZ3DyU/TePr/iF+N7l
         qIyn0DFgt8JhmptafYzSgiehsHw612zSwnK/T9ycW6YmQcVSTVQC1YF+ZWsYLf66M/jm
         UU1wtOJiVlhA9WJcHzZbqZh1hUTS1cqae++Ilzls0CumodpD3BlkHB4wjqMtvoQiMAzg
         ZPk2KPFrUgPwOqJb+USpLNTU4vf+v8eq/Suk8zS6JR3CQvnQlLt7dbleIhVPAGpEw+Ah
         YAmDIR3ARyUYAIjp+/6Qw/XoX/JLJrwYFyQwJcl2oc9nnWpQjLdCKyx62jNm5yy53SL5
         Qpmw==
X-Forwarded-Encrypted: i=1; AJvYcCVNUnK30/mhbA4FiaM49BcBfrEGXnXkJbthbiFqkO/MAHDjr/2bdKzDd+quqHZ0slHbUD5kA39H2G6mD1n08dio9uEKEv/8Ln7/rIU/
X-Gm-Message-State: AOJu0YzsFu9tJK2HR1Os5mPx6YyF9Li/ZNZXmg/6s1AQqyd8z13Ha9yw
	HQIQtN7MLmI4P+jEs4ln+kuw9ef9rSFH17771NA4VFWBlOsfTJ9HAxi6nihd8CA=
X-Google-Smtp-Source: AGHT+IHmfhzYhswL+q5F4aVR+npRhzdTj2L7dKbOyBQ9wI3xHaXvPRu7CbbM43TEedhU2ph/itihzA==
X-Received: by 2002:a05:600c:3108:b0:416:536b:683a with SMTP id 5b1f17b1804b1-41fead65000mr120876815e9.32.1715842518928;
        Wed, 15 May 2024 23:55:18 -0700 (PDT)
Received: from [10.96.0.27] ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4201916e7c6sm118983755e9.12.2024.05.15.23.55.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 23:55:18 -0700 (PDT)
Message-ID: <7b488473-7fd1-4f4f-8c32-72e84420b478@linaro.org>
Date: Thu, 16 May 2024 08:55:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [v7 3/7] arm64: defconfig: Enable HIMAX_HX83102 panel
To: cong yang <yangcong5@huaqin.corp-partner.google.com>,
 Doug Anderson <dianders@chromium.org>
Cc: sam@ravnborg.org, daniel@ffwll.ch, linus.walleij@linaro.org,
 krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, conor+dt@kernel.org,
 airlied@gmail.com, dmitry.baryshkov@linaro.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com
References: <20240515014643.2715010-1-yangcong5@huaqin.corp-partner.google.com>
 <20240515014643.2715010-4-yangcong5@huaqin.corp-partner.google.com>
 <0fcdb0ac-2e4a-44b2-a5d6-a67a1d747df8@linaro.org>
 <CAD=FV=XkBkQUN-93eQDKZcw_66uSeNBBhbiq2hRLcFN+Ck71RQ@mail.gmail.com>
 <CAHwB_N+foZpCjqUy0dJdS2wBbUjHVRQQP0p7S_eTG1Yrh0bgPw@mail.gmail.com>
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
In-Reply-To: <CAHwB_N+foZpCjqUy0dJdS2wBbUjHVRQQP0p7S_eTG1Yrh0bgPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/05/2024 08:43, cong yang wrote:
> Hi:
> 
> If it is determined that a separately patch needs to be sent, then I
> will remove this patch in V8 series?
> 
> Doug Anderson <dianders@chromium.org> 于2024年5月16日周四 05:28写道：
> 
>>
>> Hi,
>>
>> On Wed, May 15, 2024 at 2:16 PM <neil.armstrong@linaro.org> wrote:
>>>
>>> Hi,
>>>
>>> On 15/05/2024 03:46, Cong Yang wrote:
>>>> DRM_PANEL_HIMAX_HX83102 is being split out from DRM_PANEL_BOE_TV101WUM_NL6.
>>>> Since the arm64 defconfig had the BOE panel driver enabled, let's also
>>>> enable the himax driver.
>>>>
>>>> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
>>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>>>> ---
>>>>    arch/arm64/configs/defconfig | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>> index 2c30d617e180..687c86ddaece 100644
>>>> --- a/arch/arm64/configs/defconfig
>>>> +++ b/arch/arm64/configs/defconfig
>>>> @@ -864,6 +864,7 @@ CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=m
>>>>    CONFIG_DRM_PANEL_LVDS=m
>>>>    CONFIG_DRM_PANEL_SIMPLE=m
>>>>    CONFIG_DRM_PANEL_EDP=m
>>>> +CONFIG_DRM_PANEL_HIMAX_HX83102=m
>>>>    CONFIG_DRM_PANEL_ILITEK_ILI9882T=m
>>>>    CONFIG_DRM_PANEL_MANTIX_MLAF057WE51=m
>>>>    CONFIG_DRM_PANEL_RAYDIUM_RM67191=m
>>>
>>> You should probably sent this one separately since only an ARM SoC maintainer
>>> can apply this, probably via the qcom tree.
>>
>> Really? I always kinda figured that this was a bit like MAINTAINERS
>> where it can come through a bunch of different trees. Certainly I've
>> landed changes to it before through the drm-misc tree. If that was
>> wrong then I'll certainly stop doing it, of course.

Yeah we usually don't mess with arch specific defconfig from drm tree

>>
>> -Doug


