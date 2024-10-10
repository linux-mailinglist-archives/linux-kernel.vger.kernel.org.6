Return-Path: <linux-kernel+bounces-359888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E03199924D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD478B26910
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF551A303E;
	Thu, 10 Oct 2024 19:13:12 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF841925B6
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587592; cv=none; b=S9bM2yHcJh7CyLO1IU3VPU84CBElydlXO3bGk/p+85sW5IMvoOt2wAMIQLggK+0H68HFOeWc9JHYRrUv9zrWxUkLgs/WnEV5uMCA5tqY8OaimdKQinB1f0zhwZDyLfxE7xSG+SHu8TisoPzGEhXrQk/pV5zzyKoWRHr7nHiHM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587592; c=relaxed/simple;
	bh=ov8LfodgQ9/Vqbu+cAl8XCyVbIANgXdE9rmidk9MTeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKjyxeja9/rIT2plcMmbTR5h56uk9PlQ6t7jpq7IUt/Su2yU1ui3I+qUlhnQga7nl8znLGlL4wX3S7HTgvxfXb1b3net3aOMTU5YLl8mi8U0B+ikWutip0chI/pF50DEoXYrV7B8ukUWe64e3uGE29Rn8NdY0lYj0pF30ZzR+Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 49AIah2T000379;
	Thu, 10 Oct 2024 13:36:43 -0500
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 49AIahkn000376;
	Thu, 10 Oct 2024 13:36:43 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Thu, 10 Oct 2024 13:36:42 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Naveen N Rao <naveen@kernel.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/vdso: Flag VDSO64 entry points as functions
Message-ID: <20241010183642.GF29862@gate.crashing.org>
References: <b6ad2f1ee9887af3ca5ecade2a56f4acda517a85.1728512263.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6ad2f1ee9887af3ca5ecade2a56f4acda517a85.1728512263.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i

On Thu, Oct 10, 2024 at 12:17:57AM +0200, Christophe Leroy wrote:
> On powerpc64 as shown below by readelf, vDSO functions symbols have
> type NOTYPE.

> To overcome that, commit ba83b3239e65 ("selftests: vDSO: fix vDSO
> symbols lookup for powerpc64") was applied to have selftests also
> look for NOTYPE symbols, but the correct fix should be to flag VDSO
> entry points as functions.

> For ABI v2, there is no function descriptors and VDSO functions can
> safely have function type.
> 
> So lets flag VDSO entry points as functions and revert the
> selftest change.

> diff --git a/arch/powerpc/include/asm/vdso.h b/arch/powerpc/include/asm/vdso.h
> index 7650b6ce14c8..8d972bc98b55 100644
> --- a/arch/powerpc/include/asm/vdso.h
> +++ b/arch/powerpc/include/asm/vdso.h
> @@ -25,6 +25,7 @@ int vdso_getcpu_init(void);
>  #ifdef __VDSO64__
>  #define V_FUNCTION_BEGIN(name)		\
>  	.globl name;			\
> +	.type name,@function; 		\
>  	name:				\
>  
>  #define V_FUNCTION_END(name)		\

Ha cool!  Excellent.  Thank you :-)

Reviewed-By: Segher Boessenkool <segher@kernel.crashing.org>


Segher

