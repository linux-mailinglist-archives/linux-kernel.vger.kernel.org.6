Return-Path: <linux-kernel+bounces-270444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76711943FE3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D04E28171A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ECB14884C;
	Thu,  1 Aug 2024 01:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FBTzSFF0"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E91487F1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 01:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722474662; cv=none; b=isLx0pSBh7H5hga17vhNmcMCuMLurGBHxf0y0hS2mkYppJ2lsbyPuCzd0eXpasGNufXzmATOFOeP/b62M4F5mqVP8pXJ6u5ItQ/FzPDy86PbU3kcYlvUTTKqT1HYMGM+aNoGyge7WVp4Zrll/Ts3TPGnye3TOZlFw/wCK5vk7Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722474662; c=relaxed/simple;
	bh=fc64aCYPvOPkEubCL6KFMQiiAcozTTtk7yJQcD31XdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mfu3zK/PFHCKqrMYuntWzdI1tXn2dxj5O4UyAFuvNGtob1A3bJHbRuE3ltl09l/B2MnBIkSubktDzCtu5Id6/sx4KILQu7MDKmqlLzI4KjSP/Pcu/8zajiRAhlrDUTYqE/hT3IGO8S8f/IWdI0R+RGQc7zQm97U/e6dHhVFNFlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FBTzSFF0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70d2d7e692eso5264235b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 18:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722474659; x=1723079459; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SF8gnKEAE9EljJtXDymf4/VYu2nTWcOfe4LLsbP9AN0=;
        b=FBTzSFF0lt3EQe3OyxxCWBCp7Ni9qglFY/xZ8VZeha4IIF1Io7H4aQr+VY+h6nSDaj
         4UvL3z1Fm4MzRSqNQKZ3o3IrRXNS6ZcWULvbkvrOvNjEqAvoGz29sY1nKYwJomqldAx3
         iP8ZRD1/XqlAz8/GHwf3IYTbvYy0e8Xs8YKUf9eFra7FHzxOkuHIa/DGo61u5SNL2jpt
         mCpL+pCk5u4FJO+tKsfOFOCDILwTa7EW1Zz06qt866KS3v/kCnJGTbDPp610SbXcdFdW
         57N0l95s+KmW/ceRd44itzZoP2lGN88b1j1bNeRspDQNAuIcVf0iHwOb+mY1eBoi8seB
         HR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722474659; x=1723079459;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SF8gnKEAE9EljJtXDymf4/VYu2nTWcOfe4LLsbP9AN0=;
        b=imCY6YCGSL2A2QNp8ZGr9XoYRwHZSfdm7UdswG4Z6Ahwt9XVRUmWBOqyXgEu8R3uRg
         LA1wO4meFcldt5ubhkG9ns++eDlCCc5Efvk07prsxLY8X4BOhRyS7J37F9qKLWrPN4ih
         BoRpcbECwGTjZ7HUahbqCIX2v9t9zz6N6nayU/DKT1xC8jUX13Lc58FhYFmgOhTi1Las
         OiUBNu1Kmpj0/vRE2JgEX9SiD8uLTa9UIScAOtFy9e2S+lkFwZ+HwLBMbCSXnNsKMHmY
         IIk3bB31Gqo9alyNw5GaU3rr/AKkDnAbkAalYjBRj5ygL5syqskhLG/Yko4UI8peEjq9
         7ITA==
X-Forwarded-Encrypted: i=1; AJvYcCVpGXRR3f1zkaNUlnzySSQ4pTMNC60/LHoTmrJCxDuF/nOC9CgLwdjd9PPhK1N0gjn0IuB7z3rINo+3AjVXdMkDUwtXj5ux1A3GsAq/
X-Gm-Message-State: AOJu0Yzo+ERTLu2nbW4o0MuhCo4dG2ZbnfR61tiE+cv9hidd0t9z5PQe
	L3eRoa5WK7BGJZaISfNBmJzXAYXIbR7GijwmAA5rgLTNTSbzzVeRmy0HSDemxhU=
X-Google-Smtp-Source: AGHT+IE+vBz7tRhC45aToQfMe1oJ8ucMo/aEKZneCwxPpUJhH86CJPQIsx+yfuNixrLgHrwhOoplIA==
X-Received: by 2002:a05:6a00:acd:b0:70e:98e3:1aef with SMTP id d2e1a72fcca58-7105d7e6eb5mr1179532b3a.29.1722474658867;
        Wed, 31 Jul 2024 18:10:58 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8a3aa8sm10522229b3a.210.2024.07.31.18.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 18:10:58 -0700 (PDT)
Date: Wed, 31 Jul 2024 18:10:55 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <parri.andrea@gmail.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] tools: Add riscv barrier implementation
Message-ID: <Zqrgn04zEmEpv5+m@ghost>
References: <20240729-optimize_ring_buffer_read_riscv-v1-0-6bbc0f2434ee@rivosinc.com>
 <20240729-optimize_ring_buffer_read_riscv-v1-1-6bbc0f2434ee@rivosinc.com>
 <28d780da-4f43-4db5-8e1b-c66bb9973cd1@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <28d780da-4f43-4db5-8e1b-c66bb9973cd1@rivosinc.com>

On Tue, Jul 30, 2024 at 10:59:52AM +0200, Clément Léger wrote:
> 
> 
> On 29/07/2024 22:50, Charlie Jenkins wrote:
> > Many of the other architectures use their custom barrier implmentations.
> 
> Hi Charlie,
> 
> Typo: implmentations -> implementations

Thank you! I will fix that.

- Charlie

> 
> > Use the barrier code from the kernel sources to optimize barriers in
> > tools.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  tools/arch/riscv/include/asm/barrier.h | 39 ++++++++++++++++++++++++++++++++++
> >  tools/arch/riscv/include/asm/fence.h   | 13 ++++++++++++
> >  tools/include/asm/barrier.h            |  2 ++
> >  3 files changed, 54 insertions(+)
> > 
> > diff --git a/tools/arch/riscv/include/asm/barrier.h b/tools/arch/riscv/include/asm/barrier.h
> > new file mode 100644
> > index 000000000000..6997f197086d
> > --- /dev/null
> > +++ b/tools/arch/riscv/include/asm/barrier.h
> > @@ -0,0 +1,39 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copied from the kernel sources to tools/arch/riscv:
> > + *
> > + * Copyright (C) 2012 ARM Ltd.
> > + * Copyright (C) 2013 Regents of the University of California
> > + * Copyright (C) 2017 SiFive
> > + */
> > +
> > +#ifndef _TOOLS_LINUX_ASM_RISCV_BARRIER_H
> > +#define _TOOLS_LINUX_ASM_RISCV_BARRIER_H
> > +
> > +#include <asm/fence.h>
> > +#include <linux/compiler.h>
> > +
> > +/* These barriers need to enforce ordering on both devices and memory. */
> > +#define mb()		RISCV_FENCE(iorw, iorw)
> > +#define rmb()		RISCV_FENCE(ir, ir)
> > +#define wmb()		RISCV_FENCE(ow, ow)
> > +
> > +/* These barriers do not need to enforce ordering on devices, just memory. */
> > +#define smp_mb()	RISCV_FENCE(rw, rw)
> > +#define smp_rmb()	RISCV_FENCE(r, r)
> > +#define smp_wmb()	RISCV_FENCE(w, w)
> > +
> > +#define smp_store_release(p, v)						\
> > +do {									\
> > +	RISCV_FENCE(rw, w);						\
> > +	WRITE_ONCE(*p, v);						\
> > +} while (0)
> > +
> > +#define smp_load_acquire(p)						\
> > +({									\
> > +	typeof(*p) ___p1 = READ_ONCE(*p);				\
> > +	RISCV_FENCE(r, rw);						\
> > +	___p1;								\
> > +})
> > +
> > +#endif /* _TOOLS_LINUX_ASM_RISCV_BARRIER_H */
> > diff --git a/tools/arch/riscv/include/asm/fence.h b/tools/arch/riscv/include/asm/fence.h
> > new file mode 100644
> > index 000000000000..37860e86771d
> > --- /dev/null
> > +++ b/tools/arch/riscv/include/asm/fence.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copied from the kernel sources to tools/arch/riscv:
> > + */
> > +
> > +#ifndef _ASM_RISCV_FENCE_H
> > +#define _ASM_RISCV_FENCE_H
> > +
> > +#define RISCV_FENCE_ASM(p, s)		"\tfence " #p "," #s "\n"
> > +#define RISCV_FENCE(p, s) \
> > +	({ __asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"); })
> > +
> > +#endif	/* _ASM_RISCV_FENCE_H */
> > diff --git a/tools/include/asm/barrier.h b/tools/include/asm/barrier.h
> > index 8d378c57cb01..0c21678ac5e6 100644
> > --- a/tools/include/asm/barrier.h
> > +++ b/tools/include/asm/barrier.h
> > @@ -8,6 +8,8 @@
> >  #include "../../arch/arm64/include/asm/barrier.h"
> >  #elif defined(__powerpc__)
> >  #include "../../arch/powerpc/include/asm/barrier.h"
> > +#elif defined(__riscv)
> > +#include "../../arch/riscv/include/asm/barrier.h"
> >  #elif defined(__s390__)
> >  #include "../../arch/s390/include/asm/barrier.h"
> >  #elif defined(__sh__)
> > 
> 
> Can not really tell for that part except it seems ok to me as well.
> Andrea might be a better candidate to add its Rb.
> 
> Thanks,
> 
> Clément

