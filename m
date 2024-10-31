Return-Path: <linux-kernel+bounces-390491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E899B7A92
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE851F222C7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E5719CC3E;
	Thu, 31 Oct 2024 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jGxZ8mXn"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B56F1990AB
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377912; cv=none; b=qWIVhSAlt/nf+z7RvJ29CdkcFnXXAtV17jpiRX+mK+DHnzqRaqWVvcLtuZRF1ALvbF0hL5LjHF9bX0uCd4EJEhJyTIL7SMHgEtKS8wx5FdloBNfkM7RCBBFQYRy79VfRk44exICWraASNbIEKb4ZU34o3OnylL703xbOJuL3DF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377912; c=relaxed/simple;
	bh=2WBeAOc65UgvsrNyTTVdRO4WKKV/eMXAr8WX6bShZJk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R2MVfJXGoqhK1SF9QWxvToVjs/qxWiFDLeGJd5fy4iOJerzxhB5EbSPrehZEeRncqcEmZsf9v1vdkn7Ncvg3DMsL2sm2KVRtuwe3c9CJvOWP70PLhXgSgO4OkMQNSowl9w29zn0DuEkeOwyPkTc8hFHKDAvJP9obMMaAM7OXgvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jGxZ8mXn; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d47b38336so698122f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730377909; x=1730982709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TtULGftwvkV6PBeqGDEzspAud7gcNgJ/xN3Giran/QY=;
        b=jGxZ8mXnO4mBtaBLNgh3XqJYku0c7VL7nhhxcekJS69xKKjMnZ8addG36JrDvjJ+7U
         pA9CdfGWp4GKIPuys3//xElkq1tZ9Oa++HbYbd9/evHxNCVdf/uYXZw3yDSfooX9klDv
         UT2AJEEcl8XFQSwK2ctQxPsIQKwBFB0jlrxHn/dubevxTwGIr25PCOUkKd/r22bNBj/n
         BWk5XSm3SRUW2ycEJV9DGohup76DNVOAOaSQtbRDQoPyX/52IR1nQW1vzgOetmlBUtkG
         K7RFveeiFnQY4o/skXgQJRr29+N9cWj1Q25TKO5na+sBUHdP8WdB7SOQ/FJRnWNbz8cb
         Vcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730377909; x=1730982709;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TtULGftwvkV6PBeqGDEzspAud7gcNgJ/xN3Giran/QY=;
        b=Rz21pIai6J/3Uk4vSXwHRcyfeOIRKfpnb9zVa06S2fHwbtjfWGwQETL+oX+N7DyJg2
         sFy2BvGjQTth+9ftXuSMYbVYSHDcun5FNO1UGgp++BvqG9doxo71sarsXmFPGHLizaAu
         koxlwYIsVXkDRPjDzuNPFZ0fadLoF9yRTu7mS6ufFGb5N5LBqytLSbUNSx/ZzM2bvF5v
         GQC327acDj2tov4yDPyJg4F0SKd99bQSH4oXrTiUrpTmHMN6Bgvo1fam1aH+iYGopfiU
         9uO3qo2XF0psmpuV1QDn5IvQMouuB+jC5lX0oD8DOPCgGKnnyTX/FdysPFQA1UUJrAYC
         QlGw==
X-Forwarded-Encrypted: i=1; AJvYcCUD6zdJ0zPi1We16d7d01M81X5nDmSQ9KusZVBQ8+KvB9338doI+0/KbPKihtuqFUO4tYVI+CJrZowdhRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdt+x4HLxrhVPLxodQS9w7sYDiZdfcctrSp6EGGYIWJxrzI1uL
	qlWXLsatOXDMfPfM8uz77CjsQ2KbEy/vhblMofUD/O2BP2OE61VvxpckE0prw7c=
X-Google-Smtp-Source: AGHT+IGkHR0OvxDEr7PMMN5pZS2wB+wRi7rYAoUIxvk8EKhcVrYCEcy8oIPQET5ElU3EYFZKT+iwFQ==
X-Received: by 2002:adf:f1cd:0:b0:374:c8a0:5d05 with SMTP id ffacd0b85a97d-3806121ff99mr13664108f8f.50.1730377908520;
        Thu, 31 Oct 2024 05:31:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:de28:ccc7:fdcf:6514? ([2a01:e0a:982:cbb0:de28:ccc7:fdcf:6514])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5230d5sm24947215e9.0.2024.10.31.05.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 05:31:48 -0700 (PDT)
Message-ID: <c2a4cc3a-2ffc-46f3-8636-238cd561f7aa@linaro.org>
Date: Thu, 31 Oct 2024 13:31:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
To: Sui Jingfeng <sui.jingfeng@linux.dev>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abel Vesa <abel.vesa@linaro.org>
Cc: Johan Hovold <johan@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
 <172951608323.1285208.3162107667310691864.b4-ty@linaro.org>
 <230b5910-6790-44cb-90ed-222bee89054d@linux.dev>
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
In-Reply-To: <230b5910-6790-44cb-90ed-222bee89054d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/10/2024 15:49, Sui Jingfeng wrote:
> Hi,
> 
> On 2024/10/21 21:08, Neil Armstrong wrote:
>> Hi,
>>
>> On Fri, 18 Oct 2024 15:49:34 +0300, Abel Vesa wrote:
>>> The assignment of the of_node to the aux bridge needs to mark the
>>> of_node as reused as well, otherwise resource providers like pinctrl will
>>> report a gpio as already requested by a different device when both pinconf
>>> and gpios property are present.
>>> Fix that by using the device_set_of_node_from_dev() helper instead.
>>>
>>>
>>> [...]
>> Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)
> 
> 
> It's quite impolite to force push patches that still under reviewing,
> this prevent us to know what exactly its solves.

It's quite explicit.

> 
> This also prevent us from finding a better solution.

Better solution of ? This needed to be fixed and backported to stable,
if there's desire to redesign the driver, then it should be discussed in a separate thread.

> 
>> [1/1] drm/bridge: Fix assignment of the of_node of the parent to aux bridge
>>        https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/85e444a68126a631221ae32c63fce882bb18a262
>>


