Return-Path: <linux-kernel+bounces-428039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71289E092B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B913282404
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60CD1D95AA;
	Mon,  2 Dec 2024 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C6A/CaQu"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EE8163A97
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158624; cv=none; b=AC4mxlSW+lrlTqnjfc0l4tsr8hO/KlxmL5GcwUfFSAySQaQdNI7udg5Q8FcpLbop28XsklpTu23DlcmCaJueHMpa2ncsjhzDuFuFs0qPJiiDQOJpyR7PTQ/4Uvj/WA1pCYmwcXkNZOgR8U6EE5dfXQIkOJzoNuXbR8sLXpDA5SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158624; c=relaxed/simple;
	bh=LVn08ZxeJQGSZKVbjwT13F9UCz6qG7BxwkrhQBQ5Dtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NcNLnqf5O9D5uCxDJSmFtqeLMamT2nNOxgfb9S/Pyb2V4uYSAa59nQHYlv95mV93dIPrDfHw49UG9U0HxXYTFbWQ2fbtAzTGIGGhx4HCSWBPVHYr5ljJU7Y5drmxfoMbOzX2cT7LEkn9peg0wOpbA9Py0YrRrgXxcEw696F5PLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C6A/CaQu; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7250c199602so3745959b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 08:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733158622; x=1733763422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wCAGw3CcdeUl+tWZLwElBhDe64DQp1bTeOLewMFgc3U=;
        b=C6A/CaQuWq2LQpcObQ7HkkOJ7LmUTR93FWmtvnWcxoDy0IH0u6gvHBvbQM2SPMYVKh
         O6knKfLOcOs2ZgR6rMNUPZtkS7y1MmOAbhurqnyCkQvQFNqvJfXGxIPvUF6QgY0kHb6F
         2BE4yjS+u0pO75QDAp56lVEP3HaaGqvgpFmtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733158622; x=1733763422;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCAGw3CcdeUl+tWZLwElBhDe64DQp1bTeOLewMFgc3U=;
        b=QvU1ZiXkj/E7mhzCEuSUWcIKZxhZZIDFhymj0OWMMyifgZDDXZMACAO8nQgJoGP4LB
         8u421QM+ZtNGo1nRoX2+4SGuhSk8ltSZhduWKWVVJW9tXXeTBFW1fLuJq4Py/ZC8KMLz
         YAAl3KgFLLc3ScBnK6V8Jxtnc0f8Sh8ILcPJLpXTQRMfgwJ65kfneYKzMPyn7MMub9aR
         Vl0ZDwWQcM8sIXWcahSyZcJNuPoATnjUdU2Dyl+p7cgBbNO3EEHiUer9x7PP+/hcVKf6
         1AI/6Cv4pNQcjxC8VzeZ3lwL8+K0XyllaBcwSZOVE90Et5FVmWV1iIvKnPYIaiuAXkGE
         aRog==
X-Forwarded-Encrypted: i=1; AJvYcCURTkC7JI4fT1V0u6Dqs5weOVXIkjJqXg07NT076nJxU3GL79fRXj61mtV4FJLh5WEgUz6Ak2tvv4SeC74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy8++LOQNYf/qpzpeOINoD/x0ILSbSF1+d0twTJdT8T4BtahNu
	5D+bUajZdNx4g5CmckL+rxDc+DMkzUVRrLtM5FdMydfns6z6LgltkPlcAMNiVw==
X-Gm-Gg: ASbGnctvoA8aZP8a99PEO6iZQV91C+3/6anEy9INHAzeOIiRUzS/6WY9uSPBPInQ64V
	gQMWYBRW6hCyWLwjTj7aV1BmcoE4S3PeMFdEM8l8+JWdhw6SfsneCVtT8wPFvSjWs+KnhOJF7qG
	XjcR3dKrDJmEZ0BZ+nLaSwdqXDtyjhSNc7cGdG+dzsI5GYFMl3vCYw1IWWE7lq662zmavRZdzp/
	61yVrRgswpQeS1Gp2Wrnbp2JucRORy8hdO0PrJ/NfiQjvp2gs7OmdFO7XDrATr4jXWVEQAQfvzg
	4PW/VD5ufs7njQ==
X-Google-Smtp-Source: AGHT+IHw3XDkWltSNr6nZink1lbc1pck3rHLuglw9OPS87ycLWANAwGeGA+PLT7Pf2yscolP02SgOg==
X-Received: by 2002:a17:90b:2681:b0:2ee:f80c:6892 with SMTP id 98e67ed59e1d1-2eef80c6a63mr529291a91.3.1733158621793;
        Mon, 02 Dec 2024 08:57:01 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eecd83914csm2036849a91.0.2024.12.02.08.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 08:57:00 -0800 (PST)
Message-ID: <10f3e9a9-187e-4c1e-9e1c-9885da4ace79@broadcom.com>
Date: Mon, 2 Dec 2024 08:56:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/bcm2836: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND
To: Stefan Wahren <wahrenst@gmx.net>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Lukas Wunner <lukas@wunner.de>, Peter Robinson <pbrobinson@gmail.com>,
 "Ivan T . Ivanov" <iivanov@suse.de>, linux-arm-kernel@lists.infradead.org,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
References: <20241202115437.33552-1-wahrenst@gmx.net>
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
In-Reply-To: <20241202115437.33552-1-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/2/24 03:54, Stefan Wahren wrote:
> The BCM2836 interrupt controller doesn't provide any facility to
> configure the wakeup sources. That's the reason why the driver lacks
> the irq_set_wake() callback for the interrupt chip.
> 
> Enable the flags IRQCHIP_SKIP_SET_WAKE and IRQCHIP_MASK_ON_SUSPEND so
> the interrupt suspend logic can handle the chip correctly.
> 
> This was inspired by the patch series "irqchip/irq-bcm283x update
> for BCM7211" by Florian Fainelli.
> 
> Link: https://lore.kernel.org/lkml/20191001224842.9382-1-f.fainelli@gmail.com/
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

