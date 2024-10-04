Return-Path: <linux-kernel+bounces-350813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA53990A01
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFCC28409F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3591CACC0;
	Fri,  4 Oct 2024 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S/kFGKA1"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101D11CACDE
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728061921; cv=none; b=uXZjNKkuOFfrK+7nDTRdwqvvNez5a0KWKA018Hi11iyXZHhVCegL2e2L2nGEA6qx4/9xHxe2Ql85Kr1/yzAylNLoMCy6MwOcL3zO1kzF3KOCcEoF5R25vO9rLcNhqxk6Jrb7KE59YrdHmD6pYuxda7j3tPhu8QMTt7RhhXlansk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728061921; c=relaxed/simple;
	bh=FbOJJOM3C21piIGCEoT1PnIBWiQi2gJhK77KWad+6OA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGFfxuLv3muJduZjXm8aZZ2jwC8ysD7VsrFT03ZTi2csvdgwGs8w/A1dTd7VqxLIwUdnE1pSIYcXO7gJYi07JexAU2LZZgK6XCX6+4WWXiUG6XH4vt4Q6No14lA6TslL7BOvnjpLnkYCTw4rXSdWx/XTtZEyx1LKBpd7EWiarVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S/kFGKA1; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e3bda8b6fbso894622b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 10:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728061918; x=1728666718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DX3a8LNIL/T0dZCq6vj7iBGRI8KMTX6Fm4ZrI6JYfmM=;
        b=S/kFGKA14MxQIZSvRa39AHTauBdF2HQuFqOEFtlnj7YePVecpSsWiOAALgMPqkXlKA
         F5eatWd/I0QTtrPsrai1aI7FIaqwU/duKNwT8fhAH9zEO41NQMxCw6nJDPbZ0O994rfJ
         Osid1m8eRLTvD6avJGfi+Q4mBv1USvi5ZrlSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728061918; x=1728666718;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DX3a8LNIL/T0dZCq6vj7iBGRI8KMTX6Fm4ZrI6JYfmM=;
        b=lUwHy+upuga+bU97V/z4BEoPAQO7cWSTooSw7MKvJde/fCw2gY1Ho0OFAwn8p1LA1X
         Wte7tBvzpldgNd8y8bN7MpRh4f2vL+EdAPeZZR5gKcJi4ox+N2dkupvd0RI2m1RV4LJH
         hgRUi95aiAF2zti+Uc6K6FLBixzVlveZwdmix4Xi6X8p1rt4+8e6gRUrLG8crw70dRA/
         PYDAnhYiDcbqa1ymq0jt/hy8G4VdhT+dXubW2V4tuRl/R8gNwZ0dLvFRoPqiqAejWIpU
         hoAFhBL65NT4qXUy3DhKyJfe6leOgj4aPgPPaNOzSy1yxSYA2yu2tt6b5WC4KNlomESS
         HxOA==
X-Forwarded-Encrypted: i=1; AJvYcCXSeSQrh1R805z4P7Qf0zfxCBz0VlPLq7VXi8nBi3hjA8gtHLbhO0tLmp4g/gIdQTCl6oGGxO2HBYi5URo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnnzLURWoPuoKPb/bP1YvoZv0THz54Vza/xD/2WYbI69RiWwKb
	pcpWYxPobUhQuPss+FVvgSkuw7wo1TuhqhscCNoyhNbN4YAUbfY49/mE5gGlAsLHLWXptrO14EA
	=
X-Google-Smtp-Source: AGHT+IHWLXiFheqEvcpcKH/iTcEInY4sqxF3uncfe3L4/zjoF9UnbCLYYIJ6TBQvDKvtCBpc5vzuRg==
X-Received: by 2002:a05:6808:2114:b0:3e0:3b81:6b26 with SMTP id 5614622812f47-3e3c1329c0fmr2934052b6e.15.1728061918120;
        Fri, 04 Oct 2024 10:11:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f683eddasm165562a12.56.2024.10.04.10.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 10:11:57 -0700 (PDT)
Message-ID: <3566d8aa-c166-4d4c-bf78-4bdf652b2674@broadcom.com>
Date: Fri, 4 Oct 2024 10:11:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: bcm: brcmstb: Drop custom init_irq callback
To: linux-arm-kernel@lists.infradead.org
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Russell King
 <linux@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>
References: <20240925173839.29315-1-florian.fainelli@broadcom.com>
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
In-Reply-To: <20240925173839.29315-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/24 10:38, Florian Fainelli wrote:
> The default is to call irqchip_init() in the absence of a machine
> descriptor init_irq callback.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Applied
-- 
Florian

