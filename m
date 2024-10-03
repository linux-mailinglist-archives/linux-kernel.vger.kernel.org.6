Return-Path: <linux-kernel+bounces-348679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DE498EA67
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19291C225B2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC78126BF2;
	Thu,  3 Oct 2024 07:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwFDFtyy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8ED77112
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727941007; cv=none; b=bOkXznjWuL2TRk+hPDKxynMV0ecOcL85xvCzy2N6G/qed5bHt8h3O2ckBc+Drz1pMxzKu+GB1sB8wfgJ6xyZX93k92xumywHqucAMPYHCG9U8KLPs18JbzXjwSAo5Dl6DowDM86Qnv92wOfwCKVhxWPPJZiYZAKAC3M80Jyyfx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727941007; c=relaxed/simple;
	bh=gwVFoOtcBx92ky+723r7kOzW4Gx5ccaKU+35RARmFlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6xQbgDULOpJ3ADrG5TuWobEh2Ct5XQHGaoCQxrysbZSyRMkmvLUtEa3S9Tt1lELIjxR4BHJf39tHaiaYhMBFyJoHpbDDN552u6IBGpQShvRN1s7I+cUsaKeJFunsBtnKWXzxmhtEJAIPbAFRZmuTrsYQbKvQJ5kXQtyOdP6kmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwFDFtyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3143C4CEC7;
	Thu,  3 Oct 2024 07:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727941006;
	bh=gwVFoOtcBx92ky+723r7kOzW4Gx5ccaKU+35RARmFlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jwFDFtyy+AuYLn6Y7XWWvWjSw5XR8btX9nMfKskJTlxlfjLYosu8hOFOTJbQFOrao
	 Q62UjOjvrIlU7bN3nZt4Nj52vkH0+QcZxzXeW67/KwlnMjVUxM2KSOF0ODz+YXXKFC
	 u3/BfECH4AhswGOKUhHh7gvPGH7lux4mu1fVhafwrU6imHvJ3rmnfXw8zrSmXkMKAs
	 DiioDexTLtYChC6MvKPPEAvkmrx2Qh8c1dsjtBrMvAkvMv2WkCbdbPDRt47cWQIHTU
	 agLsIR5bhLY63w22w6O3f2biz+6pBBn5lUEAJrYxrA+EzKdFTH7fvYqcYgA5bm7Oip
	 AqcKK01Q2rv9Q==
Date: Thu, 3 Oct 2024 08:36:42 +0100
From: Lee Jones <lee@kernel.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: linux@ew.tq-group.com, linux-kernel@vger.kernel.org,
	Gregor Herburger <gregor.herburger@tq-group.com>
Subject: Re: [PATCH v3 3/5] mfd: tqmx86: refactor GPIO IRQ setup
Message-ID: <20241003073642.GH7504@google.com>
References: <cover.1726148801.git.matthias.schiffer@ew.tq-group.com>
 <00708dee4281943a8da8dc2fee63388c9f923048.1726148801.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00708dee4281943a8da8dc2fee63388c9f923048.1726148801.git.matthias.schiffer@ew.tq-group.com>

On Thu, 12 Sep 2024, Matthias Schiffer wrote:

> Move IRQ setup into a helper function. The string "GPIO" for error
> messages is replaced with a label argument to prepare for reusing the
> function for the I2C IRQ.
> 
> No functional change intended.
> 
> Co-developed-by: Gregor Herburger <gregor.herburger@tq-group.com>
> Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> v2: no changes (was patch 2/4)
> v3: no changes
> 
>  drivers/mfd/tqmx86.c | 72 +++++++++++++++++++++++++++-----------------
>  1 file changed, 45 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
> index 7b2f9490a9af5..5aa51ead00a28 100644
> --- a/drivers/mfd/tqmx86.c
> +++ b/drivers/mfd/tqmx86.c
> @@ -186,32 +186,54 @@ static int tqmx86_board_id_to_clk_rate(struct device *dev, u8 board_id)
>  	}
>  }
>  
> -static int tqmx86_probe(struct platform_device *pdev)
> +static int tqmx86_irq_to_irq_cfg(struct device *dev, const char *label, u8 irq)

Not sure single case statement that only gets called once warrants its
own function (with a weird name).  I'd put it in tqmx86_setup_irq() and
have done.

>  {
> -	u8 board_id, sauc, rev, i2c_det, io_ext_int_val;
> -	struct device *dev = &pdev->dev;
> -	u8 gpio_irq_cfg, readback;
> -	const char *board_name;
> -	void __iomem *io_base;
> -	int err;
> -
> -	switch (gpio_irq) {
> +	switch (irq) {
>  	case 0:
> -		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_NONE;
> -		break;
> +		return TQMX86_REG_IO_EXT_INT_NONE;
>  	case 7:
> -		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_7;
> -		break;
> +		return TQMX86_REG_IO_EXT_INT_7;
>  	case 9:
> -		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_9;
> -		break;
> +		return TQMX86_REG_IO_EXT_INT_9;
>  	case 12:
> -		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_12;
> -		break;
> +		return TQMX86_REG_IO_EXT_INT_12;
>  	default:
> -		pr_err("tqmx86: Invalid GPIO IRQ (%d)\n", gpio_irq);
> +		dev_err(dev, "invalid %s IRQ (%d)\n", label, irq);
>  		return -EINVAL;
>  	}
> +}
> +
> +static int tqmx86_setup_irq(struct device *dev, const char *label, u8 irq,
> +			    void __iomem *io_base, u8 reg_shift)
> +{
> +	u8 val, readback;
> +	int irq_cfg;
> +
> +	irq_cfg = tqmx86_irq_to_irq_cfg(dev, label, irq);
> +	if (irq_cfg < 0)
> +		return irq_cfg;
> +
> +	val = ioread8(io_base + TQMX86_REG_IO_EXT_INT);
> +	val &= ~(TQMX86_REG_IO_EXT_INT_MASK << reg_shift);
> +	val |= (irq_cfg & TQMX86_REG_IO_EXT_INT_MASK) << reg_shift;
> +
> +	iowrite8(val, io_base + TQMX86_REG_IO_EXT_INT);
> +	readback = ioread8(io_base + TQMX86_REG_IO_EXT_INT);
> +	if (readback != val) {
> +		dev_warn(dev, "%s interrupts not supported\n", label);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tqmx86_probe(struct platform_device *pdev)
> +{
> +	u8 board_id, sauc, rev, i2c_det;
> +	struct device *dev = &pdev->dev;
> +	const char *board_name;
> +	void __iomem *io_base;
> +	int err;
>  
>  	io_base = devm_ioport_map(dev, TQMX86_IOBASE, TQMX86_IOSIZE);
>  	if (!io_base)
> @@ -233,15 +255,11 @@ static int tqmx86_probe(struct platform_device *pdev)
>  	 */
>  	i2c_det = inb(TQMX86_REG_I2C_DETECT);
>  
> -	if (gpio_irq_cfg) {
> -		io_ext_int_val =
> -			gpio_irq_cfg << TQMX86_REG_IO_EXT_INT_GPIO_SHIFT;
> -		iowrite8(io_ext_int_val, io_base + TQMX86_REG_IO_EXT_INT);
> -		readback = ioread8(io_base + TQMX86_REG_IO_EXT_INT);
> -		if (readback != io_ext_int_val) {
> -			dev_warn(dev, "GPIO interrupts not supported.\n");
> -			return -EINVAL;
> -		}
> +	if (gpio_irq) {
> +		err = tqmx86_setup_irq(dev, "GPIO", gpio_irq, io_base,
> +				       TQMX86_REG_IO_EXT_INT_GPIO_SHIFT);
> +		if (err)
> +			return err;
>  
>  		/* Assumes the IRQ resource is first. */
>  		tqmx_gpio_resources[0].start = gpio_irq;
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> https://www.tq-group.com/

-- 
Lee Jones [李琼斯]

