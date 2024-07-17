Return-Path: <linux-kernel+bounces-254681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 117CB933650
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA46282B76
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2CAC2FC;
	Wed, 17 Jul 2024 05:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2UYQaE3i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E359B665
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 05:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721193414; cv=none; b=PwTSc/6c8ZiCYirVfddUb9GSejt8aHgHYzexf5cavRZSvufGsNrQ1QKIQ7pekQhXReCigQorMU2bWL0nxZa8NX76wG/beFf12duNWzeD2WawhK0auk+X0af7DD5NRNKcemEvvlofuawmr/BvJzk7E10qurxfjp8ifjJNLr3MWo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721193414; c=relaxed/simple;
	bh=JOCPjUMcn8oJKWAJ3lw+r+3f2tR2kGXdRuILs1oHFMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWzvOSjzJ9BOsIIavueg1BILalDgK0pAGK5x4Lq/v/Exwj+wQyzOjqlxysoflhEYdM44sQpQaCclA9fWSuiH22JcPKgi0QqUzZ9l1ZlB8MWPS1fl9CDD8di0OUk5rxHlGg+3//KvD+/cv8QXLdmFagn30VrxsKlFdo30AXjlyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2UYQaE3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A1BC32782;
	Wed, 17 Jul 2024 05:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721193414;
	bh=JOCPjUMcn8oJKWAJ3lw+r+3f2tR2kGXdRuILs1oHFMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2UYQaE3iEgVhjHM1bk2kIfpJBEJ5NiLgesSiNxRgX+kUGCKMao4S96mkJNkb4ndcZ
	 MXjKstp9w2KgAAWpyifDIucD7/Qj1sMrL2DiGU+iNOawTSDb9N0Lv4iuOjPkdtRXVD
	 QasOSfDxJpwjQh7okVfqy3Moto4Gv2EECJlHTqlk=
Date: Wed, 17 Jul 2024 07:16:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vamsi Attunuru <vattunuru@marvell.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, nathan@kernel.org,
	quic_jjohnson@quicinc.com
Subject: Re: [PATCH] misc: mrvl-cn10k-dpi: resolve compilation issues on
 32-bit ARM
Message-ID: <2024071709-nephew-scooter-5c6b@gregkh>
References: <20240717045225.138799-1-vattunuru@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717045225.138799-1-vattunuru@marvell.com>

On Tue, Jul 16, 2024 at 09:52:25PM -0700, Vamsi Attunuru wrote:
> Upon adding CONFIG_ARCH_THUNDER & CONFIG_COMPILE_TEST dependency,
> compilation errors arise on 32-bit ARM with writeq() & readq() calls
> which are used for accessing 64-bit values.
> 
> Patch utilizes CONFIG_64BIT checks to define appropriate calls
> for accessing 64-bit values.
> 
> Fixes: a5e43e2d202d ("misc: Kconfig: add a new dependency for MARVELL_CN10K_DPI")
> Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> ---
>  drivers/misc/mrvl_cn10k_dpi.c | 47 ++++++++++++++++++++++++++++++++---
>  1 file changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/mrvl_cn10k_dpi.c b/drivers/misc/mrvl_cn10k_dpi.c
> index 7d5433121ff6..8d24dd6b421b 100644
> --- a/drivers/misc/mrvl_cn10k_dpi.c
> +++ b/drivers/misc/mrvl_cn10k_dpi.c
> @@ -13,6 +13,9 @@
>  #include <linux/pci.h>
>  #include <linux/irq.h>
>  #include <linux/interrupt.h>
> +#ifndef CONFIG_64BIT
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#endif

Are you sure the #ifndef is needed for this include file?

>  
>  #include <uapi/misc/mrvl_cn10k_dpi.h>
>  
> @@ -185,6 +188,8 @@ struct dpi_mbox_message {
>  	uint64_t word_h;
>  };
>  
> +#ifdef CONFIG_64BIT
> +
>  static inline void dpi_reg_write(struct dpipf *dpi, u64 offset, u64 val)
>  {
>  	writeq(val, dpi->reg_base + offset);
> @@ -195,6 +200,40 @@ static inline u64 dpi_reg_read(struct dpipf *dpi, u64 offset)
>  	return readq(dpi->reg_base + offset);
>  }
>  
> +static inline void dpi_writeq(u64 val, void __iomem *addr)
> +{
> +	writeq(val, addr);
> +}
> +
> +static inline u64 dpi_readq(const void __iomem *addr)
> +{
> +	return readq(addr);
> +}
> +
> +#else

Normally we do not like #ifdef in .c files, are you sure this is the
correct way to handle this?

thanks,

greg k-h

