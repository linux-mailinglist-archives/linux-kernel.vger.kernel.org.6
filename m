Return-Path: <linux-kernel+bounces-570920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DA2A6B646
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7350119C0CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED761EFFB9;
	Fri, 21 Mar 2025 08:50:06 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE2A1E571A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547005; cv=none; b=bn6UJ/XYiTtVLLddLouFFKp9P/mdxCN0DKdWZh2aITXEva9wXdGiG5EuglotCDGA3h8XDxDqhAzrN4WqF3gDLsOh/3DSOoBezk4ReQir5DNXmicMxDCkA4fV+Aa881A0tA0Xp+0B8kalrTq4pQ+8bC+0APJ+sA74LF/H0jmNgS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547005; c=relaxed/simple;
	bh=Yt2xqwz8bT8+3vtDi7huaR6B5ilaTZyiIYjySeGUU+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APN2MtntMV3dfinKznawhZEBIr9TJc/+kz+bXfC5PeXWqiuNQrTd6CmahLrDbsbUDDcPS/zhW91aT7qlr7AkFUvFV6Zc8cbm8nQbAISxmo6OA7bx6xFNgy2UOsmqWI56hGwtIqkgHTF5lY4uapqH8QaMdy0EdGpzzWvPAwal/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4ZJwwr01Hdz9sTL;
	Fri, 21 Mar 2025 09:44:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3l0nmMf_J-b8; Fri, 21 Mar 2025 09:44:27 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4ZJwwq6BCCz9sSg;
	Fri, 21 Mar 2025 09:44:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BBED18B79C;
	Fri, 21 Mar 2025 09:44:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id oOgqbaLveOw1; Fri, 21 Mar 2025 09:44:27 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 08EA08B763;
	Fri, 21 Mar 2025 09:44:26 +0100 (CET)
Message-ID: <49ecd313-887d-4839-93b1-027f14c26174@csgroup.eu>
Date: Fri, 21 Mar 2025 09:44:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 34/57] irqdomain: soc: Switch to irq_domain_create_*()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, tglx@linutronix.de
Cc: maz@kernel.org, linux-kernel@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>
References: <20250319092951.37667-1-jirislaby@kernel.org>
 <20250319092951.37667-35-jirislaby@kernel.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250319092951.37667-35-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 19/03/2025 à 10:29, Jiri Slaby (SUSE) a écrit :
> irq_domain_add_*() interfaces are going away as being obsolete now.
> Switch to the preferred irq_domain_create_*() ones. Those differ in the
> node parameter: They take more generic struct fwnode_handle instead of
> struct device_node. Therefore, of_fwnode_handle() is added around the
> original parameter.
> 
> Note some of the users can likely use dev->fwnode directly instead of
> indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
> guaranteed to be set for all, so this has to be investigated on case to
> case basis (by people who can actually test with the HW).
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>


Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu> # For soc/fsl

> ---
>   drivers/soc/dove/pmu.c     | 4 ++--
>   drivers/soc/fsl/qe/qe_ic.c | 4 ++--
>   drivers/soc/qcom/smp2p.c   | 2 +-
>   drivers/soc/qcom/smsm.c    | 2 +-
>   drivers/soc/tegra/pmc.c    | 5 +++--
>   5 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
> index 6202dbcd20a8..cfc0efab27d7 100644
> --- a/drivers/soc/dove/pmu.c
> +++ b/drivers/soc/dove/pmu.c
> @@ -274,8 +274,8 @@ static int __init dove_init_pmu_irq(struct pmu_data *pmu, int irq)
>   	writel(0, pmu->pmc_base + PMC_IRQ_MASK);
>   	writel(0, pmu->pmc_base + PMC_IRQ_CAUSE);
>   
> -	domain = irq_domain_add_linear(pmu->of_node, NR_PMU_IRQS,
> -				       &irq_generic_chip_ops, NULL);
> +	domain = irq_domain_create_linear(of_fwnode_handle(pmu->of_node), NR_PMU_IRQS,
> +					  &irq_generic_chip_ops, NULL);
>   	if (!domain) {
>   		pr_err("%s: unable to add irq domain\n", name);
>   		return -ENOMEM;
> diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
> index bbae3d39c7be..e5831c298ad6 100644
> --- a/drivers/soc/fsl/qe/qe_ic.c
> +++ b/drivers/soc/fsl/qe/qe_ic.c
> @@ -446,8 +446,8 @@ static int qe_ic_init(struct platform_device *pdev)
>   		high_handler = NULL;
>   	}
>   
> -	qe_ic->irqhost = irq_domain_add_linear(node, NR_QE_IC_INTS,
> -					       &qe_ic_host_ops, qe_ic);
> +	qe_ic->irqhost = irq_domain_create_linear(of_fwnode_handle(node), NR_QE_IC_INTS,
> +						  &qe_ic_host_ops, qe_ic);
>   	if (qe_ic->irqhost == NULL) {
>   		dev_err(dev, "failed to add irq domain\n");
>   		return -ENODEV;
> diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
> index a3e88ced328a..8c8878bc87f5 100644
> --- a/drivers/soc/qcom/smp2p.c
> +++ b/drivers/soc/qcom/smp2p.c
> @@ -399,7 +399,7 @@ static int qcom_smp2p_inbound_entry(struct qcom_smp2p *smp2p,
>   				    struct smp2p_entry *entry,
>   				    struct device_node *node)
>   {
> -	entry->domain = irq_domain_add_linear(node, 32, &smp2p_irq_ops, entry);
> +	entry->domain = irq_domain_create_linear(of_fwnode_handle(node), 32, &smp2p_irq_ops, entry);
>   	if (!entry->domain) {
>   		dev_err(smp2p->dev, "failed to add irq_domain\n");
>   		return -ENOMEM;
> diff --git a/drivers/soc/qcom/smsm.c b/drivers/soc/qcom/smsm.c
> index e803ea342c97..021e9d1f61dc 100644
> --- a/drivers/soc/qcom/smsm.c
> +++ b/drivers/soc/qcom/smsm.c
> @@ -456,7 +456,7 @@ static int smsm_inbound_entry(struct qcom_smsm *smsm,
>   		return ret;
>   	}
>   
> -	entry->domain = irq_domain_add_linear(node, 32, &smsm_irq_ops, entry);
> +	entry->domain = irq_domain_create_linear(of_fwnode_handle(node), 32, &smsm_irq_ops, entry);
>   	if (!entry->domain) {
>   		dev_err(smsm->dev, "failed to add irq_domain\n");
>   		return -ENOMEM;
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 51b9d852bb6a..e0d67bfe955c 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -2500,8 +2500,9 @@ static int tegra_pmc_irq_init(struct tegra_pmc *pmc)
>   	pmc->irq.irq_set_type = pmc->soc->irq_set_type;
>   	pmc->irq.irq_set_wake = pmc->soc->irq_set_wake;
>   
> -	pmc->domain = irq_domain_add_hierarchy(parent, 0, 96, pmc->dev->of_node,
> -					       &tegra_pmc_irq_domain_ops, pmc);
> +	pmc->domain = irq_domain_create_hierarchy(parent, 0, 96,
> +						  of_fwnode_handle(pmc->dev->of_node),
> +						  &tegra_pmc_irq_domain_ops, pmc);
>   	if (!pmc->domain) {
>   		dev_err(pmc->dev, "failed to allocate domain\n");
>   		return -ENOMEM;


