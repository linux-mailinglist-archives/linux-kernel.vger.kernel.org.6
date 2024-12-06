Return-Path: <linux-kernel+bounces-435152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACD59E7228
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D76616C29D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A1B153836;
	Fri,  6 Dec 2024 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rd8wwKUm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AFF53A7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497521; cv=none; b=Z8d2L1njeymuoS1I+99+/Lh9I7gmcZl9yHaQ8L6dd0/0FcoazQZxjj+2lW2yab+8S2WmaT6W8fMgi2fReZqbzo7KzFaKjhNpuhRwA+64OYPvm0ptXkttgnHeyYC1KqsliRAdA83D/hYTiLiSvY4voQhJoos2z4v7HEsyyaKd1No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497521; c=relaxed/simple;
	bh=n5luwXwWLd9DgVsstLBRLIaONOkjZ/WyIx0Gq2TnC5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OCwfN0B0Rdqi1nvFxI2Mk477H5cLYCCClDJrT9UN+CZfTTTsyQeXkNsfKxoiNxrtqwXSR+8lyQMWyktYDELgzixHKteUHfNh2yJ59yQaMa11rl1YCRWjpNR0GwhsA6YNpnGya+3DVu0M6yfbZaxCgbCBsyKvQfD5dVTRatg1Quo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rd8wwKUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A54C4CEDC;
	Fri,  6 Dec 2024 15:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733497521;
	bh=n5luwXwWLd9DgVsstLBRLIaONOkjZ/WyIx0Gq2TnC5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Rd8wwKUmprfSBWCs2QY5GkpVdlWtRmcWO1zsTlwfLgSpXywm8FYb91fmBKeXZB9yk
	 7W3C76y6xzOF3/agSS0SLMHjuIVl0wa6tmAryA28mgq8qZw8FHMxkXLBHyIZqcc2Ev
	 Bv7pkP79S/x47CGGFicx3aqe3gx5l5qx6PcTI2+0dKIxfkF2em5c+++Fh7W9xqjPGh
	 D4XCBgS+IkwRQB7MdQo9syNU17/5m2RnpyLttjywA2RUDnoxAmlLtOU9ipaSW9jvNS
	 hZhx8nO6GVldrRfTWX8EnTmxBw8EQ+GpdclGp6R4abBEFgepLlFYeB2f1fMJvvENb9
	 +i8KgdfKMTFaw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Vishwaroop A <va@nvidia.com>
Cc: <tudor.ambarus@linaro.org>,  <pratyush@kernel.org>,
  <mwalle@kernel.org>,  <cmiquel.raynal@bootlin.com>,
  <thierry.reding@gmail.com>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <linux-mtd@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <jonathanh@nvidia.com>,  <kyarlagadda@nvidia.com>,
  <smangipudi@nvidia.com>
Subject: Re: [PATCH 1/3] mtd: spi-nor: Add post-get-map-id fixup for
 S25FS512S/S1
In-Reply-To: <20241126185834.1130949-2-va@nvidia.com> (Vishwaroop A.'s message
	of "Tue, 26 Nov 2024 18:58:32 +0000")
References: <20241126185834.1130949-1-va@nvidia.com>
	<20241126185834.1130949-2-va@nvidia.com>
Date: Fri, 06 Dec 2024 15:05:17 +0000
Message-ID: <mafs0jzcc4zte.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Vishwaroop,

Thanks for the patch.

On Tue, Nov 26 2024, Vishwaroop A wrote:

> The SFDP Address Map for S25FS512S / S25FS512S1 devices incorrectly
> reports that the map ID is 0 when it should be 1. This issue can
> cause problems when trying to erase sectors on the flash device.

This isn't exactly what your patch does. It also takes care of when map
ID should be 1, 3, or 5. Please update the commit message to reflect
that, and also probably describe in more detail how you got to those
values.

>
> Add a post-get-map-id fixup for S25FS512S / S1 flash devices. The fixup
> reads the values of the CR3V and CR1V registers and determines the
> map ID based on those values. The fixup also checks for invalid
> combinations of CR3V and CR1V values.This fixup is necessary to
> workaround an issue with the SFDP Address Map for S25FS512S flash.

Do you really need a new fixup for that? Why not set the erase map via
the post_sfdp fixup? Does that add too much extra code?

This is my main question for this patch and would like to get an answer
before we move forward. Still, leaving a quick code review below as
well.

>
> Change-Id: Ide18bb4ee076cd36c57b0b52b5d49b63c3caf322

What does this change ID mean? Is this for your internal systems
(gerrit?). In that case, it has no relevance for the upstream tree and
should be removed.

> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>  drivers/mtd/spi-nor/core.c     | 25 +++++++++++++++++++++
>  drivers/mtd/spi-nor/core.h     |  4 ++++
>  drivers/mtd/spi-nor/sfdp.c     |  7 ++++++
>  drivers/mtd/spi-nor/spansion.c | 41 ++++++++++++++++++++++++++++++++++
>  4 files changed, 77 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 66949d9f0cc5..a76202c6d252 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2408,6 +2408,31 @@ int spi_nor_post_bfpt_fixups(struct spi_nor *nor,
>  	return 0;
>  }
>  
> +/**
> + * spi_nor_post_get_map_id_fixups - Apply post-processing fixups for map ID
> + * @nor: Pointer to the spi_nor structure
> + * @smpt: Pointer to the sector map parameter table
> + * @smpt_len: Length of the sector map parameter table
> + * @map_id: Pointer to store the updated map ID
> + *
> + * Return: 0 on success (including when no fixup is applied),
> + *         positive value if a new map_id is set,

Not true. The function never returns a positive value. Does it even need
to? I suppose the caller never needs to know, it should just use
whatever is in map_id.

Honestly, I would like to have similar return semantics for
spi_nor_post_get_map_id_fixups() and for the actual fixup callbacks.
Having one return map ID and another fill it in a pointer and return
just success/error is confusing. Pick one and stick with it, and I think
how the fixup callbacks do it makes more sense. Perhaps even pass in the
current map_id to the fixup so it can just choose the default if it sees
it doesn't have to fix anything up.

> + *         negative value on error
> + */
> +int spi_nor_post_get_map_id_fixups(struct spi_nor *nor, const u32 *smpt,
> +				   u8 smpt_len, u8 *map_id)
> +{
> +	int ret;
> +
> +	if (nor->info->fixups && nor->info->fixups->post_get_map_id) {

Nit: might as well do:

	struct spi_nor_fixups *fixups = nor->info->fixups;

and make this easier to parse.

> +		ret = nor->info->fixups->post_get_map_id(nor, smpt, smpt_len);
> +		if (ret < 0)
> +			return ret;
> +		*map_id = ret;
> +	}
> +	return 0;
> +}
> +
>  static int spi_nor_select_read(struct spi_nor *nor,
>  			       u32 shared_hwcaps)
>  {
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 5c33740ed7f5..37a9f43e1bf9 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -428,6 +428,7 @@ struct spi_nor_fixups {
>  			 const struct sfdp_bfpt *bfpt);
>  	int (*post_sfdp)(struct spi_nor *nor);
>  	int (*late_init)(struct spi_nor *nor);
> +	int (*post_get_map_id)(struct spi_nor *nor, const u32 *smpt, u8 smpt_len);

Should update documentation for the struct as well.

>  };
>  
>  /**
> @@ -661,6 +662,9 @@ int spi_nor_post_bfpt_fixups(struct spi_nor *nor,
>  			     const struct sfdp_parameter_header *bfpt_header,
>  			     const struct sfdp_bfpt *bfpt);
>  
> +int spi_nor_post_get_map_id_fixups(struct spi_nor *nor, const u32 *smpt,
> +				   u8 smpt_len, u8 *map_id);
> +
>  void spi_nor_init_default_locking_ops(struct spi_nor *nor);
>  void spi_nor_try_unlock_all(struct spi_nor *nor);
>  void spi_nor_set_mtd_locking_ops(struct spi_nor *nor);
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index 21727f9a4ac6..87af29d2c28b 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -769,6 +769,13 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt,
>  		map_id = map_id << 1 | !!(*buf & read_data_mask);
>  	}
>  
> +	err = spi_nor_post_get_map_id_fixups(nor, smpt, smpt_len, &map_id);
> +

Nit: drop the blank line.

> +	if (err < 0) {
> +		dev_err(nor->dev, "Error in post_get_map_id fixup: %d\n", err);
> +		return ERR_PTR(err);
> +	}
> +
>  	/*
>  	 * If command descriptors are provided, they always precede map
>  	 * descriptors in the table. There is no need to start the iteration
> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> index 5a88a6096ca8..2e1dd023a1aa 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -25,6 +25,7 @@
>  #define SPINOR_REG_CYPRESS_STR1V					\
>  	(SPINOR_REG_CYPRESS_VREG + SPINOR_REG_CYPRESS_STR1)
>  #define SPINOR_REG_CYPRESS_CFR1			0x2
> +#define SPINOR_REG_CYPRESS_CFR1V		0x00800002
>  #define SPINOR_REG_CYPRESS_CFR1_QUAD_EN		BIT(1)	/* Quad Enable */
>  #define SPINOR_REG_CYPRESS_CFR2			0x3
>  #define SPINOR_REG_CYPRESS_CFR2V					\
> @@ -33,6 +34,7 @@
>  #define SPINOR_REG_CYPRESS_CFR2_MEMLAT_11_24	0xb
>  #define SPINOR_REG_CYPRESS_CFR2_ADRBYT		BIT(7)
>  #define SPINOR_REG_CYPRESS_CFR3			0x4
> +#define SPINOR_REG_CYPRESS_CFR3V		0x00800004
>  #define SPINOR_REG_CYPRESS_CFR3_PGSZ		BIT(4) /* Page size. */
>  #define SPINOR_REG_CYPRESS_CFR5			0x6
>  #define SPINOR_REG_CYPRESS_CFR5_BIT6		BIT(6)
> @@ -754,8 +756,47 @@ s25fs_s_nor_post_bfpt_fixups(struct spi_nor *nor,
>  	return 0;
>  }
>  
> +static int s25fs_s_nor_post_get_map_id(struct spi_nor *nor, const u32 *smpt, u8 smpt_len)
> +{
> +	struct spi_mem_op op =
> +		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RD_ANY_REG, 1),
> +			   SPI_MEM_OP_ADDR(3, 0, 1),

Should you use addr_width here instead of hard-coding 3?

> +			   SPI_MEM_OP_NO_DUMMY,
> +			   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
> +
> +	u8 reg_cr3v_val, reg_cr1v_val;
> +	int ret;
> +
> +	/* Read CR3V value from Configuration Register 3 Volatile */
> +	op.addr.val = SPINOR_REG_CYPRESS_CFR3V;
> +	ret = spi_mem_exec_op(nor->spimem, &op);
> +	if (ret)
> +		return ret;
> +	reg_cr3v_val = nor->bouncebuf[0];
> +
> +	/* Read CR1V value from Configuration Register 1 Volatile */
> +	op.addr.val = SPINOR_REG_CYPRESS_CFR1V;
> +	ret = spi_mem_exec_op(nor->spimem, &op);
> +	if (ret)
> +		return ret;
> +	reg_cr1v_val = nor->bouncebuf[0];
> +
> +	/* Determine the map ID based on CR3V[3] and CR1V[2] values */
> +	if (!(reg_cr3v_val & BIT(3)) && !(reg_cr1v_val & BIT(2)))

Would be a good idea to give proper names to these bits in all the if
statements, instead of hard-coding them as BIT(x). For example, we do:

#define SPINOR_REG_CYPRESS_CFR3_PGSZ		BIT(4) /* Page size. */

Instead of using BIT(4) directly.

Also would be nice to comment why these combinations select the map IDs
they select.

> +		return 1; /* CR3V[3] = 0, CR1V[2] = 0, map id = 1 */
> +
> +	if (!(reg_cr3v_val & BIT(3)) && (reg_cr1v_val & BIT(2)))
> +		return 3; /* CR3V[3] = 0, CR1V[2] = 1, map id = 3 */
> +
> +	if ((reg_cr3v_val & BIT(3)) && !(reg_cr1v_val & BIT(2)))
> +		return 5; /* CR3V[3] = 1, CR1V[2] = 0, map id = 5 */

You say in the commit message that:

> The fixup also checks for invalid combinations of CR3V and CR1V
> values.This fixup is necessary to workaround an issue with the SFDP
> Address Map for S25FS512S flash.

I see no checks for invalid combinations. Also, what is the "issue" you
mention? Can you please elaborate?

> +
> +	return 0;

The return value is used to set map_id for callers. Did you just return
0 as the "default success value" or do you really want to use map 0 if
we get here? If so, your function never uses map 2. Why is that? Can
that configuration never happen?

> +}
> +
>  static const struct spi_nor_fixups s25fs_s_nor_fixups = {
>  	.post_bfpt = s25fs_s_nor_post_bfpt_fixups,
> +	.post_get_map_id = s25fs_s_nor_post_get_map_id,
>  };
>  
>  static const struct flash_info spansion_nor_parts[] = {

-- 
Regards,
Pratyush Yadav

