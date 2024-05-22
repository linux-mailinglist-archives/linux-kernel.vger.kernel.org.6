Return-Path: <linux-kernel+bounces-186644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21F88CC6C9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 21:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDF03B2128D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 19:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82740146588;
	Wed, 22 May 2024 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6cDF2fT"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6621CD16;
	Wed, 22 May 2024 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716405612; cv=none; b=bTkIPC5/P9l2R7VxChxB6szqYWzxWtvRkZu+LjAs+kT3Nyd476Don4qO49vOlKpGya1aVzxHAv+JJAIiwJYlDpd3IV+iwl5A1vUo4IM3J885qTEtVgs5Fh+sIX6erPKPd2NGrX8D/HGukuGmpMcWxz8OGHbd8W6kEllRKCnnbWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716405612; c=relaxed/simple;
	bh=qXzBKLa/2vH+6rPMu/HQ3cd7kmlNPPimpw21pAKLjQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CakEALTYfuo8Zg++XqPZulV8XFO5UOf6NggYerRVG7T66o9x/W9BvNyzrGxDCI8TZ7kEDJRxt4UK+PF8McJFQ7TOsO7yZFBW9Nxw+K3kJbfQPPyUQ1X7cR48HDzrZPct9N7WZAZ3kEIKb4IOHpBGMGWYs3XhKvS3khthpgnl1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6cDF2fT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a623cf7764bso22171566b.1;
        Wed, 22 May 2024 12:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716405609; x=1717010409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qXzBKLa/2vH+6rPMu/HQ3cd7kmlNPPimpw21pAKLjQc=;
        b=S6cDF2fT7FbMG0NPXPykOENwQ8Zcf22Yndwep1HvijvYnvLLQX6cHU0S1FSiWJKl1e
         u/ccE6dUPkawAxEkWIgHicZF4Eb8kHvpR2oT7gn/DP7tgNYNPEVTIP6QHAuRtf30dyVW
         t6HWmhCPTA3ag5VminEydObVzTVfH3/mGTFhdYp6SfLj27V4Z27svbTW3T+QPJiiQwm4
         aebEZZNRYCf+n29M8by8H/3zH7eP7rYDBHJV5aXtWgqTBEvXKe83qRPf2nyoSrt3kbwP
         LHn6tWq2AO95gY7gLT1k8AavJMtVHYUxEddk92lALJJErqL/Jd/WU8Hcb4h5MATUbeEN
         pqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716405609; x=1717010409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXzBKLa/2vH+6rPMu/HQ3cd7kmlNPPimpw21pAKLjQc=;
        b=PZlVHp3D+ngl8TpzpFG5+pvuOVgaNQOZZaEtxf63VHZNLVaZAnoruohpLfMeSVMCUZ
         1t3OPuqy+lFM1WlHYNpt+FFA1jbhPN/XXeaAH6PlQFmEqPQqbglFqS/aqvwDBPEOLMQz
         WAZWG+mkBW7KSIHyFP65bxK/iW3OJKw0tRpH7BEU8UyPWEcldWRlrmvESHtkQEcQu6qD
         ddZbVhwXui3UpGb3ttlN0aQ8q97dTcghfzFwxRU9RHXsw/7IB345nRzXL/1jSv0enRej
         L3tOo8HMHHgqllipastT0PULs8fPlsuTd6jMN1wfERVCCBFqF9/P0IPBhV71NFVpYu9V
         roXg==
X-Forwarded-Encrypted: i=1; AJvYcCUXom83XDrX9WvsC+zfugHWLmBIWAGxKaOPYjRYchch4bZZSzpYqWPAZ8gwMceGe61TaL4SI/AuSwuJ4YbxfoUZGrGOjlXYrv6Ex5C7CY0RCv3CattOewpBsDP1Y2CnSRFGsZh3bYIc/A==
X-Gm-Message-State: AOJu0YyGUskRs2lUL78WVp/7Mq6Vligt1hWufETOhHR1esZ7D9ZG5wVb
	tYRFH2RfGoBloQ16hHz9of7AkLa+D43YhvIqHjOrmr2W7f0TNgJh
X-Google-Smtp-Source: AGHT+IEiGXuZfJanjugmhekGCcABA0a3U1vGrSOTHp1COahUF5FeiP6lSedr0EY4pGGKZXWst/v81A==
X-Received: by 2002:a17:906:d8d1:b0:a5a:177b:d8d2 with SMTP id a640c23a62f3a-a623e8f87a3mr13393566b.22.1716405608942;
        Wed, 22 May 2024 12:20:08 -0700 (PDT)
Received: from ?IPV6:2a02:2f00:503:7c00:503d:ca7a:1fd6:cd63? ([2a02:2f00:503:7c00:503d:ca7a:1fd6:cd63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17891f6esm1820514066b.54.2024.05.22.12.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 12:20:08 -0700 (PDT)
Message-ID: <131e46b1-61d9-41de-a225-853b09c765d1@gmail.com>
Date: Wed, 22 May 2024 22:20:07 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] reset: add driver for imx8ulp SIM reset controller
Content-Language: en-US
To: Amit Singh Tomar <amitsinght@marvell.com>, Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Liu Ying <victor.liu@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 laurentiu.mihalcea@nxp.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240516204031.171920-1-laurentiumihalcea111@gmail.com>
 <20240516204031.171920-3-laurentiumihalcea111@gmail.com>
 <ade33946-bb94-4357-bc6d-a354661b50ca@marvell.com>
 <Zkd0uIaJiwzYrBIK@lizhi-Precision-Tower-5810>
 <fc91b997-f90b-4e3c-9a89-5db932ba148c@marvell.com>
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <fc91b997-f90b-4e3c-9a89-5db932ba148c@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/20/2024 5:41 PM, Amit Singh Tomar wrote:
>
>>
>> ----------------------------------------------------------------------
>> On Fri, May 17, 2024 at 11:51:30AM +0530, Amit Singh Tomar wrote:
>>> Hi,
>>>
>>>> ----------------------------------------------------------------------
>>>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>>>
>>>> Certain components can be reset via the SIM module.
>>>> Add reset controller driver for the SIM module to
>>>> allow drivers for said components to control the
>>>> reset signal(s).
>>>>
>>>> Signed-off-by: Liu Ying <victor.liu@nxp.com>
>>>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>>> ---
>>>>    drivers/reset/Kconfig                         |  7 ++
>>>>    drivers/reset/Makefile                        |  1 +
>>>>    drivers/reset/reset-imx8ulp-sim.c             | 98 +++++++++++++++++++
>>>
>>> Just out of curiosity, can't this be accomplished using a generic reset
>>> driver?
>>>
>>> https://urldefense.proofpoint.com/v2/url?u=https-3A__elixir.bootlin.com_linux_latest_source_drivers_reset_reset-2Dsimple.c&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=MnEcoegPnKc-F7TNf8PB3icMf8uCGrxsh6mEDWgNq3YA-OugL6Y53LxytlBGcsKp&s=6mBPHYYYXoyyxPPbUeOiIpwR3CXdnui1W3nkUJQ76Vo&e=
>>
>> reset-simple have not use regmap. I think it can use ti's
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__elixir.bootlin.com_linux_latest_source_drivers_reset_reset-2Dti-2Dsyscon.c&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=MnEcoegPnKc-F7TNf8PB3icMf8uCGrxsh6mEDWgNq3YA-OugL6Y53LxytlBGcsKp&s=D6tqLNYrUbsdG_gYg4G-ORlC9YKz4XRAlVeo1hyoYS4&e=
>>
>> Or should change ti to reset-simple-syscon?  or add regmap support for
>> reset-simple.c
>>
>
> Quickly looked into U-Boot (not sure if it's the right reference), and it has a separate reset-syscon.c file:
>
> https://elixir.bootlin.com/u-boot/latest/source/drivers/reset/reset-syscon.c
>
> So, converting reset-ti-syscon.c to reset-syscon.c might be the way to go.

A few comments here: current version of the patch is wrong because
the reset controller driver doesn't get probed. If my understanding
is correct this is because the syscon driver doesn't create devices
for its children (via of_platform_populate() or its variants).

I plan to fix this in V2 by transforming the syscon parent node into
a syscon + reset controller node (+ the of_platform_populate() call
in the driver for the mux controller probe).

In this case, I think TI's reset driver will no longer be an option.

>
>> Frank Li
>>
>>
>>>
>>>>    include/dt-bindings/reset/imx8ulp-sim-reset.h | 16 +++
>>>>    4 files changed, 122 insertions(+)
>>>>    create mode 100644 drivers/reset/reset-imx8ulp-sim.c
>>>>    create mode 100644 include/dt-bindings/reset/imx8ulp-sim-reset.h
>>>>
>>>> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
>>>> index 85b27c42cf65..c1f4d9ebd0fd 100644
>>>> --- a/drivers/reset/Kconfig
>>>> +++ b/drivers/reset/Kconfig
>>>> @@ -91,6 +91,13 @@ config RESET_IMX7
>>>>        help
>>>>          This enables the reset controller driver for i.MX7 SoCs.
>>>> +config RESET_IMX8ULP_SIM
>>>> +    tristate "i.MX8ULP SIM Reset Driver"
>>>> +    depends on ARCH_MXC
>>>> +    help
>>>> +      This enables the SIM (System Integration Module) reset driver
>>>> +      for the i.MX8ULP SoC.
>>>> +
>>>>    config RESET_INTEL_GW
>>>>        bool "Intel Reset Controller Driver"
>>>>        depends on X86 || COMPILE_TEST
>>>> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
>>>> index fd8b49fa46fc..f257d6a41f1e 100644
>>>> --- a/drivers/reset/Makefile
>>>> +++ b/drivers/reset/Makefile
>>>> @@ -42,3 +42,4 @@ obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
>>>>    obj-$(CONFIG_RESET_UNIPHIER_GLUE) += reset-uniphier-glue.o
>>>>    obj-$(CONFIG_RESET_ZYNQ) += reset-zynq.o
>>>>    obj-$(CONFIG_ARCH_ZYNQMP) += reset-zynqmp.o
>>>> +obj-$(CONFIG_RESET_IMX8ULP_SIM) += reset-imx8ulp-sim.o
>>>> diff --git a/drivers/reset/reset-imx8ulp-sim.c b/drivers/reset/reset-imx8ulp-sim.c
>>>> new file mode 100644
>>>> index 000000000000..27923b9cd454
>>>> --- /dev/null
>>>> +++ b/drivers/reset/reset-imx8ulp-sim.c
>>>> @@ -0,0 +1,98 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +
>>>> +/*
>>>> + * Copyright 2024 NXP
>>>> + */
>>>> +
>>>> +#include <linux/mfd/syscon.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/regmap.h>
>>>> +#include <linux/reset-controller.h>
>>>> +#include <dt-bindings/reset/imx8ulp-sim-reset.h>
>>>> +
>>>> +#define AVD_SIM_SYSCTRL0        0x8
>>>> +
>>>> +struct imx8ulp_sim_reset {
>>>> +    struct reset_controller_dev     rcdev;
>>>> +    struct regmap                   *regmap;
>>>> +};
>>>> +
>>>> +static const u32 imx8ulp_sim_reset_bits[IMX8ULP_SIM_RESET_NUM] = {
>>>> +    [IMX8ULP_SIM_RESET_MIPI_DSI_RST_DPI_N] = BIT(3),
>>>> +    [IMX8ULP_SIM_RESET_MIPI_DSI_RST_ESC_N] = BIT(4),
>>>> +    [IMX8ULP_SIM_RESET_MIPI_DSI_RST_BYTE_N] = BIT(5),
>>>> +};
>>>> +
>>>> +static inline struct imx8ulp_sim_reset *
>>>> +to_imx8ulp_sim_reset(struct reset_controller_dev *rcdev)
>>>> +{
>>>> +    return container_of(rcdev, struct imx8ulp_sim_reset, rcdev);
>>>> +}
>>>> +
>>>> +static int imx8ulp_sim_reset_assert(struct reset_controller_dev *rcdev,
>>>> +                    unsigned long id)
>>>> +{
>>>> +    struct imx8ulp_sim_reset *simr = to_imx8ulp_sim_reset(rcdev);
>>>> +    const u32 bit = imx8ulp_sim_reset_bits[id];
>>>> +
>>>> +    return regmap_update_bits(simr->regmap, AVD_SIM_SYSCTRL0, bit, 0);
>>>> +}
>>>> +
>>>> +static int imx8ulp_sim_reset_deassert(struct reset_controller_dev *rcdev,
>>>> +                      unsigned long id)
>>>> +{
>>>> +    struct imx8ulp_sim_reset *simr = to_imx8ulp_sim_reset(rcdev);
>>>> +    const u32 bit = imx8ulp_sim_reset_bits[id];
>>>> +
>>>> +    return regmap_update_bits(simr->regmap, AVD_SIM_SYSCTRL0, bit, bit);
>>>> +}
>>>> +
>>>> +static const struct reset_control_ops imx8ulp_sim_reset_ops = {
>>>> +    .assert         = imx8ulp_sim_reset_assert,
>>>> +    .deassert       = imx8ulp_sim_reset_deassert,
>>>> +};
>>>> +
>>>> +static const struct of_device_id imx8ulp_sim_reset_dt_ids[] = {
>>>> +    { .compatible = "nxp,imx8ulp-avd-sim-reset", },
>>>> +    { /* sentinel */ },
>>>> +};
>>>> +
>>>> +static int imx8ulp_sim_reset_probe(struct platform_device *pdev)
>>>> +{
>>>> +    struct device *dev = &pdev->dev;
>>>> +    struct imx8ulp_sim_reset *simr;
>>>> +    int ret;
>>>> +
>>>> +    simr = devm_kzalloc(dev, sizeof(*simr), GFP_KERNEL);
>>>> +    if (!simr)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    simr->regmap = syscon_node_to_regmap(dev->of_node->parent);
>>>> +    if (IS_ERR(simr->regmap)) {
>>>> +        ret = PTR_ERR(simr->regmap);
>>>> +        dev_err(dev, "failed to get regmap: %d\n", ret);
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    simr->rcdev.owner = THIS_MODULE;
>>>> +    simr->rcdev.nr_resets = IMX8ULP_SIM_RESET_NUM;
>>>> +    simr->rcdev.ops = &imx8ulp_sim_reset_ops;
>>>> +    simr->rcdev.of_node = dev->of_node;
>>>> +
>>>> +    return devm_reset_controller_register(dev, &simr->rcdev);
>>>> +}
>>>> +
>>>> +static struct platform_driver imx8ulp_sim_reset_driver = {
>>>> +    .probe  = imx8ulp_sim_reset_probe,
>>>> +    .driver = {
>>>> +        .name           = KBUILD_MODNAME,
>>>> +        .of_match_table = imx8ulp_sim_reset_dt_ids,
>>>> +    },
>>>> +};
>>>> +module_platform_driver(imx8ulp_sim_reset_driver);
>>>> +
>>>> +MODULE_AUTHOR("Liu Ying <victor.liu@nxp.com>");
>>>> +MODULE_DESCRIPTION("NXP i.MX8ULP System Integration Module Reset driver");
>>>> +MODULE_LICENSE("GPL");
>>>> diff --git a/include/dt-bindings/reset/imx8ulp-sim-reset.h b/include/dt-bindings/reset/imx8ulp-sim-reset.h
>>>> new file mode 100644
>>>> index 000000000000..a3cee0d60773
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/reset/imx8ulp-sim-reset.h
>>>> @@ -0,0 +1,16 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
>>>> +
>>>> +/*
>>>> + * Copyright 2024 NXP
>>>> + */
>>>> +
>>>> +#ifndef DT_BINDINGS_RESET_IMX8ULP_SIM_RESET_H
>>>> +#define DT_BINDINGS_RESET_IMX8ULP_SIM_RESET_H
>>>> +
>>>> +#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_DPI_N    0
>>>> +#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_ESC_N    1
>>>> +#define IMX8ULP_SIM_RESET_MIPI_DSI_RST_BYTE_N   2
>>>> +
>>>> +#define IMX8ULP_SIM_RESET_NUM                   3
>>>> +
>>>> +#endif /* DT_BINDINGS_RESET_IMX8ULP_SIM_RESET_H */
>>>
>


