Return-Path: <linux-kernel+bounces-187784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BD78CD86F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8549D1F22727
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DE118026;
	Thu, 23 May 2024 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtVl1yCb"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD16B1CF8F;
	Thu, 23 May 2024 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716481898; cv=none; b=gehDIJ6+RO7imdpCghp1kek7g1eLeZyNWf5iutoUlI6XghgdCsXdp19ET2GzTwsi/oFnFammC14eOF0HsTMBNHk5fxf6dQY0uw5g1Xosim0SDCfzmVCAqvHWpgwrfd1g0q93ouVAGDLA4LASi/uvvsRGMNPC4iEtwua1JKftabo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716481898; c=relaxed/simple;
	bh=yFdXknMEp6BoBRx9d/a3Xb7qQPDAPn3S0QNRYt4ZMwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FR84PJYkLp/o0zTiAM9Wa1Z3n3lPL3c0GJvoUdyZj1ulxKnYubhQTdveDRPYaIqvwbvPOfGhEk2VBqXNJabxd6ugUeFg7rXTsfSLKtdo2yXavRHydJT0wIp1NTi62BwtcmblZf87r57JOlQNtXNwRWMYjODgPL7RASFy5HsytMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtVl1yCb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42016c8db2aso21208065e9.0;
        Thu, 23 May 2024 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716481895; x=1717086695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BkFgbsBHw567DO162agH6xtszv6nFxh3v/OqHAXAYQA=;
        b=XtVl1yCbHcsASENET0tbWaPdkK/ToyDTNTbRtiG4NlXpZhNkBWWd7MnMy578pnhfG2
         7bLHEaLNqZ+ESZ2kB4xzJ2Xx8k5T6oj2NVKV+MsJo1EL3hQlLpPWKUseh1pAV3YcJriB
         sMKMeKXbF3G8S6ETEiPJPuZt1BGrsz3sRWhE/fFkvx9wAdDpU80Aecn+2I1t/OKL7TXI
         cXcKpBabwob6xoo+r6iLJ36Cr1/UnjSyA59WklhZF6sBi76XcBywcY1p/Aqa5udCoLnv
         6CmVsCZn0gzG5CA5iTWcBZ7ZLCgWNqCGkR3TS4AoN5gggl6i8QqUwRDEYHBv79ogpmPP
         fmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716481895; x=1717086695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkFgbsBHw567DO162agH6xtszv6nFxh3v/OqHAXAYQA=;
        b=wOSrM2cv2CIRlZVpl9vzJII4S8uj4uycSY51qqSzStpvlFWTiEYz4GfKCXmUNNxws8
         lDxB39US65D5KZL1EG0OgPHQNMiCyzYjcxAUf5Lsqc4OpOSNsbNJJ5N6b4r388HVqnfC
         mzElOORV5VqVZexAi/sktO4HJ6WO2gXXpsl223j1Za1XM+Zb/Sb0MMHztelYhQmLarOz
         5KcZyy/lHJxD/TvM6Hsje4aZULVOcWicClzQ2+fGjqBe2Bf51lfa6FC1i5w74LSkpSSo
         C1bS5uxWWAdqzhBJNNTIRxeEZSmrdRMqNR/YbMMhrJO7pB7Jsgd83lRKEJOhbWbyX04u
         pwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNB5bq3exj4r6dDHlAxL9CejA2jV8Gi4k0dK8tMGb4LxMRk8wHvw2l6vp5GP0ALqZP3cotScE4eaXz1VqELladsBtmaTCot7EdECg1kOVdxEeiWQoriTIi5swNVYCP4SD6tTk5WSqm0A==
X-Gm-Message-State: AOJu0YwPBhj6Ye5xgLUffIGnSTCrHYiw9k5K+8ufpgrUoPR/RqakGgmZ
	oWW4Vx6rPRi2cZH6z6hg/Av2pdIBZul2HZ8aL5p0TnGkLSegKBKv
X-Google-Smtp-Source: AGHT+IGERajLeL6v45YR+OnIu7rQ+Rz0hkkeUorXN4ovcimgSqTBgypDrtLU+Fnhe8uBHynPnppIZw==
X-Received: by 2002:a5d:5612:0:b0:354:eb32:6d1a with SMTP id ffacd0b85a97d-354eb326e3amr3792720f8f.59.1716481894901;
        Thu, 23 May 2024 09:31:34 -0700 (PDT)
Received: from [192.168.0.31] (84-115-212-250.cable.dynamic.surfer.at. [84.115.212.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-354c2a40548sm12143109f8f.34.2024.05.23.09.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 09:31:34 -0700 (PDT)
Message-ID: <865295e7-30c8-4abf-9992-fcb9b3186ebb@gmail.com>
Date: Thu, 23 May 2024 18:31:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: DT schema bindings conversion mentorships (was Re: [PATCH v5]
 ASoC: dt-bindings: omap-mcpdm: Convert to DT schema)
To: Rob Herring <robh@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Julia Lawall
 <julia.lawall@inria.fr>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20240522075245.388-1-bavishimithil@gmail.com>
 <0594944d-c158-4840-8724-b3f2edaab1ca@gmail.com>
 <4f722e53-011f-4176-b6af-080522165007@kernel.org>
 <bb44d588-9316-4509-b545-9bbaa2d240cb@gmail.com>
 <3c6c5be1-fb8e-4bf0-9f58-cfb09672e8c1@kernel.org>
 <d999bc26-9bb1-44a8-92a3-bcbe14c5a1c3@gmail.com>
 <58ada5ce-5c02-4ff5-8bdd-d6556c9d141f@kernel.org>
 <60989c44-6d16-4698-bf3f-b3c5dcd7b3e0@kernel.org>
 <dc31c4ba-1bea-4056-a68f-87d742eb8da3@nxp.com>
 <CAL_JsqJp133hGSkja9tabtsE9D7MSA9JErVkmkcy91piHMgfwg@mail.gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <CAL_JsqJp133hGSkja9tabtsE9D7MSA9JErVkmkcy91piHMgfwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/05/2024 18:24, Rob Herring wrote:
> On Thu, May 23, 2024 at 7:30 AM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>>
>>
>> On 5/22/24 20:05, Krzysztof Kozlowski wrote:
>>> Dear Daniel, Shuah, Julia, Javier and other mentorship managers,
>>>
>>> I see some contributions regarding Devicetree bindings which look like
>>> efforts of some mentorship programs. It's great, I really like it. Only
>>> sadness is that no one ever asked us, Devicetree maintainers, about some
>>> sort of guidelines. This leads to sub-optimal allocation of tasks and
>>> quite a strain on reviewers side: for example we receive contributions
>>> which were never tested (tested as in make target - make
>>> dt_binding_check). Or people converted bindings which really do not
>>> matter thus their work soon will become obsolete.
>>>
>>
>> Hi Krzysztof,
>>
>> Some of the faulty patches are on me! Sorry for that. We had an
>> unexpected high
>>
>> number of people sending contributions for Google Summer of Code and I
>> couldn't watch them all.
>>
>> Now, the application period has ended and we have 1 intern working for
>> the summer!
>>
>> Will follow your guidance! Thanks a lot for your help!
> 
> To be specific, there are several ways to prioritize what to work on.
> 
> - There's a list maintained in CI of number of occurrences of
> undocumented (by schema) compatibles[1]. Start at the top.
> - Pick a platform (or family of platform) and get the warnings down to
> 0 or close. There's a grouping of warnings and undocumented
> compatibles by platform family at the same link.
> - Prioritize newer platforms over older (arm64 rather than
> arm32(though there's still new arm32 stuff)).
> - Fix warnings treewide from common schemas (i.e. from dtschema).
> That's not conversions, but related.
> 
> Rob
> 
> [1] https://gitlab.com/robherring/linux-dt/-/jobs/6918723853

Thank you Rob, I forwarded your recommendations to the LFX mentees.

Best regards,
Javier Carrasco

