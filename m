Return-Path: <linux-kernel+bounces-294324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E42958C41
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5656E283712
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9171B86E4;
	Tue, 20 Aug 2024 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JzmVgiOw"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26155191F89
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171705; cv=none; b=fifm/OVlr5iZYG9Js1b2P0s7WBtVEZUrOiQVJuuvlKR4fqTINcUavnGaO0PetZwQu4G8Llm/wLlFJdxr7TuPp9DL8yxEjB0zlM3ypiEBSeap4O3oHmcIRpJXhG6zl3HDcmT6PsBXfKhsyc/6pSBb1w/Eu3einJVAjNVrF5TSiXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171705; c=relaxed/simple;
	bh=FS9vKrxJsQ/bz2iGYpG7dD2unzn+WDWMS3nOJz22auk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8wX3eMbuG5X6y1QPdKdxLaOwUD0O1flGFfunOS4kHDUjc2fSBZDXBZKC8IaPb5+kd9SQdBtZSrseqtajI1A1Uc9VjjCj9m7b2ThgekRbyUeZkUUIj2LKUT6JIqjcQY298OI4N5up3SMZnNhwB/Wp+jT5ENaozGp5JtbB/fWTFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JzmVgiOw; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-712603f7ba5so4630166b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724171702; x=1724776502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I/jQ4CsoLAYAWazFQRdZD0QAtpzqYEXDl/Ljb9v3uaE=;
        b=JzmVgiOwen4+TI5tOxZw9zFdH3wr+cggXk5/i02Csp9y4eYjkyethUoF4TIwqM+1wA
         xy8tiHxUqeh27lBVAbfl/9JaPWZkjNdLfXmo6EaVEySfmHvVURLBMDjOkRDAUVYX/69C
         M4pFFp0rVku6wc+AcID8ol9AkPRrZDbDRIuG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171702; x=1724776502;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/jQ4CsoLAYAWazFQRdZD0QAtpzqYEXDl/Ljb9v3uaE=;
        b=FAVrsTiUQNBOCPVxy+7jvQlKJCSidnFXAxWKreTaXfZsRgbtpsTx5Aqk1iOJS8Kftd
         gkf6pAsWlWX/aDNbKo08D9QAwVIptKsL0R124otxCMkC/VdO2S46LSFFMi+lV43FhEUs
         3MNGKFAJQGyKBH0DsPLuF3XCCWinEj1Vc/GamTSPqnNtpClDuBrIGKa5v8LMPzxvPht/
         e2pSS/zF81o0iW3oFo6vP2R4Zpuv33FPpYj7Q5yAV+wJ9OGhyQgzp/dz1fQ/iu/PwMna
         JIN0z2OmJmrA1mTMop8UXCI72zArtS8SO4g2Tg51zzTiQ1q25me3FojInw18M6A8ql5J
         KPCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl3lKkOe2rLym7fue/QrPRlfinTK7y0e4/swDoHhOKJARHaGQyjavkbNWGvuXBC/0vHiPuPeXg7LKfvM3413lrZS7/HZtR7NlH0wbK
X-Gm-Message-State: AOJu0YwViqt0iOMXqdxSlYeLV18z6PXk4Qy4f9EalRFq1P6YWBavPyL4
	CaribHbtoh0G41Jce71s22ZIoPGt/inftiOg5xdxV6/Ou0T/lF2O7k4CHcUnMA==
X-Google-Smtp-Source: AGHT+IFd776z14UzYpO+PvAZ+OsQuKluFGT6Sas0CXJ3qt53396lWSFk10aFDTPjlR6JPoZn3aRHhw==
X-Received: by 2002:a05:6a21:e8f:b0:1c6:fa1d:5b6a with SMTP id adf61e73a8af0-1cac8eb00e7mr3143945637.29.1724171701871;
        Tue, 20 Aug 2024 09:35:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add721dsm8433185b3a.42.2024.08.20.09.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 09:35:01 -0700 (PDT)
Message-ID: <1a486ead-3a65-4ef9-a562-c23ea7026b9e@broadcom.com>
Date: Tue, 20 Aug 2024 09:34:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] firmware: arm_scmi: Support 'reg-io-width'
 property for shared memory
To: Peng Fan <peng.fan@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Cristian Marussi <cristian.marussi@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE"
 <arm-scmi@vger.kernel.org>,
 "justin.chen@broadcom.com" <justin.chen@broadcom.com>,
 "opendmb@gmail.com" <opendmb@gmail.com>,
 "kapil.hali@broadcom.com" <kapil.hali@broadcom.com>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>
References: <20240816224221.3256455-1-florian.fainelli@broadcom.com>
 <20240816224221.3256455-3-florian.fainelli@broadcom.com>
 <PAXPR04MB8459322CED779885532BD852888D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
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
In-Reply-To: <PAXPR04MB8459322CED779885532BD852888D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/24 19:49, Peng Fan wrote:
>> Subject: [PATCH v3 2/2] firmware: arm_scmi: Support 'reg-io-width'
>> property for shared memory
>>
>> Some shared memory areas might only support a certain access width,
>> such as 32-bit, which memcpy_{from,to}_io() does not adhere to at
>> least on ARM64 by making both 8-bit and 64-bit accesses to such
>> memory.
>>
>> Update the shmem layer to support reading from and writing to such
>> shared memory area using the specified I/O width in the Device Tree.
>> The various transport layers making use of the shmem.c code are
>> updated accordingly to pass the I/O accessors that they store.
>>
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>   drivers/firmware/arm_scmi/common.h            | 32 ++++++-
>>   .../arm_scmi/scmi_transport_mailbox.c         | 13 ++-
>>   .../firmware/arm_scmi/scmi_transport_optee.c  | 11 ++-
>>   .../firmware/arm_scmi/scmi_transport_smc.c    | 11 ++-
>>   drivers/firmware/arm_scmi/shmem.c             | 86 +++++++++++++++++-
>> -
>>   5 files changed, 132 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/firmware/arm_scmi/common.h
>> b/drivers/firmware/arm_scmi/common.h
>> index 69928bbd01c2..73bb496fac01 100644
>> --- a/drivers/firmware/arm_scmi/common.h
>> +++ b/drivers/firmware/arm_scmi/common.h
>> @@ -316,6 +316,26 @@ enum scmi_bad_msg {
>>   	MSG_MBOX_SPURIOUS = -5,
>>   };
>>
>> +/* Used for compactness and signature validation of the function
>> +pointers being
>> + * passed.
>> + */
>> +typedef void (*shmem_copy_toio_t)(volatile void __iomem *to, const
>> void *from,
>> +				  size_t count);
>> +typedef void (*shmem_copy_fromio_t)(void *to, const volatile void
>> __iomem *from,
>> +				    size_t count);
>> +
>> +/**
>> + * struct scmi_shmem_io_ops  - I/O operations to read from/write to
>> + * Shared Memory
>> + *
>> + * @toio: Copy data to the shared memory area
>> + * @fromio: Copy data from the shared memory area  */ struct
>> +scmi_shmem_io_ops {
>> +	shmem_copy_fromio_t fromio;
>> +	shmem_copy_toio_t toio;
>> +};
>> +
>>   /* shmem related declarations */
>>   struct scmi_shared_mem;
>>
>> @@ -336,13 +356,16 @@ struct scmi_shared_mem;  struct
>> scmi_shared_mem_operations {
>>   	void (*tx_prepare)(struct scmi_shared_mem __iomem
>> *shmem,
>>   			   struct scmi_xfer *xfer,
>> -			   struct scmi_chan_info *cinfo);
>> +			   struct scmi_chan_info *cinfo,
>> +			   shmem_copy_toio_t toio);
>>   	u32 (*read_header)(struct scmi_shared_mem __iomem
>> *shmem);
>>
>>   	void (*fetch_response)(struct scmi_shared_mem __iomem
>> *shmem,
>> -			       struct scmi_xfer *xfer);
>> +			       struct scmi_xfer *xfer,
>> +			       shmem_copy_fromio_t fromio);
>>   	void (*fetch_notification)(struct scmi_shared_mem __iomem
>> *shmem,
>> -				   size_t max_len, struct scmi_xfer
>> *xfer);
>> +				   size_t max_len, struct scmi_xfer
>> *xfer,
>> +				   shmem_copy_fromio_t fromio);
>>   	void (*clear_channel)(struct scmi_shared_mem __iomem
>> *shmem);
>>   	bool (*poll_done)(struct scmi_shared_mem __iomem *shmem,
>>   			  struct scmi_xfer *xfer);
>> @@ -350,7 +373,8 @@ struct scmi_shared_mem_operations {
>>   	bool (*channel_intr_enabled)(struct scmi_shared_mem
>> __iomem *shmem);
>>   	void __iomem *(*setup_iomap)(struct scmi_chan_info *cinfo,
>>   				     struct device *dev,
>> -				     bool tx, struct resource *res);
>> +				     bool tx, struct resource *res,
>> +				     struct scmi_shmem_io_ops **ops);
>>   };
>>
>>   const struct scmi_shared_mem_operations
>> *scmi_shared_mem_operations_get(void);
>> diff --git a/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
>> b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
>> index dc5ca894d5eb..1a2e90e5c765 100644
>> --- a/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
>> +++ b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
>> @@ -25,6 +25,7 @@
>>    * @chan_platform_receiver: Optional Platform Receiver mailbox
>> unidirectional channel
>>    * @cinfo: SCMI channel info
>>    * @shmem: Transmit/Receive shared memory area
>> + * @io_ops: Transport specific I/O operations
>>    */
>>   struct scmi_mailbox {
>>   	struct mbox_client cl;
>> @@ -33,6 +34,7 @@ struct scmi_mailbox {
>>   	struct mbox_chan *chan_platform_receiver;
>>   	struct scmi_chan_info *cinfo;
>>   	struct scmi_shared_mem __iomem *shmem;
>> +	struct scmi_shmem_io_ops *io_ops;
>>   };
>>
>>   #define client_to_scmi_mailbox(c) container_of(c, struct scmi_mailbox,
>> cl) @@ -43,7 +45,8 @@ static void tx_prepare(struct mbox_client *cl,
>> void *m)  {
>>   	struct scmi_mailbox *smbox = client_to_scmi_mailbox(cl);
>>
>> -	core->shmem->tx_prepare(smbox->shmem, m, smbox->cinfo);
>> +	core->shmem->tx_prepare(smbox->shmem, m, smbox->cinfo,
>> +				smbox->io_ops->toio);
>>   }
>>
>>   static void rx_callback(struct mbox_client *cl, void *m) @@ -197,7
>> +200,8 @@ static int mailbox_chan_setup(struct scmi_chan_info
>> *cinfo, struct device *dev,
>>   	if (!smbox)
>>   		return -ENOMEM;
>>
>> -	smbox->shmem = core->shmem->setup_iomap(cinfo, dev, tx,
>> NULL);
>> +	smbox->shmem = core->shmem->setup_iomap(cinfo, dev, tx,
>> NULL,
>> +						&smbox->io_ops);
>>   	if (IS_ERR(smbox->shmem))
>>   		return PTR_ERR(smbox->shmem);
>>
>> @@ -298,7 +302,7 @@ static void mailbox_fetch_response(struct
>> scmi_chan_info *cinfo,  {
>>   	struct scmi_mailbox *smbox = cinfo->transport_info;
>>
>> -	core->shmem->fetch_response(smbox->shmem, xfer);
>> +	core->shmem->fetch_response(smbox->shmem, xfer,
>> +smbox->io_ops->fromio);
>>   }
>>
>>   static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
>> @@ -306,7 +310,8 @@ static void mailbox_fetch_notification(struct
>> scmi_chan_info *cinfo,  {
>>   	struct scmi_mailbox *smbox = cinfo->transport_info;
>>
>> -	core->shmem->fetch_notification(smbox->shmem, max_len,
>> xfer);
>> +	core->shmem->fetch_notification(smbox->shmem, max_len,
>> xfer,
>> +					smbox->io_ops->fromio);
>>   }
>>
>>   static void mailbox_clear_channel(struct scmi_chan_info *cinfo) diff --
>> git a/drivers/firmware/arm_scmi/scmi_transport_optee.c
>> b/drivers/firmware/arm_scmi/scmi_transport_optee.c
>> index 08911f40d1ff..2be4124c6826 100644
>> --- a/drivers/firmware/arm_scmi/scmi_transport_optee.c
>> +++ b/drivers/firmware/arm_scmi/scmi_transport_optee.c
>> @@ -114,6 +114,7 @@ enum scmi_optee_pta_cmd {
>>    * @req.shmem: Virtual base address of the shared memory
>>    * @req.msg: Shared memory protocol handle for SCMI request and
>>    *   synchronous response
>> + * @io_ops: Transport specific I/O operations
>>    * @tee_shm: TEE shared memory handle @req or NULL if using
>> IOMEM shmem
>>    * @link: Reference in agent's channel list
>>    */
>> @@ -128,6 +129,7 @@ struct scmi_optee_channel {
>>   		struct scmi_shared_mem __iomem *shmem;
>>   		struct scmi_msg_payld *msg;
>>   	} req;
>> +	struct scmi_shmem_io_ops *io_ops;
>>   	struct tee_shm *tee_shm;
>>   	struct list_head link;
>>   };
>> @@ -350,7 +352,8 @@ static int setup_dynamic_shmem(struct device
>> *dev, struct scmi_optee_channel *ch  static int
>> setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
>>   			      struct scmi_optee_channel *channel)  {
>> -	channel->req.shmem = core->shmem->setup_iomap(cinfo, dev,
>> true, NULL);
>> +	channel->req.shmem = core->shmem->setup_iomap(cinfo, dev,
>> true, NULL,
>> +						      &channel-
>>> io_ops);
>>   	if (IS_ERR(channel->req.shmem))
>>   		return PTR_ERR(channel->req.shmem);
>>
>> @@ -465,7 +468,8 @@ static int scmi_optee_send_message(struct
>> scmi_chan_info *cinfo,
>>   		ret = invoke_process_msg_channel(channel,
>>   						 core->msg-
>>> command_size(xfer));
>>   	} else {
>> -		core->shmem->tx_prepare(channel->req.shmem, xfer,
>> cinfo);
>> +		core->shmem->tx_prepare(channel->req.shmem, xfer,
>> cinfo,
>> +					channel->io_ops->toio);
>>   		ret = invoke_process_smt_channel(channel);
>>   	}
>>
>> @@ -484,7 +488,8 @@ static void scmi_optee_fetch_response(struct
>> scmi_chan_info *cinfo,
>>   		core->msg->fetch_response(channel->req.msg,
>>   					  channel->rx_len, xfer);
>>   	else
>> -		core->shmem->fetch_response(channel->req.shmem,
>> xfer);
>> +		core->shmem->fetch_response(channel->req.shmem,
>> xfer,
>> +					    channel->io_ops->fromio);
>>   }
>>
>>   static void scmi_optee_mark_txdone(struct scmi_chan_info *cinfo, int
>> ret, diff --git a/drivers/firmware/arm_scmi/scmi_transport_smc.c
>> b/drivers/firmware/arm_scmi/scmi_transport_smc.c
>> index c6c69a17a9cc..04e715ec1570 100644
>> --- a/drivers/firmware/arm_scmi/scmi_transport_smc.c
>> +++ b/drivers/firmware/arm_scmi/scmi_transport_smc.c
>> @@ -45,6 +45,7 @@
>>    * @irq: An optional IRQ for completion
>>    * @cinfo: SCMI channel info
>>    * @shmem: Transmit/Receive shared memory area
>> + * @io_ops: Transport specific I/O operations
>>    * @shmem_lock: Lock to protect access to Tx/Rx shared memory area.
>>    *		Used when NOT operating in atomic mode.
>>    * @inflight: Atomic flag to protect access to Tx/Rx shared memory
>> area.
>> @@ -60,6 +61,7 @@ struct scmi_smc {
>>   	int irq;
>>   	struct scmi_chan_info *cinfo;
>>   	struct scmi_shared_mem __iomem *shmem;
>> +	struct scmi_shmem_io_ops *io_ops;
>>   	/* Protect access to shmem area */
>>   	struct mutex shmem_lock;
>>   #define INFLIGHT_NONE	MSG_TOKEN_MAX
>> @@ -144,7 +146,8 @@ static int smc_chan_setup(struct
>> scmi_chan_info *cinfo, struct device *dev,
>>   	if (!scmi_info)
>>   		return -ENOMEM;
>>
>> -	scmi_info->shmem = core->shmem->setup_iomap(cinfo, dev,
>> tx, &res);
>> +	scmi_info->shmem = core->shmem->setup_iomap(cinfo, dev,
>> tx, &res,
>> +						    &scmi_info-
>>> io_ops);
>>   	if (IS_ERR(scmi_info->shmem))
>>   		return PTR_ERR(scmi_info->shmem);
>>
>> @@ -229,7 +232,8 @@ static int smc_send_message(struct
>> scmi_chan_info *cinfo,
>>   	 */
>>   	smc_channel_lock_acquire(scmi_info, xfer);
>>
>> -	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo);
>> +	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo,
>> +				scmi_info->io_ops->toio);
>>
>>   	if (scmi_info->cap_id != ULONG_MAX)
>>   		arm_smccc_1_1_invoke(scmi_info->func_id,
>> scmi_info->cap_id, 0, @@ -253,7 +257,8 @@ static void
>> smc_fetch_response(struct scmi_chan_info *cinfo,  {
>>   	struct scmi_smc *scmi_info = cinfo->transport_info;
>>
>> -	core->shmem->fetch_response(scmi_info->shmem, xfer);
>> +	core->shmem->fetch_response(scmi_info->shmem, xfer,
>> +				    scmi_info->io_ops->fromio);
>>   }
>>
>>   static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret, diff
>> --git a/drivers/firmware/arm_scmi/shmem.c
>> b/drivers/firmware/arm_scmi/shmem.c
>> index 01d8a9398fe8..aded5f1cd49f 100644
>> --- a/drivers/firmware/arm_scmi/shmem.c
>> +++ b/drivers/firmware/arm_scmi/shmem.c
>> @@ -34,9 +34,67 @@ struct scmi_shared_mem {
>>   	u8 msg_payload[];
>>   };
>>
>> +static inline void shmem_memcpy_fromio32(void *to,
>> +					 const volatile void __iomem
>> *from,
>> +					 size_t count)
>> +{
>> +	while (count) {
>> +		*(u32 *)to = __raw_readl(from);
>> +		from += 4;
>> +		to += 4;
>> +		count -= 4;
> 
> This may not have issue, considering the 'count % 4' will be 0
> and 'from' is 4 bytes aligned.

Correct, this cannot possibly happen today by virtue of msg->payload 
being naturally aligned on a 4 bytes boundary.

> 
> But I think it maybe better to add check if 'count' and 'from'
> are not 4 bytes aligned.

Humm, what would be the fallback, or should we just WARN()?

> 
>> +	}
>> +
>> +	/* Ensure all reads from I/O have completed */
>> +	rmb();
> 
> Is there a need to use rmb here? I am not sure, just wonder.

I personally do not think there is because there is an implicit data 
dependency eventually we will be consuming data that was copied into 
msg->payload and that will ensure that the data is there.

> 
>> +}
>> +
>> +static inline void shmem_memcpy_toio32(volatile void __iomem *to,
>> +				       const void *from,
>> +				       size_t count)
>> +{
>> +	while (count) {
>> +		__raw_writel(*(u32 *)from, to);
>> +		from += 4;
>> +		to += 4;
>> +		count -= 4;
>> +	}
> 
> Ditto.
> 
>> +
>> +	/* Ensure all writes to I/O have completed */
>> +	wmb();
> 
> This maybe not needed.
> The mailbox will use "writel", the SMC will use "smc",
> the virtio will have "hvc", both will have barrier I think.

Yes, those are all implicit barriers, I was attempting to address 
Christian's concerns raised in v2:

https://lore.kernel.org/all/Zr-GJts3Gu6GEkhC@pluto/
-- 
Florian


