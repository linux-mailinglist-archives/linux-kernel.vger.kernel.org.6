Return-Path: <linux-kernel+bounces-298469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A9195C7B0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 109A1B273F6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B77143889;
	Fri, 23 Aug 2024 08:13:20 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC84814037D;
	Fri, 23 Aug 2024 08:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400800; cv=none; b=pHESYsVGDuVfSv6TWsf8sqWxZrmZWSQK0jUduxqpgiEkaRX+KkZ60GDIGedJXkQKHwEQaoLQ61gocM5/trHQoUuzo5H1Th45W375X4Fze01aBlNEsIuIU7TfKbcl+6UFa32xKnyh3hv9bhpGHu8W87jXC8KSbhJR3RpLKF5nl4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400800; c=relaxed/simple;
	bh=HxhFNtilSIPh5wI6uhbsIJVEf/OZp8B8D4CDt/4neGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgYeGwVuLpuzv1KqMdrtFxG0nouUn6CynEZpv9kr8XkpLukneFWlvWeAH0ZD1J/AJl3kscEeepuePauvUsL8BRLY/KGrl3/dIvGgOGu6+gogXwSaCjZnw6kzXAQRpG4liWxuxLpQNibnWlXX1sAkPPpeAZ05gZuJu/A/XPHxywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqt9n3CkCz9sSH;
	Fri, 23 Aug 2024 10:13:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bNfUo6B625yI; Fri, 23 Aug 2024 10:13:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqt9j1hkdz9rvV;
	Fri, 23 Aug 2024 10:13:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 28D608B763;
	Fri, 23 Aug 2024 10:13:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id k0vxfPwkghgE; Fri, 23 Aug 2024 10:13:13 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 871CB8B783;
	Fri, 23 Aug 2024 10:13:12 +0200 (CEST)
Message-ID: <58da9d56-4642-409c-9375-1f0b28ce2af7@csgroup.eu>
Date: Fri, 23 Aug 2024 10:13:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/36] soc: fsl: cpm1: qmc: Handle RPACK initialization
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-30-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-30-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> Current code handles the CPM1 version of QMC, RPACK does not need to
> be initialized. This is not the case in the QUICC Engine (QE) version.
> 
> In preparation of the support for QE, initialize the RPACK register
> when the receiver is initialized and each time it is restarted.
> 
> This additional RPACK initialization has no impact in the CPM1 version
> of QMC.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
>   drivers/soc/fsl/qe/qmc.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index 272da250a763..63af2608c3cd 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -221,6 +221,7 @@ struct qmc_data {
>   	u32 zistate; /* Initial ZISTATE value */
>   	u32 zdstate_hdlc; /* Initial ZDSTATE value (HDLC mode) */
>   	u32 zdstate_transp; /* Initial ZDSTATE value (Transparent mode) */
> +	u32 rpack; /* Initial RPACK value */
>   };
>   
>   struct qmc {
> @@ -552,6 +553,7 @@ int qmc_chan_read_submit(struct qmc_chan *chan, dma_addr_t addr, size_t length,
>   	/* Restart receiver if needed */
>   	if (chan->is_rx_halted && !chan->is_rx_stopped) {
>   		/* Restart receiver */
> +		qmc_write32(chan->s_param + QMC_SPE_RPACK, chan->qmc->data->rpack);
>   		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE,
>   			    chan->mode == QMC_TRANSPARENT ?
>   				chan->qmc->data->zdstate_transp :
> @@ -980,6 +982,7 @@ static int qmc_chan_start_rx(struct qmc_chan *chan)
>   	}
>   
>   	/* Restart the receiver */
> +	qmc_write32(chan->s_param + QMC_SPE_RPACK, chan->qmc->data->rpack);
>   	qmc_write32(chan->s_param + QMC_SPE_ZDSTATE,
>   		    chan->mode == QMC_TRANSPARENT ?
>   			chan->qmc->data->zdstate_transp :
> @@ -1405,6 +1408,7 @@ static int qmc_setup_chan(struct qmc *qmc, struct qmc_chan *chan)
>   	qmc_write32(chan->s_param + QMC_SPE_TSTATE, chan->qmc->data->tstate);
>   	qmc_write32(chan->s_param + QMC_SPE_RSTATE, chan->qmc->data->rstate);
>   	qmc_write32(chan->s_param + QMC_SPE_ZISTATE, chan->qmc->data->zistate);
> +	qmc_write32(chan->s_param + QMC_SPE_RPACK, chan->qmc->data->rpack);
>   	if (chan->mode == QMC_TRANSPARENT) {
>   		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, chan->qmc->data->zdstate_transp);
>   		qmc_write16(chan->s_param + QMC_SPE_TMRBLR, 60);
> @@ -1544,6 +1548,8 @@ static void qmc_irq_gint(struct qmc *qmc)
>   			/* Restart the receiver if needed */
>   			spin_lock_irqsave(&chan->rx_lock, flags);
>   			if (chan->rx_pending && !chan->is_rx_stopped) {
> +				qmc_write32(chan->s_param + QMC_SPE_RPACK,
> +					    chan->qmc->data->rpack);
>   				qmc_write32(chan->s_param + QMC_SPE_ZDSTATE,
>   					    chan->mode == QMC_TRANSPARENT ?
>   						chan->qmc->data->zdstate_transp :
> @@ -1810,6 +1816,7 @@ static const struct qmc_data qmc_data_cpm1 = {
>   	.zistate = 0x00000100,
>   	.zdstate_hdlc = 0x00000080,
>   	.zdstate_transp = 0x18000080,
> +	.rpack = 0x00000000,
>   };
>   
>   static const struct of_device_id qmc_id_table[] = {

