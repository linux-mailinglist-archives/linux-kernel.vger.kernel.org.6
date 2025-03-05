Return-Path: <linux-kernel+bounces-546979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ED0A5016C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CD8171D2B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5933624EAB6;
	Wed,  5 Mar 2025 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qjzluVUz"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E2824CEEF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183586; cv=none; b=Wa/XdN0uTBHCAHjlZDIM9gPYgIZHnf3wNVk0FxfQNca6KDW0FrSFk1Y0XwdUPe46M0sMGyo5z51xGMv8mnSEEosoeLEPpud5NJwWeaDc4mGKrnASyBeYELB2xat26MToZQOGs9JsEtJg23YTqxxrQCCeyXvhee8dQwNTfQ7RFPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183586; c=relaxed/simple;
	bh=DzcsKPwhLdad+i452eKpUALOxdjKLGxoLOmTo5nt9Is=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LDEpLAQxDgYnhbtI7U1V+NQhlWzCF4+K1tj/+c1Ix81eBhi7m8FLyh8M19LR4mTlqnF0kQMV5AU579Li7Us5FK83fkXUBboAqOKLqiqidB71NBNvI9Bzbr18QIrry16ZxlrQa+dIdTHktnVUpqpBBBwOPoudmAv3e3e90s/M5J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qjzluVUz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43bccfa7b89so14697755e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 06:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741183583; x=1741788383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11RIqpJbRMk0CP7kEnER3o/kKEhmLuNrxSq821K075U=;
        b=qjzluVUz4I/vCqvMyPmgtk1DOtrXeXTsV5wWHbX56kBqQ3a6k42aIe3rF7LQ2mV6MV
         IS0CAUVTBiBu5kiAN1LvUq/WSgitI5V5pnTP9jCozSdrUsIBlyApmQl8v0gtyYL++fmp
         NfKW6L0cIquuzoJFDFhTeZPh8ewEjKuc2zC0WcuUw6d9sSO/5/9rWSS9DlUda4tfcFt9
         EBNY+xUgBDItftR5/858MlA7VJ0ySdqEDQYx1yQn3FqVKGaPFVG3S+b3rsf0UyoUxvAp
         4KOYxBwxLWoirNObZGBO7Q3Ju5+IbTTNLg67nRqVCxeYde8CyutOXy4QMT3vBKPVa3Mf
         y7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741183583; x=1741788383;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=11RIqpJbRMk0CP7kEnER3o/kKEhmLuNrxSq821K075U=;
        b=mqhjobFOejWwOOwQam93qi6kKYAYo1I5CaYBY0J8GishirKtrxx/tnODZ0R3GTnP+c
         j2rvy2AIJG3B3edS3TZ5gcdgYRppKhXLKlw2Qap6Y2ZbR/Up4KI+QdjE3T0oYQAKh+fk
         PfFxf2luqlHdQs01z23qJCWUS9NNphDInT96hrBTqbTEtR0pH8CTF7QTrKgwcP80FKQ4
         y70pUQBGK+V8/YVu+jeXwk7OCs8qQ98j0LXh8HfmLayAxom/nTBoHHS4T8nLTI0OSXL6
         VfIXPMmGJbp02v1cyK14eRBuXHZBiL1jiUTzE+3jtZePY44NBaxAUuktpJqh0MpqCgAi
         P+Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWzsRcjU72C2azjeHPtHntzp4iDvhIoTAv28dHeRRNfXHd8i+U7wMPHjctDKti95kRcInJTHjmM/VGJ7Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE8rp0OnYfYVZetf1IMmeSYO5M+Idnojp1SG2efEMoZc6YDGhM
	doF+tTaExvKP2focyMeL4Eg+eRT7pyVAhX0aMV3G2CpzzkZP11Bglt/yTs9MviA=
X-Gm-Gg: ASbGncv67JmYdjgvLkQ0dbHzVsD1xL4IvTSEDR3k/y0aqSkn8RuALjpDQNNKv4fvbYg
	4nSgeEJDbWQC0l/1RuoTCposoH2zQZMuFL/tfPGTOFEaFgIRAmn9l3X4PHIWOF3aCH0uW3bbdpG
	FGjWWF7yRgUtK/BmNdk9mFJinf29IvWKWOnL0rQTp/7GVw1xhPdrgaeCPsFUr2THOsb3cZXGzFm
	ER0v3DBfnZCE5k0AlIlVdMOtZ/Z0LVxPpsyi30LFe8C/Zb2tVmkyfXLCExah4xFW+CSDMO9E2oy
	mhhru/SHcZpm30dTKceP3Bq0tefFwOZmVe1YgHEpEFZWHolcE4lG42cPciv65FNegHE6Rg1ExQw
	Wmmdfrng4+OMvQYsCekcGrA==
X-Google-Smtp-Source: AGHT+IGw9gdZ+AWcZBF3A5Ecs3XaYdWNI4WSu4gKkjkQYxmSQUUfbmDB8IcIt65GvIVbdvbiREsQiQ==
X-Received: by 2002:a5d:64a6:0:b0:391:c3a:b8ae with SMTP id ffacd0b85a97d-3911f74dac3mr3468091f8f.23.1741183582872;
        Wed, 05 Mar 2025 06:06:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:d001:4ab2:d11a:658b? ([2a01:e0a:982:cbb0:d001:4ab2:d11a:658b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39121d7d866sm2079199f8f.39.2025.03.05.06.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 06:06:22 -0800 (PST)
Message-ID: <18f9658f-f2ca-4fd9-809c-ec4d198072be@linaro.org>
Date: Wed, 5 Mar 2025 15:06:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v8 0/5] Driver for pre-DCP apple display controller.
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Hector Martin
 <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev,
 Janne Grunau <j@jannau.net>, Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alyssa Ross <hi@alyssa.is>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Neal Gompa <neal@gompa.dev>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Nick Chan <towinchenmi@gmail.com>
References: <20250224-adpdrm-v8-0-cccf96710f0f@gmail.com>
 <174118223158.156873.6982508045942987984.b4-ty@rosenzweig.io>
 <Z8hZKW_F-HtzYm-w@blossom>
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
In-Reply-To: <Z8hZKW_F-HtzYm-w@blossom>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/03/2025 15:01, Alyssa Rosenzweig wrote:
> Er... I only applied 1, 2, and 5. Patch 3 was already merged, and patch
> 4 is going in via arm soc. I am, new to b4, sorry!

Yeah it's because you applied the whole patchset, and discarded/skipped
patch 3 & 4 afterwards, so b4 gets confused.

Next time specify which patch you want to apply with -P 1,2,5
and b4 with know which patch you applied and generate a good ty patch.

Neil

> 
> Le Wed, Mar 05, 2025 at 08:43:51AM -0500, Alyssa Rosenzweig a écrit :
>>
>> On Mon, 24 Feb 2025 12:02:15 +0100, Sasha Finkelstein wrote:
>>> This patch series adds support for a secondary display controller
>>> present on Apple M1/M2 chips and used to drive the display of the
>>> "touchbar" touch panel present on those.
>>>
>>>
>>
>> Applied, thanks!
>>
>> [1/5] dt-bindings: display: Add Apple pre-DCP display controller
>>        commit: 7a108b930a84e71be71c3370eef6dd96fbb8f618
>> [2/5] drm: adp: Add Apple Display Pipe driver
>>        commit: 332122eba628d537a1b7b96b976079753fd03039
>> [3/5] drm: panel: Add a panel driver for the Summit display
>>        (no commit info)
>> [4/5] arm64: dts: apple: Add touchbar screen nodes
>>        (no commit info)
>> [5/5] MAINTAINERS: Add entries for touchbar display driver
>>        commit: 4d2a877cc0efefa815648f1ed5f5b2b796f55bab
>>
>> Best regards,
>> -- 
>> Alyssa Rosenzweig <alyssa@rosenzweig.io>
>>
>>


