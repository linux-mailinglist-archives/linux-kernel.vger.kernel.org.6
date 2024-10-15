Return-Path: <linux-kernel+bounces-366872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FFE99FBA0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387AA1C23880
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AC71D63D1;
	Tue, 15 Oct 2024 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9VmySEX"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0471D63C3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032307; cv=none; b=Q9/hZex5t9t8X3gIg64fkJ5G+FVHtMBK851PrknImaLyd5S9hfzgBRAuGAi/IxJulenUGJIVWRyJKloJCKpA5uLIXlm+jMmFD58oWvRmM1u0OX1EC9buEqwhTnJLltsbQD9ewgfmC5SNorOFTL83H4+5LHk0oOXzBzPs7ITEhmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032307; c=relaxed/simple;
	bh=DsdgpSpoWZhnIXCFppOJBlx0EyQB6WqayryDSQ4A8CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8Nz+qqPSbPKriBtcXAU8dl5ifVWalNLkiZpco+zdFSMJC+n+7FIwYOTNGFtMLH/Ld9yA59TaXJf7eu2PSCCbq/OWlaLCKrVDnV3umm+03HayQIdQogw/Odey/ZYjmSde9LaXrynS5tCDEnjg29a16VLrajmlVyWspQMbmwznes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O9VmySEX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a1b71d7ffso296865866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729032304; x=1729637104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wu5LGapJAR3TxlLLRLI6uB8Zy6lgYfJ63+ETUjJg8y0=;
        b=O9VmySEXaSWqKOx9r1Ea3YbpMGmh6Um04Xr9dhP3s4OVI0udm3Vuzl/wJd0mHhef04
         uxgwSdzcYB1jt/arGApbqCQbsKrEd4urlMWVFIElZsfksdJY0MSPayZnnQrQEycuXAbt
         u98L58j/5dJ0eLOnO+BExprf6sPkw8q7OnMWQRNSLSkQawoA0iVyw4+Dvaxa7TFN50Nm
         3vptZFfhSWjBSn61z2CZRjdckshRmhxGsk19aEWKQ8eE9BaX+vM9eG48RQ44Ad9OgxRB
         5n7FZoNTsqYFXU26wGVci05y0ZGepCLU9eLXkhRZd83mcE6b5ep5U63uFFYd2w01uo60
         chjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729032304; x=1729637104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wu5LGapJAR3TxlLLRLI6uB8Zy6lgYfJ63+ETUjJg8y0=;
        b=xHn27ISFQ0agLld6yKRKed0PyQXKJZ3eKx6Md17SHjzweat3OR7YBjS75NiQpDDG83
         08jAOa5YK05Ohufbqmz9WRlTdhE14WK9qPSs3INpPoMP0F/D0UBSRu6NyS5Gat2FIhYK
         g6HyB/DmspjLJ3HgbH7aWsh0kkoWo/WL2A63ixLiES7gQHQiyIbxIkFZhnASCnXhO6sW
         8H3fF7vXFNbjbKY8BuABV11wfbBDJI9vwKFiCd4FJK6Hsp1QLqx3rMxYQfJuxixcoSK/
         +wQUu2zC6Qf63LoJim9ON0E/GD+cut9gs99Dw0+NpoQECu/G7UbQAwLQoI/9pIB1/wv+
         x86g==
X-Forwarded-Encrypted: i=1; AJvYcCUP/umig6VgzWNC/ndGw8HNq2A/n6POUz5VUPDa5DQXDhQEIpPt2xHPw1quBKDFW6AX2nouWSW8BtHX/0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWDgtHZWQCWGOl8pjxAYKR13G2UkdNlnRA0fEt/Sx7r7uRxpbU
	X4NiSresnH09u92q9o0nOmlCEV9WQFOkNjNcaJ2aXSNaW+JVHTipdTOFcfBkaRA=
X-Google-Smtp-Source: AGHT+IE8dkYYRG4VSiuIYPilluzQgGDtk3E35fxzuB+y4xhvcllblu00zCcB/RT5fExPyYiJMsZDuA==
X-Received: by 2002:a17:907:7ba8:b0:a9a:1b32:5aa8 with SMTP id a640c23a62f3a-a9a1b325dc9mr609885166b.4.1729032304410;
        Tue, 15 Oct 2024 15:45:04 -0700 (PDT)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2988c63csm114946366b.207.2024.10.15.15.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 15:45:04 -0700 (PDT)
Message-ID: <1efe72f0-6777-4057-8c5d-47e891ae1b0d@linaro.org>
Date: Tue, 15 Oct 2024 23:45:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: dt-bindings: Use additionalProperties: false
 for endpoint: properties:
To: Rob Herring <robh@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Martin Kepplinger <martink@posteo.de>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 "Paul J. Murphy" <paul.j.murphy@intel.com>,
 Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
 Tommaso Merciai <tomm.merciai@gmail.com>,
 Martin Hecht <martin.hecht@avnet.eu>, Zhi Mao <zhi.mao@mediatek.com>,
 Alain Volmat <alain.volmat@foss.st.com>,
 Mikhail Rudenko <mike.rudenko@gmail.com>,
 Ricardo Ribalda <ribalda@kernel.org>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Umang Jain <umang.jain@ideasonboard.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Dongchun Zhu <dongchun.zhu@mediatek.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Todor Tomov <todor.too@gmail.com>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20241012-b4-linux-next-202041004-i2c-media-yaml-fixes-v1-0-a2bb12a1796d@linaro.org>
 <20241012-b4-linux-next-202041004-i2c-media-yaml-fixes-v1-2-a2bb12a1796d@linaro.org>
 <7ecxjoa7aije46cxmkyfd6ihxnqw4wleqkioddomxbwlu7qtrc@4dkfitppeksu>
 <6f461cb3-3a41-4a3d-b9b2-71b1c6be77f7@linaro.org>
 <9510b546-28fa-4fb4-b06e-0af5f9fd3bbb@kernel.org>
 <20241014202920.GE5522@pendragon.ideasonboard.com>
 <f265576c-7d83-40cb-b857-7ec54ef9ab46@kernel.org>
 <20241015112806.GA2712@pendragon.ideasonboard.com>
 <20241015194418.GA1244454-robh@kernel.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241015194418.GA1244454-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/10/2024 20:44, Rob Herring wrote:
> On Tue, Oct 15, 2024 at 02:28:06PM +0300, Laurent Pinchart wrote:
>> Hi Krzysztof,
>>
>> On Tue, Oct 15, 2024 at 08:11:18AM +0200, Krzysztof Kozlowski wrote:
>>> On 14/10/2024 22:29, Laurent Pinchart wrote:
>>>> On Mon, Oct 14, 2024 at 10:47:31AM +0200, Krzysztof Kozlowski wrote:
>>>>> On 14/10/2024 10:31, Bryan O'Donoghue wrote:
>>>>>> On 14/10/2024 08:45, Krzysztof Kozlowski wrote:
>>>>>>> I do not understand the reasoning behind this change at all. I don't
>>>>>>> think DT maintainers ever suggested it (in fact, rather opposite:
>>>>>>> suggested using unevaluatedProps) and I think is not a consensus of any
>>>>>>> talks.
>>>>>>
>>>>>> No there is not but then, how do you give consistent feedback except
>>>>>> proposing something to be a baseline.
>>>>>>
>>>>>> On the one hand you have upstream additionalProperties: false and
>>>>>> unevaluatedProperites: false - it'd be better to have a consistent
>>>>>> message on which is to be used.
> 
> There are 3 options:
> 
> - no $ref => additionalProperties

I interpret this to mean that omitting 
additionalProperties/unevaluatedProperties is logically the same as 
having additionalProperties as you will then need to list the properties 
explicitly.

> - has a $ref:
>      - additionalProperties and list ref-ed properties
>      - unevaluatedProperties and don't list ref-ed properties
> 
> I do debate (with myself) that that is too complicated as many don't
> understand the difference. 


We could go back to always using
> additionalProperties which is what we had before unevaluatedProperties
> was added. The other option is always use unevaluatedProperties. 2
> things have stopped me from going that route. I don't care to fix
> 'additionalProperties' treewide which would be necessary to implement a
> meta-schema or check that unevaluatedProperties is used. It's not
> something I want to manually check in reviews. The other reason is just
> to not change what the rules are again.

Right so I received feedback to change link-frequencies if I recall. I 
thought I had been very-clever (tm) by copying an upstream source and 
when I received feedback to change assumed the upstream source I had 
copied had bit-rot w/r/t the current preferred way.

Some additional discussion shows there really isn't a preferred way at 
present.

Is there a place to meaningfully document that conclusion instead both 
for reviewers and implementers ?

Should I already know the answer to that question ?

---
bod

