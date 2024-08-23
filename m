Return-Path: <linux-kernel+bounces-298467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 987D495C7AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF5A1C24E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D304F143C5D;
	Fri, 23 Aug 2024 08:12:17 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CBC14387B;
	Fri, 23 Aug 2024 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400737; cv=none; b=B9IxyRmrOUdqALP0FsG0c8v4D4MfVNMYpoyT6+mwQMclfuTbrcpfi61bVwUvXAb+oKF46HWEo0vz2n+Oofh87GGfe62NrZQfCYnsg67spvDckzg6adniDMOW3Fbp2ZaE/UIdC7yAirgjITpyr0mtxhWIh1nT75OBWRKj0JYrh6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400737; c=relaxed/simple;
	bh=78RPg+aV/jDbyHPLnQb7mo4iutKAnBxei2oJBr/z7CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PeEbhnIKgIkw/OB/S7OxKzGEwGpYEILIHot5mnlZFGVeXbTejzqOVRsHNj5VEQSM3Fx5oSZqgQSDmN0OhNaH17+SboOt2OfmfHpNa8vewYF2wsFridr1e5Rn+2T6gbe24kfTZspr2urePT+yBwKHjMC4zkpoUWcFc6nKFFzDCfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqt8Z2Ky9z9sRr;
	Fri, 23 Aug 2024 10:12:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 32SoiF7gwB8l; Fri, 23 Aug 2024 10:12:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqt8Z1NGmz9rvV;
	Fri, 23 Aug 2024 10:12:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1DD3E8B77D;
	Fri, 23 Aug 2024 10:12:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id DnJaPxcKeQj9; Fri, 23 Aug 2024 10:12:14 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 82BE08B763;
	Fri, 23 Aug 2024 10:12:13 +0200 (CEST)
Message-ID: <52bee8b1-1d42-441d-ba90-b7d6eb9163b8@csgroup.eu>
Date: Fri, 23 Aug 2024 10:12:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/36] soc: fsl: cpm1: qmc: Introduce
 qmc_{init,exit}_xcc() and their CPM1 version
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-28-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-28-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> Current code handles the CPM1 version of QMC and initialize the QMC used
> SCC. The QUICC Engine (QE) version uses an UCC (Unified Communication
> Controllers) instead of the SCC (Serial Communication Controllers) used
> in the CPM1 version. These controllers serve the same purpose and are
> used in the same way but their inializations are slightly different.
> 
> In order to prepare the support for QE version of QMC, introduce
> qmc_init_xcc() to initialize theses controllers (UCC in QE and SCC in
> CPM1) and isolate the CPM1 specific SCC initialization in a specific
> function.
> 
> Also introduce qmc_exit_xcc() for consistency to revert operations done
> in qmc_init_xcc().
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/soc/fsl/qe/qmc.c | 66 +++++++++++++++++++++++++++-------------
>   1 file changed, 45 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index eacc7dd2be53..b95227378f97 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -1621,6 +1621,41 @@ static int qmc_init_resources(struct qmc *qmc, struct platform_device *pdev)
>   	return qmc_cpm1_init_resources(qmc, pdev);
>   }
>   
> +static int qmc_cpm1_init_scc(struct qmc *qmc)
> +{
> +	u32 val;
> +	int ret;
> +
> +	/* Connect the serial (SCC) to TSA */
> +	ret = tsa_serial_connect(qmc->tsa_serial);
> +	if (ret)
> +		return dev_err_probe(qmc->dev, ret, "Failed to connect TSA serial\n");
> +
> +	/* Init GMSR_H and GMSR_L registers */
> +	val = SCC_GSMRH_CDS | SCC_GSMRH_CTSS | SCC_GSMRH_CDP | SCC_GSMRH_CTSP;
> +	qmc_write32(qmc->scc_regs + SCC_GSMRH, val);
> +
> +	/* enable QMC mode */
> +	qmc_write32(qmc->scc_regs + SCC_GSMRL, SCC_GSMRL_MODE_QMC);
> +
> +	/* Disable and clear interrupts */
> +	qmc_write16(qmc->scc_regs + SCC_SCCM, 0x0000);
> +	qmc_write16(qmc->scc_regs + SCC_SCCE, 0x000F);
> +
> +	return 0;
> +}
> +
> +static int qmc_init_xcc(struct qmc *qmc)
> +{
> +	return qmc_cpm1_init_scc(qmc);
> +}
> +
> +static void qmc_exit_xcc(struct qmc *qmc)
> +{
> +	/* Disconnect the serial from TSA */
> +	tsa_serial_disconnect(qmc->tsa_serial);
> +}
> +
>   static int qmc_probe(struct platform_device *pdev)
>   {
>   	struct device_node *np = pdev->dev.of_node;
> @@ -1711,29 +1746,18 @@ static int qmc_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	/* Connect the serial (SCC) to TSA */
> -	ret = tsa_serial_connect(qmc->tsa_serial);
> -	if (ret) {
> -		dev_err(qmc->dev, "Failed to connect TSA serial\n");
> +	/* Init SCC */
> +	ret = qmc_init_xcc(qmc);
> +	if (ret)
>   		return ret;
> -	}
>   
> -	/* Init GMSR_H and GMSR_L registers */
> -	qmc_write32(qmc->scc_regs + SCC_GSMRH,
> -		    SCC_GSMRH_CDS | SCC_GSMRH_CTSS | SCC_GSMRH_CDP | SCC_GSMRH_CTSP);
> -
> -	/* enable QMC mode */
> -	qmc_write32(qmc->scc_regs + SCC_GSMRL, SCC_GSMRL_MODE_QMC);
> -
> -	/* Disable and clear interrupts,  set the irq handler */
> -	qmc_write16(qmc->scc_regs + SCC_SCCM, 0x0000);
> -	qmc_write16(qmc->scc_regs + SCC_SCCE, 0x000F);
> +	/* Set the irq handler */
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq < 0)
> -		goto err_tsa_serial_disconnect;
> +		goto err_exit_xcc;
>   	ret = devm_request_irq(qmc->dev, irq, qmc_irq_handler, 0, "qmc", qmc);
>   	if (ret < 0)
> -		goto err_tsa_serial_disconnect;
> +		goto err_exit_xcc;
>   
>   	/* Enable interrupts */
>   	qmc_write16(qmc->scc_regs + SCC_SCCM,
> @@ -1761,8 +1785,8 @@ static int qmc_probe(struct platform_device *pdev)
>   err_disable_intr:
>   	qmc_write16(qmc->scc_regs + SCC_SCCM, 0);
>   
> -err_tsa_serial_disconnect:
> -	tsa_serial_disconnect(qmc->tsa_serial);
> +err_exit_xcc:
> +	qmc_exit_xcc(qmc);
>   	return ret;
>   }
>   
> @@ -1776,8 +1800,8 @@ static void qmc_remove(struct platform_device *pdev)
>   	/* Disable interrupts */
>   	qmc_write16(qmc->scc_regs + SCC_SCCM, 0);
>   
> -	/* Disconnect the serial from TSA */
> -	tsa_serial_disconnect(qmc->tsa_serial);
> +	/* Exit SCC */
> +	qmc_exit_xcc(qmc);
>   }
>   
>   static const struct qmc_data qmc_data_cpm1 = {

