Return-Path: <linux-kernel+bounces-412933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8000B9D116F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE3E1F23506
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6430D1A0B0C;
	Mon, 18 Nov 2024 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aKvYvzsM"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D5819EED3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731935182; cv=none; b=CLZziLuOE/0Dvbad+n/oSGhscKSMTvKTN/mSJtqS20TMulGdLXhH1NrK2kiGiGXqvGXr3Xr0a37tlKw03J80FqzM5XDvE3bWPigA/ttmiEiB41NFUtWnSLmHmVl6wS4KHIoaTPVJhCS83U4OGj9WHBzPUQm+FupElvFMsnZernk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731935182; c=relaxed/simple;
	bh=GRNV3bW7c0K4s5GFCHqyPX3ATGSiaeDuuNtCBOzaiUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CgDz79gxqftFb09CL1v5XvEE5TpjhvQ3vn82j6OH5OfscIdws8b2pdUcnHTussb7x3xLNphP7RuIWIUaXB6jsCGliaoyS5JWuo9Dzxak1QJm4tgvmGO65jLinw4/Po9eur0JGo0m4oYVO2lcVsv3Z1fzmTchAx+koSb5cUtqVrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aKvYvzsM; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D80FEFF806;
	Mon, 18 Nov 2024 13:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731935172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgitSO12Tcu39jjcYc9b4qcvZmSoxQsq/VM/TY8Chgw=;
	b=aKvYvzsMXQQ+ls8zRUxnMN6GkySr1qXCFabheMfnb2re1dpmlDRs93dxj9kRjTynCcg02/
	1lc4TLcQyEjdG3NW5kg5VBTiF1fQvkygHr6+KILeTA2Wnlol83xPMKVD9p4hwtueAlHR2k
	pJrl8oMnVn2K+jZXZEpETa0cG/fnJbFRbaxFDDXPlvfikQsC0lKc4EH+U0Ogv3HOAOL0Fh
	plKibB+fHaASv3ksfyfd2T3Z/6Nw9sJOzKVLdL0pr0wdQ6LGnzKINLswMe6BBtwk0cFd9M
	i0i/AMm4tNZjYt2Sz915at6l1cB72cQgMnfWgm6vfcxTI4IIDYnmMYJHaFZcuA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Richard Weinberger
 <richard@nod.at>,  Vignesh Raghavendra <vigneshr@ti.com>,  Daniel Golle
 <daniel@makrotopia.org>,  Chia-Lin Kao <acelan.kao@canonical.com>,  "Mika
 Westerberg" <mika.westerberg@linux.intel.com>,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <linux-arm-kernel@lists.infradead.org>,
  <linux-mediatek@lists.infradead.org>,  Steven Liu
 <Steven.Liu@mediatek.com>
Subject: Re: [RFC PATCH nand/next 3/4] include: mtd: spinand: Add CASN page
 related macros and flags.
In-Reply-To: <20241020132722.20565-4-SkyLake.Huang@mediatek.com> (Sky Huang's
	message of "Sun, 20 Oct 2024 21:27:21 +0800")
References: <20241020132722.20565-1-SkyLake.Huang@mediatek.com>
	<20241020132722.20565-4-SkyLake.Huang@mediatek.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 18 Nov 2024 14:06:08 +0100
Message-ID: <87r078y9mn.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 20/10/2024 at 21:27:21 +08, Sky Huang <SkyLake.Huang@mediatek.com> wrote:

> From: "Sky Huang" <skylake.huang@mediatek.com>
>
> This patch adds SPINAND CASN page manipulation macros for
> SPI-NAND driver to use. Also, some important flag bits, like
> SPINAND_SUPR_CR(continuous read), are added to show the
> SPI-NAND device's capability.
>
> Signed-off-by: Sky Huang <skylake.huang@mediatek.com>
> ---
>  include/linux/mtd/spinand.h | 100 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 98 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 702e5fb13dae..de97994c357b 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -62,6 +62,59 @@
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_NO_DATA)
>=20=20
> +/* Macros for CASN */
> +#define SPINAND_CASN_PAGE_READ_FROM_CACHE_OP(fast, naddr, addr, ndummy, =
buf, len) \
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(fast ? 0x0b : 0x03, 1),		\
> +		   SPI_MEM_OP_ADDR(naddr, addr, 1),			\
> +		   SPI_MEM_OP_DUMMY(ndummy, 1),			\
> +		   SPI_MEM_OP_DATA_IN(len, buf, 1))
> +
> +#define SPINAND_CASN_PAGE_READ_FROM_CACHE_X2_OP(naddr, addr, ndummy, buf=
, len)	\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x3b, 1),			\
> +		   SPI_MEM_OP_ADDR(naddr, addr, 1),			\
> +		   SPI_MEM_OP_DUMMY(ndummy, 1),			\
> +		   SPI_MEM_OP_DATA_IN(len, buf, 2))
> +
> +#define SPINAND_CASN_PAGE_READ_FROM_CACHE_DUALIO_OP(naddr, addr, ndummy,=
 buf, len)	\
> +		SPI_MEM_OP(SPI_MEM_OP_CMD(0xbb, 1),			\
> +			   SPI_MEM_OP_ADDR(naddr, addr, 2),			\
> +			   SPI_MEM_OP_DUMMY(ndummy, 2),			\
> +			   SPI_MEM_OP_DATA_IN(len, buf, 2))
> +
> +#define SPINAND_CASN_PAGE_READ_FROM_CACHE_X4_OP(naddr, addr, ndummy, buf=
, len)	\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0x6b, 1),				\
> +		   SPI_MEM_OP_ADDR(naddr, addr, 1),				\
> +		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
> +		   SPI_MEM_OP_DATA_IN(len, buf, 4))
> +
> +#define SPINAND_CASN_PAGE_READ_FROM_CACHE_QUADIO_OP(naddr, addr, ndummy,=
 buf, len)	\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(0xeb, 1),				\
> +		   SPI_MEM_OP_ADDR(naddr, addr, 4),				\
> +		   SPI_MEM_OP_DUMMY(ndummy, 4),				\
> +		   SPI_MEM_OP_DATA_IN(len, buf, 4))
> +
> +#define SPINAND_CASN_PROG_LOAD(reset, naddr, addr, buf, len)			\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(reset ? 0x02 : 0x84, 1),		\
> +		   SPI_MEM_OP_ADDR(naddr, addr, 1),				\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_DATA_OUT(len, buf, 1))
> +
> +#define SPINAND_CASN_PROG_LOAD_X4(reset, naddr, addr, buf, len)			\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(reset ? 0x32 : 0x34, 1),		\
> +		   SPI_MEM_OP_ADDR(naddr, addr, 1),				\
> +		   SPI_MEM_OP_NO_DUMMY,					\
> +		   SPI_MEM_OP_DATA_OUT(len, buf, 4))

Why would you need to redefine all these?

> +
> +#define SPINAND_CASN_ADVECC_OP(casn_adv_ecc_status, buf)			\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(casn_adv_ecc_status.cmd, 1),			\
> +		   SPI_MEM_OP_ADDR(casn_adv_ecc_status.addr_nbytes,		\
> +				   casn_adv_ecc_status.addr,			\
> +				   casn_adv_ecc_status.addr_buswidth),		\
> +		   SPI_MEM_OP_DUMMY(casn_adv_ecc_status.dummy_nbytes,		\
> +				    casn_adv_ecc_status.dummy_buswidth),	\
> +		   SPI_MEM_OP_DATA_IN(casn_adv_ecc_status.status_nbytes, buf, 1))
> +/* Macros for CASN end */
> +
>  #define SPINAND_PAGE_READ_FROM_CACHE_OP(fast, addr, ndummy, buf, len)	\
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(fast ? 0x0b : 0x03, 1),		\
>  		   SPI_MEM_OP_ADDR(2, addr, 1),				\
> @@ -312,8 +365,11 @@ struct spinand_ecc_info {
>=20=20
>  #define SPINAND_HAS_QE_BIT		BIT(0)
>  #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
> -#define SPINAND_HAS_PROG_PLANE_SELECT_BIT		BIT(2)
> -#define SPINAND_HAS_READ_PLANE_SELECT_BIT		BIT(3)

Why do you remove that?

> +#define SPINAND_SUP_CR			BIT(2)
> +#define SPINAND_SUP_ON_DIE_ECC		BIT(3)
> +#define SPINAND_SUP_LEGACY_ECC_STATUS	BIT(4)
> +#define SPINAND_SUP_ADV_ECC_STATUS	BIT(5)
> +#define SPINAND_ECC_PARITY_READABLE	BIT(6)
>=20=20
>  /**
>   * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine st=
ructure
> @@ -406,6 +462,28 @@ struct spinand_dirmap {
>  	struct spi_mem_dirmap_desc *rdesc_ecc;
>  };
>=20=20
> +/**
> + * struct CASN_ADVECC - CASN's advanced ECC description
> + * @cmd: Command to access SPI-NAND on-chip ECC status registers
> + * @mask: Mask to access SPI-NAND on-chip ECC status registers.
> + *	  ADV_ECC_STATUS->status_nbytes | CASN_ADVECC->mask
> + *			1		|      0 to 0xff
> + *			2		|     0 to 0xffff
> + * @shift: How many bits to shift to get on-chip ECC status
> + * @pre_op: This comes from CASN page's ADV_ECC_STATUS's pre_op.
> + *	    After reading on-chip ECC status, we need to do some math
> + *	    operations if this is specified.

I'm not sure I understand how you'll encode a math operation there.

> + * @pre_mask: This comes from CASN page's ADV_ECC_STATUS's pre_mask.
> + *	      This is used in companion with pre_op above.
> + */
> +struct CASN_ADVECC {

This is usually changing when continuous reads are enabled, it would
need to be handled.

> +	u8 cmd;
> +	u16 mask;
> +	u8 shift;
> +	u8 pre_op;
> +	u8 pre_mask;
> +};
> +

Thanks,
Miqu=C3=A8l


