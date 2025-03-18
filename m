Return-Path: <linux-kernel+bounces-565952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA53EA67185
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BCAF1893271
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41592080E3;
	Tue, 18 Mar 2025 10:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYYY5G9+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC3F20764C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294350; cv=none; b=PERrYs62kWYtigq1qiOg5xNr6I6DVUpjWWVBc/sjT2WiZrg+GtoAi09G9XE19FDcgqMIGxNmQiP1g/jFdOosDA8H6nZMQXNLE/5oNDU56tabbbDT1V+yW18MCS7egzQ0JJHFhAPxy/TRnOBxXhgzhoHIAQVA6BO1xU+e0TzDVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294350; c=relaxed/simple;
	bh=S5vhga9QA7reqPDVqnFGOSniHDIqSP109WCSFuO233w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdR5hw3HI9xXpQduBu6scLt00kSAKHSMmT39rYc1C4vO+rUJBpy8fpspB3Oq2SxsclcqoNgRuakIR1PsMTnLsifUAxtVwuivJkDYqy4YgmUJGYdCrdsTxthRjAnF7jECLMSFOqCm0XTCyfxnCBLHiRJrJlT4jfv5IOi90YeVDKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYYY5G9+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742294347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jnWPwRdxfjJmbmL9lUdfvnLVfhyxHEjPQZWNXGFbNek=;
	b=CYYY5G9+9qyiS7hAFaKgh6UIhhtVqRoTgfQBlK5azMI4Q7DM8quf3dh3nHx06/HRuIo7jA
	FiBObMjUWgvryriK2mH34kNaRK3RtYVpEGwYoqAs9ED0i7ncT0oeB6G3sBLJOEirqXPVG3
	j7Sa+JyE1R94d5NBjE3WSXEVr0Uwn2g=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-z4-gtNvBPqCFo_6eiHlQoQ-1; Tue, 18 Mar 2025 06:39:06 -0400
X-MC-Unique: z4-gtNvBPqCFo_6eiHlQoQ-1
X-Mimecast-MFC-AGG-ID: z4-gtNvBPqCFo_6eiHlQoQ_1742294345
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6fda1dcbdf1so51331797b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742294345; x=1742899145;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jnWPwRdxfjJmbmL9lUdfvnLVfhyxHEjPQZWNXGFbNek=;
        b=jvQqvA1fP1dMMg6Y/q2etLau4kV6C3J9Hb+MpO3TY5KBkQ3xReU3a3qTz1546VDXOc
         dfQV3bNiCEfRNXzooOdH0vfNaVVsZzC4JbvpkowW5u6zt+IMGBmf9mqr7HD5hYkFQKJe
         a/+OM9L7V2IdhX8zkt1JPzlJ1asiTGA5wyTJIjsGEg83OPZ1XM5Vy3t2EsVH47LO1BL9
         9cWbfCpsPInQqrMTVVrEcBNv3s9PM5vsRl8YENIgLHoiFo8e9UgHr224NMDJSIqUHROZ
         eYxUOJ+fptWrvu9BBdVAWM+CWQldwAMwlvOwsXueR+3WpWCVksUib6oe5urtr5InLvfO
         zfHg==
X-Forwarded-Encrypted: i=1; AJvYcCXEpZb7jt+DZEjSGomikRN+VJbi6XQYQ4dGLPa1BJQcEtnkTAUDabnkKW8xQNK2hcwpn8h+bG0twUrI4Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgeSHYXPzO2/z8ISKBVgOokLieaRMnChttOIjbskj5pPzhU0zF
	NuU8615wQEhcelrKPl0HQhI1gI+agVjl0SqTCCibyE+Sn9PQmlrHR7uzO62DpZTamKg8WK5H5nc
	deOCUh8mD/ZlvmU0+UQ2/bgF74tpSYaTBJmQl26JC8tkRNOtdUy43NPZ23mPeWlY6sITNBP0Vbw
	WFSFOPgwxyAxq+chDM7TmY8VHdfETQ48H5Hlfp
X-Gm-Gg: ASbGnctNQxJwGQpHymRa4/8SSa3VZmCx5HX1q4cFYRiF/K+AmPE7CwtCOlGDoKFbDZO
	7HjWUUtCViQ4op2g4FrnjbvB5Rhnz4fIUegYKSvZF1POjIM7rxGCh8dUZOhPnarT7Ie66ofA=
X-Received: by 2002:a05:690c:6f12:b0:6ef:94db:b208 with SMTP id 00721157ae682-6ffdcdd903emr42056207b3.24.1742294345605;
        Tue, 18 Mar 2025 03:39:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcs34+mywRkHH9/zr57+wQrTFedRyoTFqcoTadxI7B6Gl4m+IzuStg1aOOe8u9qwg2EAkANPN1T9ZcW8oiY+0=
X-Received: by 2002:a05:690c:6f12:b0:6ef:94db:b208 with SMTP id
 00721157ae682-6ffdcdd903emr42055977b3.24.1742294345278; Tue, 18 Mar 2025
 03:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311094225.35129-1-sgarzare@redhat.com> <20250311094225.35129-4-sgarzare@redhat.com>
 <e4eeaead-2277-1f6f-86eb-f80deae2135b@amd.com> <Z9gm9iWhk5Zs2NvI@kernel.org>
In-Reply-To: <Z9gm9iWhk5Zs2NvI@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 18 Mar 2025 11:38:54 +0100
X-Gm-Features: AQ5f1Jr7rf_kvKv3CkN5VNDwMFWrJLIRyHbLjA-wM7Oj1IfVfGHscJveaLj3fVw
Message-ID: <CAGxU2F7fdAi148rB-4c==-qCOW1SJjwf4AzC2=TUhfPXMhR5pQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] tpm: add SNP SVSM vTPM driver
To: Jarkko Sakkinen <jarkko@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
	linux-integrity@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>, 
	Dionna Glaze <dionnaglaze@google.com>, linux-coco@lists.linux.dev, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 17, 2025 at 03:43:18PM +0200, Jarkko Sakkinen wrote:
>On Fri, Mar 14, 2025 at 11:48:11AM -0500, Tom Lendacky wrote:
>> On 3/11/25 04:42, Stefano Garzarella wrote:
>> > Add driver for the vTPM defined by the AMD SVSM spec [1].
>> >
>> > The specification defines a protocol that a SEV-SNP guest OS can use to
>> > discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
>> > in the guest context, but at a more privileged level (VMPL0).
>> >
>> > The new tpm-svsm platform driver uses two functions exposed by x86/sev
>> > to verify that the device is actually emulated by the platform and to
>> > send commands and receive responses.
>> >
>> > The device cannot be hot-plugged/unplugged as it is emulated by the
>> > platform, so we can use module_platform_driver_probe(). The probe
>> > function will only check whether in the current runtime configuration,
>> > SVSM is present and provides a vTPM.
>> >
>> > This device does not support interrupts and sends responses to commands
>> > synchronously. In order to have .recv() called just after .send() in
>> > tpm_try_transmit(), the .status() callback returns 0, and both
>> > .req_complete_mask and .req_complete_val are set to 0.
>> >
>> > [1] "Secure VM Service Module for SEV-SNP Guests"
>> >     Publication # 58019 Revision: 1.00
>> >
>> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > ---
>> > v3:
>> > - removed send_recv() ops and followed the ftpm driver implementing .status,
>> >   .req_complete_mask, .req_complete_val, etc. [Jarkko]
>> > - removed link to the spec because those URLs are unstable [Borislav]
>> > ---
>> >  drivers/char/tpm/tpm_svsm.c | 148 ++++++++++++++++++++++++++++++++++++
>> >  drivers/char/tpm/Kconfig    |  10 +++
>> >  drivers/char/tpm/Makefile   |   1 +
>> >  3 files changed, 159 insertions(+)
>> >  create mode 100644 drivers/char/tpm/tpm_svsm.c
>> >
>> > diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
>> > new file mode 100644
>> > index 000000000000..5540d0227eed
>> > --- /dev/null
>> > +++ b/drivers/char/tpm/tpm_svsm.c
>> > @@ -0,0 +1,148 @@
>> > +// SPDX-License-Identifier: GPL-2.0-only
>> > +/*
>> > + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
>> > + *
>> > + * Driver for the vTPM defined by the AMD SVSM spec [1].
>> > + *
>> > + * The specification defines a protocol that a SEV-SNP guest OS can use to
>> > + * discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
>> > + * in the guest context, but at a more privileged level (usually VMPL0).
>> > + *
>> > + * [1] "Secure VM Service Module for SEV-SNP Guests"
>> > + *     Publication # 58019 Revision: 1.00
>> > + */
>> > +
>> > +#include <asm/sev.h>
>>
>> Typically the "asm" includes are after the "linux" includes and separated
>> from each other by a blank line.

Yep, I already fixed it in v4, since I found that issue while
backporting this patch to CentOS 9.

>>
>> > +#include <linux/module.h>
>> > +#include <linux/kernel.h>
>> > +#include <linux/platform_device.h>
>> > +#include <linux/svsm_vtpm.h>
>> > +
>> > +#include "tpm.h"
>> > +
>> > +struct tpm_svsm_priv {
>> > +  u8 buffer[SVSM_VTPM_MAX_BUFFER];
>> > +  u8 locality;
>> > +};
>>
>> I'm wondering if the buffer shouldn't be a pointer to a page of memory
>> that is a page allocation. This ensures it is always page-aligned in case
>> the tpm_svsm_priv structure is ever modified.

@Tom Should that buffer really page aligned?

I couldn't find anything in the specification. IIRC edk2 also doesn't
allocate it aligned, and the code in SVSM already handles the case when
this is not aligned.

So if it is to be aligned to the pages, we should reinforce it in SVSM
(spec/code) and also fix edk2.

Or was yours a suggestion for performance/optimization?

>>
>> As it is, the kmalloc() allocation will be page-aligned because of the
>> size, but it might be safer, dunno, your call.
>
>This was good catch. There's actually two issues here:
>
>1. SVSM_VTPM_MAX_BUFFER is same as page size.
>2. SVSM_VTPM_MAX_BUFFER is IMHO defined in wrong patch 2/4.

I put it in patch 2 because IIUC it should be part of the SVSM
specification (the size, not the alignment).

>
>So this constant would be needed, it should be appeneded in this patch,
>not in 2/4 because it has direct effect on implementation of the driver.
>
>I'd personally support the idea of removing this constant altogether
>and use alloc_page() (i.e., same as you suggested).

Do you think it's necessary, even though alignment is not required?
(I'm still not clear if it's a requirement, see above)

>
>kmalloc() does do the "right thing here but it is still extra
>unnecessary layer of random stuff on top...

Yes, if it has to be aligned I completely agree. I would like to use
devm_ functions to keep the driver simple. Do you think
devm_get_free_pages() might be a good alternative to alloc_page()?

Thanks,
Stefano


