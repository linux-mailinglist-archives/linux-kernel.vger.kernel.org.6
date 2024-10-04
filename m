Return-Path: <linux-kernel+bounces-350732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BBC9908C2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171E228569A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8071C3056;
	Fri,  4 Oct 2024 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UWKKOyQ3"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5191E3793
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 16:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058469; cv=none; b=CXczW+J9QMV91y2Pa1k5A4hUXARaPdFR9pJT8ucQTOFrE7f2R3asGFO1SeK9Amk2K1UpGLTzaldmzb91dOPCzAxOBe6KWbqxJhdyQB8EkF95GyAg58ntpbOH7ukvviboQMLPPobFr8QeWK8AhtHY2PUjSoY3QqGdNh5XQ/K2i7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058469; c=relaxed/simple;
	bh=UoIT6EYKRHo6Xa9SGSYR8+sORXfHttWgLjoOWLldjVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IpegSudpXNiF1k9MOoRd/qE1ujsSpduAzRagqXcNv4LW1oWksCHY47m4tNlLSVAYngkcWyvbs5rsg/VwDqgFOTpnT+TxenLMNf5Y5Nl8jNw9tCPEZyrm5SOfXRzF16pDzbU+q3Q7hbDMV+Rbm964hpDgdYiLGY/evSgZpzPC3Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UWKKOyQ3; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7163489149eso1932672a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728058467; x=1728663267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cvJQhMmZpu/noxTEa/v4JGbaLrcquCziF/BJJZjakIc=;
        b=UWKKOyQ3A4UcR0CM6Y3UcvnwXeaEsiuBQPUgQd0OagPrr8N8oyldL1VK3vQND0Qv+Q
         mv/fZKAR/vD1tUZg2jPW2R6dezoq1XZd8oppZjsQRTwIiU6a/wDm27jaW1RJZr0zTTnj
         /ONE8P//pQcN+Wd/v19AFKTPFpmIzwu/ihem8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728058467; x=1728663267;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvJQhMmZpu/noxTEa/v4JGbaLrcquCziF/BJJZjakIc=;
        b=o+enFC52H5aEa0xSobS6NWehIgqU/mqbl4GrtNSO9wa6M6ggDYNEie4tAtwUAfECI/
         FKFKmxwLZD/j1E5+C2G5ODYptVv+KKLGUFHoHX2vVFiVKKAMtKtIlicAUYW2EuYzPASs
         0/0n9+IOPiOrAG4v281IRtOD15snJ/maZS0YoXBCSpw9PzohPAU6pKYMVr3OC0Ekhe9c
         8aHJPsguf2uYRbqm0TyTQ2Yg1e0Gnkz/e7ETHo0nExA+zUT5T6lzBBSdbxXFK71+FJ0+
         Piz4RmtVUlGcx4Z3/natwBfATLr5PXlWdzaYJAjnOTa3GjEWh2mLxhNfNB6r7f390ULC
         hJfA==
X-Forwarded-Encrypted: i=1; AJvYcCVu+DnE+fn0TZtEfvTh3P0p2KofN3t/1TzSI9YdsZ5vTgavNDGVAAUN8L9OzuQUgNaA2jo/qseWkq2TTBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLDIeFLGGc18IReSdtqyurYjMS9QeqCmtqy7gdJN4d5RkL8Ruk
	HAPzST1qBbjOIrT6JW130/kL5+SHHgKEkfMOZy9WyskZSs4IvywD46jItak0uw==
X-Google-Smtp-Source: AGHT+IEFoiiVZajezV5lhU/ioE1/Z8frXx96mckNFqpZWWYZBHeV2kOr0uTpbDhzIPCXufPpa3SVpw==
X-Received: by 2002:a05:6a21:10b:b0:1d3:292a:2f7c with SMTP id adf61e73a8af0-1d6dfae2978mr5573933637.49.1728058467527;
        Fri, 04 Oct 2024 09:14:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd0ae9sm30588b3a.82.2024.10.04.09.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 09:14:26 -0700 (PDT)
Message-ID: <d8e12243-20d2-4a37-92d1-df6b9b32dc63@broadcom.com>
Date: Fri, 4 Oct 2024 09:14:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] phy: usb: Fix missing elements in BCM4908 USB init
 array
To: Sam Edwards <cfsworks@gmail.com>, Justin Chen <justin.chen@broadcom.com>,
 Al Cooper <alcooperx@gmail.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org
References: <20241004034131.1363813-1-CFSworks@gmail.com>
 <20241004034131.1363813-2-CFSworks@gmail.com>
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
In-Reply-To: <20241004034131.1363813-2-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 20:41, Sam Edwards wrote:
> The Broadcom USB PHY driver contains a lookup table
> (`reg_bits_map_tables`) to resolve register bitmaps unique to certain
> versions of the USB PHY as found in various Broadcom chip families. A
> recent commit (see 'fixes' tag) introduced two new elements to each chip
> family in this table -- except for one: BCM4908. This resulted in the
> xHCI controller not being initialized correctly, causing a panic on
> boot.

Yes, I think I see what happened here, we took the patch in the "fixes" 
tag from the our downstream tree, and it applied just fine, we will keep 
a closer eye on other entries in the future.

> 
> The next patch will update this table to use designated initializers in
> order to prevent this from happening again. For now, just add back the
> missing array elements to resolve the regression.

Out of curiosity, can you check whether building with 
-Wmissing-field-initializers would have caught this?

> 
> Fixes: 4536fe9640b6 ("phy: usb: suppress OC condition for 7439b2")
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

> ---
>   drivers/phy/broadcom/phy-brcm-usb-init.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/broadcom/phy-brcm-usb-init.c
> index 39536b6d96a9..5ebb3a616115 100644
> --- a/drivers/phy/broadcom/phy-brcm-usb-init.c
> +++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
> @@ -220,6 +220,8 @@ usb_reg_bits_map_table[BRCM_FAMILY_COUNT][USB_CTRL_SELECTOR_COUNT] = {
>   		0, /* USB_CTRL_SETUP_SCB2_EN_MASK */
>   		0, /* USB_CTRL_SETUP_SS_EHCI64BIT_EN_MASK */
>   		0, /* USB_CTRL_SETUP_STRAP_IPP_SEL_MASK */
> +		0, /* USB_CTRL_SETUP_OC3_DISABLE_PORT0_MASK */
> +		0, /* USB_CTRL_SETUP_OC3_DISABLE_PORT1_MASK */
>   		0, /* USB_CTRL_SETUP_OC3_DISABLE_MASK */
>   		0, /* USB_CTRL_PLL_CTL_PLL_IDDQ_PWRDN_MASK */
>   		0, /* USB_CTRL_USB_PM_BDC_SOFT_RESETB_MASK */


-- 
Florian

