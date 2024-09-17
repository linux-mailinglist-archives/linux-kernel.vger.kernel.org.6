Return-Path: <linux-kernel+bounces-331603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AF297AECB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDD02837B8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176CB16130C;
	Tue, 17 Sep 2024 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwPP/pa6"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E7361FCE;
	Tue, 17 Sep 2024 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569176; cv=none; b=XLny19fdXmi2pxnpvRdbE7PWm9/m0/Zi3bPBC9Is5eBkVDZ5B7mzwIhsIE1PJeS7g1IYsejhwO/i5B4SkewyTCFl7i03lKhllARJhYUTdqaQbVoZ+EU3sGKHBlk5d5yzV53zlptTlHBr+LqfMHFZeFTEUFwEE791+Kkhgd0bhiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569176; c=relaxed/simple;
	bh=QeTNcms1pCatvxZiPyM6j/75fEw2qRdEoth+C5Qo0R0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEQcKYyAodPBq4vHOp2iWKhZtSaYp81h9ToHLrW228Auvcc3eeQbmU3MmBd+Wsiwgk2dES1ThPWUY5+Oigh4hqpUxBYmVUB7G+vi/vr+raY+glAFexQXcB26E3vyZKPB5PYJbz3N7Chaa8dXjRVLlbGspXILuT8CD4zNqUtQTEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwPP/pa6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so5814713a12.0;
        Tue, 17 Sep 2024 03:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726569173; x=1727173973; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=urw93t9dgeqJfpnW0Vddrv1JySfFGP+z7gLlYb3sLUw=;
        b=fwPP/pa6xzmoF3mz66OVHQ5tzx8U1Ihj32JTRBiyNFHpZvjK5GcvemSRprNn6KjAsL
         8q+HfasuOW5KfqBssqY8xnuFNC4O5YvZ+VehJPV5TmtP6Co1CVAaAbqMpbdEXaO6bzMN
         V8adad50a65bISTEGlECDUH2mzdMAPdetATQfqkAq0lZIQB6X8X70/xdWme/ax06ymPH
         rkKCT9QYg74MRIbz2+MOAQJfgE1ryAmBfNE1uutiolf5wyNQf+cA9s9iEcM/Mr+vgl9U
         hNQa78AX1XQaK+IV8z8hOepe59rN+TnNw5xy/2U9vxADqC6lPihKkp8pwkGRAZX+o4/j
         iz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726569173; x=1727173973;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urw93t9dgeqJfpnW0Vddrv1JySfFGP+z7gLlYb3sLUw=;
        b=SFpclvh+tOp2jn+QS2fErTSorESKSlrvV2fG15Jr4/XGjjYJcQfW5acTUxhR1DZIWk
         RlCzOj4ScFz89+lUe8oDP9BNH66T5k2DZ+ZyWzXwHmEmomOZqw7l2xmHt+MxRbBn6Hel
         P5U2cZfECwMokAyWmW/4YF/B3z2k+x0Z++GiqMD97jyUZEKX06/gz0BXjHl1GpNlAmwW
         yht6XkbbjzRalixH6xKjCJ2t0WJyX2vmj/7P/6MrhrIfLKpN1Sm1EpB5gjV7rC/ddFp0
         DNzPABWOzoXSyF3ZM1v51JUAnJA3d+4GhGeK6IjHsrPHEMAobS5JMWvH6lQaSsBeVSSZ
         76Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUFC8dmYtg0bAt7gGSNLmJxLCa/TLutPdO06uzJM+4jCI0Lg2O+mYHRGW5S01Ny1k7NKvl4k/S/fX31@vger.kernel.org, AJvYcCXZCTxKCOw7sD2uu4m6QO09ka/fT0RFCvHbHkyVn2sshTD2S3oLMhyW/bNgIWbit7lO8bG1/QUCGFsZHfMZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzLoPYfC/z9rCrvtIIIgJO8Onl0e6atBFQhcxNsCLgiiI4WqSWz
	18K1oAgIDvi4BSokoNPg9oEZFTw1R5L5Hr3OYXN9o5u8iCUxK40Hk9m5r0fdV4xCyCVBQ0SYN+z
	xBqHhiuWyDKjMMNYQqfZtcAJS1w==
X-Google-Smtp-Source: AGHT+IHzw0PEUSjwbeoB50lNCJxhRmwmchGr8DJxZWRkSMgFxsN/7POvekxN1y4jscottow7M2YGBODgeFPz5dPsdLc=
X-Received: by 2002:a05:6402:278b:b0:5c2:6d16:ad5e with SMTP id
 4fb4d7f45d1cf-5c41e1906e8mr12620913a12.19.1726569172271; Tue, 17 Sep 2024
 03:32:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917094956.437078-1-erezgeva@nwtime.org> <20240917094956.437078-5-erezgeva@nwtime.org>
In-Reply-To: <20240917094956.437078-5-erezgeva@nwtime.org>
From: Erez <erezgeva2@gmail.com>
Date: Tue, 17 Sep 2024 12:32:15 +0200
Message-ID: <CANeKEMNouQi+L8qUjayaNwyWwi6v=4PsX+VcgqiJgz4z9S91hQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] mtd: spi-nor: macronix: add support for OTP
To: Erez Geva <erezgeva@nwtime.org>
Cc: linux-mtd@lists.infradead.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, linux-kernel@vger.kernel.org, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Esben Haabendal <esben@geanix.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Sept 2024 at 11:50, Erez Geva <erezgeva@nwtime.org> wrote:
>
> From: Erez Geva <ErezGeva2@gmail.com>
>
> Macronix SPI-NOR support OTP.
> Add callbacks to read, write and lock the OTP.
>
> Notice Macronix OTP do not support erase.
> Every bit written with '0', can not be changed further.
>
> Notice Macronix OTP do not support single region lock!
> The locking includes all regions at once!
>
> Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
> ---
>  drivers/mtd/spi-nor/macronix.c | 167 +++++++++++++++++++++++++++++++++
>  include/linux/mtd/spi-nor.h    |   9 ++
>  2 files changed, 176 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index ea6be95e75a5..02aa844d641b 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -8,6 +8,162 @@
>
>  #include "core.h"
>
> +/**
> + * macronix_nor_otp_enter() - Send Enter Secured OTP instruction to the chip.
> + * @nor:       pointer to 'struct spi_nor'.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int macronix_nor_otp_enter(struct spi_nor *nor)
> +{
> +       int error;
> +
> +       error = spi_nor_send_cmd(nor, SPINOR_OP_ENSO);
> +       if (error)
> +               dev_dbg(nor->dev, "error %d on Macronix Enter Secured OTP\n", error);
> +
> +       return error;
> +}
> +
> +/**
> + * macronix_nor_otp_exit() - Send Exit Secured OTP instruction to the chip.
> + * @nor:       pointer to 'struct spi_nor'.
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int macronix_nor_otp_exit(struct spi_nor *nor)
> +{
> +       int error;
> +
> +       error = spi_nor_send_cmd(nor, SPINOR_OP_EXSO);
> +       if (error)
> +               dev_dbg(nor->dev, "error %d on Macronix Exit Secured OTP\n", error);
> +
> +       return error;
> +}
> +
> +/**
> + * macronix_nor_otp_read() - read security register

Sorry, it should be "read OTP data".

> + * @nor:       pointer to 'struct spi_nor'
> + * @addr:       offset to read from
> + * @len:        number of bytes to read
> + * @buf:        pointer to dst buffer
> + *
> + * Return: number of bytes read successfully, -errno otherwise
> + */
> +static int macronix_nor_otp_read(struct spi_nor *nor, loff_t addr, size_t len, u8 *buf)
> +{
> +       int ret, error;
> +
> +       error = macronix_nor_otp_enter(nor);
> +       if (error)
> +               return error;
> +
> +       ret = spi_nor_read_data(nor, addr, len, buf);
> +
> +       error = macronix_nor_otp_exit(nor);
> +
> +       if (ret < 0)
> +               dev_dbg(nor->dev, "error %d on Macronix read OTP data\n", ret);
> +       else if (error)
> +               return error;
> +
> +       return ret;
> +}
> +
> +/**
> + * macronix_nor_otp_write() - write security register

Sorry, it should be "write data to OTP".

> + * @nor:        pointer to 'struct spi_nor'
> + * @addr:       offset to write to
> + * @len:        number of bytes to write
> + * @buf:        pointer to src buffer
> + *
> + * Return: number of bytes written successfully, -errno otherwise
> + */
> +static int macronix_nor_otp_write(struct spi_nor *nor, loff_t addr, size_t len, const u8 *buf)
> +{
> +       int error, ret = 0;
> +
> +       error = macronix_nor_otp_enter(nor);
> +       if (error)
> +               return error;
> +
> +       error = spi_nor_write_enable(nor);
> +       if (error)
> +               goto otp_write_err;
> +
> +       ret = spi_nor_write_data(nor, addr, len, buf);
> +       if (ret < 0) {
> +               dev_dbg(nor->dev, "error %d on Macronix write OTP data\n", ret);
> +               goto otp_write_err;
> +       }
> +
> +       error = spi_nor_wait_till_ready(nor);
> +       if (error)
> +               dev_dbg(nor->dev, "error %d on Macronix waiting write OTP finish\n", error);
> +
> +otp_write_err:
> +
> +       error = macronix_nor_otp_exit(nor);
> +
> +       return ret;
> +}
> +
> +/**
> + * macronix_nor_otp_lock() - lock the OTP region
> + * @nor:        pointer to 'struct spi_nor'
> + * @region:     OTP region
> + *
> + * Return: 0 on success, -errno otherwise.
> + */
> +static int macronix_nor_otp_lock(struct spi_nor *nor, unsigned int region)
> +{
> +       int error;
> +       u8 *rdscur = nor->bouncebuf;
> +
> +       error = spi_nor_read_reg(nor, SPINOR_OP_RDSCUR, 1);
> +       if (error) {
> +               dev_dbg(nor->dev, "error %d on read security register\n", error);
> +               return error;
> +       }
> +
> +       if (rdscur[0] & SEC_REG_LDSO)
> +               return 0;
> +
> +       error = spi_nor_write_enable(nor);
> +       if (error) {
> +               dev_dbg(nor->dev, "error %d on enable write before update security register\n",
> +                       error);
> +               return error;
> +       }
> +
> +       error = spi_nor_send_cmd(nor, SPINOR_OP_WRSCUR);
> +       if (error)
> +               dev_dbg(nor->dev, "error %d on update security register\n", error);
> +
> +       return error;
> +}
> +
> +/**
> + * macronix_nor_otp_is_locked() - get the OTP region lock status
> + * @nor:        pointer to 'struct spi_nor'
> + * @region:     OTP region
> + *
> + * Return: 1 on lock, 0 on not locked, -errno otherwise.
> + */
> +static int macronix_nor_otp_is_locked(struct spi_nor *nor, unsigned int region)
> +{
> +       int error;
> +       u8 *rdscur = nor->bouncebuf;
> +
> +       error = spi_nor_read_reg(nor, SPINOR_OP_RDSCUR, 1);
> +       if (error) {
> +               dev_dbg(nor->dev, "error %d on read security register\n", error);
> +               return error;
> +       }
> +       return rdscur[0] & SEC_REG_LDSO ? 1 : 0;
> +}
> +
>  static int
>  mx25l25635_post_bfpt_fixups(struct spi_nor *nor,
>                             const struct sfdp_parameter_header *bfpt_header,
> @@ -190,8 +346,19 @@ static void macronix_nor_default_init(struct spi_nor *nor)
>         nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
>  }
>
> +static const struct spi_nor_otp_ops macronix_nor_otp_ops = {
> +       .read = macronix_nor_otp_read,
> +       .write = macronix_nor_otp_write,
> +       /* .erase = Macronix OTP do not support erase, */
> +       .lock = macronix_nor_otp_lock,
> +       .is_locked = macronix_nor_otp_is_locked,
> +};
> +
>  static int macronix_nor_late_init(struct spi_nor *nor)
>  {
> +       if (nor->params->otp.org.n_regions)
> +               nor->params->otp.ops = &macronix_nor_otp_ops;
> +
>         if (!nor->params->set_4byte_addr_mode)
>                 nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode_en4b_ex4b;
>
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index cdcfe0fd2e7d..ef834e7fc0ac 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -81,6 +81,15 @@
>  #define SPINOR_OP_BP           0x02    /* Byte program */
>  #define SPINOR_OP_AAI_WP       0xad    /* Auto address increment word program */
>
> +/* Macronix OTP registers. */
> +#define SPINOR_OP_RDSCUR       0x2b    /* read security register */
> +#define SPINOR_OP_WRSCUR       0x2f    /* write security register */
> +#define SPINOR_OP_ENSO         0xb1    /* enter secured OTP */
> +#define SPINOR_OP_EXSO         0xc1    /* exit secured OTP */
> +
> +/* Macronix security register values */
> +#define SEC_REG_LDSO           BIT(1)  /* Lock-down Secured OTP */
> +
>  /* Used for Macronix and Winbond flashes. */
>  #define SPINOR_OP_EN4B         0xb7    /* Enter 4-byte mode */
>  #define SPINOR_OP_EX4B         0xe9    /* Exit 4-byte mode */
> --
> 2.39.5
>

