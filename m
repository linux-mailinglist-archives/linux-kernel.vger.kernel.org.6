Return-Path: <linux-kernel+bounces-443730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3C49EFB3C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2663E16BCE3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77D3223E83;
	Thu, 12 Dec 2024 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SJh905U1"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81646223302
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028714; cv=none; b=fenYRbnPFExkvEEF0fWtolGi8pCyHzz6uTDTM0dtSSt+c81l/z5kStvs+LsDS65cBnG77DdFBR4Rt1VImR5dRHmaXd9W/5UFmSGOfE+Po4RePmtE5qPFLs+jYwivugTYtzsJ68oacp+E2JsrwNJ7tYEN8GdGtrXhL3VCsBfNE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028714; c=relaxed/simple;
	bh=ZB1OioAHkXt/OCBly9Y06hmqji22bScpGu5hoRZRo8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lDMzN7Hoqc36Nu1bHv19VoGqNIk+2ipgdfh/dHiWLvyp1/Wt/5ZFNBM7CkfhPEwGDAKKSbgfXuhI00rvj0ScGCEm3joL+5W1HvWedh+hKzNhPa+JgSVYr+aZ2yRaFmGBzOEqUX+fvu5MleUoIu3bjit+vL2YqQUjaYwKYHfw9LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SJh905U1; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-467a17055e6so4543191cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734028711; x=1734633511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RY4XSszRMLAuP4zkppmQozhG4xq+ulRYZgxgC0WoT0M=;
        b=SJh905U1evagdmYRrWnQaKDvtmGO2BipoMD9+yeYprS0EzwnRefjxztEDvXIwyYKQc
         sW+IHoajD3EBw3XV7XLmVRfPmQ1b/HDA7GRGgHmTuhEjNE1rbYPquQZx/fplsunSKZUR
         SYq6dn+1uaukDQIheJgh2HvVlchtCSPe5FGl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734028711; x=1734633511;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RY4XSszRMLAuP4zkppmQozhG4xq+ulRYZgxgC0WoT0M=;
        b=kykXAwwNmLL3td45OKRCWRjmUwKtz9hHo53mJS2KcZ9lzh0qik/rPiUdc5ov1glP4d
         OLVBEeO0rfCy16IWiDYFbZtrJQokR+QqeFJsJdbExp+/v1s79cC97exXkF5NlBJpSwmT
         rQhrn717iC1OQelbx5D8AYMLdUqm6VbZniiMJtiQGFuUy9Dc+0Hq50FK/maEZAiB5oBm
         L5CiAAdWwr64nIXqBBN+gM36JS83J3tO7e6DwEGekMT3lbK9RGiFnIdDT7klo4ChlW40
         rrnRZ48yx1Sn7e5wi7dDixLsjp4FvdZv9A0xKkWL4BDTXRkVE6+X7R8x7lFJ+e0LaBYe
         LpRg==
X-Forwarded-Encrypted: i=1; AJvYcCXSDpegEBJHG6hnkKZVHaIpdiCiRH7yqVecbqmTCYkFSGFrgkUVo1f0dUtlwKNlLBYmnfuIJs191DRuDGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx34DIsZUkIWmSFO0MZAmM5bmhCe62yYoqomXxvqQ3Ql1kRaJlK
	57/LziydBbPJinKLj2hTVnNFdlXZ6yXzx3mIOPa/8JeFZ/mgk3VmWVz3jBWDpQ==
X-Gm-Gg: ASbGnct4KwPaIa6SYeWim3n4+v4bJ9J7fPdIylPRRdanzNNvgiGQ3gaH4T+rhNsiM5Q
	wygeSXgud2ZnDwfplVl5dy29vG2GaG3lgRcq6wCzMGidV3QusxOglgh1ROeQn9xfpONMmJJ0Fp8
	Y4/pX8LSnCedW2LLFDKcttB4oijKgJD7GmRxH+xU/fgdRRfnvvhbtwZM4RM4iBlly65/Z0SW5V6
	VqakkNJc7ZhysSLuduxG17bslb704jRnrBCFcV+408BoZOlxZ2mRh1YOwNj2362uKcq9s7TKNaV
	hAImKT5arEet5lkTObY8
X-Google-Smtp-Source: AGHT+IFrSej8gbXB5/x0xpywNqXzp00kjSoVVwX6s0c/neVrhKP9+H9a21BzIInAst0EQtH7/Krmkg==
X-Received: by 2002:ac8:7dcd:0:b0:467:6833:e30c with SMTP id d75a77b69052e-467a1633a26mr20778431cf.30.1734028711389;
        Thu, 12 Dec 2024 10:38:31 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46793279fedsm15658671cf.64.2024.12.12.10.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 10:38:30 -0800 (PST)
Message-ID: <deed2858-ceaa-42bd-85f0-2b280070437f@broadcom.com>
Date: Thu, 12 Dec 2024 10:38:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] dt-bindings: gpio: brcmstb: permit gpio-line-names
 property
To: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Eric Anholt <eric@anholt.net>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Doug Berger <opendmb@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Thomas Gleixner <tglx@linutronix.de>,
 Stefan Wahren <wahrenst@gmx.net>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 linux-gpio@vger.kernel.org
References: <20241212-dt-bcm2712-fixes-v3-0-44a7f3390331@raspberrypi.com>
 <20241212-dt-bcm2712-fixes-v3-3-44a7f3390331@raspberrypi.com>
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
In-Reply-To: <20241212-dt-bcm2712-fixes-v3-3-44a7f3390331@raspberrypi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/24 10:36, Dave Stevenson wrote:
> gpio-line-names is a generic property that can be supported by any
> GPIO controller, so permit it through the binding.
> 
> It is permitted to have a variable number of GPIOs per node based
> on brcm,gpio-bank-widths, so define an arbitrary maximum number of
> items based on current users.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

