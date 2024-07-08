Return-Path: <linux-kernel+bounces-244682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0C992A7D2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACDF1C20F1D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5700D148310;
	Mon,  8 Jul 2024 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ETihcGGp"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F9114386F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458362; cv=none; b=TYoT5ZL1mR+IQTbgAMAydKO85YWyOtPWxm/U5qBc22IUkPWJGk3G3YpYPT0U912uVqeXChcm6ncEo+UXJnZBF7qLN41WYWL49ZmtYKkqAwKuX+cKCLswi0I6QH9JXKqfLoKeZstNhHsU68PHUnt4KOmne0omRbCGRa3+ZlLtRdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458362; c=relaxed/simple;
	bh=Ish0rUcGrNM6Y64WRYX4W3v6raEfzTe4xQ8BUWA9+C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/dnTWCL8CUveh13jDtbiel9GvaE7Z4Rq18liyq6eBWjScCY4b64ScbZhVOePfxZ1CD9d3fgz+UtIBBF1CYF3pnjIOiowc1RVFIKRyVKE11beNaUX33L3JBm7byLq5W8dGaH6dvC19Jxikk9jWheCd8tbPmrRLwS/HrkYwzXgFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ETihcGGp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9700F40E019C;
	Mon,  8 Jul 2024 17:05:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6zurUK6Kdl7H; Mon,  8 Jul 2024 17:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720458352; bh=qvpshdjcai+bu5YyaX5ecqH8SNfEteGnaGQ1BUGaRuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ETihcGGp2WBVa/arC/4Y2wVTsBhyCGqBARR9EhgjRvJ97d69lVhplPmPbknNsahiu
	 1UITU9vFVN4jCeKlZ44faix2m9nWUG6Zv2AdOaI753D7G0rTVZ6xYFe3PD2g7JjuvC
	 D+xfz2zva0rV4h/fJtVjaYCBpt0aaFv4yhT+Gm6+ddgY3R/zB9o4F0gx7gqw1dclLY
	 WQk1AOu4mMZv7SSdWThXqGWnzldfiRBLdPeM7UEUZg/X2jARbIibNXt7J9FAe4i2S6
	 ubyUpM6yOKmAQa1YF9P4xtyPJ+Ckur9tONDCBwCsu4Tcz1FSnESatJPON7sDb5y8dz
	 cX2TS0T+gt5ogrEnBMZtz0iRxcPbOAudcSfEIR/ouUH1vSiUxxOOlG4I2XyWNshlry
	 9rN8rslcflxq2+HzcYlW6kUpW+LBMuuMN+TmB9zlKocZLdcwJnKuqiDVxnjopohjFZ
	 X5Nwq1qJX2kxG3ZFJUAzpXCXpLr7evxUHK9m0x6DaJqJUhYuntr3Xl3UCA9lnvN+ZQ
	 sygHjA1Czt/8G7UlBw9V/X86nOTvofgmt/kUszDq7kmUc55mAemuasOke7WTiwvrJi
	 XfzBOh5UAAtjr4PidSad2ZHE4/6qZRJUAyeeWxkI05sIBXrpdubosI1u1HrmJfLiQl
	 P0VxQttSutgtRChvu5Om1f5Q=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A4EA440E0192;
	Mon,  8 Jul 2024 17:05:46 +0000 (UTC)
Date: Mon, 8 Jul 2024 19:05:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jim Mattson <jmattson@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH 5.10] x86/retpoline: Move a NOENDBR annotation to the
 SRSO dummy return thunk
Message-ID: <20240708170541.GGZowcZZ0tZmt7znYA@fat_crate.local>
References: <20240708164319.3801778-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240708164319.3801778-1-jmattson@google.com>

On Mon, Jul 08, 2024 at 09:43:05AM -0700, Jim Mattson wrote:
> The linux-5.10-y backport of commit b377c66ae350 ("x86/retpoline: Add
> NOENDBR annotation to the SRSO dummy return thunk") misplaced the new
> NOENDBR annotation, repeating the annotation on __x86_return_thunk,
> rather than adding the annotation to the !CONFIG_CPU_SRSO version of
> srso_alias_untrain_ret, as intended.
> 
> Move the annotation to the right place.
> 
> Fixes: 0bdc64e9e716 ("x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk")
> Reported-by: Greg Thelen <gthelen@google.com>
> Signed-off-by: Jim Mattson <jmattson@google.com>
> ---
>  arch/x86/lib/retpoline.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
> index ab9b047790dd..d1902213a0d6 100644
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -105,6 +105,7 @@ __EXPORT_THUNK(srso_alias_untrain_ret)
>  /* dummy definition for alternatives */
>  SYM_START(srso_alias_untrain_ret, SYM_L_GLOBAL, SYM_A_NONE)
>  	ANNOTATE_UNRET_SAFE
> +	ANNOTATE_NOENDBR
>  	ret
>  	int3
>  SYM_FUNC_END(srso_alias_untrain_ret)
> @@ -258,7 +259,6 @@ SYM_CODE_START(__x86_return_thunk)
>  	UNWIND_HINT_FUNC
>  	ANNOTATE_NOENDBR
>  	ANNOTATE_UNRET_SAFE
> -	ANNOTATE_NOENDBR

Whoops, those two here didn't look right, thanks for catching this.

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

And looking at 6.1, it is wrong there too. :-\

commit 7ef6a7f9b32fdfc8bec0a10e6d5ac5374d4f02e7
Author: Borislav Petkov (AMD) <bp@alien8.de>
Date:   Fri Apr 5 16:46:37 2024 +0200

    x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk
    
    commit b377c66ae3509ccea596512d6afb4777711c4870 upstream.

Greg (KH - there's another Greg on CC too :-)), do you prefer such stable-only
fixes like that or should we revert the wrong backports and redo them?

Thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

