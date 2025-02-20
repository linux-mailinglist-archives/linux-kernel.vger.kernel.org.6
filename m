Return-Path: <linux-kernel+bounces-524386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C2EA3E2A1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6B43A3603
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8BF212D69;
	Thu, 20 Feb 2025 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Py/2apbW"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5174204877
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072515; cv=none; b=GVxGeTAGsjlNRya4AXW5r5XYMwLpvuRO4FJfHc0sp5czP1oPMXyY2v/VrW0sWTpkzT48wYAB7JOYy1LOsALf+kYxcz3Lf8GLhap00AwMWdIPgKd0TCIRDMw5VNdJyBoptSvXGByiL6Ndz9llDjrleTVltQFIjE0BkiHKEjuuw4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072515; c=relaxed/simple;
	bh=pSF+3Q0yOxZTxTMkcKGl8KlJQbXl8XaWL05HvaA1CXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZVaMkU84fYaWnSIwZy9IWLXdAJAOKVhSdkN/1m+8604peMpRrA5TNtfcqFnJRZkTJGtPC2Evvhg/P2+RpgspecmQRiCNkSWEpwCg7xe5KMh4iCjgzwKbOpgL0EdiPe7a1BVlQTS625p7o0EUv/2VUlZGsg760eJMbL9/tTmIf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Py/2apbW; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2bcceee7b40so692351fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740072512; x=1740677312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Se84fI0QvJHv7tBsVCkvI8sK3nuKMRhf8fQQM5TGP/Y=;
        b=Py/2apbW5Sig4tCc/Q/GOYHcInyc4S6K141BMWRdD0WM+Y5hovOsN6tyxUCCopSuqx
         oNsJDC/pF4RVUGrE7IIXALvFYOML8Z2rgEfDaljG2FiZh9uEqTYJ9X5yEEk28mFgU1WA
         jehuLRqVVaWLgDLEOdFx8gKv7q0xKpNOojz5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740072512; x=1740677312;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Se84fI0QvJHv7tBsVCkvI8sK3nuKMRhf8fQQM5TGP/Y=;
        b=wu/HP1EP4FR15AjL0Lq/LEPGKKB94/c5f+mqNalLxzjGc2Ke4BugFYr9RnMsZ5NVkU
         NDb5+XI/YAFujuzCiHEg0Jod9uGkTHek3XOiIN41/VoGn4mMxZ/v3wvD0LSzs5JjW1sF
         pC6s/s388eYvEVZI7HIQ/SjTXFY24L6twhON51NdSEUUymc1jfZABV4VdULuwHpolHb1
         R4j8BuuJt5h4WM0TbO5M4W9S7kC39Q6jZiatnwRHbb8DXmjzIg6AuKrW5B5fJTIVE2Dw
         jMtEZ7aLCgf/kx2dDCB3bYv6jPIDsK56iPUvvHN4v+43NAk7RvwazGcK6RbixASYcXLi
         g6hQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1bobRCspnNplCo150LlWLOW5J18ZZBqQIBfY5VfF+2dXNo8LzVx4ucF9+k4H42GK1poJQAWWYCwb/mfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6TtPiit/T8c7h/f4xeAqZgEviiJrU6chPAYgSK6la2N7SRWse
	BrE7gnoa+FlI8rwtfF5NQnQWf9re4+a8jc4b/ULVxPh7F3sf/4i8ls+MUL3jRw==
X-Gm-Gg: ASbGncsi95I0X1PXeUz+/rPXud+RuX66br5vfrWtg650LLF7iyRQujO1Ztxkqd/4DBz
	epGwyN4nKP9vVcBKt18eCzTD/uu5HdzdsPAvRevMK4QFViZeYHUoR3eTdFrWUyRxBmCAzC33X9Y
	T/1dp69onKOU6zU0D7iRKLHOKOEgHMPNdBvvghwxpC71BBS6ThGxiIIvkX7K2ZrDV2ldMuPcufe
	03NmfcgSvBUWd5YEb36cFeIRoaR7ilm95C8NkQT+cdyzQVBWReLktJEdDc//eUnp3jT0k8BDNx6
	KsAKnIbvar+m+6+sAkxaMnVo3UyIdAPlHAsHJo70pasl+H8/g09SbocEHJVnPyeJYEdBvOZdemx
	tE56g
X-Google-Smtp-Source: AGHT+IHx2vbvGJAHIaFv9cg0KxSVcmogH7AF0Pu9XJIHUk15LcaEcO3igriQn9XHQKeAmlP5LjbZFg==
X-Received: by 2002:a05:6870:5688:b0:2bc:7c3d:1918 with SMTP id 586e51a60fabf-2bd1029003emr6698012fac.21.1740072512624;
        Thu, 20 Feb 2025 09:28:32 -0800 (PST)
Received: from [10.171.122.29] (wsip-98-189-219-228.oc.oc.cox.net. [98.189.219.228])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b95486cf40sm6433631fac.16.2025.02.20.09.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 09:28:32 -0800 (PST)
Message-ID: <110d6471-d7a5-43bb-b768-dcbfb0f029eb@broadcom.com>
Date: Thu, 20 Feb 2025 09:28:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] PCI: brcmstb: Write to internal register to change
 link cap
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Andrew Murray <amurray@thegoodpenguin.co.uk>,
 Jeremy Linton <jeremy.linton@arm.com>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-3-james.quinlan@broadcom.com>
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
In-Reply-To: <20250214173944.47506-3-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/14/2025 9:39 AM, Jim Quinlan wrote:
> The driver was mistakenly writing to a RO config-space register
> (PCI_EXP_LNKCAP).  Although harmless in this case, the proper destination
> is an internal RW register that is reflected by PCI_EXP_LNKCAP.
> 
> Fixes: c0452137034bda8f686dd9a2e167949bfffd6776 ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")

Likewise this needs to be shortened to 12 digits, with that fixed:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


