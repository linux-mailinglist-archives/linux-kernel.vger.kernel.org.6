Return-Path: <linux-kernel+bounces-421311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E2D9D8976
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED887281944
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02071AF0B5;
	Mon, 25 Nov 2024 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a2FbMizl"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776AC14E2E8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732549060; cv=none; b=Eg399mv2+rm/XlpE3CrrIu91x1iwVQ6cYzl5BFbq70tob4CJuCfMGnef7XrdcqBRQz1GWYpvHYsPbgu3VnbyXAsH4X/LoStcOYvc2hToSLPAmwXUqm8y49Rp1tI+scUxiHLv9VCPoENxlV+K/gG46Bcee5qnF+2hOomeYM4OHrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732549060; c=relaxed/simple;
	bh=G9neb+XkH6gOH+GosPEzMre6WvIqpGwyQ7NQSc5QvYU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VPJ5KzZwA4q9H8Le71twDS2r4HTtldmMasixLuCdHVLdZfCoAoN/SF/qdLGGnhxpExmCyW9KFc1yrbdulz+WjGG7567sXcQ6uwo9LtMfIpaOwiPEvYoPW2Vl1fT3vktnjpbLNxTVdq/UYkNj8WO4OVdhc9mIPOn9ULLBG3wa67Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a2FbMizl; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53de79c2be4so435047e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732549056; x=1733153856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Hg71u/nSxxdt/8mQpbUuh2Vaj/SF/MUnmwqWlHQVd0=;
        b=a2FbMizl7hnrZXwjSh5ucemSsBRwr3cnEwyVFP7AwW+rtvQMjDWqqXhr34JFazRTeZ
         r9Gvk7HTpv0uwfh+FopCOl0Wdij0zAzGGmz1SDvuf3BOCeoPGjJXWiXjvPQ8fLNuf9Vp
         VBAuU2sAG0T+u/W6fs/O3aMJnwhOkWduC0le3eXMhNpR7wSqOmCOaNSLFWiIajRX1jFI
         RMJDMZyEyK1pfGH8QmtfBQPFqFetVNqK2Dy7fg5vUGlsS3MmsRyTsuD3AaF6vRmlHFB6
         05sHKISl3OAwJb8iBIAS3qxi4W1zfmrdHIoKG42oLybc7hP42+qe/JM5ZzXmwt9kjdBz
         aoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732549056; x=1733153856;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Hg71u/nSxxdt/8mQpbUuh2Vaj/SF/MUnmwqWlHQVd0=;
        b=e+EDs0cof7S/kNkjyIE84UYJN4w6p9sAi9Cl2hdesKu95Z7wiLuAQcnkfEgsMK3yvq
         FqnyOW+ND28gr3M/cwqgbkPT+/9itRvyoon09HURyYeBpr9zzN6YMIYAKmBOZf433KVD
         rCjkCczRn4Oa8wpxYOGdQXNlqk4TADSBUb4OXT05NY+4KTCSBgPFi+B3azne7PJoGy/6
         8rdc3chuSXDZu+Eg47hq64cQCNPaOqLv+IAe3UnYmGAgF4yYoU+AE1wv8tMw+uDyRimg
         h6l9HjFcHl6PNbp9sud9d+XUAGdT0FzFIuwn9tsV7hSmh5VdSM9yC3n/gH5Ua1pRD9qC
         mfYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVukEsEU9QKtnhZYe5eApUrgU1VFvqHqxnGIyDhkm8VzyCMAx9SNEEhEL12g1UkYRLe2ndSMHVna9E115g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjrslAlGkpdWx83Ob5eqghRqXqgNJQP5ak1TcON6+/APR1Z+QH
	vm9tE8bfJ/awdODJ+WIknV87C1I2pWnZ29+GlBBYfxGspOoh144VA6wZmoZBrVA=
X-Gm-Gg: ASbGncsm5mAi5lHxlCnsZoicXSEjm9kFcW59iyltsWPpY327aRmXEnLYhA3tJmfFSdR
	fb72LfN0Vl/4LMMctS1oo6PxjLwxCpcscf74hKALrwVl6bopGodvKRVM5T4D/N43QlwiUQ/0uFb
	Vjc+w2REv3rSy/z19MdI94qchemCX8Gcmg62sNzbRKfdZWXyePVSXVs39x+eMoK/6AJsDZPwjS9
	sTV3pCtSFjiYDVq1gjdBvFjBX3pWB1NTYJ2FSKD/SoZCSQ9SMFyIfbtNSIVs02S6huoj0AL2qBf
	/QjRT4GQJC6BKRmVKw+kxxOg8lY=
X-Google-Smtp-Source: AGHT+IHmC/h4cTUnON85E6sO/QnQqtWoSOkY3lw5hIYTrZwaGeM/PrXuqTSpTpCW43QaBSIa3xvw0g==
X-Received: by 2002:a05:6512:1247:b0:53d:a9a4:7567 with SMTP id 2adb3069b0e04-53dd39b4f71mr6398723e87.48.1732549056577;
        Mon, 25 Nov 2024 07:37:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9dc0:6c46:415c:5f8b? ([2a01:e0a:982:cbb0:9dc0:6c46:415c:5f8b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349ca82957sm66277205e9.33.2024.11.25.07.37.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 07:37:36 -0800 (PST)
Message-ID: <48f3bb08-a591-401c-bc0c-6af0506a1b1f@linaro.org>
Date: Mon, 25 Nov 2024 16:37:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/5] gpu: drm: adp: Add Apple Display Pipe driver
To: Hector Martin <marcan@marcan.st>,
 Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig
 <alyssa@rosenzweig.io>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com>
 <20241124-adpdrm-v1-2-3191d8e6e49a@gmail.com>
 <10d0aa88-de2e-4856-a137-301519e58b2d@linaro.org>
 <CAMT+MTRWZWj=3AP7wyooXr49-W4vcm0ZbAoqPyEuNkQBMOaJfw@mail.gmail.com>
 <cc71021e-b53d-4eda-bad8-abb4df13575f@marcan.st>
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
In-Reply-To: <cc71021e-b53d-4eda-bad8-abb4df13575f@marcan.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hector,

On 25/11/2024 15:24, Hector Martin wrote:
> 
> 
> On 2024/11/25 20:24, Sasha Finkelstein wrote:
>> On Mon, 25 Nov 2024 at 09:50, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>
>>> So this controller only supports a single mode ???????
>>>
>> Most likely. On all devices it is connected to a single built-in display.
> 
> More specifically, the controller obviously supports multiple modes but
> it is pre-initialized by the bootloader for the single hardwired
> display's only mode. So as far as the driver is concerned, there is a
> single possible mode, and there's no point in trying to be more generic
> if there is no hardware that would use that.

I totally got the point, I just asked to slightly change the design to fit
the overall DRM/DSI/Panel architecture.

> 
> In general, it is not possible/practical to be generic for reverse
> engineered hardware with no specs documenting how to drive it
> generically. You just can't know how to implement the options that are
> never used in practice. I spent a lot of time on exceptions to this rule
> for the GPIO and SPI controllers, and that's not going to happen for
> more complex hardware like MIPI DSI.

I'm fine with the overall actual design since it's a special usecase
for a special display present on only a few SKUs.

Nevertheless, as Maxime expressed, you should still try to fit nicely
on the abstractions, or change the abstractions.

Neil

> 
> - Hector
> 


