Return-Path: <linux-kernel+bounces-441642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211159ED136
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30882164906
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3006C1DDA15;
	Wed, 11 Dec 2024 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMQuRzB3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D92D1DD0F6;
	Wed, 11 Dec 2024 16:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934137; cv=none; b=a9UXN7cQtn6WpCGSwQ68pVzsW+f88SCnLin3m/fKOXDpaTpOUMJeNf6GR8SM7MY6Gti7hS2kRvKxZqRPvSsHl2TtMNbz4RrQvSQe0RHVvoJL/S/AQwYIfpka8H0mxgNAvBIRlrIYwd9q0iMGcGzc84LVRE5jsAXHmiFv0FL02hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934137; c=relaxed/simple;
	bh=1o4nKAvHbdeD/mN69tGs7tgkNmaWAZnJ3IKqTY1yIi8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3DUGdOgDFMefn8vYsOu4eUcOgUyAo8WT37LPyUKa2XIGrxKEZsZocjQCSm0R5fNS4VD9fQM3+5M5J5U870eT4lW5cufmC3wflJC7modZ1qC70UzvfqrM/DEv1+xBnBJJ1Jbbe712t9+B6XsEAeNRDBsXLb3xJDYFOF3Pn/mEwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMQuRzB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9BDC4CED2;
	Wed, 11 Dec 2024 16:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934137;
	bh=1o4nKAvHbdeD/mN69tGs7tgkNmaWAZnJ3IKqTY1yIi8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sMQuRzB32XkehBIDiJx6QPHK0y7kHVd6CYYeC01SuLDRPOQKu9LL48ckjNB677ODB
	 LJkbbmjOuPxJ3tsxPg6WHIx2ieHzXTJDdY0YT7LS4GYEtR0kj0eTyi+pDwsVIRN8pn
	 2NWDgPn/efDSlvYaBx3z9FN0Pc7i/N7QNB2y06WvdF3hYJn3h3GuDyilNrEfVWWMnJ
	 dxokOJvu55tX6XUSe734hvdxxHcmYpYhr8fTyRuM/0q2+KLk2CIQqfTAfVBrUVkuyc
	 vK0yoXyJoMrkGtu/u9t8Z70frYkfdi9Yriy/dkiQrajZal4ZI2ALdqjHWGrYP9oGu4
	 mxWuFdBl3drKg==
Date: Wed, 11 Dec 2024 17:22:07 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Xiaofei Tan <tanxiaofei@huawei.com>
Cc: <rafael@kernel.org>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <jonathan.cameron@huawei.com>,
 <M.Chehab@huawei.com>, <roberto.sassu@huawei.com>, <shiju.jose@huawei.com>,
 <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH] acpi: Fix hed module initialization order when it is
 built-in
Message-ID: <20241211172207.513957e2@sal.lan>
In-Reply-To: <20241115035014.1339256-1-tanxiaofei@huawei.com>
References: <20241115035014.1339256-1-tanxiaofei@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 15 Nov 2024 11:50:14 +0800
Xiaofei Tan <tanxiaofei@huawei.com> escreveu:

Please always copy my @kernel.org address for upstream work.

> When the module hed is built-in, the init order is determined by
> Makefile order. That order violates expectations. Because the module
> hed init is behind evged. RAS records can't be handled in the
> special time window that evged has initialized while hed not.
> If the number of such RAS records is more than the APEI HEST error
> source number, the HEST resources could be occupied all, and then
> could affect subsequent RAS error reporting.

IMO, it is a lot better to use a late init call. Please see:
	include/linux/init.h

This would be done by, for instance, using late_initcall().

Now, what we have is:

	acpi-y                          += evged.o
	obj-$(CONFIG_ACPI_HED)          += hed.o

Where ACPI_HED being a tri-state.

It sounds to me, that even, with your patch, if you build
HED as a module, you'll still have a problem.

Shouldn't be ACPI_HED be changed from tristate to bool?

Regards,
Mauro

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
> ---
>  drivers/acpi/Makefile | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 61ca4afe83dc..54f60b7922ad 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -15,6 +15,13 @@ endif
>  
>  obj-$(CONFIG_ACPI)		+= tables.o
>  
> +#
> +# The hed.o needs to be in front of evged.o to avoid the problem that
> +# RAS errors cannot be handled in the special time window of startup
> +# phase that evged has initialized while hed not.
> +#
> +obj-$(CONFIG_ACPI_HED)		+= hed.o
> +
>  #
>  # ACPI Core Subsystem (Interpreter)
>  #
> @@ -95,7 +102,6 @@ obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
>  obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
>  obj-$(CONFIG_ACPI_SBS)		+= sbshc.o
>  obj-$(CONFIG_ACPI_SBS)		+= sbs.o
> -obj-$(CONFIG_ACPI_HED)		+= hed.o
>  obj-$(CONFIG_ACPI_EC_DEBUGFS)	+= ec_sys.o
>  obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o

