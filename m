Return-Path: <linux-kernel+bounces-250804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD1F92FD04
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7A51F24238
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D5E172BC8;
	Fri, 12 Jul 2024 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6f2aYu9"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203441E4A9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796197; cv=none; b=kXB/7odchksu2LGYXCg86bgeNIa9EOR98R45L6CSCzIwHiF+vZxfw/Ih5QWcXP3+6MMP3cQMP0K5DaTpkgFdSRlWHGXtePAOHSt3enRbGGTMvR4HPfE1YkVYO8PLWE+ATh3+Hmoffk6vvSxWHeE1JYmrJAFq/UXGAFPajTL7p3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796197; c=relaxed/simple;
	bh=SSKRtsXyzHZFJ2vEEJZxayCvLBN10jSdkeQ4SPgwQyc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XD4R2Irq7uBy4CIBrpDuZX9Zby3VTjEramttybIKIiU7wzpRMfYnxHjjvpJUr4d/e7FGIleGLbIySppyysOKkuOaTfdBz0Fl+8BemaP92lpoZMydfDTSTzvq/2s/nKGaZUXnjimhYg9Ujtz+Y7mqNNcWc50LpgYJUKSpb7GLzVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T6f2aYu9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e9fe05354so3052703e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720796194; x=1721400994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i7PJER1WcNMLVoA4+jwbRI3bEuqBAe5uHPV+6MR3WXI=;
        b=T6f2aYu9RviWKPb2+dVH0v4WygtLep6m4svNThn/T3ggMHCJI0t9REfbF0Xu/5F/II
         i9Ek3Bl7/KbUBW+PCvOgQv5noEeYNIE5bPldkaPJ4SqjAw95XupR1PRdlwGBiYHW0eso
         0wpSCj+FlM6iooed1xNOb0LOOoPo6KboLY016pex67kAEGMaTJ1+w4UTu9i1T1rsRx8Q
         P4/sGeoY49314TZTg65pizG2mJLlHlKAfxbMQiDjOoeoyUGwFINDJ0/HIH/39muVtUBP
         coBwrVoB5j12U0UoYawkwelAVnv/9w+FLtSgXoYHksw+kMOuVwTD4bmVY/1iQXcvCsXL
         a77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720796194; x=1721400994;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i7PJER1WcNMLVoA4+jwbRI3bEuqBAe5uHPV+6MR3WXI=;
        b=jWYPcYZCFDL8WB8kaXO4SEJ0iZ5q10SvcqcCTf34Zf3A1po0nEVN9PRjDVjvO7vaG/
         OuYAK0ITV8h5BMU2z8Xo+DKovUhUJdHrelYBjMiv8T+CkAPVzNaNArYNiLfxVjMFmKHX
         6mLV6JVuTgCfREDmnL6pi8CFbqs5cOEBuA1dkvl5UNHY4B6N3qLYRT+e3bBKZitxRRhy
         nSBqmHbZjAtLbFybeuxKktM02HOBR0fuJ5yvLqZ8LIdopQyoYRF250RTGfw9y+AGWtTu
         p1nitalOzAVzua1/ODnNfDwQcnQGQ4s22iAS+bm7fNEMf5yo0r+wtkAA+m4OTC0Pjrx7
         OeyA==
X-Forwarded-Encrypted: i=1; AJvYcCXTygiY6F1jIzWPHAFya9g864K0iRtv1mDfT3IROa9uPB/3W3flvvgwZ9BpbqaNnNGTKD0VsvKZASOnTELZUJJcvhBi4+sBhATf9Y4y
X-Gm-Message-State: AOJu0Yx5bEFH3rPxWCQjND4IUhJA86FIH1bIMvInRHE6N2zNn0jNsc8t
	cr1/XU8NQFbVPALQNoGwGPX7LCwheaOv8oxBt8gJ4measAjyzMS3amMiH054eho=
X-Google-Smtp-Source: AGHT+IFKsQa4tj4EnMtXSYCImi7RYxWXOxCwTzx3qALEfPlt1OtJI1helQ394X7LtJ9DSijPFxVFiQ==
X-Received: by 2002:a05:6512:3b20:b0:52c:adc4:137c with SMTP id 2adb3069b0e04-52eb99949a2mr8484666e87.20.1720796193960;
        Fri, 12 Jul 2024 07:56:33 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:123f:f92c:4c8f:b8cc:9804:975e? ([2a0d:e487:123f:f92c:4c8f:b8cc:9804:975e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f27846bsm25959965e9.25.2024.07.12.07.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 07:56:33 -0700 (PDT)
Message-ID: <4f3b24d6-9638-49d0-8308-00da09c7ed76@linaro.org>
Date: Fri, 12 Jul 2024 16:56:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 4/4] drm/panel: ili9806e: Break some CMDS into helper
 functions
To: Doug Anderson <dianders@chromium.org>,
 cong yang <yangcong5@huaqin.corp-partner.google.com>
Cc: Michael Walle <mwalle@kernel.org>, quic_jesszhan@quicinc.com,
 linus.walleij@linaro.org, airlied@gmail.com, dmitry.baryshkov@linaro.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240710084715.1119935-1-yangcong5@huaqin.corp-partner.google.com>
 <20240710084715.1119935-5-yangcong5@huaqin.corp-partner.google.com>
 <D2LQJROQYIY3.2Q88EXS8HUDLQ@kernel.org>
 <CAD=FV=WAosZPSKdpwR6pjOmiy4hih=jXaMg2guuVgmc+qj-Csw@mail.gmail.com>
 <D2M42ODWQPAU.I0BMEOLKUP29@kernel.org>
 <CAHwB_NJ+YEMoL18Sr9HFmTVH_ErDztyF7vxxPFAE0Y2ta3dO0A@mail.gmail.com>
 <CAD=FV=VNx5qEyWDvVz6AVDryqvw09tkYRYMjbFuUQS4Wvyok6Q@mail.gmail.com>
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
In-Reply-To: <CAD=FV=VNx5qEyWDvVz6AVDryqvw09tkYRYMjbFuUQS4Wvyok6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/07/2024 21:36, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jul 10, 2024 at 6:09 PM cong yang
> <yangcong5@huaqin.corp-partner.google.com> wrote:
>>
>> Hi,
>>
>> Michael Walle <mwalle@kernel.org> 于2024年7月11日周四 03:38写道：
>>>
>>> On Wed Jul 10, 2024 at 9:12 PM CEST, Doug Anderson wrote:
>>>> Hi,
>>>>
>>>> On Wed, Jul 10, 2024 at 2:02 AM Michael Walle <mwalle@kernel.org> wrote:
>>>>>
>>>>> On Wed Jul 10, 2024 at 10:47 AM CEST, Cong Yang wrote:
>>>>>> Break select page cmds into helper function.
>>>>>
>>>>> Why though? I don't find that anything easier to read. In fact, I
>>>>> deliberately chose not to factor that out into a function. It's just
>>>>> a sequence of magic commands, taken straight from the datasheet. So,
>>>>> I'd like to keep it that way.
>>>>
>>>> The consensus of previous discussion on the lists was that folks
>>>> agreed that we should, where possible, make it more obvious what these
>>>> magic sequences of commands were doing. IMO separating out the page
>>>> switch command helps. Certainly I'm always happy to hear other
>>>> opinions, though.
>>>
>>> Fair enough, but in that case, one should take the datasheet (which
>>> you can find online) and replace all the magic numbers with the
>>> correct command names from it. E.g. 0xff is the ENEXTC register. To
>>> be clear, I'm not just talking about the "switch page command".
>>>
>>> As patch stands, I don't see much value, TBH. On the contrary, you
>>> make it harder to compare it with the Ortustech panel datasheet.
>>>
>>> just my 2c,
>>> -michael
>>
>> If all drivers replace all the magic numbers with the correct command names,
>> it will be a huge amount of work (assuming that the datasheet can be found).
>>   I am afraid I don't have enough time to complete it.  Thanks.
> 
> Makes sense. I'd be interested in hearing the opinion of others in the
> DRM community about whether they'd prefer to land something long this
> patch as-is or drop it.

I don't have a strong opinion, but I think only changing the switch
page operations doesn't make a lot of sense by itself.

Having a much larger register coverage would be preferred.

Neil

> 
> -Doug


