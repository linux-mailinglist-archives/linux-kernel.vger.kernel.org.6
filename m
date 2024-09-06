Return-Path: <linux-kernel+bounces-318993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9A396F648
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 839F8B210F7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440331CF7A8;
	Fri,  6 Sep 2024 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kb3mgg1n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55EF13B5AF
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631657; cv=none; b=WETrK+lokJkdf137csgOvWq3d7dNORd11xeXFyq/ZJY9LgX78OrhU26ap8ae4fkWExMQ7jUoxNjVMSHLsiAP2Ykha9r/EPFLyAyBW8Oc2ZC5UismcQTcxmUxKQU2PHt8NtkOyTTv/cs4refNu6xQsD4ZxLeH9svuTYOOR58bwzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631657; c=relaxed/simple;
	bh=n649iZISruVjFcb8MmY5fUpAUynB7oUB8uDWJZbIXXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAkRP3NUBDdFqfdYraYdjbKOUKCbYNArQ86oGGGZSMIi2gq6p4VZUVxu38HVo+VQX4CcVCIHaJCn2H9mi7tGtLhlYRO6acmaIB14KatEK0l9jm0NEyOP+CsJ8CJjndzZKG2l8v5/D3m6Nn5GX1MKZgC7l5VHI3pvwVn7BqTpqEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=kb3mgg1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687A5C4CEC4;
	Fri,  6 Sep 2024 14:07:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kb3mgg1n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725631654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K7LZVi58f5+Ti3Nfy7VxoI0NsxNh8KDlsMzkNiEZ9Yk=;
	b=kb3mgg1nzwso9U2S0XpYDSKHzzaZU8sY1+QG+AOH6fmtua4/8SGO9R/Yn8yKtybHBsVTte
	uk7W61bNNgvvmVeSHggy8z9wnnuO5dFHZKa1puxHAhjUNce6wdintCj+nNuVxgGKpPRmbo
	JMbP+WjmbZSJE9CE/Sj+lFiO3PHlMXw=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f920a885 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Sep 2024 14:07:34 +0000 (UTC)
Date: Fri, 6 Sep 2024 16:07:33 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 2/2] Fixup for 3279be36b671 ("powerpc/vdso: Wire up
 getrandom() vDSO implementation on VDSO32")
Message-ID: <ZtsMpcV7iLYoytdJ@zx2c4.com>
References: <700dbf296d02e32376329774be35cfbead08041d.1725611321.git.christophe.leroy@csgroup.eu>
 <ffd7fc255e194d1e2b0aa3d9d129e826c53219d4.1725611321.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ffd7fc255e194d1e2b0aa3d9d129e826c53219d4.1725611321.git.christophe.leroy@csgroup.eu>

On Fri, Sep 06, 2024 at 10:33:44AM +0200, Christophe Leroy wrote:
> Use the new get_realdatapage macro instead of get_datapage
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/vdso/getrandom.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/vdso/getrandom.S b/arch/powerpc/kernel/vdso/getrandom.S
> index a957cd2b2b03..f3bbf931931c 100644
> --- a/arch/powerpc/kernel/vdso/getrandom.S
> +++ b/arch/powerpc/kernel/vdso/getrandom.S
> @@ -31,7 +31,7 @@
>  	PPC_STL		r2, PPC_MIN_STKFRM + STK_GOT(r1)
>    .cfi_rel_offset r2, PPC_MIN_STKFRM + STK_GOT
>  #endif
> -	get_datapage	r8
> +	get_realdatapage	r8, r11
>  	addi		r8, r8, VDSO_RNG_DATA_OFFSET
>  	bl		CFUNC(DOTSYM(\funct))
>  	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)

I tested that this is working as intended on powerpc, powerpc64, and
powerpc64le. Thanks for writing the patch so quickly.

Jason

