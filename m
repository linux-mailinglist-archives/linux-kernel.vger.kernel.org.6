Return-Path: <linux-kernel+bounces-211729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDD9905613
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 17:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E061F21E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D37117FAAE;
	Wed, 12 Jun 2024 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXIURYSK"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C744C17E90A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204414; cv=none; b=IlShm9HOjvSvflVNH/fHsoQ9cW/5kmpHXqqalpydNufBFMPNxZZ7qZu7V4JS1hJbTYlGSmkiRfotWwNgxP3Qhm1d/O52bJ4+KSz1J5dNSUEl9hTEWD9cbn2h0WF0DYT/EcJ2qVzRgcjG1IW13jVipB0gKlnlWy9eZYFjpYqSF1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204414; c=relaxed/simple;
	bh=f34fdBeyY/ZmGv0O8WhD9I3tze49PDqiPO6M3mFfPfk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZZM+EzOHP/1IqhAXbbpIcT87+h1rPteTlaxrBe8q740sffj9WfSZTmGIj71DQLKOhgBf/vwdZk14Qa1YdfA2ANmm213a6Q+KVO3khr8OBjLuRybfnzQbQpcvewLVnwex9QaqOhHq9JzEzhR2PKnNTVsQpWSO1Qs79LghoLeLlqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gXIURYSK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-421eab59723so26683695e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718204411; x=1718809211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jhh2/EbO+KzKdZ2Ceo1EYx6oUtTDKk/jJAIaFVIVoMI=;
        b=gXIURYSKL2460MC6KjA4+KDI1t5PVcIZwodO9/DegeMFiNN4Ws1chIxV9Ms4fA23kh
         EY3iz7EXyWEkKyOntpUyr1Fvx94E+tLZN2Msm5EuzWtli9gas1C+Hva5WB1hq8qsk3ZC
         /wPAIhfR39zbGF/Y834MStdXxXlDO0/KSIcHcJxESSYbFc89b+iYrEU1nd/8fpDA169+
         RYc1QOu+KSQ0vqxYcCzBpmJO/cujE083AzrMBNTnh7Kg1fhJYMAl6izQOds9XEiSMt5X
         yun/SdyfO4ZXbcDdPXWq3h9JDZm20hhGUbP4LuFqNN9t8JL7fd5VZu0fdulHwBGT5Wjc
         FOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718204411; x=1718809211;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jhh2/EbO+KzKdZ2Ceo1EYx6oUtTDKk/jJAIaFVIVoMI=;
        b=lRGP2OQmaytc4DoUF5gUl2nMFPyB3nIJcl0YcXq4o012NNpKrYUEJmTsjyYXx/8vqu
         tEi+XWoJuQ6qyWBQFeG2s4KxdFUwvCwGBUdQg2py7OJGetgDNijWjdNavXqrSe3+hQdn
         lL2zoNcbKj9aUcDiKv/8onKK4pYk+jYE791byGUQ4r3DHETLKBFmj506PZUawoWPC6y+
         vz0WTL9Xlgv/7hRGKMfrxqqww9ksFaDNkkVvgxTrMGYYRSWf/SkuR62if2PZnUN54FAh
         12mxJZM0VQLEm749l3ssqGQ6ix/Y3zasvNRX/1o/B7LleisUWu9NSQYVtHMqyc5fgYjz
         PVfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJHITkxbgkqFXV3PeiSx8z+wxGLJ0YCrlbGdimIssnbDRM2gxadeQdtxmRPQ8xkZv4CmB1Z8EbYNm2NhsDDYP7JVa/cvk/GhH9IT6s
X-Gm-Message-State: AOJu0YxpXMKHg5rw9sgfp0Wsp9SbvQ+crvj/e/CLagWCG3K+sCuPt2C/
	UA8NcJVvSjVi2YzxW4gOac51PT2EE7+q4z55VNCdfV5JWRf3vP5HEA7fm/znP4o=
X-Google-Smtp-Source: AGHT+IHYnEIUuKhHAo+YHne7cw1OEPvSnqErGK9eKY2wBCW7WO7/RuHH1cbOVIMAIN9kpXDkMQlCSQ==
X-Received: by 2002:a7b:cbc5:0:b0:421:2711:cde9 with SMTP id 5b1f17b1804b1-422864af234mr18269665e9.22.1718204410921;
        Wed, 12 Jun 2024 08:00:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:30bd:bf21:eed1:8aeb? ([2a01:e0a:982:cbb0:30bd:bf21:eed1:8aeb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870ebadbsm29401255e9.23.2024.06.12.08.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 08:00:09 -0700 (PDT)
Message-ID: <a29db79c-53ab-45a6-bdc3-b165475da0fb@linaro.org>
Date: Wed, 12 Jun 2024 17:00:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] drm/mipi-dsi: fix handling of ctx in mipi_dsi_msleep
To: Doug Anderson <dianders@chromium.org>
Cc: Tejas Vipin <tejasvipin76@gmail.com>, quic_jesszhan@quicinc.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, linus.walleij@linaro.org,
 dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240612133550.473279-1-tejasvipin76@gmail.com>
 <20240612133550.473279-3-tejasvipin76@gmail.com>
 <CAD=FV=VTEzSyTHm-YBwneBgpohK8uu460DER-GcsQWu-z9hJsg@mail.gmail.com>
 <9beb8011-cb0f-4694-87e7-d4c02de80cd8@linaro.org>
 <CAD=FV=Udsw=XCR204A8QGwVSAxyprLCrrOgmZf+pU+8m-7sQ0Q@mail.gmail.com>
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
In-Reply-To: <CAD=FV=Udsw=XCR204A8QGwVSAxyprLCrrOgmZf+pU+8m-7sQ0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/06/2024 16:52, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jun 12, 2024 at 7:34 AM <neil.armstrong@linaro.org> wrote:
>>
>> On 12/06/2024 16:21, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Wed, Jun 12, 2024 at 6:37 AM Tejas Vipin <tejasvipin76@gmail.com> wrote:
>>>>
>>>> ctx would be better off treated as a pointer to account for most of its
>>>> usage so far, and brackets should be added to account for operator
>>>> precedence for correct evaluation.
>>>>
>>>> Fixes: f79d6d28d8fe7 ("drm/mipi-dsi: wrap more functions for streamline handling")
>>>> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
>>>> ---
>>>>    include/drm/drm_mipi_dsi.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> Yeah. Looking closer at the history, it looks like it was always
>>> intended to be a pointer since the first users all used it as a
>>> pointer.
>>>
>>> Suggested-by: Douglas Anderson <dianders@chromium.org>
>>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>>>
>>> I've also compile-tested all the panels currently using mipi_dsi_msleep().
>>>
>>> Neil: Given that this is a correctness thing, I'd rather see this land
>>> sooner rather than later. If you agree, maybe you can land these two
>>> patches whenever you're comfortable with them?
>>
>> Applying them, but inverting them, fix should go first.
> 
> Well, they're both fixes, and inverting them means that you get a
> compile failure across several panels if you happen to be bisecting
> and land on the first commit, but it doesn't really matter. I guess
> the compile failure is maybe a benefit given that they were not doing
> their delays properly... ;-)

Yes, and thanksfully there's a fix for the build failure!

> 
> -Doug


