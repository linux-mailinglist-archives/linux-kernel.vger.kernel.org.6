Return-Path: <linux-kernel+bounces-420168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1319D7645
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A7B2846E4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8C83D966;
	Sun, 24 Nov 2024 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W+8J5qT8"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BC229CFB
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732467608; cv=none; b=YayldQHutKsjnmFXw+xN8XXbV6iWtNRoJDHLCH/c/RCxRiiEg0hR9Y0SBhuq2c6saQlLlQPZHcuMi7gNJ0V50oBpDrXdvFQZFwcP5e1OmiC21FAeAvQkqukq4ZBED7oMLVOZzUNRMYUD1YBLvFBlVbAuiMBEhlDPo1xU7zzG0OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732467608; c=relaxed/simple;
	bh=jDGgratR98QMuzXWl2kRk0pCq1JrpZXJWTg8tUkgHN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WuFAKl2Vrw5svAeCX77gMvPqj6hYrTHh++70ZKLhLOjHgl+7YXfRKo6CkGvfKBlK9EtHCaCdbS+3txxqK1bdD20gqD9/MJV5EyXHorm8A93C1RnmFIeoDumCXEkG/rUGETHhF7/5wsfM7p4RIaKmXSTzIxuANbi4cQn9oSGvclg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=W+8J5qT8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-724d57a9f7cso2766563b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 09:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732467605; x=1733072405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl6qaCA4FjrSrOlL89IvgGS74AwUKWEk0HxCEUUlHiI=;
        b=W+8J5qT8tzoDjd6RJicIWV3OTNAGOovKHXUwy1WOtWgETb7aeWcVAFeiUmK0cyKxec
         ayAMBSR69IR4w9iXsqEIbjByAzyWsPSsr0ikWYAV8bax+nvxobCaHgY6XCwUQ1zPWlLP
         2OsAyQB4hrDyyGi5fYHCkaWFQRznULLBxhR6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732467605; x=1733072405;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wl6qaCA4FjrSrOlL89IvgGS74AwUKWEk0HxCEUUlHiI=;
        b=EvZuVjzsnLKaYrlwzknkdlnNbDCZnrPzJGSWe7BOgMb8qfxmy10DF3OAcPb5JRj793
         qMXoeAe9hk7ncCvnjXhESarrFYuYlgC9b1sH67qHYK9ZO0g1NpLVTRKbQ64vEcW5y3Dr
         1uPZhnTGRjIhErDoAzC4dnHJZoCnJqM5+U1FZNcCJN+Fi/Uh7rykL/Gw40pLqSC10YM/
         iLZFB95O000NFB0yfZRvTuiqxQw/ZbhY+MCKibXkot/OV+Z1eK3qPLnocYFmZzLbKpK1
         Syt20xb7XeWo8n5g34uO5i7rZD9f0efEffOkNp0Zs1QS3DmHzs4VWfB4H8pTqzef/xQu
         LyOg==
X-Forwarded-Encrypted: i=1; AJvYcCWyVPCLqO7a+1XNa6VxkqpyLVIl2gUBXLeLqFohi2iAT6pEtcOtOrIXXOU2eu61rZWvQfchnQ6iQEpOBtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz38sGN770ofcC6dbOgihKyWmlm+MwbCzx56Mf5ggFVeFmFV6pJ
	WRFqz+PalYL/7DkSVZJ+Oo0WHfcIW8U6YcQj3lfSXspU35vYFbU/+8weA21Jxw==
X-Gm-Gg: ASbGncuNmPifYhi3iRzp48P9gA4E+t4i9XgHRR/w6ffBk05Xu4Pj87LIjIoZ7hPZcy5
	67xaD+rBZMoOHbFv2B9YDGzmOevAlKmFHAMWIn4dTsu8umr1/aPPYNqgITqobEgpcBX1wCxWnfp
	OUb7RntEIeEEHdL/beOVzQ2eYip9xVtm60wrpez7PpXHFqGVC00gt7LwA0M9lNhTV0Rc2BNuwiz
	fhyPUMYO/aSeTxjupFlhbRBtw+1tsnrU5bgr9UIKFbqkPlZjI1ntKI25SNXBMf2jrJ3VJBrGn0Q
	xOiLjFrtXQKamgaiBv339fRj
X-Google-Smtp-Source: AGHT+IGwv6ltXszkTZNKWR1hqsTL9YkMtEQbN3d+uSOBBmXjG7uY/W92zTYfcHtsdsBE3RwDiVg++Q==
X-Received: by 2002:a17:903:22c2:b0:212:20c2:387f with SMTP id d9443c01a7336-2129f28ed87mr137598525ad.49.1732467605125;
        Sun, 24 Nov 2024 09:00:05 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc22344sm48729285ad.253.2024.11.24.09.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 09:00:04 -0800 (PST)
Message-ID: <13cfb66b-f904-4720-8829-a6d9db85aaa5@broadcom.com>
Date: Sun, 24 Nov 2024 09:00:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/37] drm/vc4: Add support for BCM2712 / Pi5 display
 hardware
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Javier Martinez Canillas <javierm@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Stefan Wahren <wahrenst@gmx.net>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
 <CAPY8ntBM=34pTiQ=t-CjtYEE5Ax6D=EtiY-sLT1keUkUMXuLeA@mail.gmail.com>
 <20241122-orthodox-mantis-of-reading-2dcdcf@houat>
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
In-Reply-To: <20241122-orthodox-mantis-of-reading-2dcdcf@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/22/2024 12:06 AM, Maxime Ripard wrote:
> On Thu, Nov 21, 2024 at 03:37:00PM +0000, Dave Stevenson wrote:
>> On Wed, 23 Oct 2024 at 17:50, Dave Stevenson
>> <dave.stevenson@raspberrypi.com> wrote:
>>>
>>> This series adds the required DRM, clock, and DT changes
>>> required to support the display hardware on Pi5.
>>> There are a couple of minor fixes first before the main patches.
>>>
>>> Many of the patches were authored by Maxime whilst working
>>> for us, however there have been a number of fixes squashed
>>> into his original patches as issues have been found. I also
>>> reworked the way UBM allocations are done to avoid double
>>> buffering of the handles as they are quite a limited resource.
>>>
>>> There are 2 variants of the IP. Most Pi5's released to date
>>> have used the C1 step of the SoC, whilst the 2GB Pi5 released
>>> in August is using the D0 step, as will other boards in future.
>>>
>>> Due to various reasons the register map got reworked between
>>> the steps, so there is extra code to handle the differences.
>>> Which step is in use is read out of the hardware, so they
>>> share a compatible string.
>>
>> A gentle ping on the patches for clk-raspberrypi (patches 29-33) and
>> Broadcom DT (patches 34-36).
>>
>> All the DRM and dtbinding ones are reviewed or acked (thank you!).
> 
> If the bindings and DRM patches are all merged, you can merge these at
> least.

I will be taking in the DTS patche shortly. Thanks!
-- 
Florian


