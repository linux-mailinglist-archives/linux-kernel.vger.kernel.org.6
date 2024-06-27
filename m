Return-Path: <linux-kernel+bounces-232117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4810591A3B5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6EAE1F2318E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE4513D8A0;
	Thu, 27 Jun 2024 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYgvbPfa"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BEE13D516
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719483994; cv=none; b=FECk0nSa2wjiCX9th7F18G2q3TM6qA85yNLlmJp2A9EUO91u3FsTLCY26arEzj8dwa4HglBOz2vDnShBsPtktHkYfsVsuwBxYfgpAwPtts85fCaOjXKuyVrY8x3I5mJXmQUVKSbReJA0oyVhczH+EraA5RYy4ClVKmbDvS93xmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719483994; c=relaxed/simple;
	bh=d9wEoD0UdiUGKw4bhAzp2yNReSjDi+Ux2hbuT19dj5Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UgjQoigTIP1FCdhLPx8P4w0j3wx0tilB82vBhjKULDb3kiCj1pMzV9o+LtgSBJv1lie2ihI1/sOwv8/5SltIUix6dr5EbwXr6ShF8B8Lq5QeEFjvjHf5I21/oPPCzB6pys+2ouAe2nRGu82iaQ0eNGqWtVPo8aVhLXRtoEWYwcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DYgvbPfa; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42138eadf64so65990615e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719483991; x=1720088791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kkiib5uXUKfAV0KZC0BOS/LLie42Hi3enUGI15yO3lg=;
        b=DYgvbPfajDXNartblys0+zDXd/31lCXo0+9GU6tRT1Bpm/Umprl0/eZlB5MazAovkT
         gc6MIhpurJ5yQMwfFdLlMtJW8d76IjV/NORNEZzpkV/Ck6XjlpkdEaAYMtTq+KaOthp7
         uYoqfR3+fobEDlUpd+ol9aQVO+YkZczMmpgMJpSAQWNrmQVaFboGdgSsXTmkxHXHl8xP
         YqRUHFrcxOkzO6W6I2F6WnYyYMgDIV1VgtIdamYH3GFKalpaFs3q9njZWZ+rISWBqEc5
         uRL7B+DyKU3bK5PIrAXPqNG3+PnIH5fKyrFO9QKes5N7gbuH3wfgQaMlWNunusqI5h3p
         iS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719483991; x=1720088791;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkiib5uXUKfAV0KZC0BOS/LLie42Hi3enUGI15yO3lg=;
        b=CM0rsIdOeKkJ2ZeoJvcUbOcDS4vuWTMymIJrg0tfHei9ts0+B4aZXk9EZ4hksIyllv
         ZEG/uEnBUSTX1RsTOSrrEwSXrv/jgTT6oymbrxrnUr6OrryN21eo9So431r42Zw+5/KO
         9g/1+KrZZ8hmOSkFuT+NE07x8wAbMKnrp+qT7h5H4p9e6KI4y3EYwmx+jOZyTULV5Q2E
         waM6jDFu8daVjk+Lh8qzHI2babBbvoBhl+0b5LJk+ZL2T4o8EtGU0/x6eUcJMNraKFzB
         0f8BBFUzgwtg1f5fFolDI7pxXZdV3mB0gicYKx6UTTQwHw9pF8+yOCKfXKlr1y25GkMg
         0OeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4gFn49Y3CEkdIVfmwmf4W1TW2n/s95P3NGLkhsK1zpYFODdflJsTJGRGnGMgC+xPPhqkBMhxcyCNJvaRz4bcSoPPQQ75LZ/KQGJvA
X-Gm-Message-State: AOJu0YwaJ6Jwc30Z/M7qGCwfdFCFyKsUsHrV33qMv/tE+2EyFrlo8ISV
	+bWs1l5zDB9Wzv7NObtpd8oikQ/ThWO6siYnliGY4ThVPCS4pymoofIxLv8fTtM=
X-Google-Smtp-Source: AGHT+IFuC5s3wiSW8VkamLlRdNW2xEIi0ktoj3jQfj2TJK9ZIRcRaQQZXUFi9lGKO8Puy6iYf7kyXg==
X-Received: by 2002:a05:600c:47c7:b0:425:632b:b929 with SMTP id 5b1f17b1804b1-425632bba79mr13819525e9.1.1719483991359;
        Thu, 27 Jun 2024 03:26:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42564bc60f9sm19587705e9.46.2024.06.27.03.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 03:26:30 -0700 (PDT)
Message-ID: <8a30fc06-4152-4489-b991-184c8e816254@linaro.org>
Date: Thu, 27 Jun 2024 12:26:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] dt-bindings: mfd: syscon: Document more
 compatibles and require simpe-mfd description
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Lee Jones <lee@kernel.org>
Cc: Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Jacky Huang <ychuang3@nuvoton.com>,
 Shan-Chun Hung <schung@nuvoton.com>,
 Khuong Dinh <khuong@os.amperecomputing.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chuanhua Lei <lchuanhua@maxlinear.com>,
 Rahul Tanwar <rtanwar@maxlinear.com>,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com,
 Nishanth Menon <nm@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Conor Dooley
 <conor.dooley@microchip.com>, Rahul Tanwar <rahul.tanwar@linux.intel.com>,
 Amireddy Mallikarjuna reddy <mallikarjunax.reddy@intel.com>,
 "Zhu, Yi Xin" <Yixin.zhu@intel.com>, Maxime Ripard <mripard@kernel.org>
References: <20240626-dt-bindings-mfd-syscon-split-v3-0-3409903bb99b@linaro.org>
 <20240627081853.GF2532839@google.com>
 <58d1e88c-b2cd-49c7-b250-84104e82ed67@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <58d1e88c-b2cd-49c7-b250-84104e82ed67@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/06/2024 12:24, Krzysztof Kozlowski wrote:
>>>  .../devicetree/bindings/mfd/syscon-common.yaml     |  71 +++++
>>>  Documentation/devicetree/bindings/mfd/syscon.yaml  | 306 ++++++++++++---------
>>>  .../bindings/soc/intel/intel,lgm-syscon.yaml       |  57 ++++
>>>  .../soc/microchip/microchip,sparx5-cpu-syscon.yaml |  49 ++++
>>>  .../bindings/soc/sprd/sprd,sc9863a-glbregs.yaml    |  55 ++++
>>>  .../bindings/soc/ti/ti,am654-serdes-ctrl.yaml      |  42 +++
>>>  6 files changed, 457 insertions(+), 123 deletions(-)
>>> ---
>>> base-commit: 8dc7c29f608649f3d9eca826e9d4fe4b8a32c472
>>> change-id: 20240517-dt-bindings-mfd-syscon-split-37e23996523d
>>
>> Okay, I tried to apply these whilst fixing up all the conflicts, but
>> lost the will to live.  Please rebase and [RESEND].
> 
> This was based on your for-next 8dc7c29f608649f3d9ec "mfd: lm3533: Move
> to new GPIO descriptor-based APIs". I'll rebase.

Ah, I see now in your tree Bryan's "dt-bindings: mfd: syscon: Add TI's
opp table compatible" which will conflict in tricky way.

Best regards,
Krzysztof


