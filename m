Return-Path: <linux-kernel+bounces-529347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5098AA42330
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF1A37A1B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F99F24888F;
	Mon, 24 Feb 2025 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="irli+lCE"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2768123BCEA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407440; cv=none; b=fvSlREJrSlUgFFNV0n8bjtKivZZ1aLE9c2Kk+yQVOwUi80LthWTt4zGQsupXroyWsS8GKGfdXw7HanMwhHQxkg352NHdixmQx2obgfQK23wWpiXoJ586VQUoRqISOxxTbv7HTsRBhKhpqtFZX1/gokZffeAEGYzfbtFWRx5J7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407440; c=relaxed/simple;
	bh=A4sO6cN1cpNqJvgaPAPM6bHpcQPbDrtPOMb89oj9Pm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FAvnm4BINhH6vkDvV2qh5Yux8yGaroPglj95ccSiHsuCm/OcSR89rNxLIDGGIV29IDZIPr4bol0NLma5OO9W6EztBm8PY1yiRB9lVfa+yfP1Xp60gklm6tuoJPypsqAOx1BShsux5HUdPjVEBF6gFpkhXhJsCgvvPkJiKnu0pcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=irli+lCE; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso2310570f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740407437; x=1741012237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cji69n3WY8P4L0jP3m5wYY9M3Sin0x61QBvMV9h4TzY=;
        b=irli+lCEAWS9ghxiU8a5WV1LzzcD2q2FEcRUyaG+SkpyarTws8Nu5h7eZi9foLcfsU
         PsY2nsOJYyDnM0P7TKxWmkMLQfJ6ldnINR8F0YFficriXB1dJeQzk4U/+61fMiOCdzdF
         B4r8v7N523VhvysVjBU/x5AEW9NpEroCja5Pj0fUI6k2gl/sbXmWJ1GVsmrPJ5dmevsA
         BrllEdcZ16gZqwRrguI6f10MrUQsLzZCsaVZ7m1Rz004pT/+vs1sFt7kU9Mglsp+w86z
         lFikmDgqzAgM2acawAXawEKmgvJdS2YvWQqYTJfo0eeUutdCk5pp4pgGEXicoWy6ayB7
         4YEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407437; x=1741012237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cji69n3WY8P4L0jP3m5wYY9M3Sin0x61QBvMV9h4TzY=;
        b=ZaRJ6po/I/VggNJSFXTNfyji/HcGl4GdZMe0qagtJIef6VXEkBhIODgs7jspM3RdsT
         eCsI+xFj02apXEMNAQT7q4G2rbJXhtES+MzPeM7+tnQORvJwHKVbET4sgxh7i3oPadhE
         YH9wKC4aByzo5bt+ABpXUKvyo4KblH1tDcWngflYVAYOCczWlBsxtoFKF2PQX2EEIj8E
         uR3BnGq51Yu02SJRW+mE++Lcp1AHubprdkLSx1g3aue6QOAsDiKGss0tYmrmHMxnP9Iu
         rHaEFQwruA+i3yhPO9CyuK2VLvnLT9li05cqh0VjHCWZCEGW9++6v3S4L6dCZlqdf5A7
         /fVg==
X-Forwarded-Encrypted: i=1; AJvYcCWzsii6a6ltJbh02+agoGf5ZZL7OoCyEojQ6+owulU4jaDbLnN+p3oWttVzmOdYUCxcJ8WHvZWPmqNnib8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq2yMdxcA+U7Mi3p2ljXEJm6oOBilJSiSVeWKE02C6+JtdHUm4
	OUXGLDm1AWAXtVE07v9LQQfd+3/Xs+zdPQwuFNUTSXXfGk4qtv9KPH3ysWhdwX4=
X-Gm-Gg: ASbGncv1FET5vr/s384NQsAhC7lTCx7bkZijIgrh7ydJOPa1ELdh56Nwf6pY3K3X+UR
	ZEgAslesqGdC83zV9hwaPsIvs/hl60ZofeuEJRO9hrmO2vRwx1g+Qasf2TH8q5dO4Sr5/RjeOip
	9Mo2vYfDojLN6iYSof8xU6F46vQC+9Mfqsg6j2LYSlCKhIZaRjfumOW0i69wM/8RB0Y4cRnj/UL
	oZ/w+5Fma8i+xy5xencR32LM5Bxynj933PeMv87+p3yPB1fO3egAUysbk9NIYnADbiJXexw5YQr
	8vicnGpIZuDteDO65OfzWvatZoAvMe73PzhLBal/FPVtXBmcL+pnrvcyKcT7CiP/SwYnNdtCWg=
	=
X-Google-Smtp-Source: AGHT+IEC7mdR0hWAg4+Gqbpyo8+1P9D8qUn8hGBjBBnsIrJNrEh/GPTRe144zpuW/58kf6KoAeRu3w==
X-Received: by 2002:a5d:6d85:0:b0:38f:2726:bc0e with SMTP id ffacd0b85a97d-38f6f09750dmr12138802f8f.44.1740407436620;
        Mon, 24 Feb 2025 06:30:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:5ee:79d0:ce53:5813:dc8a:b123? ([2a01:e0a:5ee:79d0:ce53:5813:dc8a:b123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5eeesm32323805f8f.63.2025.02.24.06.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 06:30:36 -0800 (PST)
Message-ID: <41849f69-ee2a-4cee-85d8-2d3b0993b907@baylibre.com>
Date: Mon, 24 Feb 2025 15:30:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: usb: mtu3: Add ports property
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Cc: "macpaul@gmail.com" <macpaul@gmail.com>,
 =?UTF-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?UTF-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>, =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20250220142230.2530583-1-macpaul.lin@mediatek.com>
 <0e58bfb8f2f7b7e83e3da6075986ddbcc84531fc.camel@mediatek.com>
 <fd173075-df66-4ee7-a9fa-07e840976f26@collabora.com>
Content-Language: en-US
From: Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <fd173075-df66-4ee7-a9fa-07e840976f26@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 24/02/2025 13:18, AngeloGioacchino Del Regno wrote:
> Il 22/02/25 09:35, Chunfeng Yun (云春峰) ha scritto:
>> On Thu, 2025-02-20 at 22:22 +0800, Macpaul Lin wrote:
>>> Define the ports property in the mediatek,mtu3 device tree binding
>>> schema.
>>> Include definitions for port@0 and port@1, specifying their roles as
>>> High Speed (HS) and Super Speed (SS) data buses, respectively.
>>>
>>> Suggested-by: AngeloGioacchino Del Regno <
>>> angelogioacchino.delregno@collabora.com>
>>> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
>>> ---
>>>   .../devicetree/bindings/usb/mediatek,mtu3.yaml       | 12
>>> ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
>>> b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
>>> index d4e187c78a0b..21fc6bbe954f 100644
>>> --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
>>> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
>>> @@ -155,6 +155,18 @@ properties:
>>>         property is used. See graph.txt
>>>       $ref: /schemas/graph.yaml#/properties/port
>>> +  ports:
>>> +    $ref: /schemas/graph.yaml#/properties/ports
>>> +
>>> +    properties:
>>> +      port@0:
>>> +        $ref: /schemas/graph.yaml#/properties/port
>>> +        description: High Speed (HS) data bus.
>>> +
>>> +      port@1:
>>> +        $ref: /schemas/graph.yaml#/properties/port
>>> +        description: Super Speed (SS) data bus.
>>> +
>>>     enable-manual-drd:
>>>       $ref: /schemas/types.yaml#/definitions/flag
>>>       description:
>> Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>
>> Thank you
>>
> 
> Is everyone okay if I pick this (and the XHCI one [1]) in the MediaTek trees?
> 
> This is so that I don't get devicetree warnings when picking the DT patches
> that are adding USB MUX/TCPC to the MediaTek boards.

Sound good to me.
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

