Return-Path: <linux-kernel+bounces-228347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1487C915E86
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB591F2273D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17F0145B3F;
	Tue, 25 Jun 2024 05:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r0a/wpd7"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7807D1448C5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 05:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719295137; cv=none; b=IvA750ztgWdZvr8RJXYrdNOjHNNQ25PqgLFuU0d95PalDD3QuPwgpSyDnABscHCEU3tBOAVtSxLUtdudcXKUxwsM2VhblhGgrMnriWqhxYK6ZZmPR7C2jeZDcbmnYbYiVJF+gJUhIOOH07LkmdK3Va2FunDf6b6tM3rsEIGHlK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719295137; c=relaxed/simple;
	bh=XQCmf27Ylxkt/CeNjMw9wYOcCNe/zvY4fjCovTUwlhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLA/QOO+7ZV+ltJiviUmKHvXprDCDGoGdNzQRHVzSj9WJjCcY84X+EVc0TrR/o6Qpo20MnW7rmDw6Gc3UP8zW1ThlCb+eJAQrVTZb7pFmUzrRBH5MsmCD1pLZJ6pCyfsJ+avfbyC+1mKVhEfkZKKIlFAJdGc8Kyrp/mQWkTvYBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r0a/wpd7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42179dafd6bso35889345e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719295133; x=1719899933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MEh/17Aqb0CF0XY9Y7f3T5FZpR/u2UEtrCW8T4woPmU=;
        b=r0a/wpd7SN0MxdFR2oZPhcOSe3U/YvAuJ0aBrjaE+i/P8KfQd6hlwGFjCpIyNrcIAs
         qP3mlKHv1LvNctxvJBq+rqldUT8M1Fc8/53lPuUe7keeHkYoX/0DHpKTh655gL/BMkJs
         o/sRJlgwUC2GNbZVYZpRgacpobxjmB1GDKmI54TyRxvAYESQ5SBdFmjN2iOtPvZKC4Ti
         +qE6y+Ja/R0Nw6QGSrIceu9y8HHJMbkE7A0D6M/FXCh8EzC8yhnC07jcdV2VnSx5Y2eM
         pASl/g7hwj2J2IJDbv8a0kvZSrkG+LkVhSIffCBmeZH+pbM4MGybGGtNYS5TL/o+nKfX
         GJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719295133; x=1719899933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEh/17Aqb0CF0XY9Y7f3T5FZpR/u2UEtrCW8T4woPmU=;
        b=lj8p/oOsgOtgiwFSX4cyrKj7fWCx2QBvU412Bd/2gdAjx7eD5D4h9exrvGTSv1zhrU
         +E0gNMdmWsm3Yh1N6221qj6YGmHfbR3kwhEwYn1au4UsI+EL21oFL5Tn6om3hMBkCwxR
         Hp2HGRoQy5exVdP6PNYRR97GBgUXkpqoU5TMU66ej7nEj4upRTYU10095W9PhdRSb2js
         +1M+kLDyG5GBk1hAWpcs9ckiiwMLgsxSo9bsfZ1qAVJ8Xbe1QTJghRfU8vra8ScY3H4K
         JYk0KBwcqzVYE9/S7usc/e/FUqIYDeAIO0U7r+Jrxu5PGVPwKBWRhpgMHuKAd53FArn5
         ZJcA==
X-Forwarded-Encrypted: i=1; AJvYcCVWrze+KEEOnBRlI4mH+hFp7yJGfu/qOu3a2c+NYRPETJ9J7DSfuY0kbrIqa57NI/V9FxnrYq4Rc0mof4FzXyKPviaNt8Hz+6i0gx9s
X-Gm-Message-State: AOJu0YyZtvUuvmG3gmYqGOIOKZDFH7fJt2jq+Bi3faX3f0zMxOpInKz1
	rb8hKOIBE0ie+DyJMKJI5zbr2x+DsMPA/1riEcL2RV8TbDVlmImikYoe5efoc2A=
X-Google-Smtp-Source: AGHT+IFJxOVQ6z/UnneNaFNFir8Cu23IX66luADI6AV5R2+EvI6fqlxEn0zeZSz/k+uUdK2EqMLxRA==
X-Received: by 2002:a5d:63c5:0:b0:366:dee6:a9ea with SMTP id ffacd0b85a97d-366e32f6c82mr5877092f8f.26.1719295132720;
        Mon, 24 Jun 2024 22:58:52 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-366389b861bsm11819109f8f.29.2024.06.24.22.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 22:58:52 -0700 (PDT)
Message-ID: <0bfcbf2e-9082-4287-9821-acd85a7024b9@linaro.org>
Date: Tue, 25 Jun 2024 06:58:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 v4 2/2] pinctrl: qcom: Introduce SM4250 LPI pinctrl
 driver
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240612-sm4250-lpi-v4-0-a0342e47e21b@linaro.org>
 <20240612-sm4250-lpi-v4-2-a0342e47e21b@linaro.org>
 <CANgGJDqJZ-qUB4XOTEhRQrzim_-ecf6evbM=zz4SiEKMSBObzQ@mail.gmail.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <CANgGJDqJZ-qUB4XOTEhRQrzim_-ecf6evbM=zz4SiEKMSBObzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Alexey,

On 24/06/2024 22:36, Alexey Klimov wrote:
> Hi Srini,
> 
> On Sat, 22 Jun 2024 at 17:49, Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>> Add support for the pin controller block on SM4250 Low Power Island.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   drivers/pinctrl/qcom/Kconfig                    |   9 +
>>   drivers/pinctrl/qcom/Makefile                   |   1 +
>>   drivers/pinctrl/qcom/pinctrl-sm4250-lpass-lpi.c | 236 ++++++++++++++++++++++++
>>   3 files changed, 246 insertions(+)
>>
>> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
>> index 24619e80b2cc..dd9bbe8f3e11 100644
>> --- a/drivers/pinctrl/qcom/Kconfig
>> +++ b/drivers/pinctrl/qcom/Kconfig
>> @@ -68,6 +68,15 @@ config PINCTRL_SC7280_LPASS_LPI
>>            Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
>>            (Low Power Island) found on the Qualcomm Technologies Inc SC7280 platform.
>>
>> +config PINCTRL_SM4250_LPASS_LPI
>> +       tristate "Qualcomm Technologies Inc SM4250 LPASS LPI pin controller driver"
>> +       depends on ARM64 || COMPILE_TEST
>> +       depends on PINCTRL_LPASS_LPI
>> +       help
>> +         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> +         Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
>> +         (Low Power Island) found on the Qualcomm Technologies Inc SM4250 platform.
>> +
>>   config PINCTRL_SM6115_LPASS_LPI
>>          tristate "Qualcomm Technologies Inc SM6115 LPASS LPI pin controller driver"
>>          depends on ARM64 || COMPILE_TEST
>> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
>> index e2e76071d268..eb04297b6388 100644
>> --- a/drivers/pinctrl/qcom/Makefile
>> +++ b/drivers/pinctrl/qcom/Makefile
>> @@ -43,6 +43,7 @@ obj-$(CONFIG_PINCTRL_SDM845) += pinctrl-sdm845.o
>>   obj-$(CONFIG_PINCTRL_SDX55) += pinctrl-sdx55.o
>>   obj-$(CONFIG_PINCTRL_SDX65) += pinctrl-sdx65.o
>>   obj-$(CONFIG_PINCTRL_SDX75) += pinctrl-sdx75.o
>> +obj-$(CONFIG_PINCTRL_SM4250_LPASS_LPI) += pinctrl-sm4250-lpass-lpi.o
>>   obj-$(CONFIG_PINCTRL_SM4450) += pinctrl-sm4450.o
>>   obj-$(CONFIG_PINCTRL_SM6115) += pinctrl-sm6115.o
>>   obj-$(CONFIG_PINCTRL_SM6115_LPASS_LPI) += pinctrl-sm6115-lpass-lpi.o
>> diff --git a/drivers/pinctrl/qcom/pinctrl-sm4250-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm4250-lpass-lpi.c
>> new file mode 100644
>> index 000000000000..2d2c636a3e20
>> --- /dev/null
>> +++ b/drivers/pinctrl/qcom/pinctrl-sm4250-lpass-lpi.c
>> @@ -0,0 +1,236 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2016-2019, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2020, 2023 Linaro Ltd.
>> + */
>> +
>> +#include <linux/gpio/driver.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "pinctrl-lpass-lpi.h"
>> +
>> +enum lpass_lpi_functions {
>> +       LPI_MUX_dmic01_clk,
>> +       LPI_MUX_dmic01_data,
>> +       LPI_MUX_dmic23_clk,
>> +       LPI_MUX_dmic23_data,
>> +       LPI_MUX_dmic4_clk,
>> +       LPI_MUX_dmic4_data,
>> +       LPI_MUX_ext_mclk0_a,
>> +       LPI_MUX_ext_mclk0_b,
>> +       LPI_MUX_ext_mclk1_a,
>> +       LPI_MUX_ext_mclk1_b,
>> +       LPI_MUX_ext_mclk1_c,
>> +       LPI_MUX_i2s1_clk,
>> +       LPI_MUX_i2s1_data,
>> +       LPI_MUX_i2s1_ws,
>> +       LPI_MUX_i2s2_clk,
>> +       LPI_MUX_i2s2_data,
>> +       LPI_MUX_i2s2_ws,
>> +       LPI_MUX_i2s3_clk,
>> +       LPI_MUX_i2s3_data,
>> +       LPI_MUX_i2s3_ws,
>> +       LPI_MUX_qup_io_00,
>> +       LPI_MUX_qup_io_01,
>> +       LPI_MUX_qup_io_05,
>> +       LPI_MUX_qup_io_10,
>> +       LPI_MUX_qup_io_11,
>> +       LPI_MUX_qup_io_25,
>> +       LPI_MUX_qup_io_21,
>> +       LPI_MUX_qup_io_26,
>> +       LPI_MUX_qup_io_31,
>> +       LPI_MUX_qup_io_36,
>> +       LPI_MUX_qua_mi2s_data,
>> +       LPI_MUX_qua_mi2s_sclk,
>> +       LPI_MUX_qua_mi2s_ws,
>> +       LPI_MUX_slim_clk,
>> +       LPI_MUX_slim_data,
>> +       LPI_MUX_sync_out,
>> +       LPI_MUX_swr_rx_clk,
>> +       LPI_MUX_swr_rx_data,
>> +       LPI_MUX_swr_tx_clk,
>> +       LPI_MUX_swr_tx_data,
>> +       LPI_MUX_swr_wsa_clk,
>> +       LPI_MUX_swr_wsa_data,
>> +       LPI_MUX_gpio,
>> +       LPI_MUX__,
>> +};
>> +
>> +static const struct pinctrl_pin_desc sm4250_lpi_pins[] = {
>> +       PINCTRL_PIN(0, "gpio0"),
>> +       PINCTRL_PIN(1, "gpio1"),
>> +       PINCTRL_PIN(2, "gpio2"),
>> +       PINCTRL_PIN(3, "gpio3"),
>> +       PINCTRL_PIN(4, "gpio4"),
>> +       PINCTRL_PIN(5, "gpio5"),
>> +       PINCTRL_PIN(6, "gpio6"),
>> +       PINCTRL_PIN(7, "gpio7"),
>> +       PINCTRL_PIN(8, "gpio8"),
>> +       PINCTRL_PIN(9, "gpio9"),
>> +       PINCTRL_PIN(10, "gpio10"),
>> +       PINCTRL_PIN(11, "gpio11"),
>> +       PINCTRL_PIN(12, "gpio12"),
>> +       PINCTRL_PIN(13, "gpio13"),
>> +       PINCTRL_PIN(14, "gpio14"),
>> +       PINCTRL_PIN(15, "gpio15"),
>> +       PINCTRL_PIN(16, "gpio16"),
>> +       PINCTRL_PIN(17, "gpio17"),
>> +       PINCTRL_PIN(18, "gpio18"),
>> +       PINCTRL_PIN(19, "gpio19"),
>> +       PINCTRL_PIN(20, "gpio20"),
>> +       PINCTRL_PIN(21, "gpio21"),
>> +       PINCTRL_PIN(22, "gpio22"),
>> +       PINCTRL_PIN(23, "gpio23"),
>> +       PINCTRL_PIN(24, "gpio24"),
>> +       PINCTRL_PIN(25, "gpio25"),
>> +       PINCTRL_PIN(26, "gpio26"),
>> +};
> 
> This doesn't probe() on qrb4210 RB2 for me with the following trace:
> 
> [   10.709014] ------------[ cut here ]------------
> [   10.719085] WARNING: CPU: 1 PID: 56 at
> drivers/pinctrl/qcom/pinctrl-lpass-lpi.c:446
> lpi_pinctrl_probe+0x308/0x388 [pinctrl_lpass_lpi]
> [   10.719108] Modules linked in: btqca qrtr btbcm qcom_q6v5_pas
> libarc4 qcom_pil_info llcc_qcom bluetooth snd_soc_sm8250 ocmem
> qcom_q6v5 snd_soc_qcom_sdw cfg80211 drm_exec qcom_sysmon
> snd_soc_qcom_common gpu_sched crct10dif_ce qcom_common soundwire_bus
> ecdh_generic qcom_glink_smem pinctrl_sm4250_lpass_lpi qcom_pmic_tcpm
> drm_dp_aux_bus ecc mdt_loader qcom_wdt pinctrl_lpass_lpi
> drm_display_helper qmi_helpers tcpm dispcc_sm6115 rfkill gpucc_sm6115
> aux_hpd_bridge qcom_usb_vbus_regulator nvmem_qcom_spmi_sdam
> qcom_spmi_temp_alarm qcom_pbs qcom_pon qcom_spmi_adc5 qcom_vadc_common
> spi_geni_qcom gpi qcom_stats icc_bwmon qcom_rng qcrypto authenc
> phy_qcom_qmp_usbc display_connector rpmsg_ctrl libdes typec rpmsg_char
> phy_qcom_qusb2 drm_kms_helper rmtfs_mem socinfo i2c_gpio fuse drm
> backlight dm_mod ip_tables x_tables ipv6
> [   10.719238] CPU: 1 PID: 56 Comm: kworker/u33:0 Not tainted
> 6.10.0-rc2-00012-ge45ddb1f8d34-dirty #7
> [   10.719245] Hardware name: Qualcomm Technologies, Inc. QRB4210 RB2 (DT)
> [   10.719250] Workqueue: events_unbound deferred_probe_work_func
> [   10.719265] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   10.719271] pc : lpi_pinctrl_probe+0x308/0x388 [pinctrl_lpass_lpi]
> [   10.719278] lr : lpi_pinctrl_probe+0x44/0x388 [pinctrl_lpass_lpi]
> [   10.719284] sp : ffff80008035bb40
> [   10.719286] x29: ffff80008035bb40 x28: 0000000000000000 x27: 0000000000000000
> [   10.719294] x26: ffff7eea83029428 x25: ffffa0c480a67510 x24: ffff7eea83be5800
> [   10.719301] x23: ffff7eea83be5810 x22: 0000000000000000 x21: ffffa0c480a64030
> [   10.719308] x20: ffff7eea83be5810 x19: ffff7eea89e59880 x18: ffffffffffffffff
> [   10.719315] x17: 0000000000000000 x16: ffffa0c4f34949a4 x15: ffff80008035b7f0
> [   10.719321] x14: ffffffffffffffff x13: 006c7274636e6970 x12: 2e30303030633761
> [   10.719329] x11: 0101010101010101 x10: ffffa0c4f4b28ff2 x9 : 0000000000000008
> [   10.719335] x8 : 0000000000000008 x7 : ffffa0c4f3cfa640 x6 : 0000000000000020
> [   10.719342] x5 : 0000000000000020 x4 : 0000000000000000 x3 : ffffa0c480a67448
> [   10.719348] x2 : ffffa0c480a67468 x1 : ffff7eea838b8000 x0 : 000000000000001b
> [   10.719357] Call trace:
> [   10.719361]  lpi_pinctrl_probe+0x308/0x388 [pinctrl_lpass_lpi]


For some reason the common library seems to have a bit mask of 23 which 
is why we are seeing this error.

Can you try this change,

--------------------------------------->cut<-------------------------------
diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c 
b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index 0d98008e33ee..7366aba5a199 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -20,7 +20,7 @@

  #include "pinctrl-lpass-lpi.h"

-#define MAX_NR_GPIO            23
+#define MAX_NR_GPIO            32
  #define GPIO_FUNC              0
  #define MAX_LPI_NUM_CLKS       2

--------------------------------------->cut<-------------------------------

> [   10.719369]  platform_probe+0x68/0xc4
> [   10.719378]  really_probe+0xbc/0x29c
> [   10.719384]  __driver_probe_device+0x78/0x12c
> [   10.719390]  driver_probe_device+0xd8/0x15c
> [   10.719395]  __device_attach_driver+0xb8/0x134
> [   10.719401]  bus_for_each_drv+0x88/0xe8
> [   10.719407]  __device_attach+0xa0/0x190
> [   10.719412]  device_initial_probe+0x14/0x20
> [   10.719418]  bus_probe_device+0xac/0xb0
> [   10.719423]  deferred_probe_work_func+0x88/0xc0
> [   10.719429]  process_one_work+0x150/0x294
> [   10.719439]  worker_thread+0x2f8/0x408
> [   10.719445]  kthread+0x110/0x114
> [   10.719452]  ret_from_fork+0x10/0x20
> [   10.719459] ---[ end trace 0000000000000000 ]---
> [   10.719589] qcom-sm4250-lpass-lpi-pinctrl a7c0000.pinctrl: probe
> with driver qcom-sm4250-lpass-lpi-pinctrl failed with error -22
> 
> 
> [...]
> 
> Thanks,
> Alexey

