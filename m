Return-Path: <linux-kernel+bounces-282390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7A494E335
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 23:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CEC1C21005
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 21:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BFA15B98F;
	Sun, 11 Aug 2024 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KBSyKK6+"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544CC1E890
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723410241; cv=none; b=gJeQGneAJvxzwxKwjD8v9TWUbxlUzYHY0wjg1nwKtghB+DWIKLo1B0BNWPmj0nPXGZ1wS1voLosVx8XUZI6SMPFTLNtirDghp8v/GoFtoIqsg6bSiz32LfB97Eo3Y6i43YrMjkn2z2rAorP6gf3o6wX0uaym1iIB+Ct/lvaSDgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723410241; c=relaxed/simple;
	bh=MT0y4VCRRLpriP/eAiBk2LS90ppp/gwCZQWbl04mSwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzWM46CB8RSsTzNcM05GPWA4lFpM/uLON+zq1F3WOYnj1OeWwSrrornUnkeTEX3PAUhh/TVxw8K812e5a2EojRo5sHFqLU+oYd47y15ZdoN+kcb0o8Gx0UzwQ1si0VGyEe712tmnmgnED2mumf94sQQ8WLPSZ8vu/EsCRdgCpWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KBSyKK6+; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-26927819823so2740963fac.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 14:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723410238; x=1724015038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hhwUYVWQargogqMYBVEgIa27lfgjOztqreLsgQMR2Qo=;
        b=KBSyKK6+9oytZuwXRMvcHArtye69d9rQDIFVTKhXEA96wzGov7nktC0NrGmTHjgbkB
         /My/FEWFC7HRzHqagx19VJAzVp4dDHWPHrqSXlpCc/eMO3v36MQ24WEeUauOVtc7tE2j
         rEOpFqn7SNOV+uOqv89O+ix9DIoE7MYHJNJac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723410238; x=1724015038;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhwUYVWQargogqMYBVEgIa27lfgjOztqreLsgQMR2Qo=;
        b=H/nC3wnHDrQ8NQQ0mmkmgEGeHWeJsgqvrTt341zfdx2al+FBUdu9c1Wonp17+RvFZG
         2BpudkR7C+RWLwZDJe3wMY4vXjBBIKSwd/RfxvHE8uxYnaH6N/xSmoxOJB2wS1lt8E1b
         BNAyqLddmY+j/VIjdwjQ00/5y+AIWS0kmHn8Psbv1D6wPjYNFdx55aTSvJGC963sp/m6
         oP4Wldt/KZF/2TaxEb6vR7bWTg5UOq2AShaHTK5bTdzgCvocFZgbYsfrVR4XZ2d1zjcx
         lZ8ijXq8ngSUTBpNWajbdHafIadM68OU/sEIYlplQFJmVLAHrhk599OCIjCP7sO10dkt
         c81w==
X-Forwarded-Encrypted: i=1; AJvYcCVrl/2QiywZ1Uk/nNBw4NFIqvzx9F9S/fwRL6K0XlR5NWaYsk8Mmhrfnn6J2qzDCLn/nRMbR2qI9WtzgO39tU6ujn9yyFRba1iXh7fj
X-Gm-Message-State: AOJu0Yz/LEdxwMraxrREVVECrHH7CcxEvgiLenkmjY1cABbmBOa3vlEu
	PMrTQu7y8+9eABQyCnaIAITY4DDc8g4RpluKHdFN61t/NxVHswF269TuyqaVFi6f7rhiUIcVDuM
	=
X-Google-Smtp-Source: AGHT+IH/KDSs7jY3xVlPdKDzbeU9AQUy3KjKyKP9vIgMarHgOicfawNZYm+Cmc0SbcTNJs3UiPkmJw==
X-Received: by 2002:a05:6871:4ccc:b0:26c:64f8:d6ba with SMTP id 586e51a60fabf-26c64f9d27dmr7398335fac.41.1723410238276;
        Sun, 11 Aug 2024 14:03:58 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58ca645sm2837308b3a.94.2024.08.11.14.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 14:03:57 -0700 (PDT)
Message-ID: <6d601728-7f38-400c-9a51-8170d33f0055@broadcom.com>
Date: Sun, 11 Aug 2024 14:03:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Support 'reg-io-width' property
 for shared memory
To: Peng Fan <peng.fan@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Cristian Marussi <cristian.marussi@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
 "james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
 "justin.chen@broadcom.com" <justin.chen@broadcom.com>,
 "kapil.hali@broadcom.com" <kapil.hali@broadcom.com>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>
References: <20240810214621.14417-1-florian.fainelli@broadcom.com>
 <20240810214621.14417-3-florian.fainelli@broadcom.com>
 <PAXPR04MB84598FFA4F7D8D1287D220D688842@PAXPR04MB8459.eurprd04.prod.outlook.com>
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
In-Reply-To: <PAXPR04MB84598FFA4F7D8D1287D220D688842@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/11/2024 5:42 AM, Peng Fan wrote:
>> Subject: [PATCH 2/2] firmware: arm_scmi: Support 'reg-io-width'
>> property for shared memory
>>
>> Some shared memory areas might only support a certain access width,
>> (e.g.: 32 bits accesses only). Update the shmem layer to support
>> reading from and writing to such shared memory area using the
>> specified I/O width in the Device Tree. The various transport layers
>> making use of the shmem.c code are updated accordingly to pass the
>> I/O width to the routines that need it.
>>
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
> 
> [...]
>>   }
>>
>>   static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret, diff
>> --git a/drivers/firmware/arm_scmi/shmem.c
>> b/drivers/firmware/arm_scmi/shmem.c
>> index 01d8a9398fe8..192262d63baa 100644
>> --- a/drivers/firmware/arm_scmi/shmem.c
>> +++ b/drivers/firmware/arm_scmi/shmem.c
>> @@ -34,9 +34,20 @@ struct scmi_shared_mem {
>>   	u8 msg_payload[];
>>   };
>>
>> +#define __shmem_copy_toio_tpl(s)			\
>> +	for (unsigned int i = 0; i < xfer->tx.len; i += shmem_io_width)
>> 		\
>> +		iowrite##s(((u##s *)(xfer->tx.buf))[i / shmem_io_width],
>> 	\
>> +			   shmem->msg_payload + i);
> 
> there will be a barrier with iowrite, use raw_write##s?

Makes sense, and that matches what memcpy_{from,to}_io() does, too.

> 
>> +
>> +#define __shmem_copy_fromio_tpl(s)			\
>> +	for (unsigned int i = 0; i < xfer->rx.len; i += shmem_io_width)
>> 		\
>> +		((u##s *)(xfer->rx.buf))[i / shmem_io_width] =
>> 		\
>> +			 ioread##s(shmem->msg_payload +
>> shmem_io_width + i);
> 
> Use raw_ioread##s?

Agreed.

-- 
Florian


