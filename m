Return-Path: <linux-kernel+bounces-548551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4190A5465C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 478B93B1567
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E28209F4D;
	Thu,  6 Mar 2025 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/UqtCnr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C1120969B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741253442; cv=none; b=nstDvuEW/mJL8RbDhKzmqVDfc5l7/HNMPOcuB4wdRH8L2QijdPbbjeoqcevyOhRmO2n8IyNUWAxM4VWz1cA5GG5aiNpp/PVOb9Gnx/4nYa+xvr66PZNXCA3LIPuBjr43UTab7Neupn/OuZp5q5uQ9mmuN4kIkm/tHa8LMVBUVeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741253442; c=relaxed/simple;
	bh=BUOIYYi+AUGf0RKnF2BqG8DjQr9FTfo3Wg2p/fA/iD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aF1Nswjsv9k6H6gDLbavSiQozaXVgi3tI6jzUz/l8zapyeJOUtnD2ut53YoiMP7RCTiqDmD/1eL7KsFSBxsbL+yBIc6G7sSCylrVVyz3l+A3AGZRpDw26uxlaBX6WpnvJlELgszaQmdTsjJL9Ma0DTNWSA7RWXBZeFhbQQ4QKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V/UqtCnr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741253438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/4Zu38Dw3L/X/5VSkpFb55AgaIj8FkzrSRrle8DQUE=;
	b=V/UqtCnrFw3Y9L+kMkTcdYCN2Prcg7y0Mx7Bd0gMLPqLH4bM9ICPilqPgG1vicdvJn4NLU
	Kb2BVJ1/xB2luk2SkJ/g3mh9cTMVN7mVDUg2YXRsxqjbt42XTctFueozPzVGdXJ6oGBTZE
	cmAzMOqL6ffYDaVDKoSE9n1E7CYpnTc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-0eOVfF7GMXSCCaxw9za7-w-1; Thu, 06 Mar 2025 04:30:20 -0500
X-MC-Unique: 0eOVfF7GMXSCCaxw9za7-w-1
X-Mimecast-MFC-AGG-ID: 0eOVfF7GMXSCCaxw9za7-w_1741253419
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43bca561111so1628015e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 01:30:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741253419; x=1741858219;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/4Zu38Dw3L/X/5VSkpFb55AgaIj8FkzrSRrle8DQUE=;
        b=bSXZGMwrLe7FSwMsFqqkKq+9U7ZwL9QwfNZ6ILOK+kuMSxvIwySC3w0xWyfMgPJlly
         PqvbuPX0v5XwEu9mSoyRWsfbC/41nVnmOk/tb8Ccg9f/vcf1cojnlsMCBmn3NSWVKQk3
         A2wExnkZloD7nxE2TsagCyvF7mnS2vNntCOqM9tUwY5gYHKbvav/O2Rf3gEjYC4adoYV
         PA8f81ygLvZTBiYoG5AFV97LSBl7FaB3kcI6rmu5BsZIcZ9Mm9WPizVY/UMwYoyXYD6T
         WfJzG11B3727hEdoBj4t8oicmWVaO/arfqy0wYQ85HpV2x6Ylw2oEWSDpqLZYnHNdfPj
         RC1g==
X-Forwarded-Encrypted: i=1; AJvYcCWhkioCmvd54N97uc4yzk/2dbM8Yu+6f7uDRF+459UcmeA5P+CChUz4433yEevu+W3ilVXgciGyWIA1UKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvVVvDkMaoxzTrMH38TlLINTse46YUTnjyojq4nb5ARrUvNDf/
	LoMyV6eTIVXCsjIjR0trdGRewjADonGvj0lVzRF+IMGIUNJ0xhQ1wLIrYIe6gcQ9h18RAkq2JXV
	/4ZZehPlmCHK7ljX+RmYCOqoS0qd6uYtzkxX7w/+mBbxkKAF47TaWdGSdUhpdfg==
X-Gm-Gg: ASbGncsc6JOoRNmK82fDy5EoZwBOMArzIVlpYD3/53FyDb0f2dcOw0l+qKDUHoVmV3H
	FcX2HsYiqc809wS4Ijw3TKb3jQonXGOxyl16XahBj29qLQNMZ4FNBdZw2G/aYFtC4L4LPATGSFN
	yG1Tz3vCJMyUgbf0lIv89Uffj1pdlkl7wTEtArPLc/6j9ILDClICw3neq7fBzh6eIVDa7US2x9I
	bMZnDyoFqJWDJAe/ppqhXOoIItQfXeU/JFP6hdNxxVdHBv0nKom3a/yCZ1BmeHwQSK0iOtXpC0i
	WGFOAWRAVdNC7S+JQiOJhcM8Llv2w3f14LM8YyWm6ZBpbg==
X-Received: by 2002:a05:600c:511c:b0:43b:cad1:46a0 with SMTP id 5b1f17b1804b1-43bd2973b12mr57419065e9.14.1741253419136;
        Thu, 06 Mar 2025 01:30:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPNVzUPPgKr46aMV4O3KDQ6EjQEi5L08z1i/8idpe88HXbBhjs8qekiDsmL2ciqXtW9X7/Uw==
X-Received: by 2002:a05:600c:511c:b0:43b:cad1:46a0 with SMTP id 5b1f17b1804b1-43bd2973b12mr57418605e9.14.1741253418622;
        Thu, 06 Mar 2025 01:30:18 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd426c16dsm44725855e9.6.2025.03.06.01.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:30:18 -0800 (PST)
Message-ID: <66abce08-e50e-491f-932b-bd36ec6b464c@redhat.com>
Date: Thu, 6 Mar 2025 10:30:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next v8 1/1] net: mdio: Add RTL9300 MDIO driver
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, sander@svanheule.net,
 markus.stockhausen@gmx.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250304015258.386485-1-chris.packham@alliedtelesis.co.nz>
 <20250304015258.386485-2-chris.packham@alliedtelesis.co.nz>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250304015258.386485-2-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,


On 3/4/25 2:52 AM, Chris Packham wrote:
> Add a driver for the MDIO controller on the RTL9300 family of Ethernet
> switches with integrated SoC. There are 4 physical SMI interfaces on the
> RTL9300 however access is done using the switch ports. The driver takes
> the MDIO bus hierarchy from the DTS and uses this to configure the
> switch ports so they are associated with the correct PHY. This mapping
> is also used when dealing with software requests from phylib.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     Changes in v8:
>     - Fix typo in user visible string
>     Changes in v7:
>     - Update out of date comment
>     - Use for_each_set_bit() instead of open-coded iteration
>     - Use FIELD_PREP() in a few more places
>     - Add #defines for register field masks
>     Changes in v6:
>     - Parse port->phy mapping from devicetree removing the need for the
>       realtek,port property
>     - Remove erroneous code dealing with SMI_POLL_CTRL. When actually
>       implemented this stops the LED unit from updating correctly.
>     Changes in v5:
>     - Reword out of date comment
>     - Use GENMASK/FIELD_PREP where appropriate
>     - Introduce port validity bitmap.
>     - Use more obvious names for PHY_CTRL_READ/WRITE and
>       PHY_CTRL_TYPE_C45/C22
>     Changes in v4:
>     - rename to realtek-rtl9300
>     - s/realtek_/rtl9300_/
>     - add locking to support concurrent access
>     - The dtbinding now represents the MDIO bus hierarchy so we consume this
>       information and use it to configure the switch port to MDIO bus+addr.
>     Changes in v3:
>     - Fix (another) off-by-one error
>     Changes in v2:
>     - Add clause 22 support
>     - Remove commented out code
>     - Formatting cleanup
>     - Set MAX_PORTS correctly for MDIO interface
>     - Fix off-by-one error in pn check
> 
>  drivers/net/mdio/Kconfig                |   7 +
>  drivers/net/mdio/Makefile               |   1 +
>  drivers/net/mdio/mdio-realtek-rtl9300.c | 475 ++++++++++++++++++++++++
>  3 files changed, 483 insertions(+)
>  create mode 100644 drivers/net/mdio/mdio-realtek-rtl9300.c
> 
> diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
> index 4a7a303be2f7..058fcdaf6c18 100644
> --- a/drivers/net/mdio/Kconfig
> +++ b/drivers/net/mdio/Kconfig
> @@ -185,6 +185,13 @@ config MDIO_IPQ8064
>  	  This driver supports the MDIO interface found in the network
>  	  interface units of the IPQ8064 SoC
>  
> +config MDIO_REALTEK_RTL9300
> +	tristate "Realtek RTL9300 MDIO interface support"
> +	depends on MACH_REALTEK_RTL || COMPILE_TEST
> +	help
> +	  This driver supports the MDIO interface found in the Realtek
> +	  RTL9300 family of Ethernet switches with integrated SoC.
> +
>  config MDIO_REGMAP
>  	tristate
>  	help
> diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
> index 1015f0db4531..c23778e73890 100644
> --- a/drivers/net/mdio/Makefile
> +++ b/drivers/net/mdio/Makefile
> @@ -19,6 +19,7 @@ obj-$(CONFIG_MDIO_MOXART)		+= mdio-moxart.o
>  obj-$(CONFIG_MDIO_MSCC_MIIM)		+= mdio-mscc-miim.o
>  obj-$(CONFIG_MDIO_MVUSB)		+= mdio-mvusb.o
>  obj-$(CONFIG_MDIO_OCTEON)		+= mdio-octeon.o
> +obj-$(CONFIG_MDIO_REALTEK_RTL9300)	+= mdio-realtek-rtl9300.o
>  obj-$(CONFIG_MDIO_REGMAP)		+= mdio-regmap.o
>  obj-$(CONFIG_MDIO_SUN4I)		+= mdio-sun4i.o
>  obj-$(CONFIG_MDIO_THUNDER)		+= mdio-thunder.o
> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> new file mode 100644
> index 000000000000..0a97c2a9c46d
> --- /dev/null
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
> @@ -0,0 +1,475 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MDIO controller for RTL9300 switches with integrated SoC.
> + *
> + * The MDIO communication is abstracted by the switch. At the software level
> + * communication uses the switch port to address the PHY. We work out the
> + * mapping based on the MDIO bus described in device tree and phandles on the
> + * ethernet-ports property.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitmap.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/find.h>
> +#include <linux/mdio.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/of_mdio.h>
> +#include <linux/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +#define SMI_GLB_CTRL			0xca00
> +#define   GLB_CTRL_INTF_SEL(intf)	BIT(16 + (intf))
> +#define SMI_PORT0_15_POLLING_SEL	0xca08
> +#define SMI_ACCESS_PHY_CTRL_0		0xcb70
> +#define SMI_ACCESS_PHY_CTRL_1		0xcb74
> +#define   PHY_CTRL_REG_ADDR		GENMASK(24, 20)
> +#define   PHY_CTRL_PARK_PAGE		GENMASK(19, 15)
> +#define   PHY_CTRL_MAIN_PAGE		GENMASK(14, 3)
> +#define   PHY_CTRL_WRITE		BIT(2)
> +#define   PHY_CTRL_READ			0
> +#define   PHY_CTRL_TYPE_C45		BIT(1)
> +#define   PHY_CTRL_TYPE_C22		0
> +#define   PHY_CTRL_CMD			BIT(0)
> +#define   PHY_CTRL_FAIL			BIT(25)
> +#define SMI_ACCESS_PHY_CTRL_2		0xcb78
> +#define   PHY_CTRL_INDATA		GENMASK(31, 16)
> +#define   PHY_CTRL_DATA			GENMASK(15, 0)
> +#define SMI_ACCESS_PHY_CTRL_3		0xcb7c
> +#define   PHY_CTRL_MMD_DEVAD		GENMASK(20, 16)
> +#define   PHY_CTRL_MMD_REG		GENMASK(15, 0)
> +#define SMI_PORT0_5_ADDR_CTRL		0xcb80
> +
> +#define MAX_PORTS       28
> +#define MAX_SMI_BUSSES  4
> +#define MAX_SMI_ADDR	0x1f
> +
> +struct rtl9300_mdio_priv {
> +	struct regmap *regmap;
> +	struct mutex lock; /* protect HW access */
> +	DECLARE_BITMAP(valid_ports, MAX_PORTS);
> +	u8 smi_bus[MAX_PORTS];
> +	u8 smi_addr[MAX_PORTS];
> +	bool smi_bus_is_c45[MAX_SMI_BUSSES];
> +	struct mii_bus *bus[MAX_SMI_BUSSES];
> +};
> +
> +struct rtl9300_mdio_chan {
> +	struct rtl9300_mdio_priv *priv;
> +	u8 mdio_bus;
> +};
> +
> +static int rtl9300_mdio_phy_to_port(struct mii_bus *bus, int phy_id)
> +{
> +	struct rtl9300_mdio_chan *chan = bus->priv;
> +	struct rtl9300_mdio_priv *priv = chan->priv;
> +	int i;
> +
> +	for_each_set_bit(i, priv->valid_ports, MAX_PORTS)
> +		if (priv->smi_bus[i] == chan->mdio_bus &&
> +		    priv->smi_addr[i] == phy_id)
> +			return i;
> +
> +	return -ENOENT;
> +}
> +
> +static int rtl9300_mdio_wait_ready(struct rtl9300_mdio_priv *priv)
> +{
> +	struct regmap *regmap = priv->regmap;
> +	u32 val;
> +
> +	lockdep_assert_held(&priv->lock);
> +
> +	return regmap_read_poll_timeout(regmap, SMI_ACCESS_PHY_CTRL_1,
> +					val, !(val & PHY_CTRL_CMD), 10, 1000);
> +}
> +
> +static int rtl9300_mdio_read_c22(struct mii_bus *bus, int phy_id, int regnum)
> +{
> +	struct rtl9300_mdio_chan *chan = bus->priv;
> +	struct rtl9300_mdio_priv *priv = chan->priv;
> +	struct regmap *regmap = priv->regmap;
> +	int port;
> +	u32 val;
> +	int err;
> +
> +	guard(mutex)(&priv->lock);

I'm sorry for the late feedback but quoting
Documentation/process/maintainer-netdev.rst:

"""
Use of ``guard()`` is discouraged within any function longer than 20 lines,
"""

I suggest plain mutex_lock()/unlock() usage in a

Also please respect the reverse christmass tree in the variable
definiton. You will have to do something alike:

	struct rtl9300_mdio_chan *chan = bus->priv;
	struct rtl9300_mdio_priv *priv;
	struct regmap *regmap;
	int port;
	u32 val;
	int err;

	priv = chan->priv;
	regmap = priv->regmap;

Finaly, the cover letter is not required for a single patch.

Thanks,

Paolo


