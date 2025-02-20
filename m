Return-Path: <linux-kernel+bounces-524476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8A9A3E38F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF05E3BBAF5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5201FDA7B;
	Thu, 20 Feb 2025 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eb2d4gJM"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F6190072
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 18:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075333; cv=none; b=QbMnLeFodFXlrOMkicHIaCnAkkHguqdm9dOFLaNRfQuoacauqkCR9YBELXe8xo0JbHo4WbRup6XonfmbEY7h/RnN7Zcex4Rit7jM0N+p8yGZWkGP7GhsTNHioPSI66cHWfNdDeDYrKdjsbLzR7krjNvsuFzW72vfedxajCAhWK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075333; c=relaxed/simple;
	bh=XYBOGtcnThVut61p0csCaf8gKVv/2ebNR6BSRx0wraw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgT04klhw3MEyfWWjbbACxiFNMAi2fsIaOwVW/rOuyoo6oHrO+KUIGYzXmYUGWiz099knvf+Lixy3nrNq8DsN1ss+Qi9bEwWyEGTlAl08CYjTZs2idZ5BnGx3ajuzQT4qKZlJUhvnsnZPlTmAx12eDJlF3LmEwnpwaNp7AHdWdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eb2d4gJM; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3f41091f7c5so677765b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740075331; x=1740680131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+zSBLBub+0DV1mL9PQvU0LTUDmWa3nJU7kZAxsIQwuY=;
        b=eb2d4gJMgT9QTSTUuWGbZwdkJ/jf7027UKaEqcMzANbZKX/4/DW0g1U+ZsF9kUF/z0
         TOJAtiEIPkVprHMsbWDlh5w0/26vQqzxtME7b88u4F6lOGf7YS9cjQyNH/LzeOc91YEr
         jI+YHocNa74sgDNac8FMZj63wzLv/Tz2Q8pB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740075331; x=1740680131;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zSBLBub+0DV1mL9PQvU0LTUDmWa3nJU7kZAxsIQwuY=;
        b=EsOL7mNezbSZwvPI1Fz4hhifOxVyFIj095h4pyxUfduwJ/gEUjxAVyKZXDimuPyQVO
         4LDnLgRX9CnpnyAgXGfiUCNNCJozgh5ohEXRzYjsw4dJd2pP/Ac1U9PxqGfdtaBYL+8Z
         PWVuxCRW7Qp+ukvrn1r8dJn68gVhQjmN93LT92nbw5xA6vNGr1oRjbwuU84QqeOjW/Jh
         oc1JsdGbKlBvb0Fosg2E6BL1yV1UBTs5d84kM/xHo/a69/j2nppUyRmRTPGFhZzlepfB
         ppIORT+erkbjSj/Iw0MGRsWdDxMWE1qmKZMfYbxV0B+DMY0zhtWauohO7xqtR5Uv+uFQ
         IkBA==
X-Forwarded-Encrypted: i=1; AJvYcCWqHq9lE4MHNAf0Qkb+mUyVW6ncmOBEm5rxgm2pq7VvUnu3XVMGlaw/PqFPyTDGYJS9I2izPcwEixFFtEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhxbt1nt/ySBLEAtFe9G7n8su8n4UvHDTBIHsflKl27hvCmMrN
	NYTqLFmttkbT1KeZCr691z3grC0PbvFRH001kD0kGZoLPwj3JtCnepYg5SUO4gDIceL3aM8MEh6
	lxg==
X-Gm-Gg: ASbGncsjOkvdqaKa7DAvU4WKkTttjHt1yIqai0Y7zviQuFgn4WTg63GEIysivVatJaQ
	c/shJnV1TO9febhp1EGgB3iy7W+tvPDPmcHDCbRzNJcJMVcsa/eDm9WVQLdwJjDOeNvxseSSbVc
	yWTKVZE27UP+QVZMIatw3IOOlu+Z5p7+ZdwxUkvbAOr4228b8rWZ150E86dGzZgAPGaQU96y5ac
	5SSIlvjr87v/8Jv2pUMt+XDqKGiEs9NvbK6hE6NaBEHhhk+rZC1G1rKG0jjGBUIp9xPsb1UQb1e
	Vdm+AGbrsyjp1d4kBeQrcuBmLMQgNg8WzeFAMahaljHXxvQaVFdGxOmFjtNKr/4Gkg==
X-Google-Smtp-Source: AGHT+IH2l0eRcxY3Eu6vwoauLMOYCdGbNvwLkKWPz3/PunqRtomjjR5eVSyx7rBWij/N2juPg3g7+Q==
X-Received: by 2002:a05:6808:2e92:b0:3f4:1dc8:f52e with SMTP id 5614622812f47-3f4247b2b7bmr350247b6e.30.1740075331418;
        Thu, 20 Feb 2025 10:15:31 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f3f9ce7493sm2600909b6e.45.2025.02.20.10.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 10:15:30 -0800 (PST)
Message-ID: <d5870fbe-0009-4960-9040-99ec35944c92@broadcom.com>
Date: Thu, 20 Feb 2025 10:15:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] PCI: brcmstb: Clarify conversion of
 irq_domain_set_info() param
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
 <20250214173944.47506-9-james.quinlan@broadcom.com>
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
In-Reply-To: <20250214173944.47506-9-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/14/2025 9:39 AM, Jim Quinlan wrote:
> Just make it clear to the reader that there is a conversion happening, in
> this case from an int type to an irq_hw_number_t, an unsigned long int.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


