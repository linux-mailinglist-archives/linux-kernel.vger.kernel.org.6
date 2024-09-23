Return-Path: <linux-kernel+bounces-335870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 787B297EBC6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDCCB1F21E44
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0F11990C7;
	Mon, 23 Sep 2024 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nI50L/hP"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264C880C0C
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727096253; cv=none; b=NxSATO78RR0Jhrt/yqWKRvKZ/CMezOXSZtkRhtqIbCKE1Khcr18sdRpLnLRzC70cQEHWbtBSTBEm2cX599th+22HnzRo/rW7QWGh++O/tEzfi8WIToRhfP31AjXlkg6nRmq8NoPzDQyxVRHtQmxgzWCYxYX/kmW80beqPWaJdKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727096253; c=relaxed/simple;
	bh=AGENL3X2WYbv/5PQxx8UPDvRzHUeY5nRRhGT32q77wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COr9JRUAbfPr6UxDHEMI/lXXAfhBX30Sm00aixhaibj1DhPrc60wIxAAtbCDfUAWNoW/iWoPP/P79EL71tdpMtwl5aYJvw8tvn4UJ/cP2wbTZP/L3a/PJjIn8DPH7e+ylelyUjtHk0RPl3Gp/iTYd5WpJYx0ms9KESSbAZ99YYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nI50L/hP; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d889207d1aso2758051a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727096251; x=1727701051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqL+b1FAcrvUWqURWulPmdkzJdVjg5DPzosrsko/fRk=;
        b=nI50L/hPbkNaXUiibbxGaSE1wpXFvwjHaBPVqBbF0553Oxvm4R6RqwEd88P3nHz6Yu
         rjD1yTYEKTBP74T+KsnxdenJxXxe5XfZdmpNl9YmqT+S6A0GrnAGqp7FpZvrZ+RmeUpW
         XuvZ1K2HV3sbZJKATH67SGLIzkFwbd42a5ikugSboXbTWwhboVhFGCRqouvyMbxcpqgt
         dW1AEdWNEc1c62355JqdMBlAmf6f5R6kRoFNIRUXrmOvgjhUm2+/Zx7ADshd79VT4qIP
         Z6nHMxWS8IPFBBSC19vwQfMpnR6tXOiR1h6DQd9zlBrxB3wBnys51PPeglIYbzRpzxfJ
         mO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727096251; x=1727701051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqL+b1FAcrvUWqURWulPmdkzJdVjg5DPzosrsko/fRk=;
        b=lxveRzHoHePYKo4W6dnabL8E10UR/FXvVbvktsr53k6skmsDj7Ni4Rj0tWa+/29CeQ
         ny+FLcyLtZl2e4PPNKWoYXsGO67gXeGNL8wocFQ73gIaFS25wdIAzs8dPpLFB7wsD0j7
         O9kfl4vpH1oTdmfCjvU7AjXP3hFibBbifeQLU+FfCGcTDAlPnMCP5flCpDDpPMdtdprM
         Hxh+wFeh68nHjwCb5Fgs5sz3rOhUMNjgo1JafH807Mkmhoj3rBdm9th+nECbuI1SZ+LW
         aHJk7g9u55pkHRmkXWhSPH3D0WFYc5+jDqXq3VH1N7+hPbzegcR8nxFAsFK8n+3CT5jQ
         THEw==
X-Forwarded-Encrypted: i=1; AJvYcCWKDphJhpN0hjfirWM2v9HecxJ1i/7pbMAZR+iM1LyXqUhcZkUwWJnCTZRXOmBtklh7t3MBl2hXQ9TBMqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy08u3t5we40fLyNRBWW1FHccYBQwhYi3CXSEt50GSfM0iFT4qT
	HwNf+06Do8yeY+1jj+G4C0jV7xwI88Z4YFBeqSXwrRA+dV0EWz/z
X-Google-Smtp-Source: AGHT+IEV/bw2rQotOm5i6ahVAaEb6Gjhc+RLQd1rT1eTdwlbMtsSETLnKOeMvwOJoMo79T1SEG/wMw==
X-Received: by 2002:a17:90a:68c3:b0:2d8:8c82:10a with SMTP id 98e67ed59e1d1-2dd80c465f4mr15200818a91.5.1727096251368;
        Mon, 23 Sep 2024 05:57:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd6ef9858fsm9372570a91.52.2024.09.23.05.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:57:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 23 Sep 2024 05:57:28 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	linux-kernel@vger.kernel.org, mahesh@linux.ibm.com,
	oohall@gmail.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	naveen@kernel.org, vaibhav@linux.ibm.com, ganeshgr@linux.ibm.com,
	sbhat@linux.ibm.com
Subject: Re: [PATCH v3] powerpc/pseries/eeh: Fix pseries_eeh_err_inject
Message-ID: <c474f56f-af74-479d-9db6-fbbfdb287604@roeck-us.net>
References: <20240909140220.529333-1-nnmlinux@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909140220.529333-1-nnmlinux@linux.ibm.com>

Hi,

On Mon, Sep 09, 2024 at 09:02:20AM -0500, Narayana Murty N wrote:
> VFIO_EEH_PE_INJECT_ERR ioctl is currently failing on pseries
> due to missing implementation of err_inject eeh_ops for pseries.
> This patch implements pseries_eeh_err_inject in eeh_ops/pseries
> eeh_ops. Implements support for injecting MMIO load/store error
> for testing from user space.
> 
> The check on PCI error type (bus type) code is moved to platform
> code, since the eeh_pe_inject_err can be allowed to more error
> types depending on platform requirement. Removal of the check for
> 'type' in eeh_pe_inject_err() doesn't impact PowerNV as
> pnv_eeh_err_inject() already has an equivalent check in place.
> 
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> 
> ---
>  arch/powerpc/include/asm/eeh.h               |  2 +-
>  arch/powerpc/kernel/eeh.c                    |  9 +++--
>  arch/powerpc/platforms/pseries/eeh_pseries.c | 39 +++++++++++++++++++-
>  3 files changed, 44 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index 91a9fd53254f..317b12fc1fe4 100644
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
>  	/* Check on PCI error function */
>  	if (func < EEH_ERR_FUNC_MIN || func > EEH_ERR_FUNC_MAX)
>  		return -EINVAL;
> @@ -1851,6 +1847,11 @@ static const struct file_operations eeh_dev_break_fops = {
>  	.read   = eeh_debugfs_dev_usage,
>  };
>  
> +int eeh_pe_inject_mmio_error(struct pci_dev *pdev)
> +{
> +	return eeh_debugfs_break_device(pdev);
> +}
> +

The new function, as the context suggests, is only compiled if CONFIG_DEBUG_FS=y.
However, it is called unconditionally. With CONFIG_DEBUG_FS=n, this results in

powerpc64-linux-ld: arch/powerpc/platforms/pseries/eeh_pseries.o: in function `pseries_eeh_err_inject':
/opt/buildbot/slave/qemu-ppc64/build/arch/powerpc/platforms/pseries/eeh_pseries.c:814:(.text+0x554): undefined reference to `eeh_pe_inject_mmio_error'
make[3]: *** [/opt/buildbot/slave/qemu-ppc64/build/scripts/Makefile.vmlinux:34: vmlinux] Error 1
make[2]: *** [/opt/buildbot/slave/qemu-ppc64/build/Makefile:1157: vmlinux] Error 2

I'll enable CONFIG_DEBUG_FS in my tests and won't report this further,
but you might want to consider fixing the problem at some point.

Guenter

