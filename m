Return-Path: <linux-kernel+bounces-184635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F05078CA9E2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A79152819C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B909B5478B;
	Tue, 21 May 2024 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zFt/MZFh"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1379851C4F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716279769; cv=none; b=SPcTRhzCwm3Be1schrxPlgNYQD6+2hB9Ncp6C85XAohWRTrSb0oEeV3hjyQonHx5W7fkTpKFof/AzvO0L5vh8wRaCQO87VPd3Q4iYnpzZHorkB7I2PsgkYBmU1tK2X3ZAaerWGRH35fDqAxqopXbGckPifdfiFhSKmycrszWOSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716279769; c=relaxed/simple;
	bh=EeRWE1XR2EwYdwHW9dWW9XdQxrVC1xXxF1iefdEmBVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UTU3PoHR/oCVw6p4Azls/FpcN02GPKmKMW7F/AYBEGH8KGOVc2IBmAc1bKp6l+4NghoAdgJzwNfh6toFjc/8wajsIKZmNABf0iTJV4PnOIJrHyT35ijc7E9se7mSsSnb+YaUmbZNlrQ1wqwLnyn8SZk7VASR/FstH6jxnNQkq/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zFt/MZFh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4202c1d19d5so26426515e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716279765; x=1716884565; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LPtanllkSZKaScs+26zclJhDb8dZFC+D3WKJMlR2rG4=;
        b=zFt/MZFhsSIcuB2ZlVBcKwsXJGZhK7zX4YMcof94aeTi4eSaY15It+Oy4SCfd+RyG+
         yeAimbqDXM/6v+Hg6QdZBI3ET1/KXUq1oFEjF8D00TaL5Bf4nX7kS+jYLPhk1BpYML+5
         hKlTkYtAapqam1rTEtCB3uUsfBvjU75mt8EFklck8exxAme3BSTwEdSJCA7xzv/Oan4J
         VOdi6uPi/JgNeyXFTYb1tU5UMALRFOB9HUjk3MlNMgX32MlNSSAqaNfa+UPAOgjfwRLO
         d5Cjsw+EHNeUiIEzpAwmSTp84XWoG5py7OLwrfJPp9AgpGMqAz+p9cWXIOUcS/WpKzs7
         ga/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716279765; x=1716884565;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPtanllkSZKaScs+26zclJhDb8dZFC+D3WKJMlR2rG4=;
        b=QVvMVxWNlf/hvpzRpB+Ne5DFNZAYkOU71y1pjOqKD1URHSwpiJMXCzG8kPotcn5KSt
         xXd9N0dk4dvtSMGyQLXQSxZV8eYoZ9G5zy57oJsyWhGTPD/yHJ6++sxpUxYAKMHnAiYD
         I2xHohvO7jkMBuWMLDThwpUYJtJd1hs/dPxKZvIJ/OFrEueLnDnNuOIKbLVKa+ZY34ou
         STVvFcSCVio8QuhmI0TpBAW+ON0Pr63pxl9c2dvVG1f0mo1vEFsy6YW+b1TVEiqCwEfm
         swAteE+D0rsNxHTzlm2U3rf3QBpfILyeMjdsDX9tTdKa7albtPhmGLfKtu3Q4UgFIvc7
         q1ng==
X-Forwarded-Encrypted: i=1; AJvYcCXWXPqUn/sTwA6Ot+5ArrjK32TYzZLaT6WvfUHRnsSVnRqwFv4QCnqd6BhxXoO3dsqn/URPErvAPn77I7N1x0u7B+97K36b2zJM4pQB
X-Gm-Message-State: AOJu0YyoqvHBootwSJRaWGeM1MlMqk40zWgc4ZOqFXIozMrw0Ek9IAeQ
	x/ut1sGceqQn0Q7KM0NREqTAtYxUjO+HyGXYb1OwD+SCpDQz+y7smFXZCxX7was=
X-Google-Smtp-Source: AGHT+IEQiUdLUGmNWLykbFfa4RT4CIrJVdBWV2yNgONyRHnKSm21v+25mZw0CbXmwrgPyL/U6Emzkw==
X-Received: by 2002:a05:600c:450e:b0:41c:2499:fa0e with SMTP id 5b1f17b1804b1-41fea931878mr281712685e9.4.1716279765368;
        Tue, 21 May 2024 01:22:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420111f2decsm369090595e9.22.2024.05.21.01.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 01:22:44 -0700 (PDT)
Message-ID: <75b78eaf-9b13-477c-bf02-4e9837a25dd4@linaro.org>
Date: Tue, 21 May 2024 10:22:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: mediatek: mt8365: use a specific SCPSYS
 compatible
To: Alexandre Mergnat <amergnat@baylibre.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>
 <20240518211159.142920-2-krzysztof.kozlowski@linaro.org>
 <f42ef151-6eee-418f-91e1-5ac08d161119@collabora.com>
 <2cc638ca-0add-4c8c-b844-606e22dbd253@linaro.org>
 <cf8c87fe-7a4f-423f-9c97-3759eeee4894@collabora.com>
 <51a47736-ffe8-49e2-b798-d409ca587501@baylibre.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <51a47736-ffe8-49e2-b798-d409ca587501@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/05/2024 17:23, Alexandre Mergnat wrote:
> Hello Krzysztof,
> 
> On 20/05/2024 12:12, AngeloGioacchino Del Regno wrote:
>> Il 20/05/24 12:03, Krzysztof Kozlowski ha scritto:
>>> On 20/05/2024 11:55, AngeloGioacchino Del Regno wrote:
>>>> Il 18/05/24 23:11, Krzysztof Kozlowski ha scritto:
>>>>> SoCs should use dedicated compatibles for each of their syscon nodes to
>>>>> precisely describe the block.  Using an incorrect compatible does not
>>>>> allow to properly match/validate children of the syscon device.  Replace
>>>>> SYSCFG compatible, which does not have children, with a new dedicated
>>>>> one for SCPSYS block.
>>>>>
>>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>> Technically, that's not a SCPSYS block, but called SYSCFG in MT8365, but the
>>>> meaning and the functioning is the same, so it's fine for me.
>>>
>>> So there are two syscfg blocks? With exactly the same set of registers
>>> or different?
>>>
>>
>> I'm not sure about that, I don't have the MT8365 datasheet...
>>
>> Adding Alexandre to the loop - I think he can clarify as he should have the
>> required documentation.
> 
> Unfortunately, The SCPSYS (@10006000) isn't documented, but according to the functionnal 
> specification, it seems to have only one block.
> 
> I don't have the history why SYSCFG instead of SCPSYS.
> 
> I've tested your serie and have a regression at the kernel boot time:
> [    7.738117] mtk-power-controller 10006000.syscon:power-controller: Failed to create device link 
> (0x180) with 14000000.syscon
> 
> It's related to your patch 3/4.

I don't see how this could be related. The error is mentioning entirely
different node - mmsys. No driver binds to 10006000.syscon, except the
MFD syscon of course, so my change should have zero effect on drivers.

The mtk-pm-domains (so child of patch affected in 3/4) only takes regmap
from the parent, so the cells again are not related.

Just to be sure: you are testing mainline or next, without any other
patches on top except mine?

> 

Best regards,
Krzysztof


