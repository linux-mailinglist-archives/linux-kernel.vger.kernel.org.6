Return-Path: <linux-kernel+bounces-549802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1591A55767
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A97B1775A6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5604B276046;
	Thu,  6 Mar 2025 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BjKF85tG"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDF8270EDA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741292696; cv=none; b=XjU9izoCY8N6kZRrIJevjzM61JnbMF7ScNpn/nELQ3lloOIpUxDyDOKulAWpPKMN3cAZsP2m+lbpUDyGQoNk3itBHO27oVubD1ASjdJShlqW0+3n8wqh9r1DziCwW0PItffA2rfwtgTxDhD58o5J90CpCLTGV5m3pW7aLzDAVlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741292696; c=relaxed/simple;
	bh=5+q01UCSAz1jgk2+OLKId5qLJKOZQMwvwLNYE3yQS8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZA1n1AHxDGWZRLiNNc/DO3BdfmtKWEdc8JlHFRQhh7yIlvYuFISUObC8T80tqYjmL+BlVcfwvyMBDwaNLtbKrc7msV3YhbwolcSXqCmYZhcNH7ICGQL5SajxRoS32vlLwWZorqo5KOmUdX0AzP7A31Cs7cveefVTmJMcpSJLymI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BjKF85tG; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c1c9b7bd9aso481450fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 12:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741292694; x=1741897494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c1cRjxk4ULPo9wT7nsgPxLazl5DCbR3WepLIGeojf+I=;
        b=BjKF85tG1xUlfBHduZd8bJfn2ABj/0evz4GxDkKIUsUjbrKtjkceMawaFH+as3noav
         YCkcPUvABZ0P7TAIN/T9/+uGugc54E+DNN8AAU0MDMUdmC2LFf3BohNAtbeg8zbx8zkh
         IDUw7dbbIqbT3I0EG/3Ixv6tFX6HAo4JoVAa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741292694; x=1741897494;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1cRjxk4ULPo9wT7nsgPxLazl5DCbR3WepLIGeojf+I=;
        b=E7a0cv6vYOgRMjvNiCjfQk0YnWxglAB/WA6EqqGkcexYkYbm5ajxWO9RG8GDP/5TPi
         WEK3pVNZQMB8iGyi2TWlKNshJIitBF+eo9reEN56qvOVNNv6wdNnMecUobPq/kAACO2/
         ENfxrd5RFApxbdlkzx3ogDWKIkSYHpKSQ5+5P7VMMHR8dwxQe1WezEfW9c23JNufFnZ4
         mbQ2Axqrb1HJJCsEn/Vh1DT35x14DS5/mmk2/F8maXONz86ge5+Y/wnF3aY/0JngH5Y6
         PpWgBtXzegoRkWRma9bUw83/Hykr3bOemt01sT1Tta42MXdlJxXKZXB5U1uHQXHSn0dx
         6DDg==
X-Forwarded-Encrypted: i=1; AJvYcCWoSb9Ce0B6OMdxaP3mmIiiYet2TMm/mxT+R1074LrqVR+x0LuZ5t/QlDcOt0ZeNz2Yup62fYrlGhWrV8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/g7Z+1bbhJqejZonodkwN47d2a3TquLSRgeSfWv1f2MlMLCof
	aoxcQRn3ZIBK2j4BU76I9Hmft2miaay+3F317Y30+gKCTztZw6z0MobX3C/Gkg==
X-Gm-Gg: ASbGncv85TZpZSQHt2/XmdUUfJ5T76b5pX+ClUf7fw34HyRjrWpup5izANUoGFurKAE
	myCyj4IDUNpaNenXTLtTwQW2StGnH+Kx+pZEyHY67jZI0M+jSGSvDmEWaGTheKWYGJdd+N/ERMj
	6TPv7Q/dETtZ4MIAQzu+27FUVs1LNHAsIAtULRLcOdU2QzgMaBjkxAkcs3BFJh/nmwtIhvgE0Sx
	TXdiFaY//y1y9emIOudq7VEcwGdkCMtWCZpUmQuwml31OCCAHE1LmfdNzy+laTz1WrNkcd/7spI
	cCKqdp9nPAq14PzaHGB9x5F/WPzKhjAXb/XF58KwJs9Yh5ofFeyVpifn/xBVN1OaGb74LncdPPA
	RJ+XTqxC7
X-Google-Smtp-Source: AGHT+IEsGlRU88WPK+S9Ogf64O1wKb5CqscJaoSYot45vH6h/+dig3i5tKGVu9fZBtoadSDU6LYg5Q==
X-Received: by 2002:a05:6871:2002:b0:2c2:2b76:74fd with SMTP id 586e51a60fabf-2c261433d28mr425395fac.31.1741292694387;
        Thu, 06 Mar 2025 12:24:54 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2db0c3besm386237a34.41.2025.03.06.12.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 12:24:53 -0800 (PST)
Message-ID: <c147d3d5-863b-4c57-b861-687a927792b0@broadcom.com>
Date: Thu, 6 Mar 2025 12:24:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 12/14] net: bcmgenet: move bcmgenet_power_up into
 resume_noirq
To: Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250306192643.2383632-1-opendmb@gmail.com>
 <20250306192643.2383632-13-opendmb@gmail.com>
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
In-Reply-To: <20250306192643.2383632-13-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 11:26, Doug Berger wrote:
> The bcmgenet_power_up() function is moved from the resume method
> to the resume_noirq method for symmetry with the suspend_noirq
> method. This allows the wol_active flag to be removed.
> 
> The UMAC_IRQ_WAKE_EVENT interrupts that can be unmasked by the
> bcmgenet_wol_power_down_cfg() function are now re-masked by the
> bcmgenet_wol_power_up_cfg() function at the resume_noirq level
> as well.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

