Return-Path: <linux-kernel+bounces-297668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B260295BC43
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D13CB28C37
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6631CDA2F;
	Thu, 22 Aug 2024 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bvtyDJ9j"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC2F1CDA28
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345029; cv=none; b=mhh36b3/smN61z9qpk1o4d8WUHXjfR3ksz12tYqejHJ0EAUUBZCCvc/zs7C6qZQCnyXO0wsclSzA3ZYleun4cNRCRvMRiNfsJTKGPawTs0QiNSSYKl5+EXgU4i7Ry9n7YcuYRvT5tkkNjnICJL4hpjaWS9/IRHpE8XiUO64+p+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345029; c=relaxed/simple;
	bh=vUV+6eQAPuNrLhvow2mnEQrXqT4STDw6iajrWO5TyOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UozCZ9ALih8vmKG2JRLMN5hVAmdUe8l4SaeQT4R7ewhsU74+IfiR1U4vHT8rQLe1upsaFIAesGjK0WVduH+PqZUwVOqcDkFWj+E65+rmSjQnijX2A9aIfhLSup4UCgE2MwplY04oe1hF9XctfO5hRg9QvMcIBjIx4OW+boB1xgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bvtyDJ9j; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-709340f1cb1so561783a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724345027; x=1724949827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKTbaL/FXWM3w7cKHQVTv5E900J5Zpuy86Fh8cTkTA=;
        b=bvtyDJ9ja4NCOyRHUokFXILupyoTtT4uGA7n13TaqpnKJNBtjzq+rFt+kGkdiUZLo3
         8JvUijGHE2z+N/Ad6LlSuQzfPLjPy/x9kAl3Bjep36wbSwbAc6U9nJOIdf8h84dgMlZr
         GsPyUK05L9p626GwBRXZWgTsiaE2DFneC4hBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724345027; x=1724949827;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPKTbaL/FXWM3w7cKHQVTv5E900J5Zpuy86Fh8cTkTA=;
        b=KlT2C5GPUTpoFXm8Jfm35QR6EZwufy8RQuobmu/FSCl2zwGhrSPzknT24I+q7DZ+xL
         ZubhD8fI8IS37QdG+MgmnTiwXJZ1Dx6Wz/4d6Lln2PlwflI5keA7ZxXGMaFnrz+fXaOU
         UE08aMVbG2hsBltWc5vRWWimQZdK3kthcLaDrIDOyDoFY/AFFhHyP736zlXi/UKL+hXl
         MnBvam8r3nTtWzv6UK81rl1euNE3LKSrBz5RiRV8EX0Gi0G0Cr4jyVvRMq9XOuEfr4Pj
         nN6XfAP2+xr2PX0iZIDqIyYueTAJGSjvRPIModvq19FsegqCEEDqNogAIgpC9WDBEFed
         xRdQ==
X-Gm-Message-State: AOJu0YyNDeBXkmNfsyFPZD4HQcBfhLZ+KDwa3CUSaw48/eKZprm7wVpa
	pXaTcR4AsPOEJew4DNgRSuKiUdUpkCCImU4W5AXCFIjB2yP+pyGVcj0sUIJBfg==
X-Google-Smtp-Source: AGHT+IHtz9jB5yeucL2PQw0+jxjP6Oqe9xFPw8V6kOBRAu8q3ELTAniJIYBhireoiZ6g93E0Bm7zTg==
X-Received: by 2002:a05:6830:6f04:b0:709:4d7a:3438 with SMTP id 46e09a7af769-70e046ba56emr3042730a34.11.1724345026609;
        Thu, 22 Aug 2024 09:43:46 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162db0685sm9137806d6.101.2024.08.22.09.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2024 09:43:46 -0700 (PDT)
Message-ID: <24d73fb0-477c-436b-ae09-23e96fe7eb4e@broadcom.com>
Date: Thu, 22 Aug 2024 09:43:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 4/4] usb: ehci-brcm: fix module autoloading
To: Liao Chen <liaochen4@huawei.com>, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com,
 heikki.krogerus@linux.intel.com, stern@rowland.harvard.edu,
 justin.chen@broadcom.com
References: <20240822130113.164644-1-liaochen4@huawei.com>
 <20240822130113.164644-5-liaochen4@huawei.com>
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
In-Reply-To: <20240822130113.164644-5-liaochen4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/24 06:01, 'Liao Chen' via BCM-KERNEL-FEEDBACK-LIST,PDL wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
> 
> Signed-off-by: Liao Chen <liaochen4@huawei.com>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


