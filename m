Return-Path: <linux-kernel+bounces-283805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9FC94F8D7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17719B211DC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69122198E88;
	Mon, 12 Aug 2024 21:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f8R1yMJ5"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D92198856
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723497410; cv=none; b=lHm5W2dwgDLo8EABfBNZWb25fy+DwrObPiODQOMJtgzDMUJpG5vEMrRwRrZaL1pmLn1uCi4GJXSUAGqWjZCEGWZLCzbFA5Z7lRKp3GN3eBen6T7QeEFTLydCWz+gum647D96dPcL2W25rsNT5eQJxmuN2QqvU4Fzv02Db8hpFC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723497410; c=relaxed/simple;
	bh=p12e/PLFITYF456IbJKBsf4gXPV78RjHjiM2yVWZVkE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=em+3l93Wail5N+we4k0dnQNAGPdD3XxEiEIVXJ76KAabs7lar1pH1L4nTPI6on3L+Fkvq+zCOyymxy1+8SpMCva+jl/iaTnM7I/z+JL6aAI6U5nbG0DQ+hqx1Tn9oFwxDcTLSZqDNsMYDSovhGKEmMapVX44DHeVyBWVCn3q4yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f8R1yMJ5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc587361b6so38339305ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723497407; x=1724102207; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=glRHgM8xhwoYlcjgNLA4lJhSJgddsN6N7UUXGoa9228=;
        b=f8R1yMJ50mfZ8KbKhJtMIM1WtU/WJxqCAsCNeg2Mktx3NlVHsgi8wLbwQYCi4dvkDl
         BaJEJG26weTorNKPvs2QO9SRIgIp3/TG3txL/5DbUAbwkhhvc/9FTfoSPuUYZFhOb4QO
         OdrkR8JnBfR7/IzqBCfD9wciaEuca+/pvkOKWRVn5TvTkqeCNZDYXJp3gCxdNj64Gbi8
         Nn+HmE96FkydgZXGJuf79jHd9hULx66QPaplsPrV2Y9Tg6kz8iEPwgyDerOMWciyrRiK
         9jO7aJFPw1jULsNOoCMaX+LD7RbcbKW3TFZxLygF338bJSQAyuSRswlNj8Qd1suYkGJw
         l05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723497407; x=1724102207;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glRHgM8xhwoYlcjgNLA4lJhSJgddsN6N7UUXGoa9228=;
        b=rqPHNa0C9IxLWFX71oTCNOKAGSdfLw9k8QvR8DhU6wlHgcdG8CYM4wtO8piftRwP2D
         TFV/ZCVOsFRSnnFPkJ5zo80VHfORjp8L5ZZ3OrvB5wsrNRAE21mpewMggWThORGiu5mV
         xidRk34z5wIZLhmbHPZh1IhvYwxP8CGLs/BDBHy7SUI2FANZOyy7TowoBgycgPSsxXGJ
         Zfq/emt8iyzatWJyd6/1JQ/ku8W10xtBfOLCXDfwGofOigmT+QvMDcElnTTpGrdYjQhJ
         hsgeJ+XK5cFBBYW7v0uCTW6nF3yQO37+CBg52Pm6UPtlqSkenugbX4GUumfaArtl61Gn
         v9vA==
X-Forwarded-Encrypted: i=1; AJvYcCW943fgBBjqU7B0BG+4u4UYzPc2sG45RUCGTkkX7lmDjQDGPjittLjA3MNl6QlzFHZa9yHaPH6jDCCiFQHH4+gfuOydZI+38zszfuTT
X-Gm-Message-State: AOJu0YxKOcld+lu9/Ae5him8mqepUwhYqkggCLmFI8wUXvF9UQ7CTyl+
	9+X8Mp6sb/kGFM2Yk3qI1dCL7RkIc/PqKqq2KGjZUXPqQarxmQtupMwweoS/xsU=
X-Google-Smtp-Source: AGHT+IG3huzZbJvj7W1Iydd51Kl4NAJb5ySebRX+HV4626+6wB1HXfeSHul8v0+Czq2PcAdrsHmT/w==
X-Received: by 2002:a17:902:e74f:b0:1fd:78dd:8578 with SMTP id d9443c01a7336-201ca1c5bd9mr20762635ad.55.1723497407243;
        Mon, 12 Aug 2024 14:16:47 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a963esm1185185ad.181.2024.08.12.14.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 14:16:46 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Dhruva Gole <d-gole@ti.com>, Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh
 Shilimkar <ssantosh@kernel.org>, Vibhore Vardhan <vibhore@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dave
 Gerlach <d-gerlach@ti.com>, Georgi Vlaev <g-vlaev@ti.com>, Akashdeep Kaur
 <a-kaur@ti.com>
Subject: Re: [PATCH v9 3/4] firmware: ti_sci: Introduce Power Management Ops
In-Reply-To: <20240812054717.6lzkt3lxclzec3zy@lcpd911>
References: <20240809135347.2112634-1-msp@baylibre.com>
 <20240809135347.2112634-4-msp@baylibre.com>
 <20240812054717.6lzkt3lxclzec3zy@lcpd911>
Date: Mon, 12 Aug 2024 14:16:45 -0700
Message-ID: <7hcymdphky.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dhruva Gole <d-gole@ti.com> writes:

> On Aug 09, 2024 at 15:53:46 +0200, Markus Schneider-Pargmann wrote:
>> From: Dave Gerlach <d-gerlach@ti.com>
>> 
>> Introduce power management ops supported by the TISCI
>> Low Power Mode API [1].
>> 
>> 1) TISCI_MSG_LPM_WAKE_REASON
>> Get which wake up source woke the SoC from Low Power Mode.
>> The wake up source IDs will be common for all K3 platforms.
>> 
>> 2) TISCI_MSG_LPM_SET_DEVICE_CONSTRAINT
>> Set LPM constraint on behalf of a device. By setting a constraint, the
>> device ensures that it will not be powered off or reset in the selected
>> mode.
>> 
>> 3) TISCI_MSG_LPM_SET_LATENCY_CONSTRAINT
>> Set LPM resume latency constraint. By setting a constraint, the host
>> ensures that the resume time from selected mode will be less than the
>> constraint value.
>> 
>> [1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html
>> 
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> [g-vlaev@ti.com: LPM_WAKE_REASON and IO_ISOLATION support]
>> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
>> [a-kaur@ti.com: SET_DEVICE_CONSTRAINT support]
>> Signed-off-by: Akashdeep Kaur <a-kaur@ti.com>
>> [vibhore@ti.com: SET_LATENCY_CONSTRAINT support]
>> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>> ---
> [...]
>> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
>> index 8efe4d0e61fb..9dd40b6711d4 100644
>> --- a/drivers/firmware/ti_sci.h
>> +++ b/drivers/firmware/ti_sci.h
>> @@ -38,7 +38,10 @@
>>  
>>  /* Low Power Mode Requests */
>>  #define TI_SCI_MSG_PREPARE_SLEEP	0x0300
>> +#define TI_SCI_MSG_LPM_WAKE_REASON	0x0306
>>  #define TI_SCI_MSG_SET_IO_ISOLATION	0x0307
>> +#define TI_SCI_MSG_LPM_SET_DEVICE_CONSTRAINT	0x0309
>> +#define TI_SCI_MSG_LPM_SET_LATENCY_CONSTRAINT	0x030A
>>  
>>  /* Resource Management Requests */
>>  #define TI_SCI_MSG_GET_RESOURCE_RANGE	0x1500
>> @@ -610,6 +613,73 @@ struct ti_sci_msg_req_set_io_isolation {
>>  	u8 state;
>>  } __packed;
>>  
>> +/**
>> + * struct ti_sci_msg_resp_lpm_wake_reason - Response for TI_SCI_MSG_LPM_WAKE_REASON.
>> + *
>> + * @hdr:		Generic header.
>> + * @wake_source:	The wake up source that woke soc from LPM.
>> + * @wake_timestamp:	Timestamp at which soc woke.
>> + *
>> + * Response to a generic message with message type TI_SCI_MSG_LPM_WAKE_REASON,
>> + * used to query the wake up source from low power mode.
>> + */
>> +struct ti_sci_msg_resp_lpm_wake_reason {
>> +	struct ti_sci_msg_hdr hdr;
>> +	u32 wake_source;
>> +	u64 wake_timestamp;
>> +} __packed;
>> +
>
> It looks like we forgot to update the parameters in this API.
> See [1]:
>
> struct tisci_msg_lpm_wake_reason_req
>
> We're missing here the wake_pin, mode and 2 rsvd fields as well.
>
> [1] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/pm/lpm.html#tisci-msg-lpm-wake-reason
>

The docs mention how to interpret the pin, but not the mode.  This
driver should translate this mode number to some human-readable state
for better debug messages.

Kevin

