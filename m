Return-Path: <linux-kernel+bounces-353995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6019935E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA4F1C23A3C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE53D1D7E47;
	Mon,  7 Oct 2024 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b4GlOX2j"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFF513B58B
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728325050; cv=none; b=VwULfQtez/+JVcOVgV/ZyzzKjMckUfFLCaTt2H5zUYmHYigFLUtKm6KEYh7Yoa4jgahWgipSqLE/2dsE3aX8BEoTVQBx60YWXFefOqZJC6i1UTKZlwBes2lUSC3lvFqMrxPXANABUqPsVY0USECTuaDarxZ0BAUF7AvbF9M5RkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728325050; c=relaxed/simple;
	bh=izpYAusTqS8MWOqc/2zu7+cI429VBGhjM4QmpEE+0BQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4fP/qlVxoime1LAHZCB4k/OdwOQlky53zOD1RTBYD0nsNy2xOiciL9KTcjex+zq8gfcrwB9Fb0PtYeW2ce7904GODEPNif1MSthRzZfTvxUf1F8P368mo7pFvA1FPMuoJCt9uNzAxfu0fp7kxGkHw10mjucIgMuHd5JdbaImFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b4GlOX2j; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7ac83a98e5eso418763085a.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728325046; x=1728929846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UbsFDaR7v+/oiyxl30AahMevLCDbWMg7zXOhg9Y+w/Q=;
        b=b4GlOX2jWEUS4LeTsab17cTCTqPaSIXb5BfxyOFZXFXqUn9lk7gt9JQ8AWhx6voQbg
         n9hOdqyCrVw6tpIFagzbt6kHxHJiN5tjVGs9ARapIQ/Mk3mxkztGK62RLonoIJ43257s
         /SKQZd5i/V6fJukut92sBThbTSp+aXYuCEiR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728325046; x=1728929846;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UbsFDaR7v+/oiyxl30AahMevLCDbWMg7zXOhg9Y+w/Q=;
        b=AUCTRObOzFScxI5oBiuRBnYXpjkNBHOKR2cdoOLV9eqLkTGZVeFq9vUYPyPAa5i8ew
         YuDSvf+efC7CqlM/3plKuI4Erwu0ZXpejEZUpC5iosTaTcCb2ZYHlG3YR5Y5NsOqHz1x
         eGI1x3Wqu4RMCMisRg6xaFmYJ1MkGRRlgHX7Vx6AkDW/du3q6QJFBCvx8j4uiimcVWwt
         RzZkDJsJgQXPpbqplAHPi98Q5yWyEzRYk2WGCMCsnn33tEKt+pBHha/lzNy9ea0vfzkV
         OPMPuPR56sAPsyLidON5IpgD0UEm1V3LSeMrxU35n+GjIknOQwOFYbTknpSmAUMjx2cq
         tI/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVI5lq67hsAUXXlCTKN7FKWb2ZnPI8NGEQf4U6C1d9z1O16S4CadYZzb2nA3df9CK4uo5AVD9/gUCSvBy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL8MAY+zHCyO92zutlpqpGMUlxVt63viHNlaNPfOBfA+afNGsS
	z8kUeV3edK5LovfJOemK2iug6UnBDAlNF0zZK9AOL/gpU88CBB+gZD1NAkSDDQ==
X-Google-Smtp-Source: AGHT+IFj3PM7fVXOu4zxxkXitcx59F4uG6ddCEWg50DU1XSH206HVA93m1BnZSLzA0HXhKQ4sQNZ3Q==
X-Received: by 2002:a05:620a:1a1a:b0:7ac:a9b2:9374 with SMTP id af79cd13be357-7ae85f022fbmr88784685a.4.1728325046319;
        Mon, 07 Oct 2024 11:17:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae757628e4sm279069385a.125.2024.10.07.11.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 11:17:25 -0700 (PDT)
Message-ID: <c1d1c6fa-9d5c-4dc2-92bd-4deac333a568@broadcom.com>
Date: Mon, 7 Oct 2024 11:17:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v2 0/2] phy: usb: Broadcom BCM4908 USB init fixes
To: Vinod Koul <vkoul@kernel.org>
Cc: Justin Chen <justin.chen@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 Sam Edwards <cfsworks@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org
References: <20241004034131.1363813-1-CFSworks@gmail.com>
 <172831613316.134526.5485203085922304367.b4-ty@kernel.org>
 <d20fbf91-e7e9-4f0d-8e4a-0c5364f73bc5@broadcom.com> <ZwQkh6Vg+RgpXZdm@vaman>
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
In-Reply-To: <ZwQkh6Vg+RgpXZdm@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 11:12, Vinod Koul wrote:
> On 07-10-24, 10:06, Florian Fainelli wrote:
>> On 10/7/24 08:48, Vinod Koul wrote:
>>>
>>> On Thu, 03 Oct 2024 20:41:29 -0700, Sam Edwards wrote:
>>>> This is v2 of my previous patch [1] targeted at resolving a crash-on-boot on
>>>> the BCM4908 family due to a missized table.
>>>>
>>>> Changes v1->v2:
>>>> - Florian requested this change be broken into an immediate bugfix (w/ the
>>>>     'fixes' tag) and a second patch containing the coding change aimed at
>>>>     preventing this problem from happening again
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [2/2] phy: usb: update Broadcom driver table to use designated initializers
>>>         commit: d3712b35f3c694cb932f87194caafc714109ea08
>>
>> I looked at your tree and both patches are applied in the "next" branch and
>> the first one is also in the "fixes" branch, thanks Vinod!
> 
> First one should go into fixes, whereas second on next (due to
> dependency merged fixes into next)

Yes that makes sense and is what I would have expected. I got worried 
about your git hook responding to this patch series and indicating that 
only the second patch had been applied, thus making me look into your 
tree to double check this had not been the case.
-- 
Florian

