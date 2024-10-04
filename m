Return-Path: <linux-kernel+bounces-351567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF4599132A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 01:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB931F242B7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03197148826;
	Fri,  4 Oct 2024 23:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d7yJGear"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7646153838
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 23:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085047; cv=none; b=m7XcuwircRK6o1piQQZSUTALP1HSqyeXFUiqU8i8XmfdMa1qHgXfD0YOMdczRuLeOQ7+6q+qeutGs0zRmkAfOCSyJyqr/AfEyyBsdTpshzE4j0/KwdzXfHUBhDnu4U7D719Ub68pBGEGBHhm/OqJrU92IQ4GpZO5dh/3ObB05ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085047; c=relaxed/simple;
	bh=ISRW4DEGbc1IRYs8vAe348Nx13J4CAC57iym1ULCqiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eAV3LC9pP2c0dxumDzmJZqwj9IcA2LK21W/SYmqLeWFaoTfCg3sX4X4rvdKReXshMM961AqKBidYyOde5pXlQjcXEBnVAZ6TK6H8O0vup+tk6VOn6zvC/KBn5umuTaXzqauRY2/ftVx0fdZGJGuRSb+vM4pvudzUHnYGq8zoDO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=d7yJGear; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e0be1afa85so2285597a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 16:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728085045; x=1728689845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bhp01HYVejj6s0Evn+kBYf3ZUQxgKuSRHFNAaxqr3Gk=;
        b=d7yJGearc/Kp6n+HkXaMheQtHTsJ+8qq04Na/fLFpISHtHSmT4IlArck2rmPsXXmUG
         e+a+m4uybgsMfisKf82LCUpzx0TJn7JOmNT/ejZ4jsWvNxQMYCoy4lxrd879dDiY5Pnt
         RiNY95V3Fzczc2u14P0UQ1xeCT/dqW1igOQaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085045; x=1728689845;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bhp01HYVejj6s0Evn+kBYf3ZUQxgKuSRHFNAaxqr3Gk=;
        b=esXOp4IFh8sN0hDL4Xe6w6jtAM0hOxjw2IS1/Cel+JZFGV9FUVcbDpQ47vdQNVISFu
         VoS3jHxC90fO68kQR+nG1QRLfmoDL+w8PQMEo7nKyj8+/s1wSjVHKWfziDX5U/4gTXiz
         KrNSVfdeH7XXZdDnd53PftOvzXbf1rdbH/94eb2cQuth7VXEDG6t67OhmeIqP6kF351C
         CuspXne2XrRUyQKsp8YV8SGwzf0FJge9hxn7+nrlXoLbFptIUlR53mZkk3hRFzOIBRBU
         5mCVhRwqKHa16CBi1HytTXrVuc4Bq8LwVvzPZqTuCLqcJUAyl8V9BQPT4dwC0NKC1CE2
         e98A==
X-Forwarded-Encrypted: i=1; AJvYcCWD7DawaZ7x/h5yFU8gL715hZjbg1YhvWv2TBTdMDgIv0BFQ/V1BWoSsPWkDEjtzZiPW7Fec+M+TJShfno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLtAaIS2XUjajhJ4kKDF6lxa3K5F/YxOPnIJW+nATGI9IR/PcU
	yIcpaeahgIDtKxKZ3OEIUJq0DA48hSDszKVcbLpHwRfRIPEXmzZQZtpQv7kHCQ==
X-Google-Smtp-Source: AGHT+IEhlzK5IHTBl+qrDyISD/4EVrdhG7yxtyo4+sxfL8etrSGCYN8a21N/ORT9K0H84Xvr6f7q4w==
X-Received: by 2002:a17:90a:4805:b0:2e0:7b2b:f76 with SMTP id 98e67ed59e1d1-2e1e62675b8mr6183625a91.19.1728085045184;
        Fri, 04 Oct 2024 16:37:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85da3f0sm2248715a91.30.2024.10.04.16.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 16:37:24 -0700 (PDT)
Message-ID: <4b8302db-be90-48aa-8d10-16b961458a2d@broadcom.com>
Date: Fri, 4 Oct 2024 16:37:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] phy: usb: Fix missing elements in BCM4908 USB init
 array
To: Sam Edwards <cfsworks@gmail.com>
Cc: Justin Chen <justin.chen@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org
References: <20241004034131.1363813-1-CFSworks@gmail.com>
 <20241004034131.1363813-2-CFSworks@gmail.com>
 <d8e12243-20d2-4a37-92d1-df6b9b32dc63@broadcom.com>
 <CAH5Ym4jTidgY9MdWzHN1=30DpOSUKf_h8nXBw21XR1VFuXn6fw@mail.gmail.com>
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
In-Reply-To: <CAH5Ym4jTidgY9MdWzHN1=30DpOSUKf_h8nXBw21XR1VFuXn6fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/4/24 16:35, Sam Edwards wrote:
> On Fri, Oct 4, 2024 at 9:14 AM Florian Fainelli
> <florian.fainelli@broadcom.com> wrote:
>>
>> On 10/3/24 20:41, Sam Edwards wrote:
>>> The Broadcom USB PHY driver contains a lookup table
>>> (`reg_bits_map_tables`) to resolve register bitmaps unique to certain
>>> versions of the USB PHY as found in various Broadcom chip families. A
>>> recent commit (see 'fixes' tag) introduced two new elements to each chip
>>> family in this table -- except for one: BCM4908. This resulted in the
>>> xHCI controller not being initialized correctly, causing a panic on
>>> boot.
>>
>> Yes, I think I see what happened here, we took the patch in the "fixes"
>> tag from the our downstream tree, and it applied just fine, we will keep
>> a closer eye on other entries in the future.
>>
>>>
>>> The next patch will update this table to use designated initializers in
>>> order to prevent this from happening again. For now, just add back the
>>> missing array elements to resolve the regression.
>>
>> Out of curiosity, can you check whether building with
>> -Wmissing-field-initializers would have caught this?
> 
> It appears that the answer is no, at least here on Clang. I also just
> tried -Wextra to see if any warning would catch it and didn't see one.
> My understanding is that -Wmissing-field-initializers is for struct
> fields, and a construct like:
> int array[3] = {1, 2};
> ...does not result in a warning because it's considered perfectly
> valid standards-compliant C per C's default initialization rule.

I suspected that much, thanks for having checked!
-- 
Florian

