Return-Path: <linux-kernel+bounces-353914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D07993466
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6B81F22F01
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6B31DC74A;
	Mon,  7 Oct 2024 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LGnKKAUo"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D421DC1BB
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320775; cv=none; b=Bw198M3l22jHn0jkCH+zXXhyjrxQOqQ6rXwe/+anvfX8+2X8Ui0bnW50jBmrxJMd32wLnyJzd40EKk5R6PxRguj+UxoWom0STpUQxfKBd4xHYdNYo/EA5LwQ3J0i2OLcodqrEDjbxm1F6N08uycMe+INT5Bsk2frr34ameCR8co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320775; c=relaxed/simple;
	bh=KKoYN1MZeU4MXV91vF7w1L79BlgJFTuw8OQwYqQLGfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXaj5WygETENAvpDFsv0NdKYP85VkvSzHtYrigWy6z+hLUpXKRVgli49OCL/sFT+U/zsKSoKxjxFSAbYL5FSYEqvsdF6ht5NgS7L3eut2I18Cr1W+jRIfuNDa61GEdrxic8cGXV039/9aP478azxnNrIh5n0w1+mq+SVSavIMeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LGnKKAUo; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e091682cfbso3470839a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 10:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728320774; x=1728925574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w3dKnbp+ul7Hd8TY2t1UblH9+oLc+IM3YRFlz/wkkwA=;
        b=LGnKKAUokT1SoVp5i4iSj0ClQhA9fQNcUFsgktCAbHh3e1JSlJEV1cK8vEMZhO53ci
         LBSHOmg3aOvHMzTl61kxXCpEARU3+JD+cunzkktiTLGY+9awJPl44thxI2n8APGvEEfx
         OK/kYYqlUxRxhOkXoXkUGYdSR1DTwIu00ZPTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728320774; x=1728925574;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3dKnbp+ul7Hd8TY2t1UblH9+oLc+IM3YRFlz/wkkwA=;
        b=NoUVDkHW+NDv1CCeR0ZfB7L2EPioOSTqBo57hBpurOmIJQijgx0NP8uKEuNCTsKs6m
         Zmtu4k+zL/jM+jk1lN342NZz38gT8k3e0VajOpaXVPsRxHkqHv/ydggRuNoTFfBCNnuG
         qLUgisAFpz0SyECox7Bvm4yYV+dJT6q6vdc0JBxERcgolC0cpp0zK+eHXiaAR277svHv
         Qr5UenNWY5d3J/IXoFFeF9qVRW3djYxXW4JB8sXeYw2iYTxZStU+iYQaYEOwNEpmTIZK
         ggczqqjhM9/I1Ny70HN5BS1WDenr6teFtBTotcfv1meNLZNRIOmSyazN+hWVRSwDzez2
         jh1w==
X-Forwarded-Encrypted: i=1; AJvYcCWVkXQZAhanXybFj+DM6nSf7T9tKeh5hIyWGiOu9e59JosSy0oWWRW32xHUyLQIX1IMWaA5AhqXAUeadOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyow8ijongCyDVlMxlq5wymhFSG1htIbjDCNvJXNgS7wA2O85Zo
	k1/Jg2SZogto6/Yx/vlllrZfZDK6cG7l766KzxYHh0i5/ajJLMpHzMiJVasmxg==
X-Google-Smtp-Source: AGHT+IHu0ieKAwZ9GWz0XksXyMokN3WZBcdcx6rzGNoXhpTLFK46e2YKF1n5YwLVRs686AVL1EDY2g==
X-Received: by 2002:a17:90a:6003:b0:2e0:7560:9338 with SMTP id 98e67ed59e1d1-2e1e63222c3mr14612732a91.25.1728320773812;
        Mon, 07 Oct 2024 10:06:13 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e83ca394sm7442483a91.1.2024.10.07.10.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 10:06:13 -0700 (PDT)
Message-ID: <d20fbf91-e7e9-4f0d-8e4a-0c5364f73bc5@broadcom.com>
Date: Mon, 7 Oct 2024 10:06:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v2 0/2] phy: usb: Broadcom BCM4908 USB init fixes
To: Vinod Koul <vkoul@kernel.org>, Justin Chen <justin.chen@broadcom.com>,
 Al Cooper <alcooperx@gmail.com>, Sam Edwards <cfsworks@gmail.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org
References: <20241004034131.1363813-1-CFSworks@gmail.com>
 <172831613316.134526.5485203085922304367.b4-ty@kernel.org>
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
In-Reply-To: <172831613316.134526.5485203085922304367.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 08:48, Vinod Koul wrote:
> 
> On Thu, 03 Oct 2024 20:41:29 -0700, Sam Edwards wrote:
>> This is v2 of my previous patch [1] targeted at resolving a crash-on-boot on
>> the BCM4908 family due to a missized table.
>>
>> Changes v1->v2:
>> - Florian requested this change be broken into an immediate bugfix (w/ the
>>    'fixes' tag) and a second patch containing the coding change aimed at
>>    preventing this problem from happening again
>>
>> [...]
> 
> Applied, thanks!
> 
> [2/2] phy: usb: update Broadcom driver table to use designated initializers
>        commit: d3712b35f3c694cb932f87194caafc714109ea08

I looked at your tree and both patches are applied in the "next" branch 
and the first one is also in the "fixes" branch, thanks Vinod!
-- 
Florian

