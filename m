Return-Path: <linux-kernel+bounces-394781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C3D9BB413
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8837FB25B0D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B03F1B4F1C;
	Mon,  4 Nov 2024 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kjINS+39"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BBC18A6B5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720868; cv=none; b=lcgmDNcyWm2cFUeGP3Fg4mMIetCBFker3UNeL9Z11p6KaIkQrMknzvA4fY9D9hwcTG+Z5SosW6qX1I4M2FRL+41w7zP+bcWJfHbSdEqXjU3gN+ocVE9JqjfyhRmZ1lHBxRyxao9EROdrJT+fbuI7TPUESrW3ec5hUUoqSPWQC7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720868; c=relaxed/simple;
	bh=yOEPsj9KFFRdY7eMeU9/C5lJYE5SkXK4KN0usaOHEQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upVVfbtElh5Lz4elNzqj5mtyqhOxmzIVROjptcQRYWi6/bgRxG6qASqtGaRMxxlm2lo5oiSxaemspA2KJbjhbLVIzJsNwVB9BX3iBoNlGm70FX+oPO9fP2xZWTpQtRNKYmf4TWImY29s8vlb75jgVbyUscbNosElTmNxm7Xt6Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kjINS+39; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 35C5640E0263;
	Mon,  4 Nov 2024 11:47:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id l-k2S-n2RROW; Mon,  4 Nov 2024 11:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730720860; bh=rVi6YSrvxImXe6tAD3p6c0ZCJPUYYzFo2UZtJJiidtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjINS+39G4cocInXfJMcuADyNK094aCiL4bdZkdNJQ1j2crNeWquir2qSrQzH6pbJ
	 egOM3eFbMhpjQIfPBifS3W1zuvRSiNHeotchFqrzWJ+kXkXUq0HNEtNVWvUFOhDt0Y
	 46SSe0LuVX0v5fqLNNFOXej2IyLgrian9gtBjjFW1P1vHmhi7voidIV5wq5Cr3Jh6y
	 Mvd4S1L6O/faJrmJ3PS5870fZ1a75dfyn6spRtUe5F7VFwHQ7wHVw2U3TjpadCdyrj
	 sqgGJRQAxovRPHzrBJSTWrHJK7uKUAvzspXGT2TYXJmTkMS6ySU/4igFuIOMnCiOXs
	 X8qtpjhoRaQPY5RzI4W2kLQzxzW+7mORoqfwGBLBmmvnidDZv4cJ5tekdTeqRcc6vT
	 F8qJ//fOLtKAQWcpH0h1yriKwDck38u/oKI3uUZTANr7e970o9PXhJtdpYYd3ouFhy
	 9W+NcJo94N0B6e+l/Qbb/7WrkTtyHiCTnEd+NS+QNT71mwr8TECX6QGMtxDzl/k1gU
	 112q7ueTiEtxgNyvdcccclk0DduhJpK+Uc8BtsbvTvxM1HUIsgQp4Fh7saJTLZHxZk
	 JF5scRSfUeSfGWk08cNZ8X8iKVP26Qrzk+tGPj2uC19KX/kRwxW4R+exBlw9lSF7W0
	 v3uM151/hw4LU9y1pgmdP1ME=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 02BC040E0163;
	Mon,  4 Nov 2024 11:47:34 +0000 (UTC)
Date: Mon, 4 Nov 2024 12:47:28 +0100
From: Borislav Petkov <bp@alien8.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: david.kaplan@amd.com, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [RFC][PATCH 2/2] x86: Clean up default rethunk warning
Message-ID: <20241104114728.GTZyi0UHYKx-ZHL4kh@fat_crate.local>
References: <20241007083210.043925135@infradead.org>
 <20241007083844.119369498@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007083844.119369498@infradead.org>

On Mon, Oct 07, 2024 at 10:32:12AM +0200, Peter Zijlstra wrote:
> -	.section .text..__x86.indirect_thunk
> +#define WARN_ONCE							\

This should be in the asm section of arch/x86/include/asm/bug.h so that other
asm code can use it. It will come in handy...

> +	1: ALTERNATIVE "", "ud2", X86_FEATURE_ALWAYS ;			\

... but uff, you can't because of this ALTERNATIVE. This is a conditional
WARN_ONCE.  Yuck.

I guess ALT_WARN_ONCE or so...

> +	ASM_BUGTABLE_FLAGS(1b, 0, 0, BUGFLAG_WARNING | BUGFLAG_ONCE) ;	\
> +	REACHABLE
>  
> +	.section .text..__x86.indirect_thunk
>  
>  .macro POLINE reg
>  	ANNOTATE_INTRA_FUNCTION_CALL
> @@ -382,16 +387,15 @@ SYM_FUNC_END(call_depth_return_thunk)
>  SYM_CODE_START(__x86_return_thunk)
>  	UNWIND_HINT_FUNC
>  	ANNOTATE_NOENDBR
> -#if defined(CONFIG_MITIGATION_UNRET_ENTRY) || \
> -    defined(CONFIG_MITIGATION_SRSO) || \
> -    defined(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)
> -	ALTERNATIVE __stringify(ANNOTATE_UNRET_SAFE; ret), \
> -		   "jmp warn_thunk_thunk", X86_FEATURE_ALWAYS
> -#else
> +
> +#ifdef CONFIG_X86_64
> +	WARN_ONCE
> +#endif

And you can add an empty 32-bit WARN_ONCE macro so that we don't have this
ifdeffery here where ifdeffery gives the last drop of making this file totally
unreadable...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

