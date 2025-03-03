Return-Path: <linux-kernel+bounces-542478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5987A4CA8C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00AB33BC68E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E78624CEC8;
	Mon,  3 Mar 2025 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dw1XWC/I"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96A7215185
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741023046; cv=none; b=O40V0HsA1LsHRo/uuhy+VfRpl1UaurMnUloHROfWQLGYYHeAZ4eyJmav92euKV3NF3g//fPcpiP3t5wIRT1mv5Okkx06KYoNN0mhyGBe4m5FyWb85IZ0Hw4bGunRNwUdIPQi7i1/qoy8zTUDEzJUUMU0JlBolZB06xikJ2fXnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741023046; c=relaxed/simple;
	bh=zCLifRE0KoQawzB/TcyJYbwoK84uaqCSQwdfN6x2BcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NA8K1OlVIrou9dBeHXKcQgmADdqmwzNXFHYSEXRVp5pNG9FeSNTXTQN4NDK0CWbi5X+eCvTS5lKc3Eq9G0aAF0MviMEevUhqMP1LxcnHzDfyM7AEB4eKIyUHpMGLoiKaBY6LvRVvcpuNzw2gkrLNCkmUYwpYzQ140y6OSQCItwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dw1XWC/I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741023044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qK6V1d4F8/3GYYMbFs+Mb6fZwFXqDTRxwVUEODfRNfg=;
	b=dw1XWC/IwY0FGbPz+5Du9SIcVqAzb5MAQ3vVDAs/Xi4+I30ppJ9XKEPKvGaHHriy+lbZFz
	uL1MD2KdNun2/y0XGFyLCc8XJXm7/1r3fImA3SlW1wQnJrqwy4v5bw/3A/4BXrEFyZLMmB
	cyA65TaRnk9smmC9GLCXoLmuCOagT1w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-cJQrK3OkPiSY1ShTwN9BaA-1; Mon, 03 Mar 2025 12:30:32 -0500
X-MC-Unique: cJQrK3OkPiSY1ShTwN9BaA-1
X-Mimecast-MFC-AGG-ID: cJQrK3OkPiSY1ShTwN9BaA_1741023032
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4398ed35b10so21127605e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 09:30:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741023031; x=1741627831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qK6V1d4F8/3GYYMbFs+Mb6fZwFXqDTRxwVUEODfRNfg=;
        b=ChzGG5OBZK70fwyqZiuMJ5DTrYJ3UVKun1u2XuyMsZPYoqRf2egwvcU0iJuq3n47b8
         pVuD1S8bBJBWv0suSIIYq3I5JKLvIP4v9VbIwGR29sHGzKU0w82HQyODJwz8GBk6vLos
         OpEm+dyx1GbdWREEKQh/zRL4qy95XONg4Eesn+WnpgJdJWJbmYG5jlodzjmEOcs/EfSV
         yzq9RikfEgDKjXtUWQU3MF01ToQ7vh0WGk9ffUAecrYi/GzttdPFtVZCstEkprA95I53
         xC/HVzsGDVEpW1ygW6HmuCE4U++cxvOTfFYxqnmjpth1tPntCC/SZMEA4O8Cg/28SBty
         cgOg==
X-Forwarded-Encrypted: i=1; AJvYcCUDR4HwsSV4vHpteC6mBRpWZtqG/oz2nHHGG7KSZz0W94XX4VGvUqqZTfRCoP0mz18enzwyVcmvqOkxv2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe3g4I3CClye4lobQwnHdmuX1MqSx7iiPVixr07OFFk7m8PTJB
	XNuAqz2TkH7kYHk6jkq9NRKi9vxf7UNhs7VBKgRHOt+SlAETMF17lyLBtmEuYps3Tv9LZLBXPfU
	SXgIZC/iOFGaiiFTLYQRy4qayzAsWk3OUMPADt4S3R25NHntSWqBqVOlbG6bydQ==
X-Gm-Gg: ASbGncs8h2l7DsHJifZuI7cfee5icrUeLKdlgMyGMVf0arSFzRJRCBmP248BnKG54rW
	V53/jZeFGjW0/tx/7JL1i4De8AxKH920xoZu3h0fJ6xlB3euYlwHvdCHJFe2b1/mEtyiyDFBZBG
	RvRKhU90cEMzzlky3dcyXQLY7ZEYKsJPRTr6jJ/28TgXJbJOZPHrs5izf9hxThoUzWNk1I+iJNd
	hvhfNYXGkBlY2KuUypbdoVRfycrElxqZ01zrPfkGG6g7aq8biKpOZV3vOgDo8zPzw43pw14XM0G
	PqdpAfch3oCRCHxRCwRzNRlr604CGk1HK1d08B3izZcOlaiVhn24jAVOGcafKJjg
X-Received: by 2002:a05:600c:3ca8:b0:439:a88f:8523 with SMTP id 5b1f17b1804b1-43ba6760622mr101787955e9.21.1741023031542;
        Mon, 03 Mar 2025 09:30:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQsnNiGGEYqX44soHY1inSfp9Dy8FQXmQyAL1i5ej8GJiYTvczodK99UyEHKUMhAfUCjVl7A==
X-Received: by 2002:a05:600c:3ca8:b0:439:a88f:8523 with SMTP id 5b1f17b1804b1-43ba6760622mr101787525e9.21.1741023030939;
        Mon, 03 Mar 2025 09:30:30 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba539466sm204364905e9.18.2025.03.03.09.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 09:30:30 -0800 (PST)
Date: Mon, 3 Mar 2025 18:30:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Claudio Carvalho <cclaudio@linux.ibm.com>, 
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, Dov Murik <dovmurik@linux.ibm.com>, 
	linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 4/6] tpm: add interface to interact with devices
 based on TCG Simulator
Message-ID: <jmo7t55vnwlszauoje2o427re3omdnaaqk2cbhynksb225isig@blymmqrezzo7>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-5-sgarzare@redhat.com>
 <d50d9d6e-10e4-23e8-a584-df28a1c41e86@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d50d9d6e-10e4-23e8-a584-df28a1c41e86@amd.com>

On Mon, Mar 03, 2025 at 08:28:45AM -0600, Tom Lendacky wrote:
>On 2/28/25 11:07, Stefano Garzarella wrote:
>> This is primarily designed to support an enlightened driver for the
>> AMD SVSM based vTPM, but it could be used by any TPM driver which
>> communicates with a TPM device implemented through the TCG TPM reference
>> implementation (https://github.com/TrustedComputingGroup/TPM)
>>
>> Co-developed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>> Co-developed-by: Claudio Carvalho <cclaudio@linux.ibm.com>
>> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> James, Claudio are you fine with the Cdb, Sob?
>> The code is based to what was in the initial RFC, but I removed the
>> tpm_platform module, moved some code in the header, changed some names,
>> etc.
>> For these reasons I reset the author but added C-o-b.
>> Please, let me know if this is okay or if I need to do anything
>> else (reset the author, etc.)
>> ---
>>  include/linux/tpm_tcgsim.h | 136 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 136 insertions(+)
>>  create mode 100644 include/linux/tpm_tcgsim.h
>>
>> diff --git a/include/linux/tpm_tcgsim.h b/include/linux/tpm_tcgsim.h
>> new file mode 100644
>> index 000000000000..bd5b123c393b
>> --- /dev/null
>> +++ b/include/linux/tpm_tcgsim.h
>> @@ -0,0 +1,136 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2023 James.Bottomley@HansenPartnership.com
>> + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
>> + *
>> + * Generic interface usable by TPM drivers interacting with devices
>> + * implemented through the TCG Simulator.
>> + */
>> +#ifndef _TPM_TCGSIM_H_
>> +#define _TPM_TCGSIM_H_
>> +
>> +#include <linux/errno.h>
>> +#include <linux/string.h>
>> +#include <linux/types.h>
>> +
>> +/*
>> + * The current TCG Simulator TPM commands we support.  The complete list is
>> + * in the TcpTpmProtocol header:
>> + *
>> + * https://github.com/TrustedComputingGroup/TPM/blob/main/TPMCmd/Simulator/include/TpmTcpProtocol.h
>> + */
>> +
>> +#define TPM_SEND_COMMAND		8
>> +#define TPM_SIGNAL_CANCEL_ON		9
>> +#define TPM_SIGNAL_CANCEL_OFF		10
>> +/*
>> + * Any platform specific commands should be placed here and should start
>> + * at 0x8000 to avoid clashes with the TCG Simulator protocol.  They should
>> + * follow the same self describing buffer format below.
>> + */
>> +
>> +#define TPM_TCGSIM_MAX_BUFFER		4096 /* max req/resp buffer size */
>> +
>> +/**
>> + * struct tpm_req - generic request header for single word command
>> + *
>> + * @cmd:	The command to send
>> + */
>> +struct tpm_req {
>> +	u32 cmd;
>> +} __packed;
>> +
>> +/**
>> + * struct tpm_resp - generic response header
>> + *
>> + * @size:	The response size (zero if nothing follows)
>> + *
>> + * Note: most TCG Simulator commands simply return zero here with no indication
>> + * of success or failure.
>> + */
>> +struct tpm_resp {
>> +	u32 size;
>> +} __packed;
>> +
>> +/**
>> + * struct tpm_send_cmd_req - Structure for a TPM_SEND_COMMAND request
>> + *
>> + * @hdr:	The request header whit the command (must be TPM_SEND_COMMAND)
>> + * @locality:	The locality
>> + * @inbuf_size:	The size of the input buffer following
>> + * @inbuf:	A buffer of size inbuf_size
>> + *
>> + * Note that TCG Simulator expects @inbuf_size to be equal to the size of the
>> + * specific TPM command, otherwise an TPM_RC_COMMAND_SIZE error is
>> + * returned.
>> + */
>> +struct tpm_send_cmd_req {
>> +	struct tpm_req hdr;
>> +	u8 locality;
>> +	u32 inbuf_size;
>> +	u8 inbuf[];
>> +} __packed;
>> +
>> +/**
>> + * struct tpm_send_cmd_req - Structure for a TPM_SEND_COMMAND response
>> + *
>> + * @hdr:	The response header whit the following size
>> + * @outbuf:	A buffer of size hdr.size
>> + */
>> +struct tpm_send_cmd_resp {
>> +	struct tpm_resp hdr;
>> +	u8 outbuf[];
>> +} __packed;
>> +
>> +/**
>> + * tpm_tcgsim_fill_send_cmd() - fill a struct tpm_send_cmd_req to be sent to the
>> + * TCG Simulator.
>> + * @req: The struct tpm_send_cmd_req to fill
>> + * @locality: The locality
>> + * @buf: The buffer from where to copy the payload of the command
>> + * @len: The size of the buffer
>> + *
>> + * Return: 0 on success, negative error code on failure.
>> + */
>> +static inline int
>> +tpm_tcgsim_fill_send_cmd(struct tpm_send_cmd_req *req, u8 locality,
>> +			 const u8 *buf, size_t len)
>> +{
>> +	if (len > TPM_TCGSIM_MAX_BUFFER - sizeof(*req))
>> +		return -EINVAL;
>> +
>> +	req->hdr.cmd = TPM_SEND_COMMAND;
>> +	req->locality = locality;
>> +	req->inbuf_size = len;
>> +
>> +	memcpy(req->inbuf, buf, len);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * tpm_tcgsim_parse_send_cmd() - Parse a struct tpm_send_cmd_resp received from
>> + * the TCG Simulator
>> + * @resp: The struct tpm_send_cmd_resp to parse
>> + * @buf: The buffer where to copy the response
>> + * @len: The size of the buffer
>> + *
>> + * Return: buffer size filled with the response on success, negative error
>> + * code on failure.
>> + */
>> +static inline int
>> +tpm_tcgsim_parse_send_cmd(const struct tpm_send_cmd_resp *resp, u8 *buf,
>> +			  size_t len)
>
>This is a confusing name... would tpm_tcgsim_parse_cmd_resp() be a
>better name?

Ack, and we can rename also the other in tpm_tcgsim_fill_cmd_req().

Thanks,
Stefano


