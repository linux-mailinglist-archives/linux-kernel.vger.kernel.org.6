Return-Path: <linux-kernel+bounces-198152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D138D7421
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7521F2168E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 07:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3011C6BD;
	Sun,  2 Jun 2024 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OZc6I9qs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="joR/8rMo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872D519A
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717313541; cv=none; b=kZlOw55UJrg/NPtO0mov4le0SNi/GGEiDh6wQEQ/gPlB3dzAxAUwPYIGOzYRFuzcCIdydNl+tpAiodeUwKUw5ke5fr3Gr4SCbPhWLN5tRJoXSQdYLDYbqTaop69GzTvwZdo2rfRccbBWllVpEpEtVdiBZrcs+ydodQTUdE1O128=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717313541; c=relaxed/simple;
	bh=sqdBlSVKcse7rRSf3r40Go/w+iJ9VJ4VK9R+9tRQmhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyBANYIpmamGFtL5PsguyjGsaI4PM31cE46XXgQAxdQTWAYZSPDlpT7THKysFrguCfs5LbIWZv1IOMTjzam8xE0FgZhWx05DogxUIdlAD0FRXKbD8A+gd9ES3WEbz2BVbCNNuO0Woz02FoZSESxh0KGAKevXKFVnVRjEkvKbZW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OZc6I9qs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=joR/8rMo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 2 Jun 2024 09:32:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717313537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/MaeXkfU5+d9iME/l5SX4YTaljCevq2NVRlbP81IKuU=;
	b=OZc6I9qsg1cGXYuLdROyGA49u1EnXdtNWafGGioa6SDOp12ApWkTyVUDBep4y1wzszdaG7
	sGalfIeBgA/EAHqPc+sXNbxNJm035sVKzr/NkfLIWLiuNzEQdHf7knJTk11VlmJjtQXizg
	hBabohPZdGdwrxFlUVrXN3e+nKYFapWwnyKb9otg9W51jsee9/jTBAEOJaCy7Ag8BCWVsx
	uyV9FPYbGCclvHvGqAFAWdlrgpXq5DlbWFVj9BbNgn6Z5eUxivgsHFr41yso0KmRPjixln
	7dmGF8yAcuHi1N39J9ZQQ+Zf/9LPnBkRWuZjLPZNXUNI8K6LrXQPpfrm0msXUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717313537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/MaeXkfU5+d9iME/l5SX4YTaljCevq2NVRlbP81IKuU=;
	b=joR/8rMo8+qdZcxRgUK4sNXpNs4h81q5qpBECmx26RwTojRNGMqDkD69QD86U8H5vV3SoQ
	g4LoyxDl42IAaNDA==
From: Nam Cao <namcao@linutronix.de>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 7/7] riscv: remove limit on the size of read-only section
 for XIP kernel
Message-ID: <20240602073210.w0CKrGlj@linutronix.de>
References: <cover.1715286093.git.namcao@linutronix.de>
 <9eea4b61f7b6300def3b6582d8e465ef4207501e.1715286093.git.namcao@linutronix.de>
 <2e092f39-0716-4b73-9268-da9211a4b600@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e092f39-0716-4b73-9268-da9211a4b600@ghiti.fr>

On Mon, May 27, 2024 at 02:58:14PM +0200, Alexandre Ghiti wrote:
> > diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vmlinux-xip.lds.S
> > index 8c3daa1b0531..01f73f2ffecc 100644
> > --- a/arch/riscv/kernel/vmlinux-xip.lds.S
> > +++ b/arch/riscv/kernel/vmlinux-xip.lds.S
> > @@ -65,10 +65,10 @@ SECTIONS
> >    * From this point, stuff is considered writable and will be copied to RAM
> >    */
> >   	__data_loc = ALIGN(PAGE_SIZE);		/* location in file */
> > -	. = KERNEL_LINK_ADDR + XIP_OFFSET;	/* location in memory */
> > +	. = ALIGN(SZ_2M);			/* location in memory */
> 
> You can't use SZ_2M here since it corresponds to PMD_SIZE for rv64 but on
> rv32 (which is allowed to use xip kernels), it's 4MB. Use SECTION_ALIGN
> instead.

SECTION_ALIGN doesn't work unfortunately. For XIP, SECTION_ALIGN is
L1_CACHE_BYTES which is 64 bytes, but we need at least PMD_SIZE alignment
to setup virtual mapping.

Ideally we use PMD_SIZE here, but I can't #include that header file.
Probably we can refactor the header files so that we can #include the
header file that PMD_SIZE is in. But I am not sure if it's worth it.

I'm thinking just go for:
ifdef CONFIG_64_BIT
	. = ALIGN(SZ_2M);
#else
	. = ALIGN(SZ_4M);
#endif

Or even simpler, just:
	. = ALIGN(SZ_4M);

As much as I hate magic numbers, I think we can give linker script some
leeway. Perhaps with an explanation why this alignment is chosen?

Or do you have a better idea?

Best regards,
Nam

