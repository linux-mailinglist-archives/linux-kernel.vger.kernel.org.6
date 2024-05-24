Return-Path: <linux-kernel+bounces-188457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08698CE241
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74F01C2182D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2611292C4;
	Fri, 24 May 2024 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVPlKohn"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968CD36AEC
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716538797; cv=none; b=QE6ZArBXPpWQPLssHzbxF+KNgsNEX5SGE3Nb7B6cDkO3owVomA8LNogbNtJfIoblr3U17QzL2B7pp+ACyMEdQKEaEk3HbdR0JAu1dTRs3ETpqEokGQ3Vas5Br3eWBBCjmMPDYmqAWMe6+IzhE+TRde36qIEVBUii49ODSt5USb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716538797; c=relaxed/simple;
	bh=HaTp4H3GKVf72m4HXWQ/TCDYs50/gy1Mzs+jf6lliNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPSjfXfipqHSWVq6EDB3pMdef+IA3iuL7ZHJphAQtPioY7X4CceQJsSpPL1jaQs201fk/adie4ZxHRO/Uolb7eeAikQk+ij1pusvKJXMNxWoWZj/no3qJgwal7xPYJBeIc8TdcXE/OxH74eNdnztlh+ppvODL8cFeTUPOfIw0Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVPlKohn; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5295dada905so440282e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 01:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716538794; x=1717143594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iq1qNxsQxnP7HnWvmIjJ/56QoNGgF9weszuNGJ5t43s=;
        b=GVPlKohn8+pJ9GOV52hA8ZG+BAtxE6Fp/sNnyJ0zfungLl7LvOTM/qcEQILswMW7Tx
         CBOUTRU977Ad8NK6p4rSV4btBBq0p3ND30H4pXNNWLAFmf6NvKU+doG2VVUaIiHxqa8P
         6Z5IWT+56qPpsme6f7+6HVWReYcmMZHoLH7n2gea93IoFUEJWejDcTww/5Cd2TEJ6diz
         ZZL5BnksRncydJpT6PKi0LzUWZdAEBRI7x5oLnaCjPlk9MFRtNmc7rGsMSdOCA46tIyd
         1lwgpU5dok5nnjYADDhK3jgJqFBh8YA+iwBouR6SK8I/EbDfkI7mYYj4zgTqVuTG91R6
         O+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716538794; x=1717143594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iq1qNxsQxnP7HnWvmIjJ/56QoNGgF9weszuNGJ5t43s=;
        b=nlvgHGdLQgqD3Q/nFjATI3vVBBSz8RQoRYnZ+eqjHllh0eDFDT1jmqVq702CrCjMO4
         R4r1i/OKG1mstFkLuE2/JMK8M+kpAbff1OnvdB9g6Xm0pSbfC3/zFwtad9jmp6hnccbk
         RO2vCLJWQ6TfkcU6F0S+JtvLKLxsxQ1lRLAUaUVBjdHwjromektx+6f7NnUtFKuAnkPt
         acVtOt8it/gGswgsbfCuEzlpxm7z0fg6/fsyKfL/IT7RLfPgT1ZzW7W1r4DDn+zKUGKm
         /CYB6gaxattW5+Kp9v/tymiXEaM+ogBOaoJV6kP46u4d2BnIspqj0V80iFCuvGyJIy1+
         GFOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF3++npfelMLGN4JvjQ6JzWMW7r0ffhXtz4XHsjgb+zVwAKYNII9FcuHEK/JlGwrAsgnA8bTQ7MG9fxydpLuYJm62WyTCzq+lpaixn
X-Gm-Message-State: AOJu0YyUghuO/IKJ784DiQl4nIgfL75UIFE+NAef0s78E1Wmkqy8JxDB
	9wYZBuUICKxVo7c9CK8UGWIePficqZU1lJDHr4TYwRjojnJZ2WW2s0FWWQ==
X-Google-Smtp-Source: AGHT+IGFWZVp5sMKzBEs8zZvrICVgN72DbDBOEv/PLgaJFCAj3oJRleEn7GPdQzod8fBx0RyWNyhQg==
X-Received: by 2002:a05:6512:3e1f:b0:529:a161:4781 with SMTP id 2adb3069b0e04-529a16149a0mr162794e87.7.1716538793678;
        Fri, 24 May 2024 01:19:53 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52970760245sm126331e87.122.2024.05.24.01.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 01:19:51 -0700 (PDT)
Date: Fri, 24 May 2024 11:19:47 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/10] regulator: bd96801: Add ERRB IRQ
Message-ID: <3ebba7116380a65666b5b05835dff8c8f565c473.1716533790.git.mazziesaccount@gmail.com>
References: <cover.1716533790.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D4vwuOjcjiNNFpd7"
Content-Disposition: inline
In-Reply-To: <cover.1716533790.git.mazziesaccount@gmail.com>


--D4vwuOjcjiNNFpd7
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
---
Revision history:
v1 =3D> v2:
        - New patch
---
 drivers/regulator/bd96801-regulator.c | 130 +++++++++++++++++++++++---
 1 file changed, 115 insertions(+), 15 deletions(-)

diff --git a/drivers/regulator/bd96801-regulator.c b/drivers/regulator/bd96=
801-regulator.c
index a1ac068c69f8..e49a9948223e 100644
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
2.45.1


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

--D4vwuOjcjiNNFpd7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmZQTaMACgkQeFA3/03a
ocUvMgf/RsK6SvizI4iVh8PmdjF+C7twMQjUOFlPVg62lSZwYsvMbRQ7enNSVzfX
OaDaP4/emX7D4Z3bodG05nxAUxZx2ZlaxgVU4UvyYr5i5PlHPC3kzwMlYIuFdYIZ
0wpnE9GObE/Hj1loFCYGZeNgbb3xByHmnr4koqZovYJLqtHuQF3x5XVnSaS/2KVx
z8LFKrZmE6h2MgCKG0zoEwOtqumXBNKgtSaFJ7/HMZdXsPmhcOLIy180G5FK+GBb
x3DhC2Ge5gia/3gHjJQHjmY9j74/kWkYUdffudxWJWblyZ1bJCcLJXXcQ/jzAoyy
UYm+1VDBXIWg955ZgNiYvAbOmiB6Xw==
=voqK
-----END PGP SIGNATURE-----

--D4vwuOjcjiNNFpd7--

