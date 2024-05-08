Return-Path: <linux-kernel+bounces-173477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FFD8C00D9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71341F27662
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5388286651;
	Wed,  8 May 2024 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTyJg/Oq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986D98562E
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181700; cv=none; b=W0agmp5qHrcArYEBShrBs1vZb+4a6C2AkjpzK4kjrLFGdvJdfRDmc7g4eyVa8yyO3Zm3uDTm+ogsaJ8jD8KkkPeM18YPGLTZS+TO63MhMwojw65MMRveR8UqBGKbepc0QwsoBn1R0RST9mJUGMb6HnFADmKuT+Jnm29ETn2XRFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181700; c=relaxed/simple;
	bh=KkxdlyLOvGp72ZcWd3A9ZpsF7baokhKDpIc01PvlDC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NhXQYVzM94SPBaiRgC4XQVj0veaSYyF8YinnBYipDyLOy7ee50AuXPV/H9zX+uOGYhFjuTVPDpbj7Fv0XeQyZHNmzTP87dQRPC9OWPBcdiEMkxxXnFAoi4KFARrGgmZ1SxGjgMfRaaPRrslgXFGIvW+cwsWFClykRl4Br9xvPf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTyJg/Oq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0F0C2BD11
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715181700;
	bh=KkxdlyLOvGp72ZcWd3A9ZpsF7baokhKDpIc01PvlDC4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XTyJg/OqlsZ4NXggj1pQ8s3lemBXje7xUqBqSOGBt6+FidE5TRpMs+o5HEbMMIXZm
	 Z5QgsZrmoBRZ2Es0TpbSGUQRhilyLRxnd3eTVRcb0GgBKxxT163EGWOmunWswigXGl
	 PKF60UkioFo8P2hMVvxJi9IiqLE3+qRKobQNuCP9IrXKKX2xD7rVkWWAE0BXWaxmK9
	 SthILc4Iwnc7WfveiIqRmg1zmemHvtC1f6V2o0rcOx7FW7kac6uaiykfA5SizZL4eB
	 8o1QdO7FbZmGE43Ux6Vez6v4VJohH+L1wokEp0vDnCaZiauCPC/mASHmC0NKlaxmsg
	 YBDrSRAmXPBfQ==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b21d7e48ecso430515eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 08:21:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWaLuiDPmvZrF6Y7qAUonf42Q4SqhPu1vbTW6YYbV1mRJTDtpmQFDj8nbZIi4gaqYzq+A1VGIeZ7k9T1FrvPvdK8ojk1Xr1lA2VsV++
X-Gm-Message-State: AOJu0YyguszXq1cv9Xwo3kQgLfOgIeKBdLDKj02w+vWTh9zzH6KKR/d1
	o1cknvR2uq+2mdoo8K+xP+mF9FCIwfJOZ9+bMR2Q9FkkEUSKQ/FlBBtR2a2L11EOCWcQnvYEhRy
	ebAzZJ5c/n3HVghRWMHWFVcLru0c=
X-Google-Smtp-Source: AGHT+IHyKriAMcoFcJK6rpeB38LWCRd7xKLX1Z2/0jNnK1N5XjqFbtdHl1QVKb7vy2mOel8rDakBXC2FFbm12ZUI7xA=
X-Received: by 2002:a4a:d122:0:b0:5b2:32a:85c0 with SMTP id
 006d021491bc7-5b22f83f345mr2865279eaf.2.1715181699433; Wed, 08 May 2024
 08:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406140621.18355-1-hdegoede@redhat.com>
In-Reply-To: <20240406140621.18355-1-hdegoede@redhat.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Thu, 9 May 2024 00:21:02 +0900
X-Gmail-Original-Message-ID: <CAGTfZH1_-x+Z5+t=GCrJ+uEsuV2DPm9m+sKFYDXXXFprAVXekA@mail.gmail.com>
Message-ID: <CAGTfZH1_-x+Z5+t=GCrJ+uEsuV2DPm9m+sKFYDXXXFprAVXekA@mail.gmail.com>
Subject: Re: [PATCH] extcon: Add LC824206XA microUSB switch driver
To: Hans de Goede <hdegoede@redhat.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 11:07=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Add a new driver for the ON Semiconductor LC824206XA microUSB switch and
> accessory detector chip.
>
> ON Semiconductor has an "Advance Information" datasheet available
> (ENA2222-D.PDF), but no full datasheet. So there is no documentation
> available for the registers.
>
> This driver is based on the register info from the extcon-fsa9285.c drive=
r,
> from the Lollipop Android sources for the Lenovo Yoga Tablet 2 (Pro)
> 830 / 1050 / 1380 models. Note despite the name this is actually a driver
> for the LC824206XA not the FSA9285.
>
> This has only been tested on a Lenovo Yoga Tablet 2 Pro 1380 and
> using the driver on other setups may require additional work.
>
> So far this driver is only used on x86/ACPI (non devicetree) devs.
> Therefor there is no devicetree bindings documentation for this driver's
> "onnn,enable-miclr-for-dcp" property since this is not used in actual
> devicetree files and the dt bindings maintainers have requested propertie=
s
> with no actual dt users to _not_ be added to the dt bindings.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/extcon/Kconfig             |  11 +
>  drivers/extcon/Makefile            |   1 +
>  drivers/extcon/extcon-lc824206xa.c | 500 +++++++++++++++++++++++++++++
>  3 files changed, 512 insertions(+)
>  create mode 100644 drivers/extcon/extcon-lc824206xa.c
>
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index 5f869eacd19a..10212a585142 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -75,6 +75,17 @@ config EXTCON_INTEL_MRFLD
>           Say Y here to enable extcon support for charger detection / con=
trol
>           on the Intel Merrifield Basin Cove PMIC.
>
> +config EXTCON_LC824206XA
> +       tristate "LC824206XA extcon Support"
> +       depends on I2C
> +       depends on POWER_SUPPLY
> +       help
> +         Say Y here to enable support for the ON Semiconductor LC824206X=
A
> +         microUSB switch and accessory detector chip. The LC824206XA is =
a USB
> +         port accessory detector and switch. The LC824206XA is fully con=
trolled
> +         using I2C and enables USB data, stereo and mono audio, video,
> +         microphone and UART data to use a common connector port.
> +
>  config EXTCON_MAX14577
>         tristate "Maxim MAX14577/77836 EXTCON Support"
>         depends on MFD_MAX14577
> diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
> index f779adb5e4c7..0d6d23faf748 100644
> --- a/drivers/extcon/Makefile
> +++ b/drivers/extcon/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_EXTCON_GPIO)     +=3D extcon-gpio.o
>  obj-$(CONFIG_EXTCON_INTEL_INT3496) +=3D extcon-intel-int3496.o
>  obj-$(CONFIG_EXTCON_INTEL_CHT_WC) +=3D extcon-intel-cht-wc.o
>  obj-$(CONFIG_EXTCON_INTEL_MRFLD) +=3D extcon-intel-mrfld.o
> +obj-$(CONFIG_EXTCON_LC824206XA)        +=3D extcon-lc824206xa.o
>  obj-$(CONFIG_EXTCON_MAX14577)  +=3D extcon-max14577.o
>  obj-$(CONFIG_EXTCON_MAX3355)   +=3D extcon-max3355.o
>  obj-$(CONFIG_EXTCON_MAX77693)  +=3D extcon-max77693.o
> diff --git a/drivers/extcon/extcon-lc824206xa.c b/drivers/extcon/extcon-l=
c824206xa.c
> new file mode 100644
> index 000000000000..fdf4da50ff46
> --- /dev/null
> +++ b/drivers/extcon/extcon-lc824206xa.c
> @@ -0,0 +1,500 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * ON Semiconductor LC824206XA Micro USB Switch driver
> + *
> + * Copyright (c) 2024 Hans de Goede <hansg@kernel.org>
> + *
> + * ON Semiconductor has an "Advance Information" datasheet available
> + * (ENA2222-D.PDF), but no full datasheet. So there is no documentation
> + * available for the registers.
> + *
> + * This driver is based on the register info from the extcon-fsa9285.c d=
river,
> + * from the Lollipop Android sources for the Lenovo Yoga Tablet 2 (Pro)
> + * 830 / 1050 / 1380 models. Note despite the name this is actually a dr=
iver
> + * for the LC824206XA not the FSA9285. The Android sources can be downlo=
aded
> + * from Lenovo's support page for these tablets, filename:
> + * yoga_tab_2_osc_android_to_lollipop_201505.rar.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/extcon-provider.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/power_supply.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/workqueue.h>
> +
> +/*
> + * Register defines as mentioned above there is no datasheet with regist=
er
> + * info, so this may not be 100% accurate.
> + */
> +#define REG00                          0x00
> +#define REG00_INIT_VALUE               0x01
> +
> +#define REG_STATUS                     0x01
> +#define STATUS_OVP                     BIT(0)
> +#define STATUS_DATA_SHORT              BIT(1)
> +#define STATUS_VBUS_PRESENT            BIT(2)
> +#define STATUS_USB_ID                  GENMASK(7, 3)
> +#define STATUS_USB_ID_GND              0x80
> +#define STATUS_USB_ID_ACA              0xf0
> +#define STATUS_USB_ID_FLOAT            0xf8
> +
> +/*
> + * This controls the DP/DM muxes + other switches,
> + * meaning of individual bits is unknown.
> + */
> +#define REG_SWITCH_CONTROL             0x02
> +#define SWITCH_STEREO_MIC              0xc8
> +#define SWITCH_USB_HOST                        0xec
> +#define SWITCH_DISCONNECTED            0xf8
> +#define SWITCH_USB_DEVICE              0xfc
> +
> +/* 5 bits? ADC 0x10 GND, 0x1a-0x1f ACA, 0x1f float */
> +#define REG_ID_PIN_ADC_VALUE           0x03
> +
> +/* Masks for all 3 interrupt registers */
> +#define INTR_ID_PIN_CHANGE             BIT(0)
> +#define INTR_VBUS_CHANGE               BIT(1)
> +/* Both of these get set after a continuous mode ADC conversion */
> +#define INTR_ID_PIN_ADC_INT1           BIT(2)
> +#define INTR_ID_PIN_ADC_INT2           BIT(3)
> +/* Charger type available in reg 0x09 */
> +#define INTR_CHARGER_DET_DONE          BIT(4)
> +#define INTR_OVP                       BIT(5)
> +
> +/* There are 7 interrupt sources, bit 6 use is unknown (OCP?) */
> +#define INTR_ALL                       GENMASK(6, 0)
> +
> +/* Unmask interrupts this driver cares about */
> +#define INTR_MASK \
> +       (INTR_ALL & ~(INTR_ID_PIN_CHANGE | INTR_VBUS_CHANGE | INTR_CHARGE=
R_DET_DONE))
> +
> +/* Active (event happened and not cleared yet) interrupts */
> +#define REG_INTR_STATUS                        0x04
> +
> +/*
> + * Writing a 1 to a bit here clears it in INTR_STATUS. These bits do NOT
> + * auto-reset to 0, so these must be set to 0 manually after clearing.
> + */
> +#define REG_INTR_CLEAR                 0x05
> +
> +/* Interrupts which bit is set to 1 here will not raise the HW IRQ */
> +#define REG_INTR_MASK                  0x06
> +
> +/* ID pin ADC control, meaning of individual bits is unknown */
> +#define REG_ID_PIN_ADC_CTRL            0x07
> +#define ID_PIN_ADC_AUTO                        0x40
> +#define ID_PIN_ADC_CONTINUOUS          0x44
> +
> +#define REG_CHARGER_DET                        0x08
> +#define CHARGER_DET_ON                 BIT(0)
> +#define CHARGER_DET_CDP_ON             BIT(1)
> +#define CHARGER_DET_CDP_VAL            BIT(2)
> +
> +#define REG_CHARGER_TYPE               0x09
> +#define CHARGER_TYPE_UNKNOWN           0x00
> +#define CHARGER_TYPE_DCP               0x01
> +#define CHARGER_TYPE_SDP_OR_CDP                0x04
> +#define CHARGER_TYPE_QC                        0x06
> +
> +#define REG10                          0x10
> +#define REG10_INIT_VALUE               0x00
> +
> +struct lc824206xa_data {
> +       struct work_struct work;
> +       struct i2c_client *client;
> +       struct extcon_dev *edev;
> +       struct power_supply *psy;
> +       struct regulator *vbus_boost;
> +       unsigned int usb_type;
> +       unsigned int cable;
> +       unsigned int previous_cable;
> +       u8 switch_control;
> +       u8 previous_switch_control;
> +       bool vbus_ok;
> +       bool vbus_boost_enabled;
> +       bool fastcharge_over_miclr;
> +};
> +
> +static const unsigned int lc824206xa_cables[] =3D {
> +       EXTCON_USB_HOST,
> +       EXTCON_CHG_USB_SDP,
> +       EXTCON_CHG_USB_CDP,
> +       EXTCON_CHG_USB_DCP,
> +       EXTCON_CHG_USB_ACA,
> +       EXTCON_CHG_USB_FAST,
> +       EXTCON_NONE,
> +};
> +
> +/* read/write reg helpers to add error logging to smbus byte functions *=
/
> +static int lc824206xa_read_reg(struct lc824206xa_data *data, u8 reg)
> +{
> +       int ret;
> +
> +       ret =3D i2c_smbus_read_byte_data(data->client, reg);
> +       if (ret < 0)
> +               dev_err(&data->client->dev, "Error %d reading reg 0x%02x\=
n", ret, reg);
> +
> +       return ret;
> +}
> +
> +static int lc824206xa_write_reg(struct lc824206xa_data *data, u8 reg, u8=
 val)
> +{
> +       int ret;
> +
> +       ret =3D i2c_smbus_write_byte_data(data->client, reg, val);
> +       if (ret < 0)
> +               dev_err(&data->client->dev, "Error %d writing reg 0x%02x\=
n", ret, reg);
> +
> +       return ret;
> +}
> +
> +static int lc824206xa_get_id(struct lc824206xa_data *data)
> +{
> +       int ret;
> +
> +       ret =3D lc824206xa_write_reg(data, REG_ID_PIN_ADC_CTRL, ID_PIN_AD=
C_CONTINUOUS);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D lc824206xa_read_reg(data, REG_ID_PIN_ADC_VALUE);
> +
> +       lc824206xa_write_reg(data, REG_ID_PIN_ADC_CTRL, ID_PIN_ADC_AUTO);
> +
> +       return ret;
> +}
> +
> +static void lc824206xa_set_vbus_boost(struct lc824206xa_data *data, bool=
 enable)
> +{
> +       int ret;
> +
> +       if (data->vbus_boost_enabled =3D=3D enable)
> +               return;
> +
> +       if (enable)
> +               ret =3D regulator_enable(data->vbus_boost);
> +       else
> +               ret =3D regulator_disable(data->vbus_boost);
> +
> +       if (ret =3D=3D 0)
> +               data->vbus_boost_enabled =3D enable;
> +       else
> +               dev_err(&data->client->dev, "Error updating Vbus boost re=
gulator: %d\n", ret);
> +}
> +
> +static void lc824206xa_charger_detect(struct lc824206xa_data *data)
> +{
> +       int charger_type, ret;
> +
> +       charger_type =3D lc824206xa_read_reg(data, REG_CHARGER_TYPE);
> +       if (charger_type < 0)
> +               return;
> +
> +       dev_dbg(&data->client->dev, "charger type 0x%02x\n", charger_type=
);
> +
> +       switch (charger_type) {
> +       case CHARGER_TYPE_UNKNOWN:
> +               data->usb_type =3D POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +               /* Treat as SDP */
> +               data->cable =3D EXTCON_CHG_USB_SDP;
> +               data->switch_control =3D SWITCH_USB_DEVICE;
> +               break;
> +       case CHARGER_TYPE_SDP_OR_CDP:
> +               data->usb_type =3D POWER_SUPPLY_USB_TYPE_SDP;
> +               data->cable =3D EXTCON_CHG_USB_SDP;
> +               data->switch_control =3D SWITCH_USB_DEVICE;
> +
> +               ret =3D lc824206xa_write_reg(data, REG_CHARGER_DET,
> +                                          CHARGER_DET_CDP_ON | CHARGER_D=
ET_ON);
> +               if (ret < 0)
> +                       break;
> +
> +               msleep(100);
> +               ret =3D lc824206xa_read_reg(data, REG_CHARGER_DET);
> +               if (ret >=3D 0 && (ret & CHARGER_DET_CDP_VAL)) {
> +                       data->usb_type =3D POWER_SUPPLY_USB_TYPE_CDP;
> +                       data->cable =3D EXTCON_CHG_USB_CDP;
> +               }
> +
> +               lc824206xa_write_reg(data, REG_CHARGER_DET, CHARGER_DET_O=
N);
> +               break;
> +       case CHARGER_TYPE_DCP:
> +               data->usb_type =3D POWER_SUPPLY_USB_TYPE_DCP;
> +               data->cable =3D EXTCON_CHG_USB_DCP;
> +               if (data->fastcharge_over_miclr)
> +                       data->switch_control =3D SWITCH_STEREO_MIC;
> +               else
> +                       data->switch_control =3D SWITCH_DISCONNECTED;
> +               break;
> +       case CHARGER_TYPE_QC:
> +               data->usb_type =3D POWER_SUPPLY_USB_TYPE_DCP;
> +               data->cable =3D EXTCON_CHG_USB_DCP;
> +               data->switch_control =3D SWITCH_DISCONNECTED;
> +               break;
> +       default:
> +               dev_warn(&data->client->dev, "Unknown charger type: 0x%02=
x\n", charger_type);
> +               break;
> +       }
> +}
> +
> +static void lc824206xa_work(struct work_struct *work)
> +{
> +        struct lc824206xa_data *data =3D container_of(work, struct lc824=
206xa_data, work);
> +        bool vbus_boost_enable =3D false;
> +        int status, id;
> +
> +        status =3D lc824206xa_read_reg(data, REG_STATUS);
> +        if (status < 0)
> +               return;
> +
> +       dev_dbg(&data->client->dev, "status 0x%02x\n", status);
> +
> +       data->vbus_ok =3D (status & (STATUS_VBUS_PRESENT | STATUS_OVP)) =
=3D=3D STATUS_VBUS_PRESENT;
> +
> +       /* Read id pin ADC if necessary */
> +       switch (status & STATUS_USB_ID) {
> +       case STATUS_USB_ID_GND:
> +       case STATUS_USB_ID_FLOAT:
> +               break;
> +       default:
> +               /* Happens when the connector is inserted slowly, log at =
dbg level */
> +               dev_dbg(&data->client->dev, "Unknown status 0x%02x\n", st=
atus);
> +               fallthrough;
> +       case STATUS_USB_ID_ACA:
> +               id =3D lc824206xa_get_id(data);
> +               dev_dbg(&data->client->dev, "RID 0x%02x\n", id);
> +               switch (id) {
> +               case 0x10:
> +                       status =3D STATUS_USB_ID_GND;
> +                       break;
> +               case 0x18 ... 0x1e:
> +                       status =3D STATUS_USB_ID_ACA;
> +                       break;
> +               case 0x1f:
> +                       status =3D STATUS_USB_ID_FLOAT;
> +                       break;
> +               default:
> +                       dev_warn(&data->client->dev, "Unknown RID 0x%02x\=
n", id);
> +                       return;
> +               }
> +       }
> +
> +       /* Check for out of spec OTG charging hubs, treat as ACA */
> +       if ((status & STATUS_USB_ID) =3D=3D STATUS_USB_ID_GND &&
> +           data->vbus_ok && !data->vbus_boost_enabled) {
> +               dev_info(&data->client->dev, "Out of spec USB host adapte=
r with Vbus present, not enabling 5V output\n");
> +               status =3D STATUS_USB_ID_ACA;
> +       }
> +
> +       switch (status & STATUS_USB_ID) {
> +       case STATUS_USB_ID_ACA:
> +               data->usb_type =3D POWER_SUPPLY_USB_TYPE_ACA;
> +               data->cable =3D EXTCON_CHG_USB_ACA;
> +               data->switch_control =3D SWITCH_USB_HOST;
> +               break;
> +       case STATUS_USB_ID_GND:
> +               data->usb_type =3D POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +               data->cable =3D EXTCON_USB_HOST;
> +               data->switch_control =3D SWITCH_USB_HOST;
> +               vbus_boost_enable =3D true;
> +               break;
> +       case STATUS_USB_ID_FLOAT:
> +               /* When fast charging with Vbus > 5V, OVP will be set */
> +               if (data->fastcharge_over_miclr &&
> +                   data->switch_control =3D=3D SWITCH_STEREO_MIC &&
> +                   (status & STATUS_OVP)) {
> +                       data->cable =3D EXTCON_CHG_USB_FAST;
> +                       break;
> +               }
> +
> +               if (data->vbus_ok) {
> +                       lc824206xa_charger_detect(data);
> +               } else {
> +                       data->usb_type =3D POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +                       data->cable =3D EXTCON_NONE;
> +                       data->switch_control =3D SWITCH_DISCONNECTED;
> +               }
> +               break;
> +       }
> +
> +       lc824206xa_set_vbus_boost(data, vbus_boost_enable);
> +
> +       if (data->switch_control !=3D data->previous_switch_control) {
> +               lc824206xa_write_reg(data, REG_SWITCH_CONTROL, data->swit=
ch_control);
> +               data->previous_switch_control =3D data->switch_control;
> +       }
> +
> +       if (data->cable !=3D data->previous_cable) {
> +               extcon_set_state_sync(data->edev, data->previous_cable, f=
alse);
> +               extcon_set_state_sync(data->edev, data->cable, true);
> +               data->previous_cable =3D data->cable;
> +       }
> +
> +       power_supply_changed(data->psy);
> +}
> +
> +static irqreturn_t lc824206xa_irq(int irq, void *_data)
> +{
> +       struct lc824206xa_data *data =3D _data;
> +       int intr_status;
> +
> +       intr_status =3D lc824206xa_read_reg(data, REG_INTR_STATUS);
> +       if (intr_status < 0)
> +               intr_status =3D INTR_ALL; /* Should never happen, clear a=
ll */
> +
> +       dev_dbg(&data->client->dev, "interrupt 0x%02x\n", intr_status);
> +
> +       lc824206xa_write_reg(data, REG_INTR_CLEAR, intr_status);
> +       lc824206xa_write_reg(data, REG_INTR_CLEAR, 0);
> +
> +       schedule_work(&data->work);
> +       return IRQ_HANDLED;
> +}
> +
> +/*
> + * Newer charger (power_supply) drivers expect the max input current to =
be
> + * provided by a parent power_supply device for the charger chip.
> + */
> +static int lc824206xa_psy_get_prop(struct power_supply *psy,
> +                                  enum power_supply_property psp,
> +                                  union power_supply_propval *val)
> +{
> +       struct lc824206xa_data *data =3D power_supply_get_drvdata(psy);
> +
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_ONLINE:
> +               val->intval =3D data->vbus_ok && !data->vbus_boost_enable=
d;
> +               break;
> +       case POWER_SUPPLY_PROP_USB_TYPE:
> +               val->intval =3D data->usb_type;
> +               break;
> +       case POWER_SUPPLY_PROP_CURRENT_MAX:
> +               switch (data->usb_type) {
> +               case POWER_SUPPLY_USB_TYPE_DCP:
> +               case POWER_SUPPLY_USB_TYPE_ACA:
> +                       val->intval =3D 2000000;
> +                       break;
> +               case POWER_SUPPLY_USB_TYPE_CDP:
> +                       val->intval =3D 1500000;
> +                       break;
> +               default:
> +                       val->intval =3D 500000;
> +               }
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static const enum power_supply_usb_type lc824206xa_psy_usb_types[] =3D {
> +       POWER_SUPPLY_USB_TYPE_SDP,
> +       POWER_SUPPLY_USB_TYPE_CDP,
> +       POWER_SUPPLY_USB_TYPE_DCP,
> +       POWER_SUPPLY_USB_TYPE_ACA,
> +       POWER_SUPPLY_USB_TYPE_UNKNOWN,
> +};
> +
> +static const enum power_supply_property lc824206xa_psy_props[] =3D {
> +       POWER_SUPPLY_PROP_ONLINE,
> +       POWER_SUPPLY_PROP_USB_TYPE,
> +       POWER_SUPPLY_PROP_CURRENT_MAX,
> +};
> +
> +static const struct power_supply_desc lc824206xa_psy_desc =3D {
> +       .name =3D "lc824206xa-charger-detect",
> +       .type =3D POWER_SUPPLY_TYPE_USB,
> +       .usb_types =3D lc824206xa_psy_usb_types,
> +       .num_usb_types =3D ARRAY_SIZE(lc824206xa_psy_usb_types),
> +       .properties =3D lc824206xa_psy_props,
> +       .num_properties =3D ARRAY_SIZE(lc824206xa_psy_props),
> +       .get_property =3D lc824206xa_psy_get_prop,
> +};
> +
> +static int lc824206xa_probe(struct i2c_client *client)
> +{
> +       struct power_supply_config psy_cfg =3D { };
> +       struct device *dev =3D &client->dev;
> +       struct lc824206xa_data *data;
> +       int ret;
> +
> +       data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->client =3D client;
> +       INIT_WORK(&data->work, lc824206xa_work);
> +       data->cable =3D EXTCON_NONE;
> +       data->previous_cable =3D EXTCON_NONE;
> +       data->usb_type =3D POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +       /* Some designs use a custom fast-charge protocol over the mic L/=
R inputs */
> +       data->fastcharge_over_miclr =3D
> +               device_property_read_bool(dev, "onnn,enable-miclr-for-dcp=
");
> +
> +       data->vbus_boost =3D devm_regulator_get(dev, "vbus");
> +       if (IS_ERR(data->vbus_boost))
> +               return dev_err_probe(dev, PTR_ERR(data->vbus_boost),
> +                                    "getting regulator\n");
> +
> +       /* Init */
> +       ret =3D lc824206xa_write_reg(data, REG00, REG00_INIT_VALUE);
> +       ret |=3D lc824206xa_write_reg(data, REG10, REG10_INIT_VALUE);
> +       msleep(100);
> +       ret |=3D lc824206xa_write_reg(data, REG_INTR_CLEAR, INTR_ALL);
> +       ret |=3D lc824206xa_write_reg(data, REG_INTR_CLEAR, 0);
> +       ret |=3D lc824206xa_write_reg(data, REG_INTR_MASK, INTR_MASK);
> +       ret |=3D lc824206xa_write_reg(data, REG_ID_PIN_ADC_CTRL, ID_PIN_A=
DC_AUTO);
> +       ret |=3D lc824206xa_write_reg(data, REG_CHARGER_DET, CHARGER_DET_=
ON);
> +       if (ret)
> +               return -EIO;
> +
> +       /* Initialize extcon device */
> +       data->edev =3D devm_extcon_dev_allocate(dev, lc824206xa_cables);
> +       if (IS_ERR(data->edev))
> +               return PTR_ERR(data->edev);
> +
> +       ret =3D devm_extcon_dev_register(dev, data->edev);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "registering extcon device=
\n");
> +
> +       psy_cfg.drv_data =3D data;
> +       data->psy =3D devm_power_supply_register(dev, &lc824206xa_psy_des=
c, &psy_cfg);
> +       if (IS_ERR(data->psy))
> +               return dev_err_probe(dev, PTR_ERR(data->psy), "registerin=
g power supply\n");
> +
> +       ret =3D devm_request_threaded_irq(dev, client->irq, NULL, lc82420=
6xa_irq,
> +                                       IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +                                       KBUILD_MODNAME, data);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "requesting IRQ\n");
> +
> +       /* Sync initial state */
> +       schedule_work(&data->work);
> +       return 0;
> +}
> +
> +static const struct i2c_device_id lc824206xa_i2c_ids[] =3D {
> +       { "lc824206xa" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, lc824206xa_i2c_ids);
> +
> +static struct i2c_driver lc824206xa_driver =3D {
> +       .driver =3D {
> +               .name =3D KBUILD_MODNAME,
> +       },
> +       .probe =3D lc824206xa_probe,
> +       .id_table =3D lc824206xa_i2c_ids,
> +};
> +
> +module_i2c_driver(lc824206xa_driver);
> +
> +MODULE_AUTHOR("Hans de Goede <hansg@kernel.org>");
> +MODULE_DESCRIPTION("LC824206XA Micro USB Switch driver");
> +MODULE_LICENSE("GPL");
> --
> 2.44.0
>
>

Firstly, I'm sorry for late reply.

When I check the patch with checkpatch script, there are following warnings=
.
Could you please fix it?

Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 11, in <module>
    import git
ModuleNotFoundError: No module named 'git'
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#71:
new file mode 100644

ERROR: trailing whitespace
#241: FILE: drivers/extcon/extcon-lc824206xa.c:166:
+^I$

ERROR: code indent should use tabs where possible
#322: FILE: drivers/extcon/extcon-lc824206xa.c:247:
+        struct lc824206xa_data *data =3D container_of(work, struct
lc824206xa_data, work);$

WARNING: please, no spaces at the start of a line
#322: FILE: drivers/extcon/extcon-lc824206xa.c:247:
+        struct lc824206xa_data *data =3D container_of(work, struct
lc824206xa_data, work);$

ERROR: code indent should use tabs where possible
#323: FILE: drivers/extcon/extcon-lc824206xa.c:248:
+        bool vbus_boost_enable =3D false;$

WARNING: please, no spaces at the start of a line
#323: FILE: drivers/extcon/extcon-lc824206xa.c:248:
+        bool vbus_boost_enable =3D false;$

ERROR: code indent should use tabs where possible
#324: FILE: drivers/extcon/extcon-lc824206xa.c:249:
+        int status, id;$

WARNING: please, no spaces at the start of a line
#324: FILE: drivers/extcon/extcon-lc824206xa.c:249:
+        int status, id;$

ERROR: code indent should use tabs where possible
#326: FILE: drivers/extcon/extcon-lc824206xa.c:251:
+        status =3D lc824206xa_read_reg(data, REG_STATUS);$

WARNING: please, no spaces at the start of a line
#326: FILE: drivers/extcon/extcon-lc824206xa.c:251:
+        status =3D lc824206xa_read_reg(data, REG_STATUS);$

ERROR: code indent should use tabs where possible
#327: FILE: drivers/extcon/extcon-lc824206xa.c:252:
+        if (status < 0)$

WARNING: please, no spaces at the start of a line
#327: FILE: drivers/extcon/extcon-lc824206xa.c:252:
+        if (status < 0)$

ERROR: code indent should use tabs where possible
#328: FILE: drivers/extcon/extcon-lc824206xa.c:253:
+        ^Ireturn;$

WARNING: please, no space before tabs
#328: FILE: drivers/extcon/extcon-lc824206xa.c:253:
+        ^Ireturn;$

WARNING: please, no spaces at the start of a line
#328: FILE: drivers/extcon/extcon-lc824206xa.c:253:
+        ^Ireturn;$

ERROR: trailing whitespace
#430: FILE: drivers/extcon/extcon-lc824206xa.c:355:
+^Ischedule_work(&data->work);^I^I$

ERROR: trailing whitespace
#553: FILE: drivers/extcon/extcon-lc824206xa.c:478:
+^Ischedule_work(&data->work);^I^I$

total: 9 errors, 8 warnings, 524 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplac=
e.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile



--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

