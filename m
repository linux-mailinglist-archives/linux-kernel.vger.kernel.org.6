Return-Path: <linux-kernel+bounces-317134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FA796D9B6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DCF6B24C02
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EC519B5BB;
	Thu,  5 Sep 2024 13:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="qVxA64tz"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC06B83CC1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725541438; cv=none; b=cFpQZGlm9TPzjqwoCSTEtkX1sQf2gYOHBtx/LOItPshrF82pRqoQz3lfmQhQ5bJyX1ZAuMFco2eL9YI0WFIbrxJPUATjXM03mcj0mVkhKvp5XYQr6jiq8yIPSk7isOFvrho0HXnLEv6TI0tVInwTQ+w0QQLTY+UpmZEsQZxGBQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725541438; c=relaxed/simple;
	bh=/UZauUobr63bvDNFETdIEPRKlA+u7hPCi07/Fdpy3v4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XnWofEoVGZIe8Uz0tH7j8xt65w/Rmvv2p0U/uBip8SuWfGiWEiEdvckhz1nr6cJqjFQMCUMf1Fw9NbMvQaaYewYB0LRrZuMXA1qr+MBrq5ECcXuujG3LRRUy5/Nh76cExROy8PwxtG0JApN/ePc0MptJjExp65OR1L3li9OQVmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=qVxA64tz; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1725541433;
	bh=RXRwmdIw2hmujIu+zOU3bMrotz29NiEUkMEbFdyrSEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qVxA64tzjJkTa4KIhbNdHQZLZSYP5jVH+TbDzUfI1Z67UCCZGjo4ErcXqMrmgHsZ5
	 1gxnnq4fGLeSjR+CvesYrxURi1Oooo5wlsJwLDj1fidxwmB1BY+IqAULqcSr1Zp30m
	 2+VREPlHs1sf3f/BT0e39xqeCW2kL6tHZflax9sOHK/2d3SA++9Y/4cFpSMuknuYOe
	 aTn4nKhD+dXRvBRk/PEryq6Y6PBZ0xDyV3C7+tppU8iCGwxnUPKwNJZOXC6T2K4GBS
	 mOhZbYqa6BTt28B8wmS7Yfa/e3msGZswJaQXg97IjrfGWcewBqKKCB8FATVviDYt8j
	 MwJPuOW84uewA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4X00153jJGz4w2N;
	Thu,  5 Sep 2024 23:03:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Narayana Murty N <nnmlinux@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, naveen@kernel.org, vaibhav@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com
Subject: Re: [PATCH v2] powerpc/pseries/eeh: Fix pseries_eeh_err_inject
In-Reply-To: <20240823151158.92602-1-nnmlinux@linux.ibm.com>
References: <20240823151158.92602-1-nnmlinux@linux.ibm.com>
Date: Thu, 05 Sep 2024 23:03:53 +1000
Message-ID: <877cbq5k1y.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Narayana Murty N <nnmlinux@linux.ibm.com> writes:
> VFIO_EEH_PE_INJECT_ERR ioctl is currently failing on pseries
> due to missing implementation of err_inject eeh_ops for pseries.
> This patch implements pseries_eeh_err_inject in eeh_ops/pseries
> eeh_ops. Implements support for injecting MMIO load/store error
> for testing from user space.
>
> The check on PCI error type code is moved to platform code, since
> the eeh_pe_inject_err can be allowed to more error types depending
> on platform requirement.
>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>
> Testing:
> ========
> vfio-test [1] by Alex Willamson, was forked and updated to add
> support inject error on pSeries guest and used to test this
> patch[2].
>
> References:
> ===========
> [1] https://github.com/awilliam/tests
> [2] https://github.com/nnmwebmin/vfio-ppc-tests/tree/vfio-ppc-ex
>
> ================
> Changelog:
> V1:https://lore.kernel.org/all/20240822082713.529982-1-nnmlinux@linux.ibm.com/
> - Resolved build issues for ppc64|le_defconfig by moving the
> pseries_eeh_err_inject() definition outside of the CONFIG_PCI_IOV
> code block.
> - New eeh_pe_inject_mmio_error wrapper function added to avoid
> CONFIG_EEH is not set.
 
I don't see why that's necessary?

It's only called from eeh_pseries.c, which is only built for
PPC_PSERIES, and when PPC_PSERIES=y, EEH is always enabled.

> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index 91a9fd53254f..8da6b047a4fe 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -308,7 +308,7 @@ int eeh_pe_reset(struct eeh_pe *pe, int option, bool include_passed);
>  int eeh_pe_configure(struct eeh_pe *pe);
>  int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
>  		      unsigned long addr, unsigned long mask);
> -
> +int eeh_pe_inject_mmio_error(struct pci_dev *pdev);
>  /**
>   * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
>   *
> @@ -338,6 +338,10 @@ static inline int eeh_check_failure(const volatile void __iomem *token)
>  	return 0;
>  }
>  
> +static inline int eeh_pe_inject_mmio_error(struct pci_dev *pdev)
> +{
> +	return -ENXIO;
> +}
>  #define eeh_dev_check_failure(x) (0)
>  
>  static inline void eeh_addr_cache_init(void) { }
> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> index d03f17987fca..49ab11a287a3 100644
> --- a/arch/powerpc/kernel/eeh.c
> +++ b/arch/powerpc/kernel/eeh.c
> @@ -1537,10 +1537,6 @@ int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
>  	if (!eeh_ops || !eeh_ops->err_inject)
>  		return -ENOENT;
>  
> -	/* Check on PCI error type */
> -	if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
> -		return -EINVAL;
> -
 
The change log should mention why it's OK to remove these checks. You
add the same checks in pseries_eeh_err_inject(), but what about
pnv_eeh_err_inject() ?

It is OK AFAICS, because pnv_eeh_err_inject() already contains
equivalent checks, but you should spell that out.

cheers

