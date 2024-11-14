Return-Path: <linux-kernel+bounces-408818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB599C83E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6986FB225C5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FAC1EBA0F;
	Thu, 14 Nov 2024 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EELPGuMT"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1B11E50B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568821; cv=none; b=PUdo104KCYYAnnGIzM/AQN2nnfYe1M0oaLFsS1RBa4oRC1bhDbPQ4/VqYkJH1jpmaFa2f78Va7dVfIem4GFjFi77Hy1eSOPixy3NL/hNvUrBrM7DXe8go3sxxYeuItSrZyaI9REKSvv1F68mNmtSLsut//Xer2ylxiLKADyiYyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568821; c=relaxed/simple;
	bh=zgky1j2aFfjl+hd4xlKRKeSlNO9nWVhZn5rkK7CSDuI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tfVryU2XZSgzIRUAGIuqxFjW07KFDY0EXIgBf6gNm8FqIR0EgR+oRI9/zF/jSft2zvRKsnNobpvm1FKAL2KRSRihRk+WO0yIBKbU0e8oF+X17j/tc1r8kmQbcwip4dQT66dR3QyCB2CI+hcCbt86afVkHjIGZcnXAJINRFv5fsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EELPGuMT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53d8c08cfc4so197264e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 23:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731568817; x=1732173617; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1CLbYiDjOmhi7BUQON9dwJTmGxEjLLat5Mat5RF6Th4=;
        b=EELPGuMTz7lEQFmEMFxJSPhl8DV2b//ALosY0FFFvwGW1JThb2Fe4TKpF8SL3UB7HH
         qRUWsHkaElD82iCVsah0oFVbqkkjuTjgQMY41CKFlj9dg/OSwFyVCWzuvBt6CKRLjN1M
         TBMAIGFj5EDZZyBYpiK7yvFgGdqAvArKGDgkfD8JnCrHkdDj9QZWha9TUJm1Z++rfgaY
         qPvL+RLL+r4UZkRLpIx4Ss80vXtmuNvHknsH4bNvWRTJb6Xjw4wCRT895yeHccT6xoJb
         1JuQdW5/xc9KfFkIvHveRQRlaZ0vlQHRQP0BEzHoMRWLraOGnkXWBxerQMFJKqoi3oA1
         Yu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731568817; x=1732173617;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CLbYiDjOmhi7BUQON9dwJTmGxEjLLat5Mat5RF6Th4=;
        b=Gxc0m4Rd6vD2t/uCLwPY0hCRl/Xotc/LIzjNc9oJzXr6WN/CVB71vzLOSYeRjKQiTJ
         L7KUK5jS6gl7NC2iFULlOYug+hAGQ40326nEC8h7qqAMD7ejy0mg3MTclsMf9lKgo/aD
         tEqS8kB+1T6TLnuZbVg4lhpXH3SFlBhVAYzRWTTTsBEnGTjp5iucHhxmzTd0Obhv0ci4
         1l+fhpYnD/IuTLzZjzInKRGFZ6rsmUFRbnKFM1qY3+2ZArGTfGrXpwAsi/j+qkZ/HSsE
         5XBxkm89GyW1yeNvNRtGbeJBesJKyxcXkgdVrLbyQWR4jG07nwdElpdyzIpazdzg1tIU
         gL/g==
X-Forwarded-Encrypted: i=1; AJvYcCU46ZEJuTYElsx/a0YGofAffhXmdTsH2rr8WU4kRtQrAIcvbcBqlwp420iitjPZrCrkWtqkRQwz5eirm5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxImYWFaFbsBcntIVGURK5NNEU9mbL4kAh6kiJu+TRsJERGvOgD
	uFF7J+jd7cYcSnH6ZlEYnAq9U6QYsMZu+t8DWgMysU7YJDpMeM9+Iv7yT8GJ
X-Google-Smtp-Source: AGHT+IHZtL6F08gDQdPZ2tIZ0ORXRn70FzW41KTygwOA8SEkXem8NlGRAkrnUtTjUgHU9JZAdjM8SA==
X-Received: by 2002:a05:6512:3c8e:b0:52c:9e82:a971 with SMTP id 2adb3069b0e04-53da5c2a138mr435539e87.7.1731568817349;
        Wed, 13 Nov 2024 23:20:17 -0800 (PST)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da653dff0sm87474e87.195.2024.11.13.23.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:20:15 -0800 (PST)
Date: Thu, 14 Nov 2024 09:19:59 +0200
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] regulator: bd96801: Add ERRB IRQ
Message-ID: <ZzWkny4lKpY09SX5@mva-rohm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ntE+gc/XLTeMHbfd"
Content-Disposition: inline


--ntE+gc/XLTeMHbfd
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

This patch was part of the:
https://lore.kernel.org/all/cover.1727931468.git.mazziesaccount@gmail.com/
The MFD part was applied by Lee, but I didn't see the regulator part in
MFD or regulator repository. Perhaps it fell through the cracks? I know
we're late in the cycle but I re-spin this now before I forgot... We do
always have the next cycle, right? :)

 drivers/regulator/bd96801-regulator.c | 130 +++++++++++++++++++++++---
 1 file changed, 115 insertions(+), 15 deletions(-)

diff --git a/drivers/regulator/bd96801-regulator.c b/drivers/regulator/bd96=
801-regulator.c
index 9876cc05867e..3a9d772491a8 100644
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
 #include <linux/cleanup.h>
@@ -728,6 +721,95 @@ static int initialize_pmic_data(struct device *dev,
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
@@ -783,11 +865,10 @@ static int bd96801_rdev_intb_irqs(struct platform_dev=
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
@@ -795,6 +876,7 @@ static int bd96801_probe(struct platform_device *pdev)
 	int temp_notif_ldos =3D 0;
 	struct device *parent;
 	int i, ret;
+	bool use_errb;
 	void *retp;
=20
 	parent =3D pdev->dev.parent;
@@ -819,6 +901,13 @@ static int bd96801_probe(struct platform_device *pdev)
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
@@ -837,6 +926,7 @@ static int bd96801_probe(struct platform_device *pdev)
 				rdesc[i].desc.name);
 			return PTR_ERR(rdev);
 		}
+		all_rdevs[i] =3D rdev;
 		/*
 		 * LDOs don't have own temperature monitoring. If temperature
 		 * notification was requested for this LDO from DT then we will
@@ -856,6 +946,12 @@ static int bd96801_probe(struct platform_device *pdev)
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
@@ -877,6 +973,10 @@ static int bd96801_probe(struct platform_device *pdev)
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

base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
--=20
2.47.0


--ntE+gc/XLTeMHbfd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmc1pJoACgkQeFA3/03a
ocXw4wf/XqOelYToQHjC7/XUs0lQQqcNGu3YDj5Xn6OBWg0fpb0IgOep7u3y4WTc
9n4o1PXxOp9wExFURqi7cSDvZkuFek1od7GowPwXVhmrYtTP99rUN1ce0p5IvZXY
12sZ7q6AKjRBwvz6Byqi+FN45yJDfBMJtTX8ktybNCjIU/VDch8dU38SbYvZVHR9
Bsx+bHDrDo75fl6+WIgHeLm4uFnB21tqSrMhsciHxwgwRYkJajhbvbImPhol35xM
RoM/KBS6qh0ADm0WJxoffRqdTjJlvFFBIb/Wn9aKKTNDndbxK5TpnFbJAoPejcrk
VXyq7QHAHhDn8DeZBEAudS4YfC+dTg==
=u/CZ
-----END PGP SIGNATURE-----

--ntE+gc/XLTeMHbfd--

