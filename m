Return-Path: <linux-kernel+bounces-543670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA27A4D863
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862F8172B95
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96181204699;
	Tue,  4 Mar 2025 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRUrUVcZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67DC20468A;
	Tue,  4 Mar 2025 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080369; cv=none; b=r63dHLqzSRtJA+GSZ9MTe6jqT4DLDcQnEUgcfL4J2KfFacY/tnPccW/yPdgQO2QeqG2vlk/5sMJowJuhSL5+eMM5LC+mHBAPTpAYFzT9vxZ+idw5m+gf0wmqMz74sr+U89ErLDvlZNf873KuuPIJLSNk/v6YG3ftBW222YP+TVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080369; c=relaxed/simple;
	bh=t6huNBUdOZacHdIaCFIq+flDCD6LJRCBE8a6PIsmI7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yw/QEbMl4ArZREFoZNpK8t15V2h9R+H/z32YcPnBqs+SRNUt3bK43996Ftx7zb35AP/l9KDVpWj4Ucz6CsssqE/QY9G4MKIK3GzKtj3ne53sawfX5c69sf2wbXSrebaD1NDhZN8J4qtDLx/1GAqUSpqv8FB50mEvOCSxt3Ipyrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRUrUVcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BB7C4CEEE;
	Tue,  4 Mar 2025 09:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741080368;
	bh=t6huNBUdOZacHdIaCFIq+flDCD6LJRCBE8a6PIsmI7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gRUrUVcZ6sNHDZqA1x65fJcd4NLyiyoWSJTt2DlsnIPZaWqLIigqj4Ltt06aOFDMD
	 Bzdx+8P3qGSc59RxFHLUJQ+J7enHiPLgOmERtg8PU2dnikZVmp9wW/eDSx7LbPkLpO
	 kTmPyEHmD438+FDPxtxoqcLn2Tb4c72DyhV9cY+jSn4eIL7qsFQ8zvuEPg1obAYR7R
	 8NW3f9HeHtEidLgMZX222vKUA1uZXo6Eiry/tOjZPcJ6WibeXdYvJt/aOjGqdhaSi9
	 FVQFxvOnzEsEGSDiEtTBU/fASWM0llgrG/VFBUSmButGNyHoeqR6TfjUZyh2RMSWBo
	 QmepfJMbuScRw==
Date: Tue, 4 Mar 2025 10:26:03 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 10/40] x86/cpu: Remove leaf 0x2 parsing loop and add
 helpers
Message-ID: <Z8bHK391zKE4gUEW@gmail.com>
References: <20250304085152.51092-1-darwi@linutronix.de>
 <20250304085152.51092-11-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304085152.51092-11-darwi@linutronix.de>


* Ahmed S. Darwish <darwi@linutronix.de> wrote:

> Leaf 0x2 output includes a "query count" byte where it was supposed to
> specify the number of repeated cpuid leaf 0x2 subleaf 0 queries needed
> to extract all of the hardware's cache and TLB descriptors.

s/cpuid
 /CPUID

Please do this in the rest of the series too. (I did it for the first 9 
patches.)

> +++ b/arch/x86/include/asm/cpuid/types.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_CPUID_TYPES_H
> +#define _ASM_X86_CPUID_TYPES_H
> +
> +#include <linux/types.h>
> +
> +#include <asm/cpuid.h>

So that header organization is a bit messy: if <asm/cpuid.h> is 
supposed to be the main header, why is there a <asm/cpuid/types.h>?

I'd suggest we follow the FPU header structure:

  starship:~/tip/arch/x86/include/asm/fpu> ls -l
  total 48
  -rw-rw-r-- 1 mingo mingo  5732 Feb 27 19:24 api.h
  -rw-rw-r-- 1 mingo mingo   671 Feb 26 16:13 regset.h
  -rw-rw-r-- 1 mingo mingo  2203 Feb 27 13:52 sched.h
  -rw-rw-r-- 1 mingo mingo  1110 Feb 27 19:24 signal.h
  -rw-rw-r-- 1 mingo mingo 14741 Feb 27 19:24 types.h
  -rw-rw-r-- 1 mingo mingo   811 Feb 26 16:13 xcr.h
  -rw-rw-r-- 1 mingo mingo  4401 Feb 27 23:01 xstate.h

With <asm/cpuid/api.h> being the main header - established via a 
separate preparatory patch.

This followup patch can then add <asm/cpuid/types.h> which will also be 
included in <asm/cpuid/api.h>.


> +/*
> + * CPUID(0x2) parsing helpers
> + * Check for_each_leaf_0x2_desc() documentation.
> + */
> +
> +struct leaf_0x2_reg {
> +		u32		: 31,
> +			invalid	: 1;
> +};
> +
> +union leaf_0x2_regs {
> +	struct leaf_0x2_reg	reg[4];
> +	u32			regv[4];
> +	u8			desc[16];
> +};
> +
> +/**
> + * get_leaf_0x2_regs() - Return sanitized leaf 0x2 register output
> + * @regs:	Output parameter
> + *
> + * Get leaf 0x2 register output and store it in @regs.  Invalid byte
> + * descriptors returned by the hardware will be force set to zero (the
> + * NULL cache/TLB descriptor) before returning them to the caller.
> + */
> +static inline void get_leaf_0x2_regs(union leaf_0x2_regs *regs)


Please prefix all new cpuid API functions and types with cpuid_.

> +#define for_each_leaf_0x2_desc(regs, desc)				\
> +	/* Skip the first byte as it is not a descriptor */		\
> +	for (desc = &(regs).desc[1]; desc < &(regs).desc[16]; desc++)

The comment line can come before the macro.

> +	get_leaf_0x2_regs(&regs);
> +	for_each_leaf_0x2_desc(regs, desc)
> +		intel_tlb_lookup(*desc);

Nice interface otherwise.

Thanks,

	Ingo

