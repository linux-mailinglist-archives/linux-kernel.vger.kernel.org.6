Return-Path: <linux-kernel+bounces-298431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440D795C73C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6DE8282268
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367F7537FF;
	Fri, 23 Aug 2024 08:04:06 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEFF13C683;
	Fri, 23 Aug 2024 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400245; cv=none; b=W0aMTjN2fWC5kkLeHEQi2u+1T3KrzkwpZA6lDnLmkuLMVtfC+qfRhoTtBc960uSxs9w/9Z0xVXyIcbW3H3NxbPgTHAesjQ7Mm0MhO/dG6T4VbmXoaCVUzJ+axlCtE44CWkzrIBo7MDDH1ysvQ1qi+nmkjpIC/FQzdsj/4ZF/M6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400245; c=relaxed/simple;
	bh=WgJlv8QN+puRGpmb3c0VyKptt5PYzIbwMXVpmJnIuYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pEabQHbdFmWy2p6REuuAzCbx6iUg1YDl9g0yiTavnERoKVWme29+d2l7kP2MXQkMY8PewhhsAxed890rerbf7dsS3vkA4MESayAEq3r2JL0fVUp3s0DCZercEPwzj3yomDABbxxh45UOjc+dB2s76SxoGsj2dJDb6erKYoShcEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqsz56TZXz9sSL;
	Fri, 23 Aug 2024 10:04:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bdF8zHuSRETr; Fri, 23 Aug 2024 10:04:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqsys3TRhz9sSR;
	Fri, 23 Aug 2024 10:03:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 668E38B77D;
	Fri, 23 Aug 2024 10:03:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id cPtC2e1YItjw; Fri, 23 Aug 2024 10:03:49 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C38B38B763;
	Fri, 23 Aug 2024 10:03:48 +0200 (CEST)
Message-ID: <d43fe116-6f74-4ee5-ab65-8bc895dedc05@csgroup.eu>
Date: Fri, 23 Aug 2024 10:03:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/36] soc: fsl: cpm1: qmc: Enable TRNSYNC only when
 needed
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-3-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-3-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:10, Herve Codina a écrit :
> The TRNSYNC feature is enabled whatever the number of time-slots used.
> The feature is needed only when more than one time-slot is used.
> 
> Improve the driver enabling TRNSYNC only when it is needed.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>


> ---
>   drivers/soc/fsl/qe/qmc.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index bacabf731dcb..916395745850 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -889,6 +889,7 @@ EXPORT_SYMBOL(qmc_chan_stop);
>   static int qmc_setup_chan_trnsync(struct qmc *qmc, struct qmc_chan *chan)
>   {
>   	struct tsa_serial_info info;
> +	unsigned int w_rx, w_tx;
>   	u16 first_rx, last_tx;
>   	u16 trnsync;
>   	int ret;
> @@ -898,6 +899,14 @@ static int qmc_setup_chan_trnsync(struct qmc *qmc, struct qmc_chan *chan)
>   	if (ret)
>   		return ret;
>   
> +	w_rx = hweight64(chan->rx_ts_mask);
> +	w_tx = hweight64(chan->tx_ts_mask);
> +	if (w_rx <= 1 && w_tx <= 1) {
> +		dev_dbg(qmc->dev, "only one or zero ts -> disable trnsync\n");
> +		qmc_clrbits16(chan->s_param + QMC_SPE_CHAMR, QMC_SPE_CHAMR_TRANSP_SYNC);
> +		return 0;
> +	}
> +
>   	/* Find the first Rx TS allocated to the channel */
>   	first_rx = chan->rx_ts_mask ? __ffs64(chan->rx_ts_mask) + 1 : 0;
>   
> @@ -911,6 +920,7 @@ static int qmc_setup_chan_trnsync(struct qmc *qmc, struct qmc_chan *chan)
>   		trnsync |= QMC_SPE_TRNSYNC_TX((last_tx % info.nb_tx_ts) * 2);
>   
>   	qmc_write16(chan->s_param + QMC_SPE_TRNSYNC, trnsync);
> +	qmc_setbits16(chan->s_param + QMC_SPE_CHAMR, QMC_SPE_CHAMR_TRANSP_SYNC);
>   
>   	dev_dbg(qmc->dev, "chan %u: trnsync=0x%04x, rx %u/%u 0x%llx, tx %u/%u 0x%llx\n",
>   		chan->id, trnsync,
> @@ -1378,7 +1388,7 @@ static int qmc_setup_chan(struct qmc *qmc, struct qmc_chan *chan)
>   	if (chan->mode == QMC_TRANSPARENT) {
>   		qmc_write32(chan->s_param + QMC_SPE_ZDSTATE, 0x18000080);
>   		qmc_write16(chan->s_param + QMC_SPE_TMRBLR, 60);
> -		val = QMC_SPE_CHAMR_MODE_TRANSP | QMC_SPE_CHAMR_TRANSP_SYNC;
> +		val = QMC_SPE_CHAMR_MODE_TRANSP;
>   		if (chan->is_reverse_data)
>   			val |= QMC_SPE_CHAMR_TRANSP_RD;
>   		qmc_write16(chan->s_param + QMC_SPE_CHAMR, val);

