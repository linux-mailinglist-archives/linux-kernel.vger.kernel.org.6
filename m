Return-Path: <linux-kernel+bounces-351564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE02991325
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 01:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14EB11C21949
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E91C1547C5;
	Fri,  4 Oct 2024 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BnzLGZ68"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9E114E2C2
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 23:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085010; cv=none; b=jKqUwJOdxT1QFevIefQRRSpWbDGcB7iaauLrLMtJY+Roz2bLGi85tVaxnaworskPw1j4NnPkhAJKmYAEE+R3a1cYlijma0NJUtyEqvQ8mLpL4LaTciVNdMKiKIe153kmggbQkFTC49/BVOp+y28c38+M38NVSMeVFZNB02IIC78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085010; c=relaxed/simple;
	bh=XvUnocCXbVbuFdtVRuQ3tHCrL6fOe57DjwVWeaC0+ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8/hMyJCXGNBufwRuL5GA9Yv7RJQOx9d+QIWGd9ShH5e/ixKZtRVQh2KI50Een3FshGYY57pUy6WieCTAXpVtdco6UMYB9nVShqV8/jY0gDVQnK1XkxnrJvDhEXbmJgZxzRpBo8XYG5J7WtGtcsOrXYeo3R6iJpJkGknzyEOcEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BnzLGZ68; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e137183587so2260421a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 16:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728085008; x=1728689808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nvv6ZVBdx+WslBs6QiI09CmZL7t21PPn8TYDS1fea1A=;
        b=BnzLGZ68OslfE1bHR81t9HmLxEL9RV3EUm4k6lEp3nYXnl/XEDcvn4Q+VxjDiwkoYA
         uhM9xAFS8CD1hsL7IW4L6dj3FpRixuD3JlfuindfRYqlA2qhuT8SzKAyaB5b9X5M3U4S
         nNEzG86kd4sqgonRRNG7x8pCc/TdMUrSTWjuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085008; x=1728689808;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvv6ZVBdx+WslBs6QiI09CmZL7t21PPn8TYDS1fea1A=;
        b=MswTcsUUI0emdJlpZ4eD/GVWxoBtviS0texJ73E8SZCUsMlwCxXD+dpm6/legvMuFg
         gGgfQPeuW98Z3cfUckmyRYymcWQzWdsSBp5FZA5G0qfdnJccp0o5pf6WHZ/MDoG3maak
         SjUZ2i5M9emZKkCu+xQ9FvdRgWX8RJbPLW42bbXh3qBDuGdoM3cQYtBl2Se3NwKL4MGt
         /DBooi0/JFF7FAAEgpy+GzKmg0awXYN+ae8wlG6Y60AT1Acp0ajAxhFVsfZlg0DZHwzY
         AYB2S6W6XxiQm2G2iPHsP7jhAZK4v4wfDxGORGthVebONCCIqn1jsp6yDGTfQ4UWGyiz
         ryTw==
X-Forwarded-Encrypted: i=1; AJvYcCXq3zLTsUrExsKHmyh2dYVjs8Dk5TiORNTqbZ7J8hOE7mPGzl/1RVL0gFVq0cpom6ywMTwMtBUgaQEYvic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhjc6Jq67KtBkLHZ0ZoG8fbRL3npwVfE3u6tWvrTqiyap+CHZ/
	TUFc4/GS8787iOSCOhe/Gcs0ubj7V9PUnW29H8pBXCUrXAdQhkKTjtpWJAR8DA==
X-Google-Smtp-Source: AGHT+IFEVUF2i0P9TypTVjBU933nKEuDhBbS+ZkLc9YiZhtGH3DObvHfsKEGcZ4pkTacJowDI+ZftA==
X-Received: by 2002:a17:90a:ad8e:b0:2e0:78a0:55c4 with SMTP id 98e67ed59e1d1-2e1e622723bmr5452427a91.9.1728085008161;
        Fri, 04 Oct 2024 16:36:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20aeba043sm538894a91.13.2024.10.04.16.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 16:36:47 -0700 (PDT)
Message-ID: <8c49c480-5647-4ecc-85ff-5d61bb873052@broadcom.com>
Date: Fri, 4 Oct 2024 16:36:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: broadcom: bcmbca: bcm4908: Reserve CFE stub
 area
To: Sam Edwards <cfsworks@gmail.com>
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 William Zhang <william.zhang@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>, Kursad Oney
 <kursad.oney@broadcom.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241003213007.1339811-1-CFSworks@gmail.com>
 <78f25b22-f35b-4183-baec-7ddc0c5e3fda@broadcom.com>
 <CAH5Ym4gUfhh3ZkPY8i8eVNzWOpfk+ibqAgdPuT3i0H0FsF5t8Q@mail.gmail.com>
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
In-Reply-To: <CAH5Ym4gUfhh3ZkPY8i8eVNzWOpfk+ibqAgdPuT3i0H0FsF5t8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/4/24 11:23, Sam Edwards wrote:
> On Thu, Oct 3, 2024 at 3:41 PM Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
>>
>> On 10/3/24 14:30, Sam Edwards wrote:
>>> The CFE bootloader places a stub program at 0x0000-0xFFFF to hold the
>>> secondary CPUs until the boot CPU writes the release address. If Linux
>>> overwrites this program before execution reaches smp_prepare_cpus(), the
>>> secondary CPUs may become inaccessible.
>>>
>>> This is only a problem with CFE, and then only until the secondary CPUs
>>> are brought online. However, since it is such a small amount of memory,
>>> it is easiest to reserve it unconditionally.
>>>
>>> Therefore, add a /reserved-memory node to bcm4908.dtsi to protect this
>>> critical memory region.
>>>
>>> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
>>
>> Not objecting to the solution, but should not this be moved to a
>> per-board DTS given that there are boards using CFE, and some using
>> u-boot + ARM TF that are unlikely to suffer from that problem?
> 
> Hi Florian,
> 
> I think I share your same gut feeling: this is bootloader-reserved
> memory, not something claimed by a driver or belonging to a device. If
> the bootloader is going to leave some code or structures resident in
> memory after handing off control to Linux, it's the responsibility of
> the bootloader to claim that memory by splicing in a reserved-memory
> DT node, and CFE isn't doing that. So I think we're very much in
> "Linux-side workaround for a proprietary-blob bug" territory.
> 
> I don't know if it makes much more sense to put this in the
> board-specific .dts files; as I understand it, the architecture of CFE
> is somewhat unique in that CFERAM (containing the actual "bootloader"
> part) is included in the firmware image. That means that whether CFE
> or CFEROM-loaded-U-Boot is the thing kicking off Linux is up to the
> creator of the firmware image, rather than the device manufacturer.
> 
> My reasoning for including this in the SoC-level .dtsi is threefold:
> - The .dtsi is specifying enable-method and cpu-release-addr for the
> CPUs, which also concern the Linux-to-bootloader protocol and should
> customarily be synthesized by the bootloader. U-Boot picks "psci,"
> overriding the FDT-specified default: so the .dtsi is already assuming
> CFE.
> - The .dtsi is also picking 0xfff8 as the fixed location to put the
> secondary-core entry point. I've noticed that CFE walks the FDT to
> learn cpu-release-addr (rather than writing the property): so the
> .dtsi is also already assuming that this region of memory is reserved;
> this patch just makes that explicit.
> - 64K of reserved memory is so tiny compared to the hundreds of MBs
> typically available on these boards, so I felt that the unconditional
> memory cost was an acceptable trade-off to save affected users the
> troubleshooting.
> 
> If you happen to know of a DT property that tells Linux to unreserve
> the memory once fully booted, I'd gladly use that, but I didn't find
> such a thing when I looked.

Not aware of such a thing, and I am not questioning the need to reserve 
memory, that need is quite clear. What I was questioning is making this 
a SoC specific entry because we do have a variety of boards supported 
out there, some with CFE, some with u-boot.

I suppose it is safer that way however, regardless of the boot loader 
being used, and therefore I have no problem taking this patch as-is.

> 
> Since CFE's stub program appears to be very small, would you be more
> amenable to a patch that moves the address at 0xfff8 to 0xff8 and
> reserves only 4K (one page) instead? I hadn't thought to try it before
> now but it should work.

If a smaller reservation works, sure, why not!
-- 
Florian

