Return-Path: <linux-kernel+bounces-171706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 647988BE791
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9B2CB22A85
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AD41649BF;
	Tue,  7 May 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D7Y9KLrm"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BB01509AE
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096349; cv=none; b=HqlSOArDIO3s+c02X3HA+VBCq+YOz5qK5C0brPx2S2U+7sy9K2LZ0DTFscn2zmMp0QTpVVaDPHEyy7id50ENu4dNr+VHvB8pWtKTfgmRSHiI9oFqGYKSojg/xPXs7bQGjkh3iXPCYu6IyEy21LmL/YXSq/hNapXOKsM0aHHKQEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096349; c=relaxed/simple;
	bh=EsmgGyx30DulTp8j/sFIJ03VtxTL36OG6D14+3GMP3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltJpfKAifuILRr6ql7QV7ZqZ5E2uTSxEvMF3GMCqj5KgDEhYSVtzs7dzblRNxpnT7RpzKCfjjktXjGoUWNzZo3a7gbiSylsgDB0KFxTskIv0quMUpgmIxnrH5adY5CKbEhiT0v/suSsKqRNdV6gGPraNAAYUIrp/6Axxv0aHRtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D7Y9KLrm; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43d55133609so373511cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715096345; x=1715701145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96nVgINAPVMQWeVSHIq1zF2vYAs3MicLM3MDjuBlAtA=;
        b=D7Y9KLrmQ8fXoPhN6HMxg2mhaMZ21Au1hZLZdCjGqNx2ttgnsjbpGfi5zZ/LGojigo
         YhIspd7f5VaapMyW3nc/IpgGOsEcLkVnh2nCl2AN9AwBBq1XmC4cmjSDINjIW4WaWxkb
         5XHVg+wvYEAwUiNiWKFqOUzY8Pt2EUeYOs1MaNrUAiTAkGzIu+sC1df5zI+mLfDIzCtb
         LepYnMqurcOlp0XhxIu2XY0gTMPWonnduOhDPwUawPn8f2acOIZeb6Mzvde2rKccK4hr
         iL/QMUetOwUXP2ffhyuTXps2RUGsCSvbomRl/qXRdTaeeDKYpJXULrbZd6Be7XEVG9yk
         uBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715096345; x=1715701145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96nVgINAPVMQWeVSHIq1zF2vYAs3MicLM3MDjuBlAtA=;
        b=w0/TXUM0fWQ5bwtymZNa515ikI9UChnvDPOKcYt/uZ7IpL9LCIx4NZlHfVc976urtk
         UkQvnfmDItNJtbnEq9rcwGDERmQxT2yMUhPJYOZ3DSV3fh6sOkydM4PEFYQDn59X/QpL
         BwRlravtc5Jw5wtXOEnSY2mpXZh3N36wt4YTl34WOfTXfTjy5UTxoMZVJ3lduquhNM2A
         qFmnOYAcKcsN0KXaqsuylhbddfWM+xtzCZ53V83EeAryFPUzKCSIjFrmufjvHwdgRpxz
         3f7CraHc4lGK5nrls3ne3TqeiVs679O6JhP6ZUVr17qijkFXD58p+k65XHN7CxbDzad9
         Rndw==
X-Forwarded-Encrypted: i=1; AJvYcCWMLakyOlrkhBRU6ZVWy8zYoUyRGTp1oc4rXZOTOtAD7uwQCry6CjXI9JI9wAt4F8FuDUQ05JqcuPT0ul8Jb0SlI1JZ2+BrNKNV/ZNx
X-Gm-Message-State: AOJu0YzwlNJUPKd4jEZE2mRxDtyC2RahT6xHyrDikKXsXdkIeMwZQTYW
	78OClIQP9zdSK+G8rcK6rLajj1+OtVifYmJEWJyKclO5Yl+WLGc/ksazKWcOjyTiq+L8B9936Ge
	CKLpyddZOuNoEO/ba7U0qKdIFMabuiaShbs22
X-Google-Smtp-Source: AGHT+IEogyaCT5RPKXCpuW8hUYpDGKWzFDgD4hF95kO2C1Yn7/rttdH2B29VI0WGLZSN5plXWVdPUM0+dVOfUQsTeL8=
X-Received: by 2002:a05:622a:a0e:b0:43a:c494:a066 with SMTP id
 d75a77b69052e-43d92ec910amr4778181cf.6.1715096345460; Tue, 07 May 2024
 08:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-cros_ec-hwmon-v1-0-2c47c5ce8e85@weissschuh.net>
 <20240507-cros_ec-hwmon-v1-1-2c47c5ce8e85@weissschuh.net> <0595e183-e724-4162-902e-298bf41b09ed@amd.com>
In-Reply-To: <0595e183-e724-4162-902e-298bf41b09ed@amd.com>
From: Guenter Roeck <groeck@google.com>
Date: Tue, 7 May 2024 09:38:52 -0600
Message-ID: <CABXOdTeJZuhaMcm35-9nTCXDLLWft2QZKaZ3Ay=TssCdxaGLTQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] hwmon: add ChromeOS EC driver
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev, 
	Dustin Howett <dustin@howett.net>, Moritz Fischer <mdf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 8:30=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 5/7/2024 08:57, Thomas Wei=C3=9Fschuh wrote:
> > The ChromeOS Embedded Controller exposes fan speed and temperature
> > readings.
> > Expose this data through the hwmon subsystem.
> >
> > The driver is designed to be probed via the cros_ec mfd device.
> >
> > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > ---
> >   Documentation/hwmon/cros_ec_hwmon.rst |  26 ++++
> >   Documentation/hwmon/index.rst         |   1 +
> >   MAINTAINERS                           |   8 +
> >   drivers/hwmon/Kconfig                 |  11 ++
> >   drivers/hwmon/Makefile                |   1 +
> >   drivers/hwmon/cros_ec_hwmon.c         | 279 +++++++++++++++++++++++++=
+++++++++
> >   6 files changed, 326 insertions(+)
> >
> > diff --git a/Documentation/hwmon/cros_ec_hwmon.rst b/Documentation/hwmo=
n/cros_ec_hwmon.rst
> > new file mode 100644
> > index 000000000000..aeb88c79d11b
> > --- /dev/null
> > +++ b/Documentation/hwmon/cros_ec_hwmon.rst
> > @@ -0,0 +1,26 @@
> > +.. SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +Kernel driver cros_ec_hwmon
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +
> > +Supported chips:
> > +
> > +  * ChromeOS embedded controllers connected via LPC
> > +
> > +    Prefix: 'cros_ec'
> > +
> > +    Addresses scanned: -
> > +
> > +Author:
> > +
> > +  - Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > +
> > +Description
> > +-----------
> > +
> > +This driver implements support for hardware monitoring commands expose=
d by the
> > +ChromeOS embedded controller used in Chromebooks and other devices.
> > +
> > +The channel labels exposed via hwmon are retrieved from the EC itself.
> > +
> > +Fan and temperature readings are supported.
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.=
rst
> > index 1ca7a4fe1f8f..355a83e66928 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -57,6 +57,7 @@ Hardware Monitoring Kernel Drivers
> >      coretemp
> >      corsair-cpro
> >      corsair-psu
> > +   cros_ec_hwmon
> >      da9052
> >      da9055
> >      dell-smm-hwmon
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c23fda1aa1f0..aa5689169eca 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4988,6 +4988,14 @@ S:     Maintained
> >   F:  Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
> >   F:  sound/soc/codecs/cros_ec_codec.*
> >
> > +CHROMEOS EC HARDWARE MONITORING
> > +M:   Thomas Wei=C3=9Fschuh <thomas@weissschuh.net>
> > +L:   chrome-platform@lists.linux.dev
> > +L:   linux-hwmon@vger.kernel.org
> > +S:   Maintained
> > +F:   Documentation/hwmon/chros_ec_hwmon.rst
> > +F:   drivers/hwmon/cros_ec_hwmon.c
> > +
> >   CHROMEOS EC SUBDRIVERS
> >   M:  Benson Leung <bleung@chromium.org>
> >   R:  Guenter Roeck <groeck@chromium.org>
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 83945397b6eb..c1284d42697f 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -506,6 +506,17 @@ config SENSORS_CORSAIR_PSU
> >         This driver can also be built as a module. If so, the module
> >         will be called corsair-psu.
> >
> > +config SENSORS_CROS_EC
> > +     tristate "ChromeOS Embedded Controller sensors"
> > +     depends on MFD_CROS_EC_DEV
> > +     default MFD_CROS_EC_DEV
> > +     help
> > +       If you say yes here you get support for ChromeOS Embedded Contr=
oller
> > +       sensors.
> > +
> > +       This driver can also be built as a module. If so, the module
> > +       will be called cros_ec_hwmon.
> > +
> >   config SENSORS_DRIVETEMP
> >       tristate "Hard disk drives with temperature sensors"
> >       depends on SCSI && ATA
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index 5c31808f6378..8519a6b36c00 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -64,6 +64,7 @@ obj-$(CONFIG_SENSORS_CHIPCAP2) +=3D chipcap2.o
> >   obj-$(CONFIG_SENSORS_CORETEMP)      +=3D coretemp.o
> >   obj-$(CONFIG_SENSORS_CORSAIR_CPRO) +=3D corsair-cpro.o
> >   obj-$(CONFIG_SENSORS_CORSAIR_PSU) +=3D corsair-psu.o
> > +obj-$(CONFIG_SENSORS_CROS_EC)        +=3D cros_ec_hwmon.o
> >   obj-$(CONFIG_SENSORS_DA9052_ADC)+=3D da9052-hwmon.o
> >   obj-$(CONFIG_SENSORS_DA9055)+=3D da9055-hwmon.o
> >   obj-$(CONFIG_SENSORS_DELL_SMM)      +=3D dell-smm-hwmon.o
> > diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmo=
n.c
> > new file mode 100644
> > index 000000000000..9588df202a74
> > --- /dev/null
> > +++ b/drivers/hwmon/cros_ec_hwmon.c
> > @@ -0,0 +1,279 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + *  ChromesOS EC driver for hwmon
> > + *
> > + *  Copyright (C) 2024 Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/platform_data/cros_ec_commands.h>
> > +#include <linux/platform_data/cros_ec_proto.h>
> > +#include <linux/units.h>
> > +
> > +#define DRV_NAME     "cros-ec-hwmon"
> > +
> > +struct cros_ec_hwmon_priv {
> > +     struct cros_ec_device *cros_ec;
> > +     u8 thermal_version;
> > +     const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SE=
NSOR_B_ENTRIES];
> > +};
> > +
> > +static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec=
, u8 index, u16 *speed)
> > +{
> > +     int ret;
> > +     u16 data;
> > +
> > +     if (index >=3D EC_FAN_SPEED_ENTRIES)
> > +             return -ENODEV;
>
> I could see an argument that this should be -EINVAL as
> EC_FAN_SPEED_ENTRIES is hardcoded in the driver and "index" was passed
> into the function.
>
> > +
> > +     ret =3D cros_ec->cmd_readmem(cros_ec, EC_MEMMAP_FAN + index * 2, =
2, &data);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     data =3D le16_to_cpu(data);
> > +
> > +     if (data =3D=3D EC_FAN_SPEED_NOT_PRESENT)
> > +             return -ENODEV;
> > +
> > +     *speed =3D data;
>
> For safety purposes I think you should either do
>
> if (speed)
>         *speed =3D data;
>

NACK. This is a static function. Callers are well known. If speed is
NULL this code deserves to crash.

> Or have a check at the start of the function and return -EINVAL and
> throw up a warning if speed was NULL.
>
> > +     return 0;
> > +}
> > +
> > +static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 =
thermal_version,
> > +                                u8 index, u8 *data)
> > +{
> > +     unsigned int offset;
> > +     int ret;
> > +
> > +     if (thermal_version < 2 && index >=3D EC_TEMP_SENSOR_ENTRIES)
> > +             return -ENODEV;
> > +
> > +     if (index >=3D EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES)
> > +             return -ENODEV;
>
> Like cros_ec_hwmon_read_fan_speed I have an opinion these should be -EINV=
AL.
>

Again, this is a static function. The caller is in full control of the
parameter range, and those error checks should be unnecessary to start
with.

I am not going to review the rest of the driver. Drop all unnecessary
range checks and resubmit.

Guenter

> > +
> > +     if (index < EC_TEMP_SENSOR_ENTRIES)
> > +             offset =3D EC_MEMMAP_TEMP_SENSOR + index;
> > +     else
> > +             offset =3D EC_MEMMAP_TEMP_SENSOR_B + index - EC_TEMP_SENS=
OR_ENTRIES;
> > +
> > +     ret =3D cros_ec->cmd_readmem(cros_ec, offset, 1, data);
> > +     if (ret < 0)
> > +             return ret;
> > +
>
> You should make sure that data isn't NULL before doing these checks:
>
> > +     if (*data =3D=3D EC_TEMP_SENSOR_NOT_PRESENT ||
> > +         *data =3D=3D EC_TEMP_SENSOR_ERROR ||
> > +         *data =3D=3D EC_TEMP_SENSOR_NOT_POWERED ||
> > +         *data =3D=3D EC_TEMP_SENSOR_NOT_CALIBRATED)
> > +             return -ENODEV;
> > +
> > +     return 0;
> > +}
> > +
> > +static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_ty=
pes type,
> > +                           u32 attr, int channel, long *val)
> > +{
> > +     struct cros_ec_hwmon_priv *priv =3D dev_get_drvdata(dev);
> > +     u16 speed;
> > +     u8 temp;
> > +     int ret =3D -ENODATA;
>
> I feel it is better practice to add this as a 3rd clause than initialize
> the variable at the start of the function.
>
> switch (type) {
> case hwmon_fan:
>         //do stuff
>         break;
> case hwmon_temp:
>         // dot stuff
>         break;
> default:
>         ret =3D -ENODATA;
> }
>
> return ret;
>
> > +
> > +     if (type =3D=3D hwmon_fan) {
> > +             ret =3D cros_ec_hwmon_read_fan_speed(priv->cros_ec, chann=
el, &speed);
> > +             if (ret =3D=3D 0)
> > +                     *val =3D speed;
> > +     } else if (type =3D=3D hwmon_temp) {
> > +             ret =3D cros_ec_hwmon_read_temp(priv->cros_ec, priv->ther=
mal_version, channel, &temp);
> > +             if (ret =3D=3D 0)
> > +                     *val =3D kelvin_to_millicelsius((((long)temp) + E=
C_TEMP_SENSOR_OFFSET));
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static int cros_ec_hwmon_get_temp_sensor_info(struct cros_ec_device *c=
ros_ec, u8 id,
> > +                                           struct ec_response_temp_sen=
sor_get_info *resp)
> > +{
> > +     int ret;
> > +     struct {
> > +             struct cros_ec_command msg;
> > +             union {
> > +                     struct ec_params_temp_sensor_get_info req;
> > +                     struct ec_response_temp_sensor_get_info resp;
> > +             } __packed data;
> > +     } __packed buf =3D {
> > +             .msg =3D {
> > +                     .version =3D 0,
> > +                     .command =3D EC_CMD_TEMP_SENSOR_GET_INFO,
> > +                     .insize  =3D sizeof(buf.data.resp),
> > +                     .outsize =3D sizeof(buf.data.req),
> > +             },
> > +             .data.req.id =3D id,
> > +     };
> > +
> > +     ret =3D cros_ec_cmd_xfer_status(cros_ec, &buf.msg);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     *resp =3D buf.data.resp;
>
> Make sure that resp isn't NULL.
>
> > +     return 0;
> > +}
> > +
> > +static int cros_ec_hwmon_read_string(struct device *dev, enum hwmon_se=
nsor_types type,
> > +                                  u32 attr, int channel, const char **=
str)
> > +{
> > +     struct cros_ec_hwmon_priv *priv =3D dev_get_drvdata(dev);
> > +     int ret =3D -ENODATA;
>
> How about just drop the variable and then do below two comments:
>
> > +
> > +     if (type =3D=3D hwmon_temp && attr =3D=3D hwmon_temp_label) {
> > +             *str =3D priv->temp_sensor_names[channel];
> > +             ret =3D 0;
>                 return 0;
> > +     }
> > +
> > +     return ret;
>         return -ENODATA;
> > +}
> > +
> > +static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_s=
ensor_types type,
> > +                                     u32 attr, int channel)
> > +{
> > +     const struct cros_ec_hwmon_priv *priv =3D data;
> > +     u16 speed;
> > +
> > +     if (type =3D=3D hwmon_fan) {
> > +             if (cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, =
&speed) =3D=3D 0)
> > +                     return 0444;
> > +     } else if (type =3D=3D hwmon_temp) {
> > +             if (priv->temp_sensor_names[channel])
> > +                     return 0444;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct hwmon_channel_info * const cros_ec_hwmon_info[] =
=3D {
> > +     HWMON_CHANNEL_INFO(fan,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT,
> > +                        HWMON_F_INPUT),
> > +     HWMON_CHANNEL_INFO(temp,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL,
> > +                        HWMON_T_INPUT | HWMON_T_LABEL),
> > +     NULL
> > +};
> > +
> > +static const struct hwmon_ops cros_ec_hwmon_ops =3D {
> > +     .read =3D cros_ec_hwmon_read,
> > +     .read_string =3D cros_ec_hwmon_read_string,
> > +     .is_visible =3D cros_ec_hwmon_is_visible,
> > +};
> > +
> > +static const struct hwmon_chip_info cros_ec_hwmon_chip_info =3D {
> > +     .ops =3D &cros_ec_hwmon_ops,
> > +     .info =3D cros_ec_hwmon_info,
> > +};
> > +
> > +static int cros_ec_hwmon_probe_temp_sensors(struct device *dev, struct=
 cros_ec_hwmon_priv *priv)
> > +{
> > +     struct ec_response_temp_sensor_get_info info;
> > +     size_t i;
> > +     u8 temp;
> > +     int ret;
> > +
> > +     ret =3D priv->cros_ec->cmd_readmem(priv->cros_ec, EC_MEMMAP_THERM=
AL_VERSION,
> > +                                      1, &priv->thermal_version);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (!priv->thermal_version)
> > +             return 0;
>
> I'm a bit confused; why isn't this -ENODEV?  I would think that you
> don't want to have probe succeed and make devices if there isn't thermal
> support in the EC.
>
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(priv->temp_sensor_names); i++) {
> > +             if (cros_ec_hwmon_read_temp(priv->cros_ec, priv->thermal_=
version, i, &temp) !=3D 0)
> > +                     continue;
> > +
> > +             ret =3D cros_ec_hwmon_get_temp_sensor_info(priv->cros_ec,=
 i, &info);
> > +             if (ret < 0)
> > +                     continue;
> > +
> > +             priv->temp_sensor_names[i] =3D devm_kasprintf(dev, GFP_KE=
RNEL, "%*s",
> > +                                                         (int)sizeof(i=
nfo.sensor_name),
> > +                                                         info.sensor_n=
ame);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int cros_ec_hwmon_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct cros_ec_dev *ec_dev =3D dev_get_drvdata(dev->parent);
> > +     struct cros_ec_device *cros_ec =3D ec_dev->ec_dev;
> > +     struct cros_ec_hwmon_priv *priv;
> > +     struct device *hwmon_dev;
> > +     int ret;
> > +
> > +     BUILD_BUG_ON(ARRAY_SIZE(priv->temp_sensor_names) !=3D 24);
> > +
> > +     /* Not every platform supports direct reads */
> > +     if (!cros_ec->cmd_readmem)
> > +             return -ENOTTY;
> > +
> > +     priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     priv->cros_ec =3D cros_ec;
> > +
> > +     ret =3D cros_ec_hwmon_probe_temp_sensors(dev, priv);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     hwmon_dev =3D devm_hwmon_device_register_with_info(dev, "cros_ec"=
, priv,
> > +                                                      &cros_ec_hwmon_c=
hip_info, NULL);
> > +
> > +     return PTR_ERR_OR_ZERO(hwmon_dev);
> > +}
> > +
> > +static const struct platform_device_id cros_ec_hwmon_id[] =3D {
> > +     { DRV_NAME, 0 },
> > +     { }
> > +};
> > +
> > +static struct platform_driver cros_ec_hwmon_driver =3D {
> > +     .driver.name    =3D DRV_NAME,
> > +     .probe          =3D cros_ec_hwmon_probe,
> > +     .id_table       =3D cros_ec_hwmon_id,
> > +};
> > +module_platform_driver(cros_ec_hwmon_driver);
> > +
> > +MODULE_DEVICE_TABLE(platform, cros_ec_hwmon_id);
> > +MODULE_DESCRIPTION("ChromeOS EC Hardware Monitoring Driver");
> > +MODULE_AUTHOR("Thomas Wei=C3=9Fschuh <linux@weissschuh.net");
> > +MODULE_LICENSE("GPL");
> >
>

