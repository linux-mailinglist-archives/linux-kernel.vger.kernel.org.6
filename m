Return-Path: <linux-kernel+bounces-292532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3082957085
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A55128204D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3844C175D50;
	Mon, 19 Aug 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMkG+YDU"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CCC42065
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724085494; cv=none; b=fAyGylVjUGlIq3fYLfRckDdpIJ7WzCszpliITRyAMwNJvSEYanajwsaAT3ILSEPXUApA4U5YWK0KEnAt4yk56nnpV41PQ71SAjiM65AjMVUJh4T3cEWjtgewzg0e2S8cQ62k4isJgqf4J12uktDvXEvLzXPBLpvly1ymQkrEtcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724085494; c=relaxed/simple;
	bh=mlT19qAV4okIIYQdw7O/J/ROZY+vISJv4HezKTW45nE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GAPrVqxNUBgIgypRBe2c4s07nOuIELCuaonUL3THAmQLTzaH8WltCVzA4Mqk1+JPtOUdEeNJ762J52Vroqv5x1I/A4VqWVEMrO2LJ9QphdaEOKTyO0ZO96ED6gV6X/0olQId41i/o8y6PLFFFRvIrBSnInUMvFMlqRv+c/oJNZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iMkG+YDU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428101fa30aso36306505e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724085491; x=1724690291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aupRQCxcZMoqMsFi03uVwOSnlXLz7pPIGDry2b1gMKQ=;
        b=iMkG+YDUltNuxs9B8U9zy5xfreWjMZ+96lSresx0qw913hXfBWgNXlnf9euRbq+Hko
         Cgq64P+m+/T2TQ7DEKcCRCNuLGBIeBm+ojjr4Jtpznvx9UkeyOEvgaozJOoFvi8/CkEn
         mYc2zBnZWH8uV0dRAQLr6JLQDVK4Q7JYJVPVZYSYVZJR0XYM6Lx9ZwTnT8BWJ1Jk9wOF
         SFxMdz/7JYjLaLMdy3ke/4peZ7P9WrN62kWWRsQKYl4qdzb/fb05PPV/pJNfZMfD/Qxo
         Ou5Nb3YDFjRxe05v7B72G+hh2SVYqQ0jnqflXSA15zmOYMnONE56m0j8xM7eJOXiKDnA
         ILOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724085491; x=1724690291;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aupRQCxcZMoqMsFi03uVwOSnlXLz7pPIGDry2b1gMKQ=;
        b=WNg7UsnD7kxLFmu9/gBeJVW4EgqnvMUdx9OsYbEM6d3pkuXpTqyNib3ok+t7Dd0gyn
         d5qXUheTHg/6dUkjjm50ijxQ7KLf1aGp4Qt07evht15rjQ2y2+kEtCFBvEEG1hOgqeEF
         d0/A/fB45BKKc1XdNdfHlD49igwaSqipaxgL0rvcj/5mu5M8+QMij6h+SdRjThBUaIDm
         Vt/MyZLzuFd8OmEMXnNSzMXFyREv5S6k5m9pSoiUZAwOD+9liV7E0VxJ+lREKVuiJ26L
         aYD13hATdXZNAAnzGBeljUPT2RCdrRj08hLkfrJNw04LWRA8UKvCvuhNFQW8oXbwJWn1
         tEdw==
X-Forwarded-Encrypted: i=1; AJvYcCVKZVZgHQQBzhasUdx4YdXApB+xWf/vjKGRLryvcUQdZTrR4YWE/NwxUAM5Gc09UerCl47z4TUzPb60bvvDRl51AbgwoLNkRrV9Uma7
X-Gm-Message-State: AOJu0YwmHvDQXMlCiRMfEwVBYCEyn96Rct7sHwLYpxhn2KTnZlzVNh02
	iX3yoG5pMyp6Q41CAY9YQdLb5BcT5v/FHuyWT2QcXKshGDHbMO9X8MOpYq+lU5KQ9vYrlJtVUJm
	N
X-Google-Smtp-Source: AGHT+IEOi2c8Np43tIFaYFeLdEU1i/a/0IyaAUgdSgqN9G16XNKD+O79mVMUDPMQcvXI9JJg4uhoPA==
X-Received: by 2002:a05:600c:1547:b0:426:62c5:4742 with SMTP id 5b1f17b1804b1-429ed785661mr71311075e9.7.1724085490334;
        Mon, 19 Aug 2024 09:38:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727? ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded36a95sm166423825e9.28.2024.08.19.09.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 09:38:09 -0700 (PDT)
Message-ID: <f868cbd6-11f2-4fb1-beae-639aaa1bb0d1@linaro.org>
Date: Mon, 19 Aug 2024 18:38:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: mantix-mlaf057we51: transition to mipi_dsi
 wrapped functions
To: Doug Anderson <dianders@chromium.org>
Cc: Tejas Vipin <tejasvipin76@gmail.com>, agx@sigxcpu.org, kernel@puri.sm,
 quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240818072356.870465-1-tejasvipin76@gmail.com>
 <4be2f1d1-534c-4c99-a35e-f354c75c88b4@linaro.org>
 <CAD=FV=UaYCW3hDp-eV9Wio-3iB2-PViy5Jj9VZxPEK2j+PPLkA@mail.gmail.com>
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
In-Reply-To: <CAD=FV=UaYCW3hDp-eV9Wio-3iB2-PViy5Jj9VZxPEK2j+PPLkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 18:14, Doug Anderson wrote:
> Hi,
> 
> On Mon, Aug 19, 2024 at 8:36 AM <neil.armstrong@linaro.org> wrote:
>>
>> Hi,
>>
>> On 18/08/2024 09:23, Tejas Vipin wrote:
>>> Changes the mantix-mlaf057we51 panel to use multi style functions for
>>> improved error handling.
>>>
>>> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
>>> ---
>>>    .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 79 +++++++------------
>>>    1 file changed, 27 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
>>> index ea4a6bf6d35b..4db852ffb0f6 100644
>>> --- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
>>> +++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
>>> @@ -23,7 +23,7 @@
>>>
>>>    /* Manufacturer specific Commands send via DSI */
>>>    #define MANTIX_CMD_OTP_STOP_RELOAD_MIPI 0x41
>>> -#define MANTIX_CMD_INT_CANCEL           0x4C
>>> +#define MANTIX_CMD_INT_CANCEL           0x4c
>>
>> Please move cleanups to separate patches
> 
> LOL, in a previous patch series I had the upper-to-lowercase in a
> separate patch and someone yelled at me to do the opposite and squash
> it together [1]. It doesn't really matter too much to me, but given
> the previous feedback I've just been suggesting that Tejas squash it
> together with his conversions. I'm OK either way, though.

Yeah it heavily depends on the rename, but I guess here it's fine to be applied as-is!

Neil

> 
> [1] https://lore.kernel.org/r/CAA8EJpo4WzMPNjpnkHt-_GJe2TAF_i_G+eTaJrGipMEzppc3rQ@mail.gmail.com
> 
> -Doug


