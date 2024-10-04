Return-Path: <linux-kernel+bounces-350818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5793990A0D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926FE284236
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 17:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E99A1CACC0;
	Fri,  4 Oct 2024 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IN7sH8lS"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B0F1E378D
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728062496; cv=none; b=rQNFMYUq6eINS93TpxesXLQ7vhPLrjmjr09Qeq5D7oDP3xIMID+PX1ZwXj7359GGfZsmhzpIU6JSDIEvaUBSB94JJL0XebH4mTjqf2XxOrOwRsE9LcdYY4RKRUAnQZ2BKPrbQpHntcJj0+tbl/aEVB3rWmfPBLqbWv2x2sD71wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728062496; c=relaxed/simple;
	bh=BfdJmm1VofeRTXTAGb6TdEwzYLaVzRCNaZ/YhiCj69M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MVAG1NoHM1ybhMg1M8YogzfUqlIQjm8zhBPHyof9Ddvx90BcxnbaNpZExgDlyd02SKg3JzdGtnsaysWN5rj3JqHSN9Et21nWivq3/E+2TXYdHRsj/K+yOurbEd6DkVJbLMja6jkFvquhlZ0eWceuiIMN8VFZwjT7G7yZ4R4xKpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IN7sH8lS; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7198cb6bb02so1775398b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 10:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728062494; x=1728667294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MJ4o8q5oEQS7g8KtToOJ3ZqCZToccFWxlyH+Q49ZRYo=;
        b=IN7sH8lSSunaEBpfCrJu1cVycgIz4FIbJwmdasnJ1efs+SFKRfXO1uIuJfyJTLShof
         8Eba7yTmZtJnYVEusWf2FBABNZ/bQ6WPEfDXZR2+YqnmTMtaBARUqlP4woiq0qdOP4ar
         MFjmkvDBQeSApVXEzgXx+9obaEbJCQPSEtB7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728062494; x=1728667294;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJ4o8q5oEQS7g8KtToOJ3ZqCZToccFWxlyH+Q49ZRYo=;
        b=dJ0OvnAzm/IHeCoypZFZH2lS/mfila/t74bi7aTIVQQ8tDep6Ur9Ja1oF6SZeIJ4Aq
         7KM/iLD3EiQTeOPGV+zd3LI9dCrrSPGcAbErIkUL8/07cjsom7WkBjNtf2DJmIgQ5PNI
         j6MpEuLY4OwvVeqXu9VM9Y+1Ndhi1klpeK8RxtimJAjw00RNJrig8a37T60fhd1qvE5W
         ueacoIWQLbNcpW5DhAk0MlvRulsymkCJuCtxXgG6AsJYJkBiv4UAVgpptwfTD/9ojpAv
         VR7fOAUX94zuqAEWf0UCObmXwPb3GV0zNIYvAlQeB+P6Zh2u4HtV3osva4FF1gVFRgBD
         8cHA==
X-Forwarded-Encrypted: i=1; AJvYcCXCwW++GoO0zXHnHOcov0nLFO7zoDFcoTMyJw0CY+FBxh6UmhkXUWYPAWEj/KW/esG9CcWYrDb7h8itZto=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKp7Pzs45hA9pg0XAQvDAGmkEBW0SNneHukfE2Cu6dQS5vAAsH
	RUSWIrGfNmNgW2STVcWkPbBqiNzB7Q6G0mLng5HYjeTK20ApwPE73bnjMWOVMg==
X-Google-Smtp-Source: AGHT+IELLRtiuNu+BB+69SzdV4WvLwhEBCEnPOGL+riehA3a4uXDke+DDE2tEOMEAhAaSJSQRUdtjQ==
X-Received: by 2002:a05:6a20:6f9c:b0:1d1:13de:68c6 with SMTP id adf61e73a8af0-1d6dfa406b7mr5682364637.29.1728062494374;
        Fri, 04 Oct 2024 10:21:34 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d452a9sm97549b3a.123.2024.10.04.10.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 10:21:33 -0700 (PDT)
Message-ID: <1c35bb90-24f4-494d-b7f0-def4d9e598f5@broadcom.com>
Date: Fri, 4 Oct 2024 10:21:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] phy: usb: update Broadcom driver table to use
 designated initializers
To: Sam Edwards <cfsworks@gmail.com>, Justin Chen <justin.chen@broadcom.com>,
 Al Cooper <alcooperx@gmail.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org
References: <20241004034131.1363813-1-CFSworks@gmail.com>
 <20241004034131.1363813-3-CFSworks@gmail.com>
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
In-Reply-To: <20241004034131.1363813-3-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/24 20:41, Sam Edwards wrote:
> The Broadcom USB PHY driver contains a lookup table
> (`reg_bits_map_tables`) to resolve register bitmaps unique to certain
> versions of the USB PHY as found in various Broadcom chip families.
> Historically, this table was just kept carefully in sync with the
> "selector" enum every time the latter changed to ensure consistency.
> However, a recent commit [1] introduced two new enumerators but did not
> adjust the array for BCM4908, thus breaking the xHCI controller (and
> boot process) on this platform and revealing the fragility of this
> approach.
> 
> Since these arrays are a little sparse (many elements are zero) and the
> position of the array elements is significant only insofar as they agree
> with the enumerators, designated initializers are a better fit than
> positional initializers here. Convert this table accordingly.
> 
> [1] 4536fe9640b6 ("phy: usb: suppress OC condition for 7439b2")
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

