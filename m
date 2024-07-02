Return-Path: <linux-kernel+bounces-237614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F0F923B87
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D2A61C21C4B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119E21586FB;
	Tue,  2 Jul 2024 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+jDMOCu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EBF158879
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916486; cv=none; b=iWO3gpaf4bbXGXmAkS/LjJ8ubRno/1YQlJ54Qnv62l8QbgO/IovsFJ8M8RryGs6ZIABcFsGqF9y2QQkvDghXRZgUCeHfD5/tgOERQL6A9jDXuYc4WRYA8EzJy/4xMWGUdCNCbfmxQOkuKHGNezEHgZywu2c62Aj9jE1++HiIXMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916486; c=relaxed/simple;
	bh=LxLrihk18XTmkwJr0hK6awJm1ovLKKbeWjvX+fM/dc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LXPDl+M67lKpIeYpxrlVBhC1Zrebq/AAdbh4XpL6wIgkXo4hrKUHPea7d9CTAL/lkxoNs+8qp2srlOBapS2S9kosA7CWoYZtzwEC3H+MOrABTLSU+vaSqrqX+kY1bR6emtL4/75l/nDYXPvBAT16QQXQ/I6TArsN7//leV/fQ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+jDMOCu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719916482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itOy7/X4Git08lkOXs4gTAO04Hfhg32Pj9YXj8LzoBo=;
	b=D+jDMOCuvLLN962Z12rTfA/gkAfezJj9tcshZt6UlDnPOUE19EWAEmsL+CqJYl9lCAguBv
	IU6nmKaEfJBhbtRS6nA12MSiBloj5xtPx6wTFRVVmfm1JiWmQRK3S8ctgPz6YT/3GHXWa4
	o9hGYVVH+Hh1Zp8REOPWgPOa5GgImFE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-jGWiGsnpPYugRBeHWtQD3Q-1; Tue, 02 Jul 2024 06:34:41 -0400
X-MC-Unique: jGWiGsnpPYugRBeHWtQD3Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a72b3066669so516283966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 03:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719916480; x=1720521280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itOy7/X4Git08lkOXs4gTAO04Hfhg32Pj9YXj8LzoBo=;
        b=J+e0S+sY0rNdSCRkBzCyebXm5pYI1/OoOVfB2qxVwAIEuGLzX10bNubA+vkmWKtstK
         V67ni731uBPYtpNBSmhWuO3xNDeiq65DWzLCARp56YEVCRKbvzGZv0tBK8T9KttqjERL
         DMRS5rBJtf0ulzhJThRzo24IkzfQ3y8+Dk4mpwapT7+3bnEHciTbdMeUAjlfsP8tgtQY
         75gVGOHOOUWlJ+faaKWnoZp2HWqmrZfVvgn11nHKNKIX+kH9hidk8j+yjCJ1eFeZO8d9
         rLVJJ5ZRBVQUp++jqR6Lo943Zl4bi/OMThtnREFb6Fc4kaUo47Eqrj46G/wjSm2XP/0m
         jnZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5sldYxok5LbQIrh8Zzr+AegzASOlasgC9/BQjTpCsiwynIrfj+qdaDT7SES0tdzT4CTf2yG2g0qEWZ0LMIbNMJyW0mBC4pKVVaU6k
X-Gm-Message-State: AOJu0YxJSjzbdET7Ezna0P5yMRD+RaC488/QOchoyxQMSXaHROcYEggW
	OraE+4YE7PRiCzGbU5mgGoIuxlQaqX5lWESJ01Bx4GRQDQh2L+81hkJm0ezqdlUb4+qMki+qVR/
	rr6OegfE6DFDqoB/ZkJ3uv4YfkhDqL1F5Tu3jZt2RMAFKJ4KudbqjUE9Hxzeajw==
X-Received: by 2002:a17:906:f0ce:b0:a72:5ca4:3ab0 with SMTP id a640c23a62f3a-a751388eef1mr669225266b.10.1719916480382;
        Tue, 02 Jul 2024 03:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEv2ZwgMR5QlRNZNacaLeITFh1WalTL5wf9dRqgw7POT5Yq3rejBsmkSF/2Sj22ISh2Av2mig==
X-Received: by 2002:a17:906:f0ce:b0:a72:5ca4:3ab0 with SMTP id a640c23a62f3a-a751388eef1mr669221366b.10.1719916479022;
        Tue, 02 Jul 2024 03:34:39 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72af0c9d06sm392076066b.18.2024.07.02.03.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 03:34:38 -0700 (PDT)
Message-ID: <fb121882-c37b-4824-a9a1-1ce0c54511d3@redhat.com>
Date: Tue, 2 Jul 2024 12:34:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] media: atomisp: Remove unused GPIO related defines
 and APIs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Kate Hsuan <hpa@redhat.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-staging@lists.linux.dev
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240424210800.1776038-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240424210800.1776038-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4/24/24 11:08 PM, Andy Shevchenko wrote:
> Remove unused GPIO related defines and APIs.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you for your patch.

I have merged this in my media-atomisp branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=media-atomisp

And this patch will be included in my next
pull-request to Mauro (to media subsystem maintainer)

Regards,

Hans


> ---
>  .../media/atomisp/pci/gpio_block_defs.h       | 17 -------
>  .../pci/hive_isp_css_common/gpio_global.h     | 23 ----------
>  .../pci/hive_isp_css_common/host/gpio_local.h | 21 ---------
>  .../hive_isp_css_common/host/gpio_private.h   |  9 ++--
>  .../atomisp/pci/hive_isp_css_include/gpio.h   | 46 -------------------
>  .../hive_isp_css_include/host/gpio_public.h   | 46 -------------------
>  drivers/staging/media/atomisp/pci/sh_css.c    | 10 ++--
>  7 files changed, 7 insertions(+), 165 deletions(-)
>  delete mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gpio_local.h
>  delete mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/gpio.h
>  delete mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/host/gpio_public.h
> 
> diff --git a/drivers/staging/media/atomisp/pci/gpio_block_defs.h b/drivers/staging/media/atomisp/pci/gpio_block_defs.h
> index e1bd638d344a..55c39067a9bf 100644
> --- a/drivers/staging/media/atomisp/pci/gpio_block_defs.h
> +++ b/drivers/staging/media/atomisp/pci/gpio_block_defs.h
> @@ -16,27 +16,10 @@
>  #ifndef _gpio_block_defs_h_
>  #define _gpio_block_defs_h_
>  
> -#define _HRT_GPIO_BLOCK_REG_ALIGN 4
> -
>  /* R/W registers */
>  #define _gpio_block_reg_do_e				 0
>  #define _gpio_block_reg_do_select		       1
>  #define _gpio_block_reg_do_0				 2
>  #define _gpio_block_reg_do_1				 3
> -#define _gpio_block_reg_do_pwm_cnt_0	     4
> -#define _gpio_block_reg_do_pwm_cnt_1	     5
> -#define _gpio_block_reg_do_pwm_cnt_2	     6
> -#define _gpio_block_reg_do_pwm_cnt_3	     7
> -#define _gpio_block_reg_do_pwm_main_cnt    8
> -#define _gpio_block_reg_do_pwm_enable      9
> -#define _gpio_block_reg_di_debounce_sel	  10
> -#define _gpio_block_reg_di_debounce_cnt_0	11
> -#define _gpio_block_reg_di_debounce_cnt_1	12
> -#define _gpio_block_reg_di_debounce_cnt_2	13
> -#define _gpio_block_reg_di_debounce_cnt_3	14
> -#define _gpio_block_reg_di_active_level	  15
> -
> -/* read-only registers */
> -#define _gpio_block_reg_di				  16
>  
>  #endif /* _gpio_block_defs_h_ */
> diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/gpio_global.h b/drivers/staging/media/atomisp/pci/hive_isp_css_common/gpio_global.h
> index b5f017482f89..06b6cb3842f4 100644
> --- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/gpio_global.h
> +++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/gpio_global.h
> @@ -16,31 +16,8 @@
>  #ifndef __GPIO_GLOBAL_H_INCLUDED__
>  #define __GPIO_GLOBAL_H_INCLUDED__
>  
> -#define IS_GPIO_VERSION_1
> -
>  #include <gpio_block_defs.h>
>  
> -/* pqiao: following part only defines in hive_isp_css_defs.h in fpga system.
> -	port it here
> -*/
> -
> -/* GPIO pin defines */
> -/*#define HIVE_GPIO_CAMERA_BOARD_RESET_PIN_NR                   0
> -#define HIVE_GPIO_LCD_CLOCK_SELECT_PIN_NR                     7
> -#define HIVE_GPIO_HDMI_CLOCK_SELECT_PIN_NR                    8
> -#define HIVE_GPIO_LCD_VERT_FLIP_PIN_NR                        8
> -#define HIVE_GPIO_LCD_HOR_FLIP_PIN_NR                         9
> -#define HIVE_GPIO_AS3683_GPIO_P0_PIN_NR                       1
> -#define HIVE_GPIO_AS3683_DATA_P1_PIN_NR                       2
> -#define HIVE_GPIO_AS3683_CLK_P2_PIN_NR                        3
> -#define HIVE_GPIO_AS3683_T1_F0_PIN_NR                         4
> -#define HIVE_GPIO_AS3683_SFL_F1_PIN_NR                        5
> -#define HIVE_GPIO_AS3683_STROBE_F2_PIN_NR                     6
> -#define HIVE_GPIO_MAX1577_EN1_PIN_NR                          1
> -#define HIVE_GPIO_MAX1577_EN2_PIN_NR                          2
> -#define HIVE_GPIO_MAX8685A_EN_PIN_NR                          3
> -#define HIVE_GPIO_MAX8685A_TRIG_PIN_NR                        4*/
> -
>  #define HIVE_GPIO_STROBE_TRIGGER_PIN		2
>  
>  #endif /* __GPIO_GLOBAL_H_INCLUDED__ */
> diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gpio_local.h b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gpio_local.h
> deleted file mode 100644
> index 14013733f826..000000000000
> --- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gpio_local.h
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Support for Intel Camera Imaging ISP subsystem.
> - * Copyright (c) 2010-2015, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU General Public License,
> - * version 2, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> - */
> -
> -#ifndef __GPIO_LOCAL_H_INCLUDED__
> -#define __GPIO_LOCAL_H_INCLUDED__
> -
> -#include "gpio_global.h"
> -
> -#endif /* __GPIO_LOCAL_H_INCLUDED__ */
> diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gpio_private.h b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gpio_private.h
> index cc60bed71ddb..85fcde0b8615 100644
> --- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gpio_private.h
> +++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gpio_private.h
> @@ -16,13 +16,10 @@
>  #ifndef __GPIO_PRIVATE_H_INCLUDED__
>  #define __GPIO_PRIVATE_H_INCLUDED__
>  
> -#include "gpio_public.h"
> -
> +#include "assert_support.h"
>  #include "device_access.h"
>  
> -#include "assert_support.h"
> -
> -STORAGE_CLASS_GPIO_C void gpio_reg_store(
> +static inline void gpio_reg_store(
>      const gpio_ID_t	ID,
>      const unsigned int		reg,
>      const hrt_data			value)
> @@ -33,7 +30,7 @@ STORAGE_CLASS_GPIO_C void gpio_reg_store(
>  	return;
>  }
>  
> -STORAGE_CLASS_GPIO_C hrt_data gpio_reg_load(
> +static inline hrt_data gpio_reg_load(
>      const gpio_ID_t	ID,
>      const unsigned int		reg)
>  {
> diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/gpio.h b/drivers/staging/media/atomisp/pci/hive_isp_css_include/gpio.h
> deleted file mode 100644
> index 6f16ca77cf75..000000000000
> --- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/gpio.h
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Support for Intel Camera Imaging ISP subsystem.
> - * Copyright (c) 2015, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU General Public License,
> - * version 2, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> - */
> -
> -#ifndef __GPIO_H_INCLUDED__
> -#define __GPIO_H_INCLUDED__
> -
> -/*
> - * This file is included on every cell {SP,ISP,host} and on every system
> - * that uses the input system device(s). It defines the API to DLI bridge
> - *
> - * System and cell specific interfaces and inline code are included
> - * conditionally through Makefile path settings.
> - *
> - *  - .        system and cell agnostic interfaces, constants and identifiers
> - *	- public:  system agnostic, cell specific interfaces
> - *	- private: system dependent, cell specific interfaces & inline implementations
> - *	- global:  system specific constants and identifiers
> - *	- local:   system and cell specific constants and identifiers
> - */
> -
> -#include "system_local.h"
> -#include "gpio_local.h"
> -
> -#ifndef __INLINE_GPIO__
> -#define STORAGE_CLASS_GPIO_H extern
> -#define STORAGE_CLASS_GPIO_C
> -#include "gpio_public.h"
> -#else  /* __INLINE_GPIO__ */
> -#define STORAGE_CLASS_GPIO_H static inline
> -#define STORAGE_CLASS_GPIO_C static inline
> -#include "gpio_private.h"
> -#endif /* __INLINE_GPIO__ */
> -
> -#endif /* __GPIO_H_INCLUDED__ */
> diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_include/host/gpio_public.h b/drivers/staging/media/atomisp/pci/hive_isp_css_include/host/gpio_public.h
> deleted file mode 100644
> index 13df9b57a5fb..000000000000
> --- a/drivers/staging/media/atomisp/pci/hive_isp_css_include/host/gpio_public.h
> +++ /dev/null
> @@ -1,46 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * Support for Intel Camera Imaging ISP subsystem.
> - * Copyright (c) 2015, Intel Corporation.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU General Public License,
> - * version 2, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> - */
> -
> -#ifndef __GPIO_PUBLIC_H_INCLUDED__
> -#define __GPIO_PUBLIC_H_INCLUDED__
> -
> -#include "system_local.h"
> -
> -/*! Write to a control register of GPIO[ID]
> -
> - \param	ID[in]				GPIO identifier
> - \param	reg_addr[in]		register byte address
> - \param value[in]			The data to be written
> -
> - \return none, GPIO[ID].ctrl[reg] = value
> - */
> -STORAGE_CLASS_GPIO_H void gpio_reg_store(
> -    const gpio_ID_t	ID,
> -    const unsigned int		reg_addr,
> -    const hrt_data			value);
> -
> -/*! Read from a control register of GPIO[ID]
> -
> - \param	ID[in]				GPIO identifier
> - \param	reg_addr[in]		register byte address
> - \param value[in]			The data to be written
> -
> - \return GPIO[ID].ctrl[reg]
> - */
> -STORAGE_CLASS_GPIO_H hrt_data gpio_reg_load(
> -    const gpio_ID_t	ID,
> -    const unsigned int		reg_addr);
> -
> -#endif /* __GPIO_PUBLIC_H_INCLUDED__ */
> diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
> index e2497fc4dfc9..01f0b8a33c99 100644
> --- a/drivers/staging/media/atomisp/pci/sh_css.c
> +++ b/drivers/staging/media/atomisp/pci/sh_css.c
> @@ -66,8 +66,8 @@
>  #include "sp.h"			/* cnd_sp_irq_enable() */
>  #include "isp.h"		/* cnd_isp_irq_enable, ISP_VEC_NELEMS */
>  #include "gp_device.h"		/* gp_device_reg_store() */
> -#define __INLINE_GPIO__
> -#include "gpio.h"
> +#include <gpio_global.h>
> +#include <gpio_private.h>
>  #include "timed_ctrl.h"
>  #include "ia_css_inputfifo.h"
>  #define WITH_PC_MONITORING  0
> @@ -1363,10 +1363,8 @@ ia_css_init(struct device *dev, const struct ia_css_env *env,
>  
>  	ia_css_device_access_init(&env->hw_access_env);
>  
> -	select = gpio_reg_load(GPIO0_ID, _gpio_block_reg_do_select)
> -	& (~GPIO_FLASH_PIN_MASK);
> -	enable = gpio_reg_load(GPIO0_ID, _gpio_block_reg_do_e)
> -	| GPIO_FLASH_PIN_MASK;
> +	select = gpio_reg_load(GPIO0_ID, _gpio_block_reg_do_select) & ~GPIO_FLASH_PIN_MASK;
> +	enable = gpio_reg_load(GPIO0_ID, _gpio_block_reg_do_e) | GPIO_FLASH_PIN_MASK;
>  	sh_css_mmu_set_page_table_base_index(mmu_l1_base);
>  
>  	my_css_save.mmu_base = mmu_l1_base;


