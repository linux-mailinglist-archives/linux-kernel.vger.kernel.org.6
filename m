Return-Path: <linux-kernel+bounces-573401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7FDA6D6C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D3C7A5EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BE725D914;
	Mon, 24 Mar 2025 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XafGwW/s"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6325D559;
	Mon, 24 Mar 2025 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742806619; cv=none; b=NLdjAUIzO73RCTk0kOU65lG99tjSdWusSR7om9tGalPbHUvNbDSC5Lt3xk0/NSO+gWxont/Fr2m7DVMMaCNIbJ1+ou59zpG1KGmJJKb/WZKag208FPt7Ccc52bJN0mFFQ7mkQvMdMx8RhAdtgZBwVNu0dTIGRkz0RN0UoMeKGUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742806619; c=relaxed/simple;
	bh=e7Q6xcs3gkYzMTLngqLRwT4p4b9yYaojAWiKJxURf5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDCbqxXY904UvXz3TPS2Kpc/9D56eL5YaH2zpshzZmwJj4E1Ad+NZdh4A0x+0lCco3pDJyTCV29TOxzrhbh0EGrWtvCVVbbU4kILJ0SIjuHvTt5L5kcjkgxY+ncWd3ymF4d5NzzYDaWw/lyB1Sb3J5ctMZlzmo2wmgUfdaRJr28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XafGwW/s; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54298ec925bso5893099e87.3;
        Mon, 24 Mar 2025 01:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742806616; x=1743411416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rzUe5JdriKGQUMoBDE39M1gu7WXalwjyg0Iud3EYcE=;
        b=XafGwW/sp2yR3ScD3DFB1BYS1Lg7xLZ5oZfYsAt2FaGSiKyiD0hx7RJy1xBm3Qun/W
         mfAB4sWI0d3rZeqB+TpuB09SghgwEoiyUAqksEFnpikV56Ob9MVEe55iJPWMFSQITpgF
         D7SfsTEyZBcMZ3Z2+g/hBPeumQ7RrH/MIcFQgGeiYkn+wHN8piRWxgpUbduiZbEZnK8D
         kzb9DMN3brGKDG2r4bk3ql1Xq0NfmjOvFD00hkftPfbls5G++Rpugl+vM6Kvvhv5IYcQ
         FHYL3myQz7v3w2C/BKYY2hR2n9SAt2mOPOuJdPG+tLFrUm/31sSpfJ80U2Pyf3K/2MS7
         /kaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742806616; x=1743411416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rzUe5JdriKGQUMoBDE39M1gu7WXalwjyg0Iud3EYcE=;
        b=I3ZqD1NLJFBrMPyqPY+MQx1wOkJrnMe4k5LMNA5D0EG/r6X0cVbCKk9N/7e/kGFPTQ
         91G/+FLYOsWxkZt3y9hBBhJZg+f7TFyy+1M0Pmn6fbSS1GFcRfjxoT8/5V7MoQJigg6a
         yNWkt7puEGeCPqcXOHyTPXuI+94JSSfIzO7tJEAJHrYg1/Q/Uup54p7n3Y5NnX8BzaP3
         akbkr+v9rSwNIA9Vxg+lUbyzppfvF7U4FGEBbPbEOeO/AjW284jSbNc2aem7DJHLiDq9
         k20n6+ZwEc0n18qK29KAqClx4vEJDgtNzDa/e3hLgK6/rZkmhlYc6TI55vFasOm6VVQ2
         1fnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMKTjQVo9cMVTdEYMHJzq30m9bBQipC9K3tKXvPNyEslFmBzIemZcnCsYjA6T/Hx7hBbrMQ87iUWRQ@vger.kernel.org, AJvYcCVw8UHi9quqleODvSO5J+gfs3tadlB99bQv9qz7T9TpFH/uSYuohnR2hsV66dsm/F/2Mesi5P7aOGtM5Ra6@vger.kernel.org
X-Gm-Message-State: AOJu0YwN+wWP7TVblpJPLJ6t+x61t91D1gcxnMjY73NFmY2KOrn/gCdU
	iX5OIK55KJ+B88sqjRaTbXQDYKtr8MJjUYEOR3snlZWON2KOr3xpu9hJtA==
X-Gm-Gg: ASbGnctA1AZrJHIBOo9DoqSJskyhmDY07aLBz92tIG8/lKCpHh3OQX1J49Tg919l5p8
	HJowC70AeuPioOxPOcGCHr+5NAiZa8UMjOP46WbJmUbPOy5k67O2lPKRRurTOJYkU7hFHoznoF7
	uvyYrrDW4WyRYi+J2O2j+7N6Vj9CscncOKqlm0MFt3KGYucaAWmcm5dDewDwKhxc1jymsK4aw+A
	J3A8sXK4BijPenBuhr//vfnFx3IQOrYGp2sSvdjMdJ0VyFQyBaY+GoPNZxbctB988B+oZNoumvy
	lk9gYL5bT7bvpJKiJ/KwtEjaklEftd3+Ip3oDbAOhhRuqxaarR0=
X-Google-Smtp-Source: AGHT+IENI2lKp6jCt2bo8WwqulJeizsUTC8i1ROjoXYKa27V7qysJn3xlHSj17vC2TjbW57twZJoUA==
X-Received: by 2002:a05:6512:1148:b0:545:1e2d:6b73 with SMTP id 2adb3069b0e04-54ad6490823mr3508236e87.13.1742806615571;
        Mon, 24 Mar 2025 01:56:55 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6468766sm1097566e87.35.2025.03.24.01.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:56:53 -0700 (PDT)
Date: Mon, 24 Mar 2025 10:56:50 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/14] regulator: bd96801: Support ROHM BD96805 PMIC
Message-ID: <bf33c911e77254420f5481b98fde29041e8f7823.1742802856.git.mazziesaccount@gmail.com>
References: <cover.1742802856.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QCSAAauiKArzvHvH"
Content-Disposition: inline
In-Reply-To: <cover.1742802856.git.mazziesaccount@gmail.com>


--QCSAAauiKArzvHvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD96805 is from the software perspective almost identical to
the ROHM BD96801. The main difference is different voltage tuning
ranges.

Add support differentiating these PMICs and provide correct voltages
for both models.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> :
 - No changes
---
 drivers/regulator/bd96801-regulator.c | 207 ++++++++++++++++++++++++++
 1 file changed, 207 insertions(+)

diff --git a/drivers/regulator/bd96801-regulator.c b/drivers/regulator/bd96=
801-regulator.c
index 893efdd92008..d829289942f9 100644
--- a/drivers/regulator/bd96801-regulator.c
+++ b/drivers/regulator/bd96801-regulator.c
@@ -83,6 +83,7 @@ enum {
 #define BD96801_LDO6_VSEL_REG		0x26
 #define BD96801_LDO7_VSEL_REG		0x27
 #define BD96801_BUCK_VSEL_MASK		0x1F
+#define BD96805_BUCK_VSEL_MASK		0x3f
 #define BD96801_LDO_VSEL_MASK		0xff
=20
 #define BD96801_MASK_RAMP_DELAY		0xc0
@@ -90,6 +91,7 @@ enum {
 #define BD96801_BUCK_INT_VOUT_MASK	0xff
=20
 #define BD96801_BUCK_VOLTS		256
+#define BD96805_BUCK_VOLTS		64
 #define BD96801_LDO_VOLTS		256
=20
 #define BD96801_OVP_MASK		0x03
@@ -160,6 +162,22 @@ static const struct linear_range bd96801_buck_init_vol=
ts[] =3D {
 	REGULATOR_LINEAR_RANGE(3300000 - 150000, 0xed, 0xff, 0),
 };
=20
+/*
+ * On BD96805 we have similar "negative tuning range" as on BD96801, except
+ * that the max tuning is -310 ... +310 mV (instead of the 150mV). We use =
same
+ * approach as with the BD96801 ranges.
+ */
+static const struct linear_range bd96805_tune_volts[] =3D {
+	REGULATOR_LINEAR_RANGE(310000, 0x00, 0x1F, 10000),
+	REGULATOR_LINEAR_RANGE(0, 0x20, 0x3F, 10000),
+};
+
+static const struct linear_range bd96805_buck_init_volts[] =3D {
+	REGULATOR_LINEAR_RANGE(500000 - 310000, 0x00, 0xc8, 5000),
+	REGULATOR_LINEAR_RANGE(1550000 - 310000, 0xc9, 0xec, 50000),
+	REGULATOR_LINEAR_RANGE(3300000 - 310000, 0xed, 0xff, 0),
+};
+
 static const struct linear_range bd96801_ldo_int_volts[] =3D {
 	REGULATOR_LINEAR_RANGE(300000, 0x00, 0x78, 25000),
 	REGULATOR_LINEAR_RANGE(3300000, 0x79, 0xff, 0),
@@ -756,6 +774,194 @@ static const struct bd96801_pmic_data bd96801_data =
=3D {
 	.num_regulators =3D 7,
 };
=20
+static const struct bd96801_pmic_data bd96805_data =3D {
+	.regulator_data =3D {
+	{
+		.desc =3D {
+			.name =3D "buck1",
+			.of_match =3D of_match_ptr("buck1"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD96801_BUCK1,
+			.ops =3D &bd96801_buck_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd96805_tune_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd96805_tune_volts),
+			.n_voltages =3D BD96805_BUCK_VOLTS,
+			.enable_reg =3D BD96801_REG_ENABLE,
+			.enable_mask =3D BD96801_BUCK1_EN_MASK,
+			.enable_is_inverted =3D true,
+			.vsel_reg =3D BD96801_BUCK1_VSEL_REG,
+			.vsel_mask =3D BD96805_BUCK_VSEL_MASK,
+			.ramp_reg =3D BD96801_BUCK1_VSEL_REG,
+			.ramp_mask =3D BD96801_MASK_RAMP_DELAY,
+			.ramp_delay_table =3D &buck_ramp_table[0],
+			.n_ramp_values =3D ARRAY_SIZE(buck_ramp_table),
+			.owner =3D THIS_MODULE,
+		},
+		.init_ranges =3D bd96805_buck_init_volts,
+		.num_ranges =3D ARRAY_SIZE(bd96805_buck_init_volts),
+		.irq_desc =3D {
+			.irqinfo =3D (struct bd96801_irqinfo *)&buck1_irqinfo[0],
+			.num_irqs =3D ARRAY_SIZE(buck1_irqinfo),
+		},
+	}, {
+		.desc =3D {
+			.name =3D "buck2",
+			.of_match =3D of_match_ptr("buck2"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD96801_BUCK2,
+			.ops =3D &bd96801_buck_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd96805_tune_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd96805_tune_volts),
+			.n_voltages =3D BD96805_BUCK_VOLTS,
+			.enable_reg =3D BD96801_REG_ENABLE,
+			.enable_mask =3D BD96801_BUCK2_EN_MASK,
+			.enable_is_inverted =3D true,
+			.vsel_reg =3D BD96801_BUCK2_VSEL_REG,
+			.vsel_mask =3D BD96805_BUCK_VSEL_MASK,
+			.ramp_reg =3D BD96801_BUCK2_VSEL_REG,
+			.ramp_mask =3D BD96801_MASK_RAMP_DELAY,
+			.ramp_delay_table =3D &buck_ramp_table[0],
+			.n_ramp_values =3D ARRAY_SIZE(buck_ramp_table),
+			.owner =3D THIS_MODULE,
+		},
+		.irq_desc =3D {
+			.irqinfo =3D (struct bd96801_irqinfo *)&buck2_irqinfo[0],
+			.num_irqs =3D ARRAY_SIZE(buck2_irqinfo),
+		},
+		.init_ranges =3D bd96805_buck_init_volts,
+		.num_ranges =3D ARRAY_SIZE(bd96805_buck_init_volts),
+	}, {
+		.desc =3D {
+			.name =3D "buck3",
+			.of_match =3D of_match_ptr("buck3"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD96801_BUCK3,
+			.ops =3D &bd96801_buck_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd96805_tune_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd96805_tune_volts),
+			.n_voltages =3D BD96805_BUCK_VOLTS,
+			.enable_reg =3D BD96801_REG_ENABLE,
+			.enable_mask =3D BD96801_BUCK3_EN_MASK,
+			.enable_is_inverted =3D true,
+			.vsel_reg =3D BD96801_BUCK3_VSEL_REG,
+			.vsel_mask =3D BD96805_BUCK_VSEL_MASK,
+			.ramp_reg =3D BD96801_BUCK3_VSEL_REG,
+			.ramp_mask =3D BD96801_MASK_RAMP_DELAY,
+			.ramp_delay_table =3D &buck_ramp_table[0],
+			.n_ramp_values =3D ARRAY_SIZE(buck_ramp_table),
+			.owner =3D THIS_MODULE,
+		},
+		.irq_desc =3D {
+			.irqinfo =3D (struct bd96801_irqinfo *)&buck3_irqinfo[0],
+			.num_irqs =3D ARRAY_SIZE(buck3_irqinfo),
+		},
+		.init_ranges =3D bd96805_buck_init_volts,
+		.num_ranges =3D ARRAY_SIZE(bd96805_buck_init_volts),
+	}, {
+		.desc =3D {
+			.name =3D "buck4",
+			.of_match =3D of_match_ptr("buck4"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD96801_BUCK4,
+			.ops =3D &bd96801_buck_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd96805_tune_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd96805_tune_volts),
+			.n_voltages =3D BD96805_BUCK_VOLTS,
+			.enable_reg =3D BD96801_REG_ENABLE,
+			.enable_mask =3D BD96801_BUCK4_EN_MASK,
+			.enable_is_inverted =3D true,
+			.vsel_reg =3D BD96801_BUCK4_VSEL_REG,
+			.vsel_mask =3D BD96805_BUCK_VSEL_MASK,
+			.ramp_reg =3D BD96801_BUCK4_VSEL_REG,
+			.ramp_mask =3D BD96801_MASK_RAMP_DELAY,
+			.ramp_delay_table =3D &buck_ramp_table[0],
+			.n_ramp_values =3D ARRAY_SIZE(buck_ramp_table),
+			.owner =3D THIS_MODULE,
+		},
+		.irq_desc =3D {
+			.irqinfo =3D (struct bd96801_irqinfo *)&buck4_irqinfo[0],
+			.num_irqs =3D ARRAY_SIZE(buck4_irqinfo),
+		},
+		.init_ranges =3D bd96805_buck_init_volts,
+		.num_ranges =3D ARRAY_SIZE(bd96805_buck_init_volts),
+	}, {
+		.desc =3D {
+			.name =3D "ldo5",
+			.of_match =3D of_match_ptr("ldo5"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD96801_LDO5,
+			.ops =3D &bd96801_ldo_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd96801_ldo_int_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd96801_ldo_int_volts),
+			.n_voltages =3D BD96801_LDO_VOLTS,
+			.enable_reg =3D BD96801_REG_ENABLE,
+			.enable_mask =3D BD96801_LDO5_EN_MASK,
+			.enable_is_inverted =3D true,
+			.vsel_reg =3D BD96801_LDO5_VSEL_REG,
+			.vsel_mask =3D BD96801_LDO_VSEL_MASK,
+			.owner =3D THIS_MODULE,
+		},
+		.irq_desc =3D {
+			.irqinfo =3D (struct bd96801_irqinfo *)&ldo5_irqinfo[0],
+			.num_irqs =3D ARRAY_SIZE(ldo5_irqinfo),
+		},
+		.ldo_vol_lvl =3D BD96801_LDO5_VOL_LVL_REG,
+	}, {
+		.desc =3D {
+			.name =3D "ldo6",
+			.of_match =3D of_match_ptr("ldo6"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD96801_LDO6,
+			.ops =3D &bd96801_ldo_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd96801_ldo_int_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd96801_ldo_int_volts),
+			.n_voltages =3D BD96801_LDO_VOLTS,
+			.enable_reg =3D BD96801_REG_ENABLE,
+			.enable_mask =3D BD96801_LDO6_EN_MASK,
+			.enable_is_inverted =3D true,
+			.vsel_reg =3D BD96801_LDO6_VSEL_REG,
+			.vsel_mask =3D BD96801_LDO_VSEL_MASK,
+			.owner =3D THIS_MODULE,
+		},
+		.irq_desc =3D {
+			.irqinfo =3D (struct bd96801_irqinfo *)&ldo6_irqinfo[0],
+			.num_irqs =3D ARRAY_SIZE(ldo6_irqinfo),
+		},
+		.ldo_vol_lvl =3D BD96801_LDO6_VOL_LVL_REG,
+	}, {
+		.desc =3D {
+			.name =3D "ldo7",
+			.of_match =3D of_match_ptr("ldo7"),
+			.regulators_node =3D of_match_ptr("regulators"),
+			.id =3D BD96801_LDO7,
+			.ops =3D &bd96801_ldo_ops,
+			.type =3D REGULATOR_VOLTAGE,
+			.linear_ranges =3D bd96801_ldo_int_volts,
+			.n_linear_ranges =3D ARRAY_SIZE(bd96801_ldo_int_volts),
+			.n_voltages =3D BD96801_LDO_VOLTS,
+			.enable_reg =3D BD96801_REG_ENABLE,
+			.enable_mask =3D BD96801_LDO7_EN_MASK,
+			.enable_is_inverted =3D true,
+			.vsel_reg =3D BD96801_LDO7_VSEL_REG,
+			.vsel_mask =3D BD96801_LDO_VSEL_MASK,
+			.owner =3D THIS_MODULE,
+		},
+		.irq_desc =3D {
+			.irqinfo =3D (struct bd96801_irqinfo *)&ldo7_irqinfo[0],
+			.num_irqs =3D ARRAY_SIZE(ldo7_irqinfo),
+		},
+		.ldo_vol_lvl =3D BD96801_LDO7_VOL_LVL_REG,
+	},
+	},
+	.num_regulators =3D 7,
+};
+
 static int initialize_pmic_data(struct platform_device *pdev,
 				struct bd96801_pmic_data *pdata)
 {
@@ -1053,6 +1259,7 @@ static int bd96801_probe(struct platform_device *pdev)
 static const struct platform_device_id bd96801_pmic_id[] =3D {
 	{ "bd96801-regulator", (kernel_ulong_t)&bd96801_data },
 	{ "bd96802-regulator", (kernel_ulong_t)&bd96802_data },
+	{ "bd96805-regulator", (kernel_ulong_t)&bd96805_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, bd96801_pmic_id);
--=20
2.49.0


--QCSAAauiKArzvHvH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfhHlIACgkQeFA3/03a
ocXRdAgA0aLw5EYOSghegbW/bbxjWzjFuloauoQHjYZYDUAPAntMSaZI3vq72Ku4
TsmKM4H3W/rdPF4KkIZb+BRb5Fjg+TrLW9QXXAzOxfe9AO/iQy18HKC9oKEzp27y
wRXz28VKt3k5GucVcw17UubFV6VARo7EuInnrINGzeXxzKSVE3zrFBY30emm+pBa
A2Ej1U4OS0YWxHL6+uKmf/30mbLjiqR5f/4c5JOzuXB2iYRED/vf+yV3fjj9g8Hc
0lFpOfL/votcxKcd8VY4ApGTXoEXzdSQPgEvGrKtV/d+RPJaai4g2r9jVxz2zsPb
qhePJRu4aUzO1euuTY/rGnlSQ/RPWA==
=4nyO
-----END PGP SIGNATURE-----

--QCSAAauiKArzvHvH--

