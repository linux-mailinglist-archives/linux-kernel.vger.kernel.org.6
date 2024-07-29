Return-Path: <linux-kernel+bounces-266505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16499400D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58052280FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DA818E744;
	Mon, 29 Jul 2024 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q4OwAbrN"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E07F18A933
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722290839; cv=none; b=RbYvHU/Y2BF8M4H3k3pNNRA7MfAGXNEc+W0kwv2CdBgwma3KgCL+fxbSxx6LXXO0dK+CSe+I8TBLBjGTGnumREgWiNEXTVh+4FXKogxeWhDd/Br1bo0Sbev8xgbG5bZAyDxmwVp5cpGnTaOpGnMUMock2fJikriu/xxbGW8Pd8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722290839; c=relaxed/simple;
	bh=W/4Cbn8/kkKSr8waaVeTGkTkc0iDnw17OTmovtR+Hs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THbcXWXcySpDxpp+DXqVVKNl4ZhRgwcxR8jyIndWbfKzgCkUQkZ5MIRWyTj0Ai4ypnDiAPFIY0+LpfQnYbqBSDrlhX3wmvPe2TOVng3cB8mmn6V7ZvIQwGy7pdP15nXtHjI+cpKWbCbOV5J9oTlQfF7kEKpwsullGWg7hj07jA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q4OwAbrN; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db15b4243dso2436453b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 15:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722290837; x=1722895637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b8H5cqONla5l6xRWvkLKshaUuFMDuSBaKxHVTiX3aGg=;
        b=Q4OwAbrNg+MJwpTown7TEU2hk1t+PRRoDYNHV0P+AQIEdbvkilYMh0PUpjZuyrwucS
         Gz/xCYUBEOURYtc9vl9j+5Ri5qhNbRltx2jjSBJ7uQKPfy1M/KWNJfuFUvJ8aNAjDBgj
         CBwQgowzbYtK7e+hofZVOKiBW/fz4FJOw44VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722290837; x=1722895637;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8H5cqONla5l6xRWvkLKshaUuFMDuSBaKxHVTiX3aGg=;
        b=pjnCOnSCdoshLyL2f12qrtdvGv7yOP15h3vmpg4bqD0XFjwI+jrJqiToBkh95MuTeJ
         FVAAmmIihHwnit+hWshAS+srrdYZ54RRYjR8tIq95zuTAXkfm0RNOkpU6Xqwm9mVAb/n
         8wh33hFqyEsefIKpiXP+SIPSJnbdp7yQP5TaSvjXL5md8mieiU5OUcp7Rra7DPXvfU9f
         OFwrKrTQGX2YGW9Ao+Jqnyc2u3b/wf8eBrch4MCb0yjeFE365QW3PlnJjLFA7HwGGv/g
         qUN12g7SxcXsX/AlQQYjdHQkC9hs1xO2HTUI0ICrqKo5vdERNXwChcZXnbq/azY9Cd+V
         TmoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJK3WSu7gYdWagDxE9Y5zJCkG/muuPc3ueCCsYrwBs+28MKMnOj4iNzqgRbX9JK44W+VEPi+We0mLiryHXHQOhHChstqIURiEQGZOt
X-Gm-Message-State: AOJu0YzsxZYAzX2k4AtMoXkms9y0z07LO0l+vm28KYBpuOESmc4oocNl
	5WITpBSLFD7KmM3Mqy+mdZqLdcKXy/bqnAZtt9mnpmTwUm4nkPoHJG/rI/bW2g==
X-Google-Smtp-Source: AGHT+IFmzx13eC2YOwTGHAR3k4HhBvZs4D0wU8GU1PmpTExe5XjmFJWYAVLbbHRlKtFyTcU6KK3o6w==
X-Received: by 2002:a05:6808:f93:b0:3db:3303:8377 with SMTP id 5614622812f47-3db33038678mr6508739b6e.30.1722290837185;
        Mon, 29 Jul 2024 15:07:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8187c0fsm44783511cf.55.2024.07.29.15.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 15:07:16 -0700 (PDT)
Message-ID: <70365646-ee0d-485f-b865-e0aaa304d758@broadcom.com>
Date: Mon, 29 Jul 2024 15:07:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 0/2] ARM: dts: bcm-mobile: Split out nodes used
 by both BCM21664 and BCM23550
To: Artur Weber <aweber.kernel@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Stanislav Jakubek <stano.jakubek@gmail.com>,
 ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240729-bcm21664-common-v2-0-ebc21a89bf63@gmail.com>
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
In-Reply-To: <20240729-bcm21664-common-v2-0-ebc21a89bf63@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/24 05:34, Artur Weber wrote:
> The BCM21664 and BCM23550 are nearly identical to each other in terms
> of register layout. This was verified against a downstream kernel[1] -
> Broadcom's kernel has "RDB" directories which includes headers with
> the full register maps for the included hardware. Running:
> 
>    diff --recursive arch/arm/mach-{hawaii,java}/include/mach/rdb
> 
> reveals that the differences are minuscule - some things related to
> ISP and H264 decoding. Most of the other differences are related to
> the different CPUs in the two chipsets - the BCM21664 has 2x Cortex-A9
> cores, and the BCM23550 has 4x Cortex-A7 cores.
> 
> In mainline, most drivers are also re-used between the two.
> 
> To make development for both platforms easier, split out the common
> nodes into a separate DTSI, bcm2166x-common.dtsi. This only leaves
> the device-specific nodes - so, CPU and related things - in the SoC-
> specific DTSIs (bcm21664.dtsi and bcm23550.dtsi).
> 
> The new DTSI is based off the bcm23550.dtsi, with its split into
> busses. Since it's pretty much 99% identical, I kept the licensing
> of the original file (BSD 3-clause). The license for the bcm21664.dtsi
> file remains GPL 2.0 as it originally was.
> 
> make CHECK_DTBS=y on bcm21664-garnet.dtb and bcm23550-sparrow.dtb
> seem to pass fine for me (thanks to Stanislav Jakubek for converting
> the bindings to YAML format!).
> 
> [1] https://github.com/knuxdroid/android_kernel_samsung_baffinlite
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Thanks for resending, I had those on my radar to push out, now done!

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next
-- 
Florian


