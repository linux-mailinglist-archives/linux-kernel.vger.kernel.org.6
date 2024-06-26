Return-Path: <linux-kernel+bounces-231031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF96491856B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3477B2D270
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F65B1891D0;
	Wed, 26 Jun 2024 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="fhcYN2cz"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4B61891BD
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414195; cv=none; b=BzrOgSMfBif0hPQoYCEjh7/o7uEruohiR3UWUYlPrW9+e9efME+M3pv/z7y9oy8wEo8oSW1jbCnhBnbXbkzSSB+wAmSXxIMfHvMZaHN5SHyIPrh/DN8rX3crTMuuKI6A6Is2rdQ+UQnJwUAq1+HDQegn5v3pSRNuj372Ro5XCJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414195; c=relaxed/simple;
	bh=GhPVGfxAv/MVfTYohQLlR0xHEcpxhbznngSfdbE8RRQ=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=an77WFZb67fxM6mthj/DFd9sIEcNukCcEgrPrbQf0HqJoBHHZ2wnTp8nQpf4jELBzDaJfUVov8OAzGGCEpxeIbZs1dwttqzXHWaxfXgfDi1r0rrLi6hbD17XF73T9fMCgn6t/zf3gL3vcxMfJHxAwssqE10ioogPOYFh7FLwLik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=fhcYN2cz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f480624d0fso54294935ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1719414189; x=1720018989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nX5BuLom8gcdUTb6Qlfv9xIgyMY+J4LR2YpbCcxHoRY=;
        b=fhcYN2czg5g1rOnyoHzsnOLeNUO4NPBrBEoVX527Ou1KJdx4Jc1PRSjnGdYOFf8w80
         cRucfW4VCsYOVJ6mX556WFgoveO9CKYBaqiHYdbl0zKkTVPu21vdNJgOEgC48PBMYmqJ
         g89gIIsFKuM9SCtMew+JLhXmY4i/z3Gu/EOn8uAuzKyJe3geGVvJhPfa8EOdIi0ESexd
         tN/b545gE7kV5JhLWjFXJXO5ym2h1RB3vUuF+hbmq3keQ4iGRPLj4xvMP/hkT57aCR3y
         KIaKr4avbXRDoxlu7qWc+Zz8lXEfZBaCPcRwKu7oWqhHzkUBKqx6wKy2MTEgO93Tuzy+
         BrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719414189; x=1720018989;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nX5BuLom8gcdUTb6Qlfv9xIgyMY+J4LR2YpbCcxHoRY=;
        b=f324Ij3UKUxUStAHP49GD0Z30KUN++7TvSCCkIWeStwoWu6ejT3Z7RgcMsVQsUTaQt
         pewojzOrXxUvTWqgKWcO4KhyqRbWyTiQFYJu170SRY8OExaOG7SxrqoAtpS3utbherAW
         15UbjWJ+uwIu/D0uo/nrp4uoxvbrVxQDBymrTkBSpHQmrsfNCFcqkLoe/qc+23eiLGlM
         TDfA7WR9kh4LQEXBUyPN+K83+4Hv6xCzGV0likmZ6Kh4MC6SInNMmRVGnz8dWWpyOhI7
         4+aT4Nb77dcB3WOrJUeSm5wrkVtac/tTbdJJYqay3IpQ0/qVebK26bSOfSUcMOkX7uj6
         rA3g==
X-Forwarded-Encrypted: i=1; AJvYcCWjzt+ngu5mHGjFdZSkdfy7ZpgcXtr/HXyIxmrN79QxE6G3JUsg5zMjjm8O73hwpxsesqqWf1tRrwREDIKYbH6yWkAagupS8+P6KLov
X-Gm-Message-State: AOJu0YxJAAVyoBzab4+dFbZCpP4vlKThuL3zAML67FodmPpZIY/Hgm2b
	6nYzOlk2K/CQIf5tjVHI24A3If5tVml+PEr1x9+adtWuUfp26lrllOtUE03MkjQ=
X-Google-Smtp-Source: AGHT+IHj5kQUVnnlLQBZ4PjflSS1nFMEsisTzs7U5PNdPk5S86sOVMgB1vzs6n/LhHNSIfIE6CcQ6Q==
X-Received: by 2002:a17:902:e542:b0:1f9:edf6:d7a5 with SMTP id d9443c01a7336-1fa23f227c0mr125868805ad.1.1719414188845;
        Wed, 26 Jun 2024 08:03:08 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbc2a7fsm99730155ad.283.2024.06.26.08.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 08:03:08 -0700 (PDT)
Date: Wed, 26 Jun 2024 08:03:08 -0700 (PDT)
X-Google-Original-Date: Wed, 26 Jun 2024 08:03:05 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: dmi: Add SMBIOS/DMI support
In-Reply-To: <CAJve8onakqwyXNcwtNOLTGah+=pbWzdNBwM64U0htyDJyY3nwQ@mail.gmail.com>
CC: Atish Patra <atishp@rivosinc.com>, haibo1.xu@intel.com,
  linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org,
  aou@eecs.berkeley.edu, Paul Walmsley <paul.walmsley@sifive.com>, Ard Biesheuvel <ardb@kernel.org>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: xiaobo55x@gmail.com
Message-ID: <mhng-dc33bf67-dbfe-4eb5-b5f6-6c83770dcc3c@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Sun, 26 May 2024 02:17:40 PDT (-0700), xiaobo55x@gmail.com wrote:
> kindly ping!
>
> Any more comments on this patch?

Sorry I dropped the ball on this one, it's queued up for staging and 
should show up on for-next assuming it passes the tests.

>
> Thanks,
> Haibo
>
> On Mon, Apr 29, 2024 at 10:22 PM Haibo Xu <xiaobo55x@gmail.com> wrote:
>>
>> Hi @Palmer,
>>
>> Could you please let me know whether this patch was OK for the next RISC-V PULL?
>>
>> Thanks,
>> Haibo
>>
>> On Wed, Mar 20, 2024 at 3:46 AM Atish Patra <atishp@rivosinc.com> wrote:
>> >
>> > On 3/17/24 19:09, Haibo Xu wrote:
>> > > Enable the dmi driver for riscv which would allow access the
>> > > SMBIOS info through some userspace file(/sys/firmware/dmi/*).
>> > >
>> > > The change was based on that of arm64 and has been verified
>> > > by dmidecode tool.
>> > >
>> > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
>> > > ---
>> > > Changes since v1
>> > >    - Change to use memremap/memunmap for dmi_(early)_remap/unmap
>> > >      definition(suggested by Ard)
>> > >    - Minor clean up for comments (Ard)
>> > > ---
>> > >   arch/riscv/Kconfig                   | 11 +++++++++++
>> > >   arch/riscv/include/asm/dmi.h         | 24 ++++++++++++++++++++++++
>> > >   drivers/firmware/efi/riscv-runtime.c | 13 +++++++++++++
>> > >   3 files changed, 48 insertions(+)
>> > >   create mode 100644 arch/riscv/include/asm/dmi.h
>> > >
>> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > > index 8ebafe337eac..3639151cb4ef 100644
>> > > --- a/arch/riscv/Kconfig
>> > > +++ b/arch/riscv/Kconfig
>> > > @@ -952,6 +952,17 @@ config EFI
>> > >         allow the kernel to be booted as an EFI application. This
>> > >         is only useful on systems that have UEFI firmware.
>> > >
>> > > +config DMI
>> > > +     bool "Enable support for SMBIOS (DMI) tables"
>> > > +     depends on EFI
>> > > +     default y
>> > > +     help
>> > > +       This enables SMBIOS/DMI feature for systems.
>> > > +
>> > > +       This option is only useful on systems that have UEFI firmware.
>> > > +       However, even with this option, the resultant kernel should
>> > > +       continue to boot on existing non-UEFI platforms.
>> > > +
>> > >   config CC_HAVE_STACKPROTECTOR_TLS
>> > >       def_bool $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=tp -mstack-protector-guard-offset=0)
>> > >
>> > > diff --git a/arch/riscv/include/asm/dmi.h b/arch/riscv/include/asm/dmi.h
>> > > new file mode 100644
>> > > index 000000000000..ca7cce557ef7
>> > > --- /dev/null
>> > > +++ b/arch/riscv/include/asm/dmi.h
>> > > @@ -0,0 +1,24 @@
>> > > +/* SPDX-License-Identifier: GPL-2.0 */
>> > > +/*
>> > > + * Copyright (C) 2024 Intel Corporation
>> > > + *
>> > > + * based on arch/arm64/include/asm/dmi.h
>> > > + *
>> > > + * This file is subject to the terms and conditions of the GNU General Public
>> > > + * License.  See the file "COPYING" in the main directory of this archive
>> > > + * for more details.
>> > > + */
>> > > +
>> > > +#ifndef __ASM_DMI_H
>> > > +#define __ASM_DMI_H
>> > > +
>> > > +#include <linux/io.h>
>> > > +#include <linux/slab.h>
>> > > +
>> > > +#define dmi_early_remap(x, l)                memremap(x, l, MEMREMAP_WB)
>> > > +#define dmi_early_unmap(x, l)                memunmap(x)
>> > > +#define dmi_remap(x, l)                      memremap(x, l, MEMREMAP_WB)
>> > > +#define dmi_unmap(x)                 memunmap(x)
>> > > +#define dmi_alloc(l)                 kzalloc(l, GFP_KERNEL)
>> > > +
>> > > +#endif
>> > > diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/efi/riscv-runtime.c
>> > > index 09525fb5c240..c3bfb9e77e02 100644
>> > > --- a/drivers/firmware/efi/riscv-runtime.c
>> > > +++ b/drivers/firmware/efi/riscv-runtime.c
>> > > @@ -152,3 +152,16 @@ void arch_efi_call_virt_teardown(void)
>> > >   {
>> > >       efi_virtmap_unload();
>> > >   }
>> > > +
>> > > +static int __init riscv_dmi_init(void)
>> > > +{
>> > > +     /*
>> > > +      * On riscv, DMI depends on UEFI, and dmi_setup() needs to
>> > > +      * be called early because dmi_id_init(), which is an arch_initcall
>> > > +      * itself, depends on dmi_scan_machine() having been called already.
>> > > +      */
>> > > +     dmi_setup();
>> > > +
>> > > +     return 0;
>> > > +}
>> > > +core_initcall(riscv_dmi_init);
>> >
>> > Reviewed-by: Atish Patra <atishp@rivosinc.com>

