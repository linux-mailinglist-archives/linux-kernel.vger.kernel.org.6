Return-Path: <linux-kernel+bounces-195900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F12A8D541C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BAA41C23A73
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653F484DE7;
	Thu, 30 May 2024 21:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="ASzC+jeQ"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B32441760;
	Thu, 30 May 2024 21:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717102958; cv=none; b=ulw7+8u6/OxouCXkx6DusNf7k4JzG6U2c2ZCUZc7urggVXKqHGJ+ELya2meVxgjMYt+sXKkdaqfFzXaGb1ef0S74sQA0U5NCf8ooZinOsPDH3FLOiDIQlicwcvwc9YFMc49qUmY+bVckxWCWFX4Wzuej+5xUd8+OIzuoztxIGts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717102958; c=relaxed/simple;
	bh=ZaWnOebaEw+vhbgWQv7i6iftPoXkeTagRvW/dBj+4pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rweE0XZUICdATkKH1mihmvR9Qy1dOkSbOlxxMAQYd67JlkZBTCcJF7EvF8qkMlC/5MDlw4WY1l2aYvkkf2leI31Dmwtgrmip5oxEVTdA356wSQeIL8tLuJDDjklsQCWZmWV2je9sJWdKohTVa1Avwq9mvg+y+3f+uj/1zelgt+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=ASzC+jeQ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1717102953; bh=ZaWnOebaEw+vhbgWQv7i6iftPoXkeTagRvW/dBj+4pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ASzC+jeQMtQg4W0jpOH8uhTqXHxTlWoBpEcapo9Iics0r8rDM/iGoT11hHEaNlsdy
	 aM9TBczzf2JS3Z+d4Zu7Ubmzm3Po2b8QiKHClYlzPZzDPzHUc5ffSa3AqrJb0zHc4+
	 wy6vZPN6q5cbR1Vm90bevJz1O3UlGp7BxOJOWfi4=
Date: Thu, 30 May 2024 23:02:32 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, Hristo Venev <hristo@venev.name>, 
	=?utf-8?B?UmVuw6k=?= Rebe <rene@exactcode.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
Subject: Re: [PATCH 2/3] hwmon: Add support for SPD5118 compliant temperature
 sensors
Message-ID: <0a2ed64d-06d9-45e8-a054-4ded4429f952@t-8ch.de>
References: <20240529205204.81208-1-linux@roeck-us.net>
 <20240529205204.81208-3-linux@roeck-us.net>
 <34a4292e-c4db-4b40-822e-b892e1444045@t-8ch.de>
 <16e448f1-cfc9-4e88-b3f1-55e1856d1405@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16e448f1-cfc9-4e88-b3f1-55e1856d1405@roeck-us.net>

On 2024-05-30 13:46:48+0000, Guenter Roeck wrote:
> On 5/30/24 13:20, Thomas Weißschuh wrote:
> > On 2024-05-29 13:52:03+0000, Guenter Roeck wrote:
> > > Add support for SPD5118 (Jedec JESD300-5B.01) compliant temperature
> > > sensors. Such sensors are typically found on DDR5 memory modules.
> > 
> > I can get the module to automatically probe with this change:
> > 
> > diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
> > index 97f338b123b1..8d9218f755d7 100644
> > --- a/drivers/i2c/i2c-smbus.c
> > +++ b/drivers/i2c/i2c-smbus.c
> > @@ -382,6 +386,10 @@ void i2c_register_spd(struct i2c_adapter *adap)
> >          case 0x1E:      /* LPDDR4 */
> >                  name = "ee1004";
> >                  break;
> > +       case 0x22:      /* DDR5 */
> > +       case 0x23:      /* LPDDR5 */
> > +               name = "spd5118";
> > +               break;
> >          default:
> >                  dev_info(&adap->dev,
> >                           "Memory type 0x%02x not supported yet, not instantiating SPD\n",
> > 
> > (Credits go to Paul Menzel [0])
> > 
> > Maybe you can add that to your series.
> > 
> 
> That is specifically for SPD (eeprom) support, which I didn't provide
> in the driver. It does not register the equivalent jc42.4 temperature
> sensor either. Given that, using the code to register a temperature
> sensor seems inappropriate.

I see, I wasn't aware about the specifics of SPD.

It felt like a nice way to get automatic probing.
(I was wondering about that today before)

> I didn't include accessing the SPD eeprom to the driver because I don't
> have a use case. I don't mind adding it, though, if others think that it is
> important.

Wolfgang seems to think it's important:
https://lore.kernel.org/lkml/tdia472d4pow2osabef24y2ujkkquplfajxmmtk5pnxllsdxsz@wxzynz7llasr/

> > To also work with my PIIX4 I2C bus, I also need:
> > 
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > index fe6e8a1bb607..ff66e883b348 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -195,6 +195,7 @@ config I2C_ISMT
> >   config I2C_PIIX4
> >          tristate "Intel PIIX4 and compatible (ATI/AMD/Serverworks/Broadcom/SMSC)"
> >          depends on PCI && HAS_IOPORT
> > +       select I2C_SMBUS
> >          help
> >            If you say yes to this option, support will be included for the Intel
> >            PIIX4 family of mainboard I2C interfaces.  Specifically, the following
> > diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> > index 6a0392172b2f..f8d81f8c0cb3 100644
> > --- a/drivers/i2c/busses/i2c-piix4.c
> > +++ b/drivers/i2c/busses/i2c-piix4.c
> > @@ -29,6 +29,7 @@
> >   #include <linux/stddef.h>
> >   #include <linux/ioport.h>
> >   #include <linux/i2c.h>
> > +#include <linux/i2c-smbus.h>
> >   #include <linux/slab.h>
> >   #include <linux/dmi.h>
> >   #include <linux/acpi.h>
> > @@ -982,6 +983,8 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
> >                  return retval;
> >          }
> > 
> > +       i2c_register_spd(adap);
> > +
> >          *padap = adap;
> >          return 0;
> >   }
> > 
> > Though I guess it's not the right place to call i2c_register_sdp(),
> > I'll look at it some more and then submit it.
> > 
> 
> Hmm, I didn't find a better place though.
> 
> Please copy me when you submit a patch; I can test it on an AMD system with
> DDR4.

Will do.


Thomas

