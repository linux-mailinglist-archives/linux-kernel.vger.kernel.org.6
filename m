Return-Path: <linux-kernel+bounces-183776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5068C9DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A1728554C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD21135A7C;
	Mon, 20 May 2024 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EEke6yAt"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5671BA2D
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716210715; cv=none; b=r8yQg68lOGLPKy2HYVYa5k6ISwaFFmEAD9ulfaqrvXR6uKQl+jwLoWPC6vy9vq+kx9JdH1w4i1v9FeRsCuaHAislphqs9fmeF1gXEtfVGEUT290LSH8pX9OzcZgT5ahwb2Kgww+mdMTnj088oyAM6oiLZYHcKV1FdK83FZM99NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716210715; c=relaxed/simple;
	bh=2Yr/ktSiz5ZqL3sxN8VLHx1ksFht5mgQS0yNhYvE+0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oAY4vqEu+hMvfU53c8KBd1fq60FGtfF4M1fucS2Y3KzurePzwNw7ER2JIDZNW82iPswUxH+KAcmDiuaqMRh1u+Q4YZAbFmZZ/sgmnAdose7YuyjmziWtwv2iXu1f78AAh99/KBOHwkUv4OTiUFoerzZAtKKrvrhaxl4D+3ZfenA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EEke6yAt; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-574f7c0bab4so9264284a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 06:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716210713; x=1716815513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CIVxA0VPqbQrJB+JYzaAq7K8VydvnyoVRdgA2fioBxk=;
        b=EEke6yAtdGAKAceQeDWC5qZK+2BPMeSpYpD0Di1qj6LxtZtoBjv4nCRLDzzRSpLnVG
         Qi4Qn2DM3chU9+EeXA0fz74a+Qf/Py1fvz40ZYQ3rpe0Q4PGV2tozu7Lf5/frC+ww900
         OzIF+RMdcZEC3N4H+aZHeGRAKY84kkMbSbkW01VdUw6vSLDZqrPsvayUwOhnADB9lJio
         NEzDw2g/SsWcN2Ut3bf7D99amD24NJrkYCmN3UWXxwWnVn5q+P73ne/2ElBPgSYTMVmE
         TSoAeBA26WZFC4rlZWjXsW5Udl2ZxSqvXZAyl0yrgMhlNbCV/2pMFkKW+SYLoKTn9R5j
         OxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716210713; x=1716815513;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIVxA0VPqbQrJB+JYzaAq7K8VydvnyoVRdgA2fioBxk=;
        b=TV0T6cEZ/VoXnMeeHFdl/0KBdJhwASAqMgg+2Bf64qr5/Uxp4M1cUUBd8BLWYSQJ1K
         abWETYcitIH24oExBmgkZSnYQClqahKnXm6sbzgEfpspOLaUVfHupAaMAVKf1SAyhg3K
         oeaxJPuExjVZ64aoExxnMOwFWAeE51fnubmey4MUpTEW5YgvoXlWYFKdNMwp+8Imfo3m
         OQnowmMCNlnxXwzZx42XFrl0Vpis+AFI9KRcfkTvdidZGGjgVytP56SD4aI3X1D/Kro7
         Ji4VumhSXBEaAxFWxkiQi4DpIgJvltxp3qbcuq8HhOCPXMwGbTHuRI3gWCyCQqza+UGY
         lBqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVociwBDnoqL3Vufldht06zhdrBOJNOJ3vAja6AUJWtHsuDd6qW8ZefYlhEbOWF2pS7J1KsLanXfV3JVFu8JpEKbIFwhQaBjzGDCy9L
X-Gm-Message-State: AOJu0Ywmo66SD8cebWXLvGpLGQI0lb/WelAB/XqMYM3kkDdymIXanzwv
	0PVVPomT0ejKrGI0oYfcOXoI7j/j48aJdC7RT3AL8apTNXYdCeinwh0xeV8lzJI=
X-Google-Smtp-Source: AGHT+IFn7EmHeXN/apxnA1/OqBGNByNsBJye4qiia6BB+t3TR1qpLGmwS0gEivtjg6gJdBinq/0L6A==
X-Received: by 2002:a50:c044:0:b0:572:7014:230a with SMTP id 4fb4d7f45d1cf-5752b4c8d66mr5219247a12.14.1716210712754;
        Mon, 20 May 2024 06:11:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5735a2490casm13572162a12.32.2024.05.20.06.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 06:11:52 -0700 (PDT)
Message-ID: <165d5aa5-c05a-40df-9c9c-6a1de360dc96@linaro.org>
Date: Mon, 20 May 2024 15:11:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: mediatek: mt8173-elm: correct PMIC's
 syscon reg entry
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>
 <20240518211159.142920-4-krzysztof.kozlowski@linaro.org>
 <671a4b1e-3d95-438c-beae-d967e0ad1c77@collabora.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <671a4b1e-3d95-438c-beae-d967e0ad1c77@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/05/2024 12:07, AngeloGioacchino Del Regno wrote:
> Il 18/05/24 23:11, Krzysztof Kozlowski ha scritto:
>> The MT6297 PMIC has address/size cells == 1, thus its syscon child node
>> has incorrect number of entries in "reg" property.  Fix dtbs_check
>> warning:
>>
>>    mt8173-elm.dtb: syscon@c000: reg: [[0, 49152], [0, 264]] is too long
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> That node is unused and not needed at all, even...
> Unless anyone has any strong opinion against, I suggest to simply remove it.

Sure, works for me.

Best regards,
Krzysztof


