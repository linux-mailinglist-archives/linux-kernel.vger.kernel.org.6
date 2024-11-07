Return-Path: <linux-kernel+bounces-399772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8EB9C03FD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A51B23397
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791D3200125;
	Thu,  7 Nov 2024 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="lIEIxhXW"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3E4200132
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978977; cv=none; b=B3VTPCtUXrHZVrp/7arpo7tCVphZMHw1xRajFZWCVmJ7w2yhhXEcP6CNOnCfEtBfMptHnyGUVbqDgrIdPLLnfCpwyhetm6jWlU7mZ6mnbvrjApVjO1A53AlS7YMsNDnZCerqhdRQxaGhZmSF35qJrWb6UW5a9sExIgYtOAzJrn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978977; c=relaxed/simple;
	bh=Y+E+oJPmW3y1BzJ2os8q7ckXlis6FAbEtly1hlfqQjg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DTdEhD5H74hsQEwIh99qSatF3S2NTVkNgCsDriadb+jAlpLakoE9hkEqTfSvh87SpQRvNghxr3YmKS7Z+dNOd0au4LoKSaR3Y6+2u9URsP8/V1zn8ahD5YXXD4+Np4oSYeACInIe+2YMwssSohck1vKQoN4+MDWnjGFewSwuh/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=lIEIxhXW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730978971;
	bh=nrjbtAPdhIcAlgAV7NujXI6QsiUwiA3bnjCu+yPjnXY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lIEIxhXWsTbljLBFi7X0QovZJjQVTZ26Df6phbYHs3YG380sHO08erH3WYcn4Mw9V
	 2MGy44pxqPNu61obgb+FVTsxZ0bTMPgE7OlLcj8b5d69BzS2N37o+euibIQyxSlFC4
	 +wtVWFN0o8hqkyuf6dtRIPl6bnerOS0WGJeknORV+r5x0dsJ6iHmgXXO/77etoOeDu
	 nspWpHHIgQx/CXiKiwWHeZDYTU7jIcLF5m9ALYokd3n/U5LUVsS5OtjPLx/SkQ/RKK
	 2yHARHBPE3OkbFtPRnUrmMwI+kZtSdlFgc0jXWDDqshkRHLD/sm73EiJKb+1rAAQBm
	 rnhVtwfjOZpPg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xkfx66dngz4wcj;
	Thu,  7 Nov 2024 22:29:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Yang Li <yang.lee@linux.alibaba.com>, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Yang Li
 <yang.lee@linux.alibaba.com>, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] powerpc/machdep: Remove duplicated include in svm.c
In-Reply-To: <20241107010259.46308-1-yang.lee@linux.alibaba.com>
References: <20241107010259.46308-1-yang.lee@linux.alibaba.com>
Date: Thu, 07 Nov 2024 22:29:32 +1100
Message-ID: <87msibcmeb.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yang Li <yang.lee@linux.alibaba.com> writes:
> The header files linux/mem_encrypt.h is included twice in svm.c,
> so one inclusion of each can be removed.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11750
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/powerpc/platforms/pseries/svm.c | 1 -
>  1 file changed, 1 deletion(-)

The two includes only appear in linux-next, and they both come from
different trees. They are required in each tree to avoid breaking the
build.

So no one can merge this patch until the two trees are merged into mainline.

cheers

> diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
> index c5d0f92c7969..384c9dc1899a 100644
> --- a/arch/powerpc/platforms/pseries/svm.c
> +++ b/arch/powerpc/platforms/pseries/svm.c
> @@ -10,7 +10,6 @@
>  #include <linux/memblock.h>
>  #include <linux/mem_encrypt.h>
>  #include <linux/cc_platform.h>
> -#include <linux/mem_encrypt.h>
>  #include <asm/machdep.h>
>  #include <asm/svm.h>
>  #include <asm/swiotlb.h>
> -- 
> 2.32.0.3.g01195cf9f

