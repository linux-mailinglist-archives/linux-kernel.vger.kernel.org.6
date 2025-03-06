Return-Path: <linux-kernel+bounces-549796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA08A5575A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA91189760E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7229427701E;
	Thu,  6 Mar 2025 20:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J9l/Uijz"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706D0276052
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741292232; cv=none; b=ofIGEuZcjm41ldT9zDkqIZgPdt3BMTQV0n8OArsrg7eRgkOM4hAitYmaeF1u8knPDDKZAMzWyewqgqy3DrJbgVeWmqDoQLjfRffmYfOgpXmFXWru7PxzIm63fKMqxi6UZ9HufydFZ1/h9KZvM+z5xwVZzr/UY8i8cYZf2+aq050=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741292232; c=relaxed/simple;
	bh=06FhvAeuepcYq1hoim3lqG9x2jYnr6RjXEq4/G7992I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoCtrzzplEsUaZY2BFmJgpLQtgrFoLAIcAlgLm9U544CXnbH5vpIao3TntyBIc3WPgQBWFhu0zVj2nnsJ7vItN2doLsX0J/nPtWFpjnio1N02V0oI3wEolVgjsneuHLuvA6VMhVbh03YdNzTYubrewE8EeN6f3Rr51t/VT8wVcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=J9l/Uijz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22409077c06so23841455ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 12:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741292231; x=1741897031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LYtabAXpFlLUqMsLfTp5Od2Wh8N47LfPWDsj5ld6WxE=;
        b=J9l/UijzdJwS87x/8qdI1NuioD908cVKoTilSGcHjR4SUMM0Ka5M2U6Jk6vOEC9SXx
         fr3PNO3IyttIZdfJQ1fcsAV6/nujOPko+mHPX8UXogrCJ3o5mkyDA5+KT2GZRbbBewCd
         BxuKDtLliYqFwNdjQALljZ5lc769MdNENmok4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741292231; x=1741897031;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYtabAXpFlLUqMsLfTp5Od2Wh8N47LfPWDsj5ld6WxE=;
        b=Snut7erJNx3pDpaej5bNG3ZAqke18a/HLmIkrGP4tWjWg/KYnUokDl1iofnrQmNfsC
         Kf5nBO0ZBAxWF1Ol8YWdJFwqszJCTYnmkU1ElPttuG5ezXvaEwe/lBqrmW3l8vKJ6m7O
         DbjnuSAfKe6Xs/HE7HLGUvjoaMYZJ/UOB7De5Frt+y6GxbGog0IAzY890QWfi5x8ZNbW
         Lm1h5dwSoPI2WaBD8/z/ePcedQxFRcMFxfmGbIsPSzoxAanJ8yRjdwQB8ZZfnhU3bSDw
         qlAQU1UQW+PTGAF1xMDvVXvfOlC4xhuFIbV/4lm9CSi6Z3frjBqgZGFtyspXw+l2K0H4
         ThVg==
X-Forwarded-Encrypted: i=1; AJvYcCWDm49IUi/UMSZ+SjfJrR/cVdTBALFiJnuwZcXhp4PO2otmeIUrkE72cVGnxNlubcAQ5Wx8N6UM7bKbb44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2eK11e2jQnyqgjEx7fV8udQS0eaC+u5KyIfgPs+EP6vXCDa+w
	YGIdhN8HR2gv5vUv4j1hMV82mu8O95iG7yOgsYfzcCzjLEK+MoJcMV9ZIQyQOA==
X-Gm-Gg: ASbGncvwi0MFxFDJK3eZgGT9rP2hzXXmGgvd8zvhLAwfRZRTRF7A6fdEnW0bmJaoTc5
	aHmccoJC5Ch2bMUXgNKVIjDlWAVfluI2cglc8YcoIhEcw9Y/FeiPquVCqBFNlPE9jKnOQywwIf1
	REu0FB1hLBAtzQtDx745P2WW1ozGr6uLhzghQR4KRWZWK3/cRNZPY2XUXwRGo+pzUmvWYHePQOD
	nBhvkvIZTbVoTTNNFU/JJyWdfIrrk5BrBVfPare6oQiXmkZ2hl3cFQluYlgo9SvO+gyM9A6lrGw
	lVNjj1z8x88VhoYl32r7uBQff+mG+Z7vAThj0NyyXThqYm8sDcYKfxYvVWmHz/KFHJnB1aVHBAe
	97Fx9odck
X-Google-Smtp-Source: AGHT+IGDru6yfTnBaUZ9w6bQW0setOAoqCdfMrFuD5V3RlxiVqbQwEFaTnDGXAke9NQrVT8csqDPpQ==
X-Received: by 2002:a17:902:cf07:b0:223:5ace:eccf with SMTP id d9443c01a7336-22428a8cdbcmr10624285ad.25.1741292230779;
        Thu, 06 Mar 2025 12:17:10 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e974fsm16714255ad.78.2025.03.06.12.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 12:17:09 -0800 (PST)
Message-ID: <0adebd9f-5e92-4446-a4fa-36959e7c35c8@broadcom.com>
Date: Thu, 6 Mar 2025 12:17:07 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 07/14] net: bcmgenet: add support for
 RX_CLS_FLOW_DISC
To: Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250306192643.2383632-1-opendmb@gmail.com>
 <20250306192643.2383632-8-opendmb@gmail.com>
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
In-Reply-To: <20250306192643.2383632-8-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 11:26, Doug Berger wrote:
> Now that the DESC_INDEX ring descriptor is no longer used we can
> enable hardware discarding of flows by routing them to a queue
> that is not enabled.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

