Return-Path: <linux-kernel+bounces-203647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013208FDE9E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC0A1B21823
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 06:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2756373163;
	Thu,  6 Jun 2024 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jUrI+GMD"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BD8446A2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717654638; cv=none; b=h0PWBoJGDHso1SErchzUQ0xtVLss/RZowRmlXAQvhAQ3XdGLDNkF139ejdjPPSdqjL/HvfkTbvTqg1jis/SrfHcH/eIhjTMV/z8Ra0UeM8P1kDO0Lw3lr9zTXlKFZ/4welTqnB1ZxPYpk1Y8FKN/DYGzswx3FuOz4x76djDfIP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717654638; c=relaxed/simple;
	bh=C0ct0YKdBQCtHTXAhsFw3ZTbFtD6rN3Vzm5lfMkHwAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAaK5S77YgvCVEPhojtJuYvvRT4Se6EQIxFnxWo/htWAqzWVO6p6P1akpVoBGzvVtfqf7+lqzvP36U6W4Srkn/1ATNg1hQBEYQzA0pra8e7lR58WOiV1vzyHIPrbfiF5MV/FMhVmyerepx/pHUoDE0MLn6FQTkqP5p9xIPrE3aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jUrI+GMD; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b912198f1so825044e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 23:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717654635; x=1718259435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KgMx57jU555pNqDdwIAzhMk/qFp6JFnYaJ9PQP+964A=;
        b=jUrI+GMD2MGiuMzn/c35VXD8iw6PQP0Ke7w8/9Ip0TN4rTWbc0pfTUsB3c24ug/26w
         i8Tit0TZkQ2SDkS2kZl+AlH+qPXny0kjqtnO2+4f5WeVikezxDpx9/OBagWsAtipvHM7
         dXGlBFM+/I2J5J/ekdCg+kw5YmEbR6LKk4z4yAIA7c0ERe28Kfa0qJ4Z+6eetU5mEuiU
         mMw/bChXKYfTY/6kKV5nJaalNbMxIk9PPQXIHzPbF2KHXORXI4mNF76fGPoxxyMJgsnd
         CbbVZJBSchEUIHVME/4a1LnJjh6hJ+Ybp1dNCHT6kX9J6oljngbIgPPvwVTiDua10fqG
         S8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717654635; x=1718259435;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KgMx57jU555pNqDdwIAzhMk/qFp6JFnYaJ9PQP+964A=;
        b=GFlJxzXQnriG93Cz8CKGgudypgyPC5yc5YHKJ1eqLBWZ0Od8AXsFbqFqyNms6BRVlz
         w4i5mgI0JrMErtdWORTqNryPJ7B1ud0VDENj97wfdzYzklSH+kDf0vSWRr9Nh4V3F0vp
         7A1R+DYAsmbhE2JvfHdSq3BxOyoGOi+tA6M5uyWaoCLZxmOWFKY7v5l1hir77UizptvS
         ZMB/IU0nvLniDInXFj/Pi60sVl/9a/3OyNiuwZPstK47Aes0/ubs1phjYoVmCXZdZqI3
         0Wh/k9IceBmQ0fbE3g3OmIPp9mEp4m5T+Xuem5gZVaXKAS87smYY6iYnvWLDlHOmcfcT
         x7aA==
X-Forwarded-Encrypted: i=1; AJvYcCX5OAmBIZHN8zKzQ2Ady7NB1htJrkOZCMNjumQJOWebULctINbEWKXssy5rS4/aW7pndD8EZpinwKkaUJtv2mWoNBtbbuqnSuopEOfZ
X-Gm-Message-State: AOJu0YyRd6wPHRS6TeQuNiuAuC2A7PK0De3zzNK8dMxN2/Pu9PwHrtCZ
	ts/Io+VW+dapPm8W845YAvZW7hP9mTNJCOJVGWlMJ7hC7UHd002m/0h717rjEBURye9bjEz3xwG
	0iS0=
X-Google-Smtp-Source: AGHT+IEJ1+aXaaDJ9r2AicXCYcsFUtrjrS2XYFqlQB+bMprHpNAjJ0IyYbZnvrDNPYij55MaO6swLA==
X-Received: by 2002:a05:6512:48c6:b0:524:68f8:9566 with SMTP id 2adb3069b0e04-52bab4e2a28mr2592429e87.30.1717654634601;
        Wed, 05 Jun 2024 23:17:14 -0700 (PDT)
Received: from [192.168.2.24] ([110.93.11.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d69917sm655381f8f.62.2024.06.05.23.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 23:17:14 -0700 (PDT)
Message-ID: <979b8f74-321d-4b83-bd3b-01643b3cbc35@linaro.org>
Date: Thu, 6 Jun 2024 08:17:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 4/4] dt-bindings: net: cdns,macb: Deprecate
 magic-packet property
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 Rob Herring <robh@kernel.org>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux@armlinux.org.uk, vadim.fedorenko@linux.dev, andrew@lunn.ch,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, git@amd.com
References: <20240605102457.4050539-1-vineeth.karumanchi@amd.com>
 <20240605102457.4050539-5-vineeth.karumanchi@amd.com>
 <20240605154112.GA3197137-robh@kernel.org>
 <241cb8ec-14c9-4d7c-9331-2df0b8bf21b2@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <241cb8ec-14c9-4d7c-9331-2df0b8bf21b2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/06/2024 07:13, Vineeth Karumanchi wrote:
> Hi Rob,
> 
> 
> On 05/06/24 9:11 pm, Rob Herring wrote:
>> On Wed, Jun 05, 2024 at 03:54:57PM +0530, Vineeth Karumanchi wrote:
>>> WOL modes such as magic-packet should be an OS policy.
>>> By default, advertise supported modes and use ethtool to activate
>>> the required mode.
>>>
>>> Suggested-by: Andrew Lunn <andrew@lunn.ch>
>>> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
>>> ---
>>>   Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
>>>   1 file changed, 1 insertion(+)
>>
>> You forgot Krzysztof's ack.
>>
> 
> There is a change in the commit message from earlier version,
> as we are not using caps any more, I thought of not including the ack.
> 
> I will add his ack in next version.

And where is it mentioned that you drop someone's ack on purpose?

Best regards,
Krzysztof


