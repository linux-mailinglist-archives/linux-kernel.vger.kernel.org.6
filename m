Return-Path: <linux-kernel+bounces-549762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD63A55700
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5EE67A4405
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5E7278114;
	Thu,  6 Mar 2025 19:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UXQQ0bpn"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C002780F1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290099; cv=none; b=iSdW6GEbpviMxKuDk5uUwxb1ZvHH1Z7NYshhHq3sAaAD1QX39EX6gNQrfRkj49YZSoTfmWUDSliVFTURTcCxhAQYZeyfRemveX+9p/o2s/E/ZzacY95kPnA7P8MZFUSKiJ+uBaincx2Dt70EhluKRuD3OINPyTnDOQ7bskr3lbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290099; c=relaxed/simple;
	bh=VytbGWjtNZNeuStAD35t7PaVEEApdQd5RvpwX5kqEDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGyRX2AZ++g6CeLwtNg6BN1c1dEX/QpSgbYChOkQfed879QGmjq+CD1OWQ/VLsWQXqP7+P36ZpWOiarmi50lyIQLP41KP+/WjRAO9y1IGrAvydntNAJ0u4LKIEQxQw3Ja+w5VWHv7/R6dnE9A4Zsw51czB0wruPsjf8DDvTEPTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UXQQ0bpn; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fec13a4067so1781465a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 11:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741290097; x=1741894897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m8fEN5OBD0glU1fS2O/OmMYenNWIq40nmlWq3uSeZko=;
        b=UXQQ0bpnGEftXKCemxIsHJYvrUqD02WFm/CK5qKxoFkH26rkDNrPwhAISfTV63KrGV
         Q22n4zHSkGsIIgWR/XF8VP8EflURNGPJm4OxHH+j97KqVx80TfRlKwoZh/Rr/KbCPXns
         h16qhznJGgz7jOldKylXrk+JhxLWi2dr8RI38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741290097; x=1741894897;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8fEN5OBD0glU1fS2O/OmMYenNWIq40nmlWq3uSeZko=;
        b=qjt3QX3UsvBDn17Wsj1elIhDzzya+TnfKK175rcGQqAECftvvSWiBSPvS3g8q3qdYk
         wLvRmZfYK22EhQKN+4qK9xI6JZL5+cJWkgD0in3BwKKJe6jbAfYCyLy+oxrM28FRoxYX
         Oqnb7UvPPmflvZHIEsAZCPwg5xBlJh6lxYhOyxJaT/VRr3L01AIAOCqcy7Ue4VUM4fTL
         sXofIJN12pWFHtf6wmvzA4Tb9xGIrET9A58fChBClYk0FaTSQIVGIXhu2GDY+nE3uZA2
         ufqZK8SjW2zeseVADHKji9rP/TpLtXZPwLoPbPDcg84h25mwkMl84eDAl3Nog4BVGzTH
         CxOg==
X-Forwarded-Encrypted: i=1; AJvYcCWXyLFcjHrXmMfNMWNSShi9ydpskGfolfOiyPYMs6SQhBcbZT8k9+Jecj7K53Oz74My2/Z3g7klfuCvHV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfIPiS/c4muSSK/6QVoDk/R2fPxlpLQhqv4aMJ09eLs2/ODODo
	uSdh5W0KySoVYQ9NRMhFv45UHmiQ0cBDs5Bb70HAjqTTOP/s6zZDNuyJUE+13A==
X-Gm-Gg: ASbGncsnrtgVkaK/7p6IrssZ/7xhPVaCD28/XwrAisb6oIr184LY1bNXJzN77CcT/Hz
	KJMyF2CTNKxVD+rA16VfNVmZQ65NB4E9PKTYs3RK9KupK1K2uPLEuRnZ101NGoY4YHVIIQ+EHwW
	2VoIZLcU/3gSl2FV92vSRlIsZWIOSaRZfXoFAic8zXLCb2ZPxQ3QKGWQotUxCdGDbrplE9LZ0r2
	JYuBA6FKpKVpQORzcEFsJrfTsU9wO3yIOb5R5Oq7lV3Ip7KNJdMa/7+qcJE8gxclxCqaS5d5IGA
	J9yuXkdIzYXBxVxiBn71YD5WYvl6CIVZsAL2xHL2ihr3NBcp4HEWV53tBqfokC/ZQ7qdIY/uh3x
	N4XbKbCi7
X-Google-Smtp-Source: AGHT+IHQtWu1ahkICTXWJmI6Rk2IzUYWx9JolZJSfOMyCww/iO1tIhAJvTfHDYG9dCVnj5wIlVZXaQ==
X-Received: by 2002:a17:90b:4e86:b0:2fe:8f9f:e5f0 with SMTP id 98e67ed59e1d1-2ff7cea0212mr690478a91.19.1741290097506;
        Thu, 06 Mar 2025 11:41:37 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693746b9sm1643765a91.27.2025.03.06.11.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 11:41:35 -0800 (PST)
Message-ID: <4d18d1c8-9af3-4899-a1f0-3ad79dd85295@broadcom.com>
Date: Thu, 6 Mar 2025 11:41:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/14] net: bcmgenet: extend bcmgenet_hfb_* API
To: Doug Berger <opendmb@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250306192643.2383632-1-opendmb@gmail.com>
 <20250306192643.2383632-6-opendmb@gmail.com>
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
In-Reply-To: <20250306192643.2383632-6-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 11:26, Doug Berger wrote:
> Extend the bcmgenet_hfb_* API to allow initialization and
> programming of the Hardware Filter Block on GENET v1 and
> GENET v2 hardware. Programming of ethtool flows is still
> not supported on this older hardware.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

