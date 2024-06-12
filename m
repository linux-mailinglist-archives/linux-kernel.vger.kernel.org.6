Return-Path: <linux-kernel+bounces-211156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EDA904DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D5F9B258DA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3950816C86C;
	Wed, 12 Jun 2024 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mJsVsgyV"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F4E16C843
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180081; cv=none; b=j05a0RDQ8a3GOil5zRLm+jfbUVR5kINZlUOJLxmNUMLiQf4b1BO/G8AK+Kg/JAacUXdHl+DuXNxf0+ViHMqlomNws3gyJ+8QyppII/yV+bESGqCykCXVbs0VM97if5aqaHj2An5VQC8rDcCmjQovOPkyK1PrMVL6qt/YBkOegvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180081; c=relaxed/simple;
	bh=JcLliFmzK8Tep6OJhj8il39PMa1YxEJNDlcLj+H3oLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbzB9ipmbbQALIn4XP2zxjSHZ4LnEiDyUlUgoM30gdvO+UJm3E42F/PNoU52JDGpNInvbejIQFGbC2wxDC4cD15H5+fhFqJm0VNrE3R7VbaiTMlw2oUqiGscs7GxCPLYmuRedv7OWFBW6L2wWQayERoyv2XCdlRviBA3ljNFB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mJsVsgyV; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35f223e7691so377762f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718180078; x=1718784878; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1PdksSUg8dwtLunozeU7Sxcg4SfJDpMyI7RXzrJNAzc=;
        b=mJsVsgyVIv8flF+Q0dcteomGAnZB8A4Q/reM0wPvkQjQNPa4/5/JaQSUTBx/BYE25v
         pJvA+E1/DtNBeDlElAAePH8yO7zTJo1Ef+xTBo5lM54uWZt5mOcWJyUbvoWkT8rugF+u
         niPEcxKsAJNT2RgVHULxB+aFG8tNO3HlggOz5pKaw+hRc0z1jrRR0Lcmt70TPfy1ztxw
         pUHp1z9uyqg8apqKayMN/JgO/QarR27+/V8HwvwQfj1QiUAVAP/EgM3Fsw0jt5h3xlWM
         E4Tg37qFlGF4bFc4HvjfZ5/JInx5AaHzkuMn6CREZfGKm7+DzBXjW8lljkQIh4Lw6DVx
         PEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718180078; x=1718784878;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PdksSUg8dwtLunozeU7Sxcg4SfJDpMyI7RXzrJNAzc=;
        b=V/Akj2re9HaW7wfMtifvxzFfBwc8IHvCZZqcjvPxMAVmmnjx4A2qtQ3jVaCIS5qmRI
         3itiYWN4Qx9MemF314VXEAyxLwszwGy3UfY/IsgKiz9cpmGoPQI00ozc4cGtvTV5PcRm
         qH/LVNdNyxhA/3q2pvwtX/Q3ob2RM5crKIy/cwT8hngIEU7u5FqhkbP8HKeC4scQgqmB
         7IgR0RXf2sKTxZjFJncv0EygY7crBxHqb1sK2lOzY98/CBmDFodeVE6rRpy/EuXdzU9H
         PAWsCXB5cfkuzlyu6EE2CpWtYUpZmc5bLQMMiP2J9bMHRlo6X552E6pSR7lk03JgkTjI
         J59A==
X-Forwarded-Encrypted: i=1; AJvYcCU7meLi8yQk5uePydItQK0aAJ0MfeVzaLoAQ1uEQt8XBhmb4a7w1YHyTucTjlUOMTktnsDwiGf9f0mNecsbH4ixAjv/kTqCwhd3fVlz
X-Gm-Message-State: AOJu0YzQN0Zh85sl45F1PibpUERCbgEgtrHyxPyhktIqRyKRaQAG0A6G
	X1jiqjJSEMsNSbiansQiQs6G/y0u1zEnxDoODLhT9UAplPelcpoDaNl+aEuit7o=
X-Google-Smtp-Source: AGHT+IEbZutML2NJ0LZ8NN7NJ/Uudc+CSJQVZMvAjNEH6d/1TWr7ms4MOXRGR4kuhjntdsKXQXPlUw==
X-Received: by 2002:a5d:5005:0:b0:35f:2af4:cccd with SMTP id ffacd0b85a97d-35f5a9da24amr1193697f8f.17.1718180078080;
        Wed, 12 Jun 2024 01:14:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f252193d9sm7240988f8f.54.2024.06.12.01.14.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 01:14:37 -0700 (PDT)
Message-ID: <106b6911-3097-487e-85db-f8de5958adcb@linaro.org>
Date: Wed, 12 Jun 2024 10:14:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: vt8500: replace "uhci" nodename with generic
 name "usb"
To: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240423150728.91527-1-sheharyaar48@gmail.com>
 <f60aac7f-dbba-4cba-8bb6-302b5c911b8c@linaro.org>
 <CAHTLo_=Gg-KN2zOtjOBCxQURq+Ap913Miph2FMhvkoV+GybFNA@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAHTLo_=Gg-KN2zOtjOBCxQURq+Ap913Miph2FMhvkoV+GybFNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/05/2024 06:53, Mohammad Shehar Yaar Tausif wrote:
> On Tue, Apr 23, 2024 at 8:46 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 23/04/2024 17:07, Mohammad Shehar Yaar Tausif wrote:
>>> Replace "uhci" nodenames with "usb" as it's generic and aligns with
>>> the schema binding.
>>>
>>> Signed-off-by: Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
>>> ---
>>>  arch/arm/boot/dts/vt8500/vt8500.dtsi | 2 +-
>>>  arch/arm/boot/dts/vt8500/wm8505.dtsi | 2 +-
>>>  arch/arm/boot/dts/vt8500/wm8650.dtsi | 2 +-
>>>  arch/arm/boot/dts/vt8500/wm8750.dtsi | 4 ++--
>>>  arch/arm/boot/dts/vt8500/wm8850.dtsi | 4 ++--
>>>  5 files changed, 7 insertions(+), 7 deletions(-)
>>
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Best regards,
>> Krzysztof
>>
> 
> Hi,
> 
> Is there any further feedback or update for this ? This patch is not
> yet merged but the related dt-binding patch that has been merged :
> https://lore.kernel.org/all/20240423150550.91055-1-sheharyaar48@gmail.com/.
> I understand that this is a trivial patch and the maintainers may be
> busy with important work.

I don't see you Cc any maintainers, so no one will pick it up.

Best regards,
Krzysztof


