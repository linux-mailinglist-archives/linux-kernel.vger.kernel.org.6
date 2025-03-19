Return-Path: <linux-kernel+bounces-567960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 238D1A68C6F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB60189FFF3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A1425525F;
	Wed, 19 Mar 2025 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TvkYPLPQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C4321D584;
	Wed, 19 Mar 2025 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386209; cv=none; b=e9VnGyYJW70Dhf0oX6InC6SDB7byJsELMbK6XVa3TzPN4P1M5jasp1j4hViHqtjIqoi7YPrRYU9c2mQ2byG5ZwgB/CpC3VCdLxnc6XAmqdcbSUjv5nYJHvLbdHu/U8FUsooo20mrztF2GxQqKfN89oTEhiqbqLircFGKJo4/GFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386209; c=relaxed/simple;
	bh=em9o8A76bY+W2OHmCuLfCUNb+oqYx4ZJvq7hslOBaMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItMVT9DhENlZ2XDKSGQ8yLq7Oy0M5Z0n49MLWABFVQzZXDUCd80D8h/PDAVZU1Zqlv6VuOXOA4lexDND5Cc2aDbHtErLtzpeIDVV6TWjetI4k9O2Ajkw9nD8CW9646kykGsOKKGWIe1pYTvGYzm+z6m3Yof4BxCuRLSpP3KrBy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TvkYPLPQ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742386208; x=1773922208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=em9o8A76bY+W2OHmCuLfCUNb+oqYx4ZJvq7hslOBaMs=;
  b=TvkYPLPQhWQzjyw2qJ/cd8x2rxOKZEgI0FFijy5EgWaB6XfHnxJVTg5U
   72l3oYbLJ0cgRBoQIXK1xi4eu2vvRvyM1PQvamzmEwUKZnIqAuBztUc7q
   nW/Z6BXFQeoVmnDoBb+E+HyNSp1DCUmoxg0sPNy55hap969HRrcfC/bkR
   mXHvCir2Qjq+sVlhOK1hc4BVQS6RiZ3CSSv3Ij/2J8rQvfrkhmao/L2da
   JNrk5SlVyvP+jKULlIdJexzABa0u2d3U3HEhAfpZbSVVJ/IdsfjGW6oFV
   ETw6B2EqzWxlzBc65kcP8mQ1/TDcsJmLrEk0cuxKh7sUKoH2VTe64qpQU
   A==;
X-CSE-ConnectionGUID: VdDt2Bi4Q+SIyXUbbh7TWA==
X-CSE-MsgGUID: kBWJ/0OxQW+0RPZWLXrqCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="47350311"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="47350311"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 05:10:07 -0700
X-CSE-ConnectionGUID: 8xkm5MhIR4mI8SzduJuxHQ==
X-CSE-MsgGUID: WQqWGG9oRFyVLN9xjIKC1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="122524516"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa010.jf.intel.com with SMTP; 19 Mar 2025 05:09:59 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 19 Mar 2025 14:09:58 +0200
Date: Wed, 19 Mar 2025 14:09:58 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v9] usb: typec: ucsi: add Huawei Matebook E Go ucsi driver
Message-ID: <Z9q0Fgf5_fXcbiMi@kuha.fi.intel.com>
References: <20250316094357.462022-1-mitltlatltl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316094357.462022-1-mitltlatltl@gmail.com>

On Sun, Mar 16, 2025 at 05:43:55PM +0800, Pengyu Luo wrote:
> The Huawei Matebook E Go tablet implements the UCSI interface in the
> onboard EC. Add the glue driver to interface with the platform's UCSI
> implementation.
> 
> This driver is inspired by the following drivers:
> 	drivers/usb/typec/ucsi/ucsi_yoga_c630.c
> 	drivers/usb/typec/ucsi/ucsi_glink.c
> 	drivers/soc/qcom/pmic_glink_altmode.c
> 
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> base-commit: 613af589b566093ce7388bf3202fca70d742c166
> ---
> Changes in v9:
> - rebased on tag next-20250313
> - remove base-commit from changelog (Greg)
> - Link to v8: https://lore.kernel.org/linux-usb/20250308105356.53808-1-mitltlatltl@gmail.com
> 
> Changes in v8:
> - since the base driver was mergerd by Ilpo, continue the UCSI driver
> - rebased on tag next-20250307
> - add the missing newline (Heikki)
> - comment the spin lock (Heikki)
> - Link to v7: https://lore.kernel.org/linux-arm-msm/20250214180656.28599-1-mitltlatltl@gmail.com
> 
> Changes in v7:
> - rebased on tag next-20250214
> - fix Kconfig, this module depends on HWMON (kernel test robot)
> - Link to v6: https://lore.kernel.org/linux-arm-msm/20250123152559.52449-1-mitltlatltl@gmail.com
> 
> Changes in v6 RESEND:
> - add Reviewed-by tag (Ilpo)
> - remove extra line
> - rebased on tag next-20250131
> - Link to v6: https://lore.kernel.org/linux-arm-msm/20250123152559.52449-1-mitltlatltl@gmail.com
> 
> Changes in v6:
> - refactor one ternary operator expression (Ilpo)
> - replace one expression with &= (Ilpo)
> - use devm_mutex_init() instead of mutex_init() (Ilpo)
> - add Reviewed-by tag for devicetree (Konrad)
> - add explicit cast (void *) to fix warnings when compiling
> - rebased on tag next-20250123
> - Link to v5: https://lore.kernel.org/linux-arm-msm/20250117140348.180681-1-mitltlatltl@gmail.com
> 
> Changes in v5 RESEND:
> - rebased on tag next-20250120
> - Link to v5: https://lore.kernel.org/linux-arm-msm/20250117140348.180681-1-mitltlatltl@gmail.com
> 
> Changes in v5:
> - handle return code of i2c_transfer() (Bryan)
> - rename threshold validatition function (Bryan)
> - add enumerates and defines for registers (Bryan)
> - drop extra line in header (Heikki)
> - add Reviewed-by tag for devicetree (Krzysztof)
> - Link to v4: https://lore.kernel.org/linux-arm-msm/20250116111559.83641-1-mitltlatltl@gmail.com
> 
> Changes in v4:
> - use new API to register hwmon device instead of the deprecated one. (Guenter)
> - add Reviewed-by tag for dt-binding (Krzysztof)
> - drop unnecessary header (Ilpo)
> - use guard mutex (Ilpo)
> - improve comments and naming (Ilpo)
> - add a shallow copy version of extr_resp() (Ilpo)
> - add functions to handle resp and req whose size is 1
> - drop PSY and UCSI subdrivers, commit them once the base driver is upstreamed
> - Link to v3: https://lore.kernel.org/linux-arm-msm/20250113175049.590511-1-mitltlatltl@gmail.com
> 
> Changes in v3:
> - Link to v2: https://lore.kernel.org/linux-arm-msm/20250105174159.227831-1-mitltlatltl@gmail.com
> 
> dt-binding:
> - drop generic compatibles. (Krzysztof)
> - remove '+' to use literal block style. (Krzysztof)
> 
> ec:
> - take struct gaokun_ucsi_reg as parameter (Heikki)
> - add almost all kernel doc comments (Krzysztof, Heikki)
> 
> ucsi:
> - drop unnecessary ucsi quirks (Dmitry)
> - add UCSI v1.0 to ucsi.h (Heikki)
> - use gaokun_ucsi_read_cci() to read cci directly (Heikki)
> - drop unnecessary gaokun_ucsi_get_port_num (Heikki)
> - rename member port_num => num_ports (Heikki)
> - fix completion, forgot to signal threads in previous version
> 
> dt:
> - fix indentation (Konrad)
> - add a link between role switch and connector
> 
> Changes in v2:
> - Link to v1: https://lore.kernel.org/linux-arm-msm/20241227171353.404432-1-mitltlatltl@gmail.com
> 
> global:
> - drop qcom's products(i.e. sc8180x, sx8280xp) everywhere, use 'product'-based instead(Krzysztof, Bryan)
> - drop Cc Nikita Travkin, we had discussed the device in PM.
> - add myself to MAINTAINERS
> 
> dt-binding:
> - fix building (Rob Herring (Arm))
> - remove unnecessary code (Krzysztof)
> - add bugzilla documentation, insights of gaokun(see [1] or patch[1/5]) (Krzysztof, Aiqun(Maria))
> - explain the difference between PMIC GLink and gaokun EC (Aiqun(Maria))
> 
> ec:
> - use Linux style comments (Krzysztof)
> - add a comment for mutex lock (Krzysztof)
> - add more kerneldoc for exported functions (Krzysztof)
> - eliminate unnecessary conditions (Bryan)
> - add a macro for check thresholds (Bryan)
> - improve English (Bryan)
> - use existing sysfs interface(hwmon, psy) whenever possible (Krzysztof)
> - use __le16 and related endianess conversion function for temp data (Ilpo)
> - drop alias for packet headers (Ilpo)
> - avoid hardcoding i2c msgs size (Aiqun(Maria))
> - add a comment for the sleep in critial region (Bryan, Aiqun(Maria))
> - use macro to construct packet (Bryan, Aiqun(Maria))
> 
> wmi:
> - dropped
> 
> ucsi:
> - reorder headers (Bryan)
> - a comment for the orientation map macro (Bryan)
> - make mux mode map more explicit(minus six is very clear now) (Bryan, Dmitry)
> - handle port update exceptions return (Bryan)
> - a comment for the UCSI quirks (Dmitry)
> - use the inline hint for the short register function (Dmitry)
> - use the API with delay to handle register instead of a direct sleep (Bryan)
> - handle unfinished initialization early
> 
> psy:
> - add charging related sysfs to here (Krzysztof, Dmitry)
> - document ABI for power_supply sysfs (Krzysztof)
> - drop charging threshold, use smart charging instead
> 
> dts:
> - correct indentation, properties' order. (Konrad)
> ---
>  MAINTAINERS                                 |   1 +
>  drivers/usb/typec/ucsi/Kconfig              |  11 +
>  drivers/usb/typec/ucsi/Makefile             |   1 +
>  drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c | 522 ++++++++++++++++++++
>  4 files changed, 535 insertions(+)
>  create mode 100644 drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b20efd24a..1b06ba3aa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10884,6 +10884,7 @@ M:	Pengyu Luo <mitltlatltl@gmail.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/platform/huawei,gaokun-ec.yaml
>  F:	drivers/platform/arm64/huawei-gaokun-ec.c
> +F:	drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
>  F:	include/linux/platform_data/huawei-gaokun-ec.h
>  
>  HUGETLB SUBSYSTEM
> diff --git a/drivers/usb/typec/ucsi/Kconfig b/drivers/usb/typec/ucsi/Kconfig
> index 75559601f..e94956d27 100644
> --- a/drivers/usb/typec/ucsi/Kconfig
> +++ b/drivers/usb/typec/ucsi/Kconfig
> @@ -91,4 +91,15 @@ config UCSI_LENOVO_YOGA_C630
>  	  To compile the driver as a module, choose M here: the module will be
>  	  called ucsi_yoga_c630.
>  
> +config UCSI_HUAWEI_GAOKUN
> +	tristate "UCSI Interface Driver for Huawei Matebook E Go"
> +	depends on EC_HUAWEI_GAOKUN
> +	select DRM_AUX_HPD_BRIDGE
> +	help
> +	  This driver enables UCSI support on the Huawei Matebook E Go tablet,
> +	  which is a sc8280xp-based 2-in-1 tablet.
> +
> +	  To compile the driver as a module, choose M here: the module will be
> +	  called ucsi_huawei_gaokun.
> +
>  endif
> diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
> index be98a8791..dbc571763 100644
> --- a/drivers/usb/typec/ucsi/Makefile
> +++ b/drivers/usb/typec/ucsi/Makefile
> @@ -23,3 +23,4 @@ obj-$(CONFIG_UCSI_STM32G0)		+= ucsi_stm32g0.o
>  obj-$(CONFIG_UCSI_PMIC_GLINK)		+= ucsi_glink.o
>  obj-$(CONFIG_CROS_EC_UCSI)		+= cros_ec_ucsi.o
>  obj-$(CONFIG_UCSI_LENOVO_YOGA_C630)	+= ucsi_yoga_c630.o
> +obj-$(CONFIG_UCSI_HUAWEI_GAOKUN)	+= ucsi_huawei_gaokun.o
> diff --git a/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> new file mode 100644
> index 000000000..344aa7aea
> --- /dev/null
> +++ b/drivers/usb/typec/ucsi/ucsi_huawei_gaokun.c
> @@ -0,0 +1,522 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ucsi-huawei-gaokun - A UCSI driver for HUAWEI Matebook E Go
> + *
> + * Copyright (C) 2024-2025 Pengyu Luo <mitltlatltl@gmail.com>
> + */
> +
> +#include <drm/bridge/aux-bridge.h>
> +#include <linux/auxiliary_bus.h>
> +#include <linux/bitops.h>
> +#include <linux/completion.h>
> +#include <linux/container_of.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/of.h>
> +#include <linux/platform_data/huawei-gaokun-ec.h>
> +#include <linux/string.h>
> +#include <linux/usb/pd_vdo.h>
> +#include <linux/usb/typec_altmode.h>
> +#include <linux/usb/typec_dp.h>
> +#include <linux/workqueue_types.h>
> +
> +#include "ucsi.h"
> +
> +#define EC_EVENT_UCSI	0x21
> +#define EC_EVENT_USB	0x22
> +
> +#define GAOKUN_CCX_MASK		GENMASK(1, 0)
> +#define GAOKUN_MUX_MASK		GENMASK(3, 2)
> +
> +#define GAOKUN_DPAM_MASK	GENMASK(3, 0)
> +#define GAOKUN_HPD_STATE_MASK	BIT(4)
> +#define GAOKUN_HPD_IRQ_MASK	BIT(5)
> +
> +#define GET_IDX(updt) (ffs(updt) - 1)
> +
> +#define CCX_TO_ORI(ccx) (++(ccx) % 3) /* convert ccx to enum typec_orientation */
> +
> +/* Configuration Channel Extension */
> +enum gaokun_ucsi_ccx {
> +	USBC_CCX_NORMAL,
> +	USBC_CCX_REVERSE,
> +	USBC_CCX_NONE,
> +};
> +
> +enum gaokun_ucsi_mux {
> +	USBC_MUX_NONE,
> +	USBC_MUX_USB_2L,
> +	USBC_MUX_DP_4L,
> +	USBC_MUX_USB_DP,
> +};
> +
> +/* based on pmic_glink_altmode_pin_assignment */
> +enum gaokun_ucsi_dpam_pan {	/* DP Alt Mode Pin Assignments */
> +	USBC_DPAM_PAN_NONE,
> +	USBC_DPAM_PAN_A,	/* Not supported after USB Type-C Standard v1.0b */
> +	USBC_DPAM_PAN_B,	/* Not supported after USB Type-C Standard v1.0b */
> +	USBC_DPAM_PAN_C,	/* USBC_DPAM_PAN_C_REVERSE - 6 */
> +	USBC_DPAM_PAN_D,
> +	USBC_DPAM_PAN_E,
> +	USBC_DPAM_PAN_F,	/* Not supported after USB Type-C Standard v1.0b */
> +	USBC_DPAM_PAN_A_REVERSE,/* Not supported after USB Type-C Standard v1.0b */
> +	USBC_DPAM_PAN_B_REVERSE,/* Not supported after USB Type-C Standard v1.0b */
> +	USBC_DPAM_PAN_C_REVERSE,
> +	USBC_DPAM_PAN_D_REVERSE,
> +	USBC_DPAM_PAN_E_REVERSE,
> +	USBC_DPAM_PAN_F_REVERSE,/* Not supported after USB Type-C Standard v1.0b */
> +};
> +
> +struct gaokun_ucsi_reg {
> +	u8 num_ports;
> +	u8 port_updt;
> +	u8 port_data[4];
> +	u8 checksum;
> +	u8 reserved;
> +} __packed;
> +
> +struct gaokun_ucsi_port {
> +	struct completion usb_ack;
> +	spinlock_t lock; /* serializing port resource access */
> +
> +	struct gaokun_ucsi *ucsi;
> +	struct auxiliary_device *bridge;
> +
> +	int idx;
> +	enum gaokun_ucsi_ccx ccx;
> +	enum gaokun_ucsi_mux mux;
> +	u8 mode;
> +	u16 svid;
> +	u8 hpd_state;
> +	u8 hpd_irq;
> +};
> +
> +struct gaokun_ucsi {
> +	struct gaokun_ec *ec;
> +	struct ucsi *ucsi;
> +	struct gaokun_ucsi_port *ports;
> +	struct device *dev;
> +	struct delayed_work work;
> +	struct notifier_block nb;
> +	u16 version;
> +	u8 num_ports;
> +};
> +
> +/* -------------------------------------------------------------------------- */
> +/* For UCSI */
> +
> +static int gaokun_ucsi_read_version(struct ucsi *ucsi, u16 *version)
> +{
> +	struct gaokun_ucsi *uec = ucsi_get_drvdata(ucsi);
> +
> +	*version = uec->version;
> +
> +	return 0;
> +}
> +
> +static int gaokun_ucsi_read_cci(struct ucsi *ucsi, u32 *cci)
> +{
> +	struct gaokun_ucsi *uec = ucsi_get_drvdata(ucsi);
> +	u8 buf[GAOKUN_UCSI_READ_SIZE];
> +	int ret;
> +
> +	ret = gaokun_ec_ucsi_read(uec->ec, buf);
> +	if (ret)
> +		return ret;
> +
> +	memcpy(cci, buf, sizeof(*cci));
> +
> +	return 0;
> +}
> +
> +static int gaokun_ucsi_read_message_in(struct ucsi *ucsi,
> +				       void *val, size_t val_len)
> +{
> +	struct gaokun_ucsi *uec = ucsi_get_drvdata(ucsi);
> +	u8 buf[GAOKUN_UCSI_READ_SIZE];
> +	int ret;
> +
> +	ret = gaokun_ec_ucsi_read(uec->ec, buf);
> +	if (ret)
> +		return ret;
> +
> +	memcpy(val, buf + GAOKUN_UCSI_CCI_SIZE,
> +	       min(val_len, GAOKUN_UCSI_MSGI_SIZE));
> +
> +	return 0;
> +}
> +
> +static int gaokun_ucsi_async_control(struct ucsi *ucsi, u64 command)
> +{
> +	struct gaokun_ucsi *uec = ucsi_get_drvdata(ucsi);
> +	u8 buf[GAOKUN_UCSI_WRITE_SIZE] = {};
> +
> +	memcpy(buf, &command, sizeof(command));
> +
> +	return gaokun_ec_ucsi_write(uec->ec, buf);
> +}
> +
> +static void gaokun_ucsi_update_connector(struct ucsi_connector *con)
> +{
> +	struct gaokun_ucsi *uec = ucsi_get_drvdata(con->ucsi);
> +
> +	if (con->num > uec->num_ports)
> +		return;
> +
> +	con->typec_cap.orientation_aware = true;
> +}
> +
> +static void gaokun_set_orientation(struct ucsi_connector *con,
> +				   struct gaokun_ucsi_port *port)
> +{
> +	enum gaokun_ucsi_ccx ccx;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	ccx = port->ccx;
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	typec_set_orientation(con->port, CCX_TO_ORI(ccx));
> +}
> +
> +static void gaokun_ucsi_connector_status(struct ucsi_connector *con)
> +{
> +	struct gaokun_ucsi *uec = ucsi_get_drvdata(con->ucsi);
> +	int idx;
> +
> +	idx = con->num - 1;
> +	if (con->num > uec->num_ports) {
> +		dev_warn(uec->dev, "set orientation out of range: con%d\n", idx);
> +		return;
> +	}
> +
> +	gaokun_set_orientation(con, &uec->ports[idx]);
> +}
> +
> +const struct ucsi_operations gaokun_ucsi_ops = {
> +	.read_version = gaokun_ucsi_read_version,
> +	.read_cci = gaokun_ucsi_read_cci,
> +	.read_message_in = gaokun_ucsi_read_message_in,
> +	.sync_control = ucsi_sync_control_common,
> +	.async_control = gaokun_ucsi_async_control,
> +	.update_connector = gaokun_ucsi_update_connector,
> +	.connector_status = gaokun_ucsi_connector_status,
> +};
> +
> +/* -------------------------------------------------------------------------- */
> +/* For Altmode */
> +
> +static void gaokun_ucsi_port_update(struct gaokun_ucsi_port *port,
> +				    const u8 *port_data)
> +{
> +	struct gaokun_ucsi *uec = port->ucsi;
> +	int offset = port->idx * 2; /* every port has 2 Bytes data */
> +	unsigned long flags;
> +	u8 dcc, ddi;
> +
> +	dcc = port_data[offset];
> +	ddi = port_data[offset + 1];
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	port->ccx = FIELD_GET(GAOKUN_CCX_MASK, dcc);
> +	port->mux = FIELD_GET(GAOKUN_MUX_MASK, dcc);
> +	port->mode = FIELD_GET(GAOKUN_DPAM_MASK, ddi);
> +	port->hpd_state = FIELD_GET(GAOKUN_HPD_STATE_MASK, ddi);
> +	port->hpd_irq = FIELD_GET(GAOKUN_HPD_IRQ_MASK, ddi);
> +
> +	/* Mode and SVID are unused; keeping them to make things clearer */
> +	switch (port->mode) {
> +	case USBC_DPAM_PAN_C:
> +	case USBC_DPAM_PAN_C_REVERSE:
> +		port->mode = DP_PIN_ASSIGN_C; /* correct it for usb later */
> +		break;
> +	case USBC_DPAM_PAN_D:
> +	case USBC_DPAM_PAN_D_REVERSE:
> +		port->mode = DP_PIN_ASSIGN_D;
> +		break;
> +	case USBC_DPAM_PAN_E:
> +	case USBC_DPAM_PAN_E_REVERSE:
> +		port->mode = DP_PIN_ASSIGN_E;
> +		break;
> +	case USBC_DPAM_PAN_NONE:
> +		port->mode = TYPEC_STATE_SAFE;
> +		break;
> +	default:
> +		dev_warn(uec->dev, "unknown mode %d\n", port->mode);
> +		break;
> +	}
> +
> +	switch (port->mux) {
> +	case USBC_MUX_NONE:
> +		port->svid = 0;
> +		break;
> +	case USBC_MUX_USB_2L:
> +		port->svid = USB_SID_PD;
> +		port->mode = TYPEC_STATE_USB; /* same as PAN_C, correct it */
> +		break;
> +	case USBC_MUX_DP_4L:
> +	case USBC_MUX_USB_DP:
> +		port->svid = USB_SID_DISPLAYPORT;
> +		break;
> +	default:
> +		dev_warn(uec->dev, "unknown mux state %d\n", port->mux);
> +		break;
> +	}
> +
> +	spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static int gaokun_ucsi_refresh(struct gaokun_ucsi *uec)
> +{
> +	struct gaokun_ucsi_reg ureg;
> +	int ret, idx;
> +
> +	ret = gaokun_ec_ucsi_get_reg(uec->ec, &ureg);
> +	if (ret)
> +		return GAOKUN_UCSI_NO_PORT_UPDATE;
> +
> +	uec->num_ports = ureg.num_ports;
> +	idx = GET_IDX(ureg.port_updt);
> +
> +	if (idx < 0 || idx >= ureg.num_ports)
> +		return GAOKUN_UCSI_NO_PORT_UPDATE;
> +
> +	gaokun_ucsi_port_update(&uec->ports[idx], ureg.port_data);
> +	return idx;
> +}
> +
> +static void gaokun_ucsi_handle_altmode(struct gaokun_ucsi_port *port)
> +{
> +	struct gaokun_ucsi *uec = port->ucsi;
> +	int idx = port->idx;
> +
> +	if (idx >= uec->ucsi->cap.num_connectors) {
> +		dev_warn(uec->dev, "altmode port out of range: %d\n", idx);
> +		return;
> +	}
> +
> +	/* UCSI callback .connector_status() have set orientation */
> +	if (port->bridge)
> +		drm_aux_hpd_bridge_notify(&port->bridge->dev,
> +					  port->hpd_state ?
> +					  connector_status_connected :
> +					  connector_status_disconnected);
> +
> +	gaokun_ec_ucsi_pan_ack(uec->ec, port->idx);
> +}
> +
> +static void gaokun_ucsi_altmode_notify_ind(struct gaokun_ucsi *uec)
> +{
> +	int idx;
> +
> +	if (!uec->ucsi->connector) { /* slow to register */
> +		dev_err_ratelimited(uec->dev, "ucsi connector is not initialized yet\n");
> +		return;
> +	}
> +
> +	idx = gaokun_ucsi_refresh(uec);
> +	if (idx == GAOKUN_UCSI_NO_PORT_UPDATE)
> +		gaokun_ec_ucsi_pan_ack(uec->ec, idx); /* ack directly if no update */
> +	else
> +		gaokun_ucsi_handle_altmode(&uec->ports[idx]);
> +}
> +
> +/*
> + * When inserting, 2 UCSI events(connector change) are followed by USB events.
> + * If we received one USB event, that means USB events are not blocked, so we
> + * can complelte for all ports, and we should signal all events.
> + */
> +static void gaokun_ucsi_complete_usb_ack(struct gaokun_ucsi *uec)
> +{
> +	struct gaokun_ucsi_port *port;
> +	int idx = 0;
> +
> +	while (idx < uec->num_ports) {
> +		port = &uec->ports[idx++];
> +		if (!completion_done(&port->usb_ack))
> +			complete_all(&port->usb_ack);
> +	}
> +}
> +
> +/*
> + * USB event is necessary for enabling altmode, the event should follow
> + * UCSI event, if not after timeout(this notify may be disabled somehow),
> + * then force to enable altmode.
> + */
> +static void gaokun_ucsi_handle_no_usb_event(struct gaokun_ucsi *uec, int idx)
> +{
> +	struct gaokun_ucsi_port *port;
> +
> +	port = &uec->ports[idx];
> +	if (!wait_for_completion_timeout(&port->usb_ack, 2 * HZ)) {
> +		dev_warn(uec->dev, "No USB EVENT, triggered by UCSI EVENT");
> +		gaokun_ucsi_altmode_notify_ind(uec);
> +	}
> +}
> +
> +static int gaokun_ucsi_notify(struct notifier_block *nb,
> +			      unsigned long action, void *data)
> +{
> +	u32 cci;
> +	struct gaokun_ucsi *uec = container_of(nb, struct gaokun_ucsi, nb);
> +
> +	switch (action) {
> +	case EC_EVENT_USB:
> +		gaokun_ucsi_complete_usb_ack(uec);
> +		gaokun_ucsi_altmode_notify_ind(uec);
> +		return NOTIFY_OK;
> +
> +	case EC_EVENT_UCSI:
> +		gaokun_ucsi_read_cci(uec->ucsi, &cci);
> +		ucsi_notify_common(uec->ucsi, cci);
> +		if (UCSI_CCI_CONNECTOR(cci))
> +			gaokun_ucsi_handle_no_usb_event(uec, UCSI_CCI_CONNECTOR(cci) - 1);
> +
> +		return NOTIFY_OK;
> +
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +}
> +
> +static int gaokun_ucsi_ports_init(struct gaokun_ucsi *uec)
> +{
> +	struct gaokun_ucsi_port *ucsi_port;
> +	struct gaokun_ucsi_reg ureg = {};
> +	struct device *dev = uec->dev;
> +	struct fwnode_handle *fwnode;
> +	int i, ret, num_ports;
> +	u32 port;
> +
> +	gaokun_ec_ucsi_get_reg(uec->ec, &ureg);
> +	num_ports = ureg.num_ports;
> +	uec->ports = devm_kcalloc(dev, num_ports, sizeof(*uec->ports),
> +				  GFP_KERNEL);
> +	if (!uec->ports)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_ports; ++i) {
> +		ucsi_port = &uec->ports[i];
> +		ucsi_port->ccx = USBC_CCX_NONE;
> +		ucsi_port->idx = i;
> +		ucsi_port->ucsi = uec;
> +		init_completion(&ucsi_port->usb_ack);
> +		spin_lock_init(&ucsi_port->lock);
> +	}
> +
> +	device_for_each_child_node(dev, fwnode) {
> +		ret = fwnode_property_read_u32(fwnode, "reg", &port);
> +		if (ret < 0) {
> +			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
> +			fwnode_handle_put(fwnode);
> +			return ret;
> +		}
> +
> +		if (port >= num_ports) {
> +			dev_warn(dev, "invalid connector number %d, ignoring\n", port);
> +			continue;
> +		}
> +
> +		ucsi_port = &uec->ports[port];
> +		ucsi_port->bridge = devm_drm_dp_hpd_bridge_alloc(dev, to_of_node(fwnode));
> +		if (IS_ERR(ucsi_port->bridge)) {
> +			fwnode_handle_put(fwnode);
> +			return PTR_ERR(ucsi_port->bridge);
> +		}
> +	}
> +
> +	for (i = 0; i < num_ports; i++) {
> +		if (!uec->ports[i].bridge)
> +			continue;
> +
> +		ret = devm_drm_dp_hpd_bridge_add(dev, uec->ports[i].bridge);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void gaokun_ucsi_register_worker(struct work_struct *work)
> +{
> +	struct gaokun_ucsi *uec;
> +	struct ucsi *ucsi;
> +	int ret;
> +
> +	uec = container_of(work, struct gaokun_ucsi, work.work);
> +	ucsi = uec->ucsi;
> +
> +	ret = gaokun_ec_register_notify(uec->ec, &uec->nb);
> +	if (ret) {
> +		dev_err_probe(ucsi->dev, ret, "notifier register failed\n");
> +		return;
> +	}
> +
> +	ret = ucsi_register(ucsi);
> +	if (ret)
> +		dev_err_probe(ucsi->dev, ret, "ucsi register failed\n");
> +}
> +
> +static int gaokun_ucsi_probe(struct auxiliary_device *adev,
> +			     const struct auxiliary_device_id *id)
> +{
> +	struct gaokun_ec *ec = adev->dev.platform_data;
> +	struct device *dev = &adev->dev;
> +	struct gaokun_ucsi *uec;
> +	int ret;
> +
> +	uec = devm_kzalloc(dev, sizeof(*uec), GFP_KERNEL);
> +	if (!uec)
> +		return -ENOMEM;
> +
> +	uec->ec = ec;
> +	uec->dev = dev;
> +	uec->version = UCSI_VERSION_1_0;
> +	uec->nb.notifier_call = gaokun_ucsi_notify;
> +
> +	INIT_DELAYED_WORK(&uec->work, gaokun_ucsi_register_worker);
> +
> +	ret = gaokun_ucsi_ports_init(uec);
> +	if (ret)
> +		return ret;
> +
> +	uec->ucsi = ucsi_create(dev, &gaokun_ucsi_ops);
> +	if (IS_ERR(uec->ucsi))
> +		return PTR_ERR(uec->ucsi);
> +
> +	ucsi_set_drvdata(uec->ucsi, uec);
> +	auxiliary_set_drvdata(adev, uec);
> +
> +	/* EC can't handle UCSI properly in the early stage */
> +	schedule_delayed_work(&uec->work, 3 * HZ);
> +
> +	return 0;
> +}
> +
> +static void gaokun_ucsi_remove(struct auxiliary_device *adev)
> +{
> +	struct gaokun_ucsi *uec = auxiliary_get_drvdata(adev);
> +
> +	gaokun_ec_unregister_notify(uec->ec, &uec->nb);
> +	ucsi_unregister(uec->ucsi);
> +	ucsi_destroy(uec->ucsi);
> +}
> +
> +static const struct auxiliary_device_id gaokun_ucsi_id_table[] = {
> +	{ .name = GAOKUN_MOD_NAME "." GAOKUN_DEV_UCSI, },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(auxiliary, gaokun_ucsi_id_table);
> +
> +static struct auxiliary_driver gaokun_ucsi_driver = {
> +	.name = GAOKUN_DEV_UCSI,
> +	.id_table = gaokun_ucsi_id_table,
> +	.probe = gaokun_ucsi_probe,
> +	.remove = gaokun_ucsi_remove,
> +};
> +
> +module_auxiliary_driver(gaokun_ucsi_driver);
> +
> +MODULE_DESCRIPTION("HUAWEI Matebook E Go UCSI driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.48.1

-- 
heikki

