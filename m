Return-Path: <linux-kernel+bounces-412330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A97089D07AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 02:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D30281DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 01:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F6238FAD;
	Mon, 18 Nov 2024 01:52:45 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D133B192
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 01:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731894764; cv=none; b=i4cRsFNMyMmcE86MHjgnudM/H90L/QEBskfMudRgETu2+MMfCrbDGQjiMjk6sN0u87JTEl+oNjHQ92nzFAEMIRxz8Hf5LGMxqfv7qf9pAfFtBpnUgzDk/bX0Wqq/76m7hq3FO1WlWNRZ0uXtVFx0Kw8sdojAIuZTEBeNEM7Bfa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731894764; c=relaxed/simple;
	bh=ywldCGbOjprysDrs4YKld2feiC2yusHyMUc50wI/AtE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fcQd3d6Uevnl8ANTh6ia3hYg0lznGBH8o5AWpmY7/IGzwCnzPkphbF5TBzYt9q4l2WS88rZah89OfOQgk8Hwgfh1GbUyA/Xakh86ZSksC4KG3xqYd958fo49E0oDfiavQuyhURrPjy/B9d9jRgfx62qTbedVY/EQFgKTerSuC74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8AxbeLnnTpnI+ZAAA--.61770S3;
	Mon, 18 Nov 2024 09:52:39 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMCxOMHinTpnw+JaAA--.6193S2;
	Mon, 18 Nov 2024 09:52:36 +0800 (CST)
Subject: Re: [PATCH] soc: loongson: add Loongson Security Module driver
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: arnd@arndb.de, olof@lixom.net, soc@lists.linux.dev,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
References: <20241116085729.12651-1-zhaoqunqin@loongson.cn>
 <8efcd579-15d5-4ea2-bbb9-f9b4969f031f@wanadoo.fr>
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
Message-ID: <4674b202-ec33-e20a-85a8-4591679488ac@loongson.cn>
Date: Mon, 18 Nov 2024 09:50:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8efcd579-15d5-4ea2-bbb9-f9b4969f031f@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMCxOMHinTpnw+JaAA--.6193S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xr4UJrWxur1rZrWxuFy8Zwc_yoWfZr4rpF
	n5JFW5GryUJrn3Jr15tryUXFy5Ar18G3ZrJFnaqF1UJrsrAr1jgr1UXF1q9r1xAr48Jr1j
	qr18WrsruF17J3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AK
	xVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8zwZ7UUUUU==


在 2024/11/16 下午5:31, Christophe JAILLET 写道:
> Le 16/11/2024 à 09:57, Qunqin Zhao a écrit :
>> This driver supports Loongson Security Module, which
>> provides the control for it's hardware encryption
>> acceleration child devices.
>>
>> Only ACPI firmware is supported.
>>
>> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
>> ---
>>   MAINTAINERS                        |   7 +
>>   drivers/soc/loongson/Kconfig       |   9 +
>>   drivers/soc/loongson/Makefile      |   1 +
>>   drivers/soc/loongson/loongson_se.c | 542 +++++++++++++++++++++++++++++
>>   include/soc/loongson/se.h          | 135 +++++++
>>   5 files changed, 694 insertions(+)
>>   create mode 100644 drivers/soc/loongson/loongson_se.c
>>   create mode 100644 include/soc/loongson/se.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fdeb3d12c..85fff2eb7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13379,6 +13379,13 @@ S:    Maintained
>>   F: Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
>>   F:    drivers/soc/loongson/loongson2_guts.c
>>   +LOONGSON SECURITY MODULE DRIVER
>> +M:    Qunqin Zhao <zhaoqunqin@loongson.cn>
>> +L:    loongarch@lists.linux.dev
>> +S:    Maintained
>> +F:    drivers/soc/loongson/loongson_se.c
>> +F:    include/soc/loongson/se.h
>> +
>>   LOONGSON-2 SOC SERIES PM DRIVER
>>   M:    Yinbo Zhu <zhuyinbo@loongson.cn>
>>   L:    linux-pm@vger.kernel.org
>> diff --git a/drivers/soc/loongson/Kconfig b/drivers/soc/loongson/Kconfig
>> index 368344943..93ef1d205 100644
>> --- a/drivers/soc/loongson/Kconfig
>> +++ b/drivers/soc/loongson/Kconfig
>> @@ -27,3 +27,12 @@ config LOONGSON2_PM
>>         Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up 
>> methods
>>         (USB, GMAC, PWRBTN, etc.). This driver was to add power 
>> management
>>         controller support that base on dts for Loongson-2 series SoCs.
>> +
>> +config LOONGSON_SE
>> +    tristate "LOONGSON SECURITY MODULE Interface"
>> +    depends on LOONGARCH && ACPI
>> +    help
>> +      The Loongson security module provides the control for hardware
>> +      encryption acceleration devices. Each device uses at least one
>> +      channel to interacts with security module, and each channel may
>
> s/interacts/interact/
>
>> +      has its own buffer provided by security module.
>
> s/has/have/
>
>> diff --git a/drivers/soc/loongson/Makefile 
>> b/drivers/soc/loongson/Makefile
>> index 4118f50f5..503075042 100644
>> --- a/drivers/soc/loongson/Makefile
>> +++ b/drivers/soc/loongson/Makefile
>> @@ -5,3 +5,4 @@
>>     obj-$(CONFIG_LOONGSON2_GUTS)        += loongson2_guts.o
>>   obj-$(CONFIG_LOONGSON2_PM)        += loongson2_pm.o
>> +obj-$(CONFIG_LOONGSON_SE)        += loongson_se.o
>> diff --git a/drivers/soc/loongson/loongson_se.c 
>> b/drivers/soc/loongson/loongson_se.c
>> new file mode 100644
>> index 000000000..d85db8423
>> --- /dev/null
>> +++ b/drivers/soc/loongson/loongson_se.c
>
> ...
>
>> +static int loongson_se_get_res(struct loongson_se *se, u32 int_bit, 
>> u32 cmd,
>> +                   struct se_data *res)
>> +{
>> +    int err = 0;
>> +
>> +    res->int_bit = int_bit;
>> +
>> +    if (se_get_response(se, res)) {
>> +        dev_err(se->dev, "Int 0x%x get response fail.\n", int_bit);
>> +        return -EFAULT;
>> +    }
>> +
>> +    /* Check response */
>> +    if (res->u.res.cmd == cmd)
>> +        err = 0;
>
> Not needed, err is already 0.
>
>> +    else {
>> +        dev_err(se->dev, "Response cmd is 0x%x, not expect cmd 
>> 0x%x.\n",
>> +            res->u.res.cmd, cmd);
>> +        err = -EFAULT;
>> +    }
>> +
>> +    return err;
>> +}
>
> ...
>
>> +static int loongson_se_set_msg(struct lsse_ch *ch)
>> +{
>> +    struct loongson_se *se = ch->se;
>> +    struct se_data req = {0};
>> +    struct se_data res = {0};
>> +    int err;
>> +
>> +    req.int_bit = SE_INT_SETUP;
>> +    req.u.gcmd.cmd = SE_CMD_SETMSG;
>> +    /* MSG off */
>> +    req.u.gcmd.info[0] = ch->id;
>> +    req.u.gcmd.info[1] = ch->smsg - se->mem_base;
>> +    req.u.gcmd.info[2] = ch->msg_size;
>> +
>> +    dev_dbg(se->dev, "Set Channel %d msg off 0x%x, msg size %d\n",
>> +        ch->id, req.u.gcmd.info[1], req.u.gcmd.info[2]);
>> +
>> +    err = se_send_genl_cmd(se, &req, &res, 5);
>> +    if (res.u.res.cmd_ret)
>
> In the fnction above, we test (err || ...)
> Is it needed here as well (or can it be removed in se_send_genl_cmd())
>
> Also, below se_send_genl_cmd() errors are checked only with err.
> Should it be consistent?

The above function may need to be tried again, so both values need to be 
checked.

However, this function only needs to return an error value.

Others agreed.

Thanks.

>
>> +        return res.u.res.cmd_ret;
>> +
>> +    return err;
>> +}
>
> ...
>
>> +void se_deinit_ch(struct lsse_ch *ch)
>> +{
>> +    struct loongson_se *se = ch->se;
>> +    unsigned long flag;
>> +    int first, nr;
>> +    int id = ch->id;
>> +
>> +    if (!se) {
>> +        pr_err("SE has bot been initialized\n");
>> +        return;
>> +    }
>> +
>> +    if (id == 0 || id > SE_CH_MAX) {
>> +        dev_err(se->dev, "Channel number %d is invalid\n", id);
>> +        return;
>> +    }
>> +
>> +    if (!se_ch_status(se, BIT(id))) {
>> +        dev_err(se->dev, "Channel number %d has not been 
>> initialized\n", id);
>> +        return;
>> +    }
>> +
>> +    spin_lock_irqsave(&se->dev_lock, flag);
>> +
>> +    se->ch_status &= ~BIT(ch->id);
>> +
>> +    first = (ch->data_buffer - se->mem_base) / PAGE_SIZE;
>> +    nr = round_up(ch->data_size, PAGE_SIZE) / PAGE_SIZE;
>> +    bitmap_clear(se->mem_map, first, nr);
>> +
>> +    first = (ch->smsg - se->mem_base) / PAGE_SIZE;
>> +    nr = round_up(ch->msg_size, PAGE_SIZE) / PAGE_SIZE;
>> +    bitmap_clear(se->mem_map, first, nr);
>> +
>> +    se_disable_int(se, ch->int_bit);
>> +
>> +    spin_unlock_irqrestore(&se->dev_lock, flag);
>> +
>
> Uneeded empty line
>
>> +}
>> +EXPORT_SYMBOL_GPL(se_deinit_ch);
>> +
>> +static int loongson_se_probe(struct platform_device *pdev)
>> +{
>> +    struct loongson_se *se;
>> +    struct device *dev = &pdev->dev;
>> +    int nr_irq, irq, err, size;
>> +
>> +    se = devm_kmalloc(dev, sizeof(*se), GFP_KERNEL);
>> +    if (!se)
>> +        return -ENOMEM;
>> +    se->dev = dev;
>> +    dev_set_drvdata(dev, se);
>> +    init_completion(&se->cmd_completion);
>> +    spin_lock_init(&se->cmd_lock);
>> +    spin_lock_init(&se->dev_lock);
>> +    /* Setup DMA buffer */
>> +    dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>> +    if (device_property_read_u32(dev, "dmam_size", &size))
>> +        return -ENODEV;
>> +    size = roundup_pow_of_two(size);
>> +    se->mem_base = dmam_alloc_coherent(dev, size, &se->mem_addr, 
>> GFP_KERNEL);
>> +    if (!se->mem_base)
>> +        return -ENOMEM;
>> +    memset(se->mem_base, 0, size);
>
> I don't think that it is needed. dmam_alloc_coherent() should return 
> zeroed memory.
>
>> +    se->mem_map_pages = size / PAGE_SIZE;
>> +    se->mem_map = devm_bitmap_zalloc(dev, se->mem_map_pages, 
>> GFP_KERNEL);
>> +    if (!se->mem_map)
>> +        return -ENOMEM;
>> +
>> +    se->base = devm_platform_ioremap_resource(pdev, 0);
>> +    if (IS_ERR(se->base))
>> +        return PTR_ERR(se->base);
>> +
>> +    nr_irq = platform_irq_count(pdev);
>> +    if (nr_irq <= 0)
>> +        return -ENODEV;
>> +    while (nr_irq) {
>> +        irq = platform_get_irq(pdev, --nr_irq);
>> +        if (irq < 0)
>> +            return -ENODEV;
>> +        /* Use the same interrupt handler address.
>> +         * Determine which irq it is accroding
>> +         * SE_S2LINT_STAT register.
>> +         */
>> +        err = devm_request_irq(dev, irq, se_irq, 0,
>> +                       "loongson-se", se);
>> +        if (err)
>> +            dev_err(dev, "failed to request irq: %d\n", err);
>> +    }
>> +
>> +    err = se_init_hw(se, se->mem_addr, size);
>> +    if (err)
>> +        se_disable_hw(se);
>> +
>> +    return err;
>> +}
>> +
>> +static struct acpi_device_id loongson_se_acpi_match[] = {
>
> const?
>
>> +    {"LOON0011", 0},
>> +    {}
>> +};
>> +MODULE_DEVICE_TABLE(acpi, loongson_se_acpi_match);
>
> ...
>
> CJ


