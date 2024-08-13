Return-Path: <linux-kernel+bounces-285333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA329950C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1A01F22489
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198621A38EA;
	Tue, 13 Aug 2024 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYKhhAkB"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20C735894;
	Tue, 13 Aug 2024 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573635; cv=none; b=ImVqHe0VOoL2yFGy4eNSq0CJYBoa4YDnn9CtOTpwzUcR6y1wTVTxo/CWMvTTg6urHzYv9Yo8XkuzVS//ldrphZueNSjZ/z9WBrYdWBZ6a7dlMOdd0EEfEJFZAPP/1Gg3ZF3xvg++K6V1kf0Ilb6AbeGAyfsoZpXNV2XzOsTzjuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573635; c=relaxed/simple;
	bh=q2Ug0hjd66N2PwhPbhm20+XNwJ6kx5laaAp/4eeRhY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFtplOg+R2yv5XiFXiW45sUo2Gjmc3aFhsMeBzXmbWNZayXgnTIK/LvdB4cgxRCbHcJ7+DQOa5lpk0W6Psy6xXSi3AB6t5ahzUPtsXdWxCmjsPZzom/vT2+sH9LeVhb7hTHz+NEDBvnhvqmPx3vXmTtMHKfJ7GIV0ZI1Yn7G36g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYKhhAkB; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7a23fbb372dso3708719a12.0;
        Tue, 13 Aug 2024 11:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723573633; x=1724178433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBorG5Owv8+xGJUxA2+j0IVgIjvFyhD3JtER++J75bQ=;
        b=dYKhhAkBff6r0wx9zUfEm+pxRLqbFY2uWOZlzr3s/3CAKeE00uFzOoBaICm29TO9kq
         sWILsc2SVGQ0Uh/sYEO3UdbyCEtGSg67Gp2hpyTqeqXkoYtCnx99BhcrBkuqO4Qp4iUm
         LJSXQjLrDb+5CfDqZCekWpZxMCx5d9ypNg2terSqAVi8GGNbjhW8j8jA64W6CYwlSiLY
         OSm4r/a/fEsenVBTc5DN/FNWB3aY4B/GScpDaQff1tZqcMhDGdB7yA7alLfS8fUi3RZG
         Rc414YRYBN5YmeBNCCsUzOrkSVAQLgdS27IJPRP4Oej0RbGNXOzvIWX/CewIutq/IHQx
         6oKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723573633; x=1724178433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBorG5Owv8+xGJUxA2+j0IVgIjvFyhD3JtER++J75bQ=;
        b=hKZNFUbwLN8hhfqzUcpzQCPOjqwE2N1nzdDpagZMPQuV9fToyiTE6RkuCbnI/b8HOA
         r9mr7WtVjTZbsfx6l8w9S0lrP5Dv66mUNKD8G/B21ag+MtdywiP5A1oj1owkQcSh3zme
         mz0/vORJ3MBsVsws5Khk8HwhkcCeICuFT5lkpgGsdaKQzda/INLEkjpzKD+wy27Uywgl
         NqpmHydkfKpYS3Fiey4WMzbU3YQSWPqofuwaqi3hlKWvx0rnOeWTBrQ7Xf2cx07335OP
         TLFHz+UJ3Kely8wH9Mnf9arcW8axOWKeSofLk1j2b97xkHgHvYl7Ny2orgqtBhCugXME
         70/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV32SNXdjpq/ZYeav/k3GiLgWjwHB1QO+xe1EMTxa1Fqexlv53mnTActcETgyatgNFmcAzP7dlju/HPgyyyU/fqP7MdyDuBmrR9SKTpk8TKFMdeiS8OGxOKJSUCOMBWlN2dVKwDJdtKDMKpsBbJepu3MjrC3WrOsFFlpA5Pc6bGdODNsnrlIUDhNnZyMGVD0dc5/u091CHDxkZNnFG/FhUG
X-Gm-Message-State: AOJu0Yw9Q5gT2diwO+RZWTNBq9MZt7yq12JTr59+Tkm6kElvDcpko53g
	YbzT8W8mucK2nNffrXIRzlxp+sIyTtdZMRCy8prCt0e6u1QdvijC
X-Google-Smtp-Source: AGHT+IGzlIh3Aas0q97yR/7KjHFLg6JbKjCq3aGVtsHIueVq4E7Mbyzn+9rpdaiCNbpaJ/u8qAJ2CA==
X-Received: by 2002:a05:6a20:c78e:b0:1c3:cfc2:2b1f with SMTP id adf61e73a8af0-1c8eaf47c09mr727003637.37.1723573632778;
        Tue, 13 Aug 2024 11:27:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71256d9c8dfsm1972109b3a.12.2024.08.13.11.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 11:27:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 13 Aug 2024 11:27:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
	Chao Wei <chao.wei@sophgo.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Drew Fustini <dfustini@baylibre.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Hal Feng <hal.feng@starfivetech.com>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 2/4] drivers: hwmon: sophgo: Add SG2042 external
 hardware monitor support
Message-ID: <0e30eab7-e202-4639-863d-85ce28525714@roeck-us.net>
References: <IA1PR20MB4953C5DB4AC5DF01236CE785BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953936E4916334E1A234962BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB4953936E4916334E1A234962BBBB2@IA1PR20MB4953.namprd20.prod.outlook.com>

On Sat, Aug 10, 2024 at 04:03:51PM +0800, Inochi Amaoto wrote:
> SG2042 use an external MCU to provide basic hardware information
> and thermal sensors.
> 
> Add driver support for the onboard MCU of SG2042.
> 
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Tested-by: Chen Wang <unicorn_wang@outlook.com>
> Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  Documentation/hwmon/index.rst      |   1 +
>  Documentation/hwmon/sg2042-mcu.rst |  77 ++++++
>  drivers/hwmon/Kconfig              |  11 +
>  drivers/hwmon/Makefile             |   1 +
>  drivers/hwmon/sg2042-mcu.c         | 388 +++++++++++++++++++++++++++++
>  5 files changed, 478 insertions(+)
>  create mode 100644 Documentation/hwmon/sg2042-mcu.rst
>  create mode 100644 drivers/hwmon/sg2042-mcu.c
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 913c11390a45..ea3b5be8fe4f 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -206,6 +206,7 @@ Hardware Monitoring Kernel Drivers
>     sch5636
>     scpi-hwmon
>     sfctemp
> +   sg2042-mcu
>     sht15
>     sht21
>     sht3x
> diff --git a/Documentation/hwmon/sg2042-mcu.rst b/Documentation/hwmon/sg2042-mcu.rst
> new file mode 100644
> index 000000000000..18a3578ac213
> --- /dev/null
> +++ b/Documentation/hwmon/sg2042-mcu.rst
> @@ -0,0 +1,77 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver sg2042-mcu
> +========================
> +
> +Supported chips:
> +
> +  * Onboard MCU for sg2042
> +
> +    Addresses scanned: -
> +
> +    Prefix: 'sg2042-mcu'
> +
> +Authors:
> +
> +  - Inochi Amaoto <inochiama@outlook.com>
> +
> +Description
> +-----------
> +
> +This driver supprts hardware monitoring for onboard MCU with
> +i2c interface.
> +
> +Usage Notes
> +-----------
> +
> +This driver does not auto-detect devices. You will have to instantiate
> +the devices explicitly.
> +Please see Documentation/i2c/instantiating-devices.rst for details.
> +
> +Sysfs Attributes
> +----------------
> +
> +The following table shows the standard entries support by the driver:
> +
> +================= =====================================================
> +Name              Description
> +================= =====================================================
> +temp1_input       Measured temperature of SoC
> +temp1_crit        Critical high temperature
> +temp1_crit_hyst   hysteresis temperature restore from Critical
> +temp2_input       Measured temperature of the base board
> +================= =====================================================
> +
> +The following table shows the extra entries support by the platform:
> +

Those are attached to the i2c device, which should be mentioned.
The terms "driver" and "platform" are really misleading. The attributes
above are hardware monitoring device attributes, the attributes below are
i2c device attributes. Both are implemented and thus supported by the
driver.

> +================= ======= =============================================
> +Name              Perm    Description
> +================= ======= =============================================
> +reset_count       RO      Reset count of the SoC
> +uptime            RO      Seconds after the MCU is powered
> +reset_reason      RO      Reset reason for the last reset
> +repower_policy    RW      Execution policy when triggering repower
> +================= ======= =============================================
> +
> +``repower_policy``
> +  The repower is triggered when the temperature of the SoC falls below
> +  the hysteresis temperature after triggering a shutdown due to
> +  reaching the critical temperature.
> +  The valid value for this entry is "repower" or "keep". "keep" will
> +  leave the SoC down when the triggering repower, and "repower" will
> +  boot the SoC.
> +
> +Debugfs Interfaces
> +------------------
> +
> +If debugfs is available, this driver exposes some hardware specific
> +data in ``/sys/kernel/debug/sg2042-mcu/*/``.
> +
> +================= ======= =============================================
> +Name              Format  Description
> +================= ======= =============================================
> +firmware_version  0x%02x  firmware version of the MCU
> +pcb_version       0x%02x  version number of the base board
> +board_type        0x%02x  identifiers for the base board
> +mcu_type          %d      type of the MCU: 0 is STM32, 1 is GD32
> +================= ======= =============================================
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index b60fe2e58ad6..7aa6c3f322e5 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2066,6 +2066,17 @@ config SENSORS_SFCTEMP
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called sfctemp.
>  
> +config SENSORS_SG2042_MCU
> +	tristate "Sophgo onboard MCU support"
> +	depends on I2C
> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	help
> +	  Support for onboard MCU of Sophgo SG2042 SoCs. This mcu provides
> +	  power control and some basic information.
> +
> +	  This driver can be built as a module. If so, the module
> +	  will be called sg2042-mcu.
> +
>  config SENSORS_SURFACE_FAN
>  	tristate "Surface Fan Driver"
>  	depends on SURFACE_AGGREGATOR
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index b1c7056c37db..0bbe812a67ae 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -194,6 +194,7 @@ obj-$(CONFIG_SENSORS_SCH56XX_COMMON)+= sch56xx-common.o
>  obj-$(CONFIG_SENSORS_SCH5627)	+= sch5627.o
>  obj-$(CONFIG_SENSORS_SCH5636)	+= sch5636.o
>  obj-$(CONFIG_SENSORS_SFCTEMP)	+= sfctemp.o
> +obj-$(CONFIG_SENSORS_SG2042_MCU) += sg2042-mcu.o
>  obj-$(CONFIG_SENSORS_SL28CPLD)	+= sl28cpld-hwmon.o
>  obj-$(CONFIG_SENSORS_SHT15)	+= sht15.o
>  obj-$(CONFIG_SENSORS_SHT21)	+= sht21.o
> diff --git a/drivers/hwmon/sg2042-mcu.c b/drivers/hwmon/sg2042-mcu.c
> new file mode 100644
> index 000000000000..0a2e072511b6
> --- /dev/null
> +++ b/drivers/hwmon/sg2042-mcu.c
> @@ -0,0 +1,388 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024 Inochi Amaoto <inochiama@outlook.com>
> + *
> + * Sophgo power control mcu for SG2042
> + */
> +
> +#include <linux/cleanup.h>
> +#include <linux/debugfs.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +
> +/* fixed MCU registers */
> +#define REG_BOARD_TYPE				0x00
> +#define REG_MCU_FIRMWARE_VERSION		0x01
> +#define REG_PCB_VERSION				0x02
> +#define REG_PWR_CTRL				0x03
> +#define REG_SOC_TEMP				0x04
> +#define REG_BOARD_TEMP				0x05
> +#define REG_RST_COUNT				0x0a
> +#define REG_UPTIME				0x0b
> +#define REG_RESET_REASON			0x0d
> +#define REG_MCU_TYPE				0x18
> +#define REG_REPOWER_POLICY			0x65
> +#define REG_CRITICAL_TEMP			0x66
> +#define REG_REPOWER_TEMP			0x67
> +
> +#define REPOWER_POLICY_REBOOT			1
> +#define REPOWER_POLICY_KEEP_OFF			2
> +
> +#define MCU_POWER_MAX				0xff
> +
> +#define DEFINE_MCU_DEBUG_ATTR(_name, _reg, _format)			\
> +	static int _name##_show(struct seq_file *seqf,			\
> +				    void *unused)			\
> +	{								\
> +		struct sg2042_mcu_data *mcu = seqf->private;		\
> +		int ret;						\
> +		ret = i2c_smbus_read_byte_data(mcu->client, (_reg));	\
> +		if (ret < 0)						\
> +			return ret;					\
> +		seq_printf(seqf, _format "\n", ret);			\
> +		return 0;						\
> +	}								\
> +	DEFINE_SHOW_ATTRIBUTE(_name)					\
> +
> +struct sg2042_mcu_data {
> +	struct i2c_client	*client;
> +	struct dentry		*debugfs;
> +	struct mutex		mutex;
> +};
> +
> +static struct dentry *sgmcu_debugfs;
> +
> +static ssize_t reset_count_show(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(mcu->client, REG_RST_COUNT);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n", ret);
> +}
> +
> +static ssize_t uptime_show(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	u8 time_val[2];
> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(mcu->client, REG_UPTIME,
> +					    sizeof(time_val), time_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%d\n",
> +		       (time_val[0]) | (time_val[1] << 8));
> +}
> +
> +static ssize_t reset_reason_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(mcu->client, REG_RESET_REASON);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "0x%02x\n", ret);
> +}
> +
> +static ssize_t repower_policy_show(struct device *dev,
> +				   struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	int ret;
> +	const char *action;
> +
> +	ret = i2c_smbus_read_byte_data(mcu->client, REG_REPOWER_POLICY);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret == REPOWER_POLICY_REBOOT)
> +		action = "repower";
> +	else if (ret == REPOWER_POLICY_KEEP_OFF)
> +		action = "keep";
> +	else
> +		action = "unknown";
> +
> +	return sprintf(buf, "%s\n", action);
> +}
> +
> +static ssize_t repower_policy_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	u8 value;
> +	int ret;
> +
> +	if (sysfs_streq("repower", buf))
> +		value = REPOWER_POLICY_REBOOT;
> +	else if (sysfs_streq("keep", buf))
> +		value = REPOWER_POLICY_KEEP_OFF;
> +	else
> +		return -EINVAL;
> +
> +	ret = i2c_smbus_write_byte_data(mcu->client,
> +					REG_REPOWER_POLICY, value);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RO(reset_count);
> +static DEVICE_ATTR_RO(uptime);
> +static DEVICE_ATTR_RO(reset_reason);
> +static DEVICE_ATTR_RW(repower_policy);
> +
> +DEFINE_MCU_DEBUG_ATTR(firmware_version, REG_MCU_FIRMWARE_VERSION, "0x%02x");
> +DEFINE_MCU_DEBUG_ATTR(pcb_version, REG_PCB_VERSION, "0x%02x");
> +DEFINE_MCU_DEBUG_ATTR(board_type, REG_BOARD_TYPE, "0x%02x");
> +DEFINE_MCU_DEBUG_ATTR(mcu_type, REG_MCU_TYPE, "%d");
> +
> +static struct attribute *sg2042_mcu_attrs[] = {
> +	&dev_attr_reset_count.attr,
> +	&dev_attr_uptime.attr,
> +	&dev_attr_reset_reason.attr,
> +	&dev_attr_repower_policy.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group sg2042_mcu_attr_group = {
> +	.attrs	= sg2042_mcu_attrs,
> +};
> +
> +static const struct attribute_group *sg2042_mcu_groups[] = {
> +	&sg2042_mcu_attr_group,
> +	NULL
> +};
> +
> +static const struct hwmon_channel_info * const sg2042_mcu_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_CRIT |
> +					HWMON_T_CRIT_HYST,
> +				 HWMON_T_INPUT),
> +	NULL
> +};
> +
> +static int sg2042_mcu_read(struct device *dev,
> +			   enum hwmon_sensor_types type,
> +			   u32 attr, int channel, long *val)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	int tmp;
> +	u8 reg;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		reg = channel ? REG_BOARD_TEMP : REG_SOC_TEMP;
> +		break;
> +	case hwmon_temp_crit:
> +		reg = REG_CRITICAL_TEMP;
> +		break;
> +	case hwmon_temp_crit_hyst:
> +		reg = REG_REPOWER_TEMP;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	tmp = i2c_smbus_read_byte_data(mcu->client, reg);
> +	if (tmp < 0)
> +		return tmp;
> +	*val = tmp * 1000;
> +
> +	return 0;
> +}
> +
> +static int sg2042_mcu_write(struct device *dev,
> +			    enum hwmon_sensor_types type,
> +			    u32 attr, int channel, long val)
> +{
> +	struct sg2042_mcu_data *mcu = dev_get_drvdata(dev);
> +	int temp = val / 1000;
> +	int hyst_temp, crit_temp;
> +	u8 reg;
> +
> +	temp = clamp_val(temp, 0, MCU_POWER_MAX);
> +
> +	guard(mutex)(&mcu->mutex);
> +
> +	switch (attr) {
> +	case hwmon_temp_crit:
> +		hyst_temp = i2c_smbus_read_byte_data(mcu->client,
> +						     REG_REPOWER_TEMP);
> +		if (hyst_temp < 0)
> +			return hyst_temp;
> +
> +		crit_temp = temp;
> +		reg = REG_CRITICAL_TEMP;
> +		break;
> +	case hwmon_temp_crit_hyst:
> +		crit_temp = i2c_smbus_read_byte_data(mcu->client,
> +						     REG_CRITICAL_TEMP);
> +		if (crit_temp < 0)
> +			return crit_temp;
> +
> +		hyst_temp = temp;
> +		reg = REG_REPOWER_TEMP;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/*
> +	 * ensure hyst_temp is smaller to avoid MCU from
> +	 * keeping triggering repower event.
> +	 */
> +	if (crit_temp < hyst_temp)
> +		return -EINVAL;
> +
> +	return i2c_smbus_write_byte_data(mcu->client, reg, temp);
> +}
> +
> +static umode_t sg2042_mcu_is_visible(const void *_data,
> +				     enum hwmon_sensor_types type,
> +				     u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			return 0444;
> +		case hwmon_temp_crit:
> +		case hwmon_temp_crit_hyst:
> +			if (channel == 0)
> +				return 0664;

0644, please. Always. We don't permit group write access for sysfs
attributes.



> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +			break;
> +	}
> +	return 0;
> +}
> +
> +static const struct hwmon_ops sg2042_mcu_ops = {
> +	.is_visible = sg2042_mcu_is_visible,
> +	.read = sg2042_mcu_read,
> +	.write = sg2042_mcu_write,
> +};
> +
> +static const struct hwmon_chip_info sg2042_mcu_chip_info = {
> +	.ops = &sg2042_mcu_ops,
> +	.info = sg2042_mcu_info,
> +};
> +
> +static void sg2042_mcu_debugfs_init(struct sg2042_mcu_data *mcu,
> +				    struct device *dev)
> +{
> +	mcu->debugfs = debugfs_create_dir(dev_name(dev), sgmcu_debugfs);
> +
> +	debugfs_create_file("firmware_version", 0444, mcu->debugfs,
> +			    mcu, &firmware_version_fops);
> +	debugfs_create_file("pcb_version", 0444, mcu->debugfs, mcu,
> +			    &pcb_version_fops);
> +	debugfs_create_file("mcu_type", 0444, mcu->debugfs, mcu,
> +			    &mcu_type_fops);
> +	debugfs_create_file("board_type", 0444, mcu->debugfs, mcu,
> +			    &board_type_fops);
> +}
> +
> +static int sg2042_mcu_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct sg2042_mcu_data *mcu;
> +	struct device *hwmon_dev;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> +						I2C_FUNC_SMBUS_BLOCK_DATA))
> +		return -ENODEV;
> +
> +	mcu = devm_kmalloc(dev, sizeof(*mcu), GFP_KERNEL);
> +	if (!mcu)
> +		return -ENOMEM;
> +
> +	mutex_init(&mcu->mutex);
> +	mcu->client = client;
> +
> +	i2c_set_clientdata(client, mcu);
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev, "sg2042_mcu",
> +							 mcu,
> +							 &sg2042_mcu_chip_info,
> +							 NULL);
> +	if (IS_ERR(hwmon_dev))
> +		return PTR_ERR(hwmon_dev);
> +
> +	sg2042_mcu_debugfs_init(mcu, dev);
> +
> +	return 0;
> +}
> +
> +static void sg2042_mcu_i2c_remove(struct i2c_client *client)
> +{
> +	struct sg2042_mcu_data *mcu = i2c_get_clientdata(client);
> +
> +	debugfs_remove_recursive(mcu->debugfs);
> +}
> +
> +static const struct i2c_device_id sg2042_mcu_id[] = {
> +	{ "sg2042-hwmon-mcu", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, sg2042_mcu_id);
> +
> +static const struct of_device_id sg2042_mcu_of_id[] = {
> +	{ .compatible = "sophgo,sg2042-hwmon-mcu" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sg2042_mcu_of_id);
> +
> +static struct i2c_driver sg2042_mcu_driver = {
> +	.driver = {
> +		.name = "sg2042-mcu",
> +		.of_match_table = sg2042_mcu_of_id,
> +		.dev_groups = sg2042_mcu_groups,
> +	},
> +	.probe = sg2042_mcu_i2c_probe,
> +	.remove = sg2042_mcu_i2c_remove,
> +	.id_table = sg2042_mcu_id,
> +};
> +
> +static int __init sg2042_mcu_init(void)
> +{
> +	sgmcu_debugfs = debugfs_create_dir("sg2042-mcu", NULL);
> +	return i2c_add_driver(&sg2042_mcu_driver);
> +}
> +
> +static void __exit sg2042_mcu_exit(void)
> +{
> +	debugfs_remove_recursive(sgmcu_debugfs);
> +	i2c_del_driver(&sg2042_mcu_driver);
> +}
> +
> +module_init(sg2042_mcu_init);
> +module_exit(sg2042_mcu_exit);
> +
> +MODULE_AUTHOR("Inochi Amaoto <inochiama@outlook.com>");
> +MODULE_DESCRIPTION("MCU I2C driver for SG2042 soc platform");
> +MODULE_LICENSE("GPL");

