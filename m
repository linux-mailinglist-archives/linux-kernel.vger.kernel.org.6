Return-Path: <linux-kernel+bounces-517052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B85AA37B65
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A1F16BC6F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AF814D2A0;
	Mon, 17 Feb 2025 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ifibiV0g"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C283418BC1D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739773943; cv=none; b=G85oS2tjYDJzWyIQ12DfOV1wcmlO9TBtpNvV/arG8aUIL17Ifhk5KF1DPmn816/6Vf6kObz5bBo4vjY2i5FTZ3nTTNZ97r1CER04BKUwqg6VTJCuQbU6XhX2Coogqavu3e+YMIZArkQwUavBMoGT9i3zIkozGwgGtSG5qwdYXVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739773943; c=relaxed/simple;
	bh=A7IRtN8hL7QiRgZjNciVRBb2qAyw0QTuXI/KIuAzjG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5/f5PFPuYW9B4BW9mckDG//Iymker8BuexmQpHtOknVWhLkMfwIl5f8f8w3htDNH7nZ71gIoIwxzy3oON8ji9IPDChGXUVWiOfaCvKFfGypF5GyJ7GylwfCOfJRqjLWForvK9puK9Qu1/ZEdTOfgfBtjGv8HmBoup4kY7l4qGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ifibiV0g; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaecf50578eso784996366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 22:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739773940; x=1740378740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A7IRtN8hL7QiRgZjNciVRBb2qAyw0QTuXI/KIuAzjG0=;
        b=ifibiV0g7bJdkgvAiqF8DYCIgCCATfz1J8pdpRbm8999AT0/lYIa1XReZqzBjjvPRC
         pIDgAmqzPPDvVmvxg4lrrepY8LIfhdEnoKqim6CFo6NYZX4vMrG6cO5sQ33L+B2/swFR
         lSy6FbUWvHoegAsZsZTA0xk8q7Sk2By6UzSghtOIvTalgSfKfXaUd/lhCzLqVILH+9OX
         SBexvFT3a9QRnUk1Qp2gaVka9nrzUHtnDF34Qek8DBanYc85/nnoLKZeMLOX8zJ7iyef
         OIlIxnRND7e9iwBVoPvR7CZXqxAesyKJVvl1DwbvaRc/zP6tH2ZwEyu3GUmN/TZlKfUN
         2vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739773940; x=1740378740;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7IRtN8hL7QiRgZjNciVRBb2qAyw0QTuXI/KIuAzjG0=;
        b=VNoAME8nJrSxxmu5bHPs82bgRLL5CkmIs1d5iUtxSiEhOxEq6bt22MMdeh5V2IZSpW
         Tee8NcMRP7Y63iAVIVNMwTxVbOtWDDjES8AeQe7wzt/Gcu5ifHRZkw8oKjeSv3IQ1I2V
         PAa7gtpSF6D5r4XKAfgQ/p0tL01jy8dkTlLc8yOmhlGssTwmkE/lbRHMkwFRWQWUpxXe
         Gd7cC9obEHxymrU85x1o6bkBmZzBEKTvoF03n4tNeRpPyuBb+Y8qqZi2L7uVCVPAZYmf
         sTjpKheK4RQ0bF2fjUnNWsQgPiVw+l5zXmEENAPThQBXsTji+csjtmc6C+AzaVIYK6Ac
         pKZw==
X-Forwarded-Encrypted: i=1; AJvYcCV/8rBJXkf6+VM/1rXr6BD8qZBWfNbLe+VcKS+4IkQw802khbZdYcUW1nP1GsjonoOPglGP1Oe6/6z6BAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGc6ZeJEVbsADkxMr0eiDynlR63ivlDO+O41DPKZEEHEFNA4mZ
	f9S5KFBeWsFl2lqbZEX8wS3E1dBVbWN6Rm2LUrq8tm52H684G7Ecybmlxt1PNv4=
X-Gm-Gg: ASbGncsEiWyck2GYe9DSJKhAmbeNwxh7EhYQYVsGjcMEpBo7hZgeQbDRwakIaEghyZc
	+Ui4KhoZSgS5+cqy955jVpW0zcgdNBrLINtsyW/9lbExDPBP7ROmtIcqjMbA4D2Jr259ifQBkCp
	suF14QuNk1uW0BJS7hQXj+clULQscKB558fXTyXKKtnFNh1M0YDuLfoNZ211G8RdPUkF92WIjzX
	6x5B1g2SdrfLsGxfDJJBGb76I7f6gpe5H/q7EV5ygIJIupVudbMR3OJNd5x4T5JMvRVr4Apnwgt
	U1Rtt8Q4ykBSbz/wJ9Z+X8U=
X-Google-Smtp-Source: AGHT+IHc3CgKCuw/Tn4up00Ngrqvc2HyPAuBwXc68KPmWOuZltnaa+t67OP6B/OZ8Mij+qQs5NbX4Q==
X-Received: by 2002:a17:906:c154:b0:ab7:d10b:e1de with SMTP id a640c23a62f3a-abb70a957aamr879561366b.13.1739773939801;
        Sun, 16 Feb 2025 22:32:19 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb86c9320csm315074866b.55.2025.02.16.22.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 22:32:19 -0800 (PST)
Message-ID: <75a6f8b9-bcfe-44fa-897f-6b800000ef10@tuxon.dev>
Date: Mon, 17 Feb 2025 08:32:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: sam9x60: Add missing address/size
 cells for spi nodes
To: Alexander Dahl <ada@thorsis.com>, devicetree@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "moderated list:ARM/Microchip (AT91) SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250110144159.379344-1-ada@thorsis.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250110144159.379344-1-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Alexander,

On 10.01.2025 16:41, Alexander Dahl wrote:
> Complies with generic spi-controller and atmel,at91rm9200-spi bindings.
> Fixes dtc warnings, when actually adding spi target device nodes on
> board dts files including this soc dtsi.

This is already covered by commit:

f0127f66528f ("ARM: dts: microchip: sam9x60: Add address/size to
spi-controller nodes")

Thank you,
Claudiu

