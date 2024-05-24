Return-Path: <linux-kernel+bounces-188376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8028CE142
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836BA1F221B6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413DE128392;
	Fri, 24 May 2024 07:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcNs+27M"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2763D531;
	Fri, 24 May 2024 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716534018; cv=none; b=KBikYoXYgegZ+S8CCxZV3ThzyK1fiW+JPF6FF0AqOYt6vY0WtW4dRw+HwpDKVZg83dG/0zzJZhpU4DLGy4ZOp2JLwGiZ1kH8hNB/awC3dooHN8zw5PL7xjM0Po+G6vgDogR7KY2NNXOE/UDoYpAcwXZ/19pgaEbwCuniNvV9J88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716534018; c=relaxed/simple;
	bh=/Q4wNIHNpd2hDoumqVKVM6V4/z4G0gvW+08vuommuZE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oJ77lc+RpeA8vvEx931fOucZcZKkKIHs7VfNAJzdpjNlq9Ci2Ehb4LdAetcM2VmN9JVGPAnJZHKowOBVFpQxAQGT/fNec9AUjlrPQs3o8bebANbtAWU0qofJDsjzi56t48SCjNASLrZoOparOdmLqrOnGIF8cxvIO7R/SMB1aHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcNs+27M; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4202c1d19d5so59255325e9.2;
        Fri, 24 May 2024 00:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716534015; x=1717138815; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1jDrrOeeCstNF+I2pCUYZNOgXXubZuPEt1qmBzr+ubA=;
        b=UcNs+27MVFe7TmpsV9OnzDUWaf/vKjA2mILmh3WX1JM228RvZoEV1X7f8M3JBn0CdK
         zUNC6QekAZjOia8BPRq9ybVYJZIVn4j3Sn0MS40E5bxlkfZqNuG4zC5R7BZxmjaT/I9c
         NT711DZMNOR5Gcc2nD1ES311X1mKK59Yv4zf7yxLQKtZA5KDSveK9trDxUDEQwT2NWb9
         CsgPj7DwIpZZtyBQ0X6huYcRs6K3JvbebMHo/7f7hvw6OoQcG7/tPxfSJa0gFsl4GcDK
         Xu7WOIfhgb8Uuy5UT+vzM5eyGx3qXlJO82U1Fk6OFq//J70xxvJYf0gqfXIWCUDH8FBG
         xnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716534015; x=1717138815;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1jDrrOeeCstNF+I2pCUYZNOgXXubZuPEt1qmBzr+ubA=;
        b=vCrQl/8Q8id+tnf+Iws70QcI/mMB55/NlqjaDuJok17TN7vAjQN2Oq1Nxfyv3OEl6i
         C1QvJ8m1I5DJ+YXQltvS2r3cYoMamk0bxa0wkmNFNQ/HRJ90vJ7yAheej1pYhcDwFhsD
         7FFqNo8MP/ZMicjFLRi8L299lKH9gCHTmdkehIDTX1dlSTvK1dK+ZKTVe1qwvvYUDC8C
         w+nBX+MG8c3Rmm2zufY7JNKyerOYJzi4ta9V+0JF1kfrC7xgc1QA3xFIOEyy8P9vQWij
         FAUAN2TqkIbbMY7jBjRrkfMm7seZdgcGBmTC8PkMkRGzwIvn8UqhT7bxGDdLGaCyMVMU
         PLrg==
X-Forwarded-Encrypted: i=1; AJvYcCUjrNguvc0YsZ+r4nxn/TUWHogDNliFe8hkR6r+uSozj2jG3VX59FFnpuCa5olgOsyCp9OxC/wh8qJzs8WpRwX1eI6pEyvsFTamA3xzWzmV+BotEqEpTyJ7N7/MTIeX03zbzJBkFwmmILJlxkfullH9B6pwpXtcXQtA0t1xe58jpvG84x4=
X-Gm-Message-State: AOJu0YxpNAtZrF/b1X0Wjh7oMnZcqGcwU9KOT5wH8P1NbvlPvp8BwtJS
	4tCDCxe/JXml/8AsG2dfc7cual4gQO6sO36y4XgwwEYdZ+27V840
X-Google-Smtp-Source: AGHT+IHD8KmPhpdD/4cbqFXK3z9zYCfEVbD1T+dG+fybQPZ2mYEegosbtymPbM7n/BIkWOUA3NieUQ==
X-Received: by 2002:a05:600c:54e3:b0:41c:2499:fa0e with SMTP id 5b1f17b1804b1-421089b2388mr10645125e9.4.1716534014779;
        Fri, 24 May 2024 00:00:14 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100e4a3c1sm45027685e9.0.2024.05.24.00.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 00:00:14 -0700 (PDT)
Message-ID: <58e17135b41da7eba8afd5d8fb5f25bcaffa7288.camel@gmail.com>
Subject: Re: [PATCH v2] drivers: hwmon: max31827: Add PEC support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, Radu Sabau <radu.sabau@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 24 May 2024 09:00:13 +0200
In-Reply-To: <e52a86de-ead6-40d3-b652-461a90bd5942@roeck-us.net>
References: <20240523121057.5689-1-radu.sabau@analog.com>
	 <e52a86de-ead6-40d3-b652-461a90bd5942@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-23 at 07:19 -0700, Guenter Roeck wrote:
> On Thu, May 23, 2024 at 03:10:56PM +0300, Radu Sabau wrote:
> > Add support for PEC by attaching PEC attribute to the i2c device.
> > Add pec_store and pec_show function for accesing the "pec" file.
> >=20
> > Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> > ---
>=20
> Change log missing.
>=20
> > =C2=A0Documentation/hwmon/max31827.rst | 13 +++++--
> > =C2=A0drivers/hwmon/max31827.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 64 ++++++++++++++++++++++++++++++++
> > =C2=A02 files changed, 74 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max=
31827.rst
> > index 44ab9dc064cb..9c11a9518c67 100644
> > --- a/Documentation/hwmon/max31827.rst
> > +++ b/Documentation/hwmon/max31827.rst
> > @@ -131,7 +131,14 @@ The Fault Queue bits select how many consecutive t=
emperature
> > faults must occur
> > =C2=A0before overtemperature or undertemperature faults are indicated i=
n the
> > =C2=A0corresponding status bits.
> > =C2=A0
> > -Notes
> > ------
> > +PEC Support
> > +-----------
> > +
> > +When reading a register value, the PEC byte is computed and sent by th=
e chip.
> > +
> > +PEC on word data transaction respresents a signifcant increase in band=
witdh
> > +usage (+33% for both write and reads) in normal conditions.
> > =C2=A0
> > -PEC is not implemented.
> > +Since this operation implies there will be an extra delay to each
> > +transaction, PEC can be disabled or enabled through sysfs.
> > +Just write 1=C2=A0 to the "pec" file for enabling PEC and 0 for disabl=
ing it.
> > diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
> > index f8a13b30f100..e86f8890ee72 100644
> > --- a/drivers/hwmon/max31827.c
> > +++ b/drivers/hwmon/max31827.c
> > @@ -24,6 +24,7 @@
> > =C2=A0
> > =C2=A0#define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
> > =C2=A0#define MAX31827_CONFIGURATION_CNV_RATE_MASK	GENMASK(3, 1)
> > +#define MAX31827_CONFIGURATION_PEC_EN_MASK	BIT(4)
> > =C2=A0#define MAX31827_CONFIGURATION_TIMEOUT_MASK	BIT(5)
> > =C2=A0#define MAX31827_CONFIGURATION_RESOLUTION_MASK	GENMASK(7, 6)
> > =C2=A0#define MAX31827_CONFIGURATION_ALRM_POL_MASK	BIT(8)
> > @@ -475,6 +476,54 @@ static ssize_t temp1_resolution_store(struct devic=
e *dev,
> > =C2=A0
> > =C2=A0static DEVICE_ATTR_RW(temp1_resolution);
> > =C2=A0
> > +static ssize_t pec_show(struct device *dev, struct device_attribute *d=
evattr,
> > +			char *buf)
> > +{
> > +	struct i2c_client *client =3D to_i2c_client(dev);
> > +
> > +	return scnprintf(buf, PAGE_SIZE, "%d\n", !!(client->flags &
> > I2C_CLIENT_PEC));
> > +}
> > +
> > +static ssize_t pec_store(struct device *dev, struct device_attribute *=
devattr,
> > +			 const char *buf, size_t count)
> > +{
> > +	struct max31827_state *st =3D dev_get_drvdata(dev);
> > +	struct i2c_client *client =3D to_i2c_client(dev);
> > +	unsigned int val;
> > +	int err;
> > +
> > +	err =3D kstrtouint(buf, 10, &val);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	switch (val) {
> > +	case 0:
> > +		err =3D regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
> > +					 MAX31827_CONFIGURATION_PEC_EN_MASK,
> > +					 val);
>=20
> While correct, this is misleading. Should write 0.
>=20
> > +		if (err)
> > +			return err;
> > +
> > +		client->flags &=3D ~I2C_CLIENT_PEC;
> > +		break;
> > +	case 1:
> > +		err =3D regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
> > +					 MAX31827_CONFIGURATION_PEC_EN_MASK,
> > +					 val);
>=20
> This is wrong. s/val/MAX31827_CONFIGURATION_PEC_EN_MASK/
>=20
>=20

Then, maybe use regmap_set_bits()...

- Nuno S=C3=A1


