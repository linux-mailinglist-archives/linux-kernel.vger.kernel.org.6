Return-Path: <linux-kernel+bounces-217216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6147090ACEE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54C9DB24A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BC2194AC3;
	Mon, 17 Jun 2024 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="DFUwqRo8"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C311946BF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718623714; cv=none; b=usB4VA9er8XgZR/jrxjfqhwD8jy+FrZK2FnFChk4V1jfktrZxLlA09Z90Tw78iwznxfoeu0A+6cDDt1cTr/6mmWDIb4ogIVs849eiExk3HIH1M/A8ogCE09h56twVB8n+BE/Qmv97EGGNQj7+k8zukSAFVk3QO7VXID3Aj62uq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718623714; c=relaxed/simple;
	bh=ALlaYV7IX5QfttmBRFxf4LFufdBkr2eW6Ax1VslEm38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BxA+M0C41inUVjtgi/+DJjFvmnPlW7cpSD42CHX4xbq93HzYczsS17RC183LDnMql0IpBXSRd46oUr8ZPtcWPxrM74MJgDenv6LfkrGvxhOQHwsRY6w1k4PZrAZ9f0sK3+FgCvYKRpvNCvbIzSbJ4+PNnHCPoVY9VOiBDfa4834=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=DFUwqRo8; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1718623703;
	bh=xN/bQdiQ7QunPgDWnHIxIsBeNMFeFeDKxugA/ptH56U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DFUwqRo8lcJWUK+iQILpyWm7Uf2kMXYORMEAw7xtKE6RbkO+HT1vSn17XJfPwP6xG
	 2B60u0Wh7t/j+3Lf9t3Pu08WpR3gAR24pUEbSmdo1Ms0FQpB3s7+4YamWeBSMC7eZU
	 85rj2ZE9XVQH9sGLrBHaebuBD9BcLHMtvhXe0hOLheXirfTiB69DJ85MlhpEuaPLBj
	 N8dwAk8ItVnZuQ1qoLi1AiWqVcPhNzaTq5czCuzqFOw5FoWxdr7nfv3JRLbUn4zg+k
	 UmeG2fx+AZ2mgZWkNDfazHRRDMULpVv+iWIXVqGf/ImDCMmB+8JIMnSGYRLD/m8pA8
	 xuyYF13tZkyJw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W2ngp42kZz4wb1;
	Mon, 17 Jun 2024 21:28:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jinglin Wen <jinglin.wen@shingroup.cn>, npiggin@gmail.com
Cc: christophe.leroy@csgroup.eu, naveen.n.rao@linux.ibm.com,
 masahiroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, jinglin.wen@shingroup.cn
Subject: Re: [PATCH] powerpc: Fixed duplicate copying in the early boot.
In-Reply-To: <20240617023509.5674-1-jinglin.wen@shingroup.cn>
References: <20240617023509.5674-1-jinglin.wen@shingroup.cn>
Date: Mon, 17 Jun 2024 21:28:19 +1000
Message-ID: <87le336c6k.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jinglin Wen <jinglin.wen@shingroup.cn> writes:
> According to the code logic, when the kernel is loaded to address 0,
> no copying operation should be performed, but it is currently being
> done.
>
> This patch fixes the issue where the kernel code was incorrectly
> duplicated to address 0 when booting from address 0.
>
> Signed-off-by: Jinglin Wen <jinglin.wen@shingroup.cn>
> ---
>  arch/powerpc/kernel/head_64.S | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thanks for the improved change log.

The subject could probably still be clearer, maybe:
  Fix unnecessary copy to 0 when kernel is booted at address 0

Looks like this was introduced by:

  Fixes: b270bebd34e3 ("powerpc/64s: Run at the kernel virtual address earlier in boot")
  Cc: stable@vger.kernel.org # v6.4+

Let me know if you think otherwise.

Just out of interest, how are you hitting this bug? AFAIK none of our
"normal" boot loaders will load the kernel at 0. 

> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 4690c219bfa4..6c73551bdc50 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -647,7 +647,9 @@ __after_prom_start:
>   * Note: This process overwrites the OF exception vectors.
>   */
>  	LOAD_REG_IMMEDIATE(r3, PAGE_OFFSET)
> -	mr.	r4,r26			/* In some cases the loader may  */
> +	tophys(r4,r26)
> +	cmplwi	cr0,r4,0	/* runtime base addr is zero */
> +	mr	r4,r26			/* In some cases the loader may */
>  	beq	9f			/* have already put us at zero */
	
That is a pretty minimal fix, but I think the code would be clearer if
we just compared the source and destination addresses.

Something like the diff below. Can you confirm that works for you.

cheers

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 4690c219bfa4..6ad1435303f9 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -647,8 +647,9 @@ __after_prom_start:
  * Note: This process overwrites the OF exception vectors.
  */
 	LOAD_REG_IMMEDIATE(r3, PAGE_OFFSET)
-	mr.	r4,r26			/* In some cases the loader may  */
-	beq	9f			/* have already put us at zero */
+	mr	r4, r26			// Load the source address into r4
+	cmpld	cr0, r3, r4		// Check if source == dest
+	beq	9f			// If so skip the copy
 	li	r6,0x100		/* Start offset, the first 0x100 */
 					/* bytes were copied earlier.	 */
 

