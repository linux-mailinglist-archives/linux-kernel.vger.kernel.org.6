Return-Path: <linux-kernel+bounces-523772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F19D9A3DB01
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C57A7A626D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714FA1F8670;
	Thu, 20 Feb 2025 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="eFsd9nWv"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42E43C3C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057230; cv=none; b=DymX305e8HhMRzVYxJEMPdpIrCCQ6T2Od+cjErtSoW20HTFjeSCfa/zMGOGExsx2uYcXg5OQ03MK40p+wAWh4GgabR62G6uXkjNy4zFOU1BLAythulYiMHU+QTX4hIZJrV5qZyz+YpPNoiMnXIhdzqioIuRLX+jrVOIBbnXrT2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057230; c=relaxed/simple;
	bh=zgle9CkTdgmTkE8vQAPkindwi88AxR8vCiCMOn6LD7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5IAioIaS4tqmE9lBzv7l1erazVnTztsxF+P9hx1XXAUMYUMLSidzlUcplA7bNHRJ0OvJIydfrNk0/zjgYGZc/9skPKkHyoWPNcl0Hgesm94oXDirsuo/2++kTcnyI88sbR7vs0Fp3rkZQ3MBhRkN5NrN/pD594MLDq1pOiSG+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=eFsd9nWv; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 339AE240103
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:13:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1740057220; bh=zgle9CkTdgmTkE8vQAPkindwi88AxR8vCiCMOn6LD7U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:From;
	b=eFsd9nWvXJX3p7Juqu2She/EHq8UFMWm+ZDyTBQgu8l3vcr46U8YctQGoaxNyXqPX
	 om67Mv6ceGxhTw9qC6CyjAIAdrKZvCwZNCXm9w3QAk5lvfR1cwwlVfKSoaRYSlItdy
	 3/ZmVtw8REzp6j5y4hbVx+XCqfsyJP/K9QbddZMrp1K0cdMTjQ+PkBhMhbOOMX3HCK
	 Q1hX6QxVhzhksmBe+3aJe4L0jkOresYkdaR3CU5wNIK2AjTjd+3/V5XYdIXvrBdQ0n
	 a2E876V/G+dPrGfUlN2I7fNSjCF6k0A3hLKnfxwnYJxNSWYkV2sawzWvtVjaZzsJ3Q
	 YNvWsKb0r7MNQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4YzDGn6MP7z6tvk;
	Thu, 20 Feb 2025 14:13:37 +0100 (CET)
Date: Thu, 20 Feb 2025 13:13:37 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: j.ne@posteo.net
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/fsl_lbc: Explicitly populate bus
Message-ID: <Z7cqgbullhR47Bb-@probook>
References: <20250209-localbus-v1-1-efcd780153a0@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250209-localbus-v1-1-efcd780153a0@posteo.net>

On Sun, Feb 09, 2025 at 10:58:50PM +0100, J. Neuschäfer via B4 Relay wrote:
> From: "J. Neuschäfer" <j.ne@posteo.net>
> 
> Historically, devicetree nodes representing the Freescale Enhanced
> Local Bus Controller (eLBC) have compatible strings such as:
> 
>     compatible = "fsl,mpc8313-elbc", "fsl,elbc", "simple-bus";
> 
> The "simple-bus" string causes the bus to be populated, and the memory
> devices contained within it to be discovered. The eLBC bus (as
> represented in device trees) differs from a simple-bus in a few ways,
> though:
> 
>  - Addresses are not simple/linear: The first cell of an address is a
>    chip select, the second is an linear address within the space thus
>    selected. Representing 1,0 as 100000000, for example, would decrease
>    readability[1].
>  - It is expected that the devices on a simple-bus "can be accessed
>    directly without additional configuration required"[2], but the eLBC
>    needs some configuration.
> 
> To accommodate devicetrees that declare an eLBC without "simple-bus",
> explicitly populate the bus in the eLBC driver.
> 
> [1]: dtc makes such a suggestion opon encountering an eLBC
> [2]: Quoting the Devicetree Specification Release v0.3
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---

Due to advice from Crystal Wood and Rob Herring[1], I reached the
conclusion that this patch is not necessary.

[1]: https://lore.kernel.org/lkml/Z7ILej_AJYot_wKP@probook/

>  arch/powerpc/sysdev/fsl_lbc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
> index 217cea150987df1e1b5c6dbf9e9a1607dd5ce49b..2007ced997fcf0c7059e5b780893b530764dc8b2 100644
> --- a/arch/powerpc/sysdev/fsl_lbc.c
> +++ b/arch/powerpc/sysdev/fsl_lbc.c
> @@ -20,6 +20,7 @@
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/of_irq.h>
> +#include <linux/of_platform.h>
>  #include <linux/slab.h>
>  #include <linux/sched.h>
>  #include <linux/platform_device.h>
> @@ -336,7 +337,7 @@ static int fsl_lbc_ctrl_probe(struct platform_device *dev)
>  	/* Enable interrupts for any detected events */
>  	out_be32(&fsl_lbc_ctrl_dev->regs->lteir, LTEIR_ENABLE);
>  
> -	return 0;
> +	return devm_of_platform_populate(&dev->dev);
>  
>  err1:
>  	free_irq(fsl_lbc_ctrl_dev->irq[0], fsl_lbc_ctrl_dev);
> 
> ---
> base-commit: 7ccde445dddcca030cd6ed66974bb80915ad9dd5
> change-id: 20250209-localbus-94a6ebb04c12
> 
> Best regards,
> -- 
> J. Neuschäfer <j.ne@posteo.net>
> 
> 

