Return-Path: <linux-kernel+bounces-301014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 015FA95EB8C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2601F2104F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD2F13A276;
	Mon, 26 Aug 2024 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ8Rs4pj"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471FE2BAE5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660118; cv=none; b=p2aNExIC1+fcRqF5o7ep/vqFzpKJmI5fQbfPT3LDEuO/yDKlIfu+ZHsCvaXlbtPTXmyhqeesFa33hKUvOs8/hH2ALBWImb+3cS6LDZkDlSuuM9RHi4eMB0x+WuD1klnzmgUOTVOhIG9HaIjUVFjfI0rZUMe4atT+w1sltHteL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660118; c=relaxed/simple;
	bh=Srz+/ers/t9rPMuiOaUsp129OhleTgCXsrzQZHqEzbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lF/H/Y9hADKr2oFQ0jhI2cpvC8iAe9ozpTIJKFUjhY5OnWKUBkxehTUQfRMw4D0eKsaA+NetA+y47S1hQyHY3aJsz7kg7gkOXsay+ig3hf88JBBx6/YLw0VB63jjj/EvCzCm3974JoH1v+ApYlIFXvLNpybGtSkBtKin4MhW7SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQ8Rs4pj; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5343e75c642so2564426e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 01:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724660114; x=1725264914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TD4OEv6YDTa2yG/bLKxocPkgLI4sxoPDGZoiF6c69sA=;
        b=PQ8Rs4pjTmFySel+WTGIFdLjySioRBGfJSYbYPZ4VPjP4FZn8zYpfiGCg1xjfWbwPY
         u4EA8SaVx4Tf/u6Go9BUuyjnQFlQpreC5r9qwjt3crP7/PNyGvxD/Rzk6as68zEHXnlQ
         6J+gczE4eySfz9e3kp9RZbT2BTWjaeOxDOfBadYaxwMsZHUAeRm1ROtHpJ9RfDhl5lW0
         GqbWJ9jnOZS3pYip2bMLgyAoHNF8eow7KoaanfCptYc+6VlMNa3a43oC4DLRrNHIiG49
         qRuIsztDPVS/jtfmnNIVKFmO5fOJ94er3qTmdE84yNZaze0bqmfjKl69CDvLSBGRSmkR
         xNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724660114; x=1725264914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TD4OEv6YDTa2yG/bLKxocPkgLI4sxoPDGZoiF6c69sA=;
        b=TIhF6JxiW0uYKG1VhwORLKfmQRf728xuhEOxq9BWL9rV4muUImnASUjSoNs4jvWVSi
         maKraU9rP+4ZB/YwcfbegAxIc9ygWcc2OFURsRLM4z50PElGaXaR4r6Gd6Z+mJogS99/
         JEAbLMrIDPMLiE1MW+rMqMOSBQ1Au3LeDAdDsr8L23IGfUwzBkKIKm4xB4fesjvCZ5Ti
         HGeY4QFdpSPjoq3CJOMY8zjADQ5pmhD23JqX+BmrobyqBHkcXlFIgSjQbQYt/1WxyvuZ
         bsmSbLuHFHzKDkc6Nx1A3iIKPDmsYPJRcOLTJCfShDHX4h5ArM8a1cCwjtBKUIOXMslQ
         sEhg==
X-Forwarded-Encrypted: i=1; AJvYcCWeeuui9BgTpu8x8BLuVodGZqERag08X3wW/3PBwSMIPFmZY1Sf6tnzvgSiZ3bH5NBLt+zD9X+TLbMAABA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjGQVnGdgELOkA2DSDkR05TSGXDmDiDnb1mgPl6Nost3dJlRRb
	DS6JGekKMiJcnD7lal9LSNC8zGeMBb97eCtldqYLzpgD5/GdBwQA
X-Google-Smtp-Source: AGHT+IGBg5QnifVakmjHlU8HiiZGJOQtTDWrdXTiISLfMsgACyx3GgKJPMXBF/CGvFFI+E8L8Kju/g==
X-Received: by 2002:a05:6512:3d1d:b0:52e:9a91:bba3 with SMTP id 2adb3069b0e04-53438832e72mr6038287e87.15.1724660113823;
        Mon, 26 Aug 2024 01:15:13 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ec6365csm1409888e87.134.2024.08.26.01.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 01:15:12 -0700 (PDT)
Date: Mon, 26 Aug 2024 11:15:09 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] regulator: bd96801: Add ERRB IRQ
Message-ID: <7dee4a1a885aa3d518c21b4bd32f7cfa41ce18ef.1724655894.git.mazziesaccount@gmail.com>
References: <cover.1724655894.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HcxC6w7uhvJnH7Zf"
Content-Disposition: inline
In-Reply-To: <cover.1724655894.git.mazziesaccount@gmail.com>


--HcxC6w7uhvJnH7Zf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ROHM BD96801 "scalable PMIC" provides two physical IRQs. The ERRB
handling can in many cases be omitted because it is used to inform fatal
IRQs, which usually kill the power from the SOC.

There may however be use-cases where the SOC has a 'back-up' emergency
power source which allows some very short time of operation to try to
gracefully shut down sensitive hardware. Furthermore, it is possible the
processor controlling the PMIC is not powered by the PMIC. In such cases
handling the ERRB IRQs may be beneficial.

Add support for ERRB IRQs.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Mark Brown <broonie@kernel.org>

---
Revision history:
New series (only ERRB addition)
v1:
	- No changes

Old series (All BD96801 functionality + irqdomain and regmap changes)
v2 =3D>:
	- No changes
v1 =3D> v2:
        - New patch
---
 drivers/regulator/bd96801-regulator.c | 130 +++++++++++++++++++++++---
 1 file changed, 115 insertions(+), 15 deletions(-)

diff --git a/drivers/regulator/bd96801-regulator.c b/drivers/regulator/bd96=
801-regulator.c
index 46ca81f18703..9443e386eaed 100644
--- a/drivers/regulator/bd96801-regulator.c
+++ b/drivers/regulator/bd96801-regulator.c
@@ -5,12 +5,7 @@
 /*
  * This version of the "BD86801 scalable PMIC"'s driver supports only very
  * basic set of the PMIC features. Most notably, there is no support for
- * the ERRB interrupt and the configurations which should be done when the
- * PMIC is in STBY mode.
- *
- * Supporting the ERRB interrupt would require dropping the regmap-IRQ
- * usage or working around (or accepting a presense of) a naming conflict
- * in debugFS IRQs.
+ * the configurations which should be done when the PMIC is in STBY mode.
  *
  * Being able to reliably do the configurations like changing the
  * regulator safety limits (like limits for the over/under -voltages, over
@@ -22,16 +17,14 @@
  * be the need to configure these safety limits. Hence it's not simple to
  * come up with a generic solution.
  *
- * Users who require the ERRB handling and STBY state configurations can
- * have a look at the original RFC:
+ * Users who require the STBY state configurations can have a look at the
+ * original RFC:
  * https://lore.kernel.org/all/cover.1712920132.git.mazziesaccount@gmail.c=
om/
- * which implements a workaround to debugFS naming conflict and some of
- * the safety limit configurations - but leaves the state change handling
- * and synchronization to be implemented.
+ * which implements some of the safety limit configurations - but leaves t=
he
+ * state change handling and synchronization to be implemented.
  *
  * It would be great to hear (and receive a patch!) if you implement the
- * STBY configuration support or a proper fix to the debugFS naming
- * conflict in your downstream driver ;)
+ * STBY configuration support in your downstream driver ;)
  */
=20
 #include <linux/delay.h>
@@ -733,6 +726,95 @@ static int initialize_pmic_data(struct device *dev,
 	return 0;
 }
=20
+static int bd96801_map_event_all(int irq, struct regulator_irq_data *rid,
+			  unsigned long *dev_mask)
+{
+	int i;
+
+	for (i =3D 0; i < rid->num_states; i++) {
+		rid->states[i].notifs =3D REGULATOR_EVENT_FAIL;
+		rid->states[i].errors =3D REGULATOR_ERROR_FAIL;
+		*dev_mask |=3D BIT(i);
+	}
+
+	return 0;
+}
+
+static int bd96801_rdev_errb_irqs(struct platform_device *pdev,
+				  struct regulator_dev *rdev)
+{
+	int i;
+	void *retp;
+	static const char * const single_out_errb_irqs[] =3D {
+		"bd96801-%s-pvin-err", "bd96801-%s-ovp-err",
+		"bd96801-%s-uvp-err", "bd96801-%s-shdn-err",
+	};
+
+	for (i =3D 0; i < ARRAY_SIZE(single_out_errb_irqs); i++) {
+		struct regulator_irq_desc id =3D {
+			.map_event =3D bd96801_map_event_all,
+			.irq_off_ms =3D 1000,
+		};
+		struct regulator_dev *rdev_arr[1];
+		char tmp[255];
+		int irq;
+
+		snprintf(tmp, 255, single_out_errb_irqs[i], rdev->desc->name);
+		tmp[254] =3D 0;
+		id.name =3D tmp;
+
+		irq =3D platform_get_irq_byname(pdev, tmp);
+		if (irq < 0)
+			continue;
+
+		rdev_arr[0] =3D rdev;
+		retp =3D devm_regulator_irq_helper(&pdev->dev, &id, irq, 0,
+						 REGULATOR_ERROR_FAIL, NULL,
+						 rdev_arr, 1);
+		if (IS_ERR(retp))
+			return PTR_ERR(retp);
+
+	}
+	return 0;
+}
+
+static int bd96801_global_errb_irqs(struct platform_device *pdev,
+				    struct regulator_dev **rdev, int num_rdev)
+{
+	int i, num_irqs;
+	void *retp;
+	static const char * const global_errb_irqs[] =3D {
+		"bd96801-otp-err", "bd96801-dbist-err", "bd96801-eep-err",
+		"bd96801-abist-err", "bd96801-prstb-err", "bd96801-drmoserr1",
+		"bd96801-drmoserr2", "bd96801-slave-err", "bd96801-vref-err",
+		"bd96801-tsd", "bd96801-uvlo-err", "bd96801-ovlo-err",
+		"bd96801-osc-err", "bd96801-pon-err", "bd96801-poff-err",
+		"bd96801-cmd-shdn-err", "bd96801-int-shdn-err"
+	};
+
+	num_irqs =3D ARRAY_SIZE(global_errb_irqs);
+	for (i =3D 0; i < num_irqs; i++) {
+		int irq;
+		struct regulator_irq_desc id =3D {
+			.name =3D global_errb_irqs[i],
+			.map_event =3D bd96801_map_event_all,
+			.irq_off_ms =3D 1000,
+		};
+
+		irq =3D platform_get_irq_byname(pdev, global_errb_irqs[i]);
+		if (irq < 0)
+			continue;
+
+		retp =3D devm_regulator_irq_helper(&pdev->dev, &id, irq, 0,
+						 REGULATOR_ERROR_FAIL, NULL,
+						  rdev, num_rdev);
+		if (IS_ERR(retp))
+			return PTR_ERR(retp);
+	}
+
+	return 0;
+}
+
 static int bd96801_rdev_intb_irqs(struct platform_device *pdev,
 				  struct bd96801_pmic_data *pdata,
 				  struct bd96801_irqinfo *iinfo,
@@ -788,11 +870,10 @@ static int bd96801_rdev_intb_irqs(struct platform_dev=
ice *pdev,
 	return 0;
 }
=20
-
-
 static int bd96801_probe(struct platform_device *pdev)
 {
 	struct regulator_dev *ldo_errs_rdev_arr[BD96801_NUM_LDOS];
+	struct regulator_dev *all_rdevs[BD96801_NUM_REGULATORS];
 	struct bd96801_regulator_data *rdesc;
 	struct regulator_config config =3D {};
 	int ldo_errs_arr[BD96801_NUM_LDOS];
@@ -800,6 +881,7 @@ static int bd96801_probe(struct platform_device *pdev)
 	int temp_notif_ldos =3D 0;
 	struct device *parent;
 	int i, ret;
+	bool use_errb;
 	void *retp;
=20
 	parent =3D pdev->dev.parent;
@@ -824,6 +906,13 @@ static int bd96801_probe(struct platform_device *pdev)
 	config.regmap =3D pdata->regmap;
 	config.dev =3D parent;
=20
+	ret =3D of_property_match_string(pdev->dev.parent->of_node,
+				       "interrupt-names", "errb");
+	if (ret < 0)
+		use_errb =3D false;
+	else
+		use_errb =3D true;
+
 	ret =3D bd96801_walk_regulator_dt(&pdev->dev, pdata->regmap, rdesc,
 					BD96801_NUM_REGULATORS);
 	if (ret)
@@ -842,6 +931,7 @@ static int bd96801_probe(struct platform_device *pdev)
 				rdesc[i].desc.name);
 			return PTR_ERR(rdev);
 		}
+		all_rdevs[i] =3D rdev;
 		/*
 		 * LDOs don't have own temperature monitoring. If temperature
 		 * notification was requested for this LDO from DT then we will
@@ -863,6 +953,12 @@ static int bd96801_probe(struct platform_device *pdev)
 			if (ret)
 				return ret;
 		}
+		/* Register per regulator ERRB notifiers */
+		if (use_errb) {
+			ret =3D bd96801_rdev_errb_irqs(pdev, rdev);
+			if (ret)
+				return ret;
+		}
 	}
 	if (temp_notif_ldos) {
 		int irq;
@@ -884,6 +980,10 @@ static int bd96801_probe(struct platform_device *pdev)
 			return PTR_ERR(retp);
 	}
=20
+	if (use_errb)
+		return bd96801_global_errb_irqs(pdev, all_rdevs,
+						ARRAY_SIZE(all_rdevs));
+
 	return 0;
 }
=20
--=20
2.45.2


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--HcxC6w7uhvJnH7Zf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmbMOY0ACgkQeFA3/03a
ocV0YQgAn3sPaPeSo9CY7V9F0K0345XXMNGvoBH0xbI8kjxWgXOxCv3rhLUmx4/v
UwlH7ePaxRed0JGpIgEllKbB6NxowrOdYYC8pCsTQxVkDOnsWIyf/ZjfRigMo/kw
cY2xlHxD1a3XyFYXvjBBmdyznmWI+cIDSm8q3PNJBBJfJE+uGtxri+SSBltVHHs7
1fmA1tU8NVCUL34cTHl2kIknxR02OFghDU1tifNa2TmcyUx31Y+z4pIKnSEoIU9Y
MiG6Eg7/1bTYobP/HMsubXKxfk/xndjf4fCJrXqddkpDoYFeIqte/yi0MkQ7sBAq
Y+SBffoRlO74RiZIJsV9d7yunrjzDg==
=CXWT
-----END PGP SIGNATURE-----

--HcxC6w7uhvJnH7Zf--

