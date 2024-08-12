Return-Path: <linux-kernel+bounces-283537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD7094F60C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84970283E70
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6975A13A24D;
	Mon, 12 Aug 2024 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B8dW88Tz"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4198187FFA
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484796; cv=none; b=onm833uDQSJpSaA2AMGTDNnEpKtABCOWjaWV0MA5uxkFU/a0zygfrLHjFkko6tv1S+Pdq6kI9F9yzqEV6qZpv0sMcci96OC4HZoWEso43LJz7hlhuQxXH0H5r74DiKyV3v8ao5K6YBPyoMQoJW5Mb0UgpRAFAZmsciDDaWQViDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484796; c=relaxed/simple;
	bh=NNx5rLeI7O8Bbdyhrtxa/ubD0gv92gXeQmgeuGVMArc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Stmsm8WCIS+DG1S45sQVgvfS8ed50JdorLOm03wilJxHTWzDr3vyP9gLnw3Z5M9yzozVgphvcDtiTi1VCg6gNwY97pV1O7cKrP63C8+tC1DZ14W+xiJuvICjdBFVRkQLC1U7TNEIJVoIbchH3ifvY3UlvPT1vIaPNCwqYOjOc58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B8dW88Tz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc47abc040so30032415ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723484794; x=1724089594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hjLlFGngLCBLcUwprsKRVSCJ+1rx4IJt0/kMRtYRRHc=;
        b=B8dW88TzUEXfpXuuVWJcMya7NuLR65cE/661rFXdObWkpYo8xy8GogdS0NuKuvyl4B
         gEm5KCGWZKs9zmhg8DpboeKjrBMb0sxxELDBReqMqX+RB/BmDIGjpJHsXigk2AqZad8J
         YStE7aaGhsx0g/oML771efFdje/8b5EsVuG+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723484794; x=1724089594;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjLlFGngLCBLcUwprsKRVSCJ+1rx4IJt0/kMRtYRRHc=;
        b=xMpPfLJ/ZHr6Ir3A1VdJueL//CbO/vnecyulXlBfR3xmxUEo+/vB4wwbfkNdCFXGmY
         NGpz/pFPrCBMiUEPlq0es6bMlF9luwZQsym9ZCWufv6UPsGtt2gkOY1aU4nTZEihd1yn
         +F5+wBkfssXb4oMO+vlul8xATR6HytMaCKj8rNFSIbHtPCfbk0MLT5OOJM1cbwdZgnN8
         ei1oe4lJML5nS4nBGhmJ8OgX45dLCeilQngf28t58G83o0jiLjrPW80Re3DAOa1Tr18O
         cz11YnZExtBoxD9Yf2SkRO7RQJVnNx5WfnicrdOqzuxthrgIPr1wj+ZPSeN6RAsGOmo6
         RzjA==
X-Forwarded-Encrypted: i=1; AJvYcCWBCXdwoNdaP1foHjuZTTzPb2KbCseuTkotv/McRsYXQ8i/HOC8QiImLO7IlMsJSviphhCGdlNqXzUuB3Ws1l2UNaQM+JHn7+RNm+SU
X-Gm-Message-State: AOJu0YxBmG5cY86dsjU7ZXizgLIQnI7Pqh87TGOtIpJqaCs5ypRtX9hH
	FE5Sr+JpCzwB3ZRkH8sxc5fhwu2kXQfyNAckwk4rq2TBjAVB4Wp2kEZYGCio5w==
X-Google-Smtp-Source: AGHT+IHJRm7J2VNfAyarkYDINwl4wudbC2Jlcc0sLiGDdEpiNCmF4KIUQOCRDRlAGWWjloh+c/lNDQ==
X-Received: by 2002:a17:902:eccb:b0:1fd:a1d2:c035 with SMTP id d9443c01a7336-201ca175854mr13704465ad.31.1723484793854;
        Mon, 12 Aug 2024 10:46:33 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bba016f7sm40250075ad.205.2024.08.12.10.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 10:46:33 -0700 (PDT)
Message-ID: <40cd771e-5dab-498b-b77d-e0de4281fce9@broadcom.com>
Date: Mon, 12 Aug 2024 10:46:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Support 'reg-io-width' property
 for shared memory
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 arm-scmi@vger.kernel.org, james.quinlan@broadcom.com,
 justin.chen@broadcom.com, kapil.hali@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com
References: <20240810214621.14417-1-florian.fainelli@broadcom.com>
 <20240810214621.14417-3-florian.fainelli@broadcom.com>
 <ZrpD9rEyw37DV1J1@pluto>
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
In-Reply-To: <ZrpD9rEyw37DV1J1@pluto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/24 10:18, Cristian Marussi wrote:
> On Sat, Aug 10, 2024 at 02:46:21PM -0700, Florian Fainelli wrote:
>> Some shared memory areas might only support a certain access width,
>> (e.g.: 32 bits accesses only). Update the shmem layer to support
>> reading from and writing to such shared memory area using the specified
>> I/O width in the Device Tree. The various transport layers making use of
>> the shmem.c code are updated accordingly to pass the I/O width to the
>> routines that need it.
> 
> Hi Florian,
> 
> I only glanced quicky through the series...a few remarks below.
> 
>>
>> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
>> ---
>>   drivers/firmware/arm_scmi/common.h            | 14 +++-
>>   .../arm_scmi/scmi_transport_mailbox.c         | 12 ++-
>>   .../firmware/arm_scmi/scmi_transport_optee.c  |  7 +-
>>   .../firmware/arm_scmi/scmi_transport_smc.c    | 10 ++-
>>   drivers/firmware/arm_scmi/shmem.c             | 77 ++++++++++++++++---
>>   5 files changed, 96 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
>> index 69928bbd01c2..97dae844a190 100644
>> --- a/drivers/firmware/arm_scmi/common.h
>> +++ b/drivers/firmware/arm_scmi/common.h
>> @@ -170,6 +170,7 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id);
>>    *		       This can be dynamically set by transports at run-time
>>    *		       inside their provided .chan_setup().
>>    * @transport_info: Transport layer related information
>> + * @shmem_io_width: I/O width in bytes of the shared memory area
>>    */
>>   struct scmi_chan_info {
>>   	int id;
>> @@ -178,6 +179,7 @@ struct scmi_chan_info {
>>   	struct scmi_handle *handle;
>>   	bool no_completion_irq;
>>   	void *transport_info;
>> +	u32 shmem_io_width;
>>   };
> 
> As you said you dont need this if you embed it inside the
> transpor_info...but...
>>   
>>   /**
>> @@ -336,13 +338,16 @@ struct scmi_shared_mem;
>>   struct scmi_shared_mem_operations {
>>   	void (*tx_prepare)(struct scmi_shared_mem __iomem *shmem,
>>   			   struct scmi_xfer *xfer,
>> -			   struct scmi_chan_info *cinfo);
>> +			   struct scmi_chan_info *cinfo,
>> +			   u32 shmem_io_width);
> 
> ...maybe also you dont need this additional parameters if you setup
> upfront the shmem ops to operate ONLY on the configured size...
> 
> ...I mean all of this seems to be a one-shot setup procedure so it
> would be sensible to just configuire the shmem ops pointers once-for all
> to ONLY use the proper size helper method...since mixed-size usage at
> runtime seems NOT be an option given how the binding is used...
> 
> ...but I can see that in this case you will need to change a bit
> how the scmi_shared_mem_operations are setup...since now they are a
> const global and initialized fully at driver init in
> 
> 	scmi_trans_core_ops.shmem = scmi_shared_mem_operations_get();
> 
> ..so, in case you want to setup only once the properly sized helpers at
> run-time, all of this should happen instead at probe-time and you should
> have a per-probe-instance scmni_trans_core_ops struct since you could have
> multiple SCMI nodes using multiple shmem transports with different size...
> (in theory...)

Indeed, let me ponder about that for a s

> 
>>   	u32 (*read_header)(struct scmi_shared_mem __iomem *shmem);
>>   
>>   	void (*fetch_response)(struct scmi_shared_mem __iomem *shmem,
>> -			       struct scmi_xfer *xfer);
>> +			       struct scmi_xfer *xfer,
>> +			       u32 shmem_io_width);
>>   	void (*fetch_notification)(struct scmi_shared_mem __iomem *shmem,
>> -				   size_t max_len, struct scmi_xfer *xfer);
>> +				   size_t max_len, struct scmi_xfer *xfer,
>> +				   u32 shmem_io_width);
>>   	void (*clear_channel)(struct scmi_shared_mem __iomem *shmem);
>>   	bool (*poll_done)(struct scmi_shared_mem __iomem *shmem,
>>   			  struct scmi_xfer *xfer);
>> @@ -350,7 +355,8 @@ struct scmi_shared_mem_operations {
>>   	bool (*channel_intr_enabled)(struct scmi_shared_mem __iomem *shmem);
>>   	void __iomem *(*setup_iomap)(struct scmi_chan_info *cinfo,
>>   				     struct device *dev,
>> -				     bool tx, struct resource *res);
>> +				     bool tx, struct resource *res,
>> +				     u32 *shmem_io_width);
>>   };
>>   
>>   const struct scmi_shared_mem_operations *scmi_shared_mem_operations_get(void);
>> diff --git a/drivers/firmware/arm_scmi/scmi_transport_mailbox.c b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
>> index dc5ca894d5eb..6bd876875655 100644
>> --- a/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
>> +++ b/drivers/firmware/arm_scmi/scmi_transport_mailbox.c
>> @@ -33,6 +33,7 @@ struct scmi_mailbox {
>>   	struct mbox_chan *chan_platform_receiver;
>>   	struct scmi_chan_info *cinfo;
>>   	struct scmi_shared_mem __iomem *shmem;
>> +	u32 shmem_io_width;
>>   };
>>   
>>   #define client_to_scmi_mailbox(c) container_of(c, struct scmi_mailbox, cl)
>> @@ -43,7 +44,8 @@ static void tx_prepare(struct mbox_client *cl, void *m)
>>   {
>>   	struct scmi_mailbox *smbox = client_to_scmi_mailbox(cl);
>>   
>> -	core->shmem->tx_prepare(smbox->shmem, m, smbox->cinfo);
>> +	core->shmem->tx_prepare(smbox->shmem, m, smbox->cinfo,
>> +				smbox->shmem_io_width);
>>   }
>>   
>>   static void rx_callback(struct mbox_client *cl, void *m)
>> @@ -197,7 +199,8 @@ static int mailbox_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>>   	if (!smbox)
>>   		return -ENOMEM;
>>   
>> -	smbox->shmem = core->shmem->setup_iomap(cinfo, dev, tx, NULL);
>> +	smbox->shmem = core->shmem->setup_iomap(cinfo, dev, tx, NULL,
>> +						&smbox->shmem_io_width);
>>   	if (IS_ERR(smbox->shmem))
>>   		return PTR_ERR(smbox->shmem);
>>   
>> @@ -298,7 +301,7 @@ static void mailbox_fetch_response(struct scmi_chan_info *cinfo,
>>   {
>>   	struct scmi_mailbox *smbox = cinfo->transport_info;
>>   
>> -	core->shmem->fetch_response(smbox->shmem, xfer);
>> +	core->shmem->fetch_response(smbox->shmem, xfer, smbox->shmem_io_width);
>>   }
>>   
>>   static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
>> @@ -306,7 +309,8 @@ static void mailbox_fetch_notification(struct scmi_chan_info *cinfo,
>>   {
>>   	struct scmi_mailbox *smbox = cinfo->transport_info;
>>   
>> -	core->shmem->fetch_notification(smbox->shmem, max_len, xfer);
>> +	core->shmem->fetch_notification(smbox->shmem, max_len, xfer,
>> +					smbox->shmem_io_width);
>>   }
>>   
>>   static void mailbox_clear_channel(struct scmi_chan_info *cinfo)
>> diff --git a/drivers/firmware/arm_scmi/scmi_transport_optee.c b/drivers/firmware/arm_scmi/scmi_transport_optee.c
>> index 08911f40d1ff..9f6804647b29 100644
>> --- a/drivers/firmware/arm_scmi/scmi_transport_optee.c
>> +++ b/drivers/firmware/arm_scmi/scmi_transport_optee.c
>> @@ -350,7 +350,8 @@ static int setup_dynamic_shmem(struct device *dev, struct scmi_optee_channel *ch
>>   static int setup_static_shmem(struct device *dev, struct scmi_chan_info *cinfo,
>>   			      struct scmi_optee_channel *channel)
>>   {
>> -	channel->req.shmem = core->shmem->setup_iomap(cinfo, dev, true, NULL);
>> +	channel->req.shmem = core->shmem->setup_iomap(cinfo, dev, true, NULL,
>> +						      NULL);
>>   	if (IS_ERR(channel->req.shmem))
>>   		return PTR_ERR(channel->req.shmem);
>>   
>> @@ -465,7 +466,7 @@ static int scmi_optee_send_message(struct scmi_chan_info *cinfo,
>>   		ret = invoke_process_msg_channel(channel,
>>   						 core->msg->command_size(xfer));
>>   	} else {
>> -		core->shmem->tx_prepare(channel->req.shmem, xfer, cinfo);
>> +		core->shmem->tx_prepare(channel->req.shmem, xfer, cinfo, 0);
>>   		ret = invoke_process_smt_channel(channel);
>>   	}
>>   
>> @@ -484,7 +485,7 @@ static void scmi_optee_fetch_response(struct scmi_chan_info *cinfo,
>>   		core->msg->fetch_response(channel->req.msg,
>>   					  channel->rx_len, xfer);
>>   	else
>> -		core->shmem->fetch_response(channel->req.shmem, xfer);
>> +		core->shmem->fetch_response(channel->req.shmem, xfer, 0);
>>   }
>>   
>>   static void scmi_optee_mark_txdone(struct scmi_chan_info *cinfo, int ret,
>> diff --git a/drivers/firmware/arm_scmi/scmi_transport_smc.c b/drivers/firmware/arm_scmi/scmi_transport_smc.c
>> index c6c69a17a9cc..4e7b2ac1c7e8 100644
>> --- a/drivers/firmware/arm_scmi/scmi_transport_smc.c
>> +++ b/drivers/firmware/arm_scmi/scmi_transport_smc.c
>> @@ -60,6 +60,7 @@ struct scmi_smc {
>>   	int irq;
>>   	struct scmi_chan_info *cinfo;
>>   	struct scmi_shared_mem __iomem *shmem;
>> +	u32 shmem_io_width;
>>   	/* Protect access to shmem area */
>>   	struct mutex shmem_lock;
>>   #define INFLIGHT_NONE	MSG_TOKEN_MAX
>> @@ -144,7 +145,8 @@ static int smc_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>>   	if (!scmi_info)
>>   		return -ENOMEM;
>>   
>> -	scmi_info->shmem = core->shmem->setup_iomap(cinfo, dev, tx, &res);
>> +	scmi_info->shmem = core->shmem->setup_iomap(cinfo, dev, tx, &res,
>> +						    &scmi_info->shmem_io_width);
>>   	if (IS_ERR(scmi_info->shmem))
>>   		return PTR_ERR(scmi_info->shmem);
>>   
>> @@ -229,7 +231,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
>>   	 */
>>   	smc_channel_lock_acquire(scmi_info, xfer);
>>   
>> -	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo);
>> +	core->shmem->tx_prepare(scmi_info->shmem, xfer, cinfo,
>> +				scmi_info->shmem_io_width);
>>   
>>   	if (scmi_info->cap_id != ULONG_MAX)
>>   		arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info->cap_id, 0,
>> @@ -253,7 +256,8 @@ static void smc_fetch_response(struct scmi_chan_info *cinfo,
>>   {
>>   	struct scmi_smc *scmi_info = cinfo->transport_info;
>>   
>> -	core->shmem->fetch_response(scmi_info->shmem, xfer);
>> +	core->shmem->fetch_response(scmi_info->shmem, xfer,
>> +				    scmi_info->shmem_io_width);
>>   }
>>   
>>   static void smc_mark_txdone(struct scmi_chan_info *cinfo, int ret,
>> diff --git a/drivers/firmware/arm_scmi/shmem.c b/drivers/firmware/arm_scmi/shmem.c
>> index 01d8a9398fe8..192262d63baa 100644
>> --- a/drivers/firmware/arm_scmi/shmem.c
>> +++ b/drivers/firmware/arm_scmi/shmem.c
>> @@ -34,9 +34,20 @@ struct scmi_shared_mem {
>>   	u8 msg_payload[];
>>   };
>>   
>> +#define __shmem_copy_toio_tpl(s)			\
>> +	for (unsigned int i = 0; i < xfer->tx.len; i += shmem_io_width)		\
>> +		iowrite##s(((u##s *)(xfer->tx.buf))[i / shmem_io_width],	\
>> +			   shmem->msg_payload + i);
>> +
>> +#define __shmem_copy_fromio_tpl(s)			\
>> +	for (unsigned int i = 0; i < xfer->rx.len; i += shmem_io_width)		\
>> +		((u##s *)(xfer->rx.buf))[i / shmem_io_width] = 			\
>> +			 ioread##s(shmem->msg_payload + shmem_io_width + i);
>> +
>>   static void shmem_tx_prepare(struct scmi_shared_mem __iomem *shmem,
>>   			     struct scmi_xfer *xfer,
>> -			     struct scmi_chan_info *cinfo)
>> +			     struct scmi_chan_info *cinfo,
>> +			     u32 shmem_io_width)
>>   {
>>   	ktime_t stop;
>>   
>> @@ -72,8 +83,25 @@ static void shmem_tx_prepare(struct scmi_shared_mem __iomem *shmem,
>>   		  &shmem->flags);
>>   	iowrite32(sizeof(shmem->msg_header) + xfer->tx.len, &shmem->length);
>>   	iowrite32(pack_scmi_header(&xfer->hdr), &shmem->msg_header);
> 
> what about these (and other) header reads if reg-io-width is defined as < 32 ?
> Should not these accesses be size-wise too ? or I am missing smth ...

Good question, I suppose it depends whether 'reg-io-width' means that 
this must be the strict access width we use, or if this is the minimum 
access width supported. If the former, then yes, we do have to make a 
whole lot of changes to support the only access width being supported, 
if the latter, then we ought to be OK, because doing a 32-bit access 
should drive more byte enables at the bus level, yet still return the 
expected data.

A minimum or only supported access width of 64-bit would be quite 
interesting, and not somewhat compatible with how SCMI is defined, so 
maybe that one should not be supported at all, even if this is how 
memcpy_{to,from}_io() decides to operate on parts of the memory that are 
8bytes aligned.

> (...and if yes I would once more say that all of this should be setup once for
> all at setup time and not checked against a parameter at run time for each access...)
> 
>> -	if (xfer->tx.buf)
>> -		memcpy_toio(shmem->msg_payload, xfer->tx.buf, xfer->tx.len);
>> +	if (xfer->tx.buf) {
>> +		switch (shmem_io_width) {
>> +		case 1:
>> +			__shmem_copy_toio_tpl(8);
>> +			break;
>> +		case 2:
>> +			__shmem_copy_toio_tpl(16);
>> +			break;
>> +		case 4:
>> +			__shmem_copy_toio_tpl(32);
>> +			break;
>> +		case 8:
>> +			__shmem_copy_toio_tpl(64);
>> +			break;
>> +		default:
>> +			memcpy_toio(shmem->msg_payload, xfer->tx.buf, xfer->tx.len);
>> +			break;
> 
> ...as said above, this switch could be avoided by setting up the
> transport access size once for all at setup time with properly
> sized-helpers...
> 
> 
>> +		}
>> +	}
>>   }
>>   
>>   static u32 shmem_read_header(struct scmi_shared_mem __iomem *shmem)
>> @@ -81,8 +109,34 @@ static u32 shmem_read_header(struct scmi_shared_mem __iomem *shmem)
>>   	return ioread32(&shmem->msg_header);
>>   }
>>   
>> +static void __shmem_fetch_resp_notif_data(struct scmi_xfer *xfer,
>> +					  struct scmi_shared_mem __iomem *shmem,
>> +					  u32 shmem_io_width)
>> +{
>> +	/* Take a copy to the rx buffer.. */
>> +	switch (shmem_io_width) {
>> +	case 1:
>> +		__shmem_copy_fromio_tpl(8);
>> +		break;
>> +	case 2:
>> +		__shmem_copy_fromio_tpl(16);
>> +		break;
>> +	case 4:
>> +		__shmem_copy_fromio_tpl(32);
>> +		break;
>> +	case 8:
>> +		__shmem_copy_fromio_tpl(32);
>> +		break;
>> +	default:
>> +		memcpy_fromio(xfer->rx.buf, shmem->msg_payload + 4,
>> +			      xfer->rx.len);
>> +		break;
>> +	}
>> +}
>> +
>>   static void shmem_fetch_response(struct scmi_shared_mem __iomem *shmem,
>> -				 struct scmi_xfer *xfer)
>> +				 struct scmi_xfer *xfer,
>> +				 u32 shmem_io_width)
>>   {
>>   	size_t len = ioread32(&shmem->length);
>>   
>> @@ -90,20 +144,19 @@ static void shmem_fetch_response(struct scmi_shared_mem __iomem *shmem,
>>   	/* Skip the length of header and status in shmem area i.e 8 bytes */
>>   	xfer->rx.len = min_t(size_t, xfer->rx.len, len > 8 ? len - 8 : 0);
>>   
>> -	/* Take a copy to the rx buffer.. */
>> -	memcpy_fromio(xfer->rx.buf, shmem->msg_payload + 4, xfer->rx.len);
>> +	__shmem_fetch_resp_notif_data(xfer, shmem, shmem_io_width);
>>   }
>>   
>>   static void shmem_fetch_notification(struct scmi_shared_mem __iomem *shmem,
>> -				     size_t max_len, struct scmi_xfer *xfer)
>> +				     size_t max_len, struct scmi_xfer *xfer,
>> +				     u32 shmem_io_width)
>>   {
>>   	size_t len = ioread32(&shmem->length);
>>   
>>   	/* Skip only the length of header in shmem area i.e 4 bytes */
>>   	xfer->rx.len = min_t(size_t, max_len, len > 4 ? len - 4 : 0);
>>   
>> -	/* Take a copy to the rx buffer.. */
>> -	memcpy_fromio(xfer->rx.buf, shmem->msg_payload, xfer->rx.len);
>> +	__shmem_fetch_resp_notif_data(xfer, shmem, shmem_io_width);
>>   }
>>   
>>   static void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem)
>> @@ -139,7 +192,8 @@ static bool shmem_channel_intr_enabled(struct scmi_shared_mem __iomem *shmem)
>>   
>>   static void __iomem *shmem_setup_iomap(struct scmi_chan_info *cinfo,
>>   				       struct device *dev, bool tx,
>> -				       struct resource *res)
>> +				       struct resource *res,
>> +				       u32 *shmem_io_width)
>>   {
>>   	struct device_node *shmem __free(device_node);
>>   	const char *desc = tx ? "Tx" : "Rx";
>> @@ -173,6 +227,9 @@ static void __iomem *shmem_setup_iomap(struct scmi_chan_info *cinfo,
>>   		return IOMEM_ERR_PTR(-EADDRNOTAVAIL);
>>   	}
>>   
>> +	if (shmem_io_width)
>> +		of_property_read_u32(shmem, "reg-io-width", shmem_io_width);
>> +
> 
> 
> ...this and all the subsequent setup could be moved inside a modified
> shared_mem_operations_get(dev) while moving its callsite from driver_init into
> driver_probe (probably) insside @scmi_transport_setup....but it will require
> a non-trivial amount of changes in the transport to avoid the global core-> ptr.

OK, I will think about more about what needs to be done here, but in 
general, do you agree this is an acceptable approach to support "odd" SRAMs?
-- 
Florian


