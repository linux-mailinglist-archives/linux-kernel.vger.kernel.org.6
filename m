Return-Path: <linux-kernel+bounces-283196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C581F94EE83
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B431F21A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1554517C22A;
	Mon, 12 Aug 2024 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3LqS5NP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8EF176FBD
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470127; cv=none; b=d78L7ZOvTeNaAUiC1kY72m1leUaHR6WNk3Y0TxpZovHmiyGHrYtAaRMtItSqTQsPE/3gRgN/ruTe5FIoRbF0u8zN3XWOuF0N8AfA1VWSdV6F18DhQ9eX+2uzkIh0yxTfMV0J3gqCQakyGumyo9QXwoLsmNl44N3uhEY+4yvInYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470127; c=relaxed/simple;
	bh=SUDN/6Po80egMnrVOI6BNtVjTOorz0Kb2BQqNcCf52c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GXwPrid2qQ5SKsWgVrLoMqD6dDrLCk1OoffhTfEFCtT2nvh5Zib5bEUdAuQ7AoUmtLibZzQWD2i/FF56bAwrJkt5IboJBhM0XTXqXESf7Mu428TLVEg43HS50i6M2fDAcQkNmgd24xKsf+c2uLoF+OIO8/EXe1YMrzVEWDSnyJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3LqS5NP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B96C32782;
	Mon, 12 Aug 2024 13:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723470126;
	bh=SUDN/6Po80egMnrVOI6BNtVjTOorz0Kb2BQqNcCf52c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Z3LqS5NP/8Y5d0AKFntUt7sBV2O6tn4hSUUpNvaZyclDQcqxTENdWIB7fMwG3RxRa
	 3IPcVWBZgfdwgNFQ9iuBqBR8fSRx0OjGwRaO2aTAUyi+8Tx/SFa1V4gqBeyO231TkC
	 K+TBlJKMOa7fuB9/DzQs/UFVN9GqtvHcSEd37WNr7URGOQNFZ2nZTGxFmNstP0cEML
	 6C/RjrYmWyuvaxDlMrQh2kmFigpywx/24wGKtlJb81uIfOa0rEsvzOh72pUdxdmQd6
	 UBBUjG4xTfyAFZ4sy6pHP4oIWwvW7U6w9yoPMdWch/DQuTJ/J1v8212837JRun9Vtr
	 w0W1AtfKL1X/Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: winbond: add Zetta ZD25Q128C support
In-Reply-To: <20240804221535.291923-1-mwalle@kernel.org> (Michael Walle's
	message of "Mon, 5 Aug 2024 00:15:35 +0200")
References: <20240804221535.291923-1-mwalle@kernel.org>
Date: Mon, 12 Aug 2024 15:42:04 +0200
Message-ID: <mafs0v805zwlv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 05 2024, Michael Walle wrote:

> Zetta normally uses BAh as its vendor ID. But for the ZD25Q128C they
> took the one from Winbond and messed up the size parameters in SFDP.
> Most functions seem compatible with the W25Q128, we just have to fix up
> the size.
>
> Link: http://www.zettadevice.com/upload/file/20150821/DS_Zetta_25Q128_RevA.pdf
> Link: https://www.lcsc.com/datasheet/lcsc_datasheet_2312081757_Zetta-ZD25Q128CSIGT_C19626875.pdf
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> ---
[...]
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index e065e4fd42a3..9f7ce5763e71 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -17,6 +17,31 @@
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_DATA_OUT(1, buf, 0))
>  
> +static int
> +w25q128_post_bfpt_fixups(struct spi_nor *nor,
> +			 const struct sfdp_parameter_header *bfpt_header,
> +			 const struct sfdp_bfpt *bfpt)
> +{
> +	/*
> +	 * Zetta ZD25Q128C is a clone of the Winbond device. But the encoded
> +	 * size is really wrong. It seems that they confused Mbit with MiB.
> +	 * Thus the flash is discovered as a 2MiB device.
> +	 */
> +	if (bfpt_header->major == SFDP_JESD216_MAJOR &&
> +	    bfpt_header->minor == SFDP_JESD216_MINOR &&
> +	    nor->params->size == SZ_2M &&
> +	    nor->params->erase_map.regions[0].size == SZ_2M) {
> +		nor->params->size = SZ_16M;
> +		nor->params->erase_map.regions[0].size = SZ_16M;
> +	}

Since the size is 16 MiB for both Zetta and Winbond, why do you have
these conditions here? Why not just do it unconditionally? What
situation do you want to protect against?

> +
> +	return 0;
> +}
> +
> +static const struct spi_nor_fixups w25q128_fixups = {
> +	.post_bfpt = w25q128_post_bfpt_fixups,
> +};
> +
>  static int
>  w25q256_post_bfpt_fixups(struct spi_nor *nor,
>  			 const struct sfdp_parameter_header *bfpt_header,
> @@ -108,6 +133,7 @@ static const struct flash_info winbond_nor_parts[] = {
>  		.size = SZ_16M,
>  		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
>  		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> +		.fixups = &w25q128_fixups,
>  	}, {
>  		.id = SNOR_ID(0xef, 0x40, 0x19),
>  		.name = "w25q256",

-- 
Regards,
Pratyush Yadav

