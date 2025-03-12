Return-Path: <linux-kernel+bounces-558218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AA4A5E2E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DF8A7A7A13
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB4823F369;
	Wed, 12 Mar 2025 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="wPqmwTpG"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273981D63D5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800945; cv=none; b=otvUev3rg2sCDRdknL4oL3W13gLhEt4fF3Wvb5LWZ+4r/2oawCRdXhhJTwE5jKO1wizOHIafFadvgOSxTIBRq2FPuVhmL+AdiGIB9TfknWJfXl3JAVq+WTk7Ry0dXSPUiDRvzSlNBRvfFhI8V9MQOn8MPUP3fT3xzxZbPTGXWCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800945; c=relaxed/simple;
	bh=4qkLX++lFyjNleliVYwoolACCiGvD8umAZsZrlCBTo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reWj/U2SIcTwBZsrAXWGjMDnXTWPa8hY6MIE/kQCAal0gLXCNAEppCe4qeEthwUP4OQQT9aQpQyVTa1wbpev+qZxxE1EzmYc01Gg+kYTpfuWTuVQMuqzzdlbMnW2L3Mt8aKeU8d51z6cnpYzXF0krRkVrvKlXyRajKwjmc4F1NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=wPqmwTpG; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1741800941;
	bh=4qkLX++lFyjNleliVYwoolACCiGvD8umAZsZrlCBTo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wPqmwTpGdXOJqNv6lNDC51+hi+V6v31jtUzUQaIUIa26vodfgzFLXMkG8S2bGxeS6
	 ZstdwCfijI4FKsp8uIEniIzsSvjG7Wte+xt5bM80cmHysGmp8RkQo3dcK4F8LOmrg3
	 ZWnOK6QXRUtB0Iu6/XnwpXG55kBAbi/PVZ3BuZyNsWkG2/U0yK+gS/T6KS3h84MszD
	 cl2pqijsDIGpMwksnf0zMGNYrDXMFGaCZg74uhKG4Jv8LfLiEnpyV2gSzPW/9d0Vwn
	 o0JHJOjGOW5ZmEiwzMQ9pHKsKja+8z5Cl3k5c95EvWAE/CO9SSTSyGodTZJMb4T5x4
	 +8xMlqKkgUQGA==
Received: from localhost.localdomain (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4ZCd7x44BDzWnL;
	Wed, 12 Mar 2025 13:35:41 -0400 (EDT)
Date: Wed, 12 Mar 2025 13:35:40 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Kienan Stewart <kstewart@efficios.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>, linux-build@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Nicolas Schier <n.schier@avm.de>
Subject: Re: [PATCH v2] kbuild: Add missing $(objtree) prefix to powerpc
 crtsavres.o artifact
Message-ID: <Z9HF7EtC8lNfJ41e@localhost.localdomain>
References: <20250218-buildfix-extmod-powerpc-v2-1-1e78fcf12b56@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-buildfix-extmod-powerpc-v2-1-1e78fcf12b56@efficios.com>

On 18-Feb-2025 03:26:39 PM, Kienan Stewart wrote:
> In the upstream commit 214c0eea43b2ea66bcd6467ea57e47ce8874191b
> ("kbuild: add $(objtree)/ prefix to some in-kernel build artifacts")
> artifacts required for building out-of-tree kernel modules had
> $(objtree) prepended to them to prepare for building in other
> directories.
> 
> When building external modules for powerpc,
> arch/powerpc/lib/crtsavres.o is required for certain
> configurations. This artifact is missing the prepended $(objtree).

FYI, the issue resolved here breaks the build of LTTng-modules against
recent kernels on powerpc. I would gladly welcome upstreaming of this
fix into the Linux kernel.

Thanks!

Mathieu

> 
> Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
> Acked-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nicolas Schier <n.schier@avm.de>
> Tested-by: Nicolas Schier <n.schier@avm.de>
> Signed-off-by: Kienan Stewart <kstewart@efficios.com>
> ---
> Changes in v2:
> - Added Review-by/Tested-by/Fixes/Acked-By
> - Removed mention of possible work-around for external modules (while
> the build will pass, `make modules_install` will fail)
> - Link to v1: https://lore.kernel.org/r/20250127-buildfix-extmod-powerpc-v1-1-450012b16263@efficios.com
> ---
>  arch/powerpc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index f3804103c56ccfdb16289468397ccaea71bf721e..9933b98df69d7f7b9aaf33d36155cc61ab4460c7 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -58,7 +58,7 @@ ifeq ($(CONFIG_PPC64)$(CONFIG_LD_IS_BFD),yy)
>  # There is a corresponding test in arch/powerpc/lib/Makefile
>  KBUILD_LDFLAGS_MODULE += --save-restore-funcs
>  else
> -KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
> +KBUILD_LDFLAGS_MODULE += $(objtree)/arch/powerpc/lib/crtsavres.o
>  endif
>  
>  ifdef CONFIG_CPU_LITTLE_ENDIAN
> 
> ---
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> change-id: 20250127-buildfix-extmod-powerpc-a744e1331f83
> 
> Best regards,
> -- 
> Kienan Stewart <kstewart@efficios.com>
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

