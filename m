Return-Path: <linux-kernel+bounces-195874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1050E8D53AE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DC9EB238AC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 20:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C90F158A22;
	Thu, 30 May 2024 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="MvOptH8Y"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498EC142E8C;
	Thu, 30 May 2024 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100442; cv=none; b=kBIPHTFWY9J0Jh3/AZwIffrWoEYmOabN7jwS8McEIrygmADZjaE94iFnFLwfozheXQETD+w7EvG9RkGuWUMnTOyt5k+XWAszSB9JrXqmeUjej++Xl9MTUExlyksa7BXBZ0hU0LAqamGpYP5Hf/7+1uAW+wi2bX4ObK9a0q22iRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100442; c=relaxed/simple;
	bh=y6fti8cQCakDlZoQdI4Hnd2ga5rtZg6++Y1ecr+x4PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9fzLU2pAv/1PtfnYgDCqcD3bR1zhyAhy+NFfa4bJ8R+id/TbHdmMQ4jGSc+Mh2oSqi3eAyel+Ght4+E3ceb38jBgY5u0Em/+FCU/LS/lE1xxQ3cPUKoPOtZqRaOgD61HCvhRt+mtf8zBGS8KCInzLMg9wCS034be1a1JYX/EUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=MvOptH8Y; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1717100438; bh=y6fti8cQCakDlZoQdI4Hnd2ga5rtZg6++Y1ecr+x4PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MvOptH8Yqs4v/aeQheehKOxAxA07XHqfhsvNCkHuG/vo86HD8kurE7pOCG9q3d1Cz
	 GdVUoduzH6sbBi1ZnZnONzBCCqM4U3FoYVc7Q4NQtZ5eyTPqeguNSYwZWUDFhnOtiC
	 aIshfFYXvxO9FjyJnWzQiK75owXNNCIr6LrbzxeE=
Date: Thu, 30 May 2024 22:20:37 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, Hristo Venev <hristo@venev.name>, 
	=?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
Subject: Re: [PATCH 2/3] hwmon: Add support for SPD5118 compliant temperature
 sensors
Message-ID: <34a4292e-c4db-4b40-822e-b892e1444045@t-8ch.de>
References: <20240529205204.81208-1-linux@roeck-us.net>
 <20240529205204.81208-3-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529205204.81208-3-linux@roeck-us.net>

On 2024-05-29 13:52:03+0000, Guenter Roeck wrote:
> Add support for SPD5118 (Jedec JESD300-5B.01) compliant temperature
> sensors. Such sensors are typically found on DDR5 memory modules.

I can get the module to automatically probe with this change:

diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index 97f338b123b1..8d9218f755d7 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -382,6 +386,10 @@ void i2c_register_spd(struct i2c_adapter *adap)
        case 0x1E:      /* LPDDR4 */
                name = "ee1004";
                break;
+       case 0x22:      /* DDR5 */
+       case 0x23:      /* LPDDR5 */
+               name = "spd5118";
+               break;
        default:
                dev_info(&adap->dev,
                         "Memory type 0x%02x not supported yet, not instantiating SPD\n",

(Credits go to Paul Menzel [0])

Maybe you can add that to your series.

To also work with my PIIX4 I2C bus, I also need:

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index fe6e8a1bb607..ff66e883b348 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -195,6 +195,7 @@ config I2C_ISMT
 config I2C_PIIX4
        tristate "Intel PIIX4 and compatible (ATI/AMD/Serverworks/Broadcom/SMSC)"
        depends on PCI && HAS_IOPORT
+       select I2C_SMBUS
        help
          If you say yes to this option, support will be included for the Intel
          PIIX4 family of mainboard I2C interfaces.  Specifically, the following
diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 6a0392172b2f..f8d81f8c0cb3 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -29,6 +29,7 @@
 #include <linux/stddef.h>
 #include <linux/ioport.h>
 #include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
 #include <linux/slab.h>
 #include <linux/dmi.h>
 #include <linux/acpi.h>
@@ -982,6 +983,8 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
                return retval;
        }

+       i2c_register_spd(adap);
+
        *padap = adap;
        return 0;
 }

Though I guess it's not the right place to call i2c_register_sdp(),
I'll look at it some more and then submit it.

[0] https://lore.kernel.org/lkml/20240530183444.9312-2-pmenzel@molgen.mpg.de/

