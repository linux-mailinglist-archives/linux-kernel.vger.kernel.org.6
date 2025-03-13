Return-Path: <linux-kernel+bounces-559383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCF5A5F2F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4159017D182
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCB3260363;
	Thu, 13 Mar 2025 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5X5oC24"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9998C266B68;
	Thu, 13 Mar 2025 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866219; cv=none; b=nQlmZeJOXZlh708BR1tgiaffL+UAPEIJix6lhwBIOKSRueYCzO8wR6H63gbZG+SpXAf+2SImpDK3N/WHRD+MxxZkRgau2bT2UxhutzdJwfrV86a6aBUgZPLeusKqHghr66ezwVGp7E6U8PFuNjyEPLfhbINncXeEbkN8ZkN+jbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866219; c=relaxed/simple;
	bh=37VGCJ9l34Kl6e8QTDgTw+xjQ93SlK9QihwqNQMovnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sW00E5iPdVcGsUda7OVDhP1taUSHqDlmd0dOPtVmTRjIQdUoMti5YLaqsIj4L/ACWJl0MWD3HwOd+ZHEMmlxFwIUN1qmNQ/CTPOGbHpxL6gafAgkCMRQazqxhhpvUPmLrDYTKDmLuQ6VwzNBjzubxgSfP/AUeKpokmzMGDi0fZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5X5oC24; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30613802a04so9351091fa.2;
        Thu, 13 Mar 2025 04:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741866215; x=1742471015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DVVUMHJT4ebI5yi18DjMis2HZfPjrDvIaHIkuYtdOvA=;
        b=M5X5oC24TjRvlosWP1Fd41IjuIFe9/K2VF9ui8dSU3VuvnyosNHglDQRf3Nuvks8vk
         J2390HEH9M+hIbWT1ikxVU0Lc/2r6HQitrxH6JYCKL+lhgk0JFBYUg58jyVkyr3Fh/HR
         Ha7S6d2HhU0fUMbVLLE9/TzuJS3XMFTu6rLfop7UQNpBAqEErWKrd6RsJqf6F47bmNHm
         qj/xqQLt4nPagpvIl1vYwcf9Aqjb6kbYKIBebcF2oSBYf4OEtkhIsVlKufsryoxGlPti
         lQ4G/0d6nDCTdCLreuM8nCqNL4oWbb7G02hOJcNCa//Izu9LERGb3bLDyx+YKt1OyVdF
         2Jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866215; x=1742471015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVVUMHJT4ebI5yi18DjMis2HZfPjrDvIaHIkuYtdOvA=;
        b=UdZVDt8FtTWmMVHeDGgS9WfpG5kGxYiHcYAx8LKpav509FnzTR3bRSXbJ8usCdhLNr
         Y33LJ7dfVHPd9Y8bkwqmvSq7ls3dyVH5qih6RCiiDY6C8oKxA53ZfKl2XB2262XRK+3b
         SAhBRDfwN//aow6aqGHFtxLxcCQ88LZRBV5fN65MG5lbTZAQm0veM0wd5ksnfPrKQCzT
         I7tUHpwXZpAxDTMiomXKkfyqS/3YFEByrjb9BFgvk7NLJiuCOSwKepMt1vzmpvxgb3WB
         +yhfgZPoZL+6Toq+/OitveFpFxCRRBeVntbFPV4Sp4AcXKs1p1VVHVsp+CZQs3HRBpgq
         uH4A==
X-Forwarded-Encrypted: i=1; AJvYcCUNhATPOF5CSgodjaDtRJDZ5SgUZpQr0mel8VjicfCeMWN7tIWdawvzuTZMSH9Csv9D4oI9qy52Wkwx@vger.kernel.org, AJvYcCVbPI8zGAjglAyK879KOKrw1tByS1/aA8JuRXDcD5YcKMgxQPBkYgnX/+nEjc9ejxq48Eupb9qKlwKrBcOC@vger.kernel.org
X-Gm-Message-State: AOJu0YwW2lJ29pxFHZXs7vAIx1Tix/YC3dMaJ1VU6vKN0kw/VeUrvmKm
	yYVMJStylPv6d6J+Uu7G24PB6HhjZk0BAWhmAuq+fPVUGImee76i
X-Gm-Gg: ASbGncsfRTOBHYX/0ZRXENokQ0IcSHcojaSYlXHjAT1hHcJQ/ozxXRdncTyUXNnzy+m
	0lV7znKkCjtKYTIpJP/XNoPD3SI+3SqL1fPVD1w/rpEEugsY2HsiImjG3SNFWvQoFajHSaxfXCQ
	t/OgWbfJ/bcUXI/WpblZLeq7DFEPs29Q+cnIfvs8bcFyUiwI8jgpQt2XzCMIFXjbTuL5nFNNB+K
	u68Eh8qbXaXXkJH4ziHHiNFms7xDWkHXd69VMNN4R63xDWHNVi0hYdW/e0Wbl6CmvEs68I3aihD
	lS1AOLvmbOWd9Y2zmCMnYWs2XkysbXbqpEa5X+QRa6k5wkFwqs8=
X-Google-Smtp-Source: AGHT+IHHDtAC4wsRKaHF5r9bwCTHbHnjherN8iguJ9N4g4M+s6iIQSB6KZUcrlU8p9B52pxpmTsIuw==
X-Received: by 2002:a05:6512:234d:b0:549:8c86:740d with SMTP id 2adb3069b0e04-549abac0101mr4515428e87.18.1741866215339;
        Thu, 13 Mar 2025 04:43:35 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7ce9e3sm186339e87.106.2025.03.13.04.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:43:34 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:43:31 +0200
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
Subject: [PATCH 13/14] regulator: bd96801: Support ROHM BD96806 PMIC
Message-ID: <1cd9265e4396296d05db100d74f334e7f95c7907.1741864404.git.mazziesaccount@gmail.com>
References: <cover.1741864404.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nuj5i02+lN0dO3xp"
Content-Disposition: inline
In-Reply-To: <cover.1741864404.git.mazziesaccount@gmail.com>


--nuj5i02+lN0dO3xp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD96806 is from the software perspective almost identical to
the ROHM BD96802. The main difference is different voltage tuning
ranges.

Add support differentiating these PMICs and provide correct voltages
for both models.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/regulator/bd96801-regulator.c | 65 +++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/regulator/bd96801-regulator.c b/drivers/regulator/bd96=
801-regulator.c
index d829289942f9..fb9e7c3314a3 100644
--- a/drivers/regulator/bd96801-regulator.c
+++ b/drivers/regulator/bd96801-regulator.c
@@ -962,6 +962,70 @@ static const struct bd96801_pmic_data bd96805_data =3D=
 {
 	.num_regulators =3D 7,
 };
=20
+static const struct bd96801_pmic_data bd96806_data =3D {
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
+		.init_ranges =3D bd96801_buck_init_volts,
+		.num_ranges =3D ARRAY_SIZE(bd96801_buck_init_volts),
+		.irq_desc =3D {
+			.irqinfo =3D (struct bd96801_irqinfo *)&buck1_irqinfo[0],
+			.num_irqs =3D ARRAY_SIZE(buck1_irqinfo),
+		},
+	},
+	{
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
+		.init_ranges =3D bd96801_buck_init_volts,
+		.num_ranges =3D ARRAY_SIZE(bd96801_buck_init_volts),
+	},
+	},
+	.num_regulators =3D 2,
+};
+
 static int initialize_pmic_data(struct platform_device *pdev,
 				struct bd96801_pmic_data *pdata)
 {
@@ -1260,6 +1324,7 @@ static const struct platform_device_id bd96801_pmic_i=
d[] =3D {
 	{ "bd96801-regulator", (kernel_ulong_t)&bd96801_data },
 	{ "bd96802-regulator", (kernel_ulong_t)&bd96802_data },
 	{ "bd96805-regulator", (kernel_ulong_t)&bd96805_data },
+	{ "bd96806-regulator", (kernel_ulong_t)&bd96806_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(platform, bd96801_pmic_id);
--=20
2.48.1


--nuj5i02+lN0dO3xp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfSxOMACgkQeFA3/03a
ocUD6AgAqOEi2FLJFEU8mmru9URPSLjoFj6MJ3fe+Z3ZfJv5n1VJCXtATIwXu+Ic
ieSfREA8+dluWdAMPRwMiElLQ+81a+bxQkUTmNcs2iLvVOnDuOghtNfbEUpdlXeI
xYF026zjpbCPevAYOf59JJvYPe2Si/Gp0/tolc/fw1HhvIE2F2gCiB5uUv6nsgRt
QRU5TF0//WUBktivi/dSW8urxFYU2EvmJP5adkzf7h1ZtCQSJKc2eh82ZwCIIOq5
zvu04ZId+eRO5hC/yV0D4yPil33IfeFCMsNTrNnkjnpktnaVtx1yc9DVHe2M4tLQ
Lk9+PiFDEI9SvWvUPqLYMxwfMxOtEQ==
=mEk8
-----END PGP SIGNATURE-----

--nuj5i02+lN0dO3xp--

