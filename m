Return-Path: <linux-kernel+bounces-325675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2C7975D04
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 00:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF8D280F86
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9EA1BAEFB;
	Wed, 11 Sep 2024 22:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OStiFe70"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F05A18C357
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 22:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093156; cv=none; b=OuK5jJMdC/4tWWe+MvFIhjnO3Tg+jxOeUmDul+6+IJMMaOtTpIdEL3wfMENEFBV/+7MXvdXdXz0GBiQVN21i04u2k0YfRzVfqtG0SiSFZCJkwk7KHushcrk33PxovUCp+6hv9Qct+z6rf4OjjZXIiHddar0a6HULdeVD5VvQioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093156; c=relaxed/simple;
	bh=er3tb85ircZygszPoyYOcNPF9PFG0IQ2v9jp7Ov2YfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxeOD6Tz5a67+xq495gLZSZdkNxUhMA818gl/U3Pkkus9sM6bGogUaSPTWr1IBajsqr+ffZE28cHpxVnL3v6ny+iVZbC7oVWOEkHYoopo4TbCz22H9VEfvv8rJsyBeOMqEUFnmHjKAVt4+V7ohmwuCgfRcbvSxnU+n0JsnLepVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OStiFe70; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-458362e898aso2056111cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726093153; x=1726697953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k55VfUJ1C4ye31OAEZG0IO0JDzp6JMcyO2yRINkLDjA=;
        b=OStiFe703fC9paPrj5+mCcVmrOds7wTHAg+4duL5sc4GsSjja8nRRkYGl17Azyg/T5
         JhoRi87dXp2qmUhDLi3lEEsb3LM4Pf0ZcpA7F18LEpEUVEz4u6heaw9r7azL8o7ZCBWG
         2d+tCf60BMSLL+ZP3kImCRg6TJ06S+Nsh1Qhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726093153; x=1726697953;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k55VfUJ1C4ye31OAEZG0IO0JDzp6JMcyO2yRINkLDjA=;
        b=e7r1Squ9RxX+bgWTlQaLhy9zB0JZt0FPTpyeOemd5Vy+jCNPLQLPH6l4Um4IS7M0HO
         j9YK5XTGKy6fnnfrr67hZJtThroMfOoVGnOAaej09zozQ1cpMo2n69+7+Dp+ENmI5od6
         JmSd/ALZ7FfApNN0AFhvw/NU8CBUrN0cerjs6IEWk5zOebsakmF/K4TYC1vCYzAgb+lC
         QxqB/RYxKv6fJgpIb4X7WyJz7q78NLBih8Z25Pg2wkaRz63PPXz6KbmHZSwO17ihftXl
         XS6KqyjZ1UF+IVNENmvO6tThC8B7O1CaCSqmtVgGHRBExfwd121pSGLBsoMy7pn116+X
         t2bA==
X-Forwarded-Encrypted: i=1; AJvYcCXrgD0hJ5MV7TiPPeVccLn5e3ngp4m3gYc0jyAoKj4/SQMu1pGtJgbNoCFKt/5GZqpjYRzJ7JZ7JmKNOOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEFW/qUt8e5CpFaRRQD30yzrM45Ku/vxCWYvlO1J+oZ97175aG
	szmD8SWQ/jhsFdCYWRQh2rHGXZbJSWS1q4rTQ+u4q+ICUKwm/mP+Z6Ni5bffezBl7bvCBaWbWbf
	pHA==
X-Google-Smtp-Source: AGHT+IFzaaraF27qZK70MnxOlT3/ovQoqRhWVN8npbIFiMpGleDPWV2+eQWDZwERjOYqy4rJ7VvV5w==
X-Received: by 2002:a05:622a:34c:b0:458:2c40:e08b with SMTP id d75a77b69052e-45860325867mr12957551cf.30.1726093152781;
        Wed, 11 Sep 2024 15:19:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e613a7sm45917571cf.2.2024.09.11.15.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 15:19:12 -0700 (PDT)
Message-ID: <d4ba49bf-60fa-4c5e-a1a8-52b1668b3d30@broadcom.com>
Date: Wed, 11 Sep 2024 15:19:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: rp2: Fix reset with non forgiving PCIe host bridges
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-serial@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, John Ogness <john.ogness@linutronix.de>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "open list:TTY LAYER AND SERIAL DRIVERS" <linux-kernel@vger.kernel.org>
References: <20240906225435.707837-1-florian.fainelli@broadcom.com>
 <CA+-6iNxYwyfATMUq+nJfH_a08tdx_HT3k_d0fNS8f8-khghTfQ@mail.gmail.com>
 <2bb3a405-cb6b-4033-99f4-ecd25ffc095d@broadcom.com>
 <CA+-6iNzFb_dn8cv_OkniWPEGZHrwtgwBkuJizn4icy-d9xPKOQ@mail.gmail.com>
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
In-Reply-To: <CA+-6iNzFb_dn8cv_OkniWPEGZHrwtgwBkuJizn4icy-d9xPKOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/11/24 15:16, Jim Quinlan wrote:
> On Wed, Sep 11, 2024 at 6:01 PM Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
>>
>> On 9/11/24 14:47, Jim Quinlan wrote:
>>> On Fri, Sep 6, 2024 at 6:54 PM Florian Fainelli
>>> <florian.fainelli@broadcom.com> wrote:
>>>>
>>>> The write to RP2_GLOBAL_CMD followed by an immediate read of
>>>> RP2_GLOBAL_CMD in rp2_reset_asic() is intented to flush out the write,
>>>> however by then the device is already in reset and cannot respond to a
>>>> memory cycle access.
>>>>
>>>> On platforms such as the Raspberry Pi 4 and others using the
>>>> pcie-brcmstb.c driver, any memory access to a device that cannot respond
>>>> is met with a fatal system error, rather than being substituted with all
>>>> 1s as is usually the case on PC platforms.
>>>>
>>>> Swapping the delay and the read ensures that the device has finished
>>>> resetting before we attempt to read from it.
>>>>
>>>> Fixes: 7d9f49afa451 ("serial: rp2: New driver for Comtrol RocketPort 2 cards")
>>>> Suggested-by: Jim Quinlan <james.quinlan@broadcom.com>
>>>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>>>> ---
>>>>    drivers/tty/serial/rp2.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
>>>> index 4132fcff7d4e..8bab2aedc499 100644
>>>> --- a/drivers/tty/serial/rp2.c
>>>> +++ b/drivers/tty/serial/rp2.c
>>>> @@ -577,8 +577,8 @@ static void rp2_reset_asic(struct rp2_card *card, unsigned int asic_id)
>>>>           u32 clk_cfg;
>>>>
>>>>           writew(1, base + RP2_GLOBAL_CMD);
>>>> -       readw(base + RP2_GLOBAL_CMD);
>>>>           msleep(100);
>>>> +       readw(base + RP2_GLOBAL_CMD);
>>>
>>> Since the assumed purpose of the readw() was to flush the writew(),
>>> would it make sense to add a barrier after the writew()?
>>
>> AFAICT there is one which is implied within the name, as it is not a
>> _relaxed() variant. Did you mean a different sort of barrier to be used?
> 
> Not sure.  The __raw_writew() is followed by __io_aw(), which is a
> no-op on arm64.  I don't know arm64 well enough to know if a follow-up
> barrier is needed.

By definition all of the {read,write}{b,w,l,q} do include an adequate 
barrier and perform the adequate endian swapping since they originated 
from PCI drivers on x86. If you do not want any barrier you would have 
to use the _relaxed variants, or if you want native ordering, you would 
use the __raw_* variant.
-- 
Florian

