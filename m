Return-Path: <linux-kernel+bounces-349682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EC598F9F9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3161C22811
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EF11CEAC3;
	Thu,  3 Oct 2024 22:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fTOuRgmB"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4EF1CDA3E
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727995282; cv=none; b=M9515//nJY73MnfzeucJeDNX6vycZW2Cm7pe9sEIyjmDwYYQhTwgxS/AKWzwymx1O4Q9xwz3sIlnF175AVOLlVouPQnP65dEkZTv4j6Tg2BQKbOwJP1e1MzFMQCCP8Q52Hd8G8LCh//ZiND/H3LG5eA3F2br2YD4yBxGUq8MRjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727995282; c=relaxed/simple;
	bh=Jo3jTu3gvdSY4hclX5Ayw7O/TbUjLGTC5b1dS6kU29Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PWUPEHy12LiyOuA6O/qFMsS8qRbG8BYVAR9Ufm9P13TCsQVTFpqGwk3oAqWJfeUwO/wWn1mf6zlcZJZkeryojYv6KCIEWNeLMSKTDseEWm+JRaMjSC6aGEcKeci1EycMWnbSrQxx+zqSHZ7LC+xcj4sfpkJKfnJTufQO2U0p3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fTOuRgmB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-718d91eef2eso1115395b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 15:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727995280; x=1728600080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JOOuScGzdxC4cr8jo6Z6y0fx9Os2Ix83Ys4a8jeW6gM=;
        b=fTOuRgmBnvVSlFdJhJM4WkQOhmWD0P7FVSYLbgoc/MI3WtZ2KRdIev/mU/H812I07V
         bbryA64zk2te6O5w3D9nCp30umpegWI7EYwWOtTcjGBUTO9V/ALmGfwRqbbrG/XHf3e2
         +sfbTTVUH1UCmA0MTwqHDm9x61UXjT1vALTHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727995280; x=1728600080;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOOuScGzdxC4cr8jo6Z6y0fx9Os2Ix83Ys4a8jeW6gM=;
        b=nO4/EIK3aBNhSddkVzCu4Mo2+ytmmFX47uyI12F5W9tZlJ6l15o2KGH3kPN8kCtJeT
         dQSHyI4FEZ2YUdpLOmr5KavrCU61FaWmXyUsODyzZg8V4JfxTUrXjrWdBZZQUhD8voUD
         AXLpStCd8hI01VCD/sZBHpj691rz5QvUx6wy7Qlrnb/BKArcllZ26jyX+5HhJKuBMCna
         8sucnB+Pd9I12qbNW8k8DMmYgrBgqlBasAG0xFqmUjtMc045AsmgaRS3LRp4aVoy9bmU
         XimSAiK8+BbFAVMBqPqLjfDeojT1zBLHCYs1g6vBk6Mo0po0Ku2nrz7mi56WAp6R24IT
         8Iqg==
X-Forwarded-Encrypted: i=1; AJvYcCXnCwWKbZq7AI3JHOgB/xMt1qcMJ17eCylOVu+LCCcKrzy1+/q+qrnqdAlyTsFhjFl8dpSvGqTh63JrSbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3SYGsLntFXJABwkfGd6Vkurd8TtJlgSLm7NlGpRZEMjtLEhQv
	dZDt+Sv8hzM+h3/Crl4mxhAEPXoiM8LNUop82i29o9uXGQUmDnK0c5dIXcYrEA==
X-Google-Smtp-Source: AGHT+IFVLgJFz8v9YeM8XoaHbIFpThc32hUC+mhSnSMer2REsIA3MjrBBIVcUPSsCAEWNGVm4/h5tw==
X-Received: by 2002:a05:6a00:9495:b0:718:d4e4:a10a with SMTP id d2e1a72fcca58-71dd5af2450mr7405946b3a.4.1727995280413;
        Thu, 03 Oct 2024 15:41:20 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9def29fsm1899168b3a.155.2024.10.03.15.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 15:41:19 -0700 (PDT)
Message-ID: <78f25b22-f35b-4183-baec-7ddc0c5e3fda@broadcom.com>
Date: Thu, 3 Oct 2024 15:41:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: broadcom: bcmbca: bcm4908: Reserve CFE stub
 area
To: Sam Edwards <cfsworks@gmail.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, William Zhang <william.zhang@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>, Kursad Oney <kursad.oney@broadcom.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241003213007.1339811-1-CFSworks@gmail.com>
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
In-Reply-To: <20241003213007.1339811-1-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 14:30, Sam Edwards wrote:
> The CFE bootloader places a stub program at 0x0000-0xFFFF to hold the
> secondary CPUs until the boot CPU writes the release address. If Linux
> overwrites this program before execution reaches smp_prepare_cpus(), the
> secondary CPUs may become inaccessible.
> 
> This is only a problem with CFE, and then only until the secondary CPUs
> are brought online. However, since it is such a small amount of memory,
> it is easiest to reserve it unconditionally.
> 
> Therefore, add a /reserved-memory node to bcm4908.dtsi to protect this
> critical memory region.
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Not objecting to the solution, but should not this be moved to a 
per-board DTS given that there are boards using CFE, and some using 
u-boot + ARM TF that are unlikely to suffer from that problem?

-- 
Florian

