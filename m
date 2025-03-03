Return-Path: <linux-kernel+bounces-542652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D74B6A4CBFA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB16A1894B85
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAB822FDEA;
	Mon,  3 Mar 2025 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fXBDlPdh"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BF2226861
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741030176; cv=none; b=Ht8hfi8pmV4X9X0E1arzUZW0GU8W9gOBwc8X7hXlnK9JGMmzxT5ePJwbPymVmd8xniWE2sigHp72qzEDlbAAyOhpXysYN1QxfVfyfMLAHFLu0PyHLmpsMCKIDnNgy/rLZk0VofuxxLDbcq5nN31iLlI/EIn47KFK3cbnsadc0WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741030176; c=relaxed/simple;
	bh=cg5RFTUeHXvHldBYXq+EDsTRu38vvlrrKZ5Iv5575aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmHp73KrLp2ZwONEOvLoLOw4nhB4Z3lfLtx93GNB3kfbB0hnbAW7DBS8eKmOtynTYcznsTaXQVy+7UsUgZTMzev586j2kJE7eykcf9u+xUEpSCh+I0D9/O0mWeIpHqSURBTPNxPX+QD/KqLjS45euMV05+xGAntwRoK2xwtOLuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fXBDlPdh; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2b1f2b286f5so499415fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 11:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741030173; x=1741634973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wm1bw6PogSWQ/oeY0cZaU0D8DinTMlzqO3h/YyHdka4=;
        b=fXBDlPdhSfjM8CGY17i+INbHZ/re1yv7RpigtEwE2yv7Ok9phVI5JhplNDzqJtejWI
         gTxSmq1BmQqjFD78Z6gsZagraTiYWf9yJHnrtS7HNrHskm0cFgzV24pymPfCDmi5oJ7m
         tUtiU5iS81hPZwjP6vWtQXCTrgii3V9sKgmoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741030173; x=1741634973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wm1bw6PogSWQ/oeY0cZaU0D8DinTMlzqO3h/YyHdka4=;
        b=C/1fM9dlRyxMzAh0Vwwm17F+1OOtjYpuWo/IH7eKgKoBGT9lagKshyyVE8gd9oYcwG
         DSglw6kwohqN7/G9Jtb7twI+Zhk2x1+WvUDXUS7yBtq/Kzxzv+fvBDj9RPoWZUf8cz5z
         LMMpXFFlG5mj32WXusWMBwyH3c+QH/6wDiPh9ULGm9EWfroAca8cxp+cZy8Ir2Fg39a/
         lKFglHRF23iKtJWjtKgE1hNDlISFjzvmxyBvcg3Ty0imWiIm3eS4MkgvZwiFawqmlxax
         +GYABnz7gklQvNGmJyo4VHTpl+eCqiWPEEwvBAnEU/EVHQqW1JUTajJvpNFjf65lX/3j
         38Lg==
X-Forwarded-Encrypted: i=1; AJvYcCVsErdRNsZ19P6vn0XcYoPZzH9HzyXwybWNTdv8zfCPHT46vO8vcSjQQsvU5Mu/ssT5z57ujUIp5ABGbSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhBw5c8GogBdKGxUMz9Ilqk+ccMIT2SrexL0Eq2Nos4qO5B1S3
	btbWgXMHsgqXRbZ7zRWc3p5aH2OUQIVzUQSU7thMeUcsD6G9ZRhrJZBV7zAL6sQo9hoxS2hu/qp
	zXv1793V0T+4CMjj8tV3weRCoTszxcEQ/xrEs
X-Gm-Gg: ASbGncu/lJb6Mt9r2lTCs24gs8grpvT9Td2sI36BoR4vmPWBJnaCuADaNbV/tAkvSYu
	/2L7h80qcOXy/0aK6Tq7jY69bAF/nR5R+AQ5Rkwrv/RYTHB3VD3NAryewI69ncy8Kw/kOnyQuGh
	FwqLyzv67/gRlNux2/SUKXf4RVASibyx8WcLUE65lRX9pnbFiSlc/CZ4U=
X-Google-Smtp-Source: AGHT+IF6t86k4HXZQOpYrZhTArHYnjZ+cSsTfbGMol0i8lJDnf/V6fvf43xFaF25VFFNhp6135KGfflzyp8sId/j2Ao=
X-Received: by 2002:a05:6808:1a27:b0:3f4:756:52e6 with SMTP id
 5614622812f47-3f5584f51b0mr3566805b6e.1.1741030173329; Mon, 03 Mar 2025
 11:29:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303050921.3033083-1-jeffxu@google.com> <20250303050921.3033083-2-jeffxu@google.com>
 <202503030834.C4ED5911A@keescook>
In-Reply-To: <202503030834.C4ED5911A@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 3 Mar 2025 11:29:21 -0800
X-Gm-Features: AQ5f1JpNJhlC4d3_-OlZv4_ZKEKPcTm851BECZGkcYWdJqb17n518uve8jCwfqo
Message-ID: <CABi2SkUgmxLe6GOeRq1Lo7yz-FG0dfeAuxK4woz2JPVPH9c-Ow@mail.gmail.com>
Subject: Re: [PATCH v8 1/7] mseal sysmap: kernel config and header change
To: Kees Cook <kees@kernel.org>
Cc: akpm@linux-foundation.org, jannh@google.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, jorgelo@chromium.org, sroettger@google.com, 
	hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de, 
	adobriyan@gmail.com, johannes@sipsolutions.net, pedro.falcato@gmail.com, 
	hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 8:37=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Mar 03, 2025 at 05:09:15AM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Provide infrastructure to mseal system mappings. Establish
> > two kernel configs (CONFIG_MSEAL_SYSTEM_MAPPINGS,
> > ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS) and VM_SEALED_SYSMAP
> > macro for future patches.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  include/linux/mm.h | 10 ++++++++++
> >  init/Kconfig       | 22 ++++++++++++++++++++++
> >  security/Kconfig   | 21 +++++++++++++++++++++
> >  3 files changed, 53 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 7b1068ddcbb7..8b800941678d 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4155,4 +4155,14 @@ int arch_get_shadow_stack_status(struct task_str=
uct *t, unsigned long __user *st
> >  int arch_set_shadow_stack_status(struct task_struct *t, unsigned long =
status);
> >  int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long=
 status);
> >
> > +
> > +/*
> > + * mseal of userspace process's system mappings.
> > + */
> > +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > +#define VM_SEALED_SYSMAP     VM_SEALED
> > +#else
> > +#define VM_SEALED_SYSMAP     VM_NONE
> > +#endif
> > +
> >  #endif /* _LINUX_MM_H */
> > diff --git a/init/Kconfig b/init/Kconfig
> > index d0d021b3fa3b..c90dd8778993 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1882,6 +1882,28 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> >       bool
> >
> > +config ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> > +     bool
> > +     help
> > +       Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
> > +
> > +       A 64-bit kernel is required for the memory sealing feature.
> > +       No specific hardware features from the CPU are needed.
> > +
> > +       To enable this feature, the architecture needs to update their
> > +       special mappings calls to include the sealing flag and confirm
> > +       that it doesn't unmap/remap system mappings during the life
> > +       time of the process. The existence of this flag for an architec=
ture
> > +       implies that it does not require the remapping of thest system
>
> typo nit: "the" instead of "thest"
>
> > +       mappings during process lifetime, so sealing these mappings is =
safe
> > +       from a kernel perspective.
> > +
> > +       After the architecture enables this, a distribution can set
> > +       CONFIG_MSEAL_SYSTEM_MAPPING to manage access to the feature.
> > +
> > +       For complete descriptions of memory sealing, please see
> > +       Documentation/userspace-api/mseal.rst
> > +
> >  config HAVE_PERF_EVENTS
> >       bool
> >       help
> > diff --git a/security/Kconfig b/security/Kconfig
> > index f10dbf15c294..5311f4a6786c 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -51,6 +51,27 @@ config PROC_MEM_NO_FORCE
> >
> >  endchoice
> >
> > +config MSEAL_SYSTEM_MAPPINGS
> > +     bool "mseal system mappings"
> > +     depends on 64BIT
> > +     depends on ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> > +     depends on !CHECKPOINT_RESTORE
> > +     help
> > +       Apply mseal on system mappings.
> > +       The system mappings includes vdso, vvar, vvar_vclock,
> > +       vectors (arm compact-mode), sigpage (arm compact-mode), uprobes=
.
>
> typo nits: "compat" instead of "compact".
>
Got it, I will change everywhere for this (mseal.rst, coverletter)


> > +
> > +       A 64-bit kernel is required for the memory sealing feature.
> > +       No specific hardware features from the CPU are needed.
> > +
> > +       WARNING: This feature breaks programs which rely on relocating
> > +       or unmapping system mappings. Known broken software at the time
> > +       of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Theref=
ore
> > +       this config can't be enabled universally.
> > +
> > +       For complete descriptions of memory sealing, please see
> > +       Documentation/userspace-api/mseal.rst
> > +
> >  config SECURITY
> >       bool "Enable different security models"
> >       depends on SYSFS
> > --
> > 2.48.1.711.g2feabab25a-goog
> >
>
> Perhaps akpm can fix these up directly instead of a v9 spin?
>
V9 is relatively easy for me. I probably need a good version for
backporting to chromeOS/Android.

If all goes well, I'll follow up with a V10 based on Thomas
Wei=C3=9Fschuh's vdso refactor branch [1] [2].

[1] https://lore.kernel.org/all/CABi2SkXwaJ=3Ds3XqHKu1aFVfcacgxpQ5Ji1_BqaN+=
ch2i_RnA9Q@mail.gmail.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3Dti=
mers/vdso


> But otherwise, yes, reads well to me:
>
> Reviewed-by: Kees Cook <kees@kernel.org>
>
> --
> Kees Cook

