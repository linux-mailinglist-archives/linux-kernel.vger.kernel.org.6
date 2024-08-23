Return-Path: <linux-kernel+bounces-298472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A166A95C7C0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D9F1F25E64
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7594142E76;
	Fri, 23 Aug 2024 08:14:04 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9855013959D;
	Fri, 23 Aug 2024 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400844; cv=none; b=f1Og4n8np/z6avquzpUj+pGxfgAphDfE8Kusu16ZUlucCT8k8xnO47Ynfl7mByLb5mLzoGQRdxGlS7U2jAe12GQFrDg9asYEZZFTgrzHUqSHQcDjYWNK1PNNKp4nsd9edsg4WN4uQHnZb9th5Bx/RV8ZLf+4teTY770Zk+tuZdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400844; c=relaxed/simple;
	bh=FkOtL6MG5tkXqyuOgpp/fmLcN8qTskHLprJby0EZ2Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQdwBVUpwdhL8WSGvC5xLNAHUUS9Ak1ftOZ7B5GzTLlFCd6EGh/lCvYfJPlbGnXU4EuYR3vrpiqWLZ/a6PVR3uPpnqfPcHzBOk3o8t0amqiJjZOOZIzUnJr4f2sO84Ot7v+Je8QWY+mywcPZObS91u0TOWaLGkXY2LB9G+SfT9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqtBc70zdz9sRr;
	Fri, 23 Aug 2024 10:14:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pWQFd58JEw5k; Fri, 23 Aug 2024 10:14:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqtBc5jqZz9rvV;
	Fri, 23 Aug 2024 10:14:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B4B008B77D;
	Fri, 23 Aug 2024 10:14:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id izVYcECcDezM; Fri, 23 Aug 2024 10:14:00 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1D23A8B763;
	Fri, 23 Aug 2024 10:14:00 +0200 (CEST)
Message-ID: <d307f378-d025-496b-91b7-2082441813b7@csgroup.eu>
Date: Fri, 23 Aug 2024 10:13:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 32/36] soc: fsl: qe: Add resource-managed muram
 allocators
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-33-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-33-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> Introduce devm_cpm_muram_alloc() and devm_cpm_muram_alloc_fixed(), the
> resource-managed version of cpm_muram_alloc and cpm_muram_alloc_fixed().
> 
> These resource-managed versions simplify the user avoiding the need to
> call cpm_muram_free(). Indeed, the allocated area returned by these
> functions will be automatically freed on driver detach.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/soc/fsl/qe/qe_common.c | 80 ++++++++++++++++++++++++++++++++++
>   include/soc/fsl/qe/qe.h        | 22 +++++++++-
>   2 files changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/qe/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
> index a877347d37d3..02c29f5f86d3 100644
> --- a/drivers/soc/fsl/qe/qe_common.c
> +++ b/drivers/soc/fsl/qe/qe_common.c
> @@ -13,6 +13,7 @@
>    * 2006 (c) MontaVista Software, Inc.
>    * Vitaly Bordug <vbordug@ru.mvista.com>
>    */
> +#include <linux/device.h>
>   #include <linux/genalloc.h>
>   #include <linux/init.h>
>   #include <linux/list.h>
> @@ -187,6 +188,49 @@ void cpm_muram_free(s32 offset)
>   }
>   EXPORT_SYMBOL(cpm_muram_free);
>   
> +static void devm_cpm_muram_release(struct device *dev, void *res)
> +{
> +	s32 *info = res;
> +
> +	cpm_muram_free(*info);
> +}
> +
> +/**
> + * devm_cpm_muram_alloc - Resource-managed cpm_muram_alloc
> + * @dev: Device to allocate memory for
> + * @size: number of bytes to allocate
> + * @align: requested alignment, in bytes
> + *
> + * This function returns a non-negative offset into the muram area, or
> + * a negative errno on failure as cpm_muram_alloc() does.
> + * Use cpm_muram_addr() to get the virtual address of the area.
> + *
> + * Compare against cpm_muram_alloc(), the memory allocated by this
> + * resource-managed version is automatically freed on driver detach and so,
> + * cpm_muram_free() must not be called to release the allocated memory.
> + */
> +s32 devm_cpm_muram_alloc(struct device *dev, unsigned long size,
> +			 unsigned long align)
> +{
> +	s32 info;
> +	s32 *dr;
> +
> +	dr = devres_alloc(devm_cpm_muram_release, sizeof(*dr), GFP_KERNEL);
> +	if (!dr)
> +		return -ENOMEM;
> +
> +	info = cpm_muram_alloc(size, align);
> +	if (info >= 0) {
> +		*dr = info;
> +		devres_add(dev, dr);
> +	} else {
> +		devres_free(dr);
> +	}
> +
> +	return info;
> +}
> +EXPORT_SYMBOL(devm_cpm_muram_alloc);
> +
>   /*
>    * cpm_muram_alloc_fixed - reserve a specific region of multi-user ram
>    * @offset: offset of allocation start address
> @@ -211,6 +255,42 @@ s32 cpm_muram_alloc_fixed(unsigned long offset, unsigned long size)
>   }
>   EXPORT_SYMBOL(cpm_muram_alloc_fixed);
>   
> +/**
> + * devm_cpm_muram_alloc_fixed - Resource-managed cpm_muram_alloc_fixed
> + * @dev: Device to allocate memory for
> + * @offset: offset of allocation start address
> + * @size: number of bytes to allocate
> + *
> + * This function returns a non-negative offset into the muram area, or
> + * a negative errno on failure as cpm_muram_alloc_fixed() does.
> + * Use cpm_muram_addr() to get the virtual address of the area.
> + *
> + * Compare against cpm_muram_alloc_fixed(), the memory allocated by this
> + * resource-managed version is automatically freed on driver detach and so,
> + * cpm_muram_free() must not be called to release the allocated memory.
> + */
> +s32 devm_cpm_muram_alloc_fixed(struct device *dev, unsigned long offset,
> +			       unsigned long size)
> +{
> +	s32 info;
> +	s32 *dr;
> +
> +	dr = devres_alloc(devm_cpm_muram_release, sizeof(*dr), GFP_KERNEL);
> +	if (!dr)
> +		return -ENOMEM;
> +
> +	info = cpm_muram_alloc_fixed(offset, size);
> +	if (info >= 0) {
> +		*dr = info;
> +		devres_add(dev, dr);
> +	} else {
> +		devres_free(dr);
> +	}
> +
> +	return info;
> +}
> +EXPORT_SYMBOL(devm_cpm_muram_alloc_fixed);
> +
>   /**
>    * cpm_muram_addr - turn a muram offset into a virtual address
>    * @offset: muram offset to convert
> diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
> index af793f2a0ec4..629835b6c71d 100644
> --- a/include/soc/fsl/qe/qe.h
> +++ b/include/soc/fsl/qe/qe.h
> @@ -23,6 +23,8 @@
>   #include <linux/of_address.h>
>   #include <linux/types.h>
>   
> +struct device;
> +
>   #define QE_NUM_OF_SNUM	256	/* There are 256 serial number in QE */
>   #define QE_NUM_OF_BRGS	16
>   #define QE_NUM_OF_PORTS	1024
> @@ -93,8 +95,12 @@ int cpm_muram_init(void);
>   
>   #if defined(CONFIG_CPM) || defined(CONFIG_QUICC_ENGINE)
>   s32 cpm_muram_alloc(unsigned long size, unsigned long align);
> +s32 devm_cpm_muram_alloc(struct device *dev, unsigned long size,
> +			 unsigned long align);
>   void cpm_muram_free(s32 offset);
>   s32 cpm_muram_alloc_fixed(unsigned long offset, unsigned long size);
> +s32 devm_cpm_muram_alloc_fixed(struct device *dev, unsigned long offset,
> +			       unsigned long size);
>   void __iomem *cpm_muram_addr(unsigned long offset);
>   unsigned long cpm_muram_offset(const void __iomem *addr);
>   dma_addr_t cpm_muram_dma(void __iomem *addr);
> @@ -106,6 +112,12 @@ static inline s32 cpm_muram_alloc(unsigned long size,
>   	return -ENOSYS;
>   }
>   
> +static inline s32 devm_cpm_muram_alloc(struct device *dev, unsigned long size,
> +				       unsigned long align)
> +{
> +	return -ENOSYS;
> +}
> +
>   static inline void cpm_muram_free(s32 offset)
>   {
>   }
> @@ -116,6 +128,13 @@ static inline s32 cpm_muram_alloc_fixed(unsigned long offset,
>   	return -ENOSYS;
>   }
>   
> +static inline s32 devm_cpm_muram_alloc_fixed(struct device *dev,
> +					     unsigned long offset,
> +					     unsigned long size)
> +{
> +	return -ENOSYS;
> +}
> +
>   static inline void __iomem *cpm_muram_addr(unsigned long offset)
>   {
>   	return NULL;
> @@ -172,7 +191,6 @@ static inline int par_io_data_set(u8 port, u8 pin, u8 val) { return -ENOSYS; }
>   /*
>    * Pin multiplexing functions.
>    */
> -struct device;
>   struct qe_pin;
>   #ifdef CONFIG_QE_GPIO
>   extern struct qe_pin *qe_pin_request(struct device *dev, int index);
> @@ -233,7 +251,9 @@ static inline int qe_alive_during_sleep(void)
>   /* we actually use cpm_muram implementation, define this for convenience */
>   #define qe_muram_init cpm_muram_init
>   #define qe_muram_alloc cpm_muram_alloc
> +#define devm_qe_muram_alloc devm_cpm_muram_alloc
>   #define qe_muram_alloc_fixed cpm_muram_alloc_fixed
> +#define devm_qe_muram_alloc_fixed devm_cpm_muram_alloc_fixed
>   #define qe_muram_free cpm_muram_free
>   #define qe_muram_addr cpm_muram_addr
>   #define qe_muram_offset cpm_muram_offset

