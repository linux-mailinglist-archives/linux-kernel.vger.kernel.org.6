Return-Path: <linux-kernel+bounces-173264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 454098BFDDE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9BB284331
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1979A5D74C;
	Wed,  8 May 2024 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RsIxO76q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VILWxv3Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172FD55E40;
	Wed,  8 May 2024 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715173222; cv=none; b=DbQ40hWofX3UV3paWxkmazEsMd98E4vbH4L1BVPjOIXd/lTR9XGHTlKodw2phLXkQkF1OuD4IP8IbAL43qLm+7Z0O5uMcl2TWKUznhRjAdyYvWuSQ2lyTBDkqFpZJfdpzHqNffhUUnkxcgEbSUwCbykrg97PMMZ+OErSJcGNCOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715173222; c=relaxed/simple;
	bh=VL/B/S5LHPg1SxdBK+Kgk3Vm5npaZzfKR8tx7ySUJDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rS5vOuCWdhtFGY6D8s6EQ7Fzepxs3aHgS4iZVI7mfy99t2QJnknjKjsCtVJ4SZEAEePito0ITIQ9kYYGRsjOcBFCxUJx0/fYzYlESTHcILPrQ7ioLfrpQ+isXcLK9Ofkd6qGupNm13ZoXgdFgfznc1VI/BAUOYl3VFFFeCXzsW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RsIxO76q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VILWxv3Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715173219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPhuL3UM5yIxpg2EhK/QKw4q/Os8hXdmW0AhRhBQxVo=;
	b=RsIxO76qBJhkUwxYZzk0EZmrqcaXa6TGwgA9yhn1OFnCCiX+vM+Rjaet+sA3uKeW9jlZ/I
	YBMnet4OmVvC4HTj6h/wnH7MYzNejU6crko2WY9cTsYBBoXSculbnI6VxD5vuywJMLxB/U
	R/4qj7RNq2IEbkjCawwFidS20dNbgEVMAGAXFz/omasMc+CG083Isx332CmP43Jfadj9g9
	TPSogDBLLteOTLyeXKBPzsuI7OQzFL1wh9HQQmLRIFcuWN2tJHQxMN2A+c2w2mWzrsmmTU
	ZDPHZzZd+FyBYF49M9X+4c8QLLYEuAF5274MdsPgJ9xbOMBsVZTqS/pSx4CeJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715173219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPhuL3UM5yIxpg2EhK/QKw4q/Os8hXdmW0AhRhBQxVo=;
	b=VILWxv3YDTYeJXbdLujOFah1LUVELZzQ+nIsfI2L9cDhNN6gHXB3rv+AeLxvQ+tCbKQfk1
	jIIj9Aev4bV2EzAw==
To: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, platform-driver-x86@vger.kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, tony.luck@intel.com, ashok.raj@intel.com,
 jithu.joseph@intel.com, chang.seok.bae@intel.com
Subject: Re: [PATCH v2 1/2] x86/fpu: Extend kernel_fpu_begin_mask() to
 initialize AMX state
In-Reply-To: <20240507235344.249103-2-chang.seok.bae@intel.com>
References: <20240430212508.105117-1-chang.seok.bae@intel.com>
 <20240507235344.249103-1-chang.seok.bae@intel.com>
 <20240507235344.249103-2-chang.seok.bae@intel.com>
Date: Wed, 08 May 2024 15:00:18 +0200
Message-ID: <87y18ko3vh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 07 2024 at 16:53, Chang S. Bae wrote:
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 1209c7aebb21..04cc6f14ca42 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -440,6 +440,9 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
>  
>  	if (unlikely(kfpu_mask & KFPU_387) && boot_cpu_has(X86_FEATURE_FPU))
>  		asm volatile ("fninit");
> +
> +	if (unlikely(kfpu_mask & KFPU_AMX) && boot_cpu_has(X86_FEATURE_AMX_TILE))

  cpu_feature_enabled() please

> +		restore_fpregs_from_fpstate(&init_fpstate, XFEATURE_MASK_XTILE);
>  }
>  EXPORT_SYMBOL_GPL(kernel_fpu_begin_mask);

