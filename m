Return-Path: <linux-kernel+bounces-433117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C34E29E5407
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0A4167A98
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FDF1DB94F;
	Thu,  5 Dec 2024 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RH/JZBks"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9543E1DB52D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398417; cv=none; b=AsWLDQ8I/Cc6KMwF/hvJ1Co4wf8HSVXtaNhxnBpW+fe3SCppAMxf5jkLx17xrKCYE4YRvzRDLmemdjYK4Wa4ACMRy9B7DMMANGmT6jmkjZwrg9faUxHX+mdvURU/4lLbdezCDgIRFrL32tDLri6xMW2ZuzkZWVXXHYA0wLR7pHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398417; c=relaxed/simple;
	bh=Yd7TCI71eLkYLDOUMO7Fs/wQoziaEJbbESfjNDCLz3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBML/T3D1Xfuz+Ev99frmT39/7l7mBK+qNP1IN4AIYaty0CBiZx4STku45iyrINaBz3VB9HWEIA0rTPo10BvXHqT6HJ4N/U3BM6LkhsSjd5XjRdo+gDAtzmkBGvwZMZNB2bKHqhhiVkBJrO1AZ6VHvipyHFMiK2/43x5DyFnhJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RH/JZBks; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385d851e7c3so21549f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733398414; x=1734003214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KqOu+03vzBSw9jXH8v9ztjiXuZ2T9DwiS1wUbaR4CAE=;
        b=RH/JZBks/hyYi049lyKyPQx5/NAR8JVf+iIQ3sQgYfVRGAKatL2TftszeVgV+kmyCL
         JVylIwMeeaUW0OkCmN/CRcwjHsVwp/cYcstGwLjB0q8xUBTsPlwhl6HpIS9Sq1K6bDdW
         oyQ+DUl4MLgvpGC0h9HVp+L3Oo7pFhOzlHAHDlBKAOmZKgJ1oBfg/mdqjc5DSICP1UJj
         8BB5wciz+4AYwm/GFik84gFTRpkr9xYj8Chz51KQRqA4oaxayWXdmFPAsGH8fEq+20t9
         PHLi4hxmSHbhUZ3iRKgMObohFusMBRoOEriTbuaOyCBxlD8/gDm7sHb6nJHuIYS77kQ+
         0OkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733398414; x=1734003214;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqOu+03vzBSw9jXH8v9ztjiXuZ2T9DwiS1wUbaR4CAE=;
        b=LM/A20Enov25TWoPB0nSbo+m/NICBk1qYqu0wc9mOaWsd2xafJCEKLY2WTSzg7aIne
         yuDEEEByPhwqNAa8RRWaqH5qaA5k08VKrwtBZbUn1xuqmdJrD4ds9qkpoAKIdmCBHvKq
         Jv8EUSyQd187ZegFepMzaZgty1UpEoEBhyuZT8tv+FHlYy1eUx22WGvA3r7uS3VFrKFw
         PuKts9Ece0eXk9HpPruiODcnPJ/BbMhF96ugU77m3WtfuHMN9E/9yuDJ0KX6TSSme9jA
         mSL65vSuiEHI7gF/wcTYlVqzUnSDZSgXbZ3rgVYXrmJpl2VFOPkkQyFzY1/8OpDcR4Fn
         j5uA==
X-Forwarded-Encrypted: i=1; AJvYcCVlgqKSaj6Rwr+dR0hpnQmS3nGdVK8SKrt13PkxmuCPUjEcfZZcwnC0N+FPIZsW+itvEYaiySTn87po88c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTgDckptThv41/OyePhxq2qRNtI+ZZIQgnLCxzwTJ5PvIqTy4D
	E4wY+QcF13vQLGZOrOpTb/w995Zh9fPeYOlUZfulwMO5OirinjRLkEsBey5u1/c=
X-Gm-Gg: ASbGncsefInvRGzBrz3BkM2hzeGJv2H/gJuOEctAuiXDXqmfmml1UgTd+ep/HBcnx4t
	RQuBzPTF3Imo2kePv7LiyS4vUZP/W/gWfIoBMXZgfKIcwgSVPbYZnYSWmn5uhFwDJitnLWABJQC
	qly+D7z6fUa/j/0mIcHa3et6/E1vPwqK6lFdBATQhF7zmXBql0IGQnoW9WGxa0lS28ieA4ioSkl
	xmTw+4XOQtS4lnuQr9VtPgXrnEJiidMand8TzDJBi+2IYS7o1MUaCDfEbmepUOvbuGSbg==
X-Google-Smtp-Source: AGHT+IGaEN5uL07/dBRHUunJUvl5k8sLTxj4oOhw+TYlOs9kGvFk3gyHiA9N+014gZqZ+fX8C23gUA==
X-Received: by 2002:a5d:64e6:0:b0:385:f7b2:aad8 with SMTP id ffacd0b85a97d-385fd3c777bmr3478269f8f.1.1733398413747;
        Thu, 05 Dec 2024 03:33:33 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862229a70bsm1684423f8f.107.2024.12.05.03.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 03:33:33 -0800 (PST)
Message-ID: <9ad14913-e7f5-47f0-84a8-044238cc2d39@linaro.org>
Date: Thu, 5 Dec 2024 12:33:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: codecs: wcd9335: Add define for number of DAIs
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
References: <20241205084021.35610-1-krzysztof.kozlowski@linaro.org>
 <3dd6b0e0-942a-4768-a4b6-50bcc0302090@sirena.org.uk>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <3dd6b0e0-942a-4768-a4b6-50bcc0302090@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/12/2024 12:27, Mark Brown wrote:
> On Thu, Dec 05, 2024 at 09:40:20AM +0100, Krzysztof Kozlowski wrote:
> 
>>  sound/soc/codecs/wcd9335.c | 2 ++
>>  1 file changed, 2 insertions(+)
> 
>> +#define NUM_CODEC_DAIS          (AIF4_PB + 1)
> 
> Several other Qualcomm CODECs appear to use this define?

Each wcd93xx driver has it in the driver, not in the binding. All have
different values. wcd9335 was the first case when this was added to the
binding and I think it was a mistake (including my mistake of not
noticing it during review).

I am not sure if I got your comment or question correctly. I hope above
answers, but in it does not, please provide some context so I will
understand the question.

Best regards,
Krzysztof

