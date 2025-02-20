Return-Path: <linux-kernel+bounces-524377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39673A3E25C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369C7164C57
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6918920DD47;
	Thu, 20 Feb 2025 17:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XcMOk1fK"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899F213220
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072202; cv=none; b=dkHMy1rcMFKyQUqoyvZsanPuR5WspUeaQ5Bp5cbriZQcdaOD8iZEbSJVYegngV2ZR4ilg7PSAyyFU9tbB1PJ8JUR8mzOFnkZlzREJOwsEBYCApTGBdyZ7oQUX6St2yzMw9x2falj+CxZjoIQ2cDrHas4WBsOUBs9sCXfrTJ7t4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072202; c=relaxed/simple;
	bh=Hw97JhtnKXny8SYR4ztJSphSmBHJYnbnmdgEdROhDAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mL+B4///9VnNxuPJui6DszTUe1wazU+gfBSCli8WaRfq1xEX9fMg0XXPXFtAyL+tGBWRzQAvIGlkr6tyVKzhWUwfMdSU8oM8/ie64QGe+AlOriZbvd+M7FYOJe/xfr9AIYIxPNzVaqKR49+cKRJF3JckeRbtJtzW/mUaZ9FVaM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XcMOk1fK; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f3fc8f5ffdso301611b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740072199; x=1740676999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KO7H4VHs+QczF3CD8h6LeuqD7FLc0DNQxeiDRPSrHIA=;
        b=XcMOk1fKSFwtiOhq9Sk0y4dPiOkwB8x5ekbD/BlfQzUW0t1wUVUOTKqhwDv17/Cr4S
         egij/t8pRz98rARva+h5SZfiwjgM2czJovP5dKrG7Vbu2U94UnibqDccQDQ+fc+DbgkN
         3nrJ4t4LIZqRBqjWPkB/nNPIB6ZckCliO/ZRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740072199; x=1740676999;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KO7H4VHs+QczF3CD8h6LeuqD7FLc0DNQxeiDRPSrHIA=;
        b=kA7lxXfVvKVml0zWbkh3qb8nbgN73RnCPwbCPJXpgu4Hg1Q+TLX6AKR8BFHMZmgJHq
         kDGKXVn+UNcc7nXPuM9WXyU30CGwqEY0cwFyRAHLzs5/zeYEwV+pflVPeKA9sk3E6lkP
         OHa3pXvM076GWv8ik4lddeHMiRWih7ahLY4jD+Q0FhhD0LRHKFDwsO7ZbbeGzv/NaQD5
         rIHphI5zokNNR+iRskCFoZT48xdlOqHeKTSkBrq5scSe14rLZSz6lmQUIj8sQKISrjSX
         ZWB8v1HECmf5XJMLq9+9uwNr98fcSBE87MPrWP4/YLs3c9f1jmZFtnCjdnrhpVfG4yit
         PMhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaLWZwHLeq1VpGThDYL72eFEKz8jREVDYmExc+JGxFQJJ7VhS4xJzaKwMb2Tvintd61snPguAP6EEFpAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Afo3itfQy3k5XCGx/D+FyNSfZOwZKw/stKCBMy4HrL01XGsO
	Dv2VC3KBgX6fzNzYcUEzMUd3Tv1DH/Og1GIZ7ldiyIRSnWkMOxe+qmxgej7LTQ==
X-Gm-Gg: ASbGncvwB17L/ZFd/g1SB/GeYYF6i4gRLt9H7X2Ksz+PbYGKvkcrgCE6HkxGld5MAZ5
	9Zsp9LHEQ0fzNaN/9X6QTrJCuaG19aIhiL5uy7ibY8zvVt/SzdWxxMPqF/UWZ7ukFRPJS18lirw
	cUw5K0yPZgi8PY25Bzct3fKzADNY9EfMqwUzxO/AmhmECiHMGsmxmTUJFlJ9Fc0Pb2gfhEOrG3R
	oHJzhDecgO0Nev0vR0HbXXWTs66tuRJZ0kcRsGeOQwE+nQA4Qqkkt9+Rhi9cjW0hNi1HSGRdaG+
	oUNl4fFaCmpA2sdbvoNxmhPN5y6fNi7CCIDrxAA99RjcP+MNCSlOfkWV3P0syF5lQ6ujQ9m7aLx
	s5SuH
X-Google-Smtp-Source: AGHT+IFNMmfpJyIfAe5dEZJG05M/SHFALg3tklMXrjbHlFxkP4JFLXWaPkYg6R+CYIbTkwyziA3SlA==
X-Received: by 2002:a05:6808:14d0:b0:3f3:f90b:f1b3 with SMTP id 5614622812f47-3f42469d77bmr204952b6e.5.1740072199073;
        Thu, 20 Feb 2025 09:23:19 -0800 (PST)
Received: from [10.171.122.29] (wsip-98-189-219-228.oc.oc.cox.net. [98.189.219.228])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f40b027906sm1450746b6e.42.2025.02.20.09.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 09:23:18 -0800 (PST)
Message-ID: <89e74137-c3cb-4318-969c-81e5f4a3a778@broadcom.com>
Date: Thu, 20 Feb 2025 09:23:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] net: phy: enable bcm63xx on bmips
To: Kyle Hendry <kylehendrydev@gmail.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, =?UTF-8?Q?Fern=C3=A1ndez_Rojas?=
 <noltari@gmail.com>, Jonas Gorski <jonas.gorski@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250218013653.229234-1-kylehendrydev@gmail.com>
 <20250218013653.229234-3-kylehendrydev@gmail.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20250218013653.229234-3-kylehendrydev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/17/2025 5:36 PM, Kyle Hendry wrote:
> Allow the bcm63xx PHY driver to be built on bmips machines
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


