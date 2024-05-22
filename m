Return-Path: <linux-kernel+bounces-186257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C5E8CC1CB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B561F247F3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED71013E40F;
	Wed, 22 May 2024 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5VlRJaU"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757DE13E05B;
	Wed, 22 May 2024 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716383336; cv=none; b=CIWY4+qYtkqM9HzqSfqr2pYJB3p0j6PLwdJZYcMuJ6wvW/8l4IFfCK5nE5F2aR4GheMGALhv2LCXKn4vBv5USKdjxUzngKoDkyT8yP7OVcWbq5Lp+gwqStHrvaqWiHCTmCSHejxUkYUC4D8NIJqmEjO2g48DiT9AsBZs7N0NpZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716383336; c=relaxed/simple;
	bh=OYm801HITH2QnowaSNTgsAkykOoI7JCJmmQS3LVh7XE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HEuBRRiYx4I1Dk6Hy700n/lRmR8KFJ8BqGEWxFD4c1jfN7rTNOXlv8nvhoMwZdD/DebOA43d0EutjWk8TwLieQiXlIRcgTr8WPauuGA0T9+dM6P8VVpIXZX5YaocPGnTT5S3AyuJYvz3u2vYHJ0ibng7wmAWn6DWbzgsSLxH96A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5VlRJaU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-574b3d6c0f3so11170332a12.0;
        Wed, 22 May 2024 06:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716383333; x=1716988133; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpYJjP79K9HnDkgb6oM0qzQ0M2yNWOSh/VG5MLDKm2s=;
        b=i5VlRJaU7D+ixYKHpMEpgidOLNKJIvUNGTDQ7cWBZTIfSE3HlSJxLSI9MBbY14J8Gh
         xqwDs6qvfRFsEZjMiPOJ0nsOS+FltrZnzl29+FmPeeXROQ5wpTJAj6oixLji9mZYm66Q
         bvK8FAFU/50ogYixCWpxoU+EH9I10HL1uacNB8lkjq2U4QN7r5wUiEROGfL7iZtqD20I
         UNCMPStmtoYtnzNtRFN/7hRQah0z32Rxdp+lbZqnuWmuTLtI7RdReba+8NJD1YZKc7wV
         qbZIhbVDAit7CE2ij+Rm8XQE4mmtfQ2iQuBq1z7UOdgSvDvrsQz6T1AsgxCZ7wT2cDGL
         qmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716383333; x=1716988133;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qpYJjP79K9HnDkgb6oM0qzQ0M2yNWOSh/VG5MLDKm2s=;
        b=CsqZ70OYx4n/wH2D/+Pr7c+xR0K9b6Pyr+PxX1cdtqACE6Yc53+piy8hEE0fgxsASA
         rtpzOTQbBEdNSJF3sxjfSJXzU0x50TA9iJrHnBSFUDIw+5LwjiBy0x49Sk9bPUAzeMnf
         5dT9q4KFv3vZWlYTHdp4cpC4aSQcfANbyDicA6rBSnrpzLfrNVQ2CFvWxuvFNm47NrIg
         XEFWwVINTgyHOURm5iD7Scckd6wG6y/iy43T/4TI5sF4ufwsOlfoDDW5xCPEqW/ksR58
         qMGW0bRneC+80beL+n29bTp7GoAOqQbPTmenz+rnwdPVk2Djpm52Hj59FP8gJinxRouJ
         oAng==
X-Forwarded-Encrypted: i=1; AJvYcCX5jHOb9fvhtoNohP8UaX3/ujK3HTNmrWvKIWV/9onhsDFjFW9H40neY1jZSwB/8JsZ7aDsS8Rorhh3bK4qPEsmh8mx05pdrOxzLX3k/rbiWBU2qoR/hb3cNjy3xFLDPX1oliAjQP6VCkWDRdoVWJ4SyyV8iwZNwvL5ITCQSIXHECRztf0=
X-Gm-Message-State: AOJu0YyoUepVFyDxzB0PVz91JV9RG9gGVKjGN0idyIYxZll6itCmBgDS
	tMWGK/HpOS5XnUKynYP0wzGoTnoe2E2hedBrtLubVWFko0tBukE7
X-Google-Smtp-Source: AGHT+IEqsYmWjn5Jt3QaVT4z9TWEuLnJ1HcJm/NnrnS8PIxx/a5S6igkM7OpPCPL3yIwOhcuec+2Ug==
X-Received: by 2002:a50:8ac8:0:b0:573:58a6:5a4d with SMTP id 4fb4d7f45d1cf-57832c46aaemr1247776a12.35.1716383332437;
        Wed, 22 May 2024 06:08:52 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574f2f50e73sm10624236a12.68.2024.05.22.06.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 06:08:52 -0700 (PDT)
Message-ID: <fc29f19a1ecbceef64bf219a9441eb5b9f09503a.camel@gmail.com>
Subject: Re: [PATCH 1/2] drivers: hwmon: max31827: Add PEC support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Radu Sabau <radu.sabau@analog.com>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>,
 linux-hwmon@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 22 May 2024 15:08:51 +0200
In-Reply-To: <20240522123923.22320-2-radu.sabau@analog.com>
References: <20240522123923.22320-1-radu.sabau@analog.com>
	 <20240522123923.22320-2-radu.sabau@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-22 at 15:39 +0300, Radu Sabau wrote:
> Add support for PEC by attaching PEC attribute to the i2c device.
> Add pec_store and pec_show function for accesing the "pec" file.
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
> =C2=A0Documentation/hwmon/max31827.rst | 13 ++++-
> =C2=A0drivers/hwmon/max31827.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 95 +++++++++++++++++++++++++++-----
> =C2=A02 files changed, 92 insertions(+), 16 deletions(-)
>=20
> diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31=
827.rst
> index 44ab9dc064cb..9c11a9518c67 100644
> --- a/Documentation/hwmon/max31827.rst
> +++ b/Documentation/hwmon/max31827.rst
> @@ -131,7 +131,14 @@ The Fault Queue bits select how many consecutive tem=
perature
> faults must occur
> =C2=A0before overtemperature or undertemperature faults are indicated in =
the
> =C2=A0corresponding status bits.
> =C2=A0
> -Notes
> ------
> +PEC Support
> +-----------
> +
> +When reading a register value, the PEC byte is computed and sent by the =
chip.
> +
> +PEC on word data transaction respresents a signifcant increase in bandwi=
tdh
> +usage (+33% for both write and reads) in normal conditions.
> =C2=A0
> -PEC is not implemented.
> +Since this operation implies there will be an extra delay to each
> +transaction, PEC can be disabled or enabled through sysfs.
> +Just write 1=C2=A0 to the "pec" file for enabling PEC and 0 for disablin=
g it.
> diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
> index f8a13b30f100..16a1524413db 100644
> --- a/drivers/hwmon/max31827.c
> +++ b/drivers/hwmon/max31827.c
> @@ -11,19 +11,20 @@
> =C2=A0#include <linux/hwmon.h>
> =C2=A0#include <linux/i2c.h>
> =C2=A0#include <linux/mutex.h>
> -#include <linux/of_device.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/regulator/consumer.h>
> +#include <linux/of_device.h>
> =C2=A0

Looks like unrelated change...
> -#define MAX31827_T_REG			0x0
> +#define MAX31827_T_REG	0x0
> =C2=A0#define MAX31827_CONFIGURATION_REG	0x2
> -#define MAX31827_TH_REG			0x4
> -#define MAX31827_TL_REG			0x6
> -#define MAX31827_TH_HYST_REG		0x8
> -#define MAX31827_TL_HYST_REG		0xA
> +#define MAX31827_TH_REG	0x4
> +#define MAX31827_TL_REG 0x6
> +#define MAX31827_TH_HYST_REG	0x8
> +#define MAX31827_TL_HYST_REG	0xA

ditto for all the other places

..

> =C2=A0
> +static ssize_t pec_show(struct device *dev, struct device_attribute *dev=
attr,
> +			char *buf)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", !!(client->flags &
> I2C_CLIENT_PEC));

sysfs_emit()

> +}
> +
> +static ssize_t pec_store(struct device *dev, struct device_attribute *de=
vattr,
> +			 const char *buf, size_t count)
> +{
> +	struct max31827_state *st =3D dev_get_drvdata(dev);
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	unsigned int val, val2;
> +	int err;
> +
> +	err =3D kstrtouint(buf, 10, &val);
> +	if (err < 0)
> +		return err;
> +
> +	val2 =3D FIELD_PREP(MAX31827_CONFIGURATION_PEC_EN_MASK, !!val);
> +

Why not just val?

> +	switch (val) {
> +	case 0:
> +		err =3D regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
> +					 MAX31827_CONFIGURATION_PEC_EN_MASK,
> +					 val2);
> +		if (err)
> +			return err;
> +
> +		client->flags &=3D ~I2C_CLIENT_PEC;
> +		break;
> +	case 1:
> +		err =3D regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
> +					 MAX31827_CONFIGURATION_PEC_EN_MASK,
> +					 val2);
> +		if (err)
> +			return err;
> +
> +		client->flags |=3D I2C_CLIENT_PEC;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(pec);
> +
> =C2=A0static struct attribute *max31827_attrs[] =3D {
> =C2=A0	&dev_attr_temp1_resolution.attr,
> +	&dev_attr_pec.attr,

Do we need it in here??


- Nuno S=C3=A1

