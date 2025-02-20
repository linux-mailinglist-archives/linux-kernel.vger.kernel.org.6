Return-Path: <linux-kernel+bounces-524475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0EEA3E38C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F443ADCD6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D802212D86;
	Thu, 20 Feb 2025 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C0GGV/rZ"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81AF190072
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075324; cv=none; b=fI/bVuMwuER4vEKN2SDPtmn1YG+dicO4rn5FVjx2HkCO9P3nui8E470SyG34ShMZUTPvwUQ08xWOaMH34Hrm8przM9LIBebkQpcNh0oiDh0/g0vIcfFbrrn/hpFc4P1oA/mAZpnI1mkhCRT7iize+XdVR7tURS3lRDgy0S24R8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075324; c=relaxed/simple;
	bh=FkvQWC+ZdXP2mjqTsEXbfZwCVpXADIq7snuopqtkODg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHfi8QNw9DgxYmem1xqReCEwtWq3CAJHaG+8pp9oDKhbBlMIGsFhWk7Qr4HJYwMBtRcl5mTw50tv+oakmtzC4UU9Uysx6hyzVtVeIb3OepK6u+e1m8ahPJROuITnW9delJzHubYHnYyasFedXc7z17XiwuaeCGJym9szM9fTB2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C0GGV/rZ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3f41091f7c5so677659b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740075322; x=1740680122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6UFXIL04L3g/FVsQnKVA9y48WlZfw6n4fIx2g65MX/M=;
        b=C0GGV/rZngmqDDLEhgJNQeKB2EKybaWPYScYrjgL3/RCEQsYJ43BOeQEb8MlmiGfXT
         CXMFqTSq3IIJrGlXBqntmEX8ysDZih1AKIBJwSqPFol4CIm+A7kCvEKToghjyf8mBN0l
         kHwEW2aaOKglge/R2x3PsobLmWjyliQUxbEEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740075322; x=1740680122;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UFXIL04L3g/FVsQnKVA9y48WlZfw6n4fIx2g65MX/M=;
        b=aqkIuSy2BAIiz73CC9btpj1LnL5r1YDHfG22wj8SEOx7OWbl+552kbmwetq3Mtsz4S
         ZPg3MqQWE9JVi5Qz7nu50ekpjpYJMKtJwnqIiQm+zr2BB+g94nzIGPZsMT9krqQBRt+L
         CfplFGg9FkIQbY3lLnoA5xC9576AqVPMIXXDDYNUWZKjUopPOW68n53ziXvI5qkaYImQ
         gK74F91ucHhDsnkFlJ04QmkQ+KTlCUVGF6w77lWoxNIid9/zpjofJ5AT5ci9nb2Pfs6X
         lhYTMHmDAp/VXXSFaXWPT5A9V5ERITgF3zIZwZkU5IjKS2BBjHtgE06e5+sWNw4ffi+K
         b3RA==
X-Forwarded-Encrypted: i=1; AJvYcCW3XXY9j2Ube+ucx8NHYVqTV2TVbmzV5dFF93LmjNq/+k2Nnmnh55QOsH7ol/E+U9oEwzY/Em8BRbOUJQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0WY3RTl3ODlHvG8sfJGYjSHgZQTY4opLOCP63D1KfOthG35xe
	19CzF6VQqr4hXufEFP5ElNXhax4jLSL9aWw6WSCM4G/MbFqHAh7jxdSgIojOjQ==
X-Gm-Gg: ASbGncshiVmKAXOIo8IXax1BNmF8RlwLdfLuTXaH/Scw0PzwYfilCKWKaL0s+nOXV0l
	tYtvSA17egaOVF2a51BGps41WAvczTDTrZKCthWJYUjelGTOpRqCnNOBFmMeTpNifyAQvvERzRt
	MR6zRWlCwWp30SK6xePGXQrPhPyf/lqFOgGRbV7udQ5HTZmZ0hGIsTLN70dAF1Gg3YjO8hTgl6F
	LcQvxQE66oS4MuUxTJBJv3iYm3hoV8a1Kd9i2fLUKQF1bXruR5A68HwsA6+/mTggDPUI3one9+D
	iTi6pH6Z4Z05kmb6R1mKx2yHs4lf/9vTN8pH+8z2Fxd+YbDa68eCTN++W8yt/IKZHA==
X-Google-Smtp-Source: AGHT+IFxuMVGZnR6zXdAwNzj8TJU1uFl8s8BTcJU5O0Y143Y+vhX1OrwKJZmy3+uU21vvgt7J9jEmQ==
X-Received: by 2002:a05:6808:2181:b0:3f4:2023:f10c with SMTP id 5614622812f47-3f4247d8a9bmr289403b6e.32.1740075321821;
        Thu, 20 Feb 2025 10:15:21 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f3f9ce7493sm2600909b6e.45.2025.02.20.10.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 10:15:20 -0800 (PST)
Message-ID: <34e6fa99-71be-4e39-a0da-893cdcf12eca@broadcom.com>
Date: Thu, 20 Feb 2025 10:15:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] PCI: brcmstb: Make two changes in MDIO register
 fields
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-8-james.quinlan@broadcom.com>
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
In-Reply-To: <20250214173944.47506-8-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/14/2025 9:39 AM, Jim Quinlan wrote:
> The HW team has decided to "tighten" some field definitions in the MDIO
> packet format.  Fortunately these two changes may be made in a backwards
> compatible manner.
> 
> The CMD field used to be 12 bits and now is one.  This change is backwards
> compatible because the field's starting bit position is unchanged and the
> only commands we've used have values 0 and 1.
> 
> The PORT field's width has been changed from four to five bits.  When
> written, the new bit is not contiguous with the other four.  Fortunately,
> this change is backwards compatible because we have never used anything
> other than 0 for the port field's value.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


