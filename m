Return-Path: <linux-kernel+bounces-334117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F95597D2BD
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BC81C2134A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A9047A66;
	Fri, 20 Sep 2024 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jMO+YoMY"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF7E4C62B
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820906; cv=none; b=FZSkAM2neCOHsWGtTeKfDMc3HviHBXD+E6maH6MNE8wzvrhiy4/dfoewHnKhSZplFyIzPzf1qG0OFF1Xv05gjhoWTtCUJIJMtkJUGnNVfokuUN9ME3+SF5rp5hslKVupqxo2fHD/Bb8EuxBRJ8VhXRswdayZaWF/D1Pnp4FmnAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820906; c=relaxed/simple;
	bh=NScGYUd6179Tb5vwg/DqqbnXhiOkYig3H5YIrnsrsfc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UQ+32JIgvaYlG8CdMa87uBbHua+fIRoFs2g49YVryUbFxMATNQhiRXcSYUUwdUmH1Ii4cujpk7p/F6oOPwCi9kkVlrLnp2l/FuEumvDYDMq+Bg0i83o+z5wyB05JOvfL152DymdgH95kSOUJiO+mJoYfXXU1LRRsrXolS0cfmmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jMO+YoMY; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3780c8d689aso1138580f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 01:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726820903; x=1727425703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSY/XwkbAFk0AHpPR2dqnekk1R5T+r9ialJRBpwsOMY=;
        b=jMO+YoMYyMqhHa2sAPGJqMw3GRTPVCUXEYGoECjdyY13PAiQB2m3M0VDT3zU/k1BYh
         PPEaeO29pWb3oB+TQEBSs+dXk2N3CT0rpMejPMC3yPjqGTgmIfZV8M2WXhH4TCB5CuY+
         2FlhCf1CjDdhSclm/MOMrhu1sUgKA/CviSiN3obUfUhcUGXt5af+FPNNr90enOTFx2fY
         QF4N3zdNfa1tSQ6Xs/yqgoydmKBlvlroxgrb9bBunXJzApc+CkKCwuSK6YBpkLYbqBwT
         2kN9EIP+oZ8R8QqMqB/MRocrtL1DPr8hHxIXStvmZYA8idJAcpfFJYzY6hH7BFAgyG5+
         CLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726820903; x=1727425703;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QSY/XwkbAFk0AHpPR2dqnekk1R5T+r9ialJRBpwsOMY=;
        b=bSRN8PV8YkKcshqD8syESrezKNc3qlw5F9FeQxSeKLKQQTZ6cDkPbQiIR77zGFhkvY
         I9iAKqXF4Dh+oRl56LhHgFzQfh4TywheO124Rgtg2/ODwswIwu1zyjgeybOi3rF7DQS3
         Mzbro2y381E+jtgUwKdygn//LsGYK7kk9V5YFLIIosEbqd9izxn9pGNt5ci1+36YSNxJ
         w/eRjbeL3AcKxMev4tLkR4VV0cvYYa6RrBaI32dBq60cOmu3RFSGkmaVoiP+/jiYeeCm
         KZ/wdu/HMJdBZGrh8dSMKEYsTERJCf8pZchh63gCOnmPOrsyYetHfYiI+QPOidTOLbWj
         qAsg==
X-Forwarded-Encrypted: i=1; AJvYcCU3oEicd4xDR2pbAysHzvsbMxygMOruvU0WQ3obJVfaAHhk+xk+PmLLep3BiHOvOzZjiSYw8Ot3mfBH1Kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYaMdi9RjLI9fGGbI3r9MtQjbaEKvPcv0rJnio3mEWyVqSWEVw
	g3IJ34DM3GFNDpYYn6wUVpI2l9iway6BPN1nL0X5QqD5Vmi9tdcr9JoSgPKB+59xW53mb67IDPh
	Z
X-Google-Smtp-Source: AGHT+IEwpW97abutw3SvbbD+fpsLM/YqBbH/+ujjWdJHEh1aCbcZ94oU53Wv3GaurPQr/FG0QEN0Gw==
X-Received: by 2002:adf:e84b:0:b0:374:cd36:8533 with SMTP id ffacd0b85a97d-37a43197db1mr1010222f8f.54.1726820903286;
        Fri, 20 Sep 2024 01:28:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b3d5:235d:4ae1:4c0f? ([2a01:e0a:982:cbb0:b3d5:235d:4ae1:4c0f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7809e0fsm17044622f8f.110.2024.09.20.01.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 01:28:22 -0700 (PDT)
Message-ID: <e8906af4-e769-48ea-8ec4-779ca4be9b8a@linaro.org>
Date: Fri, 20 Sep 2024 10:28:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] dt-bindings: mmc: convert amlogic,meson-mx-sdio.txt to
 dtschema
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v1-1-b7bfae886211@linaro.org>
 <20240916174030.GA835203-robh@kernel.org>
 <9394d785-5954-4d44-8ad0-9b57fbecde25@linaro.org>
 <CAFBinCAbb5rh4GZZhjFA1jSGJAPNC80vnUY+PC9AdaApLZphmA@mail.gmail.com>
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
In-Reply-To: <CAFBinCAbb5rh4GZZhjFA1jSGJAPNC80vnUY+PC9AdaApLZphmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/09/2024 18:33, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Tue, Sep 17, 2024 at 9:13 AM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
> [...]
>>>> +      reg:
>>>> +        description:
>>>> +          the slot (or "port") ID
>>>> +        maxItems: 1
>>>
>>> Aren't there limits in the number of slots the h/w can support?
>>
>> Good question, let me check
> allowed values are: 0, 1, 2
> 
> For the remaining questions: I also don't know - so let's see what
> Rob's suggestion is going to be.

I did something, I'll post it shortly, no idea if it works

Neil

> 
> 
> Best regards,
> Martin


