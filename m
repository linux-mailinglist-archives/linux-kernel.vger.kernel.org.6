Return-Path: <linux-kernel+bounces-268032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DDF941F90
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7E51C22F08
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1D91A76BE;
	Tue, 30 Jul 2024 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TlH+f4u3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u6dBhDqt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E39F1482F3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364280; cv=none; b=D4GYDvcjxe7vjkDNPLetOjXt2R8Q92hHzmeX/Cn9EpH08itVHwlCXFGV32vicqZfHsr0AQaoclq4gTRL0KFmsmSyu2qQZA8lNxpf9FsUv+Wug2TvhF7/sVpLAEhyQ5/NAHMzn7IVWPyD8n4Wx8fuvsNKRZlJbqqubZUZD0MVXp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364280; c=relaxed/simple;
	bh=qjbMSV72ozbsS2EaCpBgSnIUsymHPbRg6KvcPRWySMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SlYQg1ODQT4s1fimShvlctYwLgIqYqd2e3Eof85AZwFLpmnjHztTcTEefEYVaLUDkUTtvvXlY7g1YSSYMv4vh4RNqnDHawcb69i6MvHGIL0VjWcxLqC2KJ8mBsp5RHPfYdy9kqLweRKLJe3Mi9Yb9TT7SVLMI84KCvEs5h1h9YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TlH+f4u3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u6dBhDqt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722364276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IZh0VLRLVNDot7WgZe2KHKmWYfaY2DBdRJamg3tTgzg=;
	b=TlH+f4u3GJfRfYAv5iKtno2SKtjd+Iylr8k72jKHBLHFUVa00fgGQv8kNTesM6yLn1dNvb
	X4ThTWRLTXwiMtTLMwTz/dZgaJ7DsdeXgPZKOEC+BVTKpo0FCIuzh8PROVYB4I7u3ZZyfV
	+AWXpew5k/y3rW7j4CthttZczbOvFfzs4KSI9/7IoC15zdMz3R2u0ydR8jOJZXjxtEH0/8
	67Ybp+nJu7H9f2k8zj0jzMXRiFNnlFtXA3wFB7N38CAURNse4/zQFBp09p5vJvaOPioXBD
	H6sMfSFfPFfukkzzySh/JhCclxUBFNkV3b5U+jjCEKH2kr3KuUi8wDOaRMPHUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722364276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IZh0VLRLVNDot7WgZe2KHKmWYfaY2DBdRJamg3tTgzg=;
	b=u6dBhDqtDZaV2O7U+QWTBZcAysVuZWio5rgAjBLzkF9MiyBANUk/iEQFmLfuZ5tjgJrWtn
	InL4XRAGchhG56Bw==
To: "Alexey Gladkov (Intel)" <legion@kernel.org>,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai
 Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, Oleg Nesterov
 <oleg@redhat.com>, cho@microsoft.com, decui@microsoft.com,
 John.Starks@microsoft.com
Subject: Re: [PATCH v1 1/4] x86/tdx: Split MMIO read and write operations
In-Reply-To: <ff7cc8b32ae3829892d0dd5dcd3245d1db2684c0.1722356794.git.legion@kernel.org>
References: <cover.1722356794.git.legion@kernel.org>
 <ff7cc8b32ae3829892d0dd5dcd3245d1db2684c0.1722356794.git.legion@kernel.org>
Date: Tue, 30 Jul 2024 20:31:15 +0200
Message-ID: <87a5hy7mvg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 30 2024 at 19:35, Alexey Gladkov wrote:
> To implement MMIO in userspace, additional memory checks need to be
> implemented. To avoid overly complicating the handle_mmio() function
> and to separate checks from actions, it will be split into two separate
> functions for handling read and write operations.

It will be split? The patch splits it, no?
>  
> +static int handle_mmio_write(struct insn *insn, enum insn_mmio_type mmio, int size,
> +		struct pt_regs *regs, struct ve_info *ve)

Please align the second line argument with the first argument in the
first line.

> +static int handle_mmio_read(struct insn *insn, enum insn_mmio_type mmio, int size,
> +		struct pt_regs *regs, struct ve_info *ve)
> +{
> +	unsigned long *reg, val;
> +	int extend_size;
> +	u8 extend_val = 0;

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

>  static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>  {
> -	unsigned long *reg, val, vaddr;
> +	unsigned long vaddr;
>  	char buffer[MAX_INSN_SIZE];
>  	enum insn_mmio_type mmio;
>  	struct insn insn = {};
> -	int size, extend_size;
> -	u8 extend_val = 0;
> +	int size;

Ditto
  
>  	/* Only in-kernel MMIO is supported */
>  	if (WARN_ON_ONCE(user_mode(regs)))
> @@ -428,12 +504,6 @@ static int handle_mmio(struct pt_regs *regs, struct ve_info *ve)
>  	if (WARN_ON_ONCE(mmio == INSN_MMIO_DECODE_FAILED))
>  		return -EINVAL;

Thanks,

        tglx

