Return-Path: <linux-kernel+bounces-224200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391E4911EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B54A6B21919
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7128127B5A;
	Fri, 21 Jun 2024 08:27:01 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66D916D32F;
	Fri, 21 Jun 2024 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958421; cv=none; b=K3JVEiY+D4fNNpFsM54ocn/xZMbXG5AQCbY6QJip4YuxezzSm7welQrCGDwJR4aLl/xSBYYuwOErXlKYbp8vqBvBcGaYlwVzUFRyvUmAYmMf0ScB75dd+7esbOcom7Wb06D9WITEwLDaTGxDc+FRBMtb/c5iz6t31Y8dWIJeniw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958421; c=relaxed/simple;
	bh=UK3fsbl77oLkGrCcvOZTG9mXf/uwZCAocQBlI7NgwXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjLOI3KH3EQKtEk3wzM4Y74X9ohjBG9DX3dzqG94hZ4R31v5m3dYmfyCYhAh5NmOLtXP61HdWmEvtnP7Q+Q2G1SUYF8w1B+TRcABByIQBNvQCAgyDc6L3+SAUVpKttJXWuyI/eFiqygaFUWktNCYeO4AMiQThZqYjnhq4Gv7rQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1sKZbl-0001Sk-00; Fri, 21 Jun 2024 10:26:57 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 73B3BC0411; Fri, 21 Jun 2024 10:25:48 +0200 (CEST)
Date: Fri, 21 Jun 2024 10:25:48 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH fixes 1/4] MIPS: mipsmtregs: Fix target register for MFTC0
Message-ID: <ZnU5DGtw7aeZUtJ0@alpha.franken.de>
References: <20240616-mips-mt-fixes-v1-0-83913e0e60fc@flygoat.com>
 <20240616-mips-mt-fixes-v1-1-83913e0e60fc@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616-mips-mt-fixes-v1-1-83913e0e60fc@flygoat.com>

On Sun, Jun 16, 2024 at 02:25:02PM +0100, Jiaxun Yang wrote:
> Target register of mftc0 should be __res instead of $1, this is
> a leftover from old .insn code.
> 
> Fixes: dd6d29a61489 ("MIPS: Implement microMIPS MT ASE helpers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  arch/mips/include/asm/mipsmtregs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/mipsmtregs.h b/arch/mips/include/asm/mipsmtregs.h
> index 30e86861c206..b1ee3c48e84b 100644
> --- a/arch/mips/include/asm/mipsmtregs.h
> +++ b/arch/mips/include/asm/mipsmtregs.h
> @@ -322,7 +322,7 @@ static inline void ehb(void)
>  	"	.set	push				\n"	\
>  	"	.set	"MIPS_ISA_LEVEL"		\n"	\
>  	_ASM_SET_MFTC0							\
> -	"	mftc0	$1, " #rt ", " #sel "		\n"	\
> +	"	mftc0	%0, " #rt ", " #sel "		\n"	\
>  	_ASM_UNSET_MFTC0						\
>  	"	.set	pop				\n"	\
>  	: "=r" (__res));						\
> 
> -- 
> 2.43.0

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

