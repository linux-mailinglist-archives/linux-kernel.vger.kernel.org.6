Return-Path: <linux-kernel+bounces-342386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105F2988E56
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 10:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1382828B0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 08:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A1119DF82;
	Sat, 28 Sep 2024 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrLubET9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF96B42A82;
	Sat, 28 Sep 2024 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727510461; cv=none; b=sIwxLaMZwKYEiSenigdypiRsY6Ut14eqmwZiEtrgDg9oCkV2s20bDplhkh94f6oOa4N3gc+5MYBrHw5V6EuiDtMuI09V7YkKDFZNgRkWDzfChxcALZGwxbNFRrK4bIC0XIjo7n6dVCKxyMbcCmNiHSDjRaAfOoJ+ogcmK/Q0Rco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727510461; c=relaxed/simple;
	bh=qlJzuJRE9Sn5Kw0Zcfet8Sxavy9TJ8gtErUmJx8vCWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSR8Q0GTWRKfxJeRRz6hxWXZUiPnLESQgyCe3EBi86nVb+V/zKMNjgVAAeGdp4G0dpuzuHRPTjeiPxeO3khlDYtCOQ7Cew40YzT7hI2Wu2VGsk86dUIbO5ulsEexTtaqQvJel+Y4x6Uev8U1ra42Wi8IEVcn8w0sg/hUJtBRWSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrLubET9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF4FC4CEC3;
	Sat, 28 Sep 2024 08:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727510461;
	bh=qlJzuJRE9Sn5Kw0Zcfet8Sxavy9TJ8gtErUmJx8vCWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IrLubET93T+OXdMS+LoTOq9d2NZJU3b2Ekbwwegi5ck8RcOUrkEYa/shXTDNXFHzY
	 kv5kwXB6ckx/1fOia+/RgM+36ztyPZVU+lK+839m3CfsMBnWWqbHBJ5gpCK9+wDP47
	 u1cG4xJ530oF/FRmw1ehW/Q6sEDPvTtMvGJnzq1FoQZsX6cIQaHQ5PlHNz7BC/FnQL
	 PGjtN26mCMfRnkM4OlvFSRlvDGqYbRxGmmRI4NtTBNMPofUX57pkvmFJAF7a2pknxu
	 Ji+6RrreaGryF4gzKRarRbTvmeku7mqftNHBh8MvHZhaapD/IJSkGB+JCj53nWPACx
	 hK5eRuNfjjrLQ==
Date: Sat, 28 Sep 2024 10:00:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: drew@pdp7.com, guoren@kernel.org, wefu@redhat.com, 
	jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	m.szyprowski@samsung.com, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/3] mailbox: Introduce support for T-head TH1520
 Mailbox driver
Message-ID: <vgnd5fbapw2hhjbbtzcmxikzprbnzo6m7dr6tqh7n4yepdlmyd@hs7lkieqtshk>
References: <20240927094207.1650085-1-m.wilczynski@samsung.com>
 <CGME20240927094214eucas1p272cf99b40344f501cbbfaa91c929c709@eucas1p2.samsung.com>
 <20240927094207.1650085-2-m.wilczynski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240927094207.1650085-2-m.wilczynski@samsung.com>

On Fri, Sep 27, 2024 at 11:42:05AM +0200, Michal Wilczynski wrote:
> This driver was tested using the drm/imagination GPU driver. It was able
> to successfully power on the GPU, by passing a command through mailbox
> from E910 core to E902 that's responsible for powering up the GPU. The
> GPU driver was able to read the BVC version from control registers,
> which confirms it was successfully powered on.
> 
> [   33.957467] powervr ffef400000.gpu: [drm] loaded firmware
> powervr/rogue_36.52.104.182_v1.fw
> [   33.966008] powervr ffef400000.gpu: [drm] FW version v1.0 (build
> 6621747 OS)
> [   38.978542] powervr ffef400000.gpu: [drm] *ERROR* Firmware failed to
> boot
> 
> Though the driver still fails to boot the firmware, the mailbox driver
> works when used with the not-yet-upstreamed firmware AON driver. There
> is ongoing work to get the BXM-4-64 supported with the drm/imagination
> driver [1], though it's not completed yet.
> 
> This work is based on the driver from the vendor kernel [2].
> 
> Link: https://gitlab.freedesktop.org/imagination/linux-firmware/-/issues/2 [1]
> Link: https://github.com/revyos/thead-kernel.git [2]
> 
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  MAINTAINERS                      |   1 +
>  drivers/mailbox/Kconfig          |  10 +
>  drivers/mailbox/Makefile         |   2 +
>  drivers/mailbox/mailbox-th1520.c | 551 +++++++++++++++++++++++++++++++
>  4 files changed, 564 insertions(+)
>  create mode 100644 drivers/mailbox/mailbox-th1520.c

...

> +static int th1520_mbox_startup(struct mbox_chan *chan)
> +{
> +	struct th1520_mbox_priv *priv = to_th1520_mbox_priv(chan->mbox);
> +	struct th1520_mbox_con_priv *cp = chan->con_priv;
> +	u32 data[8] = {};
> +	int mask_bit;
> +	int ret;
> +
> +	/* clear local and remote generate and info0~info7 */
> +	th1520_mbox_chan_rmw(cp, TH_1520_MBOX_GEN, 0x0, 0xff, true);
> +	th1520_mbox_chan_rmw(cp, TH_1520_MBOX_GEN, 0x0, 0xff, false);
> +	th1520_mbox_chan_wr_ack(cp, &data[7], true);
> +	th1520_mbox_chan_wr_ack(cp, &data[7], false);
> +	th1520_mbox_chan_wr_data(cp, &data[0], true);
> +	th1520_mbox_chan_wr_data(cp, &data[0], false);
> +
> +	/* enable the chan mask */
> +	mask_bit = th1520_mbox_chan_id_to_mapbit(cp);
> +	th1520_mbox_rmw(priv, TH_1520_MBOX_MASK, BIT(mask_bit), 0);
> +
> +	if (cp->type == TH_1520_MBOX_TYPE_DB)
> +		/* tx doorbell doesn't have ACK, rx doorbell requires isr */
> +		tasklet_init(&cp->txdb_tasklet, th1520_mbox_txdb_tasklet,
> +			     (unsigned long)cp);
> +
> +	ret = request_irq(priv->irq, th1520_mbox_isr,
> +			  IRQF_SHARED | IRQF_NO_SUSPEND, cp->irq_desc, chan);

Mixing devm- and non-devm with shared interrupts is error-prone (or even
discouraged). Your code looks here correct, but probably this deserves
a comment that you investigated the path and it is not possible to
trigger interrupt from another device while device is unbound.

> +	if (ret) {
> +		dev_err(priv->dev, "Unable to acquire IRQ %d\n", priv->irq);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void th1520_mbox_shutdown(struct mbox_chan *chan)
> +{
> +	struct th1520_mbox_priv *priv = to_th1520_mbox_priv(chan->mbox);
> +	struct th1520_mbox_con_priv *cp = chan->con_priv;
> +	int mask_bit;
> +
> +	/* clear the chan mask */
> +	mask_bit = th1520_mbox_chan_id_to_mapbit(cp);
> +	th1520_mbox_rmw(priv, TH_1520_MBOX_MASK, 0, BIT(mask_bit));
> +
> +	free_irq(priv->irq, chan);

Odd order. This should be reverse order from startup. Why is it not?

> +}
> +
> +static const struct mbox_chan_ops th1520_mbox_ops = {
> +	.send_data = th1520_mbox_send_data,
> +	.startup = th1520_mbox_startup,
> +	.shutdown = th1520_mbox_shutdown,
> +};
> +
> +static int th1520_mbox_init_generic(struct th1520_mbox_priv *priv)
> +{
> +#ifdef CONFIG_PM_SLEEP
> +	priv->ctx = devm_kzalloc(priv->dev, sizeof(*priv->ctx), GFP_KERNEL);
> +	if (!priv->ctx)
> +		return -ENOMEM;
> +#endif
> +	/* Set default configuration */
> +	th1520_mbox_write(priv, 0xff, TH_1520_MBOX_CLR);
> +	th1520_mbox_write(priv, 0x0, TH_1520_MBOX_MASK);
> +	return 0;
> +}
> +
> +static struct mbox_chan *th1520_mbox_xlate(struct mbox_controller *mbox,
> +					  const struct of_phandle_args *sp)
> +{
> +	struct th1520_mbox_priv *priv = to_th1520_mbox_priv(mbox);
> +	struct th1520_mbox_con_priv *cp;
> +	u32 chan, type;
> +
> +	if (sp->args_count != 2) {
> +		dev_err(mbox->dev, "Invalid argument count %d\n",
> +			sp->args_count);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	chan = sp->args[0]; /* comm remote channel */
> +	type = sp->args[1]; /* comm channel type */
> +
> +	if (chan >= mbox->num_chans) {
> +		dev_err(mbox->dev, "Not supported channel number: %d\n", chan);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (chan == priv->cur_icu_cpu_id) {
> +		dev_err(mbox->dev, "Cannot communicate with yourself\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (type > TH_1520_MBOX_TYPE_DB) {
> +		dev_err(mbox->dev, "Not supported the type for channel[%d]\n",
> +			chan);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	cp = mbox->chans[chan].con_priv;
> +	cp->type = type;
> +
> +	return &mbox->chans[chan];
> +}
> +
> +static int th1520_mbox_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct th1520_mbox_priv *priv;
> +	struct resource *res;
> +	unsigned int remote_idx = 0;
> +	unsigned int i;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	if (of_property_read_u32(np, "thead,icu-cpu-id", &priv->cur_icu_cpu_id)) {
> +		dev_err(dev, "thead,icu-cpu-id is missing\n");
> +		return -EINVAL;
> +	}
> +
> +	if (priv->cur_icu_cpu_id != TH_1520_MBOX_ICU_CPU0 &&
> +	    priv->cur_icu_cpu_id != TH_1520_MBOX_ICU_CPU3) {
> +		dev_err(dev, "thead,icu-cpu-id is invalid\n");
> +		return -EINVAL;
> +	}
> +
> +	priv->dev = dev;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "local");
> +	priv->local_icu[TH_1520_MBOX_ICU_CPU0] = devm_ioremap_resource(dev, res);

Use proper wrapper over these two.

> +	if (IS_ERR(priv->local_icu[TH_1520_MBOX_ICU_CPU0]))
> +		return PTR_ERR(priv->local_icu[TH_1520_MBOX_ICU_CPU0]);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "remote-icu0");
> +	priv->remote_icu[0] = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(priv->remote_icu[0]))
> +		return PTR_ERR(priv->remote_icu[0]);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "remote-icu1");
> +	priv->remote_icu[1] = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(priv->remote_icu[1]))
> +		return PTR_ERR(priv->remote_icu[1]);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "remote-icu2");
> +	priv->remote_icu[2] = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(priv->remote_icu[2]))
> +		return PTR_ERR(priv->remote_icu[2]);

Best regards,
Krzysztof


