Return-Path: <linux-kernel+bounces-325923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D020975FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E76CB233EC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF17187855;
	Thu, 12 Sep 2024 03:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hFtDiCdv"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684971581E5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 03:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726112843; cv=none; b=rlIJzYdWNbYPM9VIz/g2GvxBSZh4zEpf7w5knnC31VW+k+KjPASn1K4IT2UrsfECnV0jxQKdDkJzVZz7HzSOANbcK5lbJSkoZ3+rwdvuuAr8Ly8TWXId42NrwLoQLWKA/wJNGiAHq+4dqCZKpm2JZJz6Ljl4kwVbNTIQu7PBneQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726112843; c=relaxed/simple;
	bh=hy2gvfBgvSG2CLZXo5GsU0amQH43X4/Zx2HrHavroIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UoaFNSeQfW3wtx8TMP/miB/TBW+S5DeGqAC5ldWgIB6fDVXqIipEEtaFVUAhSeNYRjGEtX0T8WSgiZPyYubMrixjrCicsx8qeei1UM+SLyoz38Yth40ChzPwrUza7x8guQdQDiXRNbGIadUa1XMJKLHNjuDqWZg563oektHgpBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hFtDiCdv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2057c6c57b5so2415155ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726112842; x=1726717642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zpi5WjCruGgU8/71SyqcIeKcw1xnAxd9pukWEA3iPRo=;
        b=hFtDiCdv19nLIWdozBSqvwbIZf79IZK0epHZrlHicIpEf2rsLU5ksy6vOjRoy2pwNU
         0BZCTK6xY/Acnh6+5+Wl74uu37kxor3peH9eUOhMsnkSl6nQ6J2IvR4CnUIKUHzH0RYj
         hNi2h8dECcGjtFPwM7uEHh5V2eVri0imxbEtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726112842; x=1726717642;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpi5WjCruGgU8/71SyqcIeKcw1xnAxd9pukWEA3iPRo=;
        b=Wu56J2uocK6jbWvd7H6PN98vbT+IT4mHlnUw10tJ23wLlkeW+Qbslx6xxhsV+Ua9Fh
         ujmiCSTVEyUufnvBolkrSW9Wq+w4h6mh7pROwHhxA16LqxS0uR9ZAN133LUObNHeEvMc
         gUQI61fES3RNu1JJktachxLMhJaiZf7btjwTuKYe/AT11OEV1OY7D8Ad9a2SNYCV74RR
         WDZerEFMflthRHYEhBt0f2SkbGMDX7uhJMVerDjH/FQugWUvwp4xH+no56wp9iZB/W2P
         3Jh528LBzcqDZVSp6ZqBGrVwVGd34f0J8q9zynBWNhBhGMHPS+/00b1dMQ2mSfF8xSxy
         zFeg==
X-Forwarded-Encrypted: i=1; AJvYcCXWeQoLk57WQSJhfbwY8d3w4peBA1Zo6OpKttNRxL/6Nb0VnkHkMvUlcS62L00MRRFIhbR1sDTugcthN78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx18Xy8VGc8La06UnAm4rzGy85lBvfaKcUSLvG4LhR9v4x+BKpg
	iSS4lRX5MWSZkuO5atfpVSLCiaNfyrNgPJxpcDtHjaB5f1etQ2hSdU7ECqezsA==
X-Google-Smtp-Source: AGHT+IFem+1x/fe9+X54nK3rU13rdd0fY1tEDb6WUxX7J3VusaUVKUpL8i43ZGtGxq7FK2JrdjeN3Q==
X-Received: by 2002:a17:902:e80f:b0:205:5f95:c283 with SMTP id d9443c01a7336-2074c5d28d9mr97113095ad.4.1726112841361;
        Wed, 11 Sep 2024 20:47:21 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afdd8b2sm6281215ad.175.2024.09.11.20.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 20:47:20 -0700 (PDT)
Message-ID: <2ba9dfa8-2c54-43bd-aa41-8ab87a7b2dc8@broadcom.com>
Date: Wed, 11 Sep 2024 20:47:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] MIPS: smp: Make IPI interrupts scalable
To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Huacai Chen
 <chenhuacai@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Serge Semin <fancer.lancer@gmail.com>, Paul Burton <paulburton@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240908-b4-mips-ipi-improvements-v5-0-be8617dd2e53@flygoat.com>
 <20240908-b4-mips-ipi-improvements-v5-1-be8617dd2e53@flygoat.com>
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
In-Reply-To: <20240908-b4-mips-ipi-improvements-v5-1-be8617dd2e53@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/2024 3:20 AM, Jiaxun Yang wrote:
> Define enum ipi_message_type as other architectures did to
> allow easy extension to number of IPI interrupts, fiddle
> around platform IPI code to adopt to the new infra, add
> extensive BUILD_BUG_ON on IPI numbers to ensure future
> extensions won't break existing platforms.
> 
> IPI related stuff are pulled to asm/ipi.h to avoid include
> linux/interrupt.h in asm/smp.h.
> 
> Tested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   arch/mips/cavium-octeon/smp.c         | 111 ++++++++++--------------------
>   arch/mips/fw/arc/init.c               |   1 -
>   arch/mips/include/asm/ipi.h           |  34 ++++++++++
>   arch/mips/include/asm/octeon/octeon.h |   2 +
>   arch/mips/include/asm/smp-ops.h       |   8 +--
>   arch/mips/include/asm/smp.h           |  41 +++++------
>   arch/mips/kernel/smp-bmips.c          |  43 ++++++------

For smp-bmips.c:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


