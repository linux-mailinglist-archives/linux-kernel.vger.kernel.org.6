Return-Path: <linux-kernel+bounces-280417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7895A94CA3A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B288285144
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 06:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2035716D4ED;
	Fri,  9 Aug 2024 06:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AVfiVP6H"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A8617C98
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 06:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723183875; cv=none; b=qgRJTLbUhvTYQlq0WRxiPyARC9q2Y2+8G5GfaHLHtWeU/evhz+J2h/5s9443YqfNAsSYBozSx4Oi5YbDfCWVeWcCRrevrYD1tPKFw4RGhaUOIFTamOadTG7wz+qi68ZUnHrWDMO5qR9dn4ysjAMEiV06OGWWYyxm7x7a1i2dR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723183875; c=relaxed/simple;
	bh=DK9wHN3B3sjbgIF/cgn/lP24QN2ym60nTyxuZgAVStc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KniDAi4vPJ/oseImh9cp6tjBmLm/JVF2FOj8qZE3ZVGF8y9XKbKAarv3ACr3ToDky1TXSi3hh8ydqGEtbxxD+xSDCyMOmm+f/kRJCl4DtAMznUjVc8EGaGrBJ6zqRyrIuqtPzoLw84wcY3sUjmSuyApVzILP8D2BUVX4iWyCaxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AVfiVP6H; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so2236626a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 23:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1723183871; x=1723788671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N9PyhnKMVWQaCf4o2NQtMNkal2Q790c3esRFssorUHc=;
        b=AVfiVP6HNPQ0O/oeIEBqRjsPAXkAQSnC2PJFmzq4L89ke9T8yqLmESYnXz3QUJO29+
         n+gFCcFsdIgdU7OUNmKmIOPTfDb814JgC6D6+HOnyzgcsfcyKTU+z+66fy5K1CB4VCJ4
         8xbAlj3zCSLnng6Ia6LUqGcHVdtLMOQ0YhVtV70uZWpD0kwBvAtbO3HPvNSL+ilZyzCC
         GOKZWAAU2yRGJjDLRKeBV2C0l92zr0glSWW4xgeY0v4q0+xvqZX5uX9X/gS2h3IjTE0i
         AKsxFNIop54N1QuWygubx/8Bihau58plpu4O+CtQ1N1/T2X7dsPLde2H0anT7xXiaIuq
         RN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723183871; x=1723788671;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N9PyhnKMVWQaCf4o2NQtMNkal2Q790c3esRFssorUHc=;
        b=a6xG15p1cCGuB6Vmk/fnVS6B5Vwb8zlNbJbfCTI7k8eO5/chorA7p8QdYV+y44ekjY
         fnGbLRuwX6dHMYtkZrEoyr4s7U1QHAHMHz6t7QAT8i6YwopUBfVtWzo2uBd8Gou+uNf/
         yBAE1iCmRhH/GYk26cv19Ex7sNJsTIeyYfXuz4HSvBXNdGPec3NiAGnesbpvBju1NY3n
         IruvA+9wp4h7e30x20eMMqhZ/G//D+PCPECchz5gyDf/VSqCjtY9o4unK3+BhYv5TwJ6
         96gntUlKO1N0+9+g5LaK0QjwQn5oc5n/GJ7/3aujfQiJFxRzhImTZUlMYWl3pe8ZX72t
         oLEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoZnA9R/oDYQvMhcRydXeLXTDmZtvXxWP+SJQBRqattPrn8MC0X2qNcRHq2+QDxybzcojVpQIKKVeWUmhbg+FPhHtf6zjeTfOXRfnU
X-Gm-Message-State: AOJu0YxvunvUel+wRbmXkaLe+TQqvw13+e7Px+fvCM1m6RPzoxDkC3m9
	fdS59+NQVdYJKAMoB8Zz6RXyJy7NUcf8Rdimmhj/4NfzxM8w1H+LiNY7k8jKZK4=
X-Google-Smtp-Source: AGHT+IHLST63qpgl3Ee5cLbJ2wBmYq4bMRL0nCYZftLPRBUtKZ73yES2yg3rJsqZ0uhQnU2Ve8UHIg==
X-Received: by 2002:a05:6402:234a:b0:5a3:b45:3979 with SMTP id 4fb4d7f45d1cf-5bd0a56cb16mr423549a12.17.1723183870917;
        Thu, 08 Aug 2024 23:11:10 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.180])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2bf95d9sm1245136a12.10.2024.08.08.23.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 23:11:10 -0700 (PDT)
Message-ID: <5f45e6d4-8e6d-4ac2-a926-88c123e4cd26@tuxon.dev>
Date: Fri, 9 Aug 2024 09:11:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: at91: align LED node name with
 bindings
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240701164952.577277-1-krzysztof.kozlowski@linaro.org>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240701164952.577277-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 01.07.2024 19:49, Krzysztof Kozlowski wrote:
> Bindings expect the LED node names to follow certain pattern, see
> dtbs_check warnings:
> 
>   at91sam9g15ek.dtb: leds: 'pb18', 'pd21' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied to at91-dt, thanks!

