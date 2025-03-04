Return-Path: <linux-kernel+bounces-544678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9FDA4E3A6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D52177A4125
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13583283681;
	Tue,  4 Mar 2025 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggalFGBA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8215D259CB8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101858; cv=none; b=LrSRx9ieXvwhJE1X9ie24T/noruFuJxGS0n+mhL/cJlNNo+eBrM0yrV/XiuhcGQQvf6gGJK4riZWjFsNre+w++qTgOacOIrAdrBcW/UjFB3RNH7leoDxZz18krRK2O1z4iJA26D1n9GdGs6u+AVT8zLfcMQtOeU6tqLie17JhFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101858; c=relaxed/simple;
	bh=9Jnaaj+MupYsXtZ5FbywLqogWLKCVBeU+mapvXdmuLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTNpkDM8cKNMoC5Bf0wPm/eDW7Mb0XjCXRQq2w1FjMwTGxu66QyEFkOfnWQC4XSNt4royIA/ngwZbpsrhuZbr2NGdoRo6FURdoY23hEf/Puf8lMRctF3aIrMnGFFoSiD8uwWq0xNqoVE/qt/IF5d7ySeUATG+Q1ZeqL4ToI5n1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ggalFGBA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741101855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QvFubViMNlvElEXntbaUBxPleCcZNXXI9ACRXmzKeq0=;
	b=ggalFGBA1dh3bu4i1jNbTgIS+PCtrM6q8qlHlnesW+XfqLIgyYqfSky2Wt9b2I3l978p5r
	N0fzMfiOvEjRKdEKSHLTj3TtOYv7/OSleQogquoI79X8Lw3A0pLX4pJGaKSSUyRqsUXcka
	x0Vx+juOqaDNwfys8EOjtOnrColNLjQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-l6Q0tCCcOCiT8CxdtdNSoA-1; Tue, 04 Mar 2025 10:23:59 -0500
X-MC-Unique: l6Q0tCCcOCiT8CxdtdNSoA-1
X-Mimecast-MFC-AGG-ID: l6Q0tCCcOCiT8CxdtdNSoA_1741101838
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-390eb06d920so4333075f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:23:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741101838; x=1741706638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvFubViMNlvElEXntbaUBxPleCcZNXXI9ACRXmzKeq0=;
        b=unE3px1GM19++2QCsg9yhLi110wLb4/T7DUxqZKj3zpQmSXQkcySKvnkmxWMOpOah5
         qr9A2qB/bWqIiZ+glVKLIXxOCZJSN9kg0D9RYEIsyHjpRwh5H9hUf59JSaVf+IAYEFm5
         ZTd5riW8+1nzKmbPDSw96e6u64JL7Nsh2T9EwU0UTe54bn31VGE7oqE+Lxdezxg7Wqov
         /xRA5QXbjaw9Yw23KzaxpbuqkPsPQeaf4NsMZfscCYk7lol0JO+KTllEV6bCD8OHUtY9
         QH6ckdlRai2HvxZDT0+5uw6UyVwyK5VZssMBJp8voGDBNWDKZphTmFt4x3Fa9neLZ8mR
         CAxA==
X-Forwarded-Encrypted: i=1; AJvYcCVDAr98nYklASWBeB2Aa7ANypONTAVHARFPMKbNbrjVz+3TjziCqS8Bti6FWCWn8K6z3RB6G7ZSjeaw5h0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo8pUQPCd6wFWR3pTmijXWdZnZtu6bzeTktrddcyq2KgzJDQ+Z
	IkHHg8Jzu+DM23Hnp7fhoPzci23at0pToh5vD2PSOpNJVpEcf/yW++ai7LVEml5UJk6srG1WiU6
	bwmd9uQt5cWU7Csql51eDKw0BRQ0a5xvSWGYk+8LUAPfKV7DhXk5Ce6MPBKjBwA==
X-Gm-Gg: ASbGncs/ifgfZlthhYYd/Ho0yPvhlDBR85zouLbOF4S2uzApsm3iEuSjGQ2EJZVYGbs
	Am+qVgMvOpBWRVSI2krNBgaO19h22HAVx9oYkst6xGztlUVftAhUT5Qe5OhGEuGJd5bEiwb/NYA
	ppVgyJ19koklioXfTWB6MXyu8FYA3LYsA2Ta0pP+Vwa+ENeiBgnWJydltpJgJgsZiVhEjIwo5oo
	85OACy+jTNAuzNhmRxjd3sYSjdN9Q7jbR+QcFtzkCF7KBhlYDSKmJaXuGd6Da648mvrEU+mo1D8
	SSUDoQenfQqsdrGX7Fx6S0E/pR58MyrkcJOfs0QHPOTa9sxH3Ux/LCKd1T6El3dd
X-Received: by 2002:adf:fc11:0:b0:38c:5fbf:10ca with SMTP id ffacd0b85a97d-390eca06cf4mr15878895f8f.39.1741101837802;
        Tue, 04 Mar 2025 07:23:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXUbzP/MD3DaiOBhULX8asTjjiwbkIGLuALrZE+TAO2F//xDur+SEeYf1Lx6gpZrq9uCm1kg==
X-Received: by 2002:adf:fc11:0:b0:38c:5fbf:10ca with SMTP id ffacd0b85a97d-390eca06cf4mr15878837f8f.39.1741101837140;
        Tue, 04 Mar 2025 07:23:57 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d6cdsm17907254f8f.84.2025.03.04.07.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:23:56 -0800 (PST)
Date: Tue, 4 Mar 2025 16:23:51 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev, 
	Dionna Glaze <dionnaglaze@google.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 4/6] tpm: add interface to interact with devices
 based on TCG Simulator
Message-ID: <7dltjdc4csdao5djx2jkjnvm72ubhagjwvgrpyqrr3aeo5cicn@cxrxusjpgce7>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-5-sgarzare@redhat.com>
 <Z8JncxQM7Nkit0Q6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z8JncxQM7Nkit0Q6@kernel.org>

On Sat, Mar 01, 2025 at 03:48:35AM +0200, Jarkko Sakkinen wrote:
>On Fri, Feb 28, 2025 at 06:07:18PM +0100, Stefano Garzarella wrote:
>> This is primarily designed to support an enlightened driver for the
>
>The commit message is half-way cut.
>
>I.e. it lacks the explanation of "this".
>
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
>
>We should not be dependent on any out-of-tree headers.
>
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
>> +{
>> +	if (len < resp->hdr.size)
>> +		return -E2BIG;
>> +
>> +	if (resp->hdr.size > TPM_TCGSIM_MAX_BUFFER - sizeof(*resp))
>> +		return -EINVAL;  // Invalid response from the platform TPM
>> +
>> +	memcpy(buf, resp->outbuf, resp->hdr.size);
>> +
>> +	return resp->hdr.size;
>> +}
>> +
>> +#endif /* _TPM_TCGSIM_H_ */
>> --
>> 2.48.1
>>
>
>This commit got me lost tbh.

Now I understand why you got lost, my bad!
I checked further and these structures seem to be specific to the vTPM 
protocol defined by AMD SVSM specification and independent of TCG TPM 
(unless reusing some definitions like TPM_SEND_COMMAND).

At this point I think it is best to remove this header (or move in 
x86/sev) and move this rewrap to x86/sev to avoid confusion.

I'll do in v3, sorry for the confusion.

Stefano


