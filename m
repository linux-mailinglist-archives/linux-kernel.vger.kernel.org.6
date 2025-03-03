Return-Path: <linux-kernel+bounces-542338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE587A4C8CB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA3C3B6FAA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79FD21D59C;
	Mon,  3 Mar 2025 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FuNx4zhk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5601C21E0AC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020091; cv=none; b=jdy3RSHynJfh5yGYfBFVAtjx06y3aNl0LrZaHDzTIGmYBPhZecSGOHzEjaTTr0lZLh4gOSAzeQ4N/o6bFz9vKJSx3lxXNwY8D8R5CUxEXxO/6mWVPDCj3NeVtEmQq2bl/tbXPoWmZhhXtmd/fJlo5til7ttFflGxns+ZYHpUZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020091; c=relaxed/simple;
	bh=wtuVdp1dWUSTUzgmcaVuUFduzu2pv/qe+S0adx91rFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HbPiR43V6ToypcZ13XDdvOlfGSjEdU2vGdRFFJRdgyWxhh9A/7f2nob7tAw2abLEU+A2mPiWOU4s8dmbu8mmjwupsyG6RaPKB6426rWZx9VZYlL05ZOOaX6c1KOkceOoPuwIJueBNtjCNXtwwwGh76b837BP+5oiPTr1JzvsX2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FuNx4zhk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741020088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S99anXn8JXy9g/82OL5Iaa34Jq4clnv+XI8UuV0Q2yM=;
	b=FuNx4zhkJXN10A0n22mrFwySDP2124AUiRfptS9Je6tWB0/iodoFNOKCcuOf6M5i4736Ev
	OxMeasN1z72AoK6sZXPKjPw+P9B0XZUHXoTiKlBCMOYE7Mg2S4XSnzXCM/JSYWy8IQ+v8c
	rYEoClLKb7SZ3dmjXIFx50xf6uVxPUs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-X6devD8-NRGauNnCO9ssNw-1; Mon, 03 Mar 2025 11:41:27 -0500
X-MC-Unique: X6devD8-NRGauNnCO9ssNw-1
X-Mimecast-MFC-AGG-ID: X6devD8-NRGauNnCO9ssNw_1741020085
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4393b6763a3so18045245e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:41:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020084; x=1741624884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S99anXn8JXy9g/82OL5Iaa34Jq4clnv+XI8UuV0Q2yM=;
        b=jDtOb+WMVYCEC9byeeoENhdQO+zks2mWvB9ieGsmeAo41fwgZRlPkOjyrNkrug9ZHz
         7lp1mQBIoYrAwf6OVp3vnMfKCtkjnUO+22+90X98tPP0UAQ5c3gLBuOSQIoRel4tS5ht
         It54JiUvXhmGScYlKiOF/bgWgnKnhWygbj2+2f+VIHakfEvwGbr40nXhcOcK7tNwj/AS
         K136E8LfNKfrXJTENn1DPCsaRwkxEzbuuNvORJ+GLjQ/bFjsnm3aFsCsU2tuH7ASjVqJ
         V4YhPmFOzsq1PpsBmkvQRcc2igEU8Cn787Cu5kVR8JryCjNKD/L//ZXa/1BZMMX+Vvl3
         5ZgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzUh6PvKbcJ0i8Vopr7o746MBtHX5JAOWcfPwsgSyrJVQEeo5aHtxpghRMVGBLAs5oDPTGa0Z97JzIVpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Gg/VZPdYvxEN5ZYephCb+ET5RCrWmLocTlBlYJHHuqWZMatE
	gCggO9A5OTn3jIRrvBt3FMwd3B8KII3WdjHee2XCuBrj9Hru525Juk+ktSMDZbOhoSdW2+njkHT
	Ah4d0LQCL4h2+UgfLg2eSc7AL971laaz4/gYFph1gLH62d+/cIbT/4rQ+rDG4d07oQdaY5A==
X-Gm-Gg: ASbGncuKgaEJ8pEHwujzQWBJGNrxKk86B2UAgAXf9KKGp/WC5CH6CFjCNYmwhtJ9/5i
	uB3i/LLvQFkryDBp87z5zOlEfFxdZ2OijeuYWolG9BJr7Zz1UwGQ3mSQS0NFVWzghmxcY/Ls26g
	M+Jsr5c17oV6+5sdjMJp3GpeR0Q0NoUDKk7XvM4raTc34PFHYjDcm/f8yVVuEgrJwKgvmPsdpA3
	m7jrJqcgTJKb/P/IDzyhB19n19EYRtTz/I9fihK+3DA6weczOAjMAOaIyKaJETg+GEPlQDjtvoz
	wmPDd1tqoEHD7O9zIZDih5h0cWCnzk/nwoZ9Xz9pr3lQuFFHYJQ9SOOlDpXG3gO9
X-Received: by 2002:a05:600c:1550:b0:439:9f19:72ab with SMTP id 5b1f17b1804b1-43ba67583ecmr104338755e9.23.1741020084425;
        Mon, 03 Mar 2025 08:41:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvv13ffXGAXCLH0EVzmjBIDlyJbzC6drJbfPUy9UV5VvxP8GlxxWs0ezzWZVNxeiFA1wafgw==
X-Received: by 2002:a05:600c:1550:b0:439:9f19:72ab with SMTP id 5b1f17b1804b1-43ba67583ecmr104338445e9.23.1741020083822;
        Mon, 03 Mar 2025 08:41:23 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bbc030d24sm57205495e9.22.2025.03.03.08.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:41:23 -0800 (PST)
Date: Mon, 3 Mar 2025 17:41:17 +0100
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
Message-ID: <vv2ih4adpltpcudnrs76z5ni2vdxxj465cqrqcgizmkvr32ash@ambm6xkvi5e3>
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

Yes, sorry, I rephrased James' previous commit description, but I admit 
it didn't come out clear.

I meant to say that "this" new header contains useful functions for 
creating commands and parsing responses in those drivers where vTPM 
devices are implemented via the TCG TPM reference implementation.

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

We might see that header as a specification of how to communicate with 
the device.

What do you suggest we do in this case?

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

The vTPM device is emulated through the simulator of the TCG reference 
implementation, so to communicate with it we have to send commands 
following the specified format.

This header is intended to add code that could also be reused by other 
drivers where the device follows this format. As James mentioned, 
Microsoft has something similar for OpenHCL and may reuse this header in 
the future.

If you think it is too much, I can include these things for now in 
tpm-svsm.c and when we have another driver we will pull them out.

Thanks,
Stefano


