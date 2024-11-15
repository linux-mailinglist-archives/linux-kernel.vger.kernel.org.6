Return-Path: <linux-kernel+bounces-410242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FB59CD6D2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53BE4B22326
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 06:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E63F36C;
	Fri, 15 Nov 2024 06:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dS1PT8Ba"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543591714C0;
	Fri, 15 Nov 2024 06:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731650767; cv=none; b=rxBBokBMqrCilN6qr54ZfBJSAJmnODemmRiAS79YJLmHqbYi/5OfEXpf5FmvWdDDkBEU9kc4q99uWQfloho3mq9I7Cu2Q+TMV19vqrqzMo/S92X5NpywpnUJcb1ABydEaBJe6EA3J+rMZBPCfHQSchNn7WpyU/VIIB7RfKCOj5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731650767; c=relaxed/simple;
	bh=T2jlqfk4I6dSKdy4jjzNGRgQ5N5KiA9D1QPoTD5HKUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cI1LdNgBo+ObkGrhnNGzqo/WkGH0XsDh0G16DVLrdWBtEeMstSDm0SfejeWsVohkZcNcMD4lcg0QDhM0qokZmPaLBYbkSu45urpCkcejDb7lY4Bn4hVKwoYLUDFFsabtr9CMIJyb+T1K4Anr36mfypP9EyiIWjOfNyqpvn4xTzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dS1PT8Ba; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ff589728e4so15188791fa.1;
        Thu, 14 Nov 2024 22:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731650763; x=1732255563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYSvy8tSXNmEj2t1bEVVLSulZPKtlYwZWTWCl+gr6vA=;
        b=dS1PT8BavtOt1WyrAgnUOJVQb99DBhxJNwFAYk1A4asTMW0cbylHYWWgs3KMHhhBpE
         gGns5o/8mX+i8d9o/cWh6w7Ew9Axd3BPVgGxJ+8EjnG7l2+GpYfwJoLeCa5RaTLTqrZx
         RBv9Tt2IUmj88zMvstMNMW0iFizCvNIhKEcLYf6uN05iOrryxH1nIYUogb/236xw3wo4
         I4/T+yfzQPZaQdN2ts8G/ryBiYJpLzDtPsjqdKCSkmRgyAcmgO/nNuZ9Ds0kkbk4JUHX
         WxmdBDkLVVOp3c3pm6KmY9atInASOh+vh7xkA7qu/pGp7osubwtAbchmoni8Q8X8fsA/
         +arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731650763; x=1732255563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYSvy8tSXNmEj2t1bEVVLSulZPKtlYwZWTWCl+gr6vA=;
        b=YW09rnUA2zsppcD/XaMUMrGqJZ9LW+lOk37dJKIPLxpwixxy0ea+dWOmSTkPDwff0U
         sW5W5J5hPwW7qqyUMHow9fJi0CMCw2fYOMzMFqyz0GVMQC6fKM3dErD5pJlo0BbSraBF
         2LGaX3cTS+5J4W/vkYsxwHzpPOH5J8d7xdakrbSXKePIjyj8SLOfu59QjGIVzDdRpdxA
         jY1z1wO7eYOrWtlw5yozZ4SmAn+ToYZUnYKB2S/xnreFGsVlGruqH85s1vIUQgBYCrAz
         MdF7hzETPft2Ro7yF0mPuaUirj07rmp7XykEuJ9S3EPTxbKT3mSz1KPrmkNrz9aJ2Mzr
         L4XA==
X-Forwarded-Encrypted: i=1; AJvYcCVilYm3hvw4L2WahswljNRQNid9GgJ496kRsnE6bbfLfYVzaKg6sQkbnJF+ciKSBzFTU+SIkCgA7tTE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/aLpq4LxkFIAwPQgRkHsSP8pHlfNC0NVieLJy9Vv6mSMtlLfI
	DA7rahNNfR5rq1H9bMMnwGdPxVv8jnfrnONDX4BeVgrmXhVIJC8ZK/nkJlA9wKwB6MMSTK553PW
	3Yj4TLiY4dKTrkC+D4WL7930Myj/VX2GI
X-Google-Smtp-Source: AGHT+IFAWC8ASKt/4NFkLVuj2E3khzQoyUesvQzrEMZhHeDyziqcfr3rVemKhUb+WUE6wbVyAAMoSs5i33of35X1gj8=
X-Received: by 2002:a05:651c:211a:b0:2fb:569a:5543 with SMTP id
 38308e7fff4ca-2ff5671967emr19479221fa.19.1731650762950; Thu, 14 Nov 2024
 22:06:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108093544.9492-1-ramoncristopher.calam@analog.com> <20241108093544.9492-2-ramoncristopher.calam@analog.com>
In-Reply-To: <20241108093544.9492-2-ramoncristopher.calam@analog.com>
From: anish kumar <yesanishhere@gmail.com>
Date: Thu, 14 Nov 2024 22:05:51 -0800
Message-ID: <CABCoZhAEy5JFK4vVWeoVNzNHu4PMPhBpFL=ooPrZcjDTuoxf+A@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: lt8722: Add driver for LT8722
To: "Ramon Cristopher M. Calam" <ramoncristopher.calam@analog.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 1:40=E2=80=AFAM Ramon Cristopher M. Calam
<ramoncristopher.calam@analog.com> wrote:
>
> Add ADI LT8722 full bridge DC/DC converter driver.
>
> Signed-off-by: Ramon Cristopher M. Calam <ramoncristopher.calam@analog.co=
m>
> ---
>  drivers/regulator/Kconfig            |  10 +
>  drivers/regulator/Makefile           |   1 +
>  drivers/regulator/lt8722-regulator.c | 701 +++++++++++++++++++++++++++
>  3 files changed, 712 insertions(+)
>  create mode 100644 drivers/regulator/lt8722-regulator.c
>
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 39297f7d8177..d88b050ce166 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -550,6 +550,16 @@ config REGULATOR_LP8788
>         help
>           This driver supports LP8788 voltage regulator chip.
>
> +config REGULATOR_LT8722
> +       tristate "LT8722 ultracompact full bridge driver with SPI"
> +       depends on SPI && OF
> +       help
> +         This driver controls an Analog Devices LT8722 ultracompact 4A, =
15V,
> +         full bridge driver with SPI interface.
> +
> +         Say M here if you want to include support for the regulator as =
a
> +         module.
> +
>  config REGULATOR_LTC3589
>         tristate "LTC3589 8-output voltage regulator"
>         depends on I2C
> diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
> index 3d5a803dce8a..8f9e5aec74d2 100644
> --- a/drivers/regulator/Makefile
> +++ b/drivers/regulator/Makefile
> @@ -67,6 +67,7 @@ obj-$(CONFIG_REGULATOR_LP87565) +=3D lp87565-regulator.=
o
>  obj-$(CONFIG_REGULATOR_LP8788) +=3D lp8788-buck.o
>  obj-$(CONFIG_REGULATOR_LP8788) +=3D lp8788-ldo.o
>  obj-$(CONFIG_REGULATOR_LP8755) +=3D lp8755.o
> +obj-$(CONFIG_REGULATOR_LT8722) +=3D lt8722-regulator.o
>  obj-$(CONFIG_REGULATOR_LTC3589) +=3D ltc3589.o
>  obj-$(CONFIG_REGULATOR_LTC3676) +=3D ltc3676.o
>  obj-$(CONFIG_REGULATOR_MAX14577) +=3D max14577-regulator.o
> diff --git a/drivers/regulator/lt8722-regulator.c b/drivers/regulator/lt8=
722-regulator.c
> new file mode 100644
> index 000000000000..f5d378c0b1f2
> --- /dev/null
> +++ b/drivers/regulator/lt8722-regulator.c
> @@ -0,0 +1,701 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Analog Devices LT8722 Ultracompact Full Bridge Driver with SPI driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +
> +#include <asm/unaligned.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/of_regulator.h>
> +#include <linux/spi/spi.h>
> +#include <linux/util_macros.h>
> +
> +/* Register map */
> +#define LT8722_SPIS_COMMAND            0x00
> +#define LT8722_SPIS_STATUS             0x01
> +#define        LT8722_SPIS_DAC_ILIMN           0x02
> +#define        LT8722_SPIS_DAC_ILIMP           0x03
> +#define        LT8722_SPIS_DAC                 0x04
> +#define        LT8722_SPIS_OV_CLAMP            0x05
> +#define        LT8722_SPIS_UV_CLAMP            0x06
> +#define        LT8722_SPIS_AMUX                0x07
> +
> +/* Register masks */
> +#define LT8722_SPIS_COMMAND_MASK       GENMASK(21, 0)
> +#define LT8722_SPIS_STATUS_MASK                GENMASK(10, 0)
> +#define LT8722_SPIS_DAC_ILIMN_MASK     GENMASK(8, 0)
> +#define LT8722_SPIS_DAC_ILIMP_MASK     GENMASK(8, 0)
> +#define LT8722_SPIS_DAC_MASK           GENMASK(31, 0)
> +#define LT8722_SPIS_OV_CLAMP_MASK      GENMASK(3, 0)
> +#define LT8722_SPIS_UV_CLAMP_MASK      GENMASK(3, 0)
> +#define LT8722_SPIS_AMUX_MASK          GENMASK(6, 0)
> +
> +/* SPIS_COMMAND register bit masks */
> +#define LT8722_EN_REQ_MASK             BIT(0)
> +#define LT8722_SWEN_REQ_MASK           BIT(1)
> +#define LT8722_SW_FRQ_SET_MASK         GENMASK(4, 2)
> +#define LT8722_SW_FRQ_ADJ_MASK         GENMASK(6, 5)
> +#define LT8722_SYS_DC_MASK             GENMASK(8, 7)
> +#define LT8722_VCC_VREG_MASK           BIT(9)
> +#define LT8722_SW_VC_IN_MASK           GENMASK(13, 11)
> +#define LT8722_SPI_RST_MASK            BIT(14)
> +#define LT8722_PWR_LIM_MASK            GENMASK(18, 15)
> +
> +#define LT8722_FAULTS_MASK             GENMASK(10, 5)
> +#define LT8722_UV_OV_MASK              GENMASK(23, 20)
> +#define LT8722_OC_MASK                 BIT(5)
> +#define LT8722_TSD_MASK                        BIT(6)
> +
> +#define LT8722_CRC8_POLY               0x07
> +#define LT8722_CRC_INIT                        0x00
> +
> +#define LT8722_READ_CMD                        0xF4
> +#define LT8722_WRITE_CMD               0xF2
> +#define LT8722_RW_CMD_SIZE             8
> +#define LT8722_DATA_SIZE               4
> +#define LT8722_DATA_POS                        2
> +#define LT8722_CRC_POS                 6
> +#define LT8722_ACK                     0xA5
> +#define LT8722_ACK_POS                 7
> +
> +#define LT8722_DAC_VREF                        2500000
> +#define LT8722_DAC_BITS                        25
> +#define LT8722_ILIM_STEP               13280
> +#define LT8722_RAMP_STEPS              5
> +
> +#define LT8722_MIN_DAC_CODE            0xFF000000
> +#define LT8722_MAX_DAC_CODE            0x00FFFFFF
> +#define LT8722_ILIMN_MIN_IOUT          -6786000
> +#define LT8722_ILIMN_MAX_IOUT          -664640
> +#define LT8722_ILIMP_MIN_IOUT          637440
> +#define LT8722_ILIMP_MAX_IOUT          6800000
> +#define LT8722_MIN_VOUT                        -20000000
> +#define LT8722_MAX_VOUT                        20000000
> +#define LT8722_MIN_IOUT                        -6786000
> +#define LT8722_MAX_IOUT                        6800000
> +
> +DECLARE_CRC8_TABLE(lt8722_crc8_table);
> +
> +struct lt8722_chip_info {
> +       struct spi_device *spi;
> +       struct regulator_dev *rdev;
> +       struct gpio_desc *en_gpio;
> +       struct gpio_desc *swen_gpio;
> +       int uv_clamp_uV;
> +       int ov_clamp_uV;
> +       int ilimn_uA;
> +       int ilimp_uA;
> +       int switch_freq_hz;
> +       const char *switch_freq_adjust;
> +       const char *duty_cycle_range;
> +       int vcc_vreg_mV;
> +       int peak_inductor_current_mA;
> +       int power_limit_mW;
> +};
> +
> +static const unsigned int lt8722_uv_clamp[] =3D {
> +       -20000000,
> +       -18750000,
> +       -17500000,
> +       -16250000,
> +       -15000000,
> +       -13750000,
> +       -12500000,
> +       -11250000,
> +       -10000000,
> +       -8750000,
> +       -7500000,
> +       -6250000,
> +       -5000000,
> +       -3750000,
> +       -2500000,
> +       -1250000,
> +};
> +
> +static const unsigned int lt8722_ov_clamp[] =3D {
> +       1250000,
> +       2500000,
> +       3750000,
> +       5000000,
> +       6250000,
> +       7500000,
> +       8750000,
> +       10000000,
> +       11250000,
> +       12500000,
> +       13750000,
> +       15000000,
> +       16250000,
> +       17500000,
> +       18750000,
> +       20000000,
> +};
> +
> +static const unsigned int lt8722_switch_freq[] =3D {
> +       500000,
> +       1000000,
> +       1500000,
> +       2000000,
> +       2500000,
> +       3000000,
> +};
> +
> +static const char * const lt8722_switch_freq_adjust[] =3D {
> +       "0%",
> +       "15%",
> +       "-15%",
> +};
> +
> +static const char * const lt8722_duty_cycle_range[] =3D {
> +       "20%-80%",
> +       "15%-85%",
> +       "10%-90%",
> +};
> +
> +static const unsigned int lt8722_vcc_vreg[] =3D {
> +       3100,
> +       3400,
> +};
> +
> +static const unsigned int lt8722_peak_inductor_current[] =3D {
> +       252,
> +       594,
> +       936,
> +       1278,
> +       1620,
> +       1962,
> +       2304,
> +       2646,
> +};
> +
> +static const unsigned int lt8722_power_limit[] =3D {
> +       2000,
> +       0,
> +       3000,
> +       3500,
> +};
> +
> +static s32 _lt8722_dac_to_uV(u32 dac_val)
> +{
> +       s64 tmp;
> +
> +       tmp =3D (s64)dac_val * LT8722_DAC_VREF;
> +       tmp =3D 16 * div_s64(tmp, BIT(LT8722_DAC_BITS));
> +
> +       return tmp;
> +}
> +
> +static s32 _lt8722_uV_to_dac(s32 uV)
> +{
> +       s64 tmp;
> +
> +       tmp =3D (s64)uV * BIT(LT8722_DAC_BITS);
> +       tmp =3D div_s64(tmp, LT8722_DAC_VREF * 16);
> +
> +       return tmp;
> +}
> +
> +static int lt8722_reg_read(struct spi_device *spi, u8 reg, u32 *val)
> +{
> +       int ret;
> +       struct spi_transfer t;
> +       u8 rx_buf[LT8722_RW_CMD_SIZE] =3D {0};
> +       u8 tx_buf[LT8722_RW_CMD_SIZE] =3D {0};
> +
> +       tx_buf[0] =3D LT8722_READ_CMD;
> +       tx_buf[1] =3D reg << 1;
> +       tx_buf[2] =3D crc8(lt8722_crc8_table, tx_buf, 2, LT8722_CRC_INIT)=
;
> +
> +       t.tx_buf =3D tx_buf;
> +       t.rx_buf =3D rx_buf;
> +       t.len =3D LT8722_RW_CMD_SIZE;
> +
> +       ret =3D spi_sync_transfer(spi, &t, 1);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (rx_buf[LT8722_CRC_POS] !=3D crc8(lt8722_crc8_table, rx_buf,
> +                               LT8722_CRC_POS, LT8722_CRC_INIT))
> +               return -EIO;
> +
> +       if (rx_buf[LT8722_ACK_POS] !=3D LT8722_ACK)
> +               return -EIO;
> +
> +       *val =3D get_unaligned_be32(&rx_buf[LT8722_DATA_POS]);
> +
> +       return 0;
> +}
> +
> +static int lt8722_reg_write(struct spi_device *spi, u8 reg, u32 val)
> +{
> +       int ret;
> +       struct spi_transfer t;
> +       u8 rx_buf[LT8722_RW_CMD_SIZE] =3D {0};
> +       u8 tx_buf[LT8722_RW_CMD_SIZE] =3D {0};
> +
> +       tx_buf[0] =3D LT8722_WRITE_CMD;
> +       tx_buf[1] =3D reg << 1;
> +
> +       put_unaligned_be32(val, &tx_buf[LT8722_DATA_POS]);
> +
> +       tx_buf[LT8722_CRC_POS] =3D crc8(lt8722_crc8_table, tx_buf, LT8722=
_CRC_POS,
> +                                     LT8722_CRC_INIT);
> +
> +       t.tx_buf =3D tx_buf;
> +       t.rx_buf =3D rx_buf;
> +       t.len =3D LT8722_RW_CMD_SIZE;
> +
> +       ret =3D spi_sync_transfer(spi, &t, 1);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (rx_buf[LT8722_ACK_POS] !=3D LT8722_ACK)
> +               return -EIO;
> +
> +       return 0;
> +}
> +
> +static int lt8722_reg_write_mask(struct spi_device *spi, u8 reg, u32 mas=
k,
> +                                u32 val)
> +{
> +       int ret;
> +       u32 reg_val;
> +
> +       ret =3D lt8722_reg_read(spi, reg, &reg_val);
> +       if (ret < 0)
> +               return ret;
> +
> +       reg_val =3D (reg_val & ~mask) | (val & mask);
> +
> +       return lt8722_reg_write(spi, reg, reg_val);
> +}
> +
> +static int lt8722_set_voltage(struct regulator_dev *rdev, int min_uV,
> +                             int max_uV, unsigned int *selector)
> +{
> +       struct lt8722_chip_info *chip =3D rdev_get_drvdata(rdev);
> +
> +       if (min_uV < LT8722_MIN_VOUT || max_uV > LT8722_MAX_VOUT)
> +               return -EINVAL;
> +
> +       *selector =3D _lt8722_uV_to_dac(min_uV);
> +
> +       return lt8722_reg_write(chip->spi, LT8722_SPIS_DAC, *selector);
> +}
> +
> +static int lt8722_get_voltage(struct regulator_dev *rdev)
> +{
> +       struct lt8722_chip_info *chip =3D rdev_get_drvdata(rdev);
> +       int ret, dac_val;
> +
> +       ret =3D lt8722_reg_read(chip->spi, LT8722_SPIS_DAC, &dac_val);
> +       if (ret < 0)
> +               return ret;
> +
> +       dac_val =3D FIELD_GET(LT8722_SPIS_DAC_MASK, dac_val);
> +
> +       return _lt8722_dac_to_uV(dac_val);
> +}
> +
> +static int lt8722_get_prop_index(const u32 *table, size_t table_size, u3=
2 value)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < table_size; i++)
> +               if (table[i] =3D=3D value)
> +                       break;

Nit pick: instead of break you can return the index
instead of checking again below if it is equal to
table_size, saving one check. Once you do that
then you can get rid of below if and simply return
EINVAL.

> +
> +       if (i =3D=3D table_size)
> +               return -EINVAL;
> +
> +       return i;
> +}
> +
> +static int lt8722_parse_fw(struct lt8722_chip_info *chip,
> +                          struct regulator_init_data *init_data)
> +{
> +       int ret;
> +
> +       /* Override the min_uV constraint with the minimum output voltage=
 */
> +       init_data->constraints.min_uV =3D LT8722_MIN_VOUT;
> +
> +       ret =3D device_property_read_u32(&chip->spi->dev, "adi,uv-clamp-m=
icrovolt",
> +                                      &chip->uv_clamp_uV);
> +       if (!ret) {
> +               ret =3D lt8722_get_prop_index(lt8722_uv_clamp,
> +                               ARRAY_SIZE(lt8722_uv_clamp), chip->uv_cla=
mp_uV);
> +               if (ret < 0)
> +                       return ret;
> +
> +               ret =3D lt8722_reg_write(chip->spi, LT8722_SPIS_UV_CLAMP,=
 ret);
> +               if (ret < 0)
> +                       return ret;
> +
> +               /* Override the min_uV constraint with the UV clamp value=
 */
> +               init_data->constraints.min_uV =3D chip->uv_clamp_uV;
> +       }
> +
> +       /* Override the max_uV constraint with the maximum output voltage=
 */
> +       init_data->constraints.max_uV =3D LT8722_MAX_VOUT;
> +
> +       ret =3D device_property_read_u32(&chip->spi->dev, "adi,ov-clamp-m=
icrovolt",
> +                                      &chip->ov_clamp_uV);
> +       if (!ret) {
> +               ret =3D lt8722_get_prop_index(lt8722_ov_clamp,
> +                               ARRAY_SIZE(lt8722_ov_clamp), chip->ov_cla=
mp_uV);
> +               if (ret < 0)
> +                       return ret;
> +
> +               ret =3D lt8722_reg_write(chip->spi, LT8722_SPIS_OV_CLAMP,=
 ret);
> +               if (ret < 0)
> +                       return ret;
> +
> +               /* Override the max_uV constraint with the OV clamp value=
 */
> +               init_data->constraints.max_uV =3D chip->ov_clamp_uV;
> +       }
> +
> +       /* Override the min_uA constraint with the minimum output current=
 */
> +       init_data->constraints.min_uA =3D LT8722_MIN_IOUT;
> +
> +       ret =3D device_property_read_u32(&chip->spi->dev, "adi,ilimn-micr=
oamp",
> +                                      &chip->ilimn_uA);
> +       if (!ret) {
> +               if (chip->ilimn_uA < LT8722_ILIMN_MIN_IOUT ||
> +                   chip->ilimn_uA > LT8722_ILIMN_MAX_IOUT)
> +                       return -EINVAL;
> +
> +               ret =3D div_s64(chip->ilimn_uA, -LT8722_ILIM_STEP);
> +
> +               ret =3D lt8722_reg_write(chip->spi, LT8722_SPIS_DAC_ILIMN=
, ret);
> +               if (ret < 0)
> +                       return ret;
> +
> +               /* Override the min_uA constraint with the ILIMN value */
> +               init_data->constraints.min_uA =3D chip->ilimn_uA;
> +       }
> +
> +       /* Override the max_uA constraint with the maximum output current=
 */
> +       init_data->constraints.max_uA =3D LT8722_MAX_IOUT;
> +
> +       ret =3D device_property_read_u32(&chip->spi->dev, "adi,ilimp-micr=
oamp",
> +                                      &chip->ilimp_uA);
> +       if (!ret) {
> +               if (chip->ilimp_uA < LT8722_ILIMP_MIN_IOUT ||
> +                   chip->ilimp_uA > LT8722_ILIMP_MAX_IOUT)
> +                       return -EINVAL;
> +
> +               ret =3D div_s64(LT8722_MAX_IOUT - chip->ilimp_uA, LT8722_=
ILIM_STEP);
> +
> +               ret =3D lt8722_reg_write(chip->spi, LT8722_SPIS_DAC_ILIMP=
, ret);
> +               if (ret < 0)
> +                       return ret;
> +
> +               /* Override the max_uA constraint with the ILIMP value */
> +               init_data->constraints.max_uA =3D chip->ilimp_uA;
> +       }
> +
> +       ret =3D device_property_read_u32(&chip->spi->dev, "adi,switch-fre=
quency-hz",
> +                                      &chip->switch_freq_hz);
> +       if (!ret) {
> +               ret =3D lt8722_get_prop_index(lt8722_switch_freq,
> +                                           ARRAY_SIZE(lt8722_switch_freq=
),
> +                                           chip->switch_freq_hz);
> +               if (ret < 0)
> +                       return ret;
> +
> +               ret =3D lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMM=
AND,
> +                               LT8722_SW_FRQ_SET_MASK,
> +                               FIELD_PREP(LT8722_SW_FRQ_SET_MASK, ret));
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       ret =3D device_property_match_property_string(&chip->spi->dev,
> +                       "adi,switch-frequency-adjust",
> +                       lt8722_switch_freq_adjust,
> +                       ARRAY_SIZE(lt8722_switch_freq_adjust));
> +       if (ret >=3D 0) {
> +               ret =3D lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMM=
AND,
> +                               LT8722_SW_FRQ_ADJ_MASK,
> +                               FIELD_PREP(LT8722_SW_FRQ_ADJ_MASK, ret));
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       ret =3D device_property_match_property_string(&chip->spi->dev,
> +                       "adi,duty-cycle-range", lt8722_duty_cycle_range,
> +                       ARRAY_SIZE(lt8722_duty_cycle_range));
> +       if (ret >=3D 0) {
> +               ret =3D lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMM=
AND,
> +                               LT8722_SYS_DC_MASK,
> +                               FIELD_PREP(LT8722_SYS_DC_MASK, ret));
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       ret =3D device_property_read_u32(&chip->spi->dev, "adi,vcc-vreg-m=
illivolt",
> +                                      &chip->vcc_vreg_mV);
> +       if (!ret) {
> +               ret =3D lt8722_get_prop_index(lt8722_vcc_vreg,
> +                               ARRAY_SIZE(lt8722_vcc_vreg), chip->vcc_vr=
eg_mV);
> +               if (ret < 0)
> +                       return ret;
> +
> +               ret =3D lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMM=
AND,
> +                               LT8722_VCC_VREG_MASK,
> +                               FIELD_PREP(LT8722_VCC_VREG_MASK, ret));
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       ret =3D device_property_read_u32(&chip->spi->dev,
> +                                      "adi,peak-inductor-current-milliam=
p",
> +                                      &chip->peak_inductor_current_mA);
> +       if (!ret) {
> +               ret =3D lt8722_get_prop_index(lt8722_peak_inductor_curren=
t,
> +                               ARRAY_SIZE(lt8722_peak_inductor_current),
> +                               chip->peak_inductor_current_mA);
> +               if (ret < 0)
> +                       return ret;
> +
> +               ret =3D lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMM=
AND,
> +                               LT8722_SW_VC_IN_MASK,
> +                               FIELD_PREP(LT8722_SW_VC_IN_MASK, ret));
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       ret =3D device_property_read_u32(&chip->spi->dev, "adi,power-limi=
t-milliwatt",
> +                                      &chip->power_limit_mW);
> +       if (!ret) {
> +               ret =3D lt8722_get_prop_index(lt8722_power_limit,
> +                                           ARRAY_SIZE(lt8722_power_limit=
),
> +                                           chip->power_limit_mW);
> +               if (ret < 0)
> +                       return ret;
> +
> +               ret =3D lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMM=
AND,
> +                               LT8722_PWR_LIM_MASK,
> +                               FIELD_PREP(LT8722_PWR_LIM_MASK, ret));
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int lt8722_enable(struct regulator_dev *rdev)
> +{
> +       struct lt8722_chip_info *chip =3D rdev_get_drvdata(rdev);
> +
> +       gpiod_set_value_cansleep(chip->en_gpio, 1);
> +
> +       return lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMMAND,
> +                       LT8722_EN_REQ_MASK,
> +                       FIELD_PREP(LT8722_EN_REQ_MASK, 0x1));
> +}
> +
> +static int lt8722_disable(struct regulator_dev *rdev)
> +{
> +       struct lt8722_chip_info *chip =3D rdev_get_drvdata(rdev);
> +
> +       gpiod_set_value_cansleep(chip->en_gpio, 0);
> +
> +       return lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMMAND,
> +                       LT8722_EN_REQ_MASK,
> +                       FIELD_PREP(LT8722_EN_REQ_MASK, 0x0));
> +}
> +
> +static int lt8722_is_enabled(struct regulator_dev *rdev)
> +{
> +       struct lt8722_chip_info *chip =3D rdev_get_drvdata(rdev);
> +       int ret;
> +       u32 reg_val;
> +       bool en_req, en_pin;
> +
> +       ret =3D lt8722_reg_read(chip->spi, LT8722_SPIS_COMMAND, &reg_val)=
;
> +       if (ret < 0)
> +               return ret;
> +
> +       en_req =3D FIELD_GET(LT8722_EN_REQ_MASK, reg_val);
> +       en_pin =3D gpiod_get_value(chip->en_gpio);
> +
> +       return en_req && en_pin;
> +}
> +
> +static int lt8722_get_error_flags(struct regulator_dev *rdev,
> +                                 unsigned int *flags)
> +{
> +       struct lt8722_chip_info *chip =3D rdev_get_drvdata(rdev);
> +       int ret;
> +       u32 reg_val;
> +
> +       ret =3D lt8722_reg_read(chip->spi, LT8722_SPIS_STATUS, &reg_val);
> +       if (ret < 0)
> +               return ret;
> +
> +       *flags =3D 0;
> +
> +       if (FIELD_GET(LT8722_OC_MASK, reg_val))
> +               *flags |=3D REGULATOR_ERROR_OVER_CURRENT;
> +
> +       if (FIELD_GET(LT8722_TSD_MASK, reg_val))
> +               *flags |=3D REGULATOR_ERROR_OVER_TEMP;
> +
> +       return 0;
> +}
> +
> +static int lt8722_set_soft_start(struct regulator_dev *rdev)
> +{
> +       struct lt8722_chip_info *chip =3D rdev_get_drvdata(rdev);
> +       s32 dac_val;
> +       int ret, i;
> +
> +       /* Clear faults before enabled VCC LDO and other device circuitry=
 */
> +       ret =3D lt8722_reg_write(chip->spi, LT8722_SPIS_STATUS, 0x0);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D lt8722_enable(rdev);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* Configure output voltage control DAC to 0xFF000000 */
> +       ret =3D lt8722_reg_write(chip->spi, LT8722_SPIS_DAC, LT8722_MIN_D=
AC_CODE);
> +       if (ret < 0)
> +               return ret;
> +
> +       /* Write all SPIS_STATUS register bits to 0 */
> +       ret =3D lt8722_reg_write(chip->spi, LT8722_SPIS_STATUS, 0x0);
> +       if (ret < 0)
> +               return ret;
> +
> +       fsleep(1000);
> +
> +       /* Ramp the output voltage control DAC from 0xFF000000 to 0x00000=
000 */
> +       for (i =3D 0; i < LT8722_RAMP_STEPS; i++) {
> +               dac_val =3D LT8722_MIN_DAC_CODE + 0x400000 * i;
> +
> +               ret =3D lt8722_reg_write(chip->spi, LT8722_SPIS_DAC, dac_=
val);
> +               if (ret < 0)
> +                       return ret;
> +
> +               fsleep(1000);
> +       }
> +
> +       /* Enable the PWM switching behavior */
> +       gpiod_set_value_cansleep(chip->swen_gpio, 1);
> +
> +       ret =3D lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMMAND,
> +                       LT8722_SWEN_REQ_MASK,
> +                       FIELD_PREP(LT8722_SWEN_REQ_MASK, 0x1));
> +       if (ret < 0)
> +               return ret;
> +
> +       fsleep(160);
> +
> +       return 0;
> +}
> +
> +static const struct regulator_ops lt8722_regulator_ops =3D {
> +       .set_voltage =3D lt8722_set_voltage,
> +       .get_voltage =3D lt8722_get_voltage,
> +       .enable =3D lt8722_enable,
> +       .disable =3D lt8722_disable,
> +       .is_enabled =3D lt8722_is_enabled,
> +       .set_soft_start =3D lt8722_set_soft_start,
> +       .get_error_flags =3D lt8722_get_error_flags,
> +};
> +
> +static struct regulator_desc lt8722_regulator_desc =3D {
> +       .name =3D "lt8722",
> +       .ops =3D &lt8722_regulator_ops,
> +       .type =3D REGULATOR_VOLTAGE,
> +       .owner =3D THIS_MODULE,
> +};
> +
> +static int lt8722_probe(struct spi_device *spi)
> +{
> +       struct regulator_init_data *init_data;
> +       struct regulator_config config =3D { };
> +       struct lt8722_chip_info *chip;
> +       int ret;
> +
> +       init_data =3D of_get_regulator_init_data(&spi->dev, spi->dev.of_n=
ode,
> +                                              &lt8722_regulator_desc);
> +       if (!init_data)
> +               return -EINVAL;
> +
> +       chip =3D devm_kzalloc(&spi->dev, sizeof(*chip), GFP_KERNEL);
> +       if (!chip)
> +               return -ENOMEM;
> +
> +       crc8_populate_msb(lt8722_crc8_table, LT8722_CRC8_POLY);
> +
> +       chip->spi =3D spi;
> +
> +       chip->en_gpio =3D devm_gpiod_get(&spi->dev, "enable", GPIOD_OUT_L=
OW);
> +       if (IS_ERR(chip->en_gpio))
> +               return PTR_ERR(chip->en_gpio);
> +
> +       chip->swen_gpio =3D devm_gpiod_get(&spi->dev, "switch-enable",
> +                       GPIOD_OUT_LOW);
> +       if (IS_ERR(chip->swen_gpio))
> +               return PTR_ERR(chip->swen_gpio);
> +
> +       ret =3D lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMMAND,
> +                       LT8722_SPI_RST_MASK,
> +                       FIELD_PREP(LT8722_SPI_RST_MASK, 0x1));
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D lt8722_parse_fw(chip, init_data);
> +       if (ret < 0)
> +               return ret;
> +
> +       config.dev =3D &spi->dev;
> +       config.init_data =3D init_data;
> +       config.driver_data =3D chip;
> +
> +       chip->rdev =3D devm_regulator_register(&spi->dev, &lt8722_regulat=
or_desc,
> +                                            &config);
> +       if (IS_ERR(chip->rdev))
> +               return PTR_ERR(chip->rdev);
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id lt8722_of_match[] =3D {
> +       { .compatible =3D "adi,lt8722", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, lt8722_of_match);
> +
> +static const struct spi_device_id lt8722_id[] =3D {
> +       { "lt8722" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(spi, lt8722_id);
> +
> +struct spi_driver lt8722_driver =3D {
> +       .driver =3D {
> +               .name =3D "lt8722",
> +               .of_match_table =3D lt8722_of_match,
> +       },
> +       .probe =3D lt8722_probe,
> +       .id_table =3D lt8722_id,
> +};
> +module_spi_driver(lt8722_driver);
> +
> +MODULE_AUTHOR("Ramon Cristopher Calam <ramoncristopher.calam@analog.com>=
");
> +MODULE_DESCRIPTION("LT8722 ultracompact full bridge driver with SPI driv=
er");
> +MODULE_LICENSE("GPL");
> --
> 2.47.0
>
>

