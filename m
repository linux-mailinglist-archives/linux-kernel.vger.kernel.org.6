Return-Path: <linux-kernel+bounces-268058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FEF941FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BE01F24F67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B181AA3CF;
	Tue, 30 Jul 2024 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="do2UeeMf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YsSD+dkK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E730F1AA3C3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364865; cv=none; b=CwIfM/MfTYKBQgySaillki+ZQ39xrRJZKDbnq1TAKhdmV6rlvjLxtIKBIuRt5/Q7q0fPRm2Vx6wMGEMhcHHntuizDO9uLj0jVVv4FSgPcfXBWM1EV947PvgOQk1hEPMTyMynb7uEji6s/NUseel+kc3tyuf8IO1a7+jlpA1LREA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364865; c=relaxed/simple;
	bh=HdDz1asFNv6r6ws0GmkiQ7wpyxY71Ul1bRE2sKNl0fo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y3OToA11Ts2U53fsjCSHiLfv5YPlfl5pQkVgID6vZzbu2VkrCB4rLx0LuYWpFZGRKMHDDnzXKwSFk8uznqQhMy1j6Y+f6I0PSaoHzEHJhZJqAj31yVi6PeyEaei/hEY7/Bc7avvLfQDqv2uDOENRx2tdwzwvXX8J3OPNwZ81sMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=do2UeeMf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YsSD+dkK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722364861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dWNUezlVVzVUbvkFF2B8z+arPed9lXpTmrQXYTht/ws=;
	b=do2UeeMfVoTgiFeW14ultUjy/ZCxQRiLg/tG5t8NRns0nzbChtgx7MF6Jd5WLmgx6AcwqB
	KokIW65z7mdFsqUuH2xQs4CdrZeAOI/OJqKCOuel8Upvf4zySISbPzrlYIflpvsDsTgTUw
	080UeijTwZUhKbEJUuQ27X5OkrMlovC4H3w6pIAzMXurumhYX/XGBQ4M9o0Oq0cAO89zgv
	S0XDPojmsxGgtOe7kdoCM4SlTdH4T9phuo+vmaO4/zA0vB7ON7qh9RI2at37DYAxIjINVH
	ScvpSFwOqegjJwrvu+Z7Veasd3DpmMN6nhZsPka7juNSKTEYkv2wvywhTKumVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722364861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dWNUezlVVzVUbvkFF2B8z+arPed9lXpTmrQXYTht/ws=;
	b=YsSD+dkKMUeIKgBg7hYEIsun6Pd9S5CwUxGSwpjEgaWhVwtQoRNesXamjEYxYHYpgQnjXf
	GW7kTWgQHTFposAQ==
To: "Alexey Gladkov (Intel)" <legion@kernel.org>,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai
 Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>, Oleg Nesterov
 <oleg@redhat.com>, Joerg Roedel <jroedel@suse.de>, Tom Lendacky
 <thomas.lendacky@amd.com>, cho@microsoft.com, decui@microsoft.com,
 John.Starks@microsoft.com
Subject: Re: [PATCH v1 4/4] x86/tdx: Implement movs for MMIO
In-Reply-To: <c24855b0003df4397e3931f35d7ec285db5bc8bf.1722356794.git.legion@kernel.org>
References: <cover.1722356794.git.legion@kernel.org>
 <c24855b0003df4397e3931f35d7ec285db5bc8bf.1722356794.git.legion@kernel.org>
Date: Tue, 30 Jul 2024 20:41:00 +0200
Message-ID: <871q3a7mf7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 30 2024 at 19:35, Alexey Gladkov wrote:
> Adapt AMD's implementation of the MOVS instruction. Since the
> implementations are similar, it is possible to reuse the code.
>
> MOVS emulation consists of dividing it into a series of read and write
> operations, which in turn will be validated separately.

Please split this into two patches:

    1) Splitting out the AMD code
    2) Adding it for Intel
> @@ -369,72 +369,17 @@ static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
>  static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
>  				   char *dst, char *buf, size_t size)
>  {
> -	unsigned long error_code = X86_PF_PROT | X86_PF_WRITE;
> +	unsigned long error_code;
> +	int ret = __put_iomem(dst, buf, size);

Variable ordering....
  
> +static int handle_mmio_movs(struct insn *insn, struct pt_regs *regs, int size, struct ve_info *ve)
> +{
> +	unsigned long ds_base, es_base;
> +	unsigned char *src, *dst;
> +	unsigned char buffer[8];
> +	int off, ret;
> +	bool rep;
> +
> +	/*
> +	 * The in-kernel code must use a special API that does not use MOVS.
> +	 * If the MOVS instruction is received from in-kernel, then something
> +	 * is broken.
> +	 */
> +	WARN_ON_ONCE(!user_mode(regs));

Then it should return here and not try to continue, no?

> +int __get_iomem(char *src, char *buf, size_t size)
> +{
> +	/*
> +	 * This function uses __get_user() independent of whether kernel or user
> +	 * memory is accessed. This works fine because __get_user() does no
> +	 * sanity checks of the pointer being accessed. All that it does is
> +	 * to report when the access failed.
> +	 *
> +	 * Also, this function runs in atomic context, so __get_user() is not
> +	 * allowed to sleep. The page-fault handler detects that it is running
> +	 * in atomic context and will not try to take mmap_sem and handle the
> +	 * fault, so additional pagefault_enable()/disable() calls are not
> +	 * needed.
> +	 *
> +	 * The access can't be done via copy_from_user() here because
> +	 * mmio_read_mem() must not use string instructions to access unsafe
> +	 * memory. The reason is that MOVS is emulated by the #VC handler by
> +	 * splitting the move up into a read and a write and taking a nested #VC
> +	 * exception on whatever of them is the MMIO access. Using string
> +	 * instructions here would cause infinite nesting.
> +	 */
> +	switch (size) {
> +	case 1: {
> +		u8 d1;
> +		u8 __user *s = (u8 __user *)src;

One line for the variables is enough

		u8 d1, __user *s = (u8 __user *)src;

No?

> +	case 8: {
> +		u64 d8;
> +		u64 __user *s = (u64 __user *)src;
> +		if (__get_user(d8, s))

Lacks newline between variable declaration and code.

Thanks,

        tglx

