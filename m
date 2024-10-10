Return-Path: <linux-kernel+bounces-360172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C9A999576
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EE0A1C22AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA741B5ED4;
	Thu, 10 Oct 2024 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JMbYCP6t"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE7619CC3F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 22:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728600710; cv=none; b=PJkIjRFI/nsmRhrD0mN9FAqO3ZmOBX3YASU9jVDm2tHhkh5WSpd3xNoR7/BXZfsOaMr7TK4mRoDJx91a9R4poN0mubxGduBlQkqnIQG1SHpL2d/Fjwg7M8MZJxCL1XeT+N5J42nthBh8aGDHuLxKI+T7YQQbBaeQ7vsGGfIzbvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728600710; c=relaxed/simple;
	bh=O9NI2n46dJOuG/gvXyTlCMExFGXBBYfN1EtPQ/IAcn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AkXAZ+HiB3251X6GqjBGBrxD4t+bNm38PUd+9KTtkJRbkEzSjjdveo7s1LbjPrLj19RKu7ipCFEdae7ia3HyhcN04Bc/IpisrO641oxxawXFAky0VysEbh6QK/v2p8JEX9vDphOpsoDO+nLSD7I/zRpzyI314d0a9Yq96lV+5qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JMbYCP6t; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea24595bccso687137a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728600708; x=1729205508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hirz/foRi/Y006BZzP+T74a5rrKccQo+ZtrnI7icEHk=;
        b=JMbYCP6t6rAhh+Rz9A0WGa7ZG+HTvbKTiKvHbyL2+Biw2buB3mvaVUSaSV0sm1Opu5
         useWJfL1jDeKh3Q5g4bepgKkUP1ti2y0mA8zriBa8Y1MI6Gi8leLE/LdJuRpbgZcZQEK
         8ghaJsi/5iGOAJNB+n0OW3EI83D665VoAME90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728600708; x=1729205508;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hirz/foRi/Y006BZzP+T74a5rrKccQo+ZtrnI7icEHk=;
        b=C8EfJ3wCa+tR0D1kR+El66EBdZb/rD1EKNVAiwBPXv6JKH2aUcsKPAISiycP3B1JvD
         IzA4loKUVeVqKM9+IeiI4YrEM9QRxwpRxP3XE5rDNnGfi4VEVwPS3jlY+Q81Qav0f3UK
         9ZLFR/Hjp1pfeoSn+WEYKsM4F9xGlrdQU0HIM+4lBRmgtcQ9r/OVYkBPml0RxcHva9R2
         3nBk6iiK6N9pyYkd6BXa0UBW8aM1e9mqgUizvoV1aViZt9wV/b8HwD0Sc9ovcgxvsu8P
         gsZPzsuX+2lX+UmXH/T0k1zX+dYv3NCHB8DtliYTedTehYV6DYwPFjIMJ39f8qopOJJr
         7D9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX73+N7VH6+LMZQfcv5QAYR+TnZ4nVfvzz00NLH7lvw0rO7B/kip1o4irboVkpRwN4OLczsPJQN7GFtkgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztEeRbdhB1o/41fbb8bDgfhO7c/3zdfL5mRGXVLUqn7rPSD5Ep
	l8ZQ8fhfgNIBQmVsF7CAe+PGa+llD+2LkPJ/asc8qY/bps8oc9dSjkDKJrxScQ==
X-Google-Smtp-Source: AGHT+IHWjbeiTBm6y7XcjJr1XxybI44PIP9S6uU6g4krvxZCLs1bOMxFiyLeK0ed4TMlqWkbD+v11A==
X-Received: by 2002:a05:6a21:505:b0:1ce:d9a2:66ed with SMTP id adf61e73a8af0-1d8bcfc393amr788841637.48.1728600708472;
        Thu, 10 Oct 2024 15:51:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9f5419sm1539888b3a.50.2024.10.10.15.51.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 15:51:47 -0700 (PDT)
Message-ID: <21b90eec-6c14-4523-a08d-64313e56748f@broadcom.com>
Date: Thu, 10 Oct 2024 15:51:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: arm: bcm2835: Specify
 /system/linux,revision property
To: =?UTF-8?Q?J=2E_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <wahrenst@gmx.net>, Russell King <linux@armlinux.org.uk>,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240708-raspi-revision-v1-0-66e7e403e0b5@gmx.net>
 <20240708-raspi-revision-v1-1-66e7e403e0b5@gmx.net>
 <a3400961-ae76-4e11-ba8d-1f659f7324d0@kernel.org> <Zo2VEZ3kHmYtU1_T@probook>
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
In-Reply-To: <Zo2VEZ3kHmYtU1_T@probook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/9/24 12:52, J. Neuschäfer wrote:
> On Mon, Jul 08, 2024 at 04:13:10PM +0200, Krzysztof Kozlowski wrote:
>> On 08/07/2024 01:08, Jonathan Neuschäfer wrote:
>>> The Raspberry Pi bootloader provides a revision code[0] in the
>>> devicetree, at /system/linux,revision. This patch adds
>>> /system/linux,revision to the schema to allow it to be used in
>>> mainline Linux.
>>
>> Sorry, no, we do not document stuff for various out of tree things.
>> Otherwise we would have to accept hundreds of ridiculous, vendor properties.
> 
> Fair enough.
> 
>> Fix your bootloader or make it upstream.
> 
> There is no open source upstream for this bootloader. It is (sadly)
> Broadcom's own proprietary code.

We have plenty of proprietary code all over the place, but that one is 
not ours, it's Raspberry Pi's own, FWIW.
-- 
Florian

