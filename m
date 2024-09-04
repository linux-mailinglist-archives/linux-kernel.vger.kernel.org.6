Return-Path: <linux-kernel+bounces-314678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC1896B6B9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC318B28A0E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D71E1CEABF;
	Wed,  4 Sep 2024 09:30:27 +0000 (UTC)
Received: from hop.stappers.nl (hop.stappers.nl [141.105.120.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111741A727F;
	Wed,  4 Sep 2024 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442226; cv=none; b=hdqbW5YE/M0pAMRv14cJlOMALo+ii1DeOf00prZx0mXd4EscVBckU7NNygi8vNYOj1vDWfqOSMT75sWpGTkIhVhZ8wHdqUxPpJpBKwOWNrEbf+bP62ZqeGpkWH1zVgai+nzUPcaiLYM9gtg9nXwrusGfT7K3vOQvHgNtjWDligk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442226; c=relaxed/simple;
	bh=RMPZvHEVaim0EYA6xxt6Zc8BCCA+ksqED4910RkhiLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Te74jVOCyAXvwmtmmcw/pgGZhB2Z36o6kuspKtqbO10mVkTDxTiPA2Su91dhbYi1e8eKx3LRh1z3evZIKt4mBSvK5O4GtQC3nT2pliWWql7QEuccNFkJ6QADqmnpfk697GbdsuUoRW4U1xwawtRTYI3GDupTDCJVHFR3O2HEjRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stappers.nl; spf=pass smtp.mailfrom=stappers.nl; arc=none smtp.client-ip=141.105.120.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stappers.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stappers.nl
Received: from gpm.stappers.nl (gpm.stappers.nl [82.168.249.201])
	by hop.stappers.nl (Postfix) with ESMTP id 9137C20203;
	Wed,  4 Sep 2024 09:30:14 +0000 (UTC)
Received: by gpm.stappers.nl (Postfix, from userid 1000)
	id 7470E30417C; Wed,  4 Sep 2024 11:30:13 +0200 (CEST)
Date: Wed, 4 Sep 2024 11:30:12 +0200
From: Geert Stappers <stappers@stappers.nl>
To: Zigit Zo <zig@iorw.io>
Cc: ojeda@kernel.org, bjorn3_gh@protonmail.com, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	tglx@linutronix.de, mingo@redhat.com, nathan@kernel.org,
	ndesaulniers@google.com, gary@garyguo.net,
	rust-for-linux@vger.kernel.org, linux-um@lists.infradead.org,
	llvm@lists.linux.dev, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: arch/um: use 'static' relocation model for uml
 modules
Message-ID: <ZtgopAHp+I2+xCIz@gpm.stappers.nl>
References: <20240903130606.292935-1-zig@iorw.io>
 <FD7D773099A0C7EC+20240903130606.292935-2-zig@iorw.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FD7D773099A0C7EC+20240903130606.292935-2-zig@iorw.io>

On Tue, Sep 03, 2024 at 09:06:05PM +0800, Zigit Zo wrote:
> In the x86_64 UML, kernel modules compiled with Rust will currently
> generate some R_X86_64_GOTPCREL relocations, which will then be rejected
> by the kernel.
> 
> And because of the kernel modules of UML are only got handled by the UML
> itself, relocation model 'static' can work as expected other than 'pie'.
> ---
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index 00b63bac5eff..b04b1d4d6dfe 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -63,7 +63,7 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
>  	-Din6addr_loopback=kernel_in6addr_loopback \
>  	-Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr
>  
> -KBUILD_RUSTFLAGS += -Crelocation-model=pie
> +KBUILD_RUSTFLAGS_KERNEL += -Crelocation-model=pie
>  
>  KBUILD_AFLAGS += $(ARCH_INCLUDE)
>  
> -- 

I failed to match the actual change with the commit message.  Consider
that ignorance on my side.

I see a problem in just renaming a variable, might be my problem.  Thing
is that removal of 'KBUILD_RUSTFLAG += ' feels wrong, hence this posting.



Groeten
Geert Stappers
-- 
Silence is hard to parse

