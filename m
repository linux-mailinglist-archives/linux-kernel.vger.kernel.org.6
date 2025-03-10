Return-Path: <linux-kernel+bounces-555118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A2DA5A5B0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6E416467C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A731E0DCB;
	Mon, 10 Mar 2025 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aQ63LdtY"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2441DFE36
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640900; cv=none; b=btHIIt+x3IbMhM4iX7c4H5zBC4lA58sB/rOOuBc2G4n/lKt34TTNfDAkUgGWWhNeS3NNHx5zTCRNTOJr3Kn9ZTrQpUD7yrfje3GpzyJ1I9oG5aWzBZMzaJ1hii9AerGLgHkpDjvAEs2tP08Gyc2utxGum5OH8FVb1enr4AePr48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640900; c=relaxed/simple;
	bh=VR2wAof/CUikRHxLL0n/GkAQxSTUrmIlQoE7GZeM0bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxEn78UH1HhazbU+x9cu5cFIp318ylcmmogvpY3J24n2+16k2JZSkEsx1+ySv2Y2iQh6rZZsE7CvDHFy6pTnuT3hat+VsyQaNLweooAomi70pvLcopxTQtGpmS/wBQC1bTRYvgsDhwXmAIEMrXokK2iWcw6vYCZnbSYjsTdW0Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aQ63LdtY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4C2CE40E0216;
	Mon, 10 Mar 2025 21:08:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id plde9bdFn_4K; Mon, 10 Mar 2025 21:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741640885; bh=eVxr2+AIcLO13/Vxr94S5uPIjyR4tYnmLC8UAF+lfMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQ63LdtYgExzRQReITdAyb476uo20qjDmXPBnxqBhz45slFW/OOR7ZEKO0FZhkuLR
	 Djlmlm+7597dCB/UD39Vb9DNXSRDRbnfxBEJAhOGEepxiIwefrZSsbcVpzMpy4NisQ
	 4Pj/ADEOjpCkxBv5Xz7LtIFkZUxjP98hu+evYoxnq8GdXLNPLtn4wYx10C/lW22gi5
	 sORXnxZJtVro7Yag8ANnGsyeUJJq13KjOuHF30xgwazxQekzxXX5wIxrQtNM4dBbVP
	 APGU6YHBfvRmaBEjhhpZnFPmQi5cKwuOU15uKHxAfdhvESa798E5t/AFOBfWg+ArYq
	 tvrBPF1k2Qu/zA/uQOR89kGLY+/H0GTz8J3UhnXHpDXvnjg5kKpTKoMFna0g0+g/Xy
	 VpxXaHU4hyDMx2Iw7byiWq24yz/J8SY38+MivOwUNBCE1Pqok/V12gdIy4kku4WmGH
	 56wp3SqiQD60vS1KDz/ukhCtqsvJPMgZu/Og+WPMH2m4mci4Xyz9CbuU03R0/Samv7
	 2rbYX1wFWY32vNmjZXsrZxd+AGF2loo+yENz81ZutxcRjUV8oG8231LNgnZW6q90PR
	 VxMOvcnzwO/+6mHqclnc8ieNVc5mwNp42cOFM+zTFcNydKidIr0ZYoXCTppNGk5qmN
	 /TLU1qPRzDMjN0cr+CI3FbWs=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B8C7540E0218;
	Mon, 10 Mar 2025 21:07:58 +0000 (UTC)
Date: Mon, 10 Mar 2025 22:07:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/hweight: Fix and improve __arch_hweight{32,64}()
 assembly
Message-ID: <20250310210753.GZZ89UqRTKo2OE4UOl@fat_crate.local>
References: <20250310200817.33581-1-ubizjak@gmail.com>
 <20250310201227.GXZ89Hq5LVWKHjHBeO@fat_crate.local>
 <CAFULd4ZCc08kJU+3ZVdyWhO4s5fu0Y-RDPS-Y-_sPB1R0KrnoA@mail.gmail.com>
 <20250310204454.GYZ89PRl3dBR-9oBIY@fat_crate.local>
 <CAFULd4YwQ3dcRwugyr9-GUWbVh2cREu6qNQctKG2S5JpoEfQcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4YwQ3dcRwugyr9-GUWbVh2cREu6qNQctKG2S5JpoEfQcg@mail.gmail.com>

On Mon, Mar 10, 2025 at 09:54:25PM +0100, Uros Bizjak wrote:
> Ok, so let it be your way and let's just sweep the issue under the carpet.

Can you please read my mails more carefilly? Where did I say we should sweep
the issue under the carpet?

The commit message should be *perfectly* clear what it is fixing. This

"a) Use ASM_CALL_CONSTRAINT to prevent inline asm that includes call
instruction from being scheduled before the frame pointer gets set
up by the containing function, causing objtool to print a "call
without frame pointer save/setup" warning."

says that objool is printing a warning. When I ask, it is not really printing
a warning but it can potentially do so because the compiler is allowed to
schedule things wrongly.

Do you notice the difference?

Dammit, it is very important *why* a commit message is there - it is not
write-only and people look at it. So *again* *please* be precise when
explaining why your patch exists!

All that stuff has been documented at length:

https://kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

Thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

