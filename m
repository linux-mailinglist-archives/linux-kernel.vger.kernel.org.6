Return-Path: <linux-kernel+bounces-350729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2ED9908BD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9864728246A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE681C3031;
	Fri,  4 Oct 2024 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ImUWCEza"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8A51E3793
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058278; cv=none; b=Ku/7Lndys4XDnsvtdoHdh1qp5BqztG7hVLb5GN2weK5XDUrLpOdgqg+b0dhw8g6rTbRZl+yTYy2qFsWkXP9eX71fLGD4o0go9fOWeDoaf6rkiYOOobSodjI33sY3XcbLN9pdCIOT3bx1ehRZI5LqJ75hOHwwsrRzxgSitVcpz3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058278; c=relaxed/simple;
	bh=cdbTN3dk9KoQtaZSwUqNJIdnaKT+6V+GIVRcSA/hhaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4dlNlBf7bphcVRKhMn12qZ8UgTFxfSfoI/bBpxb5oCqePqE8/Q8dPlEHvJhxuBzvA3lgGTyrDGFBo382/B0lrYKc629h1I+5KOUOadq5OyyJx0nP3pi+K0vAMaqF2Ku3ID2FOh9Jn8obU1USMWE1cpus3dd2pV4K+6b6KJWzeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ImUWCEza; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4582f9abb43so15339121cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728058276; x=1728663076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qv99QOeXcBkbZdfo+87lDU5Rqpsh7c5RFPOmgI+cSL0=;
        b=ImUWCEzaE4mZkXjbttV11AJlFc4ToFqVuqP93OjIIUbdcwn99G5Z3xvZGKQQXNGz67
         HmsZ6rpmRzlUBJvi9ZWPZE/sOX4VOjRd+XRkxhcoQnx240vYRm0E01sKVYsKS5495zzl
         wh8q5D2ZAyq3MYvLVwMLwQ5wmBG/A/l/ew1e4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728058276; x=1728663076;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qv99QOeXcBkbZdfo+87lDU5Rqpsh7c5RFPOmgI+cSL0=;
        b=k80yTrD6PGkN0yDBqtWCntyCcIe3gNMR2azQvksh+hiD8LE33/XJ9jFFf6RNjigxDU
         a3SS/l1ErHhN6RFh9hF6dniHXq5mC9kjqw5lxC+Jm9k7BtPFvUD4ZeY8VEOWRTJpNpzp
         D8InKfu3fr2E3NGh4TH5lW4syFL6tBLjL52y4LK4KsJtexiRdfPRQftXIbYxjM1Ke5pl
         eCeUkMHgYelIxNO0j03pWZDPmOzlYBgJ8P3oBmG0SYZp1XL4Ym0ADjk8aTENQ7hgBwIo
         Okb0HxdLxACF7oET3KlEE+HQw/D04bCHobMUDuwg4Me8U92nQK/5AqEIBLs25P4RfaPg
         L6DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNBP2gUdeXbKVPrz489ABvTyy43hKLVPMbw6iq9VGoLIJ7qsOrZglk/bMkD9vx7v/v+AaiuLJN5JLdAZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1rLyB2OxBmluzTRVm/gRiataPdAV0yk7guCJtRm1AbKJkizXz
	/r4GmRt09tbaUbtaasjhegs0E4OpdKpw5pPggGbw1AM3NMpQsf/yw1nPDcW6kg==
X-Google-Smtp-Source: AGHT+IF9WjuoqxXB7O+btvUqDweLOUwXmnSbTM4nu4YD4ylONS6lfLeSrTfD5T+E6hR6pXbqZE+C+A==
X-Received: by 2002:a05:622a:11c5:b0:45d:9236:89f2 with SMTP id d75a77b69052e-45d9ba79551mr40913531cf.2.1728058275929;
        Fri, 04 Oct 2024 09:11:15 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da75ed6b3sm349691cf.61.2024.10.04.09.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 09:11:14 -0700 (PDT)
Message-ID: <d6cfbefa-7526-4a8b-bb81-66f198de1395@broadcom.com>
Date: Fri, 4 Oct 2024 09:11:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: broadcom: bcmbca: bcm4908: Add DT for
 Zyxel EX3510-B
To: Sam Edwards <cfsworks@gmail.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, William Zhang <william.zhang@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>, Kursad Oney <kursad.oney@broadcom.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241003220820.1345048-1-CFSworks@gmail.com>
 <20241003220820.1345048-3-CFSworks@gmail.com>
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
In-Reply-To: <20241003220820.1345048-3-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 15:08, Sam Edwards wrote:
> Zyxel EX3510-B is a WiFi 6 capable home gateway (family) based on the
> BCM4906 SoC, with 512MiB of RAM and 512MiB of NAND flash. WiFi support
> consists of a BCM6710 and a BCM6715 attached to separate PCIe buses.
> 
> Add an initial devicetree for this system, with support for:
> - Onboard UART (per base dtsi)
> - USB (2.0 only; superspeed devices are treated as high-speed due to an
>      unknown cause)
> - Both buttons (rear reset, front WPS)
> - Almost all LEDs:
>    - Power (red/green)
>    - Internet (red/green)
>    - WAN (green)
>    - LAN (green; anode is connected to GPIO 13 so currently
>        nonfunctioning)
>    - USB (green)
>    - WPS button (red/green)
>    - Absent in DT: There are 2.4GHz/5.0GHz WiFi status LEDs connected to
>        the WiFi chips instead of the SoC.
> - NAND flash
> - Embedded Ethernet switch
> - Factory-programmed Ethernet MAC address
> 
> WiFi cannot be enabled at this time due to Linux lacking drivers for
> both the PCIe controllers and the PCIe WiFi peripherals.

On the topic of PCIe, AFAICT Rafal had made an attempt at modifying 
pcie-brcmstb.c, which is really the same IP, or rather a fork of it. Let 
me know if you need help in figuring out the programming and we can help 
with that.
-- 
Florian

