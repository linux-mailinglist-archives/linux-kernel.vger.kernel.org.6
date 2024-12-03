Return-Path: <linux-kernel+bounces-428984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2E09E15E8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2972F163AFA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF701D5AC0;
	Tue,  3 Dec 2024 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="COjp9zXG"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6641BDA99
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215063; cv=none; b=Y5NUs6JSPoigC+TioaEIQpAgAbPx6ZFeZWC9BHW4FQts8H/kSsUvLHKiyzyqsZZft4/sW2nZZvZaB2PFyvIlzwUFtRk4Iem7rDg96QZ2pUujNabJmaScsx1e1Hk9Xv75OLl2ejxc5bEOHr7scapsYy5AJJNTSJfSntnO+ZCrKwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215063; c=relaxed/simple;
	bh=eQXk4fAin6gkXYY9ucaSAgsUJyLa8K7nn85rI/niWEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XkUj7rQyeAF+zIt2Pww/pvk18ISMeaHpRFqHrZbcEdkDtBqq7wmIaxsVehoqpPXBMqp6e7jmotem1WHEBrC6Ssy23Cqc5DbJj+G/O1RUNj8gX3Pb19XQ4K5XxH5ihU7puhWiZ+7bmpPi8Bz8FOdE4/wj6WzOF4INGz7/9N16nes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=COjp9zXG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4349e4e252dso48807375e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 00:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733215060; x=1733819860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BfKWy1F7pYEgwpS+G6giCP7uqJsq7NFXHIZFcYCqRdo=;
        b=COjp9zXGEXFrjzMMlTH8iQrHcH7+v+4XoGBJt3JXaD+U+xoTDTnUToE13rYxruHw5p
         AjpegoZ6SKJAen2i2F61Tut05Qk/HhHUA73h573bmeivT70k/Dtwug3ptpp409XXJTgK
         knwcbnJmAuet12FbugngeF9okQGU+eXc/G96NAe27yLG9oNB11ldqlGGPIwcYla0BMna
         6T20xCASD7WygyyGRgWZmOmJp4/Zdngm4ytOyKfvpR05vwL+Szum13i9Qao6YUSJHcCe
         0aLTwyNNzR8Rw7Ao58Pq7FDkw9XAgG+IdAN9qRFJmiaDqGkN90tGY6I1rxt3GkA6paR3
         i0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733215060; x=1733819860;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BfKWy1F7pYEgwpS+G6giCP7uqJsq7NFXHIZFcYCqRdo=;
        b=WKZteURpYruu9Lym2pYlxQm8AMT4MgpMbp1L2RI8hsMwzA+mcqkidfIBIiU30nADHo
         xZzVo50ZFCYg8FIoIEMew6/dN2zViiEYUb4kWauFB8bZd3QZDa9Eri0pyLZouZsBJ2v5
         TObfr73aCtS616MKSUBLRk1F0bMHx76Utu6B/d6PjZIO7pr8ITz+nTBhA+nbSAFzLxSC
         bbZztS0cGoSWSKk/YMjPhLf/sVzcaoa3eyR06aysNRuf5VLDYRwzVF+CvTgKabQ+0K7z
         Nhl1ROHdswT3VG82D4p/+TTysl+a8w+OX0SI6KigWse69mlQgY3WOGfPTOMVgFT+HobR
         +VcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSCZsXypwQNnDbMKrrrzwisEMDdszZh+PUvWuP7ZyulMj46RJ6NlEzXpnitrvZ1NUB2rv5ffi4RAKXiQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgM4Ninbe2/SbEg1Sp/WyviOC7kUFfMQtNqvQ1plZbBP/D9oUm
	fVKALa4fPsUPplzMpLBu4ZbvbFTcnbbke70M1LmQMuelXJ65iPEQrNanU3aWox8=
X-Gm-Gg: ASbGnctgrtvKFYbUfNN81ueMN9wLC1x6wtafx5giaP2RlOsGN6BPc764Fxtqr28hkjR
	aYssMNszH/IH69KuxrBofSzBp88V9/cTEtb1+unupG3uJIGD7Y4tEJtqRh/K+K3wPgn+o7bxDSU
	BlN3RKzlNEckXmOyIDTksfjAwSak/WlNfUzeSQuDrFr9lxv9YKRtRR+ztJwq1X1E5r77cnjj+KL
	flFAmKNjmy3IVceFPGg301Fh96Svzq53LMOiBzXkQnzJsP9cp3O2FwhzNw=
X-Google-Smtp-Source: AGHT+IE3H3bcSinK5Q3eRdpnA47MzQBNmGfvbe9r3ouVy8hLnAWthl84xXpTMD1MB7r7vaAGmTp6AQ==
X-Received: by 2002:a5d:598c:0:b0:385:ea2b:12cc with SMTP id ffacd0b85a97d-385fd3e779bmr1474754f8f.13.1733215059572;
        Tue, 03 Dec 2024 00:37:39 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f32837sm184681645e9.33.2024.12.03.00.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 00:37:39 -0800 (PST)
Message-ID: <b1e053da-04dd-4b66-86c4-60e1d6b5a5a2@tuxon.dev>
Date: Tue, 3 Dec 2024 10:37:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: microchip: sam9x75_curiosity: Add power
 monitor support
Content-Language: en-US
To: Mihai.Sain@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
 alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241122080523.3941-1-mihai.sain@microchip.com>
 <20241122080523.3941-3-mihai.sain@microchip.com>
 <2d8dd1c8-fd4b-4dc1-ba62-312ac86335a6@tuxon.dev>
 <PH8PR11MB68043702680864433060E9B482352@PH8PR11MB6804.namprd11.prod.outlook.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <PH8PR11MB68043702680864433060E9B482352@PH8PR11MB6804.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Mihai,

On 02.12.2024 10:32, Mihai.Sain@microchip.com wrote:
> Hi Claudiu,
> 
>>> +             channel@2 {
>>> +                     reg = <0x2>;
>>> +                     shunt-resistor-micro-ohms = <10000>;
>>> +                     label = "VDDOUT4";
>>
>> On the schematics at [1] this seems to be named DCDC4. Is there a mistake on
>> [1] or this patch needs adjustments? If so, I can do it while applying.
> 
> I just wanted to use a more friendly name for buck4, since this regulator is not used.

For consistency with the rest of the channel names and the fact that we
describe the HW though device tree, I would keep the schematics naming
("DCDC4" in this case). No need to re-send, I can adjust while applying.
Just let me know if all good with you, too.

Thank you,
Claudiu

> 
>>
>> Thank you,
>> Claudiu
>>
>> [1]
>> https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocumen
>> ts/UserGuides/SAM9X75-Curiosity-User-Guide-DS60001859.pdf
>>
> 
> Regards,
> Mihai

