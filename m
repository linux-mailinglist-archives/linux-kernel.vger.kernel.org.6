Return-Path: <linux-kernel+bounces-425636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0D49DE826
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62AFFB21517
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F4919E7F8;
	Fri, 29 Nov 2024 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ggHpYgmT"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF7119F430
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732888482; cv=none; b=M4ypypPNMQ1oachH6o4R95kBTqBG+Q3UwMM6YOGU3/mZUtxkIRFzW/ZigpCbVpuoJZaJpDxMW8dyK2BcpS/nAI0tmGeUOtOOESyseUg3jb/Ki3rKgcagT5RHtiRxMqYhb59yKC0NU6puvTz9cztLD+IsQvo9SOmb0c27H9somdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732888482; c=relaxed/simple;
	bh=Nc9DCNNk33uxaNejBLp/b4gjORJUPcVof3QkYEmT64M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mn3bR23yrgS7XryHjOkN+1u35z/Zs7x3TPtaUiNDFqLnQPAV1s/udIgqSzPBNUkAc5tfzxmAjA3PRmM/Pqr9oG5HxCy7KI8j5pzQHfEgVRQSXFcQyjvLvywXp6tzhdJKXllDsXxvNKhw4J92DoNoetMbILUQWTp+VLUQaSVNEYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ggHpYgmT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4349cc45219so17259015e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 05:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732888478; x=1733493278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HB5qvtsPd7f9i7gdKT/XuYTYZDECuYTYPRyyqxwrKxQ=;
        b=ggHpYgmTRPGnhzdNdhY1NcJTTpmaL8Py0S5HwnINxaboAP9B8M8feOU3ONFnmNDJvb
         +ucQ9mCFqgT1zyPxogCIKwgDM3/lOGyPvFgtiSs3MHPfj1jLI/yt2yY23QeKIlUJIjAA
         T7IOm/YasP9KcUMJSYJUEAhXNjkc+KQp/+rNZdTEj8K7qrWSlOKlK5wpeVJzMtvtrM53
         CT/upWhQb6Uj3sPS8ccdbhWLy3mSXwMaj5vJdZ+UXOxraV2W8QmqTvY62dys8ovB39TH
         IOSVX3qw2iInmUm4rjQ7N1+RgnknhA5sFq68Rq8MZDQkAY6nyUkDPNXeKdl3rtRozQdO
         csbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732888478; x=1733493278;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HB5qvtsPd7f9i7gdKT/XuYTYZDECuYTYPRyyqxwrKxQ=;
        b=wXKW+7/7DFJRq2xZyitn++yC3TLnXgUATVSJYr6cVnnm5jnHbUoSk2fRnF1I1bbo+v
         IfPE+yxuGBxjhgBvyky9yplFjXyGU9DCmwXr2BfYABfFoVP7R5Dnv73HxUSqTUEiY2j9
         SM64413uTlkKYnNzhdiHuUMN3klvqd2yqiSLPF2B2ibTr2ffR6zxVQOBAVvkRdqa4o0N
         5+xxxIRTGSbI+u3ENc3mA/xX0o+OjquGDUS/JinVLs4cIZdVKmFCqLUOIenIbYITSlc5
         lJU5SmbnjgweKQ4QOglElFO6Uhckqbe+fJTcPD1eU9LbeUGsWHjT24RMl4lTymKWOznI
         d1sA==
X-Forwarded-Encrypted: i=1; AJvYcCXsK3+gnKrNPgJB170HqmkK+CIXhZBlynekndtELwl3GWWdUJFPTSvMBipozgTdfthOSz8j/C/AkpdOs9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpKoR5w6lNBs4rDqqTY6X68z2nezO5hCOPVFewJ8KbhCwV4uFs
	JhrDAmxyYWbXfxyPpYtANocsR401OLx6Sm3FQYou5AhXFEcdaenz+HYfnaHCgVw=
X-Gm-Gg: ASbGnctYEncdatL403Mvvwzu+6aFayHLBA+vMBynKu7/RdhhjaIneIF6h+3jV6IOPBC
	KFKgatTYBz7mzGusI6j02VQ8pgvA9zVNOObFMQY7hhJDYo06UsNwl4j1+G/SQbouotbXJk6FTex
	Q9/is4dYlcipL2bDl8N3m809xuYPM6EBwNaMVGvkx2yw5WO6TdtU/FL45Atovowwzw6cPLX26xM
	eIrYLBJMJcEg6eDzfclzAt6OpF6gjjnQtkMAFdKPobS0bsq6qSHLkwjrPPBt4KL5YcuqY4V7mDm
	fbG8w+2xVqsp4LcBZAX6OW+2
X-Google-Smtp-Source: AGHT+IFEgiv/oMH6zMYYtqaT1kchAaDlXi2IcfQveaywoKQGG/30eJYlHrTESus/gJsTsqI8VPCUpw==
X-Received: by 2002:a05:600c:83c5:b0:431:44f6:566f with SMTP id 5b1f17b1804b1-434a9dc14c7mr112122265e9.13.1732888478419;
        Fri, 29 Nov 2024 05:54:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:f573:30fa:4c5:27df? ([2a01:e0a:982:cbb0:f573:30fa:4c5:27df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74f18bsm87508445e9.4.2024.11.29.05.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 05:54:37 -0800 (PST)
Message-ID: <2c1ffbc6-0d67-4787-9fbe-03255b377c76@linaro.org>
Date: Fri, 29 Nov 2024 14:54:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 8/8] drm/msm/dp: Support external GPIO HPD with 3rd
 pinctrl chip
To: Xiangxu Yin <quic_xiangxuy@quicinc.com>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, quic_lliu6@quicinc.com, quic_fangez@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-gpio@vger.kernel.org
References: <20241129-add-displayport-support-for-qcs615-platform-v1-0-09a4338d93ef@quicinc.com>
 <20241129-add-displayport-support-for-qcs615-platform-v1-8-09a4338d93ef@quicinc.com>
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
In-Reply-To: <20241129-add-displayport-support-for-qcs615-platform-v1-8-09a4338d93ef@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/11/2024 08:57, Xiangxu Yin wrote:
> Add support for handling HPD (Hot Plug Detect) signals via external
> GPIOs connected through pinctrl chips (e.g., Semtech SX1509Q). This
> involves reinitializing the relevant GPIO and binding an interrupt
> handler to process hot plug events. Since external GPIOs only support
> edge interrupts (rising or falling) rather than state interrupts, the
> GPIO state must be read during the first DP bridge HPD enablement. This
> ensures the current connection state is determined and a hot plug event
> is reported accordingly.
> 
> Signed-off-by: Xiangxu Yin <quic_xiangxuy@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 83 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 83 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index eb6fb76c68e505fafbec563440e9784f51e1894b..22c288ca61b9b444a7b8d4a574c614bfef9d88be 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -13,6 +13,8 @@
>   #include <linux/delay.h>
>   #include <drm/display/drm_dp_aux_bus.h>
>   #include <drm/drm_edid.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/of_gpio.h>
>   
>   #include "msm_drv.h"
>   #include "msm_kms.h"
> @@ -78,6 +80,10 @@ struct msm_dp_display_private {
>   
>   	unsigned int id;
>   
> +	bool ext_gpio;
> +	int gpio_num;
> +	struct work_struct  gpio_work;
> +
>   	/* state variables */
>   	bool core_initialized;
>   	bool phy_initialized;
> @@ -1182,6 +1188,42 @@ static irqreturn_t msm_dp_display_irq_handler(int irq, void *dev_id)
>   	return ret;
>   }
>   
> +
> +static void msm_dp_gpio_work_handler(struct work_struct *work)
> +{
> +	struct msm_dp_display_private *dp = container_of(work,
> +			struct msm_dp_display_private, gpio_work);
> +	struct gpio_desc *desc;
> +	bool hpd;
> +
> +	if (dp->ext_gpio) {
> +		desc = gpio_to_desc(dp->gpio_num);
> +		if (!desc) {
> +			pr_err("Failed to get gpio_desc for GPIO %d\n", dp->gpio_num);
> +			return;
> +		}
> +
> +		hpd = gpiod_get_value_cansleep(desc);
> +		if (hpd)
> +			msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
> +		else
> +			msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
> +	}
> +}
> +
> +static irqreturn_t msm_dp_gpio_isr(int unused, void *data)
> +{
> +	struct msm_dp_display_private *dp = data;
> +
> +	if (!dp) {
> +		DRM_ERROR("NULL data\n");
> +		return IRQ_NONE;
> +	}
> +
> +	schedule_work(&dp->gpio_work);

this msm_dp_gpio_isr is already threaded, would would you also schedule a work ?

> +	return IRQ_HANDLED;
> +}
> +
>   static int msm_dp_display_request_irq(struct msm_dp_display_private *dp)
>   {
>   	int rc = 0;
> @@ -1193,6 +1235,21 @@ static int msm_dp_display_request_irq(struct msm_dp_display_private *dp)
>   		return dp->irq;
>   	}
>   
> +	if (dp->ext_gpio) {
> +		int edge, gpio_irq;
> +
> +		gpio_irq = gpio_to_irq(dp->gpio_num);

But as Dmitry reported, the system should use a dp-connected as a next bridge
instead which already supports all this much better:
drivers/gpu/drm/bridge/display-connector.c
Documentation/devicetree/bindings/display/connector/dp-connector.yaml

> +		edge = IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING;
> +
> +		rc = devm_request_threaded_irq(&pdev->dev, gpio_irq, NULL,
> +		msm_dp_gpio_isr, edge, "dp_gpio_isr", dp);
> +		if (rc < 0) {
> +			DRM_ERROR("failed to request ext-gpio IRQ%u: %d\n",
> +					gpio_irq, rc);
> +			return rc;
> +		}
> +	}
> +
>   	rc = devm_request_irq(&pdev->dev, dp->irq, msm_dp_display_irq_handler,
>   			      IRQF_TRIGGER_HIGH|IRQF_NO_AUTOEN,
>   			      "dp_display_isr", dp);
> @@ -1308,10 +1365,32 @@ static int msm_dp_display_probe(struct platform_device *pdev)
>   		return -EPROBE_DEFER;
>   	}
>   
> +	if (of_find_property(pdev->dev.of_node, "dp-hpd-gpio", NULL)) {
> +		dp->ext_gpio = true;
> +		dp->gpio_num = of_get_named_gpio(pdev->dev.of_node, "dp-hpd-gpio", 0);
> +		if (dp->gpio_num < 0) {
> +			dev_err(&pdev->dev, "Failed to get gpio:%d\n", dp->gpio_num);
> +			return dp->gpio_num;
> +		}
> +
> +		if (!gpio_is_valid(dp->gpio_num)) {
> +			DRM_ERROR("gpio(%d) invalid\n", dp->gpio_num);
> +			return -EINVAL;
> +		}
> +
> +		rc = gpio_request(dp->gpio_num, "dp-hpd-gpio");
> +		if (rc) {
> +			dev_err(&pdev->dev, "Failed to request gpio:%d\n", dp->gpio_num);
> +			return rc;
> +		}
> +		gpio_direction_input(dp->gpio_num);
> +	}
> +
>   	/* setup event q */
>   	mutex_init(&dp->event_mutex);
>   	init_waitqueue_head(&dp->event_q);
>   	spin_lock_init(&dp->event_lock);
> +	INIT_WORK(&dp->gpio_work, msm_dp_gpio_work_handler);
>   
>   	/* Store DP audio handle inside DP display */
>   	dp->msm_dp_display.msm_dp_audio = dp->audio;
> @@ -1678,6 +1757,10 @@ void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge)
>   	msm_dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_INT_MASK, true);
>   
>   	msm_dp_display->internal_hpd = true;
> +
> +	if (dp->ext_gpio)
> +		schedule_work(&dp->gpio_work);
> +
>   	mutex_unlock(&dp->event_mutex);
>   }
>   
> 


