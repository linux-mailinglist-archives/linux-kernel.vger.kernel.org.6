Return-Path: <linux-kernel+bounces-511705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0917CA32E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22371165CC2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528CF26280D;
	Wed, 12 Feb 2025 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VqNR7n44"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D5225D53A;
	Wed, 12 Feb 2025 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384447; cv=none; b=X4qtj2YQdtUgeEbaBVXvSgL0ikryNuwxxwjQiLmJCMDdLjM4z+CGTgjZmFAAS7m07ariClq+SdVrCZjo0ktJtv7kUsu0O38mGC9GA+78sSXYKCRFwdRHu9fJJl17fWCXVk6OIWUlEECSg+1E6UmyrrvSmRk65XMdPohFx+GDIfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384447; c=relaxed/simple;
	bh=dhBtvZEDw9vWKqBf6fTX0+u21TtFq+oo0b5106Syej8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxZro3ZARl11uGfS0p1hphMqEZEhANBXL3iGa0+rrH4gcQjchI/aAvg/z+yRTvlctP/BXATzu8OKX3p9tGhq1UEhocYBrkYqyJrhiilT/2a/IKXLoqLcKJP0Eai7famk6AtpzMSHrOsDrqIJZS0PehDuBwRZRXilcZPryV1fb5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VqNR7n44; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D7F61442F4;
	Wed, 12 Feb 2025 18:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739384439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vk0Fow6XyJcuTmvJGN1iZDWTQy2zS6RTXhLELnEwuWc=;
	b=VqNR7n44+gTdjGc7TaAvKBQ8GSV4Oe9iCTOuBTz/+LOPO0H1OCW6KKceCoNfeaBr4czldS
	I6kuzQqlqLcs5ZuZYOLX/M0ps33MjJDmnmSa0PjS0Sz4Y6rgS7nwmgUFbW0jN+ITia0KRq
	smcNBbmxMCO1j6cFS3h7Vz5hAP2dzCviyPrqBG3l8vwNBSYFqOlPS2AtPhz0HfRsC+S+yN
	qC1xGMEH8fMFqiJSr7pMEnS7qtJ6rucQTJGi76jz1J3oHq2zC+2rQ55vgjvzK6yLPwzfmL
	prpV7XbEPSr173yboOfXd5+xvz6o+d8oXnfYHGUYxw6FdtQYSORDxSfbqLB1tg==
Date: Wed, 12 Feb 2025 19:20:38 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Aman Kumar Pandey <aman.kumarpandey@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
	krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, vikash.bansal@nxp.com,
	priyanka.jain@nxp.com, shashank.rebbapragada@nxp.com,
	Frank.Li@nxp.com
Subject: Re: [PATCH 2/2] drivers: i3c: Add driver for NXP P3H2x4x i3c-hub
 device
Message-ID: <2025021218203856a42320@mail.local>
References: <20250212132227.1348374-1-aman.kumarpandey@nxp.com>
 <20250212132227.1348374-2-aman.kumarpandey@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212132227.1348374-2-aman.kumarpandey@nxp.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeehkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegieduueethefhkeegjeevfefhiedujeeuhffgleejgfejgeekueejuefgheeggfenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegvtdgrmedvugemieefjedtmeejkegvtdemtgdtvgekmedvkedtieemkegrtgeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedvugemieefjedtmeejkegvtdemtgdtvgekmedvkedtieemkegrtgeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduuddprhgtphhtthhopegrmhgrnhdrkhhumhgrrhhprghnuggvhiesnhigphdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtt
 hhopehlihhnuhigqdhifegtsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhikhgrshhhrdgsrghnshgrlhesnhigphdrtghomh
X-GND-Sasl: alexandre.belloni@bootlin.com

On 12/02/2025 15:22:27+0200, Aman Kumar Pandey wrote:
> P3H2x4x (P3H2440/P3H2441/P3H2840/P3H2841) is multiport I3C hub devices.
> It connects to a host CPU via I3C/I2C/SMBus bus on one side and to multiple
> peripheral devices on the other side.
> P3H2840/ P3H2841 have eight I3C/I2C Target Port.
> P3H2440/ P3H2441 have four I3C/I2C Target Port.
> 
> This driver can support
> 1. i3c/i2c communication between host and hub
> 2. i3c/i2c transparent mode between host and downstream devices.
> 3. Target ports can be configured as I2C/SMBus mode or I3C.
> 4. MCTP devices
> 5. In-band interrupts
> 
> Signed-off-by: Aman Kumar Pandey <aman.kumarpandey@nxp.com>
> Signed-off-by: Vikash Bansal <vikash.bansal@nxp.com>
> ---
>  MAINTAINERS                                  |   1 +
>  drivers/i3c/Kconfig                          |   1 +
>  drivers/i3c/Makefile                         |   1 +
>  drivers/i3c/p3h2x4x/Kconfig                  |  11 +
>  drivers/i3c/p3h2x4x/Makefile                 |   4 +
>  drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub.h        | 454 +++++++++
>  drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_common.c | 941 +++++++++++++++++++
>  drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_i3c.c    | 353 +++++++
>  drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c  | 719 ++++++++++++++
>  include/linux/i3c/device.h                   |   1 +
>  10 files changed, 2486 insertions(+)
>  create mode 100644 drivers/i3c/p3h2x4x/Kconfig
>  create mode 100644 drivers/i3c/p3h2x4x/Makefile
>  create mode 100644 drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub.h
>  create mode 100644 drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_common.c
>  create mode 100644 drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_i3c.c
>  create mode 100644 drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c
> 


Please run checkpatch in strict mode. Also, the directory should be
named hub, I'm not going to have one directory per hub. You must avoid
wildcards in the filenames and compatibles, the device seems to be
P3H2840HN. Also, please check whether your driver is compatible with the
Renesas RG3MxxB12B0 family which I guess it is.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 20aa3e987ac5..8e4ec4e3656e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17173,6 +17173,7 @@ M:	Aman Kumar Pandey <aman.kumarpandey@nxp.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/i3c/p3h2x4x_i3c_hub.yaml
> +F:	i3c/p3h2x4x/*
>  
>  NZXT-KRAKEN2 HARDWARE MONITORING DRIVER
>  M:	Jonas Malaco <jonas@protocubo.io>
> diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
> index 30a441506f61..3160437cc8e1 100644
> --- a/drivers/i3c/Kconfig
> +++ b/drivers/i3c/Kconfig
> @@ -21,4 +21,5 @@ menuconfig I3C
>  
>  if I3C
>  source "drivers/i3c/master/Kconfig"
> +source "drivers/i3c/p3h2x4x/Kconfig"
>  endif # I3C
> diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
> index 11982efbc6d9..696747cc7f18 100644
> --- a/drivers/i3c/Makefile
> +++ b/drivers/i3c/Makefile
> @@ -2,3 +2,4 @@
>  i3c-y				:= device.o master.o
>  obj-$(CONFIG_I3C)		+= i3c.o
>  obj-$(CONFIG_I3C)		+= master/
> +obj-$(CONFIG_I3C)		+= p3h2x4x/
> diff --git a/drivers/i3c/p3h2x4x/Kconfig b/drivers/i3c/p3h2x4x/Kconfig
> new file mode 100644
> index 000000000000..b8b18342b065
> --- /dev/null
> +++ b/drivers/i3c/p3h2x4x/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2024-2025 NXP
> +config P3H2X4X_I3C_HUB
> +	tristate "P3H2X4X I3C HUB support"
> +	depends on I3C
> +	select REGMAP_I3C
> +	help
> +		This enables support for NXP P3H244x/P3H284x I3C HUB. Say Y or M here to use
> +		I3C HUB driver to configure I3C HUB device.
> +		I3C HUB driver's probe will trigger when I3C device with DCR
> +		equals to 0xC2 (HUB device) is detected on the bus.
> diff --git a/drivers/i3c/p3h2x4x/Makefile b/drivers/i3c/p3h2x4x/Makefile
> new file mode 100644
> index 000000000000..214a3eeb62f2
> --- /dev/null
> +++ b/drivers/i3c/p3h2x4x/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2024-2025 NXP
> +p3h2x4x_i3c_hub-y := p3h2x4x_i3c_hub_common.o p3h2x4x_i3c_hub_i3c.o p3h2x4x_i3c_hub_smbus.o
> +obj-$(CONFIG_P3H2X4X_I3C_HUB)	+= p3h2x4x_i3c_hub.o
> diff --git a/drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub.h b/drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub.h
> new file mode 100644
> index 000000000000..e8c627019556
> --- /dev/null
> +++ b/drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub.h
> @@ -0,0 +1,454 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2024-2025 NXP
> + * This header file contain private device structure definition, Reg address and its bit
> + * mapping etc.
> + */
> +
> +#ifndef P3H2X4X_I3C_HUB_H
> +#define P3H2X4X_I3C_HUB_H
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/i3c/device.h>
> +#include <linux/i3c/master.h>
> +#include <linux/mutex.h>
> +#include <linux/rwsem.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +
> +/* I3C HUB REGISTERS */
> +
> +/* Device Information Registers */
> +#define P3H2x4x_DEV_INFO_0					0x00
> +#define P3H2x4x_DEV_INFO_1					0x01
> +#define P3H2x4x_PID_5						0x02
> +#define P3H2x4x_PID_4						0x03
> +#define P3H2x4x_PID_3						0x04
> +#define P3H2x4x_PID_2						0x05
> +#define P3H2x4x_PID_1						0x06
> +#define P3H2x4x_PID_0						0x07
> +#define P3H2x4x_BCR						0x08
> +#define P3H2x4x_DCR						0x09
> +#define P3H2x4x_DEV_CAPAB					0x0A
> +#define P3H2x4x_DEV_REV						0x0B
> +
> +/* Device Configuration Registers */
> +#define P3H2x4x_DEV_REG_PROTECTION_CODE				0x10
> +#define P3H2x4x_REGISTERS_LOCK_CODE				0x00
> +#define P3H2x4x_REGISTERS_UNLOCK_CODE				0x69
> +#define P3H2x4x_CP1_REGISTERS_UNLOCK_CODE			0x6A
> +
> +#define P3H2x4x_CP_CONF						0x11
> +#define P3H2x4x_TP_ENABLE					0x12
> +#define P3H2x4x_TPn_ENABLE(n)					BIT(n)
> +
> +#define P3H2x4x_DEV_CONF					0x13
> +#define P3H2x4x_IO_STRENGTH					0x14
> +#define P3H2x4x_TP0145_IO_STRENGTH_MASK				GENMASK(1, 0)
> +#define P3H2x4x_TP0145_IO_STRENGTH(x)	\
> +		(((x) << 0) & P3H2x4x_TP0145_IO_STRENGTH_MASK)
> +#define P3H2x4x_TP2367_IO_STRENGTH_MASK				GENMASK(3, 2)
> +#define P3H2x4x_TP2367_IO_STRENGTH(x)	\
> +		(((x) << 2) & P3H2x4x_TP2367_IO_STRENGTH_MASK)
> +#define P3H2x4x_CP0_IO_STRENGTH_MASK				GENMASK(5, 4)
> +#define P3H2x4x_CP0_IO_STRENGTH(x)	\
> +		(((x) << 4) & P3H2x4x_CP0_IO_STRENGTH_MASK)
> +#define P3H2x4x_CP1_IO_STRENGTH_MASK				GENMASK(7, 6)
> +#define P3H2x4x_CP1_IO_STRENGTH(x)	\
> +		(((x) << 6) & P3H2x4x_CP1_IO_STRENGTH_MASK)
> +
> +#define P3H2x4x_NET_OPER_MODE_CONF				0x15
> +#define P3H2x4x_VCCIO_LDO_CONF					0x16
> +#define P3H2x4x_CP0_VCCIO_LDO_VOLTAGE_MASK			GENMASK(1, 0)
> +#define P3H2x4x_CP0_VCCIO_LDO_VOLTAGE(x)	\
> +		(((x) << 0) & P3H2x4x_CP0_VCCIO_LDO_VOLTAGE_MASK)
> +#define P3H2x4x_CP1_VCCIO_LDO_VOLTAGE_MASK			GENMASK(3, 2)
> +#define P3H2x4x_CP1_VCCIO_LDO_VOLTAGE(x)	\
> +		(((x) << 2) & P3H2x4x_CP1_VCCIO_LDO_VOLTAGE_MASK)
> +#define P3H2x4x_TP0145_VCCIO_LDO_VOLTAGE_MASK			GENMASK(5, 4)
> +#define P3H2x4x_TP0145_VCCIO_LDO_VOLTAGE(x)	\
> +		(((x) << 4) & P3H2x4x_TP0145_VCCIO_LDO_VOLTAGE_MASK)
> +#define P3H2x4x_TP2367_VCCIO_LDO_VOLTAGE_MASK			GENMASK(7, 6)
> +#define P3H2x4x_TP2367_VCCIO_LDO_VOLTAGE(x)	\
> +		(((x) << 6) & P3H2x4x_TP2367_VCCIO_LDO_VOLTAGE_MASK)
> +
> +#define P3H2x4x_TP_IO_MODE_CONF					0x17
> +#define P3H2x4x_TP_SMBUS_AGNT_EN				0x18
> +#define P3H2x4x_TPn_SMBUS_MODE_EN(n)				BIT(n)
> +#define P3H2x4x_TPn_I2C_MODE_EN(n)				BIT(n)
> +
> +#define P3H2x4x_LDO_AND_PULLUP_CONF				0x19
> +#define P3H2x4x_LDO_ENABLE_DISABLE_MASK				GENMASK(3, 0)
> +#define P3H2x4x_CP0_EN_LDO				        BIT(0)
> +#define P3H2x4x_CP1_EN_LDO				        BIT(1)
> +#define P3H2x4x_TP0145_EN_LDO					BIT(2)
> +#define P3H2x4x_TP2367_EN_LDO					BIT(3)
> +
> +#define P3H2x4x_TP0145_PULLUP_CONF_MASK				GENMASK(7, 6)
> +#define P3H2x4x_TP0145_PULLUP_CONF(x)	\
> +		(((x) << 6) & P3H2x4x_TP0145_PULLUP_CONF_MASK)
> +#define P3H2x4x_TP2367_PULLUP_CONF_MASK				GENMASK(5, 4)
> +#define P3H2x4x_TP2367_PULLUP_CONF(x)	\
> +		(((x) << 4) & P3H2x4x_TP2367_PULLUP_CONF_MASK)
> +
> +#define P3H2x4x_CP_IBI_CONF					0x1A
> +
> +#define P3H2x4x_TP_SMBUS_AGNT_IBI_CONFIG			0x1B
> +#define P3H2x4x_TPn_IBI_EN(n)					BIT(n)
> +#define P3H2x4x_ALL_TP_IBI_EN					0xFF
> +#define P3H2x4x_ALL_TP_IBI_DIS					0x00
> +
> +#define P3H2x4x_IBI_MDB_CUSTOM					0x1C
> +#define P3H2x4x_JEDEC_CONTEXT_ID				0x1D
> +#define P3H2x4x_TP_GPIO_MODE_EN					0x1E
> +#define P3H2x4x_TPn_GPIO_MODE_EN(n)				BIT(n)
> +
> +/* Device Status and IBI Registers */
> +#define P3H2x4x_DEV_AND_IBI_STS					0x20
> +#define P3H2x4x_TP_SMBUS_AGNT_IBI_STS				0x21
> +#define P3H2x4x_SMBUS_AGENT_EVENT_FLAG_STATUS			BIT(4)
> +
> +/* Controller Port Control/Status Registers */
> +#define P3H2x4x_CP_MUX_SET					0x38
> +#define P3H2x4x_CONTROLLER_PORT_MUX_REQ				BIT(0)
> +#define P3H2x4x_CP_MUX_STS					0x39
> +#define P3H2x4x_CONTROLLER_PORT_MUX_CONNECTION_STATUS		BIT(0)
> +
> +/* Target Ports Control Registers */
> +#define P3H2x4x_TP_SMBUS_AGNT_TRANS_START			0x50
> +#define P3H2x4x_TP_NET_CON_CONF					0x51
> +#define P3H2x4x_TPn_NET_CON(n)					BIT(n)
> +
> +#define P3H2x4x_TP_PULLUP_EN					0x53
> +#define P3H2x4x_TPn_PULLUP_EN(n)				BIT(n)
> +
> +#define P3H2x4x_TP_SCL_OUT_EN					0x54
> +#define P3H2x4x_TP_SDA_OUT_EN					0x55
> +#define P3H2x4x_TP_SCL_OUT_LEVEL				0x56
> +#define P3H2x4x_TP_SDA_OUT_LEVEL				0x57
> +#define P3H2x4x_TP_IN_DETECT_MODE_CONF				0x58
> +#define P3H2x4x_TP_SCL_IN_DETECT_IBI_EN				0x59
> +#define P3H2x4x_TP_SDA_IN_DETECT_IBI_EN				0x5A
> +
> +/* Target Ports Status Registers */
> +#define P3H2x4x_TP_SCL_IN_LEVEL_STS				0x60
> +#define P3H2x4x_TP_SDA_IN_LEVEL_STS				0x61
> +#define P3H2x4x_TP_SCL_IN_DETECT_FLG				0x62
> +#define P3H2x4x_TP_SDA_IN_DETECT_FLG				0x63
> +
> +/* SMBus Agent Configuration and Status Registers */
> +#define P3H2x4x_TP0_SMBUS_AGNT_STS				0x64
> +#define P3H2x4x_TP1_SMBUS_AGNT_STS				0x65
> +#define P3H2x4x_TP2_SMBUS_AGNT_STS				0x66
> +#define P3H2x4x_TP3_SMBUS_AGNT_STS				0x67
> +#define P3H2x4x_TP4_SMBUS_AGNT_STS				0x68
> +#define P3H2x4x_TP5_SMBUS_AGNT_STS				0x69
> +#define P3H2x4x_TP6_SMBUS_AGNT_STS				0x6A
> +#define P3H2x4x_TP7_SMBUS_AGNT_STS				0x6B
> +#define P3H2x4x_ONCHIP_TD_AND_SMBUS_AGNT_CONF			0x6C
> +
> +/* buf receive flag set */
> +#define P3H2x4x_TARGET_BUF_CA_TF				BIT(0)
> +#define P3H2x4x_TARGET_BUF_0_RECEIVE				BIT(1)
> +#define P3H2x4x_TARGET_BUF_1_RECEIVE				BIT(2)
> +#define P3H2x4x_TARGET_BUF_0_1_RECEIVE				GENMASK(2, 1)
> +#define P3H2x4x_TARGET_BUF_OVRFL				GENMASK(3, 1)
> +#define BUF_RECEIVED_FLAG_MASK					GENMASK(3, 1)
> +#define BUF_RECEIVED_FLAG_TF_MASK				GENMASK(3, 0)
> +
> +#define P3H2x4x_TARGET_AGENT_LOCAL_DEV				0x11
> +#define P3H2x4x_TARGET_BUFF_0_PAGE				0x12
> +#define P3H2x4x_TARGET_BUFF_1_PAGE				0x13
> +
> +/* Special Function Registers */
> +#define P3H2x4x_LDO_AND_CPSEL_STS				0x79
> +#define P3H2x4x_CP_SDA1_LEVEL					BIT(7)
> +#define P3H2x4x_CP_SCL1_LEVEL					BIT(6)
> +
> +#define P3H2x4x_CP_SEL_PIN_INPUT_CODE_MASK			GENMASK(5, 4)
> +#define P3H2x4x_CP_SEL_PIN_INPUT_CODE_GET(x)	\
> +		(((x) & P3H2x4x_CP_SEL_PIN_INPUT_CODE_MASK) >> 4)
> +#define P3H2x4x_CP_SDA1_SCL1_PINS_CODE_MASK			GENMASK(7, 6)
> +#define P3H2x4x_CP_SDA1_SCL1_PINS_CODE_GET(x)	\
> +		(((x) & P3H2x4x_CP_SDA1_SCL1_PINS_CODE_MASK) >> 6)
> +#define P3H2x4x_VCCIO1_PWR_GOOD					BIT(3)
> +#define P3H2x4x_VCCIO0_PWR_GOOD					BIT(2)
> +#define P3H2x4x_CP1_VCCIO_PWR_GOOD				BIT(1)
> +#define P3H2x4x_CP0_VCCIO_PWR_GOOD				BIT(0)
> +
> +#define P3H2x4x_BUS_RESET_SCL_TIMEOUT				0x7A
> +#define P3H2x4x_ONCHIP_TD_PROTO_ERR_FLG				0x7B
> +#define P3H2x4x_DEV_CMD						0x7C
> +#define P3H2x4x_ONCHIP_TD_STS					0x7D
> +#define P3H2x4x_ONCHIP_TD_ADDR_CONF				0x7E
> +#define P3H2x4x_PAGE_PTR					0x7F
> +
> +/* Paged Transaction Registers */
> +#define P3H2x4x_CONTROLLER_BUFFER_PAGE				0x10
> +#define P3H2x4x_CONTROLLER_AGENT_BUFF				0x80
> +#define P3H2x4x_CONTROLLER_AGENT_BUFF_DATA			0x84
> +
> +#define P3H2x4x_TARGET_BUFF_LENGTH				0x80
> +#define P3H2x4x_TARGET_BUFF_ADDRESS				0x81
> +#define P3H2x4x_TARGET_BUFF_DATA				0x82
> +
> +#define P3H2x4x_TP_MAX_COUNT					0x08
> +#define P3H2x4x_CP_MAX_COUNT					0x02
> +#define P3H2x4x_TP_LOCAL_DEV					0x08
> +
> +/* LDO Disable/Enable DT settings */
> +#define P3H2x4x_LDO_VOLT_1_0V					0x00
> +#define P3H2x4x_LDO_VOLT_1_1V					0x01
> +#define P3H2x4x_LDO_VOLT_1_2V					0x02
> +#define P3H2x4x_LDO_VOLT_1_8V					0x03
> +#define P3H2x4x_DT_LDO_VOLT_NOT_SET				0x04
> +
> +#define P3H2x4x_LDO_DISABLED					0x00
> +#define P3H2x4x_LDO_ENABLED					0x01
> +#define P3H2x4x_DT_LDO_NOT_DEFINED				0x02
> +
> +#define P3H2x4x_IBI_DISABLED					0x00
> +#define P3H2x4x_IBI_ENABLED					0x01
> +#define P3H2x4x_IBI_NOT_DEFINED					0x02
> +
> +/* Pullup selection DT settings */
> +#define P3H2x4x_TP_PULLUP_250R					0x00
> +#define P3H2x4x_TP_PULLUP_500R					0x01
> +#define P3H2x4x_TP_PULLUP_1000R					0x02
> +#define P3H2x4x_TP_PULLUP_2000R					0x03
> +#define P3H2x4x_TP_PULLUP_NOT_SET				0x04
> +
> +#define P3H2x4x_TP_PULLUP_DISABLED				0x00
> +#define P3H2x4x_TP_PULLUP_ENABLED				0x01
> +#define P3H2x4x_TP_PULLUP_NOT_DEFINED				0x02
> +
> +#define P3H2x4x_IO_STRENGTH_20_OHM				0x00
> +#define P3H2x4x_IO_STRENGTH_30_OHM				0x01
> +#define P3H2x4x_IO_STRENGTH_40_OHM				0x02
> +#define P3H2x4x_IO_STRENGTH_50_OHM				0x03
> +#define P3H2x4x_IO_STRENGTH_NOT_SET				0x04
> +
> +#define P3H2x4x_TP_MODE_I3C					0x00
> +#define P3H2x4x_TP_MODE_SMBUS					0x01
> +#define P3H2x4x_TP_MODE_GPIO					0x02
> +#define P3H2x4x_TP_MODE_I2C					0x03
> +#define P3H2x4x_TP_MODE_NOT_SET					0x04
> +
> +#define ONE_BYTE_SIZE						0x01
> +
> +/* holding SDA low when both SMBus Target Agent received data buffers are full.
> + * This feature can be used as a flow-control mechanism for MCTP applications to
> + * avoid MCTP transmitters on Target Ports time out when the SMBus agent buffers
> + * are not serviced in time by upstream controller and only receives write message
> + * from its downstream ports.
> + * SMBUS_AGENT_TX_RX_LOOPBACK_EN/TARGET_AGENT_BUF_FULL_SDA_LOW_EN
> + */
> +
> +#define P3H2x4x_TARGET_AGENT_DFT_IBI_CONF			0x20
> +#define P3H2x4x_TARGET_AGENT_DFT_IBI_CONF_MASK			0x21
> +
> +/* Transaction status checking mask */
> +#define P3H2x4x_XFER_SUCCESS					0x01
> +#define P3H2x4x_TP_BUFFER_STATUS_MASK				0x0F
> +#define P3H2x4x_TP_TRANSACTION_CODE_MASK			0xF0
> +
> +/* SMBus transaction types fields */
> +#define P3H2x4x_SMBUS_400kHz					BIT(2)
> +
> +/* SMBus polling */
> +#define P3H2x4x_POLLING_ROLL_PERIOD_MS				10
> +
> +/* Hub buffer size */
> +#define P3H2x4x_CONTROLLER_BUFFER_SIZE				88
> +#define P3H2x4x_TARGET_BUFFER_SIZE				80
> +#define P3H2x4x_SMBUS_DESCRIPTOR_SIZE				4
> +#define P3H2x4x_SMBUS_PAYLOAD_SIZE	\
> +		(P3H2x4x_CONTROLLER_BUFFER_SIZE - P3H2x4x_SMBUS_DESCRIPTOR_SIZE)
> +#define P3H2x4x_SMBUS_TARGET_PAYLOAD_SIZE	(P3H2x4x_TARGET_BUFFER_SIZE - 2)
> +
> +/* Hub SMBus transaction time */
> +#define P3H2x4x_SMBUS_400kHz_TRANSFER_TIMEOUT(x)		((20 * x) + 80)
> +
> +#define P3H2x4x_NO_PAGE_PER_TP					4
> +
> +#define P3H2x4x_MAX_PAYLOAD_LEN					2
> +#define P3H2x4x_NUM_SLOTS					10
> +
> +#define P3H2x4x_HUB_ID						0
> +
> +/* Reg config for Regmap */
> +#define P3H2x4x_REG_BITS					8
> +#define P3H2x4x_VAL_BITS					8
> +
> +enum p3h2x4x_tp {
> +	TP_0,
> +	TP_1,
> +	TP_2,
> +	TP_3,
> +	TP_4,
> +	TP_5,
> +	TP_6,
> +	TP_7,
> +};
> +
> +enum p3h2x4x_rcv_buf {
> +	RCV_BUF_0,
> +	RCV_BUF_1,
> +	RCV_BUF_OF,
> +};
> +
> +struct p3h2x4x_setting {
> +	const char *const name;
> +	const u8 value;
> +};
> +
> +/* IBI enable/disable settings */
> +static const struct p3h2x4x_setting ibi_en_settings[] = {
> +	{ "disabled",	P3H2x4x_IBI_DISABLED },
> +	{ "enabled",	P3H2x4x_IBI_ENABLED },
> +};
> +
> +/* LDO enable/disable settings */
> +static const struct p3h2x4x_setting ldo_en_settings[] = {
> +	{ "disabled",	P3H2x4x_LDO_DISABLED },
> +	{ "enabled",	P3H2x4x_LDO_ENABLED },
> +};
> +
> +/* LDO voltage settings */
> +static const struct p3h2x4x_setting ldo_volt_settings[] = {
> +	{ "1.0V",	P3H2x4x_LDO_VOLT_1_0V },
> +	{ "1.1V",	P3H2x4x_LDO_VOLT_1_1V },
> +	{ "1.2V",	P3H2x4x_LDO_VOLT_1_2V },
> +	{ "1.8V",	P3H2x4x_LDO_VOLT_1_8V },
> +};
> +
> +/* target port pull-up settings */
> +static const struct p3h2x4x_setting pullup_settings[] = {
> +	{ "250R",		P3H2x4x_TP_PULLUP_250R },
> +	{ "500R",		P3H2x4x_TP_PULLUP_500R },
> +	{ "1000R",		P3H2x4x_TP_PULLUP_1000R },
> +	{ "2000R",		P3H2x4x_TP_PULLUP_2000R },
> +};
> +
> +/* target port mode settings */
> +static const struct p3h2x4x_setting tp_mode_settings[] = {
> +	{ "i3c",		P3H2x4x_TP_MODE_I3C },
> +	{ "smbus",		P3H2x4x_TP_MODE_SMBUS },
> +	{ "gpio",		P3H2x4x_TP_MODE_GPIO },
> +	{ "i2c",		P3H2x4x_TP_MODE_I2C },
> +};
> +
> +/* pull-up enable/disable settings */
> +static const struct p3h2x4x_setting tp_pullup_settings[] = {
> +	{ "disabled",	P3H2x4x_TP_PULLUP_DISABLED },
> +	{ "enabled",	P3H2x4x_TP_PULLUP_ENABLED },
> +};
> +
> +/*  IO strenght settings */
> +static const struct p3h2x4x_setting io_strength_settings[] = {
> +	{ "20Ohms",		P3H2x4x_IO_STRENGTH_20_OHM },
> +	{ "30Ohms",		P3H2x4x_IO_STRENGTH_30_OHM },
> +	{ "40Ohms",		P3H2x4x_IO_STRENGTH_40_OHM },
> +	{ "50Ohms",		P3H2x4x_IO_STRENGTH_50_OHM },
> +};
> +
> +struct tp_setting {
> +	u8 mode;
> +	u8 pullup_en;
> +	u8 ibi_en;
> +	bool always_enable;
> +};
> +
> +/*
> + * struct svc_i3c_i2c_dev_data - Device specific data
> + * @index: Index in the master tables corresponding to this device
> + * @ibi: IBI slot index in the master structure
> + * @ibi_pool: IBI pool associated to this device
> + */
> +struct dt_settings {
> +	u8 cp0_ldo_en;
> +	u8 cp1_ldo_en;
> +	u8 tp0145_ldo_en;
> +	u8 tp2367_ldo_en;
> +	u8 cp0_ldo_volt;
> +	u8 cp1_ldo_volt;
> +	u8 tp0145_ldo_volt;
> +	u8 tp2367_ldo_volt;
> +	u8 tp0145_pullup;
> +	u8 tp2367_pullup;
> +	u8 cp0_io_strength;
> +	u8 cp1_io_strength;
> +	u8 tp0145_io_strength;
> +	u8 tp2367_io_strength;
> +	struct tp_setting tp[P3H2x4x_TP_MAX_COUNT];
> +};
> +
> +struct smbus_device {
> +	struct i2c_client *client;
> +	const char *compatible;
> +	int addr;
> +	struct list_head list;
> +	struct device_node *tp_device_dt_node;
> +};
> +
> +struct tp_bus {
> +	bool dt_available;	    /* bus configuration is available in DT. */
> +	bool is_registered;	    /* bus was registered in the framework. */
> +	u8 tp_mask;
> +	u8 tp_port;
> +	u8 local_dev_list[P3H2x4x_TP_LOCAL_DEV];
> +	u8 local_dev_count;
> +	struct i3c_master_controller i3c_port_controller;
> +	struct i2c_adapter smbus_port_adapter;
> +	struct device_node *of_node;
> +	struct p3h2x4x *priv;
> +	struct list_head tp_device_entry;
> +	struct mutex port_mutex;
> +};
> +
> +struct p3h2x4x {
> +	struct i3c_device *i3cdev;
> +	struct i2c_client *i2cdev;
> +	struct i3c_master_controller *driving_master;
> +	struct regmap *regmap;
> +	struct mutex etx_mutex;
> +	struct dt_settings settings;
> +	struct tp_bus tp_bus[P3H2x4x_TP_MAX_COUNT];
> +	/* Offset for reading HUB's register. */
> +	u8 tp_ibi_mask;
> +	u8 tp_i3c_bus_mask;
> +	u8 tp_always_enable_mask;
> +	u8 is_slave_reg;
> +	bool is_p3h2x4x_in_i3c;
> +};
> +
> +/*
> + * p3h2x4x_tp_add_downstream_device - prove downstream devices for target port who
> + * configured as SMBus.
> + * @priv: p3h2x4x device structure.
> + * Return: 0 in case of success, a negative EINVAL code if the error.
> + */
> +int p3h2x4x_tp_add_downstream_device(struct p3h2x4x *priv);
> +
> +/*
> + * p3h2x4x_tp_smbus_algo - add i2c adapter for target port who
> + * configured as SMBus.
> + * @priv: p3h2x4x device structure.
> + * @tp: target port.
> + * Return: 0 in case of success, a negative EINVAL code if the error.
> + */
> +int p3h2x4x_tp_smbus_algo(struct p3h2x4x *priv, int tp);
> +
> +int p3h2x4x_tp_i3c_algo(struct p3h2x4x *priv, int tp);
> +
> +/*
> + * p3h2x4x_ibi_handler - IBI handler.
> + * @i3cdev: i3c device.
> + * @payload: two byte IBI payload data.
> + */
> +void p3h2x4x_ibi_handler(struct i3c_device *i3cdev,
> +				const struct i3c_ibi_payload *payload);
> +#endif /* P3H2X4X_I3C_HUB_H */
> diff --git a/drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_common.c b/drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_common.c
> new file mode 100644
> index 000000000000..74b86a668f12
> --- /dev/null
> +++ b/drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_common.c
> @@ -0,0 +1,941 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2024-2025 NXP
> + * This P3H2x4x driver file implements functions for Hub probe and DT parsing.
> + */
> +
> +#include "p3h2x4x_i3c_hub.h"
> +
> +struct i3c_ibi_setup p3h2x4x_ibireq = {
> +		.handler = p3h2x4x_ibi_handler,
> +		.max_payload_len = P3H2x4x_MAX_PAYLOAD_LEN,
> +		.num_slots = P3H2x4x_NUM_SLOTS,
> +};
> +
> +struct regmap_config p3h2x4x_regmap_config = {
> +		.reg_bits = P3H2x4x_REG_BITS,
> +		.val_bits = P3H2x4x_VAL_BITS,
> +	};
> +
> +/* p3h2x4x ids (i3c) */
> +static const struct i3c_device_id p3h2x4x_i3c_ids[] = {
> +	I3C_CLASS(I3C_DCR_HUB, NULL),
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(i3c, p3h2x4x_i3c_ids);
> +
> +/* p3h2x4x ids (i2c) */
> +static const struct i2c_device_id p3h2x4x_i2c_id_table[] = {
> +	{ "nxp-i3c-hub", P3H2x4x_HUB_ID },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(i2c, p3h2x4x_i2c_id_table);
> +
> +static const struct of_device_id  p3h2x4x_i2c_of_match[] = {
> +	{
> +		.compatible = "nxp,p3h2x4x",
> +		.data =  P3H2x4x_HUB_ID,
> +	},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, p3h2x4x_i2c_of_match);
> +
> +static void p3h2x4x_of_get_dt_setting(struct device *dev,
> +				const struct device_node *node,
> +				const char *setting_name,
> +				const struct p3h2x4x_setting settings[],
> +				const u8 settings_count, u8 *setting_value)
> +{
> +	const char *sval;
> +	int ret;
> +	int i;
> +
> +	ret = of_property_read_string(node, setting_name, &sval);
> +	if (ret) {
> +		if (ret != -EINVAL)
> +			dev_warn(dev, "No setting or invalid setting for %s, err=%i\n",
> +				setting_name, ret);
> +		return;
> +	}
> +
> +	for (i = 0; i < settings_count; ++i) {
> +		const struct p3h2x4x_setting *const setting = &settings[i];
> +
> +		if (!strcmp(setting->name, sval)) {
> +			*setting_value = setting->value;
> +			return;
> +		}
> +	}
> +	dev_warn(dev, "Unknown setting for %s\n", setting_name);
> +}
> +
> +static int p3h2x4x_configure_pullup(struct device *dev)
> +{
> +	struct p3h2x4x *priv = dev_get_drvdata(dev);
> +	u8 mask = 0, value = 0;
> +
> +	if (priv->settings.tp0145_pullup != P3H2x4x_TP_PULLUP_NOT_SET) {
> +		mask |= P3H2x4x_TP0145_PULLUP_CONF_MASK;
> +		value |= P3H2x4x_TP0145_PULLUP_CONF(priv->settings.tp0145_pullup);
> +	}
> +
> +	if (priv->settings.tp2367_pullup != P3H2x4x_TP_PULLUP_NOT_SET) {
> +		mask |= P3H2x4x_TP2367_PULLUP_CONF_MASK;
> +		value |= P3H2x4x_TP2367_PULLUP_CONF(priv->settings.tp2367_pullup);
> +	}
> +
> +	return regmap_update_bits(priv->regmap, P3H2x4x_LDO_AND_PULLUP_CONF,
> +				mask, value);
> +}
> +
> +static int p3h2x4x_configure_ldo(struct device *dev)
> +{
> +	struct p3h2x4x *priv = dev_get_drvdata(dev);
> +	u8 ldo_config_mask = 0, ldo_config_val = 0;
> +	u8 ldo_disable_mask = 0, ldo_en_val = 0;
> +	u32 reg_val;
> +	int ret;
> +	u8 val;
> +
> +	/* Enable or Disable LDO's. If there is no DT entry - disable LDO for safety reasons */
> +	if (priv->settings.cp0_ldo_en == P3H2x4x_LDO_ENABLED)
> +		ldo_en_val |= P3H2x4x_CP0_EN_LDO;
> +	if (priv->settings.cp1_ldo_en == P3H2x4x_LDO_ENABLED)
> +		ldo_en_val |= P3H2x4x_CP1_EN_LDO;
> +	if (priv->settings.tp0145_ldo_en == P3H2x4x_LDO_ENABLED)
> +		ldo_en_val |= P3H2x4x_TP0145_EN_LDO;
> +	if (priv->settings.tp2367_ldo_en == P3H2x4x_LDO_ENABLED)
> +		ldo_en_val |= P3H2x4x_TP2367_EN_LDO;
> +
> +	/* Get current LDOs configuration */
> +	ret = regmap_read(priv->regmap, P3H2x4x_VCCIO_LDO_CONF, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	/* LDOs Voltage level (Skip if not defined in the DT)
> +	 * Set the mask only if there is a change from current value
> +	 */
> +	if (priv->settings.cp0_ldo_volt != P3H2x4x_DT_LDO_VOLT_NOT_SET) {
> +		val = P3H2x4x_CP0_VCCIO_LDO_VOLTAGE(priv->settings.cp0_ldo_volt);
> +		if ((reg_val & P3H2x4x_CP0_VCCIO_LDO_VOLTAGE_MASK) != val) {
> +			ldo_config_mask |= P3H2x4x_CP0_VCCIO_LDO_VOLTAGE_MASK;
> +			ldo_config_val |= val;
> +
> +			ldo_disable_mask |= P3H2x4x_CP0_EN_LDO;
> +		}
> +	}
> +	if (priv->settings.cp1_ldo_volt != P3H2x4x_DT_LDO_VOLT_NOT_SET) {
> +		val = P3H2x4x_CP1_VCCIO_LDO_VOLTAGE(priv->settings.cp1_ldo_volt);
> +		if ((reg_val & P3H2x4x_CP1_VCCIO_LDO_VOLTAGE_MASK) != val) {
> +			ldo_config_mask |= P3H2x4x_CP1_VCCIO_LDO_VOLTAGE_MASK;
> +			ldo_config_val |= val;
> +
> +			ldo_disable_mask |= P3H2x4x_CP1_EN_LDO;
> +		}
> +	}
> +	if (priv->settings.tp0145_ldo_volt != P3H2x4x_DT_LDO_VOLT_NOT_SET) {
> +		val = P3H2x4x_TP0145_VCCIO_LDO_VOLTAGE(priv->settings.tp0145_ldo_volt);
> +		if ((reg_val & P3H2x4x_TP0145_VCCIO_LDO_VOLTAGE_MASK) != val) {
> +			ldo_config_mask |= P3H2x4x_TP0145_VCCIO_LDO_VOLTAGE_MASK;
> +			ldo_config_val |= val;
> +
> +			ldo_disable_mask |= P3H2x4x_TP0145_EN_LDO;
> +		}
> +	}
> +	if (priv->settings.tp2367_ldo_volt != P3H2x4x_DT_LDO_VOLT_NOT_SET) {
> +		val = P3H2x4x_TP2367_VCCIO_LDO_VOLTAGE(priv->settings.tp2367_ldo_volt);
> +		if ((reg_val & P3H2x4x_TP2367_VCCIO_LDO_VOLTAGE_MASK) != val) {
> +			ldo_config_mask |= P3H2x4x_TP2367_VCCIO_LDO_VOLTAGE_MASK;
> +			ldo_config_val |= val;
> +
> +			ldo_disable_mask |= P3H2x4x_TP2367_EN_LDO;
> +		}
> +	}
> +
> +	/*
> +	 *Update LDO voltage configuration only if value is changed from already existing register
> +	 * value. It is a good practice to disable the LDO's before making any voltage changes.
> +	 * Presence of config mask indicates voltage change to be applied.
> +	 */
> +	if (ldo_config_mask) {
> +		/* Disable LDO's before making voltage changes */
> +		ret = regmap_update_bits(priv->regmap,
> +					P3H2x4x_LDO_AND_PULLUP_CONF,
> +					ldo_disable_mask, 0);
> +		if (ret)
> +			return ret;
> +
> +		/* Update the LDOs configuration */
> +		ret = regmap_update_bits(priv->regmap, P3H2x4x_VCCIO_LDO_CONF,
> +					ldo_config_mask, ldo_config_val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Update the LDOs Enable/disable register. This will enable only LDOs enabled in DT */
> +	return regmap_update_bits(priv->regmap, P3H2x4x_LDO_AND_PULLUP_CONF,
> +				P3H2x4x_LDO_ENABLE_DISABLE_MASK, ldo_en_val);
> +}
> +
> +static int p3h2x4x_configure_io_strength(struct device *dev)
> +{
> +	struct p3h2x4x *priv = dev_get_drvdata(dev);
> +	u8 mask_all = 0, val_all = 0;
> +	u32 reg_val;
> +	u8 val;
> +	struct dt_settings tmp;
> +	int ret;
> +
> +	/* Get IO strength configuration to figure out what needs to be changed */
> +	ret = regmap_read(priv->regmap, P3H2x4x_IO_STRENGTH, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	tmp = priv->settings;
> +	if (tmp.cp0_io_strength != P3H2x4x_IO_STRENGTH_NOT_SET) {
> +		val = P3H2x4x_CP0_IO_STRENGTH(tmp.cp0_io_strength);
> +		mask_all |= P3H2x4x_CP0_IO_STRENGTH_MASK;
> +		val_all |= val;
> +	}
> +	if (tmp.cp1_io_strength != P3H2x4x_IO_STRENGTH_NOT_SET) {
> +		val = P3H2x4x_CP1_IO_STRENGTH(tmp.cp1_io_strength);
> +		mask_all |= P3H2x4x_CP1_IO_STRENGTH_MASK;
> +		val_all |= val;
> +	}
> +	if (tmp.tp0145_io_strength != P3H2x4x_IO_STRENGTH_NOT_SET) {
> +		val = P3H2x4x_TP0145_IO_STRENGTH(tmp.tp0145_io_strength);
> +		mask_all |= P3H2x4x_TP0145_IO_STRENGTH_MASK;
> +		val_all |= val;
> +	}
> +	if (tmp.tp2367_io_strength != P3H2x4x_IO_STRENGTH_NOT_SET) {
> +		val = P3H2x4x_TP2367_IO_STRENGTH(tmp.tp2367_io_strength);
> +		mask_all |= P3H2x4x_TP2367_IO_STRENGTH_MASK;
> +		val_all |= val;
> +	}
> +
> +	/* Set IO strength if required */
> +	return regmap_update_bits(priv->regmap, P3H2x4x_IO_STRENGTH, mask_all, val_all);
> +}
> +
> +static int p3h2x4x_configure_tp(struct device *dev)
> +{
> +	struct p3h2x4x *priv = dev_get_drvdata(dev);
> +	u8 pullup_mask = 0, pullup_val = 0;
> +	u8 smbus_mask = 0, smbus_val = 0;
> +	u8 gpio_mask = 0, gpio_val = 0;
> +	u8 i3c_mask = 0, i3c_val = 0;
> +	u8 ibi_mask = 0, ibi_val = 0;
> +	u8 i2c_mask = 0, i2c_val = 0;
> +	int ret;
> +	int i;
> +
> +	/* TBD: Read type of HUB from register P3H2x4x_DEV_INFO_0 to learn target ports count. */
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; ++i) {
> +		if (priv->settings.tp[i].mode != P3H2x4x_TP_MODE_NOT_SET) {
> +			i3c_mask |= P3H2x4x_TPn_NET_CON(i);
> +			smbus_mask |= P3H2x4x_TPn_SMBUS_MODE_EN(i);
> +			gpio_mask |= P3H2x4x_TPn_GPIO_MODE_EN(i);
> +			i2c_mask |= P3H2x4x_TPn_I2C_MODE_EN(i);
> +
> +			if (priv->settings.tp[i].mode == P3H2x4x_TP_MODE_I3C)
> +				i3c_val |= P3H2x4x_TPn_NET_CON(i);
> +			else if (priv->settings.tp[i].mode == P3H2x4x_TP_MODE_SMBUS)
> +				smbus_val |= P3H2x4x_TPn_SMBUS_MODE_EN(i);
> +			else if (priv->settings.tp[i].mode == P3H2x4x_TP_MODE_GPIO)
> +				gpio_val |= P3H2x4x_TPn_GPIO_MODE_EN(i);
> +			else if (priv->settings.tp[i].mode == P3H2x4x_TP_MODE_I2C)
> +				i2c_val |= P3H2x4x_TPn_I2C_MODE_EN(i);
> +		}
> +		if (priv->settings.tp[i].pullup_en != P3H2x4x_TP_PULLUP_NOT_DEFINED) {
> +			pullup_mask |= P3H2x4x_TPn_PULLUP_EN(i);
> +
> +			if (priv->settings.tp[i].pullup_en == P3H2x4x_TP_PULLUP_ENABLED)
> +				pullup_val |= P3H2x4x_TPn_PULLUP_EN(i);
> +		}
> +
> +		if (priv->settings.tp[i].ibi_en != P3H2x4x_IBI_NOT_DEFINED) {
> +			ibi_mask |= P3H2x4x_TPn_IBI_EN(i);
> +
> +			if (priv->settings.tp[i].ibi_en == P3H2x4x_IBI_ENABLED)
> +				ibi_val |= P3H2x4x_TPn_IBI_EN(i);
> +		}
> +	}
> +
> +	ret = regmap_update_bits(priv->regmap, P3H2x4x_TP_IO_MODE_CONF, (smbus_mask | i2c_mask),
> +							(smbus_val | i2c_val));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, P3H2x4x_TP_PULLUP_EN, pullup_mask, pullup_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, P3H2x4x_TP_SMBUS_AGNT_IBI_CONFIG, ibi_mask, ibi_val);
> +	if (ret)
> +		return ret;
> +	priv->tp_ibi_mask = ibi_val;
> +
> +	ret = regmap_update_bits(priv->regmap, P3H2x4x_TP_SMBUS_AGNT_EN, smbus_mask, smbus_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(priv->regmap, P3H2x4x_TP_GPIO_MODE_EN, gpio_mask, gpio_val);
> +	if (ret)
> +		return ret;
> +
> +	/* Request for HUB Network connection in case any TP is configured in I3C mode */
> +	if ((i3c_val) || (i2c_val)) {
> +		ret = regmap_write(priv->regmap, P3H2x4x_CP_MUX_SET,
> +							P3H2x4x_CONTROLLER_PORT_MUX_REQ);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Enable TP here in case TP was configured */
> +	ret = regmap_update_bits(priv->regmap, P3H2x4x_TP_ENABLE,
> +				i3c_mask | smbus_mask | gpio_mask | i2c_mask,
> +				i3c_val | smbus_val | gpio_val | i2c_val);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int p3h2x4x_configure_smbus_local_dev(struct device *dev)
> +{
> +	struct p3h2x4x *priv = dev_get_drvdata(dev);
> +	u8 target_buffer_page, hub_tp;
> +	int ret = 0;
> +
> +	for (hub_tp = 0; hub_tp < P3H2x4x_TP_MAX_COUNT; hub_tp++) {
> +		if ((priv->tp_bus[hub_tp].local_dev_count) &&
> +				(priv->settings.tp[hub_tp].mode == P3H2x4x_TP_MODE_SMBUS)) {
> +			target_buffer_page = P3H2x4x_TARGET_AGENT_LOCAL_DEV + 4 * hub_tp;
> +			ret = regmap_write(priv->regmap, P3H2x4x_PAGE_PTR, target_buffer_page);
> +			if (ret) {
> +				dev_err(dev, "Failed to configure local device settings\n");
> +				break;
> +			}
> +
> +			ret = regmap_bulk_write(priv->regmap,
> +							P3H2x4x_CONTROLLER_AGENT_BUFF,
> +							priv->tp_bus[hub_tp].local_dev_list,
> +							priv->tp_bus[hub_tp].local_dev_count);
> +			if (ret) {
> +				dev_err(dev, "Failed to add local devices\n");
> +				break;
> +			}
> +		}
> +	}
> +	regmap_write(priv->regmap, P3H2x4x_PAGE_PTR, 0x00);
> +	return ret;
> +}
> +
> +static int p3h2x4x_configure_hw(struct device *dev)
> +{
> +	int ret;
> +
> +	ret = p3h2x4x_configure_ldo(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = p3h2x4x_configure_io_strength(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = p3h2x4x_configure_pullup(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = p3h2x4x_configure_smbus_local_dev(dev);
> +	if (ret)
> +		return ret;
> +
> +	return p3h2x4x_configure_tp(dev);
> +}
> +
> +static void p3h2x4x_of_get_tp_dt_conf(struct device *dev,
> +					const struct device_node *node)
> +{
> +	struct p3h2x4x *priv = dev_get_drvdata(dev);
> +	struct device_node *dev_node;
> +	int tp_port;
> +
> +	for_each_available_child_of_node(node, dev_node) {
> +		if (!dev_node->full_name ||
> +			(sscanf(dev_node->full_name, "target-port@%d", &tp_port) != 1))
> +			continue;
> +
> +		if (tp_port < P3H2x4x_TP_MAX_COUNT) {
> +			priv->tp_bus[tp_port].dt_available = true;
> +			priv->tp_bus[tp_port].of_node = dev_node;
> +			priv->tp_bus[tp_port].tp_mask = BIT(tp_port);
> +			priv->tp_bus[tp_port].priv = priv;
> +			priv->tp_bus[tp_port].tp_port = tp_port;
> +		}
> +	}
> +}
> +
> +/* return true when backend node exist */
> +static bool p3h2x4x_is_backend_node_exist(int port, struct p3h2x4x *priv, u32 addr)
> +{
> +	struct smbus_device *backend = NULL;
> +
> +	list_for_each_entry(backend,
> +			&priv->tp_bus[port].tp_device_entry, list) {
> +		if (backend->addr == addr)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static int p3h2x4x_read_backend_from_p3h2x4x_dts(struct device_node *i3c_node_target,
> +					struct p3h2x4x *priv)
> +{
> +	struct device_node *i3c_node_tp;
> +	const char *compatible;
> +	int tp_port, ret;
> +	u32 addr_dts;
> +	struct smbus_device *backend;
> +
> +	if (sscanf(i3c_node_target->full_name, "target-port@%d", &tp_port) == 0)
> +		return -EINVAL;
> +
> +	if (tp_port > P3H2x4x_TP_MAX_COUNT)
> +		return -ERANGE;
> +
> +	if (tp_port < 0)
> +		return -EINVAL;
> +
> +	INIT_LIST_HEAD(&priv->tp_bus[tp_port].tp_device_entry);
> +
> +	if (priv->settings.tp[tp_port].mode == P3H2x4x_TP_MODE_I3C)
> +		return 0;
> +
> +	for_each_available_child_of_node(i3c_node_target, i3c_node_tp) {
> +
> +		ret = of_property_read_u32(i3c_node_tp, "reg", &addr_dts);
> +		if (ret)
> +			return ret;
> +
> +		if (p3h2x4x_is_backend_node_exist(tp_port, priv, addr_dts))
> +			continue;
> +
> +		ret = of_property_read_string(i3c_node_tp, "compatible", &compatible);
> +		if (ret)
> +			return ret;
> +
> +		backend = kzalloc(sizeof(*backend), GFP_KERNEL);
> +		if (!backend)
> +			return -ENOMEM;
> +
> +		backend->addr = addr_dts;
> +		backend->compatible = compatible;
> +		backend->tp_device_dt_node = i3c_node_tp;
> +		backend->client = NULL;
> +
> +		list_add(&backend->list,
> +			&priv->tp_bus[tp_port].tp_device_entry);
> +	}
> +
> +	return 0;
> +}
> +
> +static void p3h2x4x_parse_dt_tp(struct device *dev,
> +				const struct device_node *i3c_node_hub,
> +				struct p3h2x4x *priv)
> +{
> +	struct device_node *i3c_node_target;
> +	int ret;
> +
> +	for_each_available_child_of_node(i3c_node_hub, i3c_node_target) {
> +		if (!strcmp(i3c_node_target->name, "target-port")) {
> +			ret = p3h2x4x_read_backend_from_p3h2x4x_dts(i3c_node_target, priv);
> +			if (ret)
> +				dev_err(dev, "DTS entry invalid - error %d", ret);
> +		}
> +	}
> +}
> +
> +static int p3h2x4x_get_tp_local_device_dt_setting(struct device *dev,
> +					const struct device_node *node, u32 id)
> +{
> +	u8 i;
> +	u32 local_dev_count, local_dev;
> +	struct p3h2x4x *priv = dev_get_drvdata(dev);
> +
> +	if (!of_get_property(node, "local_dev", &local_dev_count))
> +		return -EINVAL;
> +
> +	local_dev_count = local_dev_count / (sizeof(u32));
> +
> +	if (local_dev_count > P3H2x4x_TP_LOCAL_DEV)
> +		return -ERANGE;
> +
> +	for (i = 0; i < local_dev_count; i++) {
> +		if (of_property_read_u32_index(node, "local_dev", i, &local_dev)) {
> +			priv->tp_bus[id].local_dev_count = 0;
> +			return -EINVAL;
> +		}
> +		priv->tp_bus[id].local_dev_list[i] = (u8)(local_dev*2);
> +	}
> +	priv->tp_bus[id].local_dev_count = local_dev_count;
> +	return 0;
> +}
> +
> +static void p3h2x4x_get_tp_of_get_setting(struct device *dev,
> +					const struct device_node *node,
> +					struct tp_setting tp_setting[])
> +{
> +	struct device_node *tp_node;
> +	u32 id;
> +
> +	for_each_available_child_of_node(node, tp_node) {
> +		if (!tp_node->name || of_node_cmp(tp_node->name, "target-port"))
> +			continue;
> +
> +		if (!tp_node->full_name ||
> +			(sscanf(tp_node->full_name, "target-port@%u", &id) != 1)) {
> +			dev_warn(dev, "Invalid target port node found in DT: %s\n",
> +				tp_node->full_name);
> +			continue;
> +		}
> +
> +		if (id >= P3H2x4x_TP_MAX_COUNT) {
> +			dev_warn(dev, "Invalid target port index found in DT: %i\n", id);
> +			continue;
> +		}
> +		p3h2x4x_of_get_dt_setting(dev, tp_node, "mode", tp_mode_settings,
> +					ARRAY_SIZE(tp_mode_settings),
> +					&tp_setting[id].mode);
> +		p3h2x4x_of_get_dt_setting(dev, tp_node, "pullup_en", tp_pullup_settings,
> +					ARRAY_SIZE(tp_pullup_settings),
> +					&tp_setting[id].pullup_en);
> +		p3h2x4x_of_get_dt_setting(dev, tp_node, "ibi_en", ibi_en_settings,
> +					ARRAY_SIZE(ibi_en_settings),
> +					&tp_setting[id].ibi_en);
> +		tp_setting[id].always_enable =
> +					of_property_read_bool(tp_node, "always-enable");
> +
> +		p3h2x4x_get_tp_local_device_dt_setting(dev, tp_node, id);
> +	}
> +}
> +
> +static void p3h2x4x_of_get_p3h2x4x_conf(struct device *dev,
> +					const struct device_node *node)
> +{
> +	struct p3h2x4x *priv = dev_get_drvdata(dev);
> +
> +	p3h2x4x_of_get_dt_setting(dev, node, "cp0-ldo-en", ldo_en_settings,
> +				ARRAY_SIZE(ldo_en_settings),
> +				&priv->settings.cp0_ldo_en);
> +	p3h2x4x_of_get_dt_setting(dev, node, "cp1-ldo-en", ldo_en_settings,
> +				ARRAY_SIZE(ldo_en_settings),
> +				&priv->settings.cp1_ldo_en);
> +	p3h2x4x_of_get_dt_setting(dev, node, "tp0145-ldo-en", ldo_en_settings,
> +				ARRAY_SIZE(ldo_en_settings),
> +				&priv->settings.tp0145_ldo_en);
> +	p3h2x4x_of_get_dt_setting(dev, node, "tp2367-ldo-en", ldo_en_settings,
> +				ARRAY_SIZE(ldo_en_settings),
> +				&priv->settings.tp2367_ldo_en);
> +	p3h2x4x_of_get_dt_setting(dev, node, "cp0-ldo-volt", ldo_volt_settings,
> +				ARRAY_SIZE(ldo_volt_settings),
> +				&priv->settings.cp0_ldo_volt);
> +	p3h2x4x_of_get_dt_setting(dev, node, "cp1-ldo-volt", ldo_volt_settings,
> +				ARRAY_SIZE(ldo_volt_settings),
> +				&priv->settings.cp1_ldo_volt);
> +	p3h2x4x_of_get_dt_setting(dev, node, "tp0145-ldo-volt", ldo_volt_settings,
> +				ARRAY_SIZE(ldo_volt_settings),
> +				&priv->settings.tp0145_ldo_volt);
> +	p3h2x4x_of_get_dt_setting(dev, node, "tp2367-ldo-volt", ldo_volt_settings,
> +				ARRAY_SIZE(ldo_volt_settings),
> +				&priv->settings.tp2367_ldo_volt);
> +	p3h2x4x_of_get_dt_setting(dev, node, "tp0145-pullup", pullup_settings,
> +				ARRAY_SIZE(pullup_settings),
> +				&priv->settings.tp0145_pullup);
> +	p3h2x4x_of_get_dt_setting(dev, node, "tp2367-pullup", pullup_settings,
> +				ARRAY_SIZE(pullup_settings),
> +				&priv->settings.tp2367_pullup);
> +	p3h2x4x_of_get_dt_setting(dev, node, "cp0-io-strength", io_strength_settings,
> +				ARRAY_SIZE(io_strength_settings),
> +				&priv->settings.cp0_io_strength);
> +	p3h2x4x_of_get_dt_setting(dev, node, "cp1-io-strength", io_strength_settings,
> +				ARRAY_SIZE(io_strength_settings),
> +				&priv->settings.cp1_io_strength);
> +	p3h2x4x_of_get_dt_setting(dev, node, "tp0145-io-strength", io_strength_settings,
> +				ARRAY_SIZE(io_strength_settings),
> +				&priv->settings.tp0145_io_strength);
> +	p3h2x4x_of_get_dt_setting(dev, node, "tp2367-io-strength", io_strength_settings,
> +				ARRAY_SIZE(io_strength_settings),
> +				&priv->settings.tp2367_io_strength);
> +
> +p3h2x4x_get_tp_of_get_setting(dev, node, priv->settings.tp);
> +}
> +
> +static struct device_node *p3h2x4x_get_dt_p3h2x4x_node(struct device_node *node,
> +		struct device *dev)
> +{
> +	struct device_node *hub_node_no_id = NULL;
> +	struct device_node *hub_node;
> +
> +	for_each_available_child_of_node(node, hub_node) {
> +		if (strstr(hub_node->name, "hub"))
> +			return hub_node;
> +	}
> +	return hub_node_no_id;
> +}
> +
> +static void p3h2x4x_of_default_configuration(struct device *dev)
> +{
> +	struct p3h2x4x *priv = dev_get_drvdata(dev);
> +	int tp_count;
> +
> +	priv->settings.cp0_ldo_en = P3H2x4x_DT_LDO_NOT_DEFINED;
> +	priv->settings.cp1_ldo_en = P3H2x4x_DT_LDO_NOT_DEFINED;
> +	priv->settings.tp0145_ldo_en = P3H2x4x_DT_LDO_NOT_DEFINED;
> +	priv->settings.tp2367_ldo_en = P3H2x4x_DT_LDO_NOT_DEFINED;
> +	priv->settings.cp0_ldo_volt = P3H2x4x_DT_LDO_VOLT_NOT_SET;
> +	priv->settings.cp1_ldo_volt = P3H2x4x_DT_LDO_VOLT_NOT_SET;
> +	priv->settings.tp0145_ldo_volt = P3H2x4x_DT_LDO_VOLT_NOT_SET;
> +	priv->settings.tp2367_ldo_volt = P3H2x4x_DT_LDO_VOLT_NOT_SET;
> +	priv->settings.tp0145_pullup = P3H2x4x_TP_PULLUP_NOT_SET;
> +	priv->settings.tp2367_pullup = P3H2x4x_TP_PULLUP_NOT_SET;
> +	priv->settings.cp0_io_strength = P3H2x4x_IO_STRENGTH_NOT_SET;
> +	priv->settings.cp1_io_strength = P3H2x4x_IO_STRENGTH_NOT_SET;
> +	priv->settings.tp0145_io_strength = P3H2x4x_IO_STRENGTH_NOT_SET;
> +	priv->settings.tp2367_io_strength = P3H2x4x_IO_STRENGTH_NOT_SET;
> +
> +	for (tp_count = 0; tp_count < P3H2x4x_TP_MAX_COUNT; ++tp_count) {
> +		priv->settings.tp[tp_count].mode =  P3H2x4x_TP_MODE_NOT_SET;
> +		priv->settings.tp[tp_count].pullup_en = P3H2x4x_TP_PULLUP_NOT_DEFINED;
> +		priv->settings.tp[tp_count].ibi_en = P3H2x4x_IBI_DISABLED;
> +	}
> +}
> +
> +static int p3h2x4x_device_probe_i3c(struct i3c_device *i3cdev)
> +{
> +	struct device_node *node = NULL;
> +	struct regmap *regmap;
> +	struct device *dev = &i3cdev->dev;
> +	struct p3h2x4x *priv;
> +	char hub_id[64];
> +	int ret, i;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->i3cdev = i3cdev;
> +	priv->driving_master = i3c_dev_get_master(i3cdev->desc);
> +	i3cdev_set_drvdata(i3cdev, priv);
> +	sprintf(hub_id, "i3c-hub-device-%d-%llx", i3c_dev_get_master(i3cdev->desc)->bus.id,
> +		i3cdev->desc->info.pid);
> +	p3h2x4x_of_default_configuration(dev);
> +	regmap = devm_regmap_init_i3c(i3cdev, &p3h2x4x_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(dev, "Failed to register I3C HUB regmap\n");
> +		goto error;
> +	}
> +	priv->regmap = regmap;
> +	priv->is_p3h2x4x_in_i3c = true;
> +
> +	mutex_init(&priv->etx_mutex);
> +
> +	/* Register logic for native SMBus ports */
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; i++)
> +		mutex_init(&priv->tp_bus[i].port_mutex);
> +
> +	node = p3h2x4x_get_dt_p3h2x4x_node(dev->parent->of_node, dev); /* Find hub node in DT */
> +	if (!node) {
> +		dev_warn(dev, "No DT entry - running with hardware defaults.\n");
> +	} else {
> +		of_node_get(node);
> +		p3h2x4x_of_get_p3h2x4x_conf(dev, node);
> +		p3h2x4x_of_get_tp_dt_conf(dev, node);
> +		of_node_put(node);
> +		/* Parse DTS to find data on the SMBus target mode */
> +		p3h2x4x_parse_dt_tp(dev, node, priv);
> +	}
> +
> +	/* Unlock access to protected registers */
> +	ret = regmap_write(priv->regmap, P3H2x4x_DEV_REG_PROTECTION_CODE,
> +						P3H2x4x_REGISTERS_UNLOCK_CODE);
> +	if (ret) {
> +		dev_err(dev, "Failed to unlock HUB's protected registers\n");
> +		goto error;
> +	}
> +
> +	ret = p3h2x4x_configure_hw(dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to configure the HUB\n");
> +		goto error;
> +	}
> +
> +	/* Register logic for native SMBus ports */
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; i++) {
> +		if (priv->settings.tp[i].mode == P3H2x4x_TP_MODE_SMBUS)
> +			ret = p3h2x4x_tp_smbus_algo(priv, i);
> +	}
> +
> +	ret = p3h2x4x_tp_add_downstream_device(priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to add backend device\n");
> +		goto error;
> +	}
> +
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; ++i) {
> +		if (priv->tp_bus[i].dt_available) {
> +			if (priv->settings.tp[i].always_enable)
> +				priv->tp_always_enable_mask =
> +						(priv->tp_always_enable_mask |  BIT(i));
> +
> +			if (priv->settings.tp[i].mode == P3H2x4x_TP_MODE_I3C)
> +				priv->tp_i3c_bus_mask = (priv->tp_i3c_bus_mask |  BIT(i));
> +		}
> +	}
> +
> +	/* Register logic for native vertual I3C ports */
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; i++) {
> +		if ((priv->settings.tp[i].mode == P3H2x4x_TP_MODE_I3C) &&
> +			(!priv->settings.tp[i].always_enable))
> +			ret = p3h2x4x_tp_i3c_algo(priv, i);
> +	}
> +
> +	ret = regmap_write(priv->regmap, P3H2x4x_TP_NET_CON_CONF, priv->tp_always_enable_mask);
> +	if (ret) {
> +		dev_err(dev, "Failed to open Target Port(s)\n");
> +		goto error;
> +	}
> +
> +	ret = i3c_master_do_daa(priv->driving_master);
> +	if (ret)
> +		dev_warn(dev, "Failed to run DAA\n");
> +
> +
> +	/* holding SDA low when both SMBus Target Agent received data buffers are full.
> +	 * This feature can be used as a flow-control mechanism for MCTP applications to
> +	 * avoid MCTP transmitters on Target Ports time out when the SMBus agent buffers
> +	 * are not serviced in time by upstream controller and only receives write message
> +	 * from its downstream ports.
> +	 */
> +	ret = regmap_update_bits(priv->regmap, P3H2x4x_ONCHIP_TD_AND_SMBUS_AGNT_CONF,
> +						P3H2x4x_TARGET_AGENT_DFT_IBI_CONF_MASK,
> +						P3H2x4x_TARGET_AGENT_DFT_IBI_CONF);
> +	if (ret) {
> +		dev_err(dev, "Failed to P3H2x4x_ONCHIP_TD_AND_SMBUS_AGNT_CONF\n");
> +		goto error;
> +	}
> +
> +	ret = i3c_device_request_ibi(i3cdev, &p3h2x4x_ibireq);
> +	if (ret) {
> +		dev_err(dev, "Failed to request IBI\n");
> +		goto error;
> +	}
> +
> +	ret = i3c_device_enable_ibi(i3cdev);
> +	if (ret) {
> +		dev_err(dev, "Failed to Enable IBI\n");
> +		goto error;
> +	}
> +
> +	/* Lock access to protected registers */
> +	ret = regmap_write(priv->regmap, P3H2x4x_DEV_REG_PROTECTION_CODE,
> +						P3H2x4x_REGISTERS_LOCK_CODE);
> +	if (ret) {
> +		dev_err(dev, "Failed to lock HUB's protected registers\n");
> +		goto error;
> +	}
> +
> +	return 0;
> +
> +error:
> +	devm_kfree(dev, priv);
> +	return ret;
> +}
> +
> +static void p3h2x4x_device_remove_i3c(struct i3c_device *i3cdev)
> +{
> +	struct p3h2x4x *priv = i3cdev_get_drvdata(i3cdev);
> +	struct i2c_adapter *tp_adap;
> +	struct i3c_master_controller *tp_controller;
> +	struct smbus_device *backend = NULL;
> +	int i;
> +
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; i++) {
> +		tp_adap = &priv->tp_bus[i].smbus_port_adapter;
> +		tp_controller = &priv->tp_bus[i].i3c_port_controller;
> +
> +		if (priv->tp_bus[i].is_registered) {
> +			if (priv->settings.tp[i].mode == P3H2x4x_TP_MODE_SMBUS) {
> +				list_for_each_entry(backend,
> +						&priv->tp_bus[i].tp_device_entry,
> +						list) {
> +					i2c_unregister_device(backend->client);
> +					kfree(backend);
> +				}
> +				i2c_del_adapter(tp_adap);
> +			} else if (priv->settings.tp[i].mode == P3H2x4x_TP_MODE_I3C) {
> +				i3c_master_unregister(tp_controller);
> +			}
> +		}
> +	}
> +
> +	i3c_device_disable_ibi(i3cdev);
> +	i3c_device_free_ibi(i3cdev);
> +
> +	mutex_destroy(&priv->etx_mutex);
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; i++)
> +		mutex_destroy(&priv->tp_bus[i].port_mutex);
> +
> +	devm_kfree(&i3cdev->dev, priv);
> +}
> +
> +static int p3h2x4x_device_probe_i2c(struct i2c_client *client)
> +{
> +	struct device_node *node = NULL;
> +	struct regmap *regmap;
> +	struct device *dev = &client->dev;
> +	struct p3h2x4x *priv;
> +	int ret, i;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->i2cdev = client;
> +	i2c_set_clientdata(client, priv);
> +
> +	p3h2x4x_of_default_configuration(dev);
> +
> +	regmap = devm_regmap_init_i2c(client, &p3h2x4x_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(dev, "Failed to register I3C HUB regmap\n");
> +		goto error;
> +	}
> +	priv->regmap = regmap;
> +	priv->is_p3h2x4x_in_i3c = false;
> +
> +	mutex_init(&priv->etx_mutex);
> +
> +	/* Register logic for native SMBus ports */
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; i++)
> +		mutex_init(&priv->tp_bus[i].port_mutex);
> +
> +	node = p3h2x4x_get_dt_p3h2x4x_node(dev->parent->of_node, dev); /* Find hub node in DT */
> +	if (!node) {
> +		dev_warn(dev, "No DT entry - running with hardware defaults.\n");
> +	} else {
> +		of_node_get(node);
> +		p3h2x4x_of_get_p3h2x4x_conf(dev, node);
> +		p3h2x4x_of_get_tp_dt_conf(dev, node);
> +		of_node_put(node);
> +		/* Parse DTS to find data on the SMBus target mode */
> +		p3h2x4x_parse_dt_tp(dev, node, priv);
> +	}
> +
> +	/* Unlock access to protected registers */
> +	ret = regmap_write(priv->regmap, P3H2x4x_DEV_REG_PROTECTION_CODE,
> +						P3H2x4x_REGISTERS_UNLOCK_CODE);
> +	if (ret) {
> +		dev_err(dev, "Failed to unlock HUB's protected registers\n");
> +		goto error;
> +	}
> +
> +	ret = p3h2x4x_configure_hw(dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to configure the HUB\n");
> +		goto error;
> +	}
> +
> +	/* Register logic for native SMBus ports */
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; i++) {
> +		if (priv->settings.tp[i].mode == P3H2x4x_TP_MODE_SMBUS)
> +			ret = p3h2x4x_tp_smbus_algo(priv, i);
> +	}
> +
> +	ret = p3h2x4x_tp_add_downstream_device(priv);
> +	if (ret) {
> +		dev_err(dev, "Failed to add backend device\n");
> +		goto error;
> +	}
> +
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; ++i) {
> +		if (priv->tp_bus[i].dt_available) {
> +			if (priv->settings.tp[i].always_enable)
> +				priv->tp_always_enable_mask =
> +							(priv->tp_always_enable_mask |  BIT(i));
> +		}
> +	}
> +
> +	ret = regmap_write(priv->regmap, P3H2x4x_TP_NET_CON_CONF, priv->tp_always_enable_mask);
> +	if (ret) {
> +		dev_err(dev, "Failed to open Target Port(s)\n");
> +		goto error;
> +	}
> +
> +	/* Lock access to protected registers */
> +	ret = regmap_write(priv->regmap, P3H2x4x_DEV_REG_PROTECTION_CODE,
> +						P3H2x4x_REGISTERS_LOCK_CODE);
> +	if (ret) {
> +		dev_err(dev, "Failed to lock HUB's protected registers\n");
> +		goto error;
> +	}
> +	return 0;
> +
> +error:
> +	devm_kfree(dev, priv);
> +	return ret;
> +}
> +
> +static void p3h2x4x_device_remove_i2c(struct i2c_client *client)
> +{
> +	struct p3h2x4x *priv = i2c_get_clientdata(client);
> +	struct i2c_adapter *tp_adap;
> +	struct smbus_device *backend = NULL;
> +	int i;
> +
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; i++) {
> +		tp_adap = &priv->tp_bus[i].smbus_port_adapter;
> +		if (priv->tp_bus[i].is_registered) {
> +			list_for_each_entry(backend, &priv->tp_bus[i].tp_device_entry, list) {
> +				i2c_unregister_device(backend->client);
> +				kfree(backend);
> +			}
> +			i2c_del_adapter(tp_adap);
> +		}
> +	}
> +
> +	mutex_destroy(&priv->etx_mutex);
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; i++)
> +		mutex_destroy(&priv->tp_bus[i].port_mutex);
> +
> +	devm_kfree(&client->dev, priv);
> +}
> +
> +static struct i3c_driver p3h2x4x_i3c = {
> +	.driver = {
> +		.name = "p3h2x4x_i3c_drv",
> +	},
> +	.id_table = p3h2x4x_i3c_ids,
> +	.probe = p3h2x4x_device_probe_i3c,
> +	.remove = p3h2x4x_device_remove_i3c,
> +};
> +
> +static struct i2c_driver p3h2x4x_i2c = {
> +	.driver = {
> +		.name = "p3h2x4x_i2c_drv",
> +		.of_match_table = p3h2x4x_i2c_of_match,
> +	},
> +	.probe =  p3h2x4x_device_probe_i2c,
> +	.remove = p3h2x4x_device_remove_i2c,
> +	.id_table = p3h2x4x_i2c_id_table,
> +};
> +
> +module_i3c_i2c_driver(p3h2x4x_i3c, &p3h2x4x_i2c);
> +
> +MODULE_AUTHOR("Aman Kumar Pandey <aman.kumarpandey@nxp.com>");
> +MODULE_AUTHOR("vikash Bansal <vikash.bansal@nxp.com>");
> +MODULE_DESCRIPTION("P3H2x4x I3C HUB driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_i3c.c b/drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_i3c.c
> new file mode 100644
> index 000000000000..c7827c4b6f57
> --- /dev/null
> +++ b/drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_i3c.c
> @@ -0,0 +1,353 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2024-2025 NXP
> + * This P3H2x4x driver file contain functions for I3C virtual Bus creation, connect/disconnect
> + * hub network and read/write.
> + */
> +#include "p3h2x4x_i3c_hub.h"
> +
> +static void p3h2x4x_en_p3h2x4x_ntwk_tp(struct tp_bus *bus)
> +{
> +	struct p3h2x4x *priv = bus->priv;
> +	struct device *dev = i3cdev_to_dev(priv->i3cdev);
> +	int ret;
> +
> +	if (priv->settings.tp[bus->tp_port].always_enable)
> +		return;
> +
> +	ret = regmap_write(priv->regmap, P3H2x4x_TP_NET_CON_CONF,
> +				(bus->tp_mask | priv->tp_always_enable_mask));
> +	if (ret)
> +		dev_warn(dev, "Failed to open Target Port(s)\n");
> +}
> +
> +static void p3h2x4x_dis_p3h2x4x_ntwk_tp(struct tp_bus *bus)
> +{
> +	struct p3h2x4x *priv = bus->priv;
> +	struct device *dev = i3cdev_to_dev(priv->i3cdev);
> +	int ret;
> +
> +	if (priv->settings.tp[bus->tp_port].always_enable)
> +		return;
> +
> +	ret = regmap_write(priv->regmap, P3H2x4x_TP_NET_CON_CONF, priv->tp_always_enable_mask);
> +	if (ret)
> +		dev_warn(dev, "Failed to close Target Port(s)\n");
> +}
> +
> +static struct tp_bus *p3h2x4x_bus_from_i3c_desc(struct i3c_dev_desc *desc)
> +{
> +	struct i3c_master_controller *controller = i3c_dev_get_master(desc);
> +
> +	return container_of(controller, struct tp_bus, i3c_port_controller);
> +}
> +
> +static struct tp_bus *p3h2x4x_bus_from_i2c_desc(struct i2c_dev_desc *desc)
> +{
> +	struct i3c_master_controller *controller = i2c_dev_get_master(desc);
> +
> +	return container_of(controller, struct tp_bus, i3c_port_controller);
> +}
> +
> +static struct i3c_master_controller
> +*get_parent_controller(struct i3c_master_controller *controller)
> +{
> +	struct tp_bus *bus = container_of(controller, struct tp_bus, i3c_port_controller);
> +
> +	return bus->priv->driving_master;
> +}
> +
> +static struct i3c_master_controller
> +*get_parent_controller_from_i3c_desc(struct i3c_dev_desc *desc)
> +{
> +	struct i3c_master_controller *controller = i3c_dev_get_master(desc);
> +	struct tp_bus *bus = container_of(controller, struct tp_bus, i3c_port_controller);
> +
> +	return bus->priv->driving_master;
> +}
> +
> +static struct i3c_master_controller
> +*get_parent_controller_from_i2c_desc(struct i2c_dev_desc *desc)
> +{
> +	struct i3c_master_controller *controller = desc->common.master;
> +	struct tp_bus *bus = container_of(controller, struct tp_bus, i3c_port_controller);
> +
> +	return bus->priv->driving_master;
> +}
> +
> +static struct i3c_master_controller
> +*update_i3c_i2c_desc_parent(struct i3c_i2c_dev_desc *desc,
> +				struct i3c_master_controller *parent)
> +{
> +	struct i3c_master_controller *orig_parent = desc->master;
> +
> +	desc->master = parent;
> +
> +	return orig_parent;
> +}
> +
> +static void restore_i3c_i2c_desc_parent(struct i3c_i2c_dev_desc *desc,
> +					struct i3c_master_controller *parent)
> +{
> +	desc->master = parent;
> +}
> +
> +static int p3h2x4x_i3c_bus_init(struct i3c_master_controller *controller)
> +{
> +	struct tp_bus *bus = container_of(controller, struct tp_bus, i3c_port_controller);
> +
> +	controller->this = bus->priv->i3cdev->desc;
> +	return 0;
> +}
> +
> +static void p3h2x4x_i3c_bus_cleanup(struct i3c_master_controller *controller)
> +{
> +	controller->this = NULL;
> +}
> +
> +static int p3h2x4x_attach_i3c_dev(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i3c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +	int ret;
> +
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	ret = parent->ops->attach_i3c_dev(dev);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +	return ret;
> +}
> +
> +static int p3h2x4x_reattach_i3c_dev(struct i3c_dev_desc *dev, u8 old_dyn_addr)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i3c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +	int ret;
> +
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	ret = parent->ops->reattach_i3c_dev(dev, old_dyn_addr);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +	return ret;
> +}
> +
> +static void p3h2x4x_detach_i3c_dev(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i3c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	parent->ops->detach_i3c_dev(dev);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +}
> +
> +static int p3h2x4x_do_daa(struct i3c_master_controller *controller)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller(controller);
> +
> +	struct tp_bus *bus = container_of(controller, struct tp_bus, i3c_port_controller);
> +	int ret;
> +
> +	p3h2x4x_en_p3h2x4x_ntwk_tp(bus);
> +	down_write(&parent->bus.lock);
> +	ret = parent->ops->do_daa(parent);
> +	up_write(&parent->bus.lock);
> +	p3h2x4x_dis_p3h2x4x_ntwk_tp(bus);
> +
> +	return ret;
> +}
> +
> +static bool p3h2x4x_supports_ccc_cmd(struct i3c_master_controller *controller,
> +					const struct i3c_ccc_cmd *cmd)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller(controller);
> +
> +	return parent->ops->supports_ccc_cmd(parent, cmd);
> +}
> +
> +static int p3h2x4x_send_ccc_cmd(struct i3c_master_controller *controller,
> +				struct i3c_ccc_cmd *cmd)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller(controller);
> +	struct tp_bus *bus = container_of(controller, struct tp_bus, i3c_port_controller);
> +	int ret;
> +
> +	if (cmd->id == I3C_CCC_RSTDAA(true))
> +		return 0;
> +
> +	p3h2x4x_en_p3h2x4x_ntwk_tp(bus);
> +	ret = parent->ops->send_ccc_cmd(parent, cmd);
> +	p3h2x4x_dis_p3h2x4x_ntwk_tp(bus);
> +
> +	return ret;
> +}
> +
> +static int p3h2x4x_priv_xfers(struct i3c_dev_desc *dev,
> +				struct i3c_priv_xfer *xfers, int nxfers)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i3c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +	struct tp_bus *bus = p3h2x4x_bus_from_i3c_desc(dev);
> +	int res;
> +
> +	p3h2x4x_en_p3h2x4x_ntwk_tp(bus);
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	res = parent->ops->priv_xfers(dev, xfers, nxfers);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +	p3h2x4x_dis_p3h2x4x_ntwk_tp(bus);
> +
> +	return res;
> +}
> +
> +static int p3h2x4x_attach_i2c_dev(struct i2c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i2c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +	int ret;
> +
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	ret = parent->ops->attach_i2c_dev(dev);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +	return ret;
> +}
> +
> +static void p3h2x4x_detach_i2c_dev(struct i2c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i2c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	parent->ops->detach_i2c_dev(dev);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +}
> +
> +static int p3h2x4x_i2c_xfers(struct i2c_dev_desc *dev,
> +				const struct i2c_msg *xfers, int nxfers)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i2c_desc(dev);
> +	struct tp_bus *bus = p3h2x4x_bus_from_i2c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +	int ret;
> +
> +	p3h2x4x_en_p3h2x4x_ntwk_tp(bus);
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	ret = parent->ops->i2c_xfers(dev, xfers, nxfers);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +	p3h2x4x_dis_p3h2x4x_ntwk_tp(bus);
> +	return ret;
> +}
> +
> +static int p3h2x4x_request_ibi(struct i3c_dev_desc *dev,
> +				const struct i3c_ibi_setup *req)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i3c_desc(dev);
> +	struct tp_bus *bus = p3h2x4x_bus_from_i3c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +	int ret;
> +
> +	p3h2x4x_en_p3h2x4x_ntwk_tp(bus);
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	ret = parent->ops->request_ibi(dev, req);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +	p3h2x4x_dis_p3h2x4x_ntwk_tp(bus);
> +	return ret;
> +}
> +
> +static void p3h2x4x_free_ibi(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i3c_desc(dev);
> +	struct tp_bus *bus = p3h2x4x_bus_from_i3c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +
> +	p3h2x4x_en_p3h2x4x_ntwk_tp(bus);
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	parent->ops->free_ibi(dev);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +	p3h2x4x_dis_p3h2x4x_ntwk_tp(bus);
> +}
> +
> +static int p3h2x4x_enable_ibi(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i3c_desc(dev);
> +	struct tp_bus *bus = p3h2x4x_bus_from_i3c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +	int ret;
> +
> +	p3h2x4x_en_p3h2x4x_ntwk_tp(bus);
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	ret = parent->ops->enable_ibi(dev);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +	p3h2x4x_dis_p3h2x4x_ntwk_tp(bus);
> +	return ret;
> +}
> +
> +static int p3h2x4x_disable_ibi(struct i3c_dev_desc *dev)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i3c_desc(dev);
> +	struct tp_bus *bus = p3h2x4x_bus_from_i3c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +	int ret;
> +
> +	p3h2x4x_en_p3h2x4x_ntwk_tp(bus);
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	ret = parent->ops->disable_ibi(dev);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +	p3h2x4x_dis_p3h2x4x_ntwk_tp(bus);
> +	return ret;
> +}
> +
> +static void p3h2x4x_recycle_ibi_slot(struct i3c_dev_desc *dev,
> +					struct i3c_ibi_slot *slot)
> +{
> +	struct i3c_master_controller *parent = get_parent_controller_from_i3c_desc(dev);
> +	struct i3c_master_controller *orig_parent;
> +
> +	orig_parent = update_i3c_i2c_desc_parent(&dev->common, parent);
> +	parent->ops->recycle_ibi_slot(dev, slot);
> +	restore_i3c_i2c_desc_parent(&dev->common, orig_parent);
> +}
> +
> +static const struct i3c_master_controller_ops p3h2x4x_i3c_ops = {
> +	.bus_init = p3h2x4x_i3c_bus_init,
> +	.bus_cleanup = p3h2x4x_i3c_bus_cleanup,
> +	.attach_i3c_dev = p3h2x4x_attach_i3c_dev,
> +	.reattach_i3c_dev = p3h2x4x_reattach_i3c_dev,
> +	.detach_i3c_dev = p3h2x4x_detach_i3c_dev,
> +	.do_daa = p3h2x4x_do_daa,
> +	.supports_ccc_cmd = p3h2x4x_supports_ccc_cmd,
> +	.send_ccc_cmd = p3h2x4x_send_ccc_cmd,
> +	.priv_xfers = p3h2x4x_priv_xfers,
> +	.attach_i2c_dev = p3h2x4x_attach_i2c_dev,
> +	.detach_i2c_dev = p3h2x4x_detach_i2c_dev,
> +	.i2c_xfers = p3h2x4x_i2c_xfers,
> +	.request_ibi = p3h2x4x_request_ibi,
> +	.free_ibi = p3h2x4x_free_ibi,
> +	.enable_ibi = p3h2x4x_enable_ibi,
> +	.disable_ibi = p3h2x4x_disable_ibi,
> +	.recycle_ibi_slot = p3h2x4x_recycle_ibi_slot,
> +};
> +
> +/**
> + * p3h2x4x_tp_i3c_algo - register i3c master for target port who
> + * configured as i3c.
> + * @priv: p3h2x4x device structure.
> + * @tp: target port.
> + *
> + * Return: 0 in case of success, a negative EINVAL code if the error.
> + */
> +int p3h2x4x_tp_i3c_algo(struct p3h2x4x *priv, int tp)
> +{
> +	struct device *dev = i3cdev_to_dev(priv->i3cdev);
> +	int ret;
> +
> +	priv->tp_bus[tp].tp_mask =  BIT(tp);
> +	dev->of_node = priv->tp_bus[tp].of_node;
> +
> +	ret = i3c_master_register(&priv->tp_bus[tp].i3c_port_controller,
> +				dev, &p3h2x4x_i3c_ops, false);
> +	if (ret) {
> +		dev_warn(dev, "Failed to register i3c controller for tp %d\n", tp);
> +		return -EINVAL;
> +	}
> +
> +	priv->tp_bus[tp].is_registered = true;
> +	return 0;
> +}
> diff --git a/drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c b/drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c
> new file mode 100644
> index 000000000000..8cdbaaf49378
> --- /dev/null
> +++ b/drivers/i3c/p3h2x4x/p3h2x4x_i3c_hub_smbus.c
> @@ -0,0 +1,719 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2024-2025 NXP
> + * This P3H2x4x driver file contain functions for SMBus/I2C virtual Bus creation and read/write.
> + */
> +#include "p3h2x4x_i3c_hub.h"
> +
> +static struct device *i2cdev_to_dev(struct i2c_client *i2cdev)
> +{
> +	return &i2cdev->dev;
> +}
> +
> +static void p3h2x4x_read_smbus_agent_rx_buf(struct i3c_device *i3cdev, enum p3h2x4x_rcv_buf rfbuf,
> +								enum p3h2x4x_tp tp, bool is_of)
> +{
> +	struct device *dev = i3cdev_to_dev(i3cdev);
> +	struct p3h2x4x *priv = dev_get_drvdata(dev);
> +	struct smbus_device *backend = NULL;
> +
> +	u8 target_buffer_page, flag_clear, rx_data, temp, i;
> +	u8 slave_rx_buffer[P3H2x4x_SMBUS_TARGET_PAYLOAD_SIZE] = { 0 };
> +	u32 packet_len, slave_address, ret;
> +
> +	target_buffer_page = (((rfbuf) ? P3H2x4x_TARGET_BUFF_1_PAGE : P3H2x4x_TARGET_BUFF_0_PAGE)
> +							+  (P3H2x4x_NO_PAGE_PER_TP * tp));
> +	ret = regmap_write(priv->regmap, P3H2x4x_PAGE_PTR, target_buffer_page);
> +	if (ret)
> +		goto ibi_err;
> +
> +	/* read buffer length */
> +	ret = regmap_read(priv->regmap, P3H2x4x_TARGET_BUFF_LENGTH, &packet_len);
> +	if (ret)
> +		goto ibi_err;
> +
> +	if (packet_len)
> +		packet_len = packet_len - 1;
> +
> +	if (packet_len > P3H2x4x_SMBUS_TARGET_PAYLOAD_SIZE) {
> +		dev_err(dev, "Received message too big for p3h2x4x buffer\n");
> +		return;
> +	}
> +
> +	/* read slave  address */
> +	ret = regmap_read(priv->regmap, P3H2x4x_TARGET_BUFF_ADDRESS, &slave_address);
> +	if (ret)
> +		goto ibi_err;
> +
> +	/* read data */
> +	if (packet_len) {
> +		ret = regmap_bulk_read(priv->regmap, P3H2x4x_TARGET_BUFF_DATA,
> +				slave_rx_buffer, packet_len);
> +		if (ret)
> +			goto ibi_err;
> +	}
> +
> +	if (is_of)
> +		flag_clear = BUF_RECEIVED_FLAG_TF_MASK;
> +	else
> +		flag_clear = (((rfbuf == RCV_BUF_0) ? P3H2x4x_TARGET_BUF_0_RECEIVE :
> +					P3H2x4x_TARGET_BUF_1_RECEIVE));
> +
> +	/* notify slave driver about received data */
> +	list_for_each_entry(backend, &priv->tp_bus[tp].tp_device_entry, list) {
> +		if ((slave_address >> 1 == backend->addr) && (priv->is_slave_reg)) {
> +			i2c_slave_event(backend->client, I2C_SLAVE_WRITE_REQUESTED,
> +				(u8 *)&slave_address);
> +
> +			for (i = 0; i < packet_len; i++) {
> +				rx_data = slave_rx_buffer[i];
> +				i2c_slave_event(backend->client, I2C_SLAVE_WRITE_RECEIVED,
> +						&rx_data);
> +			}
> +			i2c_slave_event(backend->client, I2C_SLAVE_STOP, &temp);
> +			break;
> +		}
> +	}
> +
> +ibi_err:
> +	regmap_write(priv->regmap, P3H2x4x_PAGE_PTR, 0x00);
> +	regmap_write(priv->regmap, P3H2x4x_TP0_SMBUS_AGNT_STS + tp, flag_clear);
> +}
> +
> +/**
> + * p3h2x4x_ibi_handler - IBI handler.
> + * @i3cdev: i3c device.
> + * @payload: two byte IBI payload data.
> + *
> + */
> +void p3h2x4x_ibi_handler(struct i3c_device *i3cdev,
> +				const struct i3c_ibi_payload *payload)
> +{
> +	struct device *dev = i3cdev_to_dev(i3cdev);
> +	struct p3h2x4x *priv = dev_get_drvdata(dev);
> +
> +	u32 target_port_status, payload_byte_one, payload_byte_two;
> +	u8 i;
> +	int  ret;
> +
> +	payload_byte_one = (*(int *)payload->data);
> +	payload_byte_two = (*(int *)(payload->data + 4));
> +
> +	if (!(payload_byte_one & P3H2x4x_SMBUS_AGENT_EVENT_FLAG_STATUS))
> +		goto err;
> +
> +	mutex_lock(&priv->etx_mutex);
> +	ret = regmap_write(priv->regmap, P3H2x4x_TP_SMBUS_AGNT_IBI_CONFIG, P3H2x4x_ALL_TP_IBI_DIS);
> +	if (ret) {
> +		dev_err(dev, "Failed to Disable IBI\n");
> +		goto err;
> +	}
> +
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; ++i) {
> +		if ((priv->tp_bus[i].is_registered) && ((payload_byte_two >> i) & 0x01)) {
> +			ret = regmap_read(priv->regmap, P3H2x4x_TP0_SMBUS_AGNT_STS + i,
> +					&target_port_status);
> +			if (ret) {
> +				dev_err(dev, "target port read status failed %d\n", ret);
> +				goto err;
> +			}
> +
> +			/* process data receive buffer */
> +			switch (target_port_status & BUF_RECEIVED_FLAG_MASK) {
> +			case P3H2x4x_TARGET_BUF_CA_TF:
> +				break;
> +			case P3H2x4x_TARGET_BUF_0_RECEIVE:
> +				p3h2x4x_read_smbus_agent_rx_buf(i3cdev, RCV_BUF_0, i, false);
> +				break;
> +			case P3H2x4x_TARGET_BUF_1_RECEIVE:
> +				p3h2x4x_read_smbus_agent_rx_buf(i3cdev, RCV_BUF_1, i, false);
> +				break;
> +			case P3H2x4x_TARGET_BUF_0_1_RECEIVE:
> +				p3h2x4x_read_smbus_agent_rx_buf(i3cdev, RCV_BUF_0, i, false);
> +				p3h2x4x_read_smbus_agent_rx_buf(i3cdev, RCV_BUF_1, i, false);
> +				break;
> +			case P3H2x4x_TARGET_BUF_OVRFL:
> +				p3h2x4x_read_smbus_agent_rx_buf(i3cdev, RCV_BUF_0, i, false);
> +				p3h2x4x_read_smbus_agent_rx_buf(i3cdev, RCV_BUF_1, i, true);
> +				dev_err(dev, "Overflow, reading buffer zero and one\n");
> +				break;
> +			default:
> +				regmap_write(priv->regmap, P3H2x4x_TP0_SMBUS_AGNT_STS + i,
> +					BUF_RECEIVED_FLAG_TF_MASK);
> +					break;
> +			}
> +		}
> +	}
> +err:
> +	regmap_write(priv->regmap, P3H2x4x_TP_SMBUS_AGNT_IBI_CONFIG, priv->tp_ibi_mask);
> +	mutex_unlock(&priv->etx_mutex);
> +}
> +
> +static int p3h2x4x_read_p3h2x4x_id(struct device *dev)
> +{
> +	struct p3h2x4x *priv = dev_get_drvdata(dev);
> +	u32 reg_val;
> +	int ret;
> +
> +	ret = regmap_read(priv->regmap, P3H2x4x_LDO_AND_CPSEL_STS, &reg_val);
> +	if (ret) {
> +		dev_err(dev, "Failed to read status register\n");
> +		return ret;
> +	}
> +	if (P3H2x4x_CP_SEL_PIN_INPUT_CODE_GET(reg_val) == 3)
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +
> +static void unlock_port_ext_mutex(struct mutex *ext, struct mutex *port)
> +{
> +	mutex_unlock(ext);
> +	mutex_unlock(port);
> +}
> +
> +static void lock_port_ext_mutex(struct mutex *ext, struct mutex *port)
> +{
> +	mutex_lock(ext);
> +	mutex_lock(port);
> +}
> +
> +static int p3h2x4x_read_smbus_transaction_status(struct p3h2x4x *priv,
> +					u8 target_port_status, u8 *status, u8 data_length)
> +{
> +	unsigned int status_read;
> +	int ret;
> +
> +	mutex_unlock(&priv->etx_mutex);
> +	fsleep(P3H2x4x_SMBUS_400kHz_TRANSFER_TIMEOUT(data_length));
> +	mutex_lock(&priv->etx_mutex);
> +
> +	ret = regmap_read(priv->regmap, target_port_status, &status_read);
> +	if (ret)
> +		return ret;
> +
> +	*status = (u8)status_read;
> +
> +	if ((*status & P3H2x4x_TP_BUFFER_STATUS_MASK) == P3H2x4x_XFER_SUCCESS)
> +		return 0;
> +
> +	dev_err(&priv->i3cdev->dev, "Status read timeout reached\n");
> +	return 0;
> +}
> +
> +/*
> + * p3h2x4x_tp_i2c_xfer_msg() - This starts a SMBus write transaction by writing a descriptor
> + * and a message to the p3h2x4x registers. Controller buffer page is determined by multiplying the
> + * target port index by four and adding the base page number to it.
> + */
> +static int p3h2x4x_tp_i2c_xfer_msg(struct p3h2x4x *priv,
> +				struct i2c_msg *xfers,
> +				u8 target_port,
> +				u8 nxfers_i, u8 rw, u8 *return_status)
> +{
> +	u8 transaction_type = P3H2x4x_SMBUS_400kHz;
> +	u8 controller_buffer_page = P3H2x4x_CONTROLLER_BUFFER_PAGE + 4 * target_port;
> +	int write_length = xfers[nxfers_i].len;
> +	int read_length = xfers[nxfers_i].len;
> +	u8 target_port_status = P3H2x4x_TP0_SMBUS_AGNT_STS + target_port;
> +	u8 addr = xfers[nxfers_i].addr;
> +	u8 target_port_code = BIT(target_port);
> +	u8 rw_address = 2 * addr;
> +	u8 desc[P3H2x4x_SMBUS_DESCRIPTOR_SIZE] = { 0 };
> +	u8 status;
> +	int ret;
> +
> +	if (rw) {
> +		rw_address |= BIT(0);
> +		write_length = 0;
> +	} else {
> +		read_length = 0;
> +	}
> +
> +	desc[0] = rw_address;
> +	desc[1] = transaction_type;
> +	desc[2] = write_length;
> +	desc[3] = read_length;
> +
> +	ret = regmap_write(priv->regmap, target_port_status,
> +			P3H2x4x_TP_BUFFER_STATUS_MASK);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, P3H2x4x_PAGE_PTR, controller_buffer_page);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_write(priv->regmap, P3H2x4x_CONTROLLER_AGENT_BUFF,
> +				desc, P3H2x4x_SMBUS_DESCRIPTOR_SIZE);
> +	if (ret)
> +		return ret;
> +
> +	if (!rw) {
> +		ret = regmap_bulk_write(priv->regmap,
> +					P3H2x4x_CONTROLLER_AGENT_BUFF_DATA,
> +					xfers[nxfers_i].buf, xfers[nxfers_i].len);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_write(priv->regmap, P3H2x4x_TP_SMBUS_AGNT_TRANS_START,
> +			target_port_code);
> +	if (ret)
> +		return ret;
> +
> +	ret = p3h2x4x_read_smbus_transaction_status(priv, target_port_status,
> +				&status, (write_length + read_length));
> +	if (ret)
> +		return ret;
> +
> +	*return_status = status;
> +
> +	if (rw) {
> +		ret = regmap_bulk_read(priv->regmap,
> +				P3H2x4x_CONTROLLER_AGENT_BUFF_DATA,
> +				xfers[nxfers_i].buf, xfers[nxfers_i].len);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_write(priv->regmap, P3H2x4x_PAGE_PTR, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/*
> + * This function will be called whenever you call I2C read, write APIs like
> + * i2c_master_send(), i2c_master_recv() etc.
> + */
> +static s32 p3h2x4x_tp_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
> +{
> +	int ret_sum = 0;
> +	int ret;
> +	u8 return_status;
> +	u8 msg_count;
> +	u8 rw;
> +
> +	struct device *dev;
> +	struct tp_bus *bus =
> +		container_of(adap, struct tp_bus, smbus_port_adapter);
> +	struct p3h2x4x *priv = bus->priv;
> +
> +	if (priv->is_p3h2x4x_in_i3c)
> +		dev = i3cdev_to_dev(priv->i3cdev);
> +	else
> +		dev = i2cdev_to_dev(priv->i2cdev);
> +
> +	lock_port_ext_mutex(&priv->etx_mutex, &bus->port_mutex);
> +
> +	if (priv->is_p3h2x4x_in_i3c) {
> +		ret = i3c_device_disable_ibi(priv->i3cdev);
> +		if (ret) {
> +			dev_err(dev, "Failed to Disable IBI\n");
> +			unlock_port_ext_mutex(&priv->etx_mutex, &bus->port_mutex);
> +			return ret;
> +		}
> +	}
> +
> +	for (msg_count = 0; msg_count < num; msg_count++) {
> +		if (msgs[msg_count].len > P3H2x4x_SMBUS_PAYLOAD_SIZE) {
> +			dev_err(&adap->dev,
> +				"Message nr. %d not sent - length over %d bytes.\n",
> +				msg_count, P3H2x4x_SMBUS_PAYLOAD_SIZE);
> +			continue;
> +		}
> +		rw = msgs[msg_count].flags % 2;
> +
> +		ret = p3h2x4x_tp_i2c_xfer_msg(priv,
> +					msgs,
> +					bus->tp_port,
> +					msg_count, rw, &return_status);
> +
> +		if (ret)
> +			goto error;
> +
> +		if (return_status == P3H2x4x_XFER_SUCCESS)
> +			ret_sum++;
> +	}
> +
> +error:
> +	if (priv->is_p3h2x4x_in_i3c) {
> +		ret =  i3c_device_enable_ibi(priv->i3cdev);
> +		if (ret) {
> +			dev_err(dev, "Failed to Enable IBI\n");
> +			unlock_port_ext_mutex(&priv->etx_mutex, &bus->port_mutex);
> +			return ret;
> +		}
> +	}
> +	unlock_port_ext_mutex(&priv->etx_mutex, &bus->port_mutex);
> +	return ret_sum;
> +}
> +
> +static int p3h2x4x_tp_smbus_xfer_msg(struct p3h2x4x *priv,
> +					u8 target_port,
> +					u8 addr,
> +					u8 rw,
> +					u8 cmd,
> +					int sz,
> +					union i2c_smbus_data *data,
> +					u8 *return_status)
> +{
> +	u8 transaction_type = P3H2x4x_SMBUS_400kHz;
> +	u8 controller_buffer_page = P3H2x4x_CONTROLLER_BUFFER_PAGE + 4 * target_port;
> +	u8 target_port_status = P3H2x4x_TP0_SMBUS_AGNT_STS + target_port;
> +	u8 target_port_code = BIT(target_port);
> +	u8 rw_address = 2 * addr;
> +	u8 desc[P3H2x4x_SMBUS_DESCRIPTOR_SIZE] = { 0 };
> +	u8 status;
> +	int ret, i;
> +	u8 read_length, write_length;
> +	u8 buf[I2C_SMBUS_BLOCK_MAX + 2] = {0};
> +	struct device *dev;
> +
> +	if (priv->is_p3h2x4x_in_i3c)
> +		dev = i3cdev_to_dev(priv->i3cdev);
> +	else
> +		dev = i2cdev_to_dev(priv->i2cdev);
> +
> +	/* Map the size to what the chip understands */
> +	switch (sz) {
> +	case I2C_SMBUS_QUICK:
> +	case I2C_SMBUS_BYTE:
> +		if (rw)	{
> +			buf[0] = data->byte;
> +			read_length = ONE_BYTE_SIZE;
> +			write_length = 0;
> +			rw_address |= BIT(0);
> +		} else {
> +			buf[0] = cmd;
> +			write_length = ONE_BYTE_SIZE;
> +			read_length = 0;
> +		}
> +		break;
> +	case I2C_SMBUS_BYTE_DATA:
> +		if (rw) {   /* read write */
> +			buf[0] = cmd;
> +			write_length = ONE_BYTE_SIZE;
> +			read_length = ONE_BYTE_SIZE;
> +			transaction_type |= BIT(0);
> +		} else {  /* only write */
> +			buf[0] = cmd;
> +			buf[1] = data->byte;
> +			write_length = ONE_BYTE_SIZE + 1;
> +			read_length = 0;
> +		}
> +		break;
> +	case I2C_SMBUS_WORD_DATA:
> +		if (rw) {         /* read write */
> +			buf[0] = cmd;
> +			write_length = ONE_BYTE_SIZE;
> +			read_length = 2;
> +			transaction_type |= BIT(0);
> +		} else {  /* only write */
> +			buf[0] = cmd;
> +			buf[1] = data->word & 0xff;
> +			buf[2] = (data->word & 0xff00) >> 8;
> +			write_length = ONE_BYTE_SIZE + 2;
> +			read_length = 0;
> +		}
> +		break;
> +	case I2C_SMBUS_BLOCK_DATA:
> +		if (rw) {         /* read write */
> +			buf[0] = cmd;
> +			write_length = ONE_BYTE_SIZE;
> +			read_length = data->block[0] + 1;
> +			transaction_type |= BIT(0);
> +		} else {  /* only write */
> +			buf[0] = cmd;
> +			for (i = 0 ; i <= data->block[0]; i++)
> +				buf[i+1] = data->block[i];
> +
> +			write_length = data->block[0] + 2;
> +			read_length = 0;
> +		}
> +		break;
> +	case I2C_SMBUS_I2C_BLOCK_DATA:
> +		if (rw) {         /* read write */
> +			buf[0] = cmd;
> +			write_length = ONE_BYTE_SIZE;
> +			read_length = data->block[0];
> +			transaction_type |= BIT(0);
> +		} else {  /* only write */
> +			buf[0] = cmd;
> +			for (i = 0 ; i < data->block[0]; i++)
> +				buf[i+1] = data->block[i+1];
> +
> +			write_length = data->block[0] + 1;
> +			read_length = 0;
> +		}
> +		break;
> +	default:
> +		dev_warn(dev, "Unsupported transaction %d\n", sz);
> +		break;
> +	}
> +
> +	desc[0] = rw_address;
> +	desc[1] = transaction_type;
> +	desc[2] = write_length;
> +	desc[3] = read_length;
> +
> +	ret = regmap_write(priv->regmap, target_port_status,
> +			P3H2x4x_TP_BUFFER_STATUS_MASK);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, P3H2x4x_PAGE_PTR, controller_buffer_page);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_write(priv->regmap, P3H2x4x_CONTROLLER_AGENT_BUFF,
> +				desc, P3H2x4x_SMBUS_DESCRIPTOR_SIZE);
> +	if (ret)
> +		return ret;
> +
> +	if (write_length) {
> +		ret = regmap_bulk_write(priv->regmap,
> +				P3H2x4x_CONTROLLER_AGENT_BUFF_DATA,
> +				buf, write_length);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_write(priv->regmap, P3H2x4x_TP_SMBUS_AGNT_TRANS_START,
> +			target_port_code);
> +	if (ret)
> +		return ret;
> +
> +	ret = p3h2x4x_read_smbus_transaction_status(priv, target_port_status, &status,
> +			(write_length + read_length));
> +	if (ret)
> +		return ret;
> +
> +	*return_status = status;
> +
> +	if (rw) {
> +		switch (sz) {
> +		case I2C_SMBUS_QUICK:
> +		case I2C_SMBUS_BYTE:
> +		case I2C_SMBUS_BYTE_DATA:
> +			{
> +				ret = regmap_bulk_read(priv->regmap,
> +					P3H2x4x_CONTROLLER_AGENT_BUFF_DATA + write_length,
> +					&data->byte, read_length);
> +					break;
> +			}
> +		case I2C_SMBUS_WORD_DATA:
> +			{
> +				ret = regmap_bulk_read(priv->regmap,
> +					P3H2x4x_CONTROLLER_AGENT_BUFF_DATA + write_length,
> +					(u8 *)&data->word, read_length);
> +				break;
> +			}
> +		case I2C_SMBUS_BLOCK_DATA:
> +			{
> +				ret = regmap_bulk_read(priv->regmap,
> +					P3H2x4x_CONTROLLER_AGENT_BUFF_DATA + write_length,
> +					data->block, read_length);
> +				break;
> +			}
> +		case I2C_SMBUS_I2C_BLOCK_DATA:
> +			{
> +				ret = regmap_bulk_read(priv->regmap,
> +					P3H2x4x_CONTROLLER_AGENT_BUFF_DATA + write_length,
> +					data->block + 1, read_length);
> +				break;
> +			}
> +		default:
> +				dev_warn(dev, "Unsupported transaction %d\n", sz);
> +				break;
> +		}
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_write(priv->regmap, P3H2x4x_PAGE_PTR, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static s32 p3h2x4x_tp_smbus_xfer(struct i2c_adapter *adap, u16 addr, unsigned short flags,
> +		char read_write, u8 command, int size, union i2c_smbus_data *data)
> +{
> +	struct tp_bus *bus =
> +		container_of(adap, struct tp_bus, smbus_port_adapter);
> +
> +	struct p3h2x4x *priv = bus->priv;
> +	struct device *dev;
> +
> +	if (priv->is_p3h2x4x_in_i3c)
> +		dev = i3cdev_to_dev(priv->i3cdev);
> +	else
> +		dev = i2cdev_to_dev(priv->i2cdev);
> +
> +	int ret, ret_status;
> +	u8 return_status;
> +
> +	lock_port_ext_mutex(&priv->etx_mutex, &bus->port_mutex);
> +
> +	if (priv->is_p3h2x4x_in_i3c) {
> +		ret = i3c_device_disable_ibi(priv->i3cdev);
> +		if (ret) {
> +			dev_err(dev, "Failed to Disable IBI\n");
> +			unlock_port_ext_mutex(&priv->etx_mutex, &bus->port_mutex);
> +			return ret;
> +		}
> +	}
> +
> +	ret_status = p3h2x4x_tp_smbus_xfer_msg(priv,
> +				(u8)bus->tp_port,
> +				(u8)addr,
> +				(u8)read_write,
> +				(u8)command,
> +				size,
> +				data,
> +				&return_status);
> +
> +	if (priv->is_p3h2x4x_in_i3c) {
> +		ret = i3c_device_enable_ibi(priv->i3cdev);
> +		if (ret) {
> +			dev_err(dev, "Failed to Enable IBI\n");
> +			unlock_port_ext_mutex(&priv->etx_mutex, &bus->port_mutex);
> +			return ret;
> +		}
> +	}
> +	unlock_port_ext_mutex(&priv->etx_mutex, &bus->port_mutex);
> +
> +	if (ret_status)
> +		return ret_status;
> +
> +	if (return_status == P3H2x4x_XFER_SUCCESS)
> +		return 0;
> +	else
> +		return -EINVAL;
> +}
> +
> +static u32 p3h2x4x_tp_smbus_funcs(struct i2c_adapter *adapter)
> +{
> +	return I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BYTE_DATA |
> +			I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_WORD_DATA |
> +			I2C_FUNC_SMBUS_I2C_BLOCK  | I2C_FUNC_SMBUS_BLOCK_DATA |
> +			I2C_FUNC_I2C;
> +}
> +
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +static int p3h2x4x_tp_i2c_reg_slave(struct i2c_client *slave)
> +{
> +	struct tp_bus *bus =
> +		container_of(slave->adapter, struct tp_bus, smbus_port_adapter);
> +	struct p3h2x4x *priv = bus->priv;
> +
> +	priv->is_slave_reg = true;
> +
> +	return 0;
> +}
> +static int p3h2x4x_tp_i2c_unreg_slave(struct i2c_client *slave)
> +{
> +	struct tp_bus *bus =
> +		container_of(slave->adapter, struct tp_bus, smbus_port_adapter);
> +	struct p3h2x4x *priv = bus->priv;
> +
> +	priv->is_slave_reg = false;
> +
> +	return 0;
> +}
> +#endif
> +
> +/*
> + * I2C algorithm Structure
> + */
> +static struct i2c_algorithm p3h2x4x_tp_i2c_algorithm = {
> +	.master_xfer    = p3h2x4x_tp_i2c_xfer,
> +	.smbus_xfer = p3h2x4x_tp_smbus_xfer,
> +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> +	.reg_slave = p3h2x4x_tp_i2c_reg_slave,
> +	.unreg_slave = p3h2x4x_tp_i2c_unreg_slave,
> +#endif
> +	.functionality  = p3h2x4x_tp_smbus_funcs,
> +};
> +
> +/*
> + * p3h2x4x_tp_add_downstream_device - prove downstream devices for target port who
> + * configured as SMBus.
> + * @priv: p3h2x4x device structure.
> + * Return: 0 in case of success, a negative EINVAL code if the error.
> + */
> +int p3h2x4x_tp_add_downstream_device(struct p3h2x4x *priv)
> +{
> +	struct i2c_board_info smbus_tp_device_info = {0};
> +	struct smbus_device *backend = NULL;
> +	struct tp_bus *bus;
> +	int i;
> +	struct device *dev;
> +
> +	if (priv->is_p3h2x4x_in_i3c)
> +		dev = i3cdev_to_dev(priv->i3cdev);
> +	else
> +		dev = i2cdev_to_dev(priv->i2cdev);
> +
> +	for (i = 0; i < P3H2x4x_TP_MAX_COUNT; i++) {
> +		bus = &priv->tp_bus[i];
> +		if (!bus->is_registered)
> +			continue;
> +
> +		list_for_each_entry(backend,
> +					&bus->tp_device_entry, list) {
> +
> +			smbus_tp_device_info.addr = backend->addr;
> +			smbus_tp_device_info.flags = I2C_CLIENT_SLAVE;
> +			smbus_tp_device_info.of_node = backend->tp_device_dt_node;
> +			snprintf(smbus_tp_device_info.type, I2C_NAME_SIZE, backend->compatible);
> +			backend->client = i2c_new_client_device(&bus->smbus_port_adapter,
> +						&smbus_tp_device_info);
> +			if (IS_ERR(backend->client)) {
> +				dev_warn(dev, "Error while registering backend\n");
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
> +/*
> + * p3h2x4x_tp_smbus_algo - add i2c adapter for target port who
> + * configured as SMBus.
> + * @priv: p3h2x4x device structure.
> + * @tp: target port.
> + * Return: 0 in case of success, a negative EINVAL code if the error.
> + */
> +int p3h2x4x_tp_smbus_algo(struct p3h2x4x *priv, int tp)
> +{
> +	int ret;
> +	struct device *dev;
> +
> +	if (priv->is_p3h2x4x_in_i3c)
> +		dev = i3cdev_to_dev(priv->i3cdev);
> +	else
> +		dev = i2cdev_to_dev(priv->i2cdev);
> +
> +	priv->tp_bus[tp].smbus_port_adapter.owner = THIS_MODULE;
> +	priv->tp_bus[tp].smbus_port_adapter.class = I2C_CLASS_HWMON;
> +	priv->tp_bus[tp].smbus_port_adapter.algo = &p3h2x4x_tp_i2c_algorithm;
> +
> +	sprintf(priv->tp_bus[tp].smbus_port_adapter.name, "p3h2x4x-cp-%d.tp-port-%d",
> +		p3h2x4x_read_p3h2x4x_id(dev), tp);
> +
> +	ret = i2c_add_adapter(&priv->tp_bus[tp].smbus_port_adapter);
> +	if (ret) {
> +		dev_warn(dev, "failled to add adapter for tp %d\n", tp);
> +		return -EINVAL;
> +	}
> +	priv->tp_bus[tp].is_registered = true;
> +
> +	return 0;
> +}
> diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
> index b674f64d0822..5ab199abb653 100644
> --- a/include/linux/i3c/device.h
> +++ b/include/linux/i3c/device.h
> @@ -77,6 +77,7 @@ struct i3c_priv_xfer {
>   */
>  enum i3c_dcr {
>  	I3C_DCR_GENERIC_DEVICE = 0,
> +	I3C_DCR_HUB = 194,
>  };
>  
>  #define I3C_PID_MANUF_ID(pid)		(((pid) & GENMASK_ULL(47, 33)) >> 33)
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

