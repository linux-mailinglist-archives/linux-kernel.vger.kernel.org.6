Return-Path: <linux-kernel+bounces-289993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF4A954E33
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016041C24388
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FE31BE229;
	Fri, 16 Aug 2024 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N4yeOg1p"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F88E1BDA99
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823517; cv=none; b=B0QzKSZ79SM7QihQbpHiizTGbb1rrA9BLskwFCEw9hKTd0nT5Al5c7TW5X+nrzy4lTwrPhKfHignSCGdxl+Ezoqx9zll798E5BPj8vRMcFb6UCjfP0/ys1g5jkhFdxqynSb5qrfXWZb5ZP68a8pGOZ0diwY+bLIKUjh9q1F0pAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823517; c=relaxed/simple;
	bh=+UdJkiC5iOgw3cMKhKR0G8j+bwJDLQHy6tkboTYZIqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/n+r4HF1VCbFAsbqsjPU/5rTH15/gF/1Rhie/agpmJn6VMxLJm87ZJJ5JB0pqVo6/IGE1oHCSZNVJi5vc+dpCTCK4nVfq0JDYUsfe/6D9D/c4LeFVZ5T0+GTzmhs1atXnDcuSd8RXtvM6QHByacGHtB7PG5/L+KTJkIZp8KBHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N4yeOg1p; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44fe9cf83c7so11396221cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723823514; x=1724428314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GeB4u8g7bvthiAp2EHwpNlBctYpmQ6ZtDsM63/Yv+yA=;
        b=N4yeOg1p7pbDzYV7LwK4MPwnqyJyvrqypVV9xdwrLzdC4k25h+347V/XSQCIcr4+eX
         Aq9L46iej9842a6AjJUzv56yUZAzOVp7IMYtJ0GLRcketx8yZF+moA82Db25hNgKNqwA
         7PjzhtRs3MszsCcdxDj/CHRjeNjqathkOLif4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723823514; x=1724428314;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeB4u8g7bvthiAp2EHwpNlBctYpmQ6ZtDsM63/Yv+yA=;
        b=q+Vz5xW0Lfnme5hfTR+FXu4fkqC3pv69hYEFRpBX3+ygqN6g8am33RRe49ifT/RlTg
         vDXMdQBv6vQUz1v2oY5zyKlWSkcgJ7O1Ys1GcI6Xmb+nDp6v/WGJgXQFyoMaMBmGYjme
         1n2nx5+Gn9Y6YFcRJBnQfeODQJU+ZoL2QZ7i1UrZB6nVb2i1fG66ceHMO0/Uy9vU3zwN
         XaJsXsrhQJrq+NOjg+Z3Bi4KCbB35kmASF5KGltFBeg8mfPsJsvLkdalhuXBZ3+w9qkC
         3jUS4eqh3FYzqAQvc/gaHBov2v5mm+5S2QyxO92IsOXIXhZQu0rXIJQSeGi5DA6UUf+V
         WZog==
X-Forwarded-Encrypted: i=1; AJvYcCX+M8puVkoXImUi9HCMJX8+7Yl1BPuejeNrqwdEiOqnVHyaBq6HnPneB+N8eqRj+X+yMFYs2dCtTM5lKJbzzak4diO0jXVkTN8QjW2z
X-Gm-Message-State: AOJu0Yz5u55Egz9WyzFgsWz6uInKJPR7duGKC/FYdBgDkfKGT01QqTyK
	/hzdIqAkAuXOgDgnF5lvrd+/ZC3g0yIjW/06LzzKFlINrLtWKzXNlAZDEl2UFQ==
X-Google-Smtp-Source: AGHT+IEZMEYrzkm3sTfu3T4oNBUo2k7zpxyvfpiV0wmh99JAWIO1KORrk3kFhCbMHSQmcaM4V2oHQw==
X-Received: by 2002:a05:622a:550c:b0:451:a092:6423 with SMTP id d75a77b69052e-453741b4edemr41048661cf.10.1723823514269;
        Fri, 16 Aug 2024 08:51:54 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a08bd5bsm17595971cf.97.2024.08.16.08.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 08:51:53 -0700 (PDT)
Message-ID: <ed528b62-afe9-434c-afc9-e8f5bcd699db@broadcom.com>
Date: Fri, 16 Aug 2024 08:51:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 12/13] PCI: brcmstb: Change field name from 'type' to
 'soc_base'
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
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
 <20240815225731.40276-13-james.quinlan@broadcom.com>
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
In-Reply-To: <20240815225731.40276-13-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 15:57, Jim Quinlan wrote:
> The 'type' field used in the driver to discern SoC differences is
> confusing; change it to the more apt 'soc_base'.  The 'base' is because
> some SoCs have the same characteristics as previous SoCs so it is
> convenient to classify them in the same group.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


