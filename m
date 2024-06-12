Return-Path: <linux-kernel+bounces-211674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCC590553A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8486D283026
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD3817E8EB;
	Wed, 12 Jun 2024 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/kO99ge"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C13816F0D9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718202858; cv=none; b=K7F9hIq0Hm1AZA1+KNvwNEkLmUGGYHNdlmW0+64LCSRHXGVxQGALWSpYqM+e1fXsufAqNOJRgnnk6IV8uoI7pBTzjzLxkGKzwiQvEZqEbnKfGFTHmhcoNaebsNZlTUrXEOaR/uYObWOVmgEtj2Uh5Dih5/0l8+iZuvAGI1XBl0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718202858; c=relaxed/simple;
	bh=gpKlN1i1SrwSn7IBrKzNTAc3APohqQGFIY+53xrgqQY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=u5/uPFNSdFuB8OwaobSQCQfUsWJ8Sgfa5jQF6LT33J52Ftbcft1TIOMAVOW7BiwQmgxebaWRLKy2y64MEyCexy76mNfJqtGDap2MuP5lCncD+j8iBbGpkxN5PYltz+8C6NNzgjpQxdHBMi4IFIS0dtt14VP2xbJ9DUTTdr4vrn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e/kO99ge; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-421820fc26dso30556955e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 07:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718202855; x=1718807655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4s1bpWClaYUNPvE+cddqi/XjNxZGqa2xsD3E7w12QbE=;
        b=e/kO99geie2ZVoWwkpBbXqvZpC01atS6y9Voh8ni5iHhM3/QnWmt+SLsFrcQ9OFG+r
         7ypNQVYhIXrW8hKE5GVaZwfr9Ua+MKHSf7VnzRpiX0zTvtQ9EONGO+PmgMq3d/MALxJg
         skTHTadIiMv3wIDVYQlovkrXGUrp0OtcjLjCluh69DwCFr5xYJZz5wNHz2BB7iTuGb50
         afkjvYMrrFVuxHwjWdDCpXOxetzmzXIdgOqEsTLxVEygjUS5R3m7GYrZcK96kjS+SjmW
         DcgqE9zMRhYT1V8PhMF6CS7wTZzsBiolBZKv4LQzRM9/cRhgiKqJWf33hSeVZe2hmqQM
         jMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718202855; x=1718807655;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4s1bpWClaYUNPvE+cddqi/XjNxZGqa2xsD3E7w12QbE=;
        b=rufXAJTDA6hpnZp0uXUJsWI34Q2F7rF5Xu8ZxlxzhfxcfwhuLEK8BQVTFtS7C2r8Zk
         +8zKg0mASe35v37R60HOpTigSioKgs3S/cinfbQxTgyfnm/IechlY6abJxsDaDWqWPXp
         y9b6GNhGByUpCVDX9jkEqdtzkBa+Idk6s836Xxdc3FrURthaRB6PLsoU0Yu6EE+oYHuI
         9E7TgsKNc86Ci+HmfELbODt1yNV75QelzoSGcREqJ5fydV8+kxSw6wpT5ZMi1eREFT6x
         ksZWlGtPcJUQoZlgTM3khS+BvkTXql9NzVn22OLHeeYvpEt/6IruuA3H4mLYGILuSt0r
         7t4A==
X-Forwarded-Encrypted: i=1; AJvYcCVjWdWlAToHu8Ss5G2ddXQNqY/ZwkETrWIxvJ92WWOc72EJLi20MrTlA7Z20/IIRTl7n7DfmJxxgARNG2pzqTxEnEaqJ/Yww98nnqK4
X-Gm-Message-State: AOJu0YxPE0Ia7NbzDqlrYy3SpU+QDSagHinc4mdPzROfb6xMKM81KGTJ
	/LT35FGbJmeuEZJ6Rn0ZjjBOPYpW6kHJ4SaGF5nBXChNa2dzByQWNKIU9GIkZoM=
X-Google-Smtp-Source: AGHT+IFwo4N6yBahUY7XXRh7MW6bPb7wu7oxP4vd7L5nupR0jkqMln8p5KPpvRHgNZsUcBXUlycOUw==
X-Received: by 2002:a05:600c:154e:b0:41d:d406:9416 with SMTP id 5b1f17b1804b1-422866c53f7mr17617685e9.34.1718202855212;
        Wed, 12 Jun 2024 07:34:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:30bd:bf21:eed1:8aeb? ([2a01:e0a:982:cbb0:30bd:bf21:eed1:8aeb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422871f8f34sm28078425e9.42.2024.06.12.07.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 07:34:14 -0700 (PDT)
Message-ID: <9beb8011-cb0f-4694-87e7-d4c02de80cd8@linaro.org>
Date: Wed, 12 Jun 2024 16:34:13 +0200
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
To: Doug Anderson <dianders@chromium.org>,
 Tejas Vipin <tejasvipin76@gmail.com>
Cc: quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 linus.walleij@linaro.org, dmitry.baryshkov@linaro.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240612133550.473279-1-tejasvipin76@gmail.com>
 <20240612133550.473279-3-tejasvipin76@gmail.com>
 <CAD=FV=VTEzSyTHm-YBwneBgpohK8uu460DER-GcsQWu-z9hJsg@mail.gmail.com>
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
In-Reply-To: <CAD=FV=VTEzSyTHm-YBwneBgpohK8uu460DER-GcsQWu-z9hJsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/06/2024 16:21, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jun 12, 2024 at 6:37 AM Tejas Vipin <tejasvipin76@gmail.com> wrote:
>>
>> ctx would be better off treated as a pointer to account for most of its
>> usage so far, and brackets should be added to account for operator
>> precedence for correct evaluation.
>>
>> Fixes: f79d6d28d8fe7 ("drm/mipi-dsi: wrap more functions for streamline handling")
>> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
>> ---
>>   include/drm/drm_mipi_dsi.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Yeah. Looking closer at the history, it looks like it was always
> intended to be a pointer since the first users all used it as a
> pointer.
> 
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> I've also compile-tested all the panels currently using mipi_dsi_msleep().
> 
> Neil: Given that this is a correctness thing, I'd rather see this land
> sooner rather than later. If you agree, maybe you can land these two
> patches whenever you're comfortable with them?

Applying them, but inverting them, fix should go first.

Neil

> 
> 
> -Doug


