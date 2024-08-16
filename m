Return-Path: <linux-kernel+bounces-289990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7773954E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB0D2881DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21D61BE222;
	Fri, 16 Aug 2024 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M6fxvjKo"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F31D1BCA1C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823469; cv=none; b=aisnF2DRgPAPF+jDH57WdaVGR0Y4rMsTUlkmTfprx9FKll8/m8f3zOme6jobojx6laDaOAxgwOiZWraC7NS5nvf0pT8duNFlMAczayjgLBJKL5BtolRv0b+DdoC9cP22rzdT8ZRyoYqmMGxAdpyps7KjsztbSgao9FSbKWxLsEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823469; c=relaxed/simple;
	bh=4lcipL/e44Lb22Xa3R82oTZxVnOPh/E7nt1AECAzeCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csXpXx6NN19/rElMaodvZT7MZq51c9PRwjuY4yijPoNRMHsAgkvOHaPu4DLkuuu9XHrztFqSH7wWuGSt+Kdh2jhUkmpqkzbk+cJYfU+oNQB1wCE6RQWaQfdZRlwNCOl58wHDfOJf7BCKaTpdOexTNgQDQsyiqia5XfS8l8NIUBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M6fxvjKo; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6bf705959f1so16566766d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723823467; x=1724428267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pAcbcvIfzFMxIDoCOPNFGf2Q6W3tIuVUn76G+MLwUMY=;
        b=M6fxvjKoqzKV5JT1ddxWE7TpIaqZbAfkhqXEg9751CJuJyNFZitrAVDnk7WkzZpAxG
         /il/5VC1j3U3qaQDjP+nuYlr3wg50jsf0hUi+NoXyNRCaclDplj7+UP+U/sPyerq47Y1
         z2o+EkGuwFoih0W1HZnA4ohtKjw50fHANJ/Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723823467; x=1724428267;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAcbcvIfzFMxIDoCOPNFGf2Q6W3tIuVUn76G+MLwUMY=;
        b=h7/HzTsO8mpi456Vdn+NWCzAMI7X8Knc235aFpEu0IICPOwnmLqEC2Ikba255+0K5F
         AArTowmBCbV7y8U2+LKgvUNN1Ig/o376YR8P1cMtUqb6qRTqetYbB8NvMyo5MHk8zR1k
         bNNgJwg+CGuU1NkYc9WUrBiv7dCE9OlzpVQZO8T7su9Ncm2ufjFf7yDJ7zk5AoaDz29m
         fco4azP7qnJMDk8K1IwWd4QHAnXQWTMBW9uhsFfmjFQ2eLA2cdMFRxlHRHYOB79Sv3Jx
         GTzOG+fFh/0EG2H1wSu8Pi2unkQnLHQIvyYACE+8PlXo6DpYYK9PIY3AQObTSf12a0TS
         c9aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP43h5Y+rJ9ZVymS5hFqDxZNNPPh/cnzE3HrFFkIjwCYETQbgCu1lP+tfHMHYiw2ARtaCs+wGKHqfectTFEPKR2AziJxYT9TuOUHAA
X-Gm-Message-State: AOJu0YytKSGnuasnT0iYbeeaW1D34dfrfXEaQY8Uc06AkiTv5LRN6Sw0
	LD3SYm3awfhyIuciYlQb7yEwnt9CRy2wdOftI4oPrEqjAtLgObf3VGv1RbptYg==
X-Google-Smtp-Source: AGHT+IEIM7ctouwZmYQqomNRV/BCMtR5QCu4/3rVHVeQWXzF2XFuKAfVwu8C5f1VSnbeJuBSYWHd+A==
X-Received: by 2002:a05:6214:3b87:b0:6bf:6e97:94e4 with SMTP id 6a1803df08f44-6bf7d528c19mr49657046d6.9.1723823467402;
        Fri, 16 Aug 2024 08:51:07 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fe1101fsm18819566d6.51.2024.08.16.08.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 08:51:06 -0700 (PDT)
Message-ID: <140ac9e4-2678-4c40-8871-a9bfaa9285fa@broadcom.com>
Date: Fri, 16 Aug 2024 08:51:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/13] PCI: brcmstb: Use bridge reset if available
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
 <20240815225731.40276-6-james.quinlan@broadcom.com>
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
In-Reply-To: <20240815225731.40276-6-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 15:57, Jim Quinlan wrote:
> The 7712 SOC has a bridge reset which can be described in the device tree.
> Use it if present.  Otherwise, continue to use the legacy method to reset
> the bridge.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


