Return-Path: <linux-kernel+bounces-549803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAF8A55769
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22FF21778C0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873C627703F;
	Thu,  6 Mar 2025 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AffrujmW"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C271277023
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741292701; cv=none; b=oMU5kZVPm/FOHXyfjwmicIDh3fHj2Xc4bQZ+kY7re7sZQ2mYdeBFH6bPyTUX83zhEYNg1W+fk/d/HSdDSOnUy+S4luvImIqWcth8Nung9LFIY7IJcFfLiHKJ5XUVLYvBqkoUVdKp6up7OcFvNDZcWxedAWdIGl8RG6D0MdKXOyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741292701; c=relaxed/simple;
	bh=z/tDNiucZ7XZY8P/T0UQf4FhEnt/DlKMDkrZJYsaRPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OAc9GuaSVLCoo13YfWaTuCFkzuc0EZ2pObJ4wKBVLluNFWeQVSoyAsUb6bXulY9OG65XelDzck0OPRylcslk5YuoHVoUaYalYk+Mz4bcTAXNivn9cxwyWhe35Y0i2Qa9ctDnwXzsyNuZspg/11Pf7FKOHULPfQHan1/AgJPUpjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AffrujmW; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-72726025fa5so256734a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 12:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741292698; x=1741897498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WLQdvi1zrfqDVr5kxIY2N4s6FwlRipfpiqhR4wSJPiI=;
        b=AffrujmWpRBe2QDbHURZo2wFILR6nVtVBGL0Qv6D/yqWxHj2bEFSAVlpX2SNUcSM6e
         FsjyQUPEK2qeyBjpOshLdjgniJc9PLEiaznXiTBtoo+Ucnlbaniyn3QTEF2dWlmvWWG5
         s4fY4A6K6gNiCgZFTbCWPaY5wYyzv5Uw8vxuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741292698; x=1741897498;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLQdvi1zrfqDVr5kxIY2N4s6FwlRipfpiqhR4wSJPiI=;
        b=gk8t2PWOKK0XGNSmV0/lW8dKJBeJQmcFT2w+MtyPhEcj5G4mswajNiI/4G3LNMjUkb
         F5V9NmpaECPLQVq6yRIIbQ+rI3RXRW70OvsoXnQzCMzLNSEjBVqKoAloRsTguiVwW8dx
         GygKMLevi8h4TKshiV0smSNZkNa6XqjNZza0u59x8e5tk9CHYBn+s87AYbNX+itqsY0Z
         6cBBFZA3+C5C/LR9YWDjB0GWve3/DhH5NsYppf74wb5InWMsZ6+l+/xtM8P3uQgQomjU
         fRrwuKsRNuylWK9EQ797W5PgI4FzoNHdjQqKgg15Jx4xABfDQ+HUlrwoqevbFXbfNqCo
         OjVw==
X-Forwarded-Encrypted: i=1; AJvYcCUV4E8eLEHaceaAsU2xEIeJPHPNV4kTyBv/16raOD3Uo7YRlotGnELGlDvewqvBIVY900kfQjv9DDJDwWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXTT6wbVX9m3euZKC//3TipdFq18kceIM1bscP9/EyXd7ht9JB
	ur2TArDb5axKBb5+QliVerMbrXsu8lATIH2Dl7+tpOPcXcVPVXbxj1YZKPHfog==
X-Gm-Gg: ASbGncsmzXxINGbUQ2XwFFAv8g54T9b77YBb7Ys5ke191QrqXYMQi+U2KoCeA0vyoJv
	T8oi797m1SU2d8JlzlT+foVqE6mNCDuTuM8aBfQXIBsnf1hFzMgTVNeNn0Iw4EKxkPV9TZtIOLN
	xkw5HnFzgKCAxztn+79ax1nn2OF6XGrUMZuvTMs4+TkzvsIF/JuI4g+3FuRnhofXwoHU4ANMqEM
	HL43sZSKTjKgycoYYUMu11L9Kfi/B0CVJiFfTFToDshJJ8rYb7VxAbeJPkPmV7Ye0eLIo3BRQbN
	poTm7KMYPyOWbNZUZK7EvKuusEWMfEM1WS4LWYXtvKYtzQxlsv4t6pHmXNck0QxDvWgH0o7y74d
	4whiEftg7
X-Google-Smtp-Source: AGHT+IFSPs+Ds6YjO3zDZuv2Bdr0asF+mDNo8nVi4QB+KDU7taqgFIOoBBb7e4KMFcFuCedL1szBsg==
X-Received: by 2002:a05:6830:3110:b0:727:3b50:26bf with SMTP id 46e09a7af769-72a37b7b126mr360556a34.7.1741292698394;
        Thu, 06 Mar 2025 12:24:58 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a2db0c3besm386237a34.41.2025.03.06.12.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 12:24:57 -0800 (PST)
Message-ID: <4f6a4d12-2103-4fe6-8f01-be6980671002@broadcom.com>
Date: Thu, 6 Mar 2025 12:24:55 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 13/14] net: bcmgenet: allow return of power up
 status
To: Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250306192643.2383632-1-opendmb@gmail.com>
 <20250306192643.2383632-14-opendmb@gmail.com>
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
In-Reply-To: <20250306192643.2383632-14-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 11:26, Doug Berger wrote:
> It is possible for a WoL power up to fail due to the GENET being
> reset while in the suspend state. Allow these failures to be
> returned as error codes to allow different recovery behavior
> when necessary.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

