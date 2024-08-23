Return-Path: <linux-kernel+bounces-298443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FDE95C768
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE6841C24511
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03645143C5B;
	Fri, 23 Aug 2024 08:07:12 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30CD13FD72;
	Fri, 23 Aug 2024 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724400431; cv=none; b=RVOUb8gT2kV9h8jsStuEyyxCiAQNkvfTU9YLGNQgrvpzmQNZ8qB06k0qBPeNdaLuRcojTH2GaAGSXQk5vl6yFcYQibm3uqp08kxDrZd9wQGmF7w/xyzQeZ6QQlCdVLere1r0djjXpaN7WtVa+Dmy9clj3FJrqEnzR/L8D1xCd0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724400431; c=relaxed/simple;
	bh=VgEA60PYPTd5q+L5o2+v2EBKVompsK8AoBbN471kNus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gw84U4Z3E8gqSUngGA5k4pVrVorN3K2sxLVT1EvqsnVrE1XJ5ympTfnU8HviSIbw03NQbHdx7NXhOt+bVRpx3tQ/EV/NqgUQcp8ax6MZs5P270ajko6VzjjYOneHrVnWl0mzecSAbn1kNHEP8rh9Kk9Cjt4Bn5XMaE5GRAMRy2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wqt2g2n8Jz9sSK;
	Fri, 23 Aug 2024 10:07:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sl_MUrsx3dNi; Fri, 23 Aug 2024 10:07:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wqt2g1WFvz9sRy;
	Fri, 23 Aug 2024 10:07:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2370C8B77D;
	Fri, 23 Aug 2024 10:07:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 1xImv7hteqcN; Fri, 23 Aug 2024 10:07:07 +0200 (CEST)
Received: from [192.168.233.10] (PO24418.IDSI0.si.c-s.fr [192.168.233.10])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4CE438B763;
	Fri, 23 Aug 2024 10:07:06 +0200 (CEST)
Message-ID: <7d43b8c8-4975-49bb-bc91-6b435552f35e@csgroup.eu>
Date: Fri, 23 Aug 2024 10:07:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/36] soc: fsl: cpm1: qmc: Use BIT(), GENMASK() and
 FIELD_PREP() macros
To: Herve Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Mark Brown <broonie@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240808071132.149251-1-herve.codina@bootlin.com>
 <20240808071132.149251-19-herve.codina@bootlin.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240808071132.149251-19-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 08/08/2024 à 09:11, Herve Codina a écrit :
> checkpatch.pl signals the following improvement for qmc.c
>    CHECK: Prefer using the BIT macro
> 
> Follow its suggestion and convert the code to BIT() and related macros.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>


> ---
>   drivers/soc/fsl/qe/qmc.c | 132 +++++++++++++++++++++------------------
>   1 file changed, 72 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
> index 721e0770510c..e2ac3e59bb79 100644
> --- a/drivers/soc/fsl/qe/qmc.c
> +++ b/drivers/soc/fsl/qe/qmc.c
> @@ -8,6 +8,7 @@
>    */
>   
>   #include <soc/fsl/qe/qmc.h>
> +#include <linux/bitfield.h>
>   #include <linux/dma-mapping.h>
>   #include <linux/hdlc.h>
>   #include <linux/interrupt.h>
> @@ -23,23 +24,24 @@
>   
>   /* SCC general mode register high (32 bits) */
>   #define SCC_GSMRL	0x00
> -#define SCC_GSMRL_ENR		(1 << 5)
> -#define SCC_GSMRL_ENT		(1 << 4)
> -#define SCC_GSMRL_MODE_QMC	(0x0A << 0)
> +#define SCC_GSMRL_ENR		BIT(5)
> +#define SCC_GSMRL_ENT		BIT(4)
> +#define SCC_GSMRL_MODE_MASK	GENMASK(3, 0)
> +#define SCC_GSMRL_MODE_QMC	FIELD_PREP_CONST(SCC_GSMRL_MODE_MASK, 0x0A)
>   
>   /* SCC general mode register low (32 bits) */
>   #define SCC_GSMRH	0x04
> -#define   SCC_GSMRH_CTSS	(1 << 7)
> -#define   SCC_GSMRH_CDS		(1 << 8)
> -#define   SCC_GSMRH_CTSP	(1 << 9)
> -#define   SCC_GSMRH_CDP		(1 << 10)
> +#define   SCC_GSMRH_CTSS	BIT(7)
> +#define   SCC_GSMRH_CDS		BIT(8)
> +#define   SCC_GSMRH_CTSP	BIT(9)
> +#define   SCC_GSMRH_CDP		BIT(10)
>   
>   /* SCC event register (16 bits) */
>   #define SCC_SCCE	0x10
> -#define   SCC_SCCE_IQOV		(1 << 3)
> -#define   SCC_SCCE_GINT		(1 << 2)
> -#define   SCC_SCCE_GUN		(1 << 1)
> -#define   SCC_SCCE_GOV		(1 << 0)
> +#define   SCC_SCCE_IQOV		BIT(3)
> +#define   SCC_SCCE_GINT		BIT(2)
> +#define   SCC_SCCE_GUN		BIT(1)
> +#define   SCC_SCCE_GOV		BIT(0)
>   
>   /* SCC mask register (16 bits) */
>   #define SCC_SCCM	0x14
> @@ -75,25 +77,31 @@
>   #define QMC_GBL_C_MASK16	0xA0
>   
>   /* TSA entry (16bit entry in TSATRX and TSATTX) */
> -#define QMC_TSA_VALID		(1 << 15)
> -#define QMC_TSA_WRAP		(1 << 14)
> -#define QMC_TSA_MASK_8BIT	(0x303F)
> -#define QMC_TSA_CHANNEL(x)	((x) << 6)
> +#define QMC_TSA_VALID		BIT(15)
> +#define QMC_TSA_WRAP		BIT(14)
> +#define QMC_TSA_MASK_MASKH	GENMASK(13, 12)
> +#define QMC_TSA_MASK_MASKL	GENMASK(5, 0)
> +#define QMC_TSA_MASK_8BIT	(FIELD_PREP_CONST(QMC_TSA_MASK_MASKH, 0x3) | \
> +				 FIELD_PREP_CONST(QMC_TSA_MASK_MASKL, 0x3F))
> +#define QMC_TSA_CHANNEL_MASK	GENMASK(11, 6)
> +#define QMC_TSA_CHANNEL(x)	FIELD_PREP(QMC_TSA_CHANNEL_MASK, x)
>   
>   /* Tx buffer descriptor base address (16 bits, offset from MCBASE) */
>   #define QMC_SPE_TBASE	0x00
>   
>   /* Channel mode register (16 bits) */
>   #define QMC_SPE_CHAMR	0x02
> -#define   QMC_SPE_CHAMR_MODE_HDLC	(1 << 15)
> -#define   QMC_SPE_CHAMR_MODE_TRANSP	((0 << 15) | (1 << 13))
> -#define   QMC_SPE_CHAMR_ENT		(1 << 12)
> -#define   QMC_SPE_CHAMR_POL		(1 << 8)
> -#define   QMC_SPE_CHAMR_HDLC_IDLM	(1 << 13)
> -#define   QMC_SPE_CHAMR_HDLC_CRC	(1 << 7)
> -#define   QMC_SPE_CHAMR_HDLC_NOF	(0x0f << 0)
> -#define   QMC_SPE_CHAMR_TRANSP_RD	(1 << 14)
> -#define   QMC_SPE_CHAMR_TRANSP_SYNC	(1 << 10)
> +#define   QMC_SPE_CHAMR_MODE_MASK	GENMASK(15, 15)
> +#define   QMC_SPE_CHAMR_MODE_HDLC	FIELD_PREP_CONST(QMC_SPE_CHAMR_MODE_MASK, 1)
> +#define   QMC_SPE_CHAMR_MODE_TRANSP	(FIELD_PREP_CONST(QMC_SPE_CHAMR_MODE_MASK, 0) | BIT(13))
> +#define   QMC_SPE_CHAMR_ENT		BIT(12)
> +#define   QMC_SPE_CHAMR_POL		BIT(8)
> +#define   QMC_SPE_CHAMR_HDLC_IDLM	BIT(13)
> +#define   QMC_SPE_CHAMR_HDLC_CRC	BIT(7)
> +#define   QMC_SPE_CHAMR_HDLC_NOF_MASK	GENMASK(3, 0)
> +#define   QMC_SPE_CHAMR_HDLC_NOF(x)	FIELD_PREP(QMC_SPE_CHAMR_HDLC_NOF_MASK, x)
> +#define   QMC_SPE_CHAMR_TRANSP_RD	BIT(14)
> +#define   QMC_SPE_CHAMR_TRANSP_SYNC	BIT(10)
>   
>   /* Tx internal state (32 bits) */
>   #define QMC_SPE_TSTATE	0x04
> @@ -120,43 +128,47 @@
>   
>   /* Transparent synchronization (16 bits) */
>   #define QMC_SPE_TRNSYNC 0x3C
> -#define   QMC_SPE_TRNSYNC_RX(x)	((x) << 8)
> -#define   QMC_SPE_TRNSYNC_TX(x)	((x) << 0)
> +#define   QMC_SPE_TRNSYNC_RX_MASK	GENMASK(15, 8)
> +#define   QMC_SPE_TRNSYNC_RX(x)		FIELD_PREP(QMC_SPE_TRNSYNC_RX_MASK, x)
> +#define   QMC_SPE_TRNSYNC_TX_MASK	GENMASK(7, 0)
> +#define   QMC_SPE_TRNSYNC_TX(x)		FIELD_PREP(QMC_SPE_TRNSYNC_TX_MASK, x)
>   
>   /* Interrupt related registers bits */
> -#define QMC_INT_V		(1 << 15)
> -#define QMC_INT_W		(1 << 14)
> -#define QMC_INT_NID		(1 << 13)
> -#define QMC_INT_IDL		(1 << 12)
> -#define QMC_INT_GET_CHANNEL(x)	(((x) & 0x0FC0) >> 6)
> -#define QMC_INT_MRF		(1 << 5)
> -#define QMC_INT_UN		(1 << 4)
> -#define QMC_INT_RXF		(1 << 3)
> -#define QMC_INT_BSY		(1 << 2)
> -#define QMC_INT_TXB		(1 << 1)
> -#define QMC_INT_RXB		(1 << 0)
> +#define QMC_INT_V		BIT(15)
> +#define QMC_INT_W		BIT(14)
> +#define QMC_INT_NID		BIT(13)
> +#define QMC_INT_IDL		BIT(12)
> +#define QMC_INT_CHANNEL_MASK	GENMASK(11, 6)
> +#define QMC_INT_GET_CHANNEL(x)	FIELD_GET(QMC_INT_CHANNEL_MASK, x)
> +#define QMC_INT_MRF		BIT(5)
> +#define QMC_INT_UN		BIT(4)
> +#define QMC_INT_RXF		BIT(3)
> +#define QMC_INT_BSY		BIT(2)
> +#define QMC_INT_TXB		BIT(1)
> +#define QMC_INT_RXB		BIT(0)
>   
>   /* BD related registers bits */
> -#define QMC_BD_RX_E	(1 << 15)
> -#define QMC_BD_RX_W	(1 << 13)
> -#define QMC_BD_RX_I	(1 << 12)
> -#define QMC_BD_RX_L	(1 << 11)
> -#define QMC_BD_RX_F	(1 << 10)
> -#define QMC_BD_RX_CM	(1 << 9)
> -#define QMC_BD_RX_UB	(1 << 7)
> -#define QMC_BD_RX_LG	(1 << 5)
> -#define QMC_BD_RX_NO	(1 << 4)
> -#define QMC_BD_RX_AB	(1 << 3)
> -#define QMC_BD_RX_CR	(1 << 2)
> -
> -#define QMC_BD_TX_R	(1 << 15)
> -#define QMC_BD_TX_W	(1 << 13)
> -#define QMC_BD_TX_I	(1 << 12)
> -#define QMC_BD_TX_L	(1 << 11)
> -#define QMC_BD_TX_TC	(1 << 10)
> -#define QMC_BD_TX_CM	(1 << 9)
> -#define QMC_BD_TX_UB	(1 << 7)
> -#define QMC_BD_TX_PAD	(0x0f << 0)
> +#define QMC_BD_RX_E	BIT(15)
> +#define QMC_BD_RX_W	BIT(13)
> +#define QMC_BD_RX_I	BIT(12)
> +#define QMC_BD_RX_L	BIT(11)
> +#define QMC_BD_RX_F	BIT(10)
> +#define QMC_BD_RX_CM	BIT(9)
> +#define QMC_BD_RX_UB	BIT(7)
> +#define QMC_BD_RX_LG	BIT(5)
> +#define QMC_BD_RX_NO	BIT(4)
> +#define QMC_BD_RX_AB	BIT(3)
> +#define QMC_BD_RX_CR	BIT(2)
> +
> +#define QMC_BD_TX_R		BIT(15)
> +#define QMC_BD_TX_W		BIT(13)
> +#define QMC_BD_TX_I		BIT(12)
> +#define QMC_BD_TX_L		BIT(11)
> +#define QMC_BD_TX_TC		BIT(10)
> +#define QMC_BD_TX_CM		BIT(9)
> +#define QMC_BD_TX_UB		BIT(7)
> +#define QMC_BD_TX_PAD_MASK	GENMASK(3, 0)
> +#define QMC_BD_TX_PAD(x)	FIELD_PREP(QMC_BD_TX_PAD_MASK, x)
>   
>   /* Numbers of BDs and interrupt items */
>   #define QMC_NB_TXBDS	8
> @@ -662,7 +674,7 @@ static int qmc_chan_setup_tsa_64rxtx(struct qmc_chan *chan, const struct tsa_ser
>   			continue;
>   
>   		qmc_clrsetbits16(chan->qmc->scc_pram + QMC_GBL_TSATRX + (i * 2),
> -				 ~QMC_TSA_WRAP, enable ? val : 0x0000);
> +				 (u16)~QMC_TSA_WRAP, enable ? val : 0x0000);
>   	}
>   
>   	return 0;
> @@ -698,7 +710,7 @@ static int qmc_chan_setup_tsa_32rx(struct qmc_chan *chan, const struct tsa_seria
>   			continue;
>   
>   		qmc_clrsetbits16(chan->qmc->scc_pram + QMC_GBL_TSATRX + (i * 2),
> -				 ~QMC_TSA_WRAP, enable ? val : 0x0000);
> +				 (u16)~QMC_TSA_WRAP, enable ? val : 0x0000);
>   	}
>   
>   	return 0;
> @@ -734,7 +746,7 @@ static int qmc_chan_setup_tsa_32tx(struct qmc_chan *chan, const struct tsa_seria
>   			continue;
>   
>   		qmc_clrsetbits16(chan->qmc->scc_pram + QMC_GBL_TSATTX + (i * 2),
> -				 ~QMC_TSA_WRAP, enable ? val : 0x0000);
> +				 (u16)~QMC_TSA_WRAP, enable ? val : 0x0000);
>   	}
>   
>   	return 0;

