Return-Path: <linux-kernel+bounces-549805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BC3A5576F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B183B49D2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BF527183F;
	Thu,  6 Mar 2025 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LiozPQ3X"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B6726B2AD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741292959; cv=none; b=JE1jzXoMHk2LG3kiMQD7RPNiYay3bPlCxMRaErRCbmB8TyWdc0iuIDj39gOVIAxNYdZzTs+T4EPGlpiEf1s9NGS8rhEfTlfhd2+fZfPp7cLU7wsa1ACp/UPJEe3l4+UuGXVUfZnTRukmA8jgKCX50I8T6mWw7NjzBWLZTHRgsUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741292959; c=relaxed/simple;
	bh=ZTLwpK1ShAoyoE7eNgul2ozEQiyT73aGcq8D0LgSGt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQfInEFylNWLZLZFLC5AEoIsgCBGgSEXPWInLzbnnO3V+eg7CgdnYz2bdZiZ3BQ/mMBEflHcOqG9bxtBaoqLERGMOjkH0O8nV3jNzvL9x4CKqeCdvOyy591h3nVc9NT5Z33ULoCPWa5PSh9fVPnH5k/COldXzGoC8UBTbYJ2vu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LiozPQ3X; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f6974e54c0so170878b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 12:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741292956; x=1741897756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ac0I4yDNXoY4QOTqvycsgq5oyxB+yg+8dfa98buWz6s=;
        b=LiozPQ3X28KTcQAz+iKEkHgJzoHWKfITtePrM64O5QX2JlTHmT8V6nUCrMeteo06zp
         jyQhzc9HJplXL8VCgOzgzQZMcgZ6csBUM4vG1luPBzVX77pD+wTOh9gLC4HUwOm6+NUr
         a+XQ52ebk9PUetDXLR/OScrPtil6Q2IkuhlRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741292956; x=1741897756;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac0I4yDNXoY4QOTqvycsgq5oyxB+yg+8dfa98buWz6s=;
        b=SjBCz2HO0YwxAi1dkK2LqEq/xw31ZNeKH/ZjJnyus8LbrJ67NiLokO+RvtE9oQabGq
         jhUwBV09GEUTieE/0SEwIP8dFZ5VwN5ZJjOSZsgjcxOGil77umEd6+xxx146nkHBpvgo
         4iJ3XgfG997ogIR1gT1g9BKxuxgZId+2QrQhMRswuc4mUkYK9MTiIbuwqVLlgBgeQW7d
         KiPSSf2yy2NF0U+y/S+k7OGtdQSSZ+bseYNnraMgg5cmlqRuVefVijxrRwCwnISNiYXX
         XBYtGdS9Af0zI440SKkF4SlcutZypqPM+2Vqcd1h2tLe0kGHjXHgPRdUc3ZBtbVQGPwN
         +87A==
X-Forwarded-Encrypted: i=1; AJvYcCUtTVS1raZTk9dzUYUxzkOwErQjwZ5nuQGZdLqevp7x5RG8FRjwKJ7MgHma50IXayZtXkV+H/039128RoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw2iZ1I5TRCJchmIWWqBgtZCzLYiUt4dICRCR/eZW45VNWjMoK
	Bxim8+HDxsQgtNa2GWR8LciYj1ZsOesCgwK6WJbmrlmsNMI661UCowcjXG87Eg==
X-Gm-Gg: ASbGnctmVvyp/L4vVHcFyi10LoaJR/HjKEHIRVCSt2aKe2uwCbbNm8LezbvLxWxjVVL
	+etHJuJpCOG8fPYSmsWBtIwbClVpvaeTNcY/E9Ecj0syvs+YKSZjTRU0gMmTYyjNq/5dHvAUFdG
	QJeV9Fke923xpiekgZm9wHjkDBAhKDS9u00BYMsxEnc8niLsrqRbyw3XemsMOCmjfT5fDvsOpfS
	D193dwseePkd+Ec3bnsgdmS9U+g43qMX2Edm30dFlfjRxTVmTW3T/aqiRSMMBJMppysxCy6tzX3
	lKfBlZBm5Y/wrYpAzP76nFTuFu0UAbZVnw8RZcFbOF+7bRDMGPCC90O5Pu8ok91TJ44EgV1UVzW
	cs9AIP7XV
X-Google-Smtp-Source: AGHT+IEswOzH4JMeJnomezEH2T0YAK+gU82fk6g5GKFLe1SmLEakRtMr9P3eqfyaM3i18imUIEKfKA==
X-Received: by 2002:a05:6808:318e:b0:3f4:1197:29b6 with SMTP id 5614622812f47-3f697afe355mr618902b6e.1.1741292956655;
        Thu, 06 Mar 2025 12:29:16 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f68f057194sm384916b6e.44.2025.03.06.12.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 12:29:15 -0800 (PST)
Message-ID: <e85b182a-ce69-4303-b401-a646139edb8d@broadcom.com>
Date: Thu, 6 Mar 2025 12:29:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 14/14] net: bcmgenet: revise suspend/resume
To: Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250306192643.2383632-1-opendmb@gmail.com>
 <20250306192643.2383632-15-opendmb@gmail.com>
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
In-Reply-To: <20250306192643.2383632-15-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 11:26, Doug Berger wrote:
> If the network interface is configured for Wake-on-LAN we should
> avoid bringing the interface down and up since it slows the time
> to reestablish network traffic on resume.
> 
> Redundant calls to phy_suspend() and phy_resume() are removed
> since they are already invoked from within phy_stop() and
> phy_start() called from bcmgenet_netif_stop() and
> bcmgenet_netif_start().
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

