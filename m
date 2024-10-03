Return-Path: <linux-kernel+bounces-348589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0B998E967
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5740286549
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 05:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA97D5A79B;
	Thu,  3 Oct 2024 05:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkgBUiMA"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143B42110E
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 05:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727933711; cv=none; b=iZpBe+7FYffxKqEwg/qs+T902rcMF2sCWcOxn2WUX3aIFMdreR2P5+WgHEPOIcWLLZap5f1dcwu4IHl+JWumC4nNyGsF4HfnrJpwXwjjzYe2iWVHTyBS8kstl5TCTky5XicvNwXhD0whzaGkZx3C7P1e65Xzwa3xuRETA6s1raM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727933711; c=relaxed/simple;
	bh=3IlHvMzfXs7DVVZZJeCQMP0OmMSJFsoLjhUdtfWr4zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssIJS1Nlfj40RZt3lgTzOTl16idSibFEXXyrCJ7a0eHlcW4Wc2fGKPSkCAVgZN8V7xTL6Cb3TYyJuO52SqcU0yZQhIniDklozPvF7G2hgURDiUrH6CKlghPRwfajMkYpRGb7MrnWYduyxHXPoO3780SZyeo3uFrXNIx1dFzV+cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkgBUiMA; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fadc95ccfcso5861651fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 22:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727933707; x=1728538507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+bONBH8vRb45l8ZwAcQrWMX7Zp4OI2J4UYOF4hZhTE=;
        b=UkgBUiMAla+Zqk120n4DUkVOYH8LqfsfDCltCUc1Emfzp1wuVX6Hdw4PJyGYuC44hZ
         qEYOumHn5lu89VU2M8RFynWWtD6qqpymJnfuJS2waYQgEp76BzSgIriIIT+EiPieAM9v
         ixelx4VlyVWRM4ydtIA6XJebf2qmOvxiCNmh+orTAB5OhWn5ZM9cB7IhVKpACfC20XrR
         hzpGQ6IVLR1l8c+PNCiXN85lwo0va2qtq0rjyNrqQRZNw+tZz8lAXnsOPYd5epV3dFDV
         mTdKezHNfiT8J8IzO1MiqZXrM4T+klQGYKR/VnAePf5tzL2NfWwcPgrXB+seM3cuaynF
         PSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727933707; x=1728538507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+bONBH8vRb45l8ZwAcQrWMX7Zp4OI2J4UYOF4hZhTE=;
        b=ISVAeocLs5ePk4PMtPZ/XOg9y6gPOAp3Hzgbb750ymlaUfi6neaLPxHxlV/+KPycWy
         JjFz+3qlHvronohur16OikldjSkMwedyU8dlPAiNXs2K/Wzpy5WjSmXrPoqnSoeydpTR
         rnsNwsjOuZv6WXnVgLjAqWi+DG9UENGLKApd4WKa0GhkSZz2uDVYIjW/2nkUjbtCjhwE
         1eowPjUKQ9r+ds7JuNVV27U6hr6zTyGJuqP4ntL9nv+QMZno9D13LkWe5Mb/pLIKYya3
         wYxB5m7jYSqppT1xantn+UXIxzEduwdU/ZGxhq2cp3YQft9QP+jbVGugL/ayx6oqHEyz
         AuEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCLDp0PZWkrTqJX6b2EiPkDmXHfpcLQshNAVrqdBY9h5bsCcgA17Mac1bYVy48gb8joUlc7Q4tljt9JpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSPpdUlSrsUHcSCoCPAgUlbt+Q1/4Nv8Ousb+N3FTTACb6oIdr
	bUCaoFFyQIqpqYbhpLY5Yi1KuwoWKH5iFSDDhERe07DHnHwOoZHh
X-Google-Smtp-Source: AGHT+IFwd4okNYyype2THoni3IobGnrJuAueiDpRaPgkciz1GtILj6y3uWZvyojSryLOTHLv0zyL6Q==
X-Received: by 2002:a2e:751:0:b0:2fa:dce8:7387 with SMTP id 38308e7fff4ca-2fae107f75bmr26902041fa.32.1727933706770;
        Wed, 02 Oct 2024 22:35:06 -0700 (PDT)
Received: from mva-rohm ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faeccb1bfdsm1074751fa.138.2024.10.02.22.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 22:35:04 -0700 (PDT)
Date: Thu, 3 Oct 2024 08:34:58 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] regulator: bd96801: Add ERRB IRQ
Message-ID: <9a32fc1a5210195551ad6df1cd1242235c280a04.1727931468.git.mazziesaccount@gmail.com>
References: <cover.1727931468.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5PtqFW143PZN+gKM"
Content-Disposition: inline
In-Reply-To: <cover.1727931468.git.mazziesaccount@gmail.com>


--5PtqFW143PZN+gKM
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
v1 =3D>
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
--=20
2.46.2


--5PtqFW143PZN+gKM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmb+LQIACgkQeFA3/03a
ocVcdAgAxAdHTRRuExhAVmc60iG+jHPa5xirsylY2S+AcQNhJh5OqiPXNy5HwqCe
1/21unQPHLnjXCsHs7pMUbO5JSuBUvBstjVTSXguHo4wAPEyFHiEmaSy96P60dZp
vchpLLaqCh5N8MggoLcibB1WQ0KHqW0HGEFkbWTCHyfF3iyjL60D4vvpB9gzrWmb
KrCPjJT+tdLCZQVGW1KiYwq5hncc7J0tdi/UjdljVSCRpdrAVSX8ECH2Xu7+dkLO
aI4iiXXlEsKfwPW973v164MdNiYCKCH6+WbQI/+gCcPqu9eyPgyCz4lBwFDqghhY
Wxm1CPwAwsi81X5KbImUA/d3S8uVtw==
=rQQy
-----END PGP SIGNATURE-----

--5PtqFW143PZN+gKM--

