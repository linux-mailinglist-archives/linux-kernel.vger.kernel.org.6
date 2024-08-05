Return-Path: <linux-kernel+bounces-275184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFB294818E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2661C21E3B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E9D161310;
	Mon,  5 Aug 2024 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LovWpel8"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F3915ECF2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722882521; cv=none; b=fVEVMIyFiLAl/iybFMXs2ptP1HPWx0ChfW+eKko4+YwaJT49kaJSpZijVzc58m7V5WTlBe6CMe4AZ0AOlDmi3PlL1TYgKzRXN1th6P+ou+A131ZzuBBhz5pCTmMlD+gZtIApagz3LlxoeNHWi9+FlCB8fxFqgb9LEl6dwLxnWVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722882521; c=relaxed/simple;
	bh=NzXgBjLy6p27MPvhpT69OWo/cTM8xBWsyl55ISoj9PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+/siMv/EE8CMXeBHvWl/I+U468YPYsN1aLb2ev2vCSUiYrJR1jwNdSYVbgHwNoq3IATCwVYG/syXJCaRT4fi7BttAGM/RBEivSu+Hz36hpbRN6YSzWWa1UKG8Rro+yLyW41ZidpQDlZZxpT+EjCkd2i0YeM7Ek1UQWT6m+wtx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LovWpel8; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a1d067d5bbso683470585a.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 11:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722882518; x=1723487318; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gvSu5xfsyPDZIgK3/CJJN4E6ZY3Iw1MkaMwXugiDJrg=;
        b=LovWpel8DgeP2Xu8+xOFGRoynxTdDwUdL5GLIggj1zcKKCW6lz2jBYgW78nB+1gvIn
         bC8TfsefeEuUqiw7IM7p0r6aotUIIjTpENKuFilCRNBeR3Q7B8DJIpkUPOP0actzwTwe
         rAHA39DZY23MzOxsuIpwiL4+7IZ/K0MR4cJ5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722882518; x=1723487318;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvSu5xfsyPDZIgK3/CJJN4E6ZY3Iw1MkaMwXugiDJrg=;
        b=jd4sASBRpGbtRRgNBJfCTbX4jb8w2IIMaRy1jxkpm4Q3sW4Qda6Xy3DWW+/4H2eUqD
         lKZduhOgw+/C37RJYbJFUCIcUBGloDMMpCTkfWB6iwhQTibTPhxHSgbPZskfoadhQZcz
         PtrK2PUUH+wGdnZyhbH6IQCFev5N5POo05xqWbCdLMYV6EY++kMyerGv95OhYmkbJG6z
         kQ4RO7OnRR6cnz5z+8SaI9WG2JOPb4IIUZ2hmzfReW5o5E6vKFy7Ogbh/9cSxNIWaJmB
         zHtHpIk7uNDpIH99kWX4Pz23fwPeB/ZeBDdgQQN6syoE4VqsovnAR9U1hCfSmQGxNuL0
         0pOg==
X-Forwarded-Encrypted: i=1; AJvYcCXc9UAac04hizeIggxvFnfJyIC/fn0Id7r+dfetN80eBMjhjHFr3hDOHEWXmt0rVGkeQda4VEUU0SavrDd0jsVFJjDeaF4ZL4JPkfKi
X-Gm-Message-State: AOJu0YxA8RojWHOj5dCyj/WRV6CaptOAouhMO0Ket+iTkxB0nULe8NbS
	dVHbaRee6FpjjnLnf7C6q/JaLfTDEyeZBp9Wf/Ja5TvQWhrwyib1dRi24Tlakg==
X-Google-Smtp-Source: AGHT+IHJhJW1tqSKFEnh01b/GyBH9GRFYJidoQjbPNxY/i4WNwoxwpGPU9BDxg/b9qugDwkj25YxOQ==
X-Received: by 2002:a05:620a:1910:b0:7a3:524f:7ef7 with SMTP id af79cd13be357-7a3524f826bmr1440847885a.12.1722882517847;
        Mon, 05 Aug 2024 11:28:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a756b6bsm31450821cf.69.2024.08.05.11.28.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 11:28:37 -0700 (PDT)
Message-ID: <1e7557b6-4b39-411d-b36b-8f05fa21eeba@broadcom.com>
Date: Mon, 5 Aug 2024 11:28:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmgenet: Properly overlay PHY and MAC
 Wake-on-LAN capabilities
To: Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240805172522.3114032-1-florian.fainelli@broadcom.com>
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
In-Reply-To: <20240805172522.3114032-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/24 10:25, Florian Fainelli wrote:
> From: Florian Fainelli <f.fainelli@gmail.com>
> 
> Some Wake-on-LAN modes such as WAKE_FILTER may only be supported by the MAC,
> while others might be only supported by the PHY. Make sure that the .get_wol()
> returns the union of both rather than only that of the PHY if the PHY supports
> Wake-on-LAN.
> 
> Fixes: 7e400ff35cbe ("net: bcmgenet: Add support for PHY-based Wake-on-LAN")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

I will be resubmitting this one with the correct email, in 24 hours.
-- 
Florian


