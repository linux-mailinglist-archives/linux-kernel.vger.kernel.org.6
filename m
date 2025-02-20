Return-Path: <linux-kernel+bounces-524392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2BAA3E2BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0303AF1A5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A37212D97;
	Thu, 20 Feb 2025 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KhGHkm7z"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4C3212D6E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072578; cv=none; b=U+Lu+h5nYHdR4JaNCSxXUusqtv42zCvwoc3CcDYEBx/py8cxns+6tlcDc9+yk2ep0+4pBa1OBSpG2VtAr6+LjWfvXwgcA42er7rVm/fzHykVMP5Y0lwvI2sGjnYk47yflDOczPrJTXpHWcGyRMTAzNuzzlz5eK5BlNiGvYCcUNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072578; c=relaxed/simple;
	bh=OMIKK8FOyrWHnC0j5QluAve9X6UXxjyhC5lNgIQnY4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nob45VQbFQbRQtaVkjd1QuHooM5k2uNUEhRZtsjuDnlEQvV3e2cC3e1RKQLlQoEk1SvrzDPDKvlvwu6Hy6H4qTTSZHJUsW+uBfAR5Rm/kXOXTHJNqDfHv0dP/X8WuRazyDced+oD1B3x2qHVoI/06cAAkQR2u9nYqRNaq/D8ehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KhGHkm7z; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7271cc3d73eso603928a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740072576; x=1740677376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kdikSYRCknu87r4IRD4jNLLC13le+VI+y2JvXDGCpPM=;
        b=KhGHkm7zYwPlYQV33lwhnuAiCykiautsZgM913OhWx1q1c+LfOcw9NpiZ4KFOpOksP
         a8rHz9jZevypA6lCyYNZTaBoWosHVUFWUIM7l7EUbDQ/xrcJPokNplzZBmJ8gnM4mVKp
         a9StjXewFPuyohafaPmU9B7xomDvuRkhhP/Uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740072576; x=1740677376;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdikSYRCknu87r4IRD4jNLLC13le+VI+y2JvXDGCpPM=;
        b=FQPSqcGBI/57m6Ks97eWJiC7lBLShZczTr+LJYeA3xzxzYBMgbi4WrbprrFbcEzgEh
         VQ0aMg1s+OEJ2ySqMut6LwsoNvhWVV5eIjC7fCHb0MxxIr+V3Zf7CMYk9VLzgprhW5Vo
         qgSMvA7tU4oW3DpBqErLvIgLVKdQrGwz7IZdgEzQEM2AqHTreRDdQ7i3Wcrb5da0Rjri
         Lsw9pD6Jl+CojvuCaJax7hd+J283ceB/7yIaLliXrowIWaj/IsnuFts8R5AivB0Rdwth
         O7IZjcFKdNNj6Mzz2SxKEcMdKXT2vQLBEx32Boohow/tEIRCib3jMe3DheIRdZu5tIoo
         gbTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXORcpvvc4Q/f+I+Fhso0Pc4FSlDdElpQhFMvzv5yCevoTxfF6u0ZssyQJ32Pzce8pGxmPY7Nmj2pnwgQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEeeGVoExjhqN0aPRchjbK3JiF0HmwmwdlLeX1a9xvkEyhH6oU
	8T3NPhSp8FZjTFIqkN/DQSa3cq+1Jo7m1xXvlfMAtB6DGZXGvaAUT4onPbj4nw==
X-Gm-Gg: ASbGncvJxoXhahxP3tlCQINC/OI1geStyuu3zHwbS/dRScrI/0gcjy1jXTIUL3MDCAy
	PYWGP+8QVGV5v+Q26lOKgwnLg4UR97vpLxMLmnf1dL9no75IvcFXTK/Dr7ENSiJTHITfhOwxHNj
	71TQMVWzUYTA7kly+3N7TbMBVGj8Mp7Nr/iFjUrCCV+N83i/Gtf050NgSUcciEOrJkjl5LQ5poe
	0b3ggz/A/Z+DLx/oap4Fydj2OE29KCUliphPS1TAdMM0XLf1BCDrdTA6jLHrfDOiZr5YJjjrcvO
	8lPYC+p1DtPzhW5tljvYIvZ5Hzs3cyvd6Dn3xQKQbLaBcueyITcgTOB8/r4rtwe0zeEuRxjNlmv
	OHD+j
X-Google-Smtp-Source: AGHT+IGZA+a9XGOETQCq4mTPzcDC3M3BrXfb2U/dru5rUVJw0B01xbMp+b+QPk3A39iTP91d5M6t3w==
X-Received: by 2002:a05:6830:2aa7:b0:727:2f9d:284c with SMTP id 46e09a7af769-7274399117dmr2635918a34.10.1740072576341;
        Thu, 20 Feb 2025 09:29:36 -0800 (PST)
Received: from [10.171.122.29] (wsip-98-189-219-228.oc.oc.cox.net. [98.189.219.228])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7272737d70dsm2344358a34.42.2025.02.20.09.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 09:29:35 -0800 (PST)
Message-ID: <d1ead47b-4b82-4657-88c3-defb44647b64@broadcom.com>
Date: Thu, 20 Feb 2025 09:29:32 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] PCI: brcmstb: Fix error path upon call of
 regulator_bulk_get()
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Cyril Brulebois <kibi@debian.org>, Stanimir Varbanov <svarbanov@suse.de>,
 bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-5-james.quinlan@broadcom.com>
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
In-Reply-To: <20250214173944.47506-5-james.quinlan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/14/2025 9:39 AM, Jim Quinlan wrote:
> If regulator_bulk_get() returns an error, no regulators are created and we
> need to set their number to zero.  If we do not do this and the PCIe
> link-up fails, regulator_bulk_free() will be invoked and effect a panic.
> 
> Also print out the error value, as we cannot return an error upwards as
> Linux will WARN on an error from add_bus().
> 
> Fixes: 9e6be018b263 ("PCI: brcmstb: Enable child bus device regulators from DT")
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


