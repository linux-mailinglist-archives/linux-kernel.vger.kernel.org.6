Return-Path: <linux-kernel+bounces-347088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3FE98CDA6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8538B21135
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655E91885AD;
	Wed,  2 Oct 2024 07:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LqT/l9Wu"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AAC1754B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727853394; cv=none; b=jrMJozTipKNR1/Fj+WgLZI4RlGgI9TJmUX21e9gXUQ9RLuRW8kDcCDMAI/i1MzV7gv/M84sVne78e51/+0lFbharrX7zF9CrdR/uQDaff05+VrseWzcgWpMSqJn+vGL483VTMUPUFPvpUy4LPyT2sAt/FVa8tl/P911YaK+p5Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727853394; c=relaxed/simple;
	bh=rpBr82lakebCythwYDVGQKT8xppOTYTzIR2dInPIPig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLcEFM8Y8rBq8pBUuYMCPm3JwlKLz3BAzTJCp/oISZTqoMH7zsDub7DxyNN7fRFRBvWM3zLnXHTnu6dL6/xnOk7naKZcJjyTXDjZB0DlYIZ0b5Spb2o3b61DvNp5tDduVg8q1OqecstWL+AKLU5bXPVKtHsmx7+rMPOXWsu+ftc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LqT/l9Wu; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37ccd81de57so321683f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 00:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727853391; x=1728458191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EwkM9xMdO6YNpUr10aG6HmysdgamH0iEBubPoE0QAjw=;
        b=LqT/l9WuU7HkbWuoG5XJW0EiikteB+2Ke02OW1GVGjCHTJZFwWS0TPCKHCPHm9it9x
         mEYi+bvHp/uzUqmmDK6UbSHc9dzyilE0lUYj0OF4W+V0Q53UZ57bPlZxvVLFdctoighr
         4UoyTYhbbxMrERLfA2lKMlWKTBsqsqPzPMm230CIQYhRz6G4ZfcZHsD0kr28cD6tHomw
         Z608WnRbYhjE1/POBzq5u6l0coWw9T3Dg398CA1HBce4ex7ljMcb3C6dcdDi9q3zn2na
         geclW0uWZ/KDCLtTisET45PK9YU863CHfmVNJQgARyInEKsJXr2J7ZYxl3Av20tYAkgM
         K5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727853391; x=1728458191;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwkM9xMdO6YNpUr10aG6HmysdgamH0iEBubPoE0QAjw=;
        b=aMvmUPx+5YNz0EYo/5AxTDmI6PkhlaEjENAJzu+rm4FG3AtHaHgtv/y+Aj/JUFJOTC
         mFaFyrKAtUEuK97FdW6xbdA+3zhCBOPjHAkmHd418+86kCyIKLvO6Gv1v0FzZbNjosRB
         8L0J2UfclCs3rdzYJ0M0gPp4TXITdTMm0DyMW6bPdt3SP56RueZIoblmCb+wd10c9POW
         o0wUGYU92Q4pKH+0DJXkfymwWrXVf/WQd3duJhe61BrxheVqerJAEtuLfXUAIopjWHrN
         84iuJKE5P02LSCHbmvonDNAHqHQ5iC0OH41PsQAR6GgqqCswsR6/n2BbkgnOnj8y1w8t
         ud8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcY+cOAzF8Y0OqnRwnvGZc3oXIWxGMNAuj+vE5viJRubMfaaRr4Ml3TBohHm3L8dNNvBJAZ9DBmB2G6/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE7pDWXlXqtyERg3/FLiMVcqxUEOyH78jG2ApHrpmR0SG2lQC+
	KJg3WtR/6voGexKTsdX8OS/ccaYshwYN2lv55PGaBvbxQkA0agXhtcuFEy6AZS8=
X-Google-Smtp-Source: AGHT+IHhMja+RznaA2PmsCPeItzGZVOftxTsWc3L0eheoPujf3oCzA5nRin1fHFVNYt9yQ5nwMxKlg==
X-Received: by 2002:adf:e44c:0:b0:371:8685:84c with SMTP id ffacd0b85a97d-37cfb9ddc04mr1183978f8f.15.1727853390994;
        Wed, 02 Oct 2024 00:16:30 -0700 (PDT)
Received: from [10.11.12.174] ([82.76.204.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e6587sm13300708f8f.47.2024.10.02.00.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 00:16:30 -0700 (PDT)
Message-ID: <28ac1c39-5592-4e5c-8fce-53489e0135ee@linaro.org>
Date: Wed, 2 Oct 2024 10:16:26 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/6] mtd: spi-nor: add Octal DTR support for Macronix
 flash
To: AlvinZhou <alvinzhou.tw@gmail.com>, linux-mtd@lists.infradead.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, broonie@kernel.org
Cc: chengminglin@mxic.com.tw, leoyu@mxic.com.tw,
 AlvinZhou <alvinzhou@mxic.com.tw>, JaimeLiao <jaimeliao@mxic.com.tw>
References: <20240926141956.2386374-1-alvinzhou.tw@gmail.com>
 <20240926141956.2386374-2-alvinzhou.tw@gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <20240926141956.2386374-2-alvinzhou.tw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26.09.2024 17:19, AlvinZhou wrote:
> From: AlvinZhou <alvinzhou@mxic.com.tw>
> 
> Create Macronix specify method for enable Octal DTR mode and
> set 20 dummy cycles to allow running at the maximum supported
> frequency for Macronix Octal flash.
> 
> Use number of dummy cycles which is parse by SFDP then convert
> it to bit pattern and set in CR2 register.
> Set CR2 register for enable octal DTR mode.
> 
> Use Read ID to confirm that enabling/disabling octal DTR mode
> was successful.
> 
> Macronix ID format is A-A-B-B-C-C in octal DTR mode.
> To ensure the successful enablement of octal DTR mode, confirm
> that the 6-byte data is entirely correct.
> 
> Co-developed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
> Signed-off-by: AlvinZhou <alvinzhou@mxic.com.tw>
> ---
>  drivers/mtd/spi-nor/macronix.c | 91 ++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index ea6be95e75a5..f039819a5252 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -8,6 +8,24 @@
>  
>  #include "core.h"
>  
> +#define MXIC_NOR_OP_RD_CR2	0x71		/* Read configuration register 2 opcode */
> +#define MXIC_NOR_OP_WR_CR2	0x72		/* Write configuration register 2 opcode */
> +#define MXIC_NOR_ADDR_CR2_MODE	0x00000000	/* CR2 address for setting spi/sopi/dopi mode */
> +#define MXIC_NOR_ADDR_CR2_DC	0x00000300	/* CR2 address for setting dummy cycles */
> +#define MXIC_NOR_REG_DOPI_EN	0x2		/* Enable Octal DTR */
> +#define MXIC_NOR_REG_SPI_EN	0x0		/* Enable SPI */
> +
> +/* Convert dummy cycles to bit pattern */
> +#define MXIC_NOR_REG_DC(p) \
> +	((20 - (p)) >> 1)

This is unfortunate as we convert dummy cycles to bytes in mtd and then
we convert back from bytes to cycles in spi. I had an attempt fixing
this in the past, but couldn't allocate more time for spinning another
version for the patch set.

I won't block the patch set for this, but if someone cares to fix it,
would be great to take over.

> +
> +/* Macronix write CR2 operations */

I'll drop this comment when applying, as I can already see what the
macro is doing from its name.

> +#define MXIC_NOR_WR_CR2(addr, ndata, buf)			\
> +	SPI_MEM_OP(SPI_MEM_OP_CMD(MXIC_NOR_OP_WR_CR2, 0),	\
> +		   SPI_MEM_OP_ADDR(4, addr, 0),			\
> +		   SPI_MEM_OP_NO_DUMMY,				\
> +		   SPI_MEM_OP_DATA_OUT(ndata, buf, 0))
> +
>  static int
>  mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
>  			    const struct sfdp_parameter_header *bfpt_header,
> @@ -185,6 +203,78 @@ static const struct flash_info macronix_nor_parts[] = {
>  	}
>  };
>  
> +static int macronix_nor_octal_dtr_en(struct spi_nor *nor)
> +{
> +	struct spi_mem_op op;
> +	u8 *buf = nor->bouncebuf, i;
> +	int ret;
> +
> +	/* Use dummy cycles which is parse by SFDP and convert to bit pattern. */
> +	buf[0] = MXIC_NOR_REG_DC(nor->params->reads[SNOR_CMD_READ_8_8_8_DTR].num_wait_states);
> +	op = (struct spi_mem_op)MXIC_NOR_WR_CR2(MXIC_NOR_ADDR_CR2_DC, 1, buf);
> +	ret = spi_nor_write_any_volatile_reg(nor, &op, nor->reg_proto);
> +	if (ret)
> +		return ret;
> +
> +	/* Set the octal and DTR enable bits. */
> +	buf[0] = MXIC_NOR_REG_DOPI_EN;
> +	op = (struct spi_mem_op)MXIC_NOR_WR_CR2(MXIC_NOR_ADDR_CR2_MODE, 1, buf);
> +	ret = spi_nor_write_any_volatile_reg(nor, &op, nor->reg_proto);
> +	if (ret)
> +		return ret;
> +
> +	/* Read flash ID to make sure the switch was successful. */
> +	ret = spi_nor_read_id(nor, 4, 4, buf, SNOR_PROTO_8_8_8_DTR);

can we use nor->addr_nbytes for the second argument? Please test and
confirm. No need to resend for this, just confirm and I can amend when
applying.

What about the third argument, the number of dummy nbytes. Can we get
the cycles needed for READID from somewhere in SFDP?

Looks good.

