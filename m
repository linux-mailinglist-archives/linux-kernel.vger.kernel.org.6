Return-Path: <linux-kernel+bounces-559382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E27A5F2F4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA2517D307
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43194267B01;
	Thu, 13 Mar 2025 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWSrgbzW"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0972267AEE;
	Thu, 13 Mar 2025 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866207; cv=none; b=qaTeOBBzzWR4trjlVAraq3qqcg/wlPz7FlAoFtSpioMjfKMsuHRK7RIpeylr0nIdy/ni8LA/n29zOCPP51dXZomw6XhwPCvqrJkYe1b1UEDaIsEdfZIgi0NGam6KjFGFtlOPqGH1/KBxBmqYJZlcNWhxuGpkUMu7oC1kwZbGVSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866207; c=relaxed/simple;
	bh=aOuAHGxcnRtk/Pkiao9pk0UX5ytOAfh8VIkWizPd7hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjoNrWJuH6zLa7MhJJ7/tBtr1A0HrzBlu/0CPfY2JDoTbec1osyRKA9WmOC4vd5cCtQAsdak6ug2OuvJ1QlqNnrjYaKbInHSF7cl34FWIn6h7KZiTck9+IY0TK8pvVp5UT5JdN3vgaqlKIQhI8ZFCWVO2aDhF2Lvmn2/cng85ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWSrgbzW; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-549b159c84cso819997e87.3;
        Thu, 13 Mar 2025 04:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741866204; x=1742471004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJd3ktIYsibSVEvB4l7L9L4g5QLxlan9AKGzvbB0x2Y=;
        b=EWSrgbzWXh9Gu9MSf0ChwMlLaHzY1YR1mHGSFb5QKkw+qohZbDt7Mkm33VqNlTHpPO
         xiOXg1oSjHlEkgUK3TifqXLXj9oy+Lgcduuc+1Q1fRa5SRNySJjMEY/l7ML49/TDpU+7
         ptZYcEFbhPOexHDCWoQrilxH0tjPz/AMq+wUjyr7/8HvUjm+ezC58xStGwC5XviaLOfG
         jggGAqyngi+zaSoCcfTgW36XRmtwcAk+PF8N/Ch5unRZdRI8EI6OieeDv8f7YQm5vG6b
         vXC9klJWfMMD1K+Pb5yArIUbJHWF9/V1s/z0PJieLxY9mTSIYvZRE/U4+pefwKK2V1nL
         /gXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866204; x=1742471004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJd3ktIYsibSVEvB4l7L9L4g5QLxlan9AKGzvbB0x2Y=;
        b=b17BCEhpU2COBL1PFCxAYUHgmFnuwebV1K8akfMWpAqUcRFHJM7k1gJ/MmYvLLJbBe
         7VQcRZwEHfds8pkrQ1963pRCMMPfRSCN1Yy5rFDC1Hj1y9Eu4RG9bQ6uBENIgt0tEoaR
         w+THv5VPxRmdtr59iRaQbHLngt1+l/0NvCvAiIyB+sBkM3cm3tifVkzJiCVqnvZW2pXc
         wJtXTgqNQljsTEAACTNFCfvSDKVG762n/JMLPQSdvN+7rxmIXqZVCUG+be4W3SXFvcJv
         USRg103GLOwpoEQlqSOdM4IdCnKM2wNMqP6Pzk8QmDZXtA+R3X7+A+ssABBWHQyujxBt
         /aCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIPWI8rwJwWrMFPRylkVhzB2lYjycVPFdIxEC7C07ymPo8vXZ4hV4E/bD+DDHFOTedq76nbUt9yTFDzqJh@vger.kernel.org, AJvYcCWpplQJ7//5HiXXgJV9lwqSNcY0qwuB0AylQWSObS7u4ZmZJ4oSo7BaGCdGn04IErm7sKuVON+M1bWU@vger.kernel.org
X-Gm-Message-State: AOJu0YyU96S8YYqDxodZwfHHWjKW/AiTQ+hz9Cy7T1i2+6lpNz6ib7F9
	fJUUEPZ1PVBvXVmGd9WgyqAQlh+4rRsFhhk7miw/wzjsdo/jvho1a1P6QQ==
X-Gm-Gg: ASbGncuw7El0jYxVMhqeRf2F0PBxz2JnCbvBoWFKUvb1kValaHvm+D5Xmfm+ypD2OIz
	Q8ohIcO8TBE/05PVWS3nn//6sq7/2QV6zOrwAZocbxrEHEVYg8t2mBRJYcsdI8gtjfr9ZsVsX8L
	SlmFTfIHyM/5Cf2wpTy2za0QCSsaI8aIPMK7DGwuAxVroUHbCwkzAF0KikWqXOsFhSeQ2IexeKb
	i1qGcbhuCUvY/14vxbKiTBrGdh/LNtj3AkMTUaXkJMXkZVYXfsdl/5ZjIOXjJaw9uTiRdOi8u5O
	InFBUUU+sxC/kmz8Uxp6HlTtW/WwKhyo52L82cWeYInLlI3cTro=
X-Google-Smtp-Source: AGHT+IEG0wltFXtjS/14Jt0pwjdHNn3dsLrpK0PYYKqe3cZjSuD1//Iu9EdunyYhh0xqqi3yIOHgYA==
X-Received: by 2002:ac2:4308:0:b0:549:903a:1bf with SMTP id 2adb3069b0e04-549910b7c7amr7770110e87.48.1741866203825;
        Thu, 13 Mar 2025 04:43:23 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7beceasm188171e87.58.2025.03.13.04.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:43:22 -0700 (PDT)
Date: Thu, 13 Mar 2025 13:43:18 +0200
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
Subject: [PATCH 12/14] mfd: bd96801: Support ROHM BD96806
Message-ID: <8fd61949bdd3a85f19c86fc3e2e768a990803586.1741864404.git.mazziesaccount@gmail.com>
References: <cover.1741864404.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="twVtW0S7FqJP+3Is"
Content-Disposition: inline
In-Reply-To: <cover.1741864404.git.mazziesaccount@gmail.com>


--twVtW0S7FqJP+3Is
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD96806 is from the software perspective almost identical to
the ROHM BD96802. The main difference is different voltage tuning
ranges. Add support differentiating these PMICs based on the compatible,
and invoking the regulator driver with correct IC type.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/mfd/rohm-bd96801.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mfd/rohm-bd96801.c b/drivers/mfd/rohm-bd96801.c
index 2ab4e1c0f9b8..3b85aaa27f54 100644
--- a/drivers/mfd/rohm-bd96801.c
+++ b/drivers/mfd/rohm-bd96801.c
@@ -225,6 +225,11 @@ static struct mfd_cell bd96805_cells[] =3D {
 	[REGULATOR_CELL] =3D { .name =3D "bd96805-regulator", },
 };
=20
+static struct mfd_cell bd96806_cells[] =3D {
+	[WDG_CELL] =3D { .name =3D "bd96806-wdt", },
+	[REGULATOR_CELL] =3D { .name =3D "bd96806-regulator", },
+};
+
 static const struct regmap_range bd96801_volatile_ranges[] =3D {
 	/* Status registers */
 	regmap_reg_range(BD96801_REG_WD_FEED, BD96801_REG_WD_FAILCOUNT),
@@ -617,6 +622,20 @@ static const struct bd968xx_chip_data bd96805_chip_dat=
a =3D {
 	.unlock_val =3D BD96801_UNLOCK,
 };
=20
+static struct bd968xx_chip_data bd96806_chip_data =3D {
+	.errb_irqs =3D bd96802_reg_errb_irqs,
+	.intb_irqs =3D bd96802_reg_intb_irqs,
+	.num_errb_irqs =3D ARRAY_SIZE(bd96802_reg_errb_irqs),
+	.num_intb_irqs =3D ARRAY_SIZE(bd96802_reg_intb_irqs),
+	.errb_irq_chip =3D &bd96802_irq_chip_errb,
+	.intb_irq_chip =3D &bd96802_irq_chip_intb,
+	.regmap_config =3D &bd96802_regmap_config,
+	.cells =3D bd96806_cells,
+	.num_cells =3D ARRAY_SIZE(bd96806_cells),
+	.unlock_reg =3D BD96801_LOCK_REG,
+	.unlock_val =3D BD96801_UNLOCK,
+};
+
 static int bd96801_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap_irq_chip_data *intb_irq_data, *errb_irq_data;
@@ -728,6 +747,7 @@ static const struct of_device_id bd96801_of_match[] =3D=
 {
 	{ .compatible =3D "rohm,bd96801", .data =3D &bd96801_chip_data, },
 	{ .compatible =3D "rohm,bd96802", .data =3D &bd96802_chip_data, },
 	{ .compatible =3D "rohm,bd96805", .data =3D &bd96805_chip_data, },
+	{ .compatible =3D "rohm,bd96806", .data =3D &bd96806_chip_data, },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bd96801_of_match);
--=20
2.48.1


--twVtW0S7FqJP+3Is
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmfSxNYACgkQeFA3/03a
ocXT6Qf9GHv4kVj0p+kl+w7jKhDKmM5R2io6m/uS5RFMCUjfv18ZimvDuirZcfL+
ZVsW6ig8EerNjyeD+mxJpAF32SR+KtAk1/KdvWCcjzpAqK2K9PRdIrNLCbngwaW5
+ajPLifPQxqbO/SEMMJQsjPav6EgRBRWd/3uf5n5688QlHubrgmjhjAN4yQaD2yz
TLsejfSimGMaaN9b8UKboeCMIY28N0dgGlNKdcXAggdTw7lvgmN7EvgHOO5zH7PA
uPxf+k182dk/nlrku5QXjXqfAT57H8VJbZTK0y1rTQPahfY2PD58e20hR9P6AbYt
9+5I8rZizupdr/5DG9zWuQq64oazog==
=CU5T
-----END PGP SIGNATURE-----

--twVtW0S7FqJP+3Is--

