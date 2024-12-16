Return-Path: <linux-kernel+bounces-447316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCEC9F307A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2401884D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E25204F93;
	Mon, 16 Dec 2024 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/sn7TvY"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6B0202F97;
	Mon, 16 Dec 2024 12:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351839; cv=none; b=kGm+27wNhpJDy5a0Rbz+sCHDMNZiSEQTKaPRzrRKdsqL5xLhLqutEeI1+yYHZ3h+9F+ZuI/k0duh8TZTwhQV9un7B8u/xPR0VEDtRnaxxr6eQrsBJMoXOrjws7YTDgqPxKU/hTrn/D+boEk63DE0xh796/+0iQRtXkKvBJrzu4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351839; c=relaxed/simple;
	bh=G+GKfXvv/rnv0WSZor2J49k45YPOTkCV2hzrNFFf3oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecq8/9sLgMrdk5Y0n5b09f2ZUQdVp6JNYE3p+yMndNby+EvW+uUpLBoV3GhnorfCM9w4nJflMjYf3gdxR5bKxwl/J2uziZIO649D8BitrBqvpPAG6QWeOeCsh8w4O06+lSEHIqJiuMLdYxM6ZHTGaWe8Ugqr4ISFVXIN6RaTylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/sn7TvY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434e3953b65so27614825e9.1;
        Mon, 16 Dec 2024 04:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734351835; x=1734956635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0M4ROyI5VuUm1Dqoke2sKtA4Jn5qP7aZUfIjFZkt4A=;
        b=b/sn7TvYrmmtxhdZWXv3J6cshGzMvtWPDLgevNp7F9pdhd/5SXCf0hhbeJ42I9luei
         WcWMCQl56qyutC3Q7R3RQCH7Ue6dTdFgdjlJPSUGSRBxE+f0KAXhe2C4cKVfwXRtcPYu
         An1gds+IBNMQtI7PLZfZB+cl+Kuv4CJHCtp58D4BLemI1Vrb8thllWC4znIiGaFTrLNT
         G6S8lHWvERTPukTiyCV8f90k0WeOI7g9hBsFG0c9xscp1Kzol8g4dAjgdfvm/O8NMncU
         8dg2LqonTHqn6Ay9egWfQ0C74ik2tw0FGdE45x/9mYy938VzaccrI1ZW0ZO/obx1uGWs
         gjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734351835; x=1734956635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0M4ROyI5VuUm1Dqoke2sKtA4Jn5qP7aZUfIjFZkt4A=;
        b=dYOnmaTndnCCznKlhl0hCQOZREJxse32tVDfybzmOJjpuq6Rnv0vb2e55l6U76RwMe
         /KwQej6pi8ZOSFEs7oHWyfQXbxm8AoyLLBhE0yPU3MUErodEg6nxUL/b7PWk72K82nAP
         lsHx1wZjcSKHYTIXqhl+q8PpSJUPRVQuX2XC9j4wyk92n5QwXdnkClLdf/SkAp1tNx3v
         6KMSJKVbmwH7AR2IiIxIUc7WAWsTNU69fDch6jYAeJbzu5aSlEwoVJCSKBFvfBGgCavY
         gZgdn5uwew2lfSEqIVFxWbnJ0qL/5/ppoq5zDwKU07zBAoWixznXKZSvs5UookkXkloB
         IdtA==
X-Forwarded-Encrypted: i=1; AJvYcCUoysOgiWx1lNFuv1Hz/Iam3ytcpCpcZmz2aYS+/yM2+4X2GMmAr6fcGgrIfakLhwug5Bhl6ObarJ+xPXM=@vger.kernel.org, AJvYcCW3kIl+Ns9M8o4dfs+9ghf37P1uKtPYgi+XT4MVp4Dllh4gPW/zV5cWSTlOkXIz1obu/oTg2LBU/hJIp2id@vger.kernel.org, AJvYcCXRQRizSo53eoCuX12IOANncdAopnUaXcOzqsnTxW2UKTKUJ0FmGozH6cJNnqEqtA4L89le0ZU6OIWO@vger.kernel.org
X-Gm-Message-State: AOJu0YwU5tOTLKWv/QMJDMnBUYRPCrF+3rqXT6VSN+KQiyCDji3moex6
	Dzu+8VdDAC7lER6XTKafJaS+gDM95lBYMGEkynET0szE14RKu2C+
X-Gm-Gg: ASbGncvNqB6NXVJKNvXpG9Q4+CI/9w2NhBVvTiOPqYu6HTwr1W/jCoW61zw4od3p/Fa
	cH7neVHE0yaKVgUhqAwnZIjdO+xltpVQ71nOj0/Gd/cWI+tYBSYU1bvvX/ja1VHb8UdjqIdjEdu
	WT6431ux7QTBanH25TmfH5/VE/Zv74v7fcQB/beO5TWcNQ5aNpVY7GbdXb3Jbu+Q7uRUSX3GB+A
	D0yMOUof8hEZCAMKPxqWoijIBfgyn4o5m7plYKe2X6AiDoXNAC04wE+HKQRAGH4K1MI2pS9044K
	WcD7QA==
X-Google-Smtp-Source: AGHT+IHllI1JbXYYae2H/MvITh+4jN27/1ciwccWg4jug4lIS1NHVOZJ0z8HLrN/tAQsxRz++H1Dmw==
X-Received: by 2002:a05:600c:350c:b0:434:a802:e99a with SMTP id 5b1f17b1804b1-4362aa147a8mr104737745e9.4.1734351833107;
        Mon, 16 Dec 2024 04:23:53 -0800 (PST)
Received: from [192.168.4.67] ([92.120.5.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602d940sm83170665e9.12.2024.12.16.04.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 04:23:52 -0800 (PST)
Message-ID: <c3c9389f-5116-4a5f-99f6-1b37c1e8c457@gmail.com>
Date: Mon, 16 Dec 2024 14:23:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] ASoC: SOF: imx: add driver for imx95
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Daniel Baluta <daniel.baluta@nxp.com>,
 Mark Brown <broonie@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.com>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-sound@vger.kernel.org,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241113195240.3699-1-laurentiumihalcea111@gmail.com>
 <20241113195240.3699-5-laurentiumihalcea111@gmail.com>
 <ZzUJQCeWclsrr/lr@lizhi-Precision-Tower-5810>
 <c47710a5-7e53-48b1-bd6b-c0123865aee5@gmail.com>
 <Z1r9hWH1ioR5vI5H@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <Z1r9hWH1ioR5vI5H@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/12/2024 5:13 PM, Frank Li wrote:
> On Thu, Dec 12, 2024 at 01:11:29PM +0200, Laurentiu Mihalcea wrote:
>>
>> On 11/13/2024 10:17 PM, Frank Li wrote:
>>> On Wed, Nov 13, 2024 at 02:52:39PM -0500, Laurentiu Mihalcea wrote:
>>>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>>>
>>>> Add SOF driver for imx95.
>>>>
>>>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>>> ---
>>>>  sound/soc/sof/imx/Kconfig  |   8 +
>>>>  sound/soc/sof/imx/Makefile |   2 +
>>>>  sound/soc/sof/imx/imx95.c  | 401 +++++++++++++++++++++++++++++++++++++
>>> why not reused exist one? look likes simular.
>>>
>>> Frank
>> the SOF drivers do indeed have some similarities, but each of them has their own quirks which IMO makes it a bit harder to add the 95 support. We need to figure out the common parts and then move them to imx-common, but I believe this can be solved incrementally.
> You should create common part firstly, then implement equal function with
> existed part. Finially add imx95 part.
>
> Frank

Yes, I'm aware of how this _should_ be done, but, like I mentioned, the change is not trivial and will
require tweaking the other drivers as well. As such, I'd like to get the 95 support in as-is firstly.

Are there any other thoughts on this?

>
>>>>  3 files changed, 411 insertions(+)
>>>>  create mode 100644 sound/soc/sof/imx/imx95.c
>>>>
>>>> diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
>>>> index 4751b04d5e6f..51a70a193533 100644
>>>> --- a/sound/soc/sof/imx/Kconfig
>>>> +++ b/sound/soc/sof/imx/Kconfig
>>>> @@ -50,4 +50,12 @@ config SND_SOC_SOF_IMX8ULP
>>>>  	  Say Y if you have such a device.
>>>>  	  If unsure select "N".
>>>>
>>>> +config SND_SOC_SOF_IMX95
>>>> +	tristate "SOF support for i.MX95"
>>>> +	depends on IMX_DSP
>>>> +	help
>>>> +	  This adds support for Sound Open Firmware for NXP i.MX95 platforms.
>>>> +	  Say Y if you have such a device.
>>>> +	  If unsure select "N".
>>>> +
>>>>  endif ## SND_SOC_SOF_IMX_TOPLEVEL
>>>> diff --git a/sound/soc/sof/imx/Makefile b/sound/soc/sof/imx/Makefile
>>>> index be0bf0736dfa..715ac3798668 100644
>>>> --- a/sound/soc/sof/imx/Makefile
>>>> +++ b/sound/soc/sof/imx/Makefile
>>>> @@ -2,10 +2,12 @@
>>>>  snd-sof-imx8-y := imx8.o
>>>>  snd-sof-imx8m-y := imx8m.o
>>>>  snd-sof-imx8ulp-y := imx8ulp.o
>>>> +snd-sof-imx95-y := imx95.o
>>>>
>>>>  snd-sof-imx-common-y := imx-common.o
>>>>
>>>>  obj-$(CONFIG_SND_SOC_SOF_IMX8) += snd-sof-imx8.o
>>>>  obj-$(CONFIG_SND_SOC_SOF_IMX8M) += snd-sof-imx8m.o
>>>>  obj-$(CONFIG_SND_SOC_SOF_IMX8ULP) += snd-sof-imx8ulp.o
>>>> +obj-$(CONFIG_SND_SOC_SOF_IMX95) += snd-sof-imx95.o
>>>>  obj-$(CONFIG_SND_SOC_SOF_IMX_COMMON) += imx-common.o
>>>> diff --git a/sound/soc/sof/imx/imx95.c b/sound/soc/sof/imx/imx95.c
>>>> new file mode 100644
>>>> index 000000000000..5a0e44f5bd48
>>>> --- /dev/null
>>>> +++ b/sound/soc/sof/imx/imx95.c
>>>> @@ -0,0 +1,401 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
>>>> +/*
>>>> + * Copyright 2024 NXP
>>>> + */
>>>> +
>>>> +#include <linux/arm-smccc.h>
>>>> +#include <linux/clk.h>
>>>> +#include <linux/firmware/imx/dsp.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/of_platform.h>
>>>> +#include <linux/of_reserved_mem.h>
>>>> +#include <sound/sof.h>
>>>> +
>>>> +#include "../sof-of-dev.h"
>>>> +#include "../ops.h"
>>>> +
>>>> +#define IMX_SIP_SRC 0xC2000005
>>>> +#define IMX_SIP_SRC_M_RESET_ADDR_SET 0x03
>>>> +
>>>> +#define IMX95_CPU_VEC_FLAGS_BOOT BIT(29)
>>>> +
>>>> +#define IMX_SIP_LMM 0xC200000F
>>>> +#define IMX_SIP_LMM_BOOT 0x0
>>>> +#define IMX_SIP_LMM_SHUTDOWN 0x1
>>>> +
>>>> +#define IMX95_M7_LM_ID 0x1
>>>> +
>>>> +#define MBOX_DSPBOX_OFFSET 0x1000
>>>> +#define MBOX_WINDOW_OFFSET 0x6000000
>>>> +
>>>> +struct imx95_priv {
>>>> +	struct platform_device *ipc_dev;
>>>> +	struct imx_dsp_ipc *ipc_handle;
>>>> +	resource_size_t bootaddr;
>>>> +};
>>>> +
>>>> +static void imx95_ipc_handle_reply(struct imx_dsp_ipc *ipc)
>>>> +{
>>>> +	unsigned long flags;
>>>> +	struct snd_sof_dev *sdev = imx_dsp_get_data(ipc);
>>>> +
>>>> +	spin_lock_irqsave(&sdev->ipc_lock, flags);
>>>> +	snd_sof_ipc_process_reply(sdev, 0);
>>>> +	spin_unlock_irqrestore(&sdev->ipc_lock, flags);
>>>> +}
>>>> +
>>>> +static void imx95_ipc_handle_request(struct imx_dsp_ipc *ipc)
>>>> +{
>>>> +	snd_sof_ipc_msgs_rx(imx_dsp_get_data(ipc));
>>>> +}
>>>> +
>>>> +static struct imx_dsp_ops ipc_ops = {
>>>> +	.handle_reply = imx95_ipc_handle_reply,
>>>> +	.handle_request = imx95_ipc_handle_request,
>>>> +};
>>>> +
>>>> +static int imx95_disable_enable_core(bool enable)
>>>> +{
>>>> +	struct arm_smccc_res res;
>>>> +
>>>> +	if (enable)
>>>> +		arm_smccc_smc(IMX_SIP_LMM, IMX_SIP_LMM_BOOT, IMX95_M7_LM_ID,
>>>> +			      0, 0, 0, 0, 0, &res);
>>>> +	else
>>>> +		arm_smccc_smc(IMX_SIP_LMM, IMX_SIP_LMM_SHUTDOWN, IMX95_M7_LM_ID,
>>>> +			      0, 0, 0, 0, 0, &res);
>>>> +
>>>> +	return res.a0;
>>>> +}
>>>> +
>>>> +static int imx95_run(struct snd_sof_dev *sdev)
>>>> +{
>>>> +	return imx95_disable_enable_core(true);
>>>> +}
>>>> +
>>>> +static int imx95_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
>>>> +{
>>>> +	struct imx95_priv *priv = sdev->pdata->hw_pdata;
>>>> +
>>>> +	sof_mailbox_write(sdev, sdev->host_box.offset,
>>>> +			  msg->msg_data, msg->msg_size);
>>>> +
>>>> +	imx_dsp_ring_doorbell(priv->ipc_handle, 0);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int imx95_get_mailbox_offset(struct snd_sof_dev *sdev)
>>>> +{
>>>> +	return MBOX_DSPBOX_OFFSET + MBOX_WINDOW_OFFSET;
>>>> +}
>>>> +
>>>> +static int imx95_get_bar_index(struct snd_sof_dev *sdev, u32 type)
>>>> +{
>>>> +	switch (type) {
>>>> +	case SOF_FW_BLK_TYPE_SRAM:
>>>> +		return type;
>>>> +	default:
>>>> +		return -EINVAL;
>>>> +	}
>>>> +}
>>>> +
>>>> +static int imx95_get_window_offset(struct snd_sof_dev *sdev, u32 id)
>>>> +{
>>>> +	return MBOX_WINDOW_OFFSET;
>>>> +}
>>>> +
>>>> +static int imx95_set_power_state(struct snd_sof_dev *sdev,
>>>> +				 const struct sof_dsp_power_state *target_state)
>>>> +{
>>>> +	sdev->dsp_power_state = *target_state;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int imx95_suspend_resume(struct snd_sof_dev *sdev, bool suspend)
>>>> +{
>>>> +	struct imx95_priv *priv;
>>>> +	int ret, i;
>>>> +
>>>> +	priv = sdev->pdata->hw_pdata;
>>>> +
>>>> +	if (suspend) {
>>>> +		ret = imx95_disable_enable_core(false);
>>>> +		if (ret) {
>>>> +			dev_err(sdev->dev, "failed to stop core\n");
>>>> +			return ret;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	for (i = 0; i < DSP_MU_CHAN_NUM; i++) {
>>>> +		if (suspend)
>>>> +			imx_dsp_free_channel(priv->ipc_handle, i);
>>>> +		else
>>>> +			imx_dsp_request_channel(priv->ipc_handle, i);
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int imx95_runtime_resume(struct snd_sof_dev *sdev)
>>>> +{
>>>> +	int ret;
>>>> +	const struct sof_dsp_power_state target_state = {
>>>> +		.state = SOF_DSP_PM_D0,
>>>> +	};
>>>> +
>>>> +	ret = imx95_suspend_resume(sdev, false);
>>>> +	if (ret < 0) {
>>>> +		dev_err(sdev->dev, "failed to runtime resume: %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	return snd_sof_dsp_set_power_state(sdev, &target_state);
>>>> +}
>>>> +
>>>> +static int imx95_resume(struct snd_sof_dev *sdev)
>>>> +{
>>>> +	int ret;
>>>> +	const struct sof_dsp_power_state target_state = {
>>>> +		.state = SOF_DSP_PM_D0,
>>>> +	};
>>>> +
>>>> +	ret = imx95_suspend_resume(sdev, false);
>>>> +	if (ret < 0) {
>>>> +		dev_err(sdev->dev, "failed to resume: %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	if (pm_runtime_suspended(sdev->dev)) {
>>>> +		pm_runtime_disable(sdev->dev);
>>>> +		pm_runtime_set_active(sdev->dev);
>>>> +		pm_runtime_mark_last_busy(sdev->dev);
>>>> +		pm_runtime_enable(sdev->dev);
>>>> +		pm_runtime_idle(sdev->dev);
>>>> +	}
>>>> +
>>>> +	return snd_sof_dsp_set_power_state(sdev, &target_state);
>>>> +}
>>>> +
>>>> +static int imx95_runtime_suspend(struct snd_sof_dev *sdev)
>>>> +{
>>>> +	int ret;
>>>> +	const struct sof_dsp_power_state target_state = {
>>>> +		.state = SOF_DSP_PM_D3,
>>>> +	};
>>>> +
>>>> +	ret = imx95_suspend_resume(sdev, true);
>>>> +	if (ret < 0) {
>>>> +		dev_err(sdev->dev, "failed to runtime suspend: %d\n", ret);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	return snd_sof_dsp_set_power_state(sdev, &target_state);
>>>> +}
>>>> +
>>>> +static int imx95_suspend(struct snd_sof_dev *sdev, unsigned int target_state)
>>>> +{
>>>> +	int ret;
>>>> +	const struct sof_dsp_power_state target_power_state = {
>>>> +		.state = target_state,
>>>> +	};
>>>> +
>>>> +	if (!pm_runtime_suspended(sdev->dev)) {
>>>> +		ret = imx95_suspend_resume(sdev, true);
>>>> +		if (ret < 0) {
>>>> +			dev_err(sdev->dev, "failed to suspend: %d\n", ret);
>>>> +			return ret;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return snd_sof_dsp_set_power_state(sdev, &target_power_state);
>>>> +}
>>>> +
>>>> +static struct snd_soc_dai_driver imx95_dai[] = {
>>>> +	{
>>>> +		.name = "sai3",
>>>> +		.playback = {
>>>> +			.channels_min = 1,
>>>> +			.channels_max = 32,
>>>> +		},
>>>> +		.capture = {
>>>> +			.channels_min = 1,
>>>> +			.channels_max = 32,
>>>> +		},
>>>> +	},
>>>> +};
>>>> +
>>>> +static int imx95_probe(struct snd_sof_dev *sdev)
>>>> +{
>>>> +	struct platform_device *pdev;
>>>> +	struct imx95_priv *priv;
>>>> +	struct resource *res;
>>>> +	struct arm_smccc_res smc_ret;
>>>> +	int ret;
>>>> +
>>>> +	pdev = container_of(sdev->dev, struct platform_device, dev);
>>>> +
>>>> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>>>> +	if (!priv)
>>>> +		return dev_err_probe(&pdev->dev, -ENOMEM, "failed to alloc priv\n");
>>>> +
>>>> +	sdev->pdata->hw_pdata = priv;
>>>> +
>>>> +	/* map SRAM */
>>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> +	if (!res)
>>>> +		return dev_err_probe(&pdev->dev, -ENODEV,
>>>> +				     "failed to fetch SRAM region\n");
>>>> +
>>>> +	sdev->bar[SOF_FW_BLK_TYPE_SRAM] = devm_ioremap(&pdev->dev, res->start,
>>>> +						       resource_size(res));
>>>> +	if (IS_ERR(sdev->bar[SOF_FW_BLK_TYPE_SRAM]))
>>>> +		return dev_err_probe(&pdev->dev,
>>>> +				     PTR_ERR(sdev->bar[SOF_FW_BLK_TYPE_SRAM]),
>>>> +				     "failed to map SRAM region\n");
>>>> +
>>>> +	sdev->mmio_bar = SOF_FW_BLK_TYPE_SRAM;
>>>> +	sdev->mailbox_bar = SOF_FW_BLK_TYPE_SRAM;
>>>> +	sdev->dsp_box.offset = MBOX_DSPBOX_OFFSET + MBOX_WINDOW_OFFSET;
>>>> +	priv->bootaddr = res->start;
>>>> +
>>>> +	ret = of_reserved_mem_device_init(sdev->dev);
>>>> +	if (ret)
>>>> +		return dev_err_probe(&pdev->dev, ret,
>>>> +				     "failed to bind DMA region\n");
>>>> +
>>>> +	priv->ipc_dev = platform_device_register_data(&pdev->dev, "imx-dsp",
>>>> +						      PLATFORM_DEVID_NONE,
>>>> +						      pdev, sizeof(*pdev));
>>>> +	if (IS_ERR(priv->ipc_dev))
>>>> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->ipc_dev),
>>>> +				     "failed to create IPC device\n");
>>>> +
>>>> +	priv->ipc_handle = dev_get_drvdata(&priv->ipc_dev->dev);
>>>> +	if (!priv->ipc_handle) {
>>>> +		ret = -EPROBE_DEFER;
>>>> +		dev_err(&pdev->dev, "failed to fetch ipc handle\n");
>>>> +		goto err_unregister_ipc_dev;
>>>> +	}
>>>> +
>>>> +	priv->ipc_handle->ops = &ipc_ops;
>>>> +	imx_dsp_set_data(priv->ipc_handle, sdev);
>>>> +
>>>> +	/* set core boot reset address */
>>>> +	arm_smccc_smc(IMX_SIP_SRC, IMX_SIP_SRC_M_RESET_ADDR_SET, priv->bootaddr,
>>>> +		      IMX95_CPU_VEC_FLAGS_BOOT, 0, 0, 0, 0, &smc_ret);
>>>> +	if ((int)smc_ret.a0 < 0) {
>>>> +		ret = smc_ret.a0;
>>>> +		dev_err(&pdev->dev, "failed to set boot address: %d", ret);
>>>> +		goto err_unregister_ipc_dev;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +
>>>> +err_unregister_ipc_dev:
>>>> +	platform_device_unregister(priv->ipc_dev);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static void imx95_remove(struct snd_sof_dev *sdev)
>>>> +{
>>>> +	struct imx95_priv *priv;
>>>> +
>>>> +	priv = sdev->pdata->hw_pdata;
>>>> +
>>>> +	if (imx95_disable_enable_core(false))
>>>> +		dev_err(sdev->dev, "failed to stop core\n");
>>>> +
>>>> +	platform_device_unregister(priv->ipc_dev);
>>>> +}
>>>> +
>>>> +static const struct snd_sof_dsp_ops sof_imx95_ops = {
>>>> +	.probe = imx95_probe,
>>>> +	.remove = imx95_remove,
>>>> +
>>>> +	/* mandatory "DSP" ops */
>>>> +	.run = imx95_run,
>>>> +	.block_read = sof_block_read,
>>>> +	.block_write = sof_block_write,
>>>> +	.send_msg = imx95_send_msg,
>>>> +	.load_firmware = snd_sof_load_firmware_memcpy,
>>>> +	.ipc_msg_data = sof_ipc_msg_data,
>>>> +
>>>> +	.mailbox_read = sof_mailbox_read,
>>>> +	.mailbox_write = sof_mailbox_write,
>>>> +
>>>> +	.get_mailbox_offset = imx95_get_mailbox_offset,
>>>> +	.get_bar_index = imx95_get_bar_index,
>>>> +	.get_window_offset = imx95_get_window_offset,
>>>> +
>>>> +	.pcm_open = sof_stream_pcm_open,
>>>> +	.pcm_close = sof_stream_pcm_close,
>>>> +	.set_stream_data_offset = sof_set_stream_data_offset,
>>>> +
>>>> +	.runtime_suspend = imx95_runtime_suspend,
>>>> +	.runtime_resume = imx95_runtime_resume,
>>>> +
>>>> +	.resume = imx95_resume,
>>>> +	.suspend = imx95_suspend,
>>>> +
>>>> +	.set_power_state = imx95_set_power_state,
>>>> +
>>>> +	.drv = imx95_dai,
>>>> +	.num_drv = ARRAY_SIZE(imx95_dai),
>>>> +
>>>> +	.hw_info = SNDRV_PCM_INFO_MMAP |
>>>> +		   SNDRV_PCM_INFO_MMAP_VALID |
>>>> +		   SNDRV_PCM_INFO_INTERLEAVED |
>>>> +		   SNDRV_PCM_INFO_PAUSE |
>>>> +		   SNDRV_PCM_INFO_BATCH |
>>>> +		   SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
>>>> +};
>>>> +
>>>> +static struct snd_sof_of_mach sof_imx95_machs[] = {
>>>> +	{
>>>> +		.compatible = "fsl,imx95-19x19-evk",
>>>> +		.sof_tplg_filename = "sof-imx95-wm8962.tplg",
>>>> +		.drv_name = "asoc-audio-graph-card2",
>>>> +	},
>>>> +	{
>>>> +	},
>>>> +};
>>>> +
>>>> +static struct sof_dev_desc sof_of_imx95_desc = {
>>>> +	.of_machines = sof_imx95_machs,
>>>> +	.ipc_supported_mask = BIT(SOF_IPC_TYPE_3),
>>>> +	.ipc_default = SOF_IPC_TYPE_3,
>>>> +	.default_fw_path = {
>>>> +		[SOF_IPC_TYPE_3] = "imx/sof",
>>>> +	},
>>>> +	.default_tplg_path = {
>>>> +		[SOF_IPC_TYPE_3] = "imx/sof-tplg",
>>>> +	},
>>>> +	.default_fw_filename = {
>>>> +		[SOF_IPC_TYPE_3] = "sof-imx95.ri",
>>>> +	},
>>>> +	.ops = &sof_imx95_ops,
>>>> +};
>>>> +
>>>> +static const struct of_device_id sof_of_imx95_ids[] = {
>>>> +	{ .compatible = "fsl,imx95-cm7-sof", .data = &sof_of_imx95_desc },
>>>> +	{ },
>>>> +};
>>>> +MODULE_DEVICE_TABLE(of, sof_of_imx95_ids);
>>>> +
>>>> +static struct platform_driver snd_sof_of_imx95_driver = {
>>>> +	.probe = sof_of_probe,
>>>> +	.remove = sof_of_remove,
>>>> +	.driver = {
>>>> +		.name = "sof-audio-of-imx95",
>>>> +		.pm = &sof_of_pm,
>>>> +		.of_match_table = sof_of_imx95_ids,
>>>> +	},
>>>> +};
>>>> +module_platform_driver(snd_sof_of_imx95_driver);
>>>> +
>>>> +MODULE_LICENSE("Dual BSD/GPL");
>>>> +MODULE_DESCRIPTION("SOF support for i.MX95 platforms");
>>>> +MODULE_AUTHOR("Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>");
>>>> --
>>>> 2.34.1
>>>>


