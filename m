Return-Path: <linux-kernel+bounces-226299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C08913CA0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 18:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4361F22883
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3D41822EA;
	Sun, 23 Jun 2024 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tsNz3QuB"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8BB181D02
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719158901; cv=none; b=HoQSnlsBo/XnoPs70Fr1n1SS/8KdYa1iEakCo+O1LlH7/6Imm3XnouhqquAL2/LfPEz9upWL0N2i+NURfhEPNebYe24fxPmyjDr2Bn6ejT6FHA6qEHLUjt4r6QJDkiULdK9k2OZPzNIXbvF1307OXhIoUXJahPW6SILKMI4xGNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719158901; c=relaxed/simple;
	bh=Sq+bFSIeFe7iNmv+hWWy8VAkvA0unBGX+tgRmU4bC08=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LbksC3I2n2utksN4sPFBi/iwRPdGCmVIfMB7GwJS4DBek4T90jcqnUX0/YCPDa68TtA3NaDD7B81nDE33T6oBJ70dhQK3CzQ3uyBS1u7rjGdZBw5jLfIvr3tZ6HT4Zr/zAiTxmt8qiWHFUdX6UwHqgE9aXcU6m5iKTTFRdX/OzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tsNz3QuB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42122ac2f38so20304365e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 09:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719158898; x=1719763698; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7JThiaVCOwwrTPhSIGm2vfpP5L/VE7fGS+pTVte+rxw=;
        b=tsNz3QuBJhaELH+KPwe6/1YFtGXdQuHyOOk6/K4EveHRSL+birsS2+IePjMkZyBmJw
         QzITae3ZWO/+k++QQ62+AxqRNLSA1L720SBhee5u6EZh3tv/3KTGAUAMrgJXZFUfScIr
         AxVmk1xrmVRrlBQ3ywuJRMCKqFymJM89goMW+He0mW7OAYPhgO0mmRZFaJju+B58fKQ0
         z2a6vSDltmlJ0Zd/C0ABIgrnqZ/Wpqhl3wK9Gjv60ud6EQ56nodjG+k/UVnR+cYyHS0H
         sTlTflGRvtWMeTebndkDg+DQWbYO9TVA/EzVAalBR0vEAN9s6c/HNfMrJXyJkuI0L7Wa
         pYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719158898; x=1719763698;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7JThiaVCOwwrTPhSIGm2vfpP5L/VE7fGS+pTVte+rxw=;
        b=ta39N4987ncDKR6ZeXzcv+6Ccp/co9Mur9UiDyYFK/nFPBTNvrL5glQXpW1C+Q6czB
         8F+SmSme6kKHcmp7IOXZYcbHQsFTuwDfHy+4kdFwo9czxCQRqBB5nXiOBLOBUZa59B+Q
         UH+0ck9giDelNvMziaedgatMhh1DylRcyMMK92Fr9leW04n1I/OOYqX3hbheymuGouLL
         e4bNP7xWniuhRsX06KrFSmkv4LBI/EcnrqRJpf4A/99Pz/CdneZnoAP3vK1VqmOfBKVr
         wT0CTlvFoWhAtBYX4erMqbKrpc/LCZBKDRx25/ZNMcqMrF/z1PGJykbi4+C9yy43Lj2d
         d1VA==
X-Forwarded-Encrypted: i=1; AJvYcCXKk4xObbDg3eFJCggdX/blquUkR1q6V2jf31LQEftk5kmk6amN0V6P4BEVcVvAca0bNSTvqye1Fpx6q8V2gpSeJY/J1Vb8Q4mtjfaH
X-Gm-Message-State: AOJu0Yypvyy0lRBygoUAULt9CoRZxASmpa+13fsQ2KtgKlFqa1QQ6G+1
	fntCPE5T/e+6ckeuwDUh2Ru0DaAzwlhtn8ZT44kK+RWNdSL51oeoZ8aK8yNh1h4=
X-Google-Smtp-Source: AGHT+IEkyRCQyQQjUSoXKygwfsmCECJmHw5ib4QihasFfGgQiZ2NxdhkEgGWQmFXcYaDFtQQ5WCIYA==
X-Received: by 2002:a05:600c:6a11:b0:421:8234:9bb4 with SMTP id 5b1f17b1804b1-424895fb1c5mr29449145e9.19.1719158897843;
        Sun, 23 Jun 2024 09:08:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e59d:dab8:2290:4b4a? ([2a01:e0a:982:cbb0:e59d:dab8:2290:4b4a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42471584311sm129286875e9.0.2024.06.23.09.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 09:08:17 -0700 (PDT)
Message-ID: <8729845e-00f5-4bdd-9804-ddb76913904a@linaro.org>
Date: Sun, 23 Jun 2024 18:08:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3] drm/panel: raydium-rm692e5: transition to mipi_dsi
 wrapped functions
To: Doug Anderson <dianders@chromium.org>,
 Tejas Vipin <tejasvipin76@gmail.com>
Cc: quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240620181051.102173-1-tejasvipin76@gmail.com>
 <CAD=FV=Vpb2xy68LUT9MRi2d=Lze=5AyPjV-ff5FLW30Q6MasJQ@mail.gmail.com>
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
In-Reply-To: <CAD=FV=Vpb2xy68LUT9MRi2d=Lze=5AyPjV-ff5FLW30Q6MasJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/06/2024 21:18, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jun 20, 2024 at 11:12 AM Tejas Vipin <tejasvipin76@gmail.com> wrote:
>>
>> Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi:
>> Introduce mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
>> ("drm/mipi-dsi: wrap more functions for streamline handling") for the
>> raydium-rm692e5 panel.
>>
>> Additionally, the error handling in rm692e5_prepare() is changed to
>> properly power the panel off in the case of a wider range of
>> initialization commands failing than before.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
>> ---
>> Changes in v3:
>>      - Remove extra blank line
>>      - Expanded on error handling functionality in patch notes
>>
>> Changes in v2:
>>      - Change rm692e5_on to return void and take mipi_dsi_multi_context
>>        as an argument.
>>      - Remove unnecessary warnings.
>>      - More efficient error handling in rm692e5_prepare
>>
>> v1: https://lore.kernel.org/all/20240615093758.65431-1-tejasvipin76@gmail.com/
>>
>> v2: https://lore.kernel.org/all/20240619033351.230929-1-tejasvipin76@gmail.com/
>> ---
>>   drivers/gpu/drm/panel/panel-raydium-rm692e5.c | 238 ++++++++----------
>>   1 file changed, 99 insertions(+), 139 deletions(-)
> 
> Thanks! I normally let non-urgent things sit for a week or so before
> applying them, but I'll be on vacation for some of next week and the
> one after. If this is still pending when I get back then I'll try to
> apply it as I'm getting through my inbox, though I'd also be happy if
> someone else (maybe Neil?) wanted to apply it next week.

Enjoy your vacations! I'll handle it.

Thanks,
Neil

> 
> -Doug


