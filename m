Return-Path: <linux-kernel+bounces-256902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 101DF93720C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 03:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA14628251F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6F523B0;
	Fri, 19 Jul 2024 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jlwdv+Uw"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5489D1392
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 01:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721352932; cv=none; b=t3ZXLSxXeVWkzTc92MM472H2I8e+9EKy2IzP7YQdv3MoGFbJzdHA6QsDXjxJw7Jy5hdgZHAl5LPYb7sxOO60+nVmrwlWz2VGWNzUu33nc7lWoq6JMVkMdWSQ0ICEDQ4bf2SM0lR41bntbeiv9xYfpk0js1RqPF+CncBOpSgpU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721352932; c=relaxed/simple;
	bh=fELDUAVQHel/sgfcP29N6Q/BqwgmS2g7A9lUs/rmQLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PfZRTItRW8M8uENl+n7G7A54+y5B+LW8W4MMLUx0CTddKGdAK+grQ9Q6JVbF+mNoxvoKavYEmEQ9iLEbvTy0yl3nBI1dUdnvqbeMIiVLC59luNtrALHKpkDd6BElFCdChmuxW8FUMEj485bbFgo4zCvdcWf5RHaoeX0CoanDbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jlwdv+Uw; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8076ebb7ba1so53817239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 18:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721352929; x=1721957729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kCKSxmpGpgIaFLiWGefaq2tuapYPzU27sKjs+BRgK0I=;
        b=jlwdv+Uwr9yyBUMzSPP8FRXqufNcOEYyxRIAHYlUyTJwznorMnmmD/TkuIwavvIQky
         1wSP7SrFV7MoByHDbKRCIPfwtPjllmcjQnwsqM3ckswXOl2d6w7eq+ZMDeesI/vnG4qU
         pTYmnMPbz8J4gxbuwiayqYqIh1krijr4nhirQdicEmorEijl8oVNg9unRNuEw307fQoi
         4iM+hscG5gSEL0YL/BOs2RLSHE5uXccFc8BsVERbRZ2O0iSfqGaStOWU3559c4ltDEg4
         aG8oO1TzOe9akKa0hZB9+RRkdAgl82IZ43XBMid0uXfPYeycGQoSVUJYmxABkmUi0qKe
         IdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721352929; x=1721957729;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kCKSxmpGpgIaFLiWGefaq2tuapYPzU27sKjs+BRgK0I=;
        b=P2jjJ9kh2JMsmQUTaH+6nnjDFVq5EWxliYpgylxbfmO38k9QmVRA0XLToUuAuqP2fJ
         38/IudhbMRB6oPynH79Yk0Re9rYa8BAeU+tAcyDK/uOKY04a930ueeYeHfgjgj6qBbeG
         dA1Bdii8htgAvZvwmwFvs85CUkugXGQ51nxNIGdRDx4jEsEtSF6N0MMT2nIKtCvonKxs
         QnrOwDIkQXzhuvRK/KdRcL2j4mrkCGNFG1gTSeVQfyvovRhlFYnmjD/tD2UQ9lyBwWRS
         kUjNh4tADBn9Z4QJzL6mD8TfjCbTLsu1evapv+K4zbC9rW0NJlaLf2PDKfGSk6AD4PzU
         0YYg==
X-Gm-Message-State: AOJu0YzljxalLv8aafZNLiR9+wvLMBnYaEpBDL9vV7oMKtBbSWE/gWV4
	B2dSlVHdLoBiOb3Phh/lj1GgFuqwhiLgq8pUDb6syjwBuxvwZDcc9Aa9TozIWlU=
X-Google-Smtp-Source: AGHT+IETQFuHKrO4/S58tyD5OTrRmmOWT93LlD/6BpqMiB9K7t92N18nv7O5GBBuy0MITzv7YIG4RA==
X-Received: by 2002:a05:6602:14c8:b0:806:560:92b5 with SMTP id ca18e2360f4ac-81710bd4048mr846335739f.11.1721352929336;
        Thu, 18 Jul 2024 18:35:29 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-819adeeec61sm15485539f.47.2024.07.18.18.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 18:35:28 -0700 (PDT)
Message-ID: <dca205a1-46cc-4712-bdb1-15517e63e824@sifive.com>
Date: Thu, 18 Jul 2024 20:35:27 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mailbox: sophgo: add mailbox driver for cv18x SoCs
To: Yuntao Dai <d1581209858@live.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, jassisinghbrar@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, unicorn_wang@outlook.com,
 inochiama@outlook.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu
References: <SYBP282MB223825D5903777B937A8A377C4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
 <SYBP282MB2238F93565D20F0A5F3EEB6BC4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <SYBP282MB2238F93565D20F0A5F3EEB6BC4A02@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-07-14 11:36 AM, Yuntao Dai wrote:
> Add mailbox controller driver for cv18x SoCs, tested on mailbox-test
> client.
> 
> Signed-off-by: Yuntao Dai <d1581209858@live.com>
> ---
>  drivers/mailbox/Kconfig          |  11 ++
>  drivers/mailbox/Makefile         |   2 +
>  drivers/mailbox/cv1800-mailbox.c | 203 +++++++++++++++++++++++++++++++
>  3 files changed, 216 insertions(+)
>  create mode 100644 drivers/mailbox/cv1800-mailbox.c
> 
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 3b8842c4a..db856ec7e 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -286,4 +286,15 @@ config QCOM_IPCC
>  	  acts as an interrupt controller for receiving interrupts from clients.
>  	  Say Y here if you want to build this driver.
>  
> +config CV1800_MBOX
> +	tristate "cv1800 mailbox"
> +	depends on OF

This dependency is not necessary once the probe function is fixed (see below).

> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	help
> +	  Mailbox driver implementation for Sophgo cv180x SoCs. This driver
> +	  can be used to send message between different processors in SoC. Any
> +	  processer can write data in a channel, and set co-responding register
> +	  to raise interrupt to notice another processor, and it is allowed to
> +	  send data to itself.
> +
>  endif
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index 5cf2f54de..2c6db8c5c 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -62,3 +62,5 @@ obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
>  obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
>  
>  obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
> +
> +obj-$(CONFIG_CV1800_MBOX)	+= cv1800-mailbox.o
> \ No newline at end of file

Please add the missing newline.

> diff --git a/drivers/mailbox/cv1800-mailbox.c b/drivers/mailbox/cv1800-mailbox.c
> new file mode 100644
> index 000000000..a3b214b4d
> --- /dev/null
> +++ b/drivers/mailbox/cv1800-mailbox.c
> @@ -0,0 +1,203 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kfifo.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define RECV_CPU 2
> +
> +#define MAILBOX_MAX_CHAN 0x0008
> +#define MAILBOX_DONE_OFFSET 0x0002
> +#define MAILBOX_CONTEXT_SIZE 0x0040
> +#define MAILBOX_CONTEXT_OFFSET 0x0400
> +
> +#define MBOX_EN_REG(cpu) (cpu << 2)
> +#define MBOX_DONE_REG(cpu) ((cpu << 2) + MAILBOX_DONE_OFFSET)
> +
> +#define MBOX_SET_CLR_REG(cpu) (0x10 + (cpu << 4))
> +#define MBOX_SET_INT_REG(cpu) (0x18 + (cpu << 4))
> +
> +#define MBOX_SET_REG 0x60
> +
> +/**
> + * cv1800 mailbox channel private data
> + * @idx: index of channel
> + * @cpu: send to which processor
> + */
> +struct cv1800_mbox_chan_priv {
> +	int idx;
> +	int cpu;
> +};
> +
> +struct cv1800_mbox {
> +	struct mbox_controller mbox;
> +	struct cv1800_mbox_chan_priv priv[MAILBOX_MAX_CHAN];
> +	struct mbox_chan chans[MAILBOX_MAX_CHAN];
> +	u64 __iomem *content[MAILBOX_MAX_CHAN];
> +	void __iomem *mbox_base;
> +	int recvid;
> +};
> +
> +static irqreturn_t cv1800_mbox_isr(int irq, void *dev_id)
> +{
> +	struct cv1800_mbox *mbox = (struct cv1800_mbox *)dev_id;
> +	size_t i;
> +
> +	for (i = 0; i < MAILBOX_MAX_CHAN; i++) {
> +		if (mbox->content[i] && mbox->chans[i].cl) {
> +			mbox_chan_received_data(&mbox->chans[i],
> +						mbox->content[i]);
> +			mbox->content[i] = NULL;
> +			return IRQ_HANDLED;

Are you sure you only want to handle one channel per interrupt? Should this be
"ret = IRQ_HANDLED;" or similar instead of early return? The same applies to
cv1800_mbox_irq().

> +		}
> +	}
> +	return IRQ_NONE;
> +}
> +
> +static irqreturn_t cv1800_mbox_irq(int irq, void *dev_id)
> +{
> +	struct cv1800_mbox *mbox = (struct cv1800_mbox *)dev_id;
> +	u64 __iomem *addr;
> +	u8 set, valid;
> +	size_t i;
> +
> +	set = readb(mbox->mbox_base + MBOX_SET_INT_REG(RECV_CPU));
> +
> +	if (!set)
> +		return IRQ_NONE;
> +
> +	for (i = 0; i < MAILBOX_MAX_CHAN; i++) {
> +		valid = set & (1 << i);
> +		addr = (u64 *)(mbox->mbox_base + MAILBOX_CONTEXT_OFFSET) + i;
> +		if (valid) {
> +			mbox->content[i] = addr;
> +			writeb(valid,
> +			       mbox->mbox_base + MBOX_SET_CLR_REG(RECV_CPU));
> +			writeb(~valid, mbox->mbox_base + MBOX_EN_REG(RECV_CPU));
> +			return IRQ_WAKE_THREAD;
> +		}
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +static int cv1800_mbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct cv1800_mbox_chan_priv *priv =
> +		(struct cv1800_mbox_chan_priv *)chan->con_priv;
> +	struct cv1800_mbox *mbox = dev_get_drvdata(chan->mbox->dev);
> +	u64 __iomem *addr;
> +	u8 en, valid;
> +
> +	int idx = priv->idx;
> +	int cpu = priv->cpu;
> +
> +	addr = (u64 *)(mbox->mbox_base + MAILBOX_CONTEXT_OFFSET) + idx;
> +	memcpy_toio(addr, data, 8);
> +
> +	valid = 1 << idx;
> +	writeb(valid, mbox->mbox_base + MBOX_SET_CLR_REG(cpu));
> +	en = readb(mbox->mbox_base + MBOX_EN_REG(cpu));
> +	writeb(en | valid, mbox->mbox_base + MBOX_EN_REG(cpu));
> +	writeb(valid, mbox->mbox_base + MBOX_SET_REG);
> +
> +	return 0;
> +}
> +
> +static bool cv1800_last_tx_done(struct mbox_chan *chan)
> +{
> +	return true;

Shouldn't this check MBOX_EN_REG(priv->cpu) or similar to check that the
receiver has read the message?

> +}
> +
> +static const struct mbox_chan_ops cv1800_mbox_chan_ops = {
> +	.send_data = cv1800_mbox_send_data,
> +	.last_tx_done = cv1800_last_tx_done,
> +};
> +
> +static struct mbox_chan *cv1800_mbox_xlate(struct mbox_controller *mbox,
> +					   const struct of_phandle_args *spec)
> +{
> +	struct cv1800_mbox_chan_priv *priv;
> +
> +	int idx = spec->args[0];
> +	int cpu = spec->args[1];
> +
> +	if (idx >= mbox->num_chans)
> +		return ERR_PTR(-EINVAL);
> +
> +	priv = mbox->chans[idx].con_priv;
> +	priv->cpu = cpu;
> +
> +	return &mbox->chans[idx];
> +}
> +
> +static const struct of_device_id cv1800_mbox_of_match[] = {
> +	{ .compatible = "sophgo,cv1800-mailbox", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, cv1800_mbox_of_match);
> +
> +static int cv1800_mbox_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cv1800_mbox *mb;
> +	int irq, idx, err;
> +
> +	if (!dev->of_node)
> +		return -ENODEV;

No need for this check.

> +
> +	mb = devm_kzalloc(dev, sizeof(*mb), GFP_KERNEL);
> +	if (!mb)
> +		return -ENOMEM;
> +
> +	mb->mbox_base = devm_of_iomap(dev, dev->of_node, 0, NULL);

Please use devm_platform_ioremap_resource() here, which abstracts away the OF node.

> +	if (IS_ERR(mb->mbox_base))
> +		return dev_err_probe(dev, PTR_ERR(mb->mbox_base),
> +				     "Failed to map resource\n");
> +
> +	mb->mbox.dev = dev;
> +	mb->mbox.chans = mb->chans;
> +	mb->mbox.txdone_poll = true;
> +	mb->mbox.ops = &cv1800_mbox_chan_ops;
> +	mb->mbox.num_chans = MAILBOX_MAX_CHAN;
> +	mb->mbox.of_xlate = cv1800_mbox_xlate;
> +
> +	irq = platform_get_irq_byname(pdev, "mailbox");
> +	err = devm_request_threaded_irq(dev, irq, cv1800_mbox_irq,
> +					cv1800_mbox_isr, IRQF_ONESHOT,
> +					dev_name(&pdev->dev), mb);
> +	if (err < 0)
> +		return dev_err_probe(dev, err, "Failed to register irq\n");
> +
> +	for (idx = 0; idx < MAILBOX_MAX_CHAN; idx++) {
> +		mb->priv[idx].idx = idx;
> +		mb->mbox.chans[idx].con_priv = &mb->priv[idx];
> +	}
> +
> +	err = devm_mbox_controller_register(dev, &mb->mbox);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to register mailbox\n");
> +
> +	platform_set_drvdata(pdev, mb);

cv1800_mbox_send_data() could be called even inside
devm_mbox_controller_register(), so this needs to be moved up.

> +	return 0;
> +}
> +
> +static struct platform_driver cv1800_mbox_driver = {
> +	.driver = {
> +		.name = "cv1800-mbox",
> +		.of_match_table = cv1800_mbox_of_match,
> +	},
> +	.probe	= cv1800_mbox_probe,
> +};
> +
> +module_platform_driver(cv1800_mbox_driver);
> +
> +MODULE_DESCRIPTION("cv1800 mailbox driver");
> +MODULE_LICENSE("GPL");


