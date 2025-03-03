Return-Path: <linux-kernel+bounces-542347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7569BA4C8C6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC901887AF0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43D5250C01;
	Mon,  3 Mar 2025 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBMoLksg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0974250C05
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020394; cv=none; b=okIKcyJ6GMCbdwyiJMDvjcEGE56x9ccp0aAoAnngj+Hu0gSDmTPZNAC2R2fGsLLDmNOVXiYKNgotoa4qf04ZVZp7obt9TzKZfA+tMdh4H2PsF2cxyXFWCTl7uSm/Kd54Uplx76QRomP4ufUlJDEAJ9ALHoZ6+g15BAi6FR3PUaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020394; c=relaxed/simple;
	bh=fDsoN8iXA5mlL9B8Jv9140jXp34B1txTI1Cb0p47uyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho9EqSUDA99U6miqvcw+HjnaHaqB8huVdqOACDZq5k3RrpWcVAOV+MdfL6CMFOjJZfzor1M9IhfOxYzcgS+bNaj9frcTnq0205wUVJjaAaVeQ2IAfN0XGb33UC6ARYPsKK34xKcWB0XRhQ636P4EQXf/laPc0vq6+U09u+Hyqec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBMoLksg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741020391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CcOdj8jl42bG7J+d9S1U7GITWB345Sp/+XQWAhZWr7c=;
	b=SBMoLksgH0RX9EER1NourZxiqiyFR5VluVn5RpWHIvLqNK+RgDUg4MEqoha8s8O/DLeBlp
	wSruWqec6N7gJ1ijg1aruDic07WeNWMFel2Tic7O9X47Bxg+YJ4iuEEXDc+KDQ7fr4NaPV
	VdMOnoGFB20mUSnL/jG+h83GSBO5HP4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-QKNK6wElO8yr-q-cA6Eg2A-1; Mon, 03 Mar 2025 11:46:25 -0500
X-MC-Unique: QKNK6wElO8yr-q-cA6Eg2A-1
X-Mimecast-MFC-AGG-ID: QKNK6wElO8yr-q-cA6Eg2A_1741020383
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-390fd681712so940789f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741020383; x=1741625183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcOdj8jl42bG7J+d9S1U7GITWB345Sp/+XQWAhZWr7c=;
        b=nVxluZY+adiCvK01sk6ggwZEAv+e8hrs/3m4xAtu22TIIYfpw//i3zQN4fMAf7cYAj
         4BImDbSipt06hNhyfJLp4KeNbKHaBX25C3dgxnyxYCxtH0MISejQwjxslUDKJN4/DpqG
         Qbe4HasaalM86GtH0deXxXpecievrqu7DM+ckmx4Mw5AmNYvOy+SqnEY61bMsXdkXr0E
         aOo15GGCd7WpK4KrYwll7nxyF6AfCYzKCvcgbHuCXC+rqTDxIxf5noyIzTd5u2zmaGUI
         STMDm/GNW2LWAdUAFjGGrdHmIJJebqCzySklOAtqzcTyBRzJ+ZbI4wTp47Ljqix2uPon
         PhZg==
X-Forwarded-Encrypted: i=1; AJvYcCVBUbdfnDSZeZeybsYmK8DDEfuMLdUzS58uHtVv7Sc1wQo8hJdvhIjkQKUWJubJ7id7gcfIp6orjefZ9wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLWErp7GP8g9Si0eWYZepc7s5QgSjlS4lPXg053AuyRYZMBrZm
	fAPBFKxWyE/ouMQNdHsCnHo47x4RVpBlbOUuu2slNwy1kDUobn0MKnTDJ4//U3V1ERyN9YIjc/I
	Uw5Kk9vTy6ea+kTdqhOUIpHCNepeytEx86KGkPeoBnuDSsMRLYtkuFYx9AkvOBQ==
X-Gm-Gg: ASbGnctOPbklXKfzwTi3207hlaIf0BONvC3ZRCiShAOLADOYV7YYB5sl1FY/Ky7+Ijb
	+ct6KjIJ4GQL/LIF/uLclO+SFWj92T6fkll5Rk5j5ZX4VTkq3O8wXMwEjv/LCAkw1njTcY1+QDC
	t326TjKnr9YXlIFwyoX6Qc3HYtne37ktpSPjgv/jY4Gb8JcXPhKflVLq//gaWBzWzDhjVtYsGd0
	5rODB16wk0dzxjLTIMPfW+LtjUk+pKwrfe9YaYd6b+wtuU4pnSyWzHSz3LE6gR/AnS4tmG4hdCL
	W1K7gScKFtLiJ3l1A/gG1vEAM7YXt67/aBCcfkDVKqmyjEJ6TLEPWwYXNm5KnKxo
X-Received: by 2002:a5d:64a1:0:b0:38f:2678:d790 with SMTP id ffacd0b85a97d-390ec9bcdcemr10177216f8f.33.1741020383377;
        Mon, 03 Mar 2025 08:46:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGovElglYA6IFQYMop2N/jlBDbEKHe10duAsnITHMrTVGL9Q69ofNIA6frZbGUtmQHgdi8qQA==
X-Received: by 2002:a5d:64a1:0:b0:38f:2678:d790 with SMTP id ffacd0b85a97d-390ec9bcdcemr10177193f8f.33.1741020382825;
        Mon, 03 Mar 2025 08:46:22 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485df22sm15213488f8f.97.2025.03.03.08.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 08:46:22 -0800 (PST)
Date: Mon, 3 Mar 2025 17:46:16 +0100
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
Subject: Re: [RFC PATCH v2 5/6] tpm: add SNP SVSM vTPM driver
Message-ID: <tpi74sl22zqngutzbqp7ajz7khwom2fgth2n3i77houwdqc3gl@obkhgfcagubh>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-6-sgarzare@redhat.com>
 <Z8JoMrUm9Dnoqgoi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Z8JoMrUm9Dnoqgoi@kernel.org>

On Sat, Mar 01, 2025 at 03:51:46AM +0200, Jarkko Sakkinen wrote:
>On Fri, Feb 28, 2025 at 06:07:19PM +0100, Stefano Garzarella wrote:
>> Add driver for the vTPM defined by the AMD SVSM spec [1].
>>
>> The specification defines a protocol that a SEV-SNP guest OS can use to
>> discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
>> in the guest context, but at a more privileged level (VMPL0).
>>
>> The new tpm-svsm platform driver uses two functions exposed by x86/sev
>> to verify that the device is actually emulated by the platform and to
>> send commands and receive responses.
>>
>> The vTPM is emulated through the TCG reference implementation, so this
>> driver leverages tpm_tcgsim.h to fill commands and parse responses.
>
>Why? Please don't.

You mean it's better not to have the external header and have all the 
functions here to prepare commands and parse responses?

As I mentioned, I did this because there may be other future drivers 
that could use it to talk to emulated devices in the same way, that is, 
through the TCG TPM reference implementation,

>
>>
>> The device cannot be hot-plugged/unplugged as it is emulated by the
>> platform, so we can use module_platform_driver_probe(). The probe
>> function will only check whether in the current runtime configuration,
>> SVSM is present and provides a vTPM.
>>
>> [1] "Secure VM Service Module for SEV-SNP Guests"
>>     Publication # 58019 Revision: 1.00
>>     https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  drivers/char/tpm/tpm_svsm.c | 120 ++++++++++++++++++++++++++++++++++++
>>  drivers/char/tpm/Kconfig    |  10 +++
>>  drivers/char/tpm/Makefile   |   1 +
>>  3 files changed, 131 insertions(+)
>>  create mode 100644 drivers/char/tpm/tpm_svsm.c
>>
>> diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
>> new file mode 100644
>> index 000000000000..1c34133990c5
>> --- /dev/null
>> +++ b/drivers/char/tpm/tpm_svsm.c
>> @@ -0,0 +1,120 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
>> + *
>> + * Driver for the vTPM defined by the AMD SVSM spec [1].
>> + *
>> + * The specification defines a protocol that a SEV-SNP guest OS can use to
>> + * discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
>> + * in the guest context, but at a more privileged level (usually VMPL0).
>> + *
>> + * The vTPM is emulated through the TCG reference implementation, so this
>> + * driver leverages tpm_tcgsim.h to fill commands and parse responses.
>> + *
>> + * [1] "Secure VM Service Module for SEV-SNP Guests"
>> + *     Publication # 58019 Revision: 1.00
>> + *     https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
>> + */
>> +
>> +#include <asm/sev.h>
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/tpm_tcgsim.h>
>> +
>> +#include "tpm.h"
>> +
>> +struct tpm_svsm_priv {
>> +	u8 buffer[TPM_TCGSIM_MAX_BUFFER];
>> +	u8 locality;
>> +};
>> +
>> +static int tpm_svsm_send_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len,
>> +			      size_t to_send)
>> +{
>> +	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
>> +	int ret;
>> +
>> +	ret = tpm_tcgsim_fill_send_cmd((struct tpm_send_cmd_req *)priv->buffer,
>> +				       priv->locality, buf, to_send);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = snp_svsm_vtpm_send_command(priv->buffer);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return tpm_tcgsim_parse_send_cmd((struct tpm_send_cmd_resp *)priv->buffer,
>> +					 buf, buf_len);
>> +}
>> +
>> +static struct tpm_class_ops tpm_chip_ops = {
>> +	.flags = TPM_OPS_AUTO_STARTUP,
>> +	.send_recv = tpm_svsm_send_recv,
>> +};
>> +
>> +static int __init tpm_svsm_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct tpm_svsm_priv *priv;
>> +	struct tpm_chip *chip;
>> +	int err;
>> +
>> +	if (!snp_svsm_vtpm_probe())
>> +		return -ENODEV;
>> +
>> +	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * FIXME: before implementing locality we need to agree what it means
>> +	 * for the SNP SVSM vTPM
>> +	 */
>> +	priv->locality = 0;
>> +
>> +	chip = tpmm_chip_alloc(dev, &tpm_chip_ops);
>> +	if (IS_ERR(chip))
>> +		return PTR_ERR(chip);
>> +
>> +	dev_set_drvdata(&chip->dev, priv);
>> +
>> +	err = tpm2_probe(chip);
>> +	if (err)
>> +		return err;
>> +
>> +	err = tpm_chip_register(chip);
>> +	if (err)
>> +		return err;
>> +
>> +	dev_info(dev, "SNP SVSM vTPM %s device\n",
>> +		 (chip->flags & TPM_CHIP_FLAG_TPM2) ? "2.0" : "1.2");
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit tpm_svsm_remove(struct platform_device *pdev)
>> +{
>> +	struct tpm_chip *chip = platform_get_drvdata(pdev);
>> +
>> +	tpm_chip_unregister(chip);
>> +}
>> +
>> +/*
>> + * tpm_svsm_remove() lives in .exit.text. For drivers registered via
>> + * module_platform_driver_probe() this is ok because they cannot get unbound
>> + * at runtime. So mark the driver struct with __refdata to prevent modpost
>> + * triggering a section mismatch warning.
>> + */
>> +static struct platform_driver tpm_svsm_driver __refdata = {
>> +	.remove = __exit_p(tpm_svsm_remove),
>> +	.driver = {
>> +		.name = "tpm-svsm",
>> +	},
>> +};
>> +
>> +module_platform_driver_probe(tpm_svsm_driver, tpm_svsm_probe);
>> +
>> +MODULE_DESCRIPTION("SNP SVSM vTPM Driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:tpm-svsm");
>> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
>> index 0fc9a510e059..fc3f1d10d31d 100644
>> --- a/drivers/char/tpm/Kconfig
>> +++ b/drivers/char/tpm/Kconfig
>> @@ -225,5 +225,15 @@ config TCG_FTPM_TEE
>>  	help
>>  	  This driver proxies for firmware TPM running in TEE.
>>
>> +config TCG_SVSM
>> +	tristate "SNP SVSM vTPM interface"
>> +	depends on AMD_MEM_ENCRYPT
>> +	help
>> +	  This is a driver for the AMD SVSM vTPM protocol that a SEV-SNP guest
>> +	  OS can use to discover and talk to a vTPM emulated by the Secure VM
>> +	  Service Module (SVSM) in the guest context, but at a more privileged
>> +	  level (usually VMPL0).  To compile this driver as a module, choose M
>> +	  here; the module will be called tpm_svsm.
>> +
>>  source "drivers/char/tpm/st33zp24/Kconfig"
>>  endif # TCG_TPM
>> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
>> index 9bb142c75243..52d9d80a0f56 100644
>> --- a/drivers/char/tpm/Makefile
>> +++ b/drivers/char/tpm/Makefile
>> @@ -44,3 +44,4 @@ obj-$(CONFIG_TCG_XEN) += xen-tpmfront.o
>>  obj-$(CONFIG_TCG_CRB) += tpm_crb.o
>>  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>>  obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
>> +obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
>> --
>> 2.48.1
>>
>
>OK, so this is like ARM's driver architecture using SMC, and I think
>tpm_ftpm_tee is probably one great reflection for this overall. Is this
>correct analysis, or not?

I just took a closer look at what ARM SMC is, and yes, it looks like a 
correct analysis.

Dionna took a look at reusing ftpm and already replied with her 
analysis, better to continue in that thread the discussion on eventually 
reusing ftpm.

Thanks,
Stefano


