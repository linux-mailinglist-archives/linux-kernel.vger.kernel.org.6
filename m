Return-Path: <linux-kernel+bounces-282117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989B194DFC1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 04:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28411C20B0B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27065DDAD;
	Sun, 11 Aug 2024 02:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DjlCbhes"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0151B64E
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723344183; cv=none; b=GI2f8coxVKa8Wtq2HiTvratzeowRXwH4b6t8N9mvjWwquqJ/ooA7Js3uAJvREtLUJ7iOSs23oHi95NDEQs/4ZC1/rUNlpbTJupXlYAQ4m+Rd7BW4LDdHX8HLDO+5RmjgmUqfvlbyjGad7dGI0yT8XyB09QjxQDHG5ZdHgMOGzUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723344183; c=relaxed/simple;
	bh=I2ml4eDAWuwVaFaSNRHbOkEVrbKZhmqBSmRHRHOhoV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hxz+4kgLn0SWRUcDA1FqG7Sl6z3dmQhFksR2XWsgXU+Grz4Np8dpl1t8/Jmvv+VJwursE6Lvd4jcVzpYf/NP5qZcKnmTQh6RWf6oq+M13jwl7o6ECHVegMwhD8FCoF3d6ChvLmZcCeorg8f7lygaOYWd14sjwhmUyEyKrpSjbjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DjlCbhes; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd66cddd4dso32472525ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 19:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723344181; x=1723948981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TyqL0k9akOlb2hvVIUqCD3E++zuDy0rXL3Yrg2o0Xvc=;
        b=DjlCbhesi3Y4FrpaqpBpM5dc0DFS8Bq2/n263k6hFLAdRgXYT/Ah4q5T+I6duLSo+9
         ZLGh8yICOmlp+1mVuK3yg6mH3AnNRftlCcC1tG02/QozdncqtUu5QJKqnBArNZNBE9Rn
         RPMzDqEW3dPBESxha0kQ89NNuDtZRYDdLHg80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723344181; x=1723948981;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyqL0k9akOlb2hvVIUqCD3E++zuDy0rXL3Yrg2o0Xvc=;
        b=v88wudp1T0rON8hTMEebKUzatCaCd6G+U2F3H6cbcyGPBZcwjEgGPSblTYL3THRYFe
         nS9eQr8bXmsyHBVKuaa7wR1sk5iSkMPEpwq7W0S/0mI9k0vsyxfXllFcgqV4Il84PI+3
         ivORmuOpmGWVKzohlE30nC8aD2c2jEPX99ipo8Frr9kXs2yIkVGltwOK6SZ5EUMMLljI
         een9wyhlPsXeUedYft2ctILslfinUPcGj/sYUirWN9hyBkT1Vhih/SKXYl2IUmXoEtnZ
         pY4MtOgOoiDcAazdeY8gPiGpta667YbDl/6k2UfyV5Kyh0XXKMJ1yuMC9k1ypANXT3Ex
         dkew==
X-Forwarded-Encrypted: i=1; AJvYcCWGZq3hpp7QTlvPRi/xJ0XfuXoHPEWeRQIVtQhUOhvMYNyZ/K63fAOwhtOxz6C0aptxfj2o171pxEPYl5437GLQuKjofdv6K8ea793C
X-Gm-Message-State: AOJu0Yy33re05m9VLIfO0CdZflOfDKzX9ATTwdAV+m/7HlvPO+Rk0/TQ
	zY1jMXRwsttjUvroiz6yUstNY4qOcI9bsTMPGG43X6xTZG91ND2wDHXrGdusxQ==
X-Google-Smtp-Source: AGHT+IH2Pnqy6bqQWwC0ZO+/SqLviXkATatRPH04u/7yu8gdi0EZ0ol/OggQFXPL4I4OxOBl9Zy2Ng==
X-Received: by 2002:a17:902:d492:b0:1fd:664b:224 with SMTP id d9443c01a7336-200ae60a518mr65172165ad.56.1723344180904;
        Sat, 10 Aug 2024 19:43:00 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bbb63778sm16913035ad.302.2024.08.10.19.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Aug 2024 19:43:00 -0700 (PDT)
Message-ID: <80a257e8-65fb-4545-a00d-9cb793d1b120@broadcom.com>
Date: Sat, 10 Aug 2024 19:42:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Support 'reg-io-width' property
 for shared memory
To: linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Cristian Marussi <cristian.marussi@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 arm-scmi@vger.kernel.org, james.quinlan@broadcom.com,
 justin.chen@broadcom.com, kapil.hali@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com
References: <20240810214621.14417-1-florian.fainelli@broadcom.com>
 <20240810214621.14417-3-florian.fainelli@broadcom.com>
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
In-Reply-To: <20240810214621.14417-3-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/10/2024 2:46 PM, Florian Fainelli wrote:
> Some shared memory areas might only support a certain access width,
> (e.g.: 32 bits accesses only). Update the shmem layer to support
> reading from and writing to such shared memory area using the specified
> I/O width in the Device Tree. The various transport layers making use of
> the shmem.c code are updated accordingly to pass the I/O width to the
> routines that need it.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Doing a self review, though I will only resend after collecting 
additional feedback.

> ---
>   drivers/firmware/arm_scmi/common.h            | 14 +++-
>   .../arm_scmi/scmi_transport_mailbox.c         | 12 ++-
>   .../firmware/arm_scmi/scmi_transport_optee.c  |  7 +-
>   .../firmware/arm_scmi/scmi_transport_smc.c    | 10 ++-
>   drivers/firmware/arm_scmi/shmem.c             | 77 ++++++++++++++++---
>   5 files changed, 96 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 69928bbd01c2..97dae844a190 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -170,6 +170,7 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id);
>    *		       This can be dynamically set by transports at run-time
>    *		       inside their provided .chan_setup().
>    * @transport_info: Transport layer related information
> + * @shmem_io_width: I/O width in bytes of the shared memory area
>    */
>   struct scmi_chan_info {
>   	int id;
> @@ -178,6 +179,7 @@ struct scmi_chan_info {
>   	struct scmi_handle *handle;
>   	bool no_completion_irq;
>   	void *transport_info;
> +	u32 shmem_io_width;

This is not used because the individual transports store the 
shmem_io_width in their own transport_info structure.

[snip]

>   
> +#define __shmem_copy_toio_tpl(s)			\
> +	for (unsigned int i = 0; i < xfer->tx.len; i += shmem_io_width)		\
> +		iowrite##s(((u##s *)(xfer->tx.buf))[i / shmem_io_width],	\
> +			   shmem->msg_payload + i);
> +
> +#define __shmem_copy_fromio_tpl(s)			\
> +	for (unsigned int i = 0; i < xfer->rx.len; i += shmem_io_width)		\
> +		((u##s *)(xfer->rx.buf))[i / shmem_io_width] = 			\
> +			 ioread##s(shmem->msg_payload + shmem_io_width + i);

This needs to be shmem->msg_payload + 4 + i. This worked in my testing 
because I was precisely tseting with 'reg-io-width = <4>'.

[snip]

>   
>   static u32 shmem_read_header(struct scmi_shared_mem __iomem *shmem)
> @@ -81,8 +109,34 @@ static u32 shmem_read_header(struct scmi_shared_mem __iomem *shmem)
>   	return ioread32(&shmem->msg_header);
>   }
>   
> +static void __shmem_fetch_resp_notif_data(struct scmi_xfer *xfer,
> +					  struct scmi_shared_mem __iomem *shmem,
> +					  u32 shmem_io_width)
> +{
> +	/* Take a copy to the rx buffer.. */
> +	switch (shmem_io_width) {
> +	case 1:
> +		__shmem_copy_fromio_tpl(8);
> +		break;
> +	case 2:
> +		__shmem_copy_fromio_tpl(16);
> +		break;
> +	case 4:
> +		__shmem_copy_fromio_tpl(32);
> +		break;
> +	case 8:
> +		__shmem_copy_fromio_tpl(32);

This should be 64 and it looks like ioread64/iowrite64 is not 
necessarily defined for 32-bit configurations, so this needs to be gated 
with a CONFIG_64BIT define here since ioread64/iowrite64 in 
include/asm-generic/io.h is defined that way.
-- 
Florian


