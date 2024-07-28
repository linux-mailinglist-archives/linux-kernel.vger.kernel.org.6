Return-Path: <linux-kernel+bounces-264502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0917C93E438
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 11:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34A0281A94
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 09:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9311818EAD;
	Sun, 28 Jul 2024 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SDsJJ5t5"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ECD15E97
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722157707; cv=none; b=D2F2Qg3glCAkbr/I7cut+JClKy4yVnx/55jwNU/DY0Nq0IRvFyv588GKHYcHzig9VWAD9AcuSlqaBMvA9F6N9wxuu96fNTuxS3yxpZFgc0LAjuqR9ZgNux7jGturyeD6t9KqyFUJugzDuxDxHhx/qcoyKemsFGBaMHHNi95hn3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722157707; c=relaxed/simple;
	bh=DGMu3LcGZCETzwzuTSzObefjtm3VJ0HhgxxmDWV2U9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iv0J2pRYTleY9n+YuVsQhKP4UAIxGW0yVkF99LeVmpmo8wv+Ry3CIPOlbbK2pUqyxU+7IWR/Jx7xBy7dI4IY2ip9qaI69pbMOHR2PjlKeVYGD2o/A71pl+pAiP5sEU6vtitGVSk/zNQjGg3UHajSdV9SBGHNKfJ5aJeCeWhLZCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SDsJJ5t5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so10591455e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 02:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722157704; x=1722762504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B0AlYY3fc/ZZl1znfYJ42AN0KaZkXyNYq98lIN0P/S0=;
        b=SDsJJ5t5IkLhuEJHXGDmHEA64Wah+1b6feU8byxPQeDhsCh14t+qG+b6gYMC+agYyw
         ytNTLEq/pTG8pPbxhAgE6rfGq1HF1l1PhmBIMtX+YYsQlVwMPgAOZf3dxIVmfnXK/LrV
         ji6G9XG0tVPkLwN24db7QYSNF9Vmd4/KuKQBb0UxhQCHQPkf5FjX4f71utWJZt0cAQDK
         UwlGjFedeKiIAPLabeLFfhgDuyb3E3x5f9wor2Wq3wyNkhvDjUnGuNZflQms22uKglCG
         1QjUEl4hEBaZkY6dDIelM0V6yTuAm9ptqv68DYY2BuyRtyZnDWyOePctDqYM29p5vKSu
         3VXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722157704; x=1722762504;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0AlYY3fc/ZZl1znfYJ42AN0KaZkXyNYq98lIN0P/S0=;
        b=xFQNUKQHX/38Wplg2tI/gDxIKqGVx4C0Qswki6Dis2q4nGeNNpbVj9A2lKN592WSVd
         Fe5nOwpndic0s7TrbFlLYC5C12Kl0qt/KJVIeJboTKoi2MfAP5AwoyVq1hOIydioM7Y4
         v9Cm0EiaDWqpJIWq7udDm/zvnIm+ciu1/riXzrefo8zqPpt4yvdyFSoi5rYCDgC5KZJv
         pJetI3sbSFTjvO/UmAPfhY+D8/ngfVItAyqUWgH98Z9yhyb8phG4iwS9/9S5CTq0BrJL
         8oQX7s4F9lR2GjXamvuGQQ9XXN9foiBhJEEBpjYx94MgXJjK2Xb3DNDXFXwtQ7qXJNWZ
         T8Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVor5BA6znzQsTq6FEXjavbthJKFULaII1xlHawSucHOUywGmREuDDcv+rzWBu2foU8is7n9RCS4yLFlCpap8GtageHWHzJOinkuv1V
X-Gm-Message-State: AOJu0Yx98IjnlI3Au0t9J7FjjYC+o7V1SifxqFoUIKyHN+oT1fpFV+o5
	jdMtIQOViUVdPAjAfIisheHUOgZ+cs1X66+afzvfzurRvVJcmLIcUjhFD2Y58EI=
X-Google-Smtp-Source: AGHT+IFzrsC/3yUJT1aZoNiMmn7LzTvw3TcPL3GVffUIkmTe+Lydehx1iLrqSywEpeW71ST106QMHQ==
X-Received: by 2002:a05:600c:314c:b0:426:690d:d5b7 with SMTP id 5b1f17b1804b1-42811dd43a6mr35284895e9.25.1722157704185;
        Sun, 28 Jul 2024 02:08:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428057a6307sm138855285e9.36.2024.07.28.02.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 02:08:23 -0700 (PDT)
Message-ID: <e430b228-ce14-497d-b63e-15f14388a5f7@linaro.org>
Date: Sun, 28 Jul 2024 11:08:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: imx93-11x11-evk: add bt-sco sound card
 support
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1721897948-6306-1-git-send-email-shengjiu.wang@nxp.com>
 <1721897948-6306-2-git-send-email-shengjiu.wang@nxp.com>
 <e4ab2fc9-eac4-4ab7-9346-d4129fd778e6@linaro.org>
 <CAA+D8ANj0oond9bT0tv7DhBRpoXTEB95zMLALrLLZZZsw7sC=Q@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAA+D8ANj0oond9bT0tv7DhBRpoXTEB95zMLALrLLZZZsw7sC=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/07/2024 05:42, Shengjiu Wang wrote:
> On Thu, Jul 25, 2024 at 7:32 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 25/07/2024 10:59, Shengjiu Wang wrote:
>>> Add bt-sco sound card, which is used by BT HFP case.
>>> It supports wb profile as default
>>
>> <form letter>
>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC (and consider --no-git-fallback argument). It might
>> happen, that command when run on an older kernel, gives you outdated
>> entries. Therefore please be sure you base your patches on recent Linux
>> kernel.
>>
>> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
>> people, so fix your workflow. Tools might also fail if you work on some
>> ancient tree (don't, instead use mainline) or work on fork of kernel
>> (don't, instead use mainline). Just use b4 and everything should be
>> fine, although remember about `b4 prep --auto-to-cc` if you added new
>> patches to the patchset.
>> </form letter>
> 
> Sorry,  I don't get the point. I used the scripts/get_maintainer.pl to get
> the list of people.   Anything wrong?

Read the message, carefully. If you used get_maintainer.pl, then:
"YOU WORK ON SOME ANCIENT TREE"

I think I was pretty clear in above form letter, unless you just want to
ping pack to me so I will waste more time to explain why you cc wrong
addresses...

Best regards,
Krzysztof


