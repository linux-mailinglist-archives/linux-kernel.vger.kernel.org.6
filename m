Return-Path: <linux-kernel+bounces-339608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4999867B4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 22:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D43B71C215F3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D8414D2B8;
	Wed, 25 Sep 2024 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I46luq1y"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CC91BC2A
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 20:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727296735; cv=none; b=WWzuhzYyIZXUTRURIyESgDQeFdg1DsrvszZzK7AxfBXgnNyJWqmUfn2fPzkVJH99Wj7MZkBwtaD0VlwgnOfaUMb2GlAcuM+r3X/XG+GfO36TA25i9Xs0xTKqmh49NUmreclVd9n7Aso8AU4Uf8+/Sh7JHLYTDKIQq9V+N34xY+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727296735; c=relaxed/simple;
	bh=YVNmR6XXvH8A5mvxHVgdhsaKgdAgwRDKLgBUf6F6wc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qm5RY5fxzMYDi/iXLizAyp8iF2zI9woSybDF+qbVgo/TywP1ul659g55EcCDr8096hUme67aBJx1Hzijflm0lCqkhMB6oncvz//QizPDnRksnlzoV3e/j+5J744YAuSVfh5ceYq9BqlAJskkkiCWZl7ouzUOT3F+NRAgg1fODaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=I46luq1y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20570b42f24so2458265ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727296733; x=1727901533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KMqnLJA14tEsx7O9h7xhY2igThYy8VcFXXux1jwsKwM=;
        b=I46luq1yYoPYyO3TaT/8qIP9cBwvN1cA52v7dzRzg54QT3uHex+0pXMn6Sg5Z0ry3Y
         mtBJE+wGK6sa+NwR4m2j2lDHfgfrWlvbIH4J5xy2k64F0FG7rWCeSZFG/ub2kI1pYJ/6
         fyaWev5bv+/x2RNIBmNE3+05RlnC9Awe/Wuf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727296733; x=1727901533;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KMqnLJA14tEsx7O9h7xhY2igThYy8VcFXXux1jwsKwM=;
        b=UG/E5lfL0YXOeqmNluYnIikn34ZqKuyoIPBzQoJtkEFIr4s0CxiZn27SECy0tpxhX9
         zXNCE/EpeoA4ZnIeIW125HYcVajYOWX83aRBfAp9rZby3WnOuA5W+raz7c851GTxpxMd
         TfyDmdBemkFTN6GAqhjkTnW+mHmgnLgMDuKKJZdWIaN/vbYd2q7VQc6vvE1MLkxN9E2g
         oXAqbp2+nRfoeWW6F5fRBkV1brXcNkn1+rUVX6/bMS95EOaisG2f3WH5ic3MW1laytYX
         sqgJWVnnIDCncZojDddvnrCJERt5crChIzk9xaC9DgwK7YvsnQks9B2iVGesf8z234ui
         yDYg==
X-Forwarded-Encrypted: i=1; AJvYcCWG1go1cKjLMVa0Oe3PTJbjkfD89pnXzHrIJuflp9Tnbjbf/V+u+LKaIh+3OQk23yIlGdn5H+8dPbSg5K0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNqCWGs25Y92ph2XS2u9TqN8kQkWjrZQ5sEjAbNOGe9qB6uW5o
	DvyBRH7H3ziisEHf9c5mPsAJONAZ+648wI4gHoWj8yOZI5ASyme4AqUBozcg4Q==
X-Google-Smtp-Source: AGHT+IH1jpsv0tw2DCcjrIftabUlsulweSmtlXGW2NhlfsDo3ONd9Fj2VcbVlSoC4aSk6HabY5Rwpg==
X-Received: by 2002:a17:902:d481:b0:20b:f89:de76 with SMTP id d9443c01a7336-20b0f89e1d1mr25897875ad.36.1727296733476;
        Wed, 25 Sep 2024 13:38:53 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af16e0551sm27781615ad.3.2024.09.25.13.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 13:38:52 -0700 (PDT)
Message-ID: <6723d91c-ac15-436e-878c-2d6fc1aac5e2@broadcom.com>
Date: Wed, 25 Sep 2024 13:38:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: broadcom: Add missing required fields
To: Stefan Wahren <wahrenst@gmx.net>,
 Karan Sanghavi <karansanghvi98@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, Anup <anupnewsmail@gmail.com>
References: <ZvQ27pvrnEYA8BB9@Emma>
 <3e296eed-5dbc-4098-ac3c-3c3125a352d8@gmx.net>
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
In-Reply-To: <3e296eed-5dbc-4098-ac3c-3c3125a352d8@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/25/24 09:39, Stefan Wahren wrote:
> Hi Karan,
> 
> Am 25.09.24 um 18:14 schrieb Karan Sanghavi:
>> Added below mentioned required fields
>>    1. interrupt-controller
>>    2. #interrupt-cells
>> in the bcm2711.dtsi file for the
>> interrupt-controller@40000000 block as defined in the
>> bindings/interrupt-controller/brcm,bcm2836-l1-intc.yaml.
>> This issue was noticed while compiling the dtb file
>> for broadcom/bcm2711-rpi-4-b.dts file.
>> After including the above fields in the dtsi file
>> interrupt-conntroller error was resolved.
> looks like you made the same mistake like me [1]. This change breaks
> boot of Raspberry Pi 4 [2].
> 
> There are a lot of DT schema warnings to fix, but this doesn't belong to
> the trivial ones.

Including the #interrupt-cells would not have a functional impact 
however, and we ought to be able to do that.

The 'interrupt-controller' property presence means that the controller 
will be picked up by of_irq_init() and that is was causes problems for 
people testing this. Stefan, do you know if the VPU firmware 
removes/inserts that property to tell Linux which interrupt controller 
(bcm2836-l1-intc or ARM GIC) to use or does it make use of the "status" 
property which would be the canonical way about doing that?

Thanks!
-- 
Florian

