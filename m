Return-Path: <linux-kernel+bounces-306718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6C496427F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9241F27CDF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BD419049B;
	Thu, 29 Aug 2024 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zKOZwvn3"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303C118A6D1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724929296; cv=none; b=UvL8owHWTE+HNYr8usnyeBNervswRxYjvB17T7NAZT2fCUKuJTwO0z4pTtoAw28R0hUhwYmcy8lEO1PoIKgfRw+pXAyyhWhCjq8W/lIrLaxuEXPDdkAEykSbC2/EPyVauiMcPyuh/Vvsgj8NhRwdtHU2sA9uGTHEb2mebYOCkKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724929296; c=relaxed/simple;
	bh=rEt764ey+j26paKgat0kweJNpYMJCZhhUHP1+vvgiQI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=K7Gdc/el5R8pqU1Zupk3MAND5jzNsgmxSQ679LfDzkZ/7bB3j5XRr344jiW4GsQj4MyT7/1qSgEVFd9IRbNTkfQeaBOnl/kNocHruJA3e/uKyLWmci+0PlbbP6In+DnpG/qBxTAbrXeOB+wPlV5Wi3Yf4uXdmFZOjXRnxCE6uDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zKOZwvn3; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso5141795e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724929293; x=1725534093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bXo6HubkCKATDdKmpK9Rg0frF1Oj5dEqDFqJTWbwDPA=;
        b=zKOZwvn3zKOx04CJNUX90TAhu53KOwECWNKVpICJK14wuXotfBV1bewPCIFMKkREj4
         aeXP/2FH3xIWkjeSSGwDdfxUDSoJvyj+icp8Fta/QlrwGKgyzs2wFAdWSaG+CczyWyKA
         iWwBkXuddh/KVgpRt9VKP5w30inwP4Q42fdunlOlPu8nNYSYTDUbdLm4Amt747ieOfu8
         H/FyfcGACc+cwkCgw7wrS4mNwoxekgaD74MT1ybyta1J4Z+EK3lSNhXoCJUzIWNwb3eS
         05sfs9biODtTk/3LEYz+NO0eDBvAnCxk/A1VDblh8RjZF/DkSHInfytmaiZvlVvZFCUt
         us5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724929293; x=1725534093;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bXo6HubkCKATDdKmpK9Rg0frF1Oj5dEqDFqJTWbwDPA=;
        b=FyFViyPOql8vN8nO4GdyYPilwC5TvrXfnfkfoJJrfso9TEN6to4d+OqVp2OcNliaZ3
         EKKH8sTkFy94mdW1x0ivDLZYxRRIYHBn56RlHq6D4yWgZIg9JBpSwnAHdQby/WVgTEss
         Wu7qpCivX5WE5qH0Ua9hJ/Ou5j0sjMkH5qACaHBsl2HS792RLGKgoMYqGCaPwwOHueMU
         bgOtuG0EsDwHl+5kZaO/SawrmoqBXfNKrk6Ex9qRkEP2b37kvP3kGiEw5NTJIVVjiB3e
         i+rWPsHbLrycmWdN8Y7Dg9tCZwmBX/YQO7sHwOHvhSI4QWX4ySgkgjd1LEOeNJg+kivJ
         DR+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX+QgEGj/GgVS75IIgOuVaJOXrciXsf2BWfLrJMBk5BNVRXgNijefy/pqShDAjObKK4ekZiK8qYZcD9QtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIUk+8YQgAnJhoXpACB+zFlMNVtydz2w8RsTvmEPSCt1Ru6/Zn
	zCzQHFbP+PBEnP8NotZqu7HsbtwaHllDgxHoObXlEQ3XlSX4cnjp8kzrorhzYaQ=
X-Google-Smtp-Source: AGHT+IEGRHFHlM0ZIqrANJERtt9IfqKCUYiVh/PmrfILo/hL0bRzQIewiOrQKcnbyufRBxVZ5itMFg==
X-Received: by 2002:a05:600c:4f42:b0:426:6b14:1839 with SMTP id 5b1f17b1804b1-42bb0136dadmr25924465e9.0.1724929292917;
        Thu, 29 Aug 2024 04:01:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:12f5:c9c:a0e1:6915? ([2a01:e0a:982:cbb0:12f5:c9c:a0e1:6915])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42b9d9561b1sm57733065e9.0.2024.08.29.04.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 04:01:32 -0700 (PDT)
Message-ID: <2da89096-a68e-4b9e-ae45-87ccc76c9c72@linaro.org>
Date: Thu, 29 Aug 2024 13:01:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] drm/panel: novatek-nt35950: transition to mipi_dsi
 wrapped functions
To: Doug Anderson <dianders@chromium.org>,
 Tejas Vipin <tejasvipin76@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240828182210.565861-1-tejasvipin76@gmail.com>
 <CAD=FV=V71VzJk81YALO4ufohL0a4EQuqZVXavbpM=bqHgsf0sw@mail.gmail.com>
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
In-Reply-To: <CAD=FV=V71VzJk81YALO4ufohL0a4EQuqZVXavbpM=bqHgsf0sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/08/2024 21:26, Doug Anderson wrote:
> Hi,
> 
> On Wed, Aug 28, 2024 at 11:26 AM Tejas Vipin <tejasvipin76@gmail.com> wrote:
>>
>> Changes the novatek-nt35950 panel to use multi style functions for
>> improved error handling.
>>
>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
>> ---
>> Changes in v2:
>>      - Style changes
>>      - Fixed changes in logic
>>
>> v1: https://lore.kernel.org/all/20240824084422.202946-1-tejasvipin76@gmail.com/
>> ---
>>   drivers/gpu/drm/panel/panel-novatek-nt35950.c | 211 ++++++------------
>>   1 file changed, 66 insertions(+), 145 deletions(-)
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> Neil: Let me know if you want to land this or you want me to land it. Thanks!
> 
> -Doug

I was already applying stuff so I applied it !

Thanks
Neil

