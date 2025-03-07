Return-Path: <linux-kernel+bounces-550820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983E8A56483
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528CB17424D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF9E20C473;
	Fri,  7 Mar 2025 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XgShIVOg"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FD120CCCA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741341647; cv=none; b=RU3HJqiADUjcInMXG+3QQ0Id0VnWTE1LN+j/C9ugkoEEXmBZpsfn9xKkmP8PIYdg/k2RsjyInlOCqSwbN5vGM6cJUqInYzHEWaIYevuy96mJ2nDBilB5dh9eWwZglOma+63PkRKkt2XgYvH4Pm6f2x9Nb7uJzYPSwIaWonJOUxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741341647; c=relaxed/simple;
	bh=apm7HFtYJKzbujRJ347C7xOyicPm3be+rbwpgKkgIZw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ug3EqYqiLWhSB8KF9FZzVy7JhFE7c7bDAIVztv6OIczwkwR1bGJZAxNcunkX6YDPpUP0OHLVnjA3+humcdzjrBYvhdUvIurHrHy+cgtUB5l5guiPW/wd0eZPDYQ9KCEq0Zl06mnpAEdUiGjFn2F+WuZxW3Es5UhrXZ4df/RC7m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XgShIVOg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso18247725e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 02:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741341643; x=1741946443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZiZ03YGBKb3coEK6nEaoU1/wKBDZKe/oaQy1DX/VsZI=;
        b=XgShIVOg6eiDpAHeGYmXzbY6RJ18znQ5AU/Nj1//Gh3UfaP4Uaj4e+icJHGDJrz9C2
         T01mHIZ9EP0uNiYnLbDa4YDuqaD3rxI2zhZkiVg9cYXpQIW2J/f7ZMfaEpO5W/llat/H
         kxyN7SdSuuEtnAclmAdpdbMwPToOywA2PW3zX/5C1gzXTNsB129NoBljkfZqrBg6rlgL
         BUrSYm48UNMZnULghcgZnLuOXHoTGZ3Tw6XHdcCZM19lTmayLN70jiFZUBZRoQ+EfOzf
         fGgqZ0pqPKZCr+Hzfj7JiDQu0wh804PjZ0fdC3w81Z3Jidt5s14bVVc1K2XRjClG0Wlo
         6vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741341643; x=1741946443;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZiZ03YGBKb3coEK6nEaoU1/wKBDZKe/oaQy1DX/VsZI=;
        b=hUenPql+Q3H2ReAk5yZbx5LjrsZTtxjldhnp628WsgyKu2UH0+9p69mMyFEG9gibH7
         6YvGueOLYdgNG1Bx+f2mQwMeEb+gf5fTfQIV0gEWhvBEhkE6aZ2vgMk47Jq4DKCOWijC
         zkSp4B485GViRTrJu909/R9a/u4GTz+YOLPdDeKEm8fWVbnsa7/Kuq7UN6iQi8GDPdoU
         la2bdxE/Fd4puii5vNkmEXo9tF4pPGek3fpQZF9G77POWLLmlIcgBvordhGsslnZrhad
         SoOYBEbtvO2ZSbJit/UBnNl5Rrb5n2DNNC5ZloqcIyXC+Y1B+Q8gXYBikndkww95Flh8
         qjBA==
X-Forwarded-Encrypted: i=1; AJvYcCX7Ebl3Vp5bw6KaaexwLknGdXjvD8ca1XxNaBX+OqTlbV3JC3izkpZPSq/yVbbubrMbS31LwvHrXPjFea4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEEuosc5tC2Bvuy8p7wx1V2IOG5D1fRBYEi29OeFac5RB1HMcN
	chyR1Dh4vTilZgLVlnhnKulPNNiEVHuEfxuKALTGT987iaET/mS8KkjaWR/Vv38=
X-Gm-Gg: ASbGncuZT0cT7+ClHmToyfPCffBaynXpJPh/t/ATIoiY7VTopab0LO5ft/pOIHJTNFS
	L85vEd1V12Exj4qO+e6PzSg8VpmgN0npHnE6o6hPWQ/bV5b6/UqXcWDH49e7sBk2zqtYmTE9J+s
	1VpOtQaP50VSmTfp1FRzbLRxWlELuuMl8VTIqtL3c74Kjy06ei8lpQX2MszRVP7oylbQoqCr+mg
	wqNeL5lSR8OvBvBJFUrsjyCmDeZ/K6gGwlTToLuhXi1LaxIWI2plePIstvLq3E1mPpBqBllIFA9
	Wi1sspQsJAtij5ktKswjbsvUYVQsdzGKcswnsztUaHuMhRVzsH4XPM6WOS5kQ+huRTbozbv3PAi
	rRIgx1bYysiDsWzWL7MQXTA==
X-Google-Smtp-Source: AGHT+IFPQHVquoDW1pJCsGtMWexMsdgKcxI80ZyycE0KtKJsDWGaMQZbcZcmjt9/NZ4f7dBj3xOoxg==
X-Received: by 2002:a05:600c:524d:b0:439:86fb:7325 with SMTP id 5b1f17b1804b1-43c60231b64mr25000755e9.31.1741341642950;
        Fri, 07 Mar 2025 02:00:42 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1ea4:9158:5668:7977? ([2a01:e0a:982:cbb0:1ea4:9158:5668:7977])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c102e01sm4915052f8f.93.2025.03.07.02.00.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 02:00:42 -0800 (PST)
Message-ID: <9696fd4c-b53f-41c4-9f8e-ae24d055210b@linaro.org>
Date: Fri, 7 Mar 2025 11:00:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: novatek-nt36523: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>,
 Doug Anderson <dianders@chromium.org>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 lujianhua000@gmail.com, quic_jesszhan@quicinc.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Anusha Srivatsa <asrivats@redhat.com>
References: <20250306134350.139792-1-tejasvipin76@gmail.com>
 <ca5b0825-a485-4bec-bd93-b57a8d7ced99@linaro.org>
 <CAD=FV=VoW-Zm5wY6Y9sr=GqnvfMP4urGw_zW8NJRHpdC4=rHXQ@mail.gmail.com>
 <0d473dc1-cbbe-4a1e-933a-938438db24f5@gmail.com>
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
In-Reply-To: <0d473dc1-cbbe-4a1e-933a-938438db24f5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/03/2025 18:38, Tejas Vipin wrote:
> 
> 
> On 3/6/25 10:58 PM, Doug Anderson wrote:
>> Hi,
>>
>> On Thu, Mar 6, 2025 at 6:05 AM <neil.armstrong@linaro.org> wrote:
>>>
>>> On 06/03/2025 14:43, Tejas Vipin wrote:
>>>> Changes the novatek-nt36523 panel to use multi style functions for
>>>> improved error handling.
>>>>
>>>> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
>>>> ---
>>>>    drivers/gpu/drm/panel/panel-novatek-nt36523.c | 1683 ++++++++---------
>>>>    1 file changed, 823 insertions(+), 860 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
>>>> index 04f1d2676c78..922a225f6258 100644
>>>> --- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
>>>> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
>>>> @@ -23,10 +23,12 @@
>>>>
>>>>    #define DSI_NUM_MIN 1
>>>>
>>>> -#define mipi_dsi_dual_dcs_write_seq(dsi0, dsi1, cmd, seq...)        \
>>>> -             do {                                                 \
>>>> -                     mipi_dsi_dcs_write_seq(dsi0, cmd, seq);      \
>>>> -                     mipi_dsi_dcs_write_seq(dsi1, cmd, seq);      \
>>>> +#define mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx0, dsi_ctx1, cmd, seq...)      \
>>>> +             do {                                                            \
>>>> +                     mipi_dsi_dcs_write_seq_multi(&dsi_ctx0, cmd, seq);      \
>>>> +                     dsi_ctx1.accum_err = dsi_ctx0.accum_err;                \
>>>> +                     mipi_dsi_dcs_write_seq_multi(&dsi_ctx1, cmd, seq);      \
>>>> +                     dsi_ctx0.accum_err = dsi_ctx1.accum_err;                \
>>>
>>> Just thinking out loud, but can't we do :
>>>
>>> struct mipi_dsi_multi_context dsi_ctx = { .dsi = NULL };
>>>
>>> #define mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx, dsi0, dsi1, cmd, seq...)      \
>>>                  do {
>>>                          dsi_ctx.dsi = dsi0;                                     \
>>>                          mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd, seq);       \
>>>                          dsi_ctx.dsi = dsi1;                                     \
>>>                          mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd, seq);       \
>>>
>>> ?
>>>
>>> So we have a single accum_err.
>>
>> Even though the code you used was what I suggested in IRC, I like
>> Neil's suggestion better here. What do you think?
> 
> I like Dmitry's suggestion [1]. If we went ahead with this we'd also
> only need to equate the accum_err for the few msleep calls. Since it
> does change the behavior, I'd like to hear another opinion on it before
> I go ahead with it.

As noted by Douglas, my solution doesn't change the current behaviour,
and I don't feel it's fine to leave one of the 2 DSI links fully configure
while stopping on error on the other one, it will lead to incomplete situations
and the debug purpose is not really acceptable, either it works or it fails entirely.
Leaving an half configured panel can damage it on some OLED like technologies.

Neil

> 
> [1]: https://lore.kernel.org/all/p2esqngynwfrshz5rqfnmx6qgwf4dclpkb3mphwg2vavx2jbcg@clqoy5tjh7bb/
> 
>>
>> Other than that, it looks good to me.
>>
>> -Doug
> 


