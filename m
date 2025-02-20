Return-Path: <linux-kernel+bounces-524387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75454A3E2A7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425813A3C7D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBFB20CCE6;
	Thu, 20 Feb 2025 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V2/RrBWn"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290A31E3DF4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072552; cv=none; b=tEckuPuleM43eBUjWaaXgrpAtUdUMLWCyhXqhmrxUzZd54LtU3sFTGWrj5ggNRQS14JNGvGpypbFkxQF/LUdp1csbVX5vnaumHrvcwPUedL3NphBo5kHw4aS4/trtv5o2GDM3W7StHpGZnhQzfuc5gwTrZb40/wtMqp4ljRdSv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072552; c=relaxed/simple;
	bh=2L9S38y1z8Zm2vnzvPj+2uI+11xVncvT2stzj/5BO2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACZQw0sp4b7WsuBsQIjP8dmFsnXr2pH4Llg1q/0PvR551qXH9vXddgXFjuJNSIXvCFsLbGdFoo+90YQyijbrilL7dCrH/bJxfF0PYHYt/Ka6j9jWgVBYdQ9QvA/alotmnVgs+oyQFoGeFVbF5WLnBIWl8GFFgVm2SyPqEBXstdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=V2/RrBWn; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5fc6cd89f85so507335eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740072549; x=1740677349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dKf1vcFL6xViBeT7BvtPbIy9sFenGIBAFVayL6IZB0U=;
        b=V2/RrBWn/Zo+teoTjn85YegpompjEEIYKk0J18yPtJIa+cgNOQ9aG+0FprOmZfTYQ9
         dpYdgK7fgcvfApEo8UQBue7r4x5D8WPMTtIvVL3V3e/k26kQ9ymBef6vu7zj8sVTgcEm
         9suSjbJ7ocYH6Ilx8JwJIu4NXF9RsjDksomfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740072549; x=1740677349;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKf1vcFL6xViBeT7BvtPbIy9sFenGIBAFVayL6IZB0U=;
        b=vT7kGpACtmeKX3kadbt46U7iE1by6+cf5Fz40fQModgMtQ02Yl+79PtBUOUoJjmhRc
         NG5x7YHfxq7Qfj/1sTccoc4ooI3z7eqafKx+RlMvpVrwBCUoawyLM9bqNBjgb8Hf/Smq
         7+bGqXe5C4q8rTSnd7PGecTbF5ycByaRTAoz91MD0z8JWYqt+emwiQUjbkSgDKVZFq/a
         rdiqlNQfaVGaXjnFBt5RQj6DqMO4RxsmEvsi/aP+4eR10jTRtnHi1yC2BZBjwXcxj1Xl
         AINVlfyGE62Uiu4HB4wx/XtwvrwvBRwe+dSpszbDG40QBwh/7QZiRaTis2Zrpcm3rLXi
         5zoA==
X-Forwarded-Encrypted: i=1; AJvYcCXVyoRcCdQcx9YLVwxUMzMI+s0z5evk1pYMZ+Y6gF8rhncz5y9FNUB6tm7NAgjzbym5DYBzPSs8Nn1V0FI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6vQDLIBuI99uLYAqnq4BAnCAir/6NdA+8qXIO28JuScJjY5X2
	AbONXK2/7zOBYSAMgK2jGZo5MMVcxokC3sNEx4Ef+1WVwIAR5Dfes6FqlQTF4w==
X-Gm-Gg: ASbGncv7Bsp3BhwPhK1cA/6nwiilIXxkvYC06YwBMzV8TFtZd8iEVhEeDaAYSdJB8Iv
	X+1tVBsgnEd+OQKWfSY0Egr+RpFg8+bKz67TtBnIFA51CGHs7Q/HglO8EeZZAgPEPwbjJ0zwDx0
	zrPZyy8WTbCCfYwlA8u5wUd1OdXCXNEfJEATQOaszwfmFPTEWNNzKrsTkGvIbBDNu3BXZ8ZBfUn
	LMFndTd6PgHAaDRNcsMntHMUGd5l+ccLzprVrMWUuVI2Tf1dbMesvsnZPZQOuMG7RIUG01v0WAs
	RWGY5Pgmez/+EHMkp5V03nAPy21mmlfwN/MSm4sv38dK/aAgTgdJOC4wuMlWKUNlvuCmk7bhxzj
	GVMe9
X-Google-Smtp-Source: AGHT+IGHUYuXkflX6Xl2ci+0XBC0DnCcaMzZUD3gJQT0dFe4tZ5U3wxWcguP1LzcW4V9sDRX10JEUw==
X-Received: by 2002:a05:6820:270c:b0:5fc:b059:7597 with SMTP id 006d021491bc7-5fd194df6fcmr160232eaf.1.1740072549114;
        Thu, 20 Feb 2025 09:29:09 -0800 (PST)
Received: from [10.171.122.29] (wsip-98-189-219-228.oc.oc.cox.net. [98.189.219.228])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fd0aa506acsm497034eaf.31.2025.02.20.09.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 09:29:08 -0800 (PST)
Message-ID: <d18d4b5d-2356-4e2a-a318-14d0c328261a@broadcom.com>
Date: Thu, 20 Feb 2025 09:29:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] PCI: brcmstb: Do not assume that reg field starts
 at LSB
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
 <20250214173944.47506-4-james.quinlan@broadcom.com>
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
In-Reply-To: <20250214173944.47506-4-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/14/2025 9:39 AM, Jim Quinlan wrote:
> When setting a register field it was assumed that the field started at the
> lsb of the register.  Although the masks do indeed start at the lsb, and
> this will probably not change, it is prudent to use a method that makes no
> assumption about the mask's placement in the register.
> 
> The uXXp_replace_bits() calls are used since they are already prevalent
> in this driver.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


