Return-Path: <linux-kernel+bounces-390259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8B09B779D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706121C220A9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76146196D98;
	Thu, 31 Oct 2024 09:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGx7GnQp"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5B7195962
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367290; cv=none; b=arP4y5C10pnaLqC/stqF+/w5RGOl5DxSw9+8P880w9VxNVilwsZAJQvKbJol16yz50UaR60K457h7tzVJ5QRADHRtsBeFA+03evyFPKXAPBxvTelnWVtqa5fsbCHfTO4I99ws0DgOgXdv179ikiwDoEKuEZ/k02dF7JL4CVbzSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367290; c=relaxed/simple;
	bh=NE5vZDjB7+rgog29LLIjVDR/nlczhRkJ9Yw+dtVVI6o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZTm8WnFFKQ1ij0r8LgNIdZfQuMK8lJ2qo587U6KXYk810SJvA4vhXjtgVc8qtsPpFHmlD9lWHtuygLaNZxE6q7XpuPpfQHFCk39tjoWMmhTM7GCQH0BJP6unCO5thLkP2ECQNwUY0NyTCugotTBvWcgnoukx7ZZg36SDo30ldRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BGx7GnQp; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb443746b8so5954441fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 02:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730367286; x=1730972086; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52187t9uJurq+P/uw4PiJkFFucVapnrqKoa1BJIfUH0=;
        b=BGx7GnQpaEIkWU2N6GFyqx+dacbgUtCtwnKpjzZk9n+fwH/GGk5F2rp7Dv4QUz/8K+
         d2vzDvyUiLPWG4tQ6YPxOU1/wHqFlLYJZLg44QaUA6W8BVn2qrVaZgggJEX1+87soWCx
         vHfnsio5Jc9rTci8Nw9xjiuHUkNjStFA0oGqCsESheth0EbDdap3YdI12C/S3T/7CUYc
         xqWkHFjDiKWA2EhHKt+Q4Mfhpwr6l1n1A00F1zr8w+N/mSz26PgvBCaEGK2GeQENmsP4
         c/BooB7DZyo8YdL8BmEoOIM1os0Jjs9kLWmWWpt1DPbYq0fd/5Um0CKg94pyo03TJfZ/
         wMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730367286; x=1730972086;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=52187t9uJurq+P/uw4PiJkFFucVapnrqKoa1BJIfUH0=;
        b=vubCTvYnot0TPJ98h+Dy+xoFwUHU5yyeDT2ocUE1LgmZQyEb1W+azX9iOVEsyLK0Yn
         WzB1hIEOGkYHwoVqWLoC/xgAiiG5q83AR+pmDqpvyNoGNNpy7OsDAuUgzap7ufmhABQH
         05bt6CZsZQUVirDiLfM/lATcIPVbLqVz8ElRDfXVu5RTg2gHvYnkjMtaMnJSuYNEQzfX
         KP35uPg04Yo5pO0RnnIHel0Iee1g0zaFq6UxgJgb31jS72K/9FjOriofWt2wydJcbSSO
         937okWk/iExUHrejlqd126s1gQ8cApJY5ZIRf3J7lKOyanMva7ZEsRGlDRdm8kdMADG6
         aHUA==
X-Forwarded-Encrypted: i=1; AJvYcCUohDBC6ND85b4Z/wbbMAG9fZ8susv2aK3RSUdQhSc9dyoJDk0WfkYnDXLNelf2mo/FBPWtB9S9jrWB7ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpNS8qSnS3MShrkmZWWjAw3DpuhW0uIyvgnO2EZDbc4WPAP//4
	xbT3TpGILkpl5RLvICChOk+YkBSrqBzpkRZrHOC70Nznw6D3Xu1SksGD7bBNu5M=
X-Google-Smtp-Source: AGHT+IE+HGfdUSlArgSClbSE11U6rFflXL9twTbhwG6MHRAZhapeIumH10fnNc6RWiXd8+UR6RJa5Q==
X-Received: by 2002:a2e:b88d:0:b0:2fb:3d86:d932 with SMTP id 38308e7fff4ca-2fcbdfaea70mr88655391fa.12.1730367286373;
        Thu, 31 Oct 2024 02:34:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:de28:ccc7:fdcf:6514? ([2a01:e0a:982:cbb0:de28:ccc7:fdcf:6514])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7b50sm1568120f8f.6.2024.10.31.02.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 02:34:45 -0700 (PDT)
Message-ID: <ca083f58-eb6c-4cb3-85f0-b51c7509fe96@linaro.org>
Date: Thu, 31 Oct 2024 10:34:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/panel: leadtek-ltk050h3146w: transition to mipi_dsi
 wrapped functions
To: Doug Anderson <dianders@chromium.org>,
 Tejas Vipin <tejasvipin76@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241026035928.183454-1-tejasvipin76@gmail.com>
 <CAD=FV=Vps5vWD72O_kYhuKudduYed41+tZrVRB6x+FiaZrm-EA@mail.gmail.com>
 <c389ea3e-70cb-46c5-8cf1-878a99f771ec@gmail.com>
 <CAD=FV=WmPmroitmYL3a4pdw8ai2LiQpJ6=zYh0kUdqcp6463Rw@mail.gmail.com>
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
In-Reply-To: <CAD=FV=WmPmroitmYL3a4pdw8ai2LiQpJ6=zYh0kUdqcp6463Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/10/2024 18:50, Doug Anderson wrote:
> Hi,
> 
> On Wed, Oct 30, 2024 at 12:24 AM Tejas Vipin <tejasvipin76@gmail.com> wrote:
>>
>> On 10/29/24 12:24 AM, Doug Anderson wrote:
>>> Hi,
>>>
>>> On Fri, Oct 25, 2024 at 9:00 PM Tejas Vipin <tejasvipin76@gmail.com> wrote:
>>>>
>>>> @@ -418,79 +398,42 @@ static const struct ltk050h3146w_desc ltk050h3146w_data = {
>>>>                  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_NO_EOT_PACKET,
>>>>   };
>>>>
>>>> -static int ltk050h3146w_a2_select_page(struct ltk050h3146w *ctx, int page)
>>>> +static void ltk050h3146w_a2_select_page(struct mipi_dsi_multi_context *dsi_ctx, int page)
>>>>   {
>>>> -       struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
>>>> -       u8 d[3] = { 0x98, 0x81, page };
>>>> +       u8 d[4] = { 0xff, 0x98, 0x81, page };
>>>>
>>>> -       return mipi_dsi_dcs_write(dsi, 0xff, d, ARRAY_SIZE(d));
>>>> +       mipi_dsi_dcs_write_buffer_multi(dsi_ctx, d, ARRAY_SIZE(d));
>>>
>>> FWIW: the above might be slightly better as:
>>>
>>> mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xff, 0x98, 0x81, page);
>>>
>>> That would make it more documenting that the 0xff is the "cmd", has
>>> fewer lines of code, and also gets the array marked as "static const"
>>> which might make the compiler slightly more efficient. ;-)
>>>
>>> Not really a huge deal, though.
>>>
>>
>> I did try this initially, but got an error because of page not being a
>> compile time constant. Not sure how I should handle this.
> 
> Ha, that makes sense! It can't be "static const" because that means
> that there's one storage location that's never changing and that's
> just not true. I tried to see if there was some way to make the
> mipi_dsi_dcs_write_seq_multi() smarter and have it detect if
> everything is constant but I couldn't find any way to do that. The
> __builtin_constant_p() trick doesn't seem to work with more than one
> number.
> 
> So I think what you have is fine then. If this becomes common I guess
> we can make an alternative version of mipi_dsi_dcs_write_seq_multi()
> that just uses "const" instead of "static const".
> 
> I'll plan to apply your patch next week unless someone beats me to it.

I'll apply it today so it can go in v6.13 :-)

Neil

> 
> -Doug


