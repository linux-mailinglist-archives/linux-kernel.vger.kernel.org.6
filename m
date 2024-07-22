Return-Path: <linux-kernel+bounces-259156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E060D9391F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BBEBB219F5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A41416EB4B;
	Mon, 22 Jul 2024 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ldex+0BA"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CDE16E870
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721663035; cv=none; b=IbwlvOM47V/d8oIxud7J6c+xLR1XBnIxEScR91VRl8t/TLk4ePAZytCl3p5NV8rVO+e7reLXScut7jt/hOqwRj/AwGQwr03SGRn8V6xx6LOYQMBIH+xkTq8U+6aiYZOkeOBfkKmc3W1GlczRV9yVXUiKilE9iOuImR9ael+0S+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721663035; c=relaxed/simple;
	bh=mOD/VqOK3QRrsU9wLyLJWrcLSaKFWSraizA2iYJ1WCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzUiPzxa6pMgikz3n3gSM9vdR35A46AJgQEMq/yKELXquaf0FWsLFBUWBQBhMcZt/PqM3rEDtZrmMuU69E9e7xvLKJPfbe3u5Myv24uuD7WYtt+8PMHtMVPRDNage2gt9BAIpL14Cqf11D/+ediw3hFHNMSwq1kvEVbtsngedZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ldex+0BA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fbc3a9d23bso26545085ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721663032; x=1722267832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HY/45sHbJIy2qcayb7XSnbeV+XKE0XpbEA826lBhjF0=;
        b=Ldex+0BAUEKrne7z9uwbr3FNZ4nJJQoCEwfS/XvxUO1nz9h2FnY85vZ96LDRAK4T+A
         UpbghKvP02nn4nesUd+hSXPfIeVNdIu0A3RX9CihWAnwsMoblouimuOisufLlKiuQ1RZ
         oVoLXSXZC2toGi08l2Q4npeGkcJeUjYrkUsrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721663032; x=1722267832;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY/45sHbJIy2qcayb7XSnbeV+XKE0XpbEA826lBhjF0=;
        b=EXHLAPcvZZjGtBHa8d1BgtRZdzPPi6cIiWWLRfLC/M97tIjZqPFcgLjSfR7SLkGDdz
         FFb1xPUVLVExd18sRXJsKcsWoL2vyxlJYvLK/fOYMDMtuXOELEiI+3U3Aoh3uTshYnOk
         mrfvlA0ZrKgZ59xp5v2mFz4aPbD1GCpBJbzuP9juq+2iQytoYztCgk4uobYH4OOQP0ln
         7PBOEXBsBkT6/3uaSu7/trLNLPPMC8k/XhkVY01rYHnNWxIBcleO9hJ5C9PZ9RuaALKo
         0284cRyey+H5wwUjZoDd1eudhGuaHq8ttUE9elDoo8Ui+sy3H9DCsjixtsbqG9VEBxOz
         PM9g==
X-Forwarded-Encrypted: i=1; AJvYcCWA0jBjmsL8Py3OPn83f7LH8mb6/wN4F2Su+iVOWvLdfD6TEVaOsyubd9roZ07Pmx3dGQqcqZk/76EXblt5DwyVrIGAciHpTg3CsD+4
X-Gm-Message-State: AOJu0Yy/3hCKFjbFOcRYD2wrpf4xdv/F4ZkL7/oB/zDZRDTtNTu0fAmj
	Vjxe0Sq43EumTFyBVeNo6yGwE7042ojjeqS0lxptpNUzjMfNnHFQXaIhydDXNQ==
X-Google-Smtp-Source: AGHT+IEc7QufvotFWBaifCXSkm/JzCWHhi/xDKlSEy8kNnjdwaRcSS2abiLnek3SNWKqWXm2rfOF0Q==
X-Received: by 2002:a17:902:e885:b0:1fb:8e00:e5e8 with SMTP id d9443c01a7336-1fd74532a56mr47332125ad.10.1721663032276;
        Mon, 22 Jul 2024 08:43:52 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f48ca81sm56055485ad.299.2024.07.22.08.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 08:43:51 -0700 (PDT)
Message-ID: <a1bda167-670a-4613-83c4-5282dd5a7091@broadcom.com>
Date: Mon, 22 Jul 2024 08:43:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: raspberrypi: VIDEO_RASPBERRYPI_PISP_BE should
 depend on ARCH_BCM2835
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Nick Hollinghurst <nick.hollinghurst@raspberrypi.org>,
 Naushir Patuck <naush@raspberrypi.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 David Plowman <david.plowman@raspberrypi.com>
Cc: linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <8e1c6c3a32919603072bb7278c66b4d469f7e762.1721661958.git.geert+renesas@glider.be>
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
In-Reply-To: <8e1c6c3a32919603072bb7278c66b4d469f7e762.1721661958.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/22/2024 8:28 AM, Geert Uytterhoeven wrote:
> Currently, the Raspberry Pi PiSP Backend (BE) ISP is only present on the
> Broadcom BCM2712-based Raspberry Pi 5.  Hence add a dependency on
> ARCH_BCM2835, to prevent asking the user about this driver when
> configuring a kernel without Broadcom BCM2835 family support.  The
> dependency can be relaxed if/when the encoder appears on other SoC
> families.
> 
> Fixes: 12187bd5d4f8c128 ("media: raspberrypi: Add support for PiSP BE")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: FLorian Fainelli <florian.fainelli@broadcom.com>

Thanks!
-- 
Florian

