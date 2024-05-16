Return-Path: <linux-kernel+bounces-181039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DB58C7692
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2F21C2127D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A58146006;
	Thu, 16 May 2024 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/xs5voZ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217A9145B37
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715863001; cv=none; b=Sii2DJjypmSTgGNFOr4bKODlnmSc6GfKWuUtW3LIj+B58xa4G2gi+pmoq96jMiBsGubbU9LSN9ZmV7D5Kg4vXacN6NjpPJrtVfNOa6DpC/PPVYjDwW29CrRJm49S4C+obsdwmeUgZoOvbQsbD5c/0iE4TkOlnZ4pW5o3PAVtSA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715863001; c=relaxed/simple;
	bh=wqO7+0Nj+t4DW2OQpnChBRs6IiuvN9tF3cG7kCxcPwE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CZBpHc0cAQj5WT4TwiXA6vb6AH2FeoYj7+mje61/ZshRSe8IzMzB7DFcQoRBJxDDO8/Sy1H/Zrc3dqIntIo5V3hOg8bsMGpVP+BjN1lgtKrQZRtjYJ6QA5ANq9iB4C9gIti74rCJDpEyOvjegH1ZHZu0+yw/Q48fE9cEECCDkfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d/xs5voZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4202ca70318so3280375e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 05:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715862998; x=1716467798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7u9UgrXAiHW9UrrIdHLjqFr2KCY8YsT8XD0QgC4VHdw=;
        b=d/xs5voZB/6zvIt8KsydTWNNU5xKA6jj1OoEhIOtd9Fa9e7PzI34DS159eWogmlmAe
         4UfTqbILIm0BfHk4j2+ghhcn1C3S2X2Bis715Cvo5GZOPFLhoCj+D9pTI0hooV9EW8BP
         ki6kqyKpsAhnu3O+z41+yWxwfVojqH04NdGNnsVgS9AbeOdHpPg1R5HXh3/oyQx0veOv
         YnesCa6OGAN5bFfBrNfA7lUcMzsZdQInjhc9iNCW8vOK/GoazNjKfg5/HDzbvOHhjQCz
         iDfakEC/LJBnlBLlJjPCr7GoJ9cyijyg5z3OMeWrEu3uCdlrIu78gmk1UdFpyBraFGbo
         AZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715862998; x=1716467798;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7u9UgrXAiHW9UrrIdHLjqFr2KCY8YsT8XD0QgC4VHdw=;
        b=L4GtyL01yV/rnxtNztFkFQaBT93hvkyF7fcCbQsfErCSXA5dizFEMq+9LdenEyXJPh
         XFx+IuvH4qrFu6XGx4Uxx9ad4vznZMBhYrSDP+C3psr3b+MZmSJPooyz3KdQBbUApJoX
         7OmQBkkx0fP+VfZaqG7ouAV1ZJwuT8796cwJY54YWQx/Z3EPVCTswMH9uCz3pjtbCmFP
         Jl6FscP+otAWwL0OgpjWgzuzlJJ2kd2QWrPusdzLrldhS9Gloyf7WYPY2+PXGAIyHNlT
         Z/IxZwA32HoS+FE0IRhD1PZypbVYWZKac9f8zIFz8qUbN5UTOcZ4iJmj0P4vsCXyUs4E
         AUfg==
X-Forwarded-Encrypted: i=1; AJvYcCWFTkBJO9aZw9Lu/FBeeWYrzyXdfX0pURY2KTtjuHmruYmcJ8OEMeA/uMUP3Cm4hD797E4plYJI7vmlCIWbYCk97iVmSIrU0VjEO1cE
X-Gm-Message-State: AOJu0Yy5kZl3aLfY8Sgz9jqNtKgd/L3SZgUYoPoKhPvduFlzJaO+h48h
	G3Z7I6S3KNLuxqAoq1Ypm+6DPAVj8kAZbLhiUMuepcW1UOByj0Zh3wGNstB+1Jo=
X-Google-Smtp-Source: AGHT+IG1y1kInySg9tuz9weH7g2TaNqHI/69k6mVraLoKsovAscO+fx1x3wznKwq9TAkINyZgf+a3w==
X-Received: by 2002:a05:600c:444e:b0:418:fb6f:5f59 with SMTP id 5b1f17b1804b1-41fea931860mr146950595e9.2.1715862998070;
        Thu, 16 May 2024 05:36:38 -0700 (PDT)
Received: from [10.91.0.73] ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce24cdsm271027755e9.15.2024.05.16.05.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 05:36:37 -0700 (PDT)
Message-ID: <6f54a590-d3dc-48f2-9061-27afb1c34fef@linaro.org>
Date: Thu, 16 May 2024 14:36:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 3/6] dt-bindings: display: simple: Add Microtips &
 Lincolntech Dual-LVDS Panels
To: Aradhya Bhatia <a-bhatia1@ti.com>, Liu Ying <victor.liu@nxp.com>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thierry Reding
 <thierry.reding@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: DRI Development List <dri-devel@lists.freedesktop.org>,
 Devicetree List <devicetree@vger.kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Jai Luthra <j-luthra@ti.com>
References: <20240515095133.745492-1-a-bhatia1@ti.com>
 <20240515095133.745492-4-a-bhatia1@ti.com>
 <9f3c1825-0438-464e-bd6d-88da6a9c3b3b@nxp.com>
 <cecb865d-2f59-4cdf-991a-4607b200d503@ti.com>
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
In-Reply-To: <cecb865d-2f59-4cdf-991a-4607b200d503@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/05/2024 13:06, Aradhya Bhatia wrote:
> Hi Liu,
> 
> Thanks for reviewing the patch.
> 
> On 16/05/24 07:49, Liu Ying wrote:
>> On 5/15/24 17:51, Aradhya Bhatia wrote:
>>> Add the Microtips Technology USA's MF-101HIEBCAF0 10.1"[0] panel,
>>> MF-103HIEB0GA0 10.25"[1] panel, and Lincoln Technology Solutions'
>>> LCD185-101CT 10.1"[2] panel.
>>>
>>> Thes are all dual-lvds panels.
>>>
>>> Panel Links:
>>> [0]: https://simplespec.microtipsusa.com/uploads/spec/datasheetFile/2588/13-101HIEBCAF0-S_V1.1_20221104.pdf
>>> [1]: https://simplespec.microtipsusa.com/uploads/spec/datasheetFile/2660/13-103HIEB0GA0-S_V1.0_20211206.pdf
>>
>> This one mentions some controls in '3. PIN DESCRIPTION' which
>> don't comply with this binding, like RL, TB, STBYB and RESET.
>> Note this binding only allows compatible, ports, backlight,
>> enable-gpios and power-supply properties, nothing more.
>>
> 
> Maybe the internal module _can_ support these control options but the
> actual panel hardware does not expose any of these controls on its
> connector pin-out, and hence has no possibility for additional SW
> control. Even for the usage, the device-tree node for the panel only has
> "compatible" and "ports" properties defined.
> 
> The panel is being used within the confines of a simple panel.

If somehow some modules with those panels would need more control lines,
we'll simply move them out of simple panel bindings & drivers if
required.

Those are perfectly fine as is, we don't want useless description and dead code.

Neil

> 
> Regards
> Aradhya
> 
>>
>>> [2]: https://lincolntechsolutions.com/wp-content/uploads/2023/04/LCD185-101CTL1ARNTT_DS_R1.3.pdf
>>>
>>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>>> ---
>>>   .../display/panel/panel-simple-lvds-dual-ports.yaml         | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
>>> index 716ece5f3978..e78160d1aa24 100644
>>> --- a/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
>>> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
>>> @@ -41,6 +41,12 @@ properties:
>>>         - auo,g190ean01
>>>           # Kaohsiung Opto-Electronics Inc. 10.1" WUXGA (1920 x 1200) LVDS TFT LCD panel
>>>         - koe,tx26d202vm0bwa
>>> +        # Lincoln Technology Solutions, LCD185-101CT 10.1" TFT 1920x1200
>>> +      - lincolntech,lcd185-101ct
>>> +        # Microtips Technology MF-101HIEBCAF0 10.1" WUXGA (1920x1200) TFT LCD panel
>>> +      - microtips,mf-101hiebcaf0
>>> +        # Microtips Technology MF-103HIEB0GA0 10.25" 1920x720 TFT LCD panel
>>> +      - microtips,mf-103hieb0ga0
>>>           # NLT Technologies, Ltd. 15.6" FHD (1920x1080) LVDS TFT LCD panel
>>>         - nlt,nl192108ac18-02d
>>>   
>>


