Return-Path: <linux-kernel+bounces-513554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5ADA34B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0D4816BAD3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAF82045BD;
	Thu, 13 Feb 2025 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SjK9gTRg"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5695F201259
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 17:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467016; cv=none; b=rCPtWOgZJnKTKx0FNOKRbc+yub12T50vbUcqpLsbC4UVYUkkkZ6Z2hJ2CC/b5WlKcD2GBWNqUt53nguQE6V1cBngq2TSymw2pt2f8RhonrbtXxLS5ZNDu98788U5VWDr8OdLKortTIm9yEuNk/YFbZOTgHuTspQBvpUiB79b3t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467016; c=relaxed/simple;
	bh=GnnlHo3AN2X6voTtxaBU3/Xd7w16hkql2u/UErCIXZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hwgrvi+HkOqrEw7+LnrUWa0j3oP2cJvhRS0LGklDkF9XV6U5Br3EOYl6w19poy/djltl8TyiVfX5ny0oX07gfIprUkW0z0T+2r1V0tZsta4LLRBd5X7w6dJwCt00YCBmq8IIhSUrlAb3G+O+x7dYWFuKFMckoYgy7FDKba3abmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SjK9gTRg; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2b8a8c8cf8dso24854fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739467013; x=1740071813; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBy9giu2XuH33LZCPuALTlrK7I4fNXTlE0NtPV35u4I=;
        b=SjK9gTRg/q6brHd1qyx/ShNJhosbomtMC4+LFoZM/JeDtEfp184HCA1qnnKq0JEAjj
         hDeotNdBcFLwYKx4bCrH+734R6NtcmmauojIPf08X5AX0xrbv9BFCulUVPgP5upWsGL8
         c+0Umv7erJ8e1BKu01c6Q32XC9kGJlEu9GkK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739467013; x=1740071813;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBy9giu2XuH33LZCPuALTlrK7I4fNXTlE0NtPV35u4I=;
        b=sVZ6XRLtpjh74hvESOk3Ffcqoy8k4bLl8qz3tPKIkr/FuqL39PhNqE8Als1Nd4MUvr
         wwtbVTSGgZLyrbm4+s7U7r9S8Vk/YNvyxNWD9Ds+VfyGtv9v+eTdGIfjRNzCRNzAij5t
         5niWItyYqGok8HEKGyjoEJ0P37yUw63XB77krLkwCZ4oAx8qsStusx/hRQ7c/aguAxiM
         9i+utsQbQRM8pywh79wkp8XBMSReyKspZH8AcNUWAPU1sZAacUkCVmzb5edIEUljndO1
         bY252xfkZbIa3/I1yfYKnq6lLDUPzedxBA78CchvtuiKBc1pvekCSBBRkv+K2mQ/TxEc
         4MmA==
X-Forwarded-Encrypted: i=1; AJvYcCVaktNY4anRFtEu5XaJNm7hfR5GNwAkb8OXSmdXsdkaoF1X6EVIEKaORiLHK71X70RLtim9wTwBeFRZWU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWPfhVsjFDUUoaqx22QJ2pSkOTMpqeC9iLIQH376YVNlgC9tZP
	lxp2pPsBwPxUMbvN+nlfJuUS3oWVgC8quR92QTGjjQauIUMHdRe8pyBtLU+e0LEk6Ky5XMp6fc+
	J2lDEqI6nQc5FDXwlCIaOY0GVLk30ZOdElKSg
X-Gm-Gg: ASbGncubC3hSHi3DS7UqeCJ+kHv8z7jHbo9HS4l6d8eEXkyIpLJ4+PEY8jw1NhbdkpT
	qDqxQBB18sHGCxMxuC/57c0t7mxSNTtPGqo2FAwhK4uJT76A2J+/XroUDUaGq78m62yuC4vkAOd
	yvixDZepL+pj1DDnodrgwdTTTuyXOBbw==
X-Google-Smtp-Source: AGHT+IFgl+AN2r8X6K1wzkDWdEWSCbY3TrGWVYP851EsxR7f08xemuxZwcDGWA0t2Tv/VeZB1tHKMo1KROF0nlz+v0E=
X-Received: by 2002:a05:6870:648b:b0:2b7:f564:a35b with SMTP id
 586e51a60fabf-2b8d67f0b49mr1726124fac.8.1739467013249; Thu, 13 Feb 2025
 09:16:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-1-jeffxu@google.com> <20250212032155.1276806-2-jeffxu@google.com>
 <qrxmfa6jvaojedmo6fle2e6vd5k4hzihcuxdc6zk43dclf6nsd@dvuzolusdtz4>
In-Reply-To: <qrxmfa6jvaojedmo6fle2e6vd5k4hzihcuxdc6zk43dclf6nsd@dvuzolusdtz4>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 13 Feb 2025 09:15:00 -0800
X-Gm-Features: AWEUYZk-H7IZgTRLevdACXtvIkKevRsUdXrms45ENhCkHRV0gRY9quOaw4ihuIE
Message-ID: <CABi2SkUWGXtWAir5j1TO1c7FwOhbNmSwEzwTrxRgzfBydus=2A@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/7] mseal, system mappings: kernel config and
 header change
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, 
	oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 7:05=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
...
> >
> > In this version, we've improved the handling of system mapping sealing =
from
> > previous versions, instead of modifying the _install_special_mapping
> > function itself, which would affect all architectures, we now call
> > _install_special_mapping with a sealing flag only within the specific
> > architecture that requires it. This targeted approach offers two key
> > advantages: 1) It limits the code change's impact to the necessary
> > architectures, and 2) It aligns with the software architecture by keepi=
ng
> > the core memory management within the mm layer, while delegating the
> > decision of sealing system mappings to the individual architecture, whi=
ch
> > is particularly relevant since 32-bit architectures never require seali=
ng.
> >
> > Additionally, this patch introduces a new header,
> > include/linux/usrprocess.h, which contains the mseal_system_mappings()
> > function. This function helps the architecture determine if system
> > mapping is enabled within the current kernel configuration. It can be
> > extended in the future to handle opt-in/out prctl for enabling system
> > mapping sealing at the process level or a kernel cmdline feature.
> >
> > A new header file was introduced because it was difficult to find the
> > best location for this function. Although include/linux/mm.h was
> > considered, this feature is more closely related to user processes
> > than core memory management. Additionally, future prctl or kernel
> > cmd-line implementations for this feature would not fit within the
> > scope of core memory management or mseal.c. This is relevant because
> > if we add unit-tests for mseal.c in the future, we would want to limit
> > mseal.c's dependencies to core memory management.
> >
...
> >
> > diff --git a/include/linux/userprocess.h b/include/linux/userprocess.h
> > new file mode 100644
> > index 000000000000..bd11e2e972c5
> > --- /dev/null
> > +++ b/include/linux/userprocess.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_USER_PROCESS_H
> > +#define _LINUX_USER_PROCESS_H
> > +#include <linux/mm.h>
>
> Why is this in a new file and not mm.h directly?  Anyone who needs to
> use this will pull in mm.h anyways, and probably already has mm.h
> included.
>
The commit message includes the reason. I've snipped and left the
relevant portion for easy reference, please see the beginning of this
email.

> > +
> > +/*
> > + * mseal of userspace process's system mappings.
> > + */
> > +static inline unsigned long mseal_system_mappings(void)
> > +{
> > +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > +     return VM_SEALED;
> > +#else
> > +     return 0;
> > +#endif
> > +}
> > +
> > +#endif
>
> Looking in mm.h, there are examples of config checks which either set
> the bit or set it to 0.  This means you wouldn't need the function at
> all and the precompiler would do all the work (although with a static
> inline, I'm not sure it would make a big difference in instructions).
>
> For instance, you could do:
> #ifdef CONFIG_64BIT
> /* VM is sealed, in vm_flags */
> #define VM_SEALED       _BITUL(63)
>
> #ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> #define VM_SYSTEM_SEAL          VM_SEALED
> else
> #define VM_SYSTEM_SEAL          VM_NONE
> #endif
>
> #else /* CONFIG_64BIT */
> #define VM_SYSTEM_SEAL          VM_NONE
> #endif
>
> Then you can use VM_SYSTEM_SEAL in the system mappings function in the
> list of flags instead of having a variable + calling the static
> function.
>
> I didn't look close enough to see if the 32bit version is necessary.
>
I'm aware of the other pattern.

VM_SEALED isn't defined in 32-bit systems, and mseal.c isn't part of
the build. This is intentional. Any 32-bit code trying to use the
sealing function or the VM_SEALED flag will immediately fail
compilation. This makes it easier to identify incorrect usage.

> > diff --git a/init/Kconfig b/init/Kconfig
> > index d0d021b3fa3b..892d2bcdf397 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1882,6 +1882,24 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> >       bool
> >
> > +config ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
>
> ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS is more clear.  HAS may mean it's
> supported or it could mean it's enabled. SUPPORTS is more clear that
> this is set if an arch supports the feature.  After all, I think HAS
> here means it "has support for" mseal system mappings.
>
> I see that both are used (HAS and SUPPORTS), but I'm still not sure what
> HAS means in other contexts without digging.
>
The existing pattern is to indicate arch support with
CONFIG_ARCH_HAS_N and   security/KConfig to have CONFIG_N as the main
switch. For example, CONFIG_ARCH_HAS_FORTIFY_SOURCE and
CONFIG_FORTIFY_SOURCE. Since the MSEAL_SYSTEM_MAPPINGS is placed in
security/Kconfig, hence I'm following the existing pattern in
security/Kconfig.

> > diff --git a/security/Kconfig b/security/Kconfig
> > index f10dbf15c294..bfb35fc7a3c6 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -51,6 +51,24 @@ config PROC_MEM_NO_FORCE
> >
> >  endchoice
> >
> > +config MSEAL_SYSTEM_MAPPINGS
> > +     bool "mseal system mappings"
> > +     depends on 64BIT
> > +     depends on ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
> > +     depends on !CHECKPOINT_RESTORE
> > +     help
> > +       Seal system mappings such as vdso, vvar, sigpage, uprobes, etc.
> > +
> > +       A 64-bit kernel is required for the memory sealing feature.
> > +       No specific hardware features from the CPU are needed.
> > +
> > +       Note: CHECKPOINT_RESTORE, UML, gVisor are known to relocate or
> > +       unmap system mapping, therefore this config can't be enabled
> > +       universally.
>
> I guess add rr to the list, since that's also reported to have issues as
> well.
>
sure.

Thanks for reviewing.

-Jeff

