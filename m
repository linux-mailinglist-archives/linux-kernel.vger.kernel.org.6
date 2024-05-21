Return-Path: <linux-kernel+bounces-184569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0408CA8F1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBEEEB21CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 07:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC8A4F88A;
	Tue, 21 May 2024 07:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJJxWA36"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D183317BA4
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276773; cv=none; b=ZR9wXiIaH+C2p87eInS6HzffonBwdTzkIpM3vMgXW86l4ATQLHS2oOWgX9X/e4ZaOzI11sEUsTWCmZaxK4vCCntN+8V7bskxMYae+0ROnjX5C9XmNOu+zeMkGbFwVSCJAZ9ys5b5gtR+pHkcEA7JbdocplL/58AOJUtqQilS5ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276773; c=relaxed/simple;
	bh=4GDKSHBiEEYSosMS/18Hw3RqC6aXwL1sOghKmIs9zQU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ti1t9SCRFbdSx6K5CQG7OGt73OAkzDKX3jJ1cDp+DPqMXmuSj8UuqBohfiBFife6/ZmX2E1h3X4Ygn/Ulw7WuhMSdB7bn1Kg76xM9DeS8YroHIK2Dq03i2sGXFBs6y/2U1W+bq7lWWlIx9T2EJzIJHJJLUiP2h1QQ2HfKRR7WGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cJJxWA36; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so8228668a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 00:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716276770; x=1716881570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DaoLar9fzsmZbKqjWwaQ+U8NLPpDMjjXi2Z0xwq8x7I=;
        b=cJJxWA36kvxzYnTcaYi6YPaPHLTRaSqSh27Eafwsf+AjUgOhFXZI5TvfW+26h8yjgh
         MouJf+u+htggBBAvXCbfMj0rGQ4jzG6pJnA46M26r5Q+y9tTADwOcCaxHdfxX4rP0qKf
         j4R5YZRlTXImNZlIzrjIUqVo5V+GzhAsILJs2k6l+rfjJICF1w+7hNrSNm63+3FFZll5
         qE4iS/Ak2y98jAn+3eIGcFqvicBFX3JXOKussNUkuMbCX3lNegAZOqGcCQDN7Wj1BD65
         su/kt9OCL9BpYADIOMNJnQ7KnG8eHSQNJ2HWcMXc0Aj81olajPDt1WSnCvvBHmmn6E9Q
         2tPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716276770; x=1716881570;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DaoLar9fzsmZbKqjWwaQ+U8NLPpDMjjXi2Z0xwq8x7I=;
        b=fkAmBTr4PQT4kK4fWDLZcHWZlxaNqsGLQWHrP6F62g7LghryvdV1du6ThAae2yRziW
         WNHol0XY6pouDJWLnK95GECIvqbzvVQwGH33ERPx/x0ZEHCLMRgeKv8oR0baL792BmaK
         56CUi32UFIYusqduidnK70Jl/qdb4NyKXcj6SzZ7KzV+ok9GlXcZnAMAS9yWRKn0Uyea
         SzVm0kODKeAOs7QbwMB0MqUNjmZ/xLU4DX3XZm0cWvEMvv5yO6vgNAMOQgKWEz+lDFz/
         S3cPNFXKj5VH/3xWxnRTzLs0+TUmf2zk+2jyIsFP7P/XuBZiV0cYQwV8miF5L4yWMft+
         ZP/A==
X-Forwarded-Encrypted: i=1; AJvYcCWCCa0EEtEKA6fKzGhqM+XH/sPn7sqYHi36Fv/e7K/P4MoVlJs2bRSyezndaKjIgikUONiCe95npzFGCR1sUY5uGQW+omAVsdZ2tFpp
X-Gm-Message-State: AOJu0YyD4Q2VG0gPIrvraO3QGhGJHFdK9JMXRd3CRRtfL34R7dTzlauK
	c9sQSiTH8bXDgRhquKBCuwsbdOmwbz+SUMsCwGdU2bFkfm6FznmInrm76A6hkHw=
X-Google-Smtp-Source: AGHT+IHAqvqdU2Zf8nC/VdtjkBHtyKKMAzX6IN9tn1mUjM5f8uH3gEXVBbI6Xabj2KSK2+HA5NqSdg==
X-Received: by 2002:a50:8ac1:0:b0:578:25f7:f5c1 with SMTP id 4fb4d7f45d1cf-57825f7f618mr250011a12.2.1716276769697;
        Tue, 21 May 2024 00:32:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:adf9:e5d:4c15:f725? ([2a01:e0a:982:cbb0:adf9:e5d:4c15:f725])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5751cc0f954sm5107914a12.74.2024.05.21.00.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 00:32:49 -0700 (PDT)
Message-ID: <2fb8fdf1-b945-4801-b947-7e824146f978@linaro.org>
Date: Tue, 21 May 2024 09:32:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 2/4] soc: amlogic: meson-gx-socinfo-sm: Add Amlogic
 secure-monitor SoC Information driver
To: Viacheslav Bocharov <adeep@lexina.in>, Kevin Hilman
 <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20240516112849.3803674-2-adeep@lexina.in>
 <20240516112849.3803674-5-adeep@lexina.in>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20240516112849.3803674-5-adeep@lexina.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

HI,

On 16/05/2024 13:26, Viacheslav Bocharov wrote:
> Amlogic SoCs have a SoC information secure-monitor call for SoC type,
> package type, revision information and chipid.
> This patchs adds support for secure-monitor call decoding and exposing
> with the SoC bus infrastructure in addition to the previous SoC
> Information driver.
> 
> Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
> ---
>   drivers/soc/amlogic/Kconfig               |  10 ++
>   drivers/soc/amlogic/Makefile              |   1 +
>   drivers/soc/amlogic/meson-gx-socinfo-sm.c | 189 ++++++++++++++++++++++
>   3 files changed, 200 insertions(+)
>   create mode 100644 drivers/soc/amlogic/meson-gx-socinfo-sm.c
> 
> diff --git a/drivers/soc/amlogic/Kconfig b/drivers/soc/amlogic/Kconfig
> index d08e398bdad4..82fc77ca3b4b 100644
> --- a/drivers/soc/amlogic/Kconfig
> +++ b/drivers/soc/amlogic/Kconfig
> @@ -26,6 +26,16 @@ config MESON_GX_SOCINFO
>   	  Say yes to support decoding of Amlogic Meson GX SoC family
>   	  information about the type, package and version.
>   
> +config MESON_GX_SOCINFO_SM
> +	bool "Amlogic Meson GX SoC Information driver via Secure Monitor"
> +	depends on (ARM64 && ARCH_MESON || COMPILE_TEST) && MESON_SM=y
> +	default ARCH_MESON && MESON_SM
> +	select SOC_BUS
> +	help
> +	  Say yes to support decoding of Amlogic Meson GX SoC family
> +	  information about the type, package and version via secure
> +	  monitor call.
> +
>   config MESON_MX_SOCINFO
>   	bool "Amlogic Meson MX SoC Information driver"
>   	depends on (ARM && ARCH_MESON) || COMPILE_TEST
> diff --git a/drivers/soc/amlogic/Makefile b/drivers/soc/amlogic/Makefile
> index c25f835e6a26..45d9d6f5904c 100644
> --- a/drivers/soc/amlogic/Makefile
> +++ b/drivers/soc/amlogic/Makefile
> @@ -2,4 +2,5 @@
>   obj-$(CONFIG_MESON_CANVAS) += meson-canvas.o
>   obj-$(CONFIG_MESON_CLK_MEASURE) += meson-clk-measure.o
>   obj-$(CONFIG_MESON_GX_SOCINFO) += meson-gx-socinfo.o
> +obj-$(CONFIG_MESON_GX_SOCINFO_SM) += meson-gx-socinfo-sm.o
>   obj-$(CONFIG_MESON_MX_SOCINFO) += meson-mx-socinfo.o
> diff --git a/drivers/soc/amlogic/meson-gx-socinfo-sm.c b/drivers/soc/amlogic/meson-gx-socinfo-sm.c
> new file mode 100644
> index 000000000000..22acd92bb830
> --- /dev/null
> +++ b/drivers/soc/amlogic/meson-gx-socinfo-sm.c
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2017 BayLibre, SAS
> + * Copyright (c) 2024 JetHome
> + * Author: Neil Armstrong <neil.armstrong@linaro.org>
> + * Author: Viacheslav Bocharov <adeep@lexina.in>
> + *
> + */
> +
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/sys_soc.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +
> +#include <linux/firmware/meson/meson_sm.h>
> +
> +#include "meson-gx-socinfo-internal.h"
> +
> +static char *socinfo_get_chipid(struct device *dev, struct meson_sm_firmware *fw,
> +			       union meson_cpu_id *socinfo)
> +{
> +	char *buf;
> +	struct meson_sm_chip_id *id_buf;
> +	int ret;
> +
> +	id_buf = kzalloc(sizeof(struct meson_sm_chip_id)+1, GFP_KERNEL);
> +	if (!id_buf)
> +		return NULL;
> +
> +	ret = meson_sm_call_read(fw, id_buf, sizeof(struct meson_sm_chip_id), SM_GET_CHIP_ID,
> +				 2, 0, 0, 0, 0);
> +	if (ret < 0) {
> +		kfree(id_buf);
> +		return NULL;
> +	}
> +	dev_info(dev, "got sm version call %i\n", id_buf->version);
> +
> +	if (id_buf->version != 2) {
> +
> +		u8 tmp;
> +		/**
> +		 * Legacy 12-byte chip ID read out, transform data
> +		 * to expected order format
> +		 */
> +		memmove((void *)&id_buf->serial, (void *)&id_buf->cpu_id, 12);
> +		for (int i = 0; i < 6; i++) {
> +			tmp = id_buf->serial[i];
> +			id_buf->serial[i] = id_buf->serial[11 - i];
> +			id_buf->serial[11 - i] = tmp;
> +		}
> +		id_buf->cpu_id.v2.major_id = socinfo->v1.major_id;
> +		id_buf->cpu_id.v2.pack_id = socinfo->v1.pack_id;
> +		id_buf->cpu_id.v2.chip_rev = socinfo->v1.chip_rev;
> +		id_buf->cpu_id.v2.reserved = socinfo->v1.reserved;
> +		id_buf->cpu_id.v2.layout_ver = socinfo->v1.layout_ver;
> +	} else {
> +		/**
> +		 * rewrite socinfo from regmap with value from secure monitor call
> +		 */
> +		socinfo->v1.major_id = id_buf->cpu_id.v2.major_id;
> +		socinfo->v1.pack_id = id_buf->cpu_id.v2.pack_id;
> +		socinfo->v1.chip_rev = id_buf->cpu_id.v2.chip_rev;
> +		socinfo->v1.reserved = id_buf->cpu_id.v2.reserved;
> +		socinfo->v1.layout_ver = id_buf->cpu_id.v2.layout_ver;
> +	}
> +
> +	buf = kasprintf(GFP_KERNEL, "%4phN%12phN", &(id_buf->cpu_id), &(id_buf->serial));
> +
> +	kfree(id_buf);
> +
> +	return buf;
> +}
> +
> +static int meson_gx_socinfo_sm_probe(struct platform_device *pdev)
> +{
> +	struct soc_device_attribute *soc_dev_attr;
> +	struct soc_device *soc_dev;
> +	struct device_node *sm_np;
> +	struct meson_sm_firmware *fw;
> +	struct regmap *regmap;
> +	union meson_cpu_id socinfo;
> +	struct device *dev;
> +	int ret;
> +
> +	/* check if chip-id is available */
> +	if (!of_property_read_bool(pdev->dev.of_node, "amlogic,has-chip-id"))
> +		return -ENODEV;
> +
> +	/* node should be a syscon */
> +	regmap = syscon_node_to_regmap(pdev->dev.of_node);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(regmap), "failed to get regmap\n");
> +
> +	sm_np = of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
> +	if (!sm_np) {
> +		dev_err(&pdev->dev, "no secure-monitor node found\n");
> +		return -EINVAL;
> +	}
> +
> +	fw = meson_sm_get(sm_np);
> +	of_node_put(sm_np);
> +	if (!fw) {
> +		dev_dbg(&pdev->dev, "secure-monitor device not ready, probe later\n");
> +		return -EPROBE_DEFER;
> +	}
> +
> +	ret = regmap_read(regmap, AO_SEC_SOCINFO_OFFSET, &socinfo.raw);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!socinfo.raw) {
> +		dev_err(&pdev->dev, "invalid regmap chipid value\n");
> +		return -EINVAL;
> +	}
> +
> +	soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr),
> +				    GFP_KERNEL);
> +	if (!soc_dev_attr)
> +		return -ENOMEM;
> +
> +	soc_dev_attr->serial_number = socinfo_get_chipid(&pdev->dev, fw, &socinfo);
> +
> +	soc_dev_attr->family = "Amlogic Meson";
> +	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%x:%x - %x:%x",
> +					   socinfo.v1.major_id,
> +					   socinfo.v1.chip_rev,
> +					   socinfo.v1.pack_id,
> +					   (socinfo.v1.reserved<<4) + socinfo.v1.layout_ver);
> +	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%s (%s)",
> +					 socinfo_v1_to_soc_id(socinfo),
> +					 socinfo_v1_to_package_id(socinfo));
> +
> +	soc_dev = soc_device_register(soc_dev_attr);
> +
> +
> +	if (IS_ERR(soc_dev)) {
> +		kfree(soc_dev_attr->revision);
> +		kfree_const(soc_dev_attr->soc_id);
> +		return PTR_ERR(soc_dev);
> +	}
> +
> +	dev = soc_device_to_device(soc_dev);
> +	platform_set_drvdata(pdev, soc_dev);
> +
> +	dev_info(dev, "Amlogic Meson %s Revision %x:%x (%x:%x) Detected (SM)\n",
> +			soc_dev_attr->soc_id,
> +			socinfo.v1.major_id,
> +			socinfo.v1.chip_rev,
> +			socinfo.v1.pack_id,
> +			(socinfo.v1.reserved<<4) + socinfo.v1.layout_ver);
> +
> +	return PTR_ERR_OR_ZERO(dev);
> +}
> +
> +
> +static int meson_gx_socinfo_sm_remove(struct platform_device *pdev)
> +{
> +	struct soc_device *soc_dev = platform_get_drvdata(pdev);
> +
> +	soc_device_unregister(soc_dev);
> +	return 0;
> +}
> +
> +static const struct of_device_id meson_gx_socinfo_match[] = {
> +	{ .compatible = "amlogic,meson-gx-ao-secure", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, meson_gx_socinfo_match);
> +
> +static struct platform_driver meson_gx_socinfo_driver = {
> +	.probe = meson_gx_socinfo_sm_probe,
> +	.remove	= meson_gx_socinfo_sm_remove,
> +	.driver = {
> +		.name = "meson-gx-socinfo-sm",
> +		.of_match_table = meson_gx_socinfo_match,
> +	},
> +};
> +
> +
> +module_platform_driver(meson_gx_socinfo_driver);
> +
> +MODULE_AUTHOR("Viacheslav Bocharov <adeep@lexina.in>");
> +MODULE_DESCRIPTION("Amlogic Meson GX SOC SM driver");
> +MODULE_LICENSE("GPL");

I get this while building :
In file included from ./include/linux/string.h:374,
                  from ./include/linux/bitmap.h:13,
                  from ./include/linux/cpumask.h:13,
                  from ./arch/arm64/include/asm/cpufeature.h:27,
                  from ./arch/arm64/include/asm/ptrace.h:11,
                  from ./arch/arm64/include/asm/irqflags.h:9,
                  from ./include/linux/irqflags.h:18,
                  from ./include/linux/spinlock.h:59,
                  from ./include/linux/kref.h:16,
                  from ./include/linux/mm_types.h:8,
                  from ./include/linux/page-flags.h:13,
                  from ./arch/arm64/include/asm/mte.h:15,
                  from ./arch/arm64/include/asm/pgtable.h:12,
                  from ./include/linux/pgtable.h:6,
                  from ./arch/arm64/include/asm/io.h:12,
                  from ./include/linux/io.h:14,
                  from drivers/soc/amlogic/meson-gx-socinfo-sm.c:10:
In function ‘fortify_memcpy_chk’,
     inlined from ‘socinfo_get_chipid’ at drivers/soc/amlogic/meson-gx-socinfo-sm.c:50:3:
/include/linux/fortify-string.h:566:25: error: call to ‘__read_overflow2_field’ declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
   566 |                         __read_overflow2_field(q_size_field, size);
       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Neil

