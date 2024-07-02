Return-Path: <linux-kernel+bounces-238000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 755739241F0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A80E3B27EF0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBA21BB695;
	Tue,  2 Jul 2024 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdB5vvsR"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69411BB6AD;
	Tue,  2 Jul 2024 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932926; cv=none; b=LW/dHE5rOADjcQd0Y7Jvk2TgFt49MFmjF7z8VvTc7S0P/JZVjpX/Afv8XQR4NPZzWu4jiIwryIYFmHjOT/avsvFhkv6LhKuITh8kAAj5dY2Jw4qRrkup0qf36Asw361qoaUYzb+MBXAiCgpCZY/bdwTlFNu669yD19tnlyYMb2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932926; c=relaxed/simple;
	bh=jQWkuFaUrIXWFQJfEgCNzBBpR41YwACdk7IdlYSYbd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wl51BRDQnZfRKxRVZ+9//suw18LDuhkqsoMUuyirEQeLQugtLSO9JeOIIxDqxCmGKeeZ1qUUnSoIOvovdoUZSJnsunp0ctKbDj+sn9CZ0jGvF+vrY/KXv2/SFBUTlNdYcWzqO9k7LXJCx2T5sYBe9QCEELEoZvv3yigzoBENw/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdB5vvsR; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7182a634815so2590912a12.3;
        Tue, 02 Jul 2024 08:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719932924; x=1720537724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ctXZQ3OEJ+XlGufIJb9yNX6233ubUXWM36kc4cCWQME=;
        b=QdB5vvsRfYOIvnI1ORN5niT6WGfg3XAVCiw2vxhn7gwj1nsFK5THS68hcmb8kei90U
         vXINJD6r9n6pdJp9Bz0ijimT8FtpYERBGAPgsGUUdmBhiBbTEazHDC+0qjJ4dQtdx1JF
         0BRxTGowJzpd0azlLWc8b4/IdMJndgs+hCHku5SXtl4WGkPus6fil7+EOfAaX8NDld1e
         9tveOZYGSp/2CvtYKHl0+tgdApso33XBleXvBpxMzD8zSbvY8LthYJrqnQmOjn9/kYbA
         VLbMr1ziEcQ8xKNG/w92Kh2nvynAz7dPTyEW4urJmYb+dkKN/IbHGcFLonIzRN9m/mjA
         XDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719932924; x=1720537724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ctXZQ3OEJ+XlGufIJb9yNX6233ubUXWM36kc4cCWQME=;
        b=BnivpqSoRDMLON1yAhVw8jP1/nR2ENaFzt3ofhQkrXb7ojb2Sb50n0fmVnNe9b/8ad
         B6eiB1q7my+28KtDOVKZki3uhWoMq2tHksJ9L9ZWNVbq1IMsmKL7vgx8k+yrk2y+qzTS
         6IALRkSTHf+Em6Hqcf7baxr69RTp0tGJ19OpTgCc3jLEAXzi/pYYgos8OFJm09L9iqvC
         bv5tKNCgUdB1/L3Din9MEhyvEgNLhLErSIwHtoGxCgtN88tugTJh8AgvFwuLRdMmt4PQ
         NJEsE5Bnxqs/8QXf0GviORmp68Wld1Gbr2upiIpoUxO62lBKapodjB9YV2W7MIpkaHd5
         pe9A==
X-Forwarded-Encrypted: i=1; AJvYcCWAhZtObJsS+i4A8VdCmpG7/YK9E+eHcMVfMcuhmsSU2++T7lzhv+A2DmiuaJk1ydY6kBbsrq0FmHE1ZHyHxg4qmSnvjD+QkyIpkx0G4jNS66BNAWyY/9fPig8H1UIJPSA9TGVPB74Vjg==
X-Gm-Message-State: AOJu0Yws8/0H0rNMSLGdFWvb6ToASVb5Fi3sEoSDlUWY0tUeldUEL6Gy
	u/cKOmF4ZVbxz7z7hcs6zpeZ9fsVcY4SqleesPh+DhT0eCr8ygCC
X-Google-Smtp-Source: AGHT+IGmiKmNF8ljuzN+S5KQnG0L2B3akXVzUTZ3G1U2BN5D/wkDQk4K8Bey1qCtYvVJLYpF+DwgvQ==
X-Received: by 2002:a05:6a20:258a:b0:1be:cd15:aeeb with SMTP id adf61e73a8af0-1bef60e3f2dmr9232326637.6.1719932922165;
        Tue, 02 Jul 2024 08:08:42 -0700 (PDT)
Received: from [127.0.0.1] ([104.224.80.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e3a1dsm85302535ad.68.2024.07.02.08.08.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 08:08:41 -0700 (PDT)
Message-ID: <cf4a9281-a28b-48f6-a53b-27df01980af6@gmail.com>
Date: Tue, 2 Jul 2024 23:08:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] mailbox: sophgo: add mailbox driver for cv18x SoCs
To: d1581209858@live.com
Cc: aou@eecs.berkeley.edu, conor+dt@kernel.org, devicetree@vger.kernel.org,
 inochiama@outlook.com, jassisinghbrar@gmail.com, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org,
 unicorn_wang@outlook.com
References: <SYBP282MB2238DE0DA19C6EF411B2356CC4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
 <SYBP282MB2238F93AB57A398E322644C3C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Junhui Liu <liujh2818@gmail.com>
In-Reply-To: <SYBP282MB2238F93AB57A398E322644C3C4CE2@SYBP282MB2238.AUSP282.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Yuntao,

On 2024/6/18 23:12, Yuntao Dai wrote:
> Add mailbox controller driver for cv18x SoCs, tested on mailbox-test
> client.
>
> Signed-off-by: Yuntao Dai <d1581209858@live.com>
> ---
>   drivers/mailbox/Kconfig           |  11 ++
>   drivers/mailbox/Makefile          |   2 +
>   drivers/mailbox/cv1800b-mailbox.c | 181 ++++++++++++++++++++++++++++++
>   3 files changed, 194 insertions(+)
>   create mode 100644 drivers/mailbox/cv1800b-mailbox.c
>
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 3b8842c4a..4e5593861 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -286,4 +286,15 @@ config QCOM_IPCC
>   	  acts as an interrupt controller for receiving interrupts from clients.
>   	  Say Y here if you want to build this driver.
>   
> +config CV1800B_MBOX
> +	tristate "cv1800b mailbox"
> +	depends on OF
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	help
> +	  Mailbox driver implementation for Sophgo cv180x SoCs. This driver
> +	  can be used to send message between different processors in SoC. Any
> +	  processer can write data in a channel, and set co-responding register
> +	  to raise interrupt to notice another processor, and it is allowed to
> +	  send data to itself.
> +
>   endif
> diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
> index 5cf2f54de..71f0f746e 100644
> --- a/drivers/mailbox/Makefile
> +++ b/drivers/mailbox/Makefile
> @@ -62,3 +62,5 @@ obj-$(CONFIG_SUN6I_MSGBOX)	+= sun6i-msgbox.o
>   obj-$(CONFIG_SPRD_MBOX)		+= sprd-mailbox.o
>   better
>   obj-$(CONFIG_QCOM_IPCC)		+= qcom-ipcc.o
> +
> +obj-$(CONFIG_CV1800B_MBOX)	+= cv1800b-mailbox.o
> \ No newline at end of file
> diff --git a/drivers/mailbox/cv1800b-mailbox.c b/drivers/mailbox/cv1800b-mailbox.c
> new file mode 100644
> index 000000000..8ef2a5492
> --- /dev/null
> +++ b/drivers/mailbox/cv1800b-mailbox.c
> @@ -0,0 +1,181 @@
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
> +struct cv1800b_mbox {
> +	struct mbox_controller mbox;
> +	struct mbox_chan chans[MAILBOX_MAX_CHAN];
> +	u64 *content[MAILBOX_MAX_CHAN];
> +	void __iomem *mbox_base;
> +	int sendto;
> +	int recvid;
> +};
> +
> +static irqreturn_t cv1800b_mbox_isr(int irq, void *dev_id)
> +{
> +	struct cv1800b_mbox *mbox = (struct cv1800b_mbox *)dev_id;
> +	size_t i;
> +
> +	for (i = 0; i < MAILBOX_MAX_CHAN; i++) {
> +		if (mbox->content[i]) {
> +			mbox_chan_received_data(&mbox->chans[i],
> +						mbox->content[i]);
I tested this driver but met "NULL pointer dereference" Oops here
when I sent message from the c906l core without binding clients.

I think maybe it's better to add a check here, like:

struct mbox_chan *chan = &mbox->chans[i];
if (chan->cl) {
     mbox_chan_received_data(chan, mbox->content[i]);
}

Best,
Junhui Liu

> +			mbox->content[i] = NULL;
> +			return IRQ_HANDLED;
> +		}
> +	}
> +	return IRQ_NONE;
> +}
> +
> +static irqreturn_t cv1800b_mbox_irq(int irq, void *dev_id)
> +{
> +	struct cv1800b_mbox *mbox = (struct cv1800b_mbox *)dev_id;
> +	u8 set, valid;
> +	u64 *addr;
> +	size_t i;
> +
> +	set = readb(mbox->mbox_base + MBOX_SET_INT_REG(mbox->recvid));
> +
> +	if (!set)
> +		return IRQ_NONE;
> +
> +	for (i = 0; i < MAILBOX_MAX_CHAN; i++) {
> +		valid = set & (1 << i);
> +		addr = (u64 *)(mbox->mbox_base + MAILBOX_CONTEXT_OFFSET) + i;
> +		if (valid) {
> +			mbox->content[i] = addr;
> +			writeb(valid, mbox->mbox_base +
> +					      MBOX_SET_CLR_REG(mbox->recvid));
> +			writeb(~valid,
> +			       mbox->mbox_base + MBOX_EN_REG(mbox->recvid));
> +			return IRQ_WAKE_THREAD;
> +		}
> +	}
> +
> +	return IRQ_NONE;
> +}
> +
> +static int cv1800b_mbox_send_data(struct mbox_chan *chan, void *data)
> +{
> +	struct cv1800b_mbox *mbox = dev_get_drvdata(chan->mbox->dev);
> +	int idx = (int)chan->con_priv;
> +	u8 en, valid;
> +	u64 *addr = (u64 *)(mbox->mbox_base + MAILBOX_CONTEXT_OFFSET) + idx;
> +
> +	memcpy_toio(addr, data, 8);
> +
> +	valid = 1 << idx;
> +	writeb(valid, mbox->mbox_base + MBOX_SET_CLR_REG(mbox->sendto));
> +	en = readb(mbox->mbox_base + MBOX_EN_REG(mbox->sendto));
> +	writeb(en | valid, mbox->mbox_base + MBOX_EN_REG(mbox->sendto));
> +	writeb(valid, mbox->mbox_base + MBOX_SET_REG);
> +
> +	return 0;
> +}
> +
> +static bool cv1800b_last_tx_done(struct mbox_chan *chan)
> +{
> +	return true;
> +}
> +
> +static const struct mbox_chan_ops cv1800b_mbox_chan_ops = {
> +	.send_data = cv1800b_mbox_send_data,
> +	.last_tx_done = cv1800b_last_tx_done,
> +};
> +
> +static const struct of_device_id cv1800b_mbox_of_match[] = {
> +	{ .compatible = "sophgo,cv1800b-mailbox", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, cv1800b_mbox_of_match);
> +
> +static int cv1800b_mbox_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cv1800b_mbox *mb;
> +	int irq, idx, err, cpu;
> +
> +	if (!dev->of_node)
> +		return -ENODEV;
> +
> +	mb = devm_kzalloc(dev, sizeof(*mb), GFP_KERNEL);
> +	if (!mb)
> +		return -ENOMEM;
> +
> +	mb->mbox_base = devm_of_iomap(dev, dev->of_node, 0, NULL);
> +	if (IS_ERR(mb->mbox_base))
> +		return dev_err_probe(dev, PTR_ERR(mb->mbox_base),
> +				     "Failed to map resource\n");
> +
> +	err = of_property_read_s32(dev->of_node, "sendto", &cpu);
> +	if (err)
> +		return dev_err_probe(dev, err,
> +				     "Failed to find <sendto> in of_node\n");
> +
> +	mb->sendto = cpu;
> +
> +	err = of_property_read_s32(dev->of_node, "recvid", &cpu);
> +	if (err) {
> +		return dev_err_probe(dev, err,
> +				     "Failed to find <recvid> in of_node\n");
> +	}
> +	mb->recvid = cpu;
> +
> +	mb->mbox.dev = dev;
> +	mb->mbox.num_chans = MAILBOX_MAX_CHAN;
> +	mb->mbox.chans = mb->chans;
> +	mb->mbox.ops = &cv1800b_mbox_chan_ops;
> +	mb->mbox.txdone_poll = true;
> +
> +	irq = platform_get_irq_byname(pdev, "mailbox");
> +	err = devm_request_threaded_irq(dev, irq, cv1800b_mbox_irq,
> +					cv1800b_mbox_isr, IRQF_ONESHOT,
> +					dev_name(&pdev->dev), mb);
> +	if (err < 0)
> +		return dev_err_probe(dev, err, "Failed to register irq\n");
> +
> +	for (idx = 0; idx < MAILBOX_MAX_CHAN; idx++)
> +		mb->mbox.chans[idx].con_priv = (void *)idx;
> +
> +	err = devm_mbox_controller_register(dev, &mb->mbox);
> +	if (err)
> +		return dev_err_probe(dev, err, "Failed to register mailbox\n");
> +
> +	platform_set_drvdata(pdev, mb);
> +	return 0;
> +}
> +
> +static struct platform_driver cv1800b_mbox_driver = {
> +	.driver = {
> +		.name = "cv1800b-mbox",
> +		.of_match_table = cv1800b_mbox_of_match,
> +	},
> +	.probe	= cv1800b_mbox_probe,
> +};
> +
> +module_platform_driver(cv1800b_mbox_driver);
> +
> +MODULE_DESCRIPTION("cv1800b mailbox driver");
> +MODULE_LICENSE("GPL");

