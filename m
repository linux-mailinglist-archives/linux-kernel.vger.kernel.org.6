Return-Path: <linux-kernel+bounces-559381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D97A2A5F2FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6F33AB55B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E39A26773F;
	Thu, 13 Mar 2025 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZyVqgNo"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEED2661A9;
	Thu, 13 Mar 2025 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866199; cv=none; b=qaJDnnqefZ5Afy+XjgFZScMcqTbmnUUPu36Um+j+aqnYCb5u9fzTO+34WNlWSu4SHqlxGBY4T0e2TjQ+VwE56d9/x3ZnvPaPqmllwOhKMfo/OZpnHR8rt7Mh+1Rl2ODL/d9l2ZSekGw23tFWii86m1M9OU3/LW80nsMQ7IBlbIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866199; c=relaxed/simple;
	bh=xVSgqHOSOxmdkD61dULtzVczoxIRLWRI6UVGL5SmrAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbO0t7hCUfa6skEpGXp2lVtNLeNVgpouPsHyAOVjBBcwDPfyci2ajuuT9cDqPWRHtaNW1u3gN8/1M4v0BbXx9XERGv0wkKsM9CwYUdcyZcGjL7ukoumGLJaVbDxvZBwYOs2SyJKrllpMVgH1/chi0OSWC3E+Dd7w/+zHNV8UX3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZyVqgNo; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-548430564d9so920610e87.2;
        Thu, 13 Mar 2025 04:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741866192; x=1742470992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O72QxYrGx6dEw31+z11PLvOjp3ZuGtz5vite0jV6nqo=;
        b=hZyVqgNoIHWpVilMAYFsZpMuOZBlrcDI2oGJKLGSV9aIqtowrPWCucBFFgS2C8zPN1
         PTUK8+dRi81KDFJPE1VvsVn9/QnX3uoJx4f93neM2qc0kM1gFwSpPJAb3eizB0qIK4bN
         evFQx7FrdGTftSPOdffVR6c3XkZ74REtFpnzS1iLIMQBEjKTNCvYHU0Qru/3/OVMXy0m
         wm7gaq7sgFpt3A8kogdpbotFqK07nxONOcvTpSNwKmyN9kvOcpIUIO9I/POsQyPUYGit
         GPMQBCJF9Pe1NN2HAJKms2/bfufi+ZaYsepnypWcQ5Q/XIsW1qGGJK0cWNs65f5IN4eE
         tx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866192; x=1742470992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O72QxYrGx6dEw31+z11PLvOjp3ZuGtz5vite0jV6nqo=;
        b=Iz/aRPJfR/c+8g/V80FHpniJWYgGMGgV6FJ1xyT9hGZ08p60o9RYhrPcT1rQwuwTy1
         t/Qy93W3amG73pgX2nyj0Mu5/wNrlX+YlMfifJN15K730chdrJb99mkf4itzEo53iZ57
         PY/Z3nxl+3HBSCrx+cQQUXQR4w2sMzMOTe+Vu87wgYA4HdPdRfmrz86kM1eEzpi1spKk
         7xtXfeCZTClDbQoiB5WFfDdZo7BbHvgq6XwrZJoodc+0cVqSxG0xSvLsDGwfHuRxPhN9
         vUabxQVmfjDNE4Ths2tqU4ibPtb3tffQaF/wBd+WEZWqAiteTXTRGwwwZxi6bhvHEx58
         qzyg==
X-Forwarded-Encrypted: i=1; AJvYcCV8I1Uhog7prPSsubws89A8ZsLQpSF7XO+6QyKzhUr/m5P4NwzR05WPxhPV5m10GD1l5snC5apQONwN@vger.kernel.org, AJvYcCX7nTRcp1SWcNQwytW5wOJFXQuSaE5b+vwUztE63PXtb1jqlrcYvmEJn7WR8tq4NuHttQ4muwNFZS9YWLU4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzym9scuRtceYdpxcqNz+yjObMiB5bk2pVmKMxTkOW0tgFGAhvm
	M5Xdi1sgMkjDDcGrB3Xh4Y3Pwm+L+HiQ9GJp4N429IOc/nL5u5yK
X-Gm-Gg: ASbGncvAKSrrLlLF+cBtUj7QO7tu0kZZFW9BYug20sKTEGDoQUooDpdZrKznZg3wpz8
	XZvObRnSSkdlr7zG8ZY3mHZo3fO9XjZ/RWrCPkF3CX+HjJbemBXmJCZZvBlbrDzvyFtylweAEB4
	FRujEZdozQszABnu4k65kWMfZVF6gy1kvbvd/sy9vappSV67uDmazH8ffXkr+K13+DKEEoYEu06
	SBrbVarHdmIf+VCFHIrvvAY3Apr2Y1PNm7NnggPZ3U4CyLHvb069ppCsAV8qMeNCLgTP5K+SIad
	H+1NV4aESqx7ozQE2GkIzkdbrmcPlryzyTAS7Muhgeo6IDEToKI3zvwDot48pw==
X-Google-Smtp-Source: AGHT+IFK+t9sXgLqGZqVE3RVe+jm52mF2CZRx6q58EOMlwXQ/mdB1/6ZQLObo7UQeNqWpju9g2ppiA==
X-Received: by 2002:a05:6512:b23:b0:549:8c86:7407 with SMTP id 2adb3069b0e04-54990ec7144mr8622073e87.52.1741866191723;
        Thu, 13 Mar 2025 04:43:11 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7a8b11sm187664e87.30.2025.03.13.04.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:43:10 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:43:06 +0200
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
Subject: [PATCH 11/14] regulator: bd96801: Support ROHM BD96805 PMIC
Message-ID: <a2ad9942ed1c22cfe7b6e8c934c4279a0c125a19.1741864404.git.mazziesaccount@gmail.com>
References: <cover.1741864404.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UTMpQQMjCORDX4ye"
Content-Disposition: inline
In-Reply-To: <cover.1741864404.git.mazziesaccount@gmail.com>


--UTMpQQMjCORDX4ye
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
2.48.1


--UTMpQQMjCORDX4ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfSxMoACgkQeFA3/03a
ocW0Ogf/WkmZu/JAHSDI8Bj50WDT0UKToQMGNRtEEmzQgP0SSSVpijl5fgjsRr0e
QFmVtObOvrgDtuAS0aGV7QdBSGVviJ21VFlXpvhrVurfV7w6TOE+BExQ4LFUs/Ab
3Z9L+yLGjjzOon9U5lYi4y+e8xvQbeYxE3zdBoeTgfLAGZ57bO/tCfe+BHL+9N8h
ykSmct4ke1AFg7LHJ63cmECtPKATvnxANqTbyRFGAsbySFePGsdKDEjV9zoQ2jRU
62c2M2Jh8a8T4AdafI4OPwtEknaxGH8xKpAfSkUUmSXjdkhWOD3nJP7NeDJtNaB3
pd/sKbbYXRa1V48/41JGcxs3OWMyFg==
=0dsE
-----END PGP SIGNATURE-----

--UTMpQQMjCORDX4ye--

