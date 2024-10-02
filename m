Return-Path: <linux-kernel+bounces-347177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3163098CF16
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6316A1C20F5B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE9A194C67;
	Wed,  2 Oct 2024 08:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="atJroNnP"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3B194AFE
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858572; cv=none; b=kedvaK0gs8LmgVtl2d5w0t12tIpYWd9B7tcF+pqTdj8rn8fKND5pWrs/IBAKBKAWNwHa+KxJnk3nfyBZTncCz5G4g61orbhn0cXBQAeg7xjsUocZvZirk4aMJ3B9I3DDC54oyJgHBb2Hidhy1CrZyHGfT1WMYnr7rJq9vkQNITo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858572; c=relaxed/simple;
	bh=Fho/u7XPToQIEjq7grzhdHP+G5mWXF1/UCRRAVC6ACg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gx6ePlQ+1gMTFVjgJQ93hOXpbXfw6PU5pmVSd2pD+NO5cwcY2vyYe5RvaqnbhQvNHYyo0fJpnOcRb2yWIKAQxzGyHyjimmFArINYjYheFCY8rUO7DvQtXbr9knOIFy+Gh1/8Ic7b9zdA/WsT8Wp4xyCGOdOBMFsWuUo4avq1sg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=atJroNnP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cbface8d6so78695525e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 01:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727858568; x=1728463368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pc31gWs8Z7rkkCJ3WpoMBFB94R1v8sVApDnxIgoPj1s=;
        b=atJroNnP0ysC2WQJTweOgd0fFZ4xn0wPLBJt2isnWlLOJ6G9r45FW+fALz0RnpntzJ
         YRw9e3Y+moi3dLgvTD9rHQgEtFcKGDg90IEnPuCetEjDzQYmK2CDufeDZ8YYv6txEKYr
         SZOpRPDT0DfQJBzUWOOuxTrp/O+3vZdR5ufoow+ObYgEC+X7bEPoyQaUKjWv2506gjWH
         n1HKeUDWXUSy2leR601ABhb6D4maC0gJXOgd/8CZI7JbcV8uUM2xirBn/lAKJzLaRWSC
         KElJpP2Qsj73+SbkvLPXjL0FnmLm3/F3XoUeLFSooOvSLnYTELvEguMa+mviFnGtrI3T
         YGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727858568; x=1728463368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pc31gWs8Z7rkkCJ3WpoMBFB94R1v8sVApDnxIgoPj1s=;
        b=azvLv0z7rwA+sjNxa+5aGHHtu0fOH47tIkYRxgHyEicvsBQcJP241bPsTYRUg7zKnb
         Q65js1B20yYVekLpC8BBhlu3J3tFyCgsD9sfFT+049hvZ+lvXMlRHBT2Oft8BBgp1le6
         ewvmE7LHAcDA4uR9zOvctK7vKu6Xwn0rhNkdI131yTuDUvYcLWFUNEwCDtOm9yYHPMZC
         bLNwgZv4bIQQTx1AuOeGEErI3qZU2XUuLHcf6oIrLZrYzwjm2pi1QQYmdSrZBOHhCBe6
         VPPiQJNmRD1s2XyEdQe34VEnhVw6eZKT51NJ4GNdyvvj8qCIu1fyoPbIxgw+KfNC82vt
         G97Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBc28sm5jL0f5K9pGb5NqOx14OrU7eGX8RAg/dIiLtT6sDQdx5UfEvCDr7hAflU+E1UT426VU7exeHBEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEq2bXo+jAnV0cBIpj5R/DG1NxDRSublxik3/DqqwlyDfVSoT0
	tZYgqcMlPk1IYZiCts+lrPXr/EYrw5EscRqT/qLIiaB9CoYzCaJgG169ZGBTjCE=
X-Google-Smtp-Source: AGHT+IHXxdnmb7Z3y3wULak05OBKFXhJJqLfiYMSNHT9ez6CmAKH8H5b+kqwmAN102OwW4Js2w9P2Q==
X-Received: by 2002:a05:600c:4ed4:b0:42c:de34:34d8 with SMTP id 5b1f17b1804b1-42f777ef18emr19650415e9.27.1727858568137;
        Wed, 02 Oct 2024 01:42:48 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a01f4fasm12291815e9.38.2024.10.02.01.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 01:42:47 -0700 (PDT)
Date: Wed, 2 Oct 2024 10:42:46 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 0/3] reset: Requesting pre-deasserted,
 auto-reasserting reset controls via devres
Message-ID: <kmrr7tougm7mf5n2xmj55f4tjwvj52nrnfcpdsfzln7dps6v6y@oorzfjdau4z3>
References: <20240925-reset-get-deasserted-v2-0-b3601bbd0458@pengutronix.de>
 <vvthbvqhcvaau2bfvlg7yajpeybrvlvqdmbqzgygk6wyjcf7di@lfwuqmpk2u3z>
 <c5d318947728e9e5b66d11542023b79452705ca3.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="22w3vuvmkgbfe5qv"
Content-Disposition: inline
In-Reply-To: <c5d318947728e9e5b66d11542023b79452705ca3.camel@pengutronix.de>


--22w3vuvmkgbfe5qv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 05:50:59PM +0200, Philipp Zabel wrote:
> Hi Uwe,
>=20
> On Do, 2024-09-26 at 07:57 +0200, Uwe Kleine-K=F6nig wrote:
> > Hello Philipp,
> >=20
> > On Wed, Sep 25, 2024 at 06:40:08PM +0200, Philipp Zabel wrote:
> > > There is a recurring pattern of drivers requesting a reset control and
> > > deasserting the reset during probe, followed by registering a reset
> > > assertion via devm_add_action_or_reset().
> > >=20
> > > We can simplify this by providing devm_reset_control_get_*_deasserted=
()
> > > helpers that return an already deasserted reset control, similarly to
> > > devm_clk_get_enabled().
> > >=20
> > > This doesn't remove a lot of boilerplate at each instance, but there =
are
> > > quite a few of them now.
> >=20
> > I really like it, thanks for respinning!
> >=20
> > Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> >
> > Two small notes: I think __devm_reset_control_get() could be a bit
> > simplified if it used devm_add_action_or_reset() instead of
> > devres_alloc() + devres_add(). I also would have prefered an if block
> > (or a function pointer) in the release function instead of a ?:
> > construct to select the right release function like e.g.
> > __devm_clk_get() does it. But that's both subjective I think and
> > orthogonal to this patch set.
>=20
> Thank you. Not sure about using devm_add_action_or_reset(), but I'll
> look into using a single release function.

The switch to devm_add_action_or_reset() would look as follows (still
with two release functions):

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 22f67fc77ae5..499dbcdedabd 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -1231,53 +1231,43 @@ void reset_control_bulk_put(int num_rstcs, struct r=
eset_control_bulk_data *rstcs
 }
 EXPORT_SYMBOL_GPL(reset_control_bulk_put);
=20
-static void devm_reset_control_release(struct device *dev, void *res)
+static void devm_reset_control_release(void *data)
 {
-	reset_control_put(*(struct reset_control **)res);
+	reset_control_put((struct reset_control *)data);
 }
=20
-static void devm_reset_control_release_deasserted(struct device *dev, void=
 *res)
+static void devm_reset_control_release_deasserted(void *data)
 {
-	struct reset_control *rstc =3D *(struct reset_control **)res;
-
-	reset_control_assert(rstc);
-	reset_control_put(rstc);
+	reset_control_assert((struct reset_control *)data);
 }
=20
 struct reset_control *
 __devm_reset_control_get(struct device *dev, const char *id, int index,
 			 enum reset_control_flags flags)
 {
-	struct reset_control **ptr, *rstc;
+	struct reset_control *rstc;
 	bool deasserted =3D flags & RESET_CONTROL_FLAGS_BIT_DEASSERTED;
-
-	ptr =3D devres_alloc(deasserted ? devm_reset_control_release_deasserted :
-			   devm_reset_control_release, sizeof(*ptr),
-			   GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+	int ret;
=20
 	flags &=3D ~RESET_CONTROL_FLAGS_BIT_DEASSERTED;
=20
 	rstc =3D __reset_control_get(dev, id, index, flags);
-	if (IS_ERR_OR_NULL(rstc)) {
-		devres_free(ptr);
+	if (IS_ERR_OR_NULL(rstc))
 		return rstc;
-	}
+
+	ret =3D devm_add_action_or_reset(dev, devm_reset_control_release, rstc);
+	if (ret)
+		return ERR_PTR(ret);
=20
 	if (deasserted) {
-		int ret;
-
 		ret =3D reset_control_deassert(rstc);
-		if (ret) {
-			reset_control_put(rstc);
-			devres_free(ptr);
+		if (ret)
 			return ERR_PTR(ret);
-		}
-	}
=20
-	*ptr =3D rstc;
-	devres_add(dev, ptr);
+		ret =3D devm_add_action_or_reset(dev, devm_reset_control_release_deasser=
ted, rstc);
+		if (ret)
+			return ERR_PTR(ret);
+	}
=20
 	return rstc;
 }
@@ -1472,21 +1462,16 @@ EXPORT_SYMBOL_GPL(of_reset_control_array_get);
 struct reset_control *
 devm_reset_control_array_get(struct device *dev, enum reset_control_flags =
flags)
 {
-	struct reset_control **ptr, *rstc;
-
-	ptr =3D devres_alloc(devm_reset_control_release, sizeof(*ptr),
-			   GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
+	struct reset_control *rstc;
+	int ret;
=20
 	rstc =3D of_reset_control_array_get(dev->of_node, flags);
-	if (IS_ERR_OR_NULL(rstc)) {
-		devres_free(ptr);
+	if (IS_ERR_OR_NULL(rstc))
 		return rstc;
-	}
=20
-	*ptr =3D rstc;
-	devres_add(dev, ptr);
+	ret =3D devm_add_action_or_reset(dev, devm_reset_control_release, rstc);
+	if (ret)
+		return ERR_PTR(ret);
=20
 	return rstc;
 }

Only compile tested! In my eyes that's an improvement, but up to you to
decide.

Best regards
Uwe

--22w3vuvmkgbfe5qv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmb9B4MACgkQj4D7WH0S
/k7o7gf/cEoTfd0JobQTBU//o21mQcMpPKTuhNnr5uDdnX8sGTzIWObip1KwI08T
qM9QhteqsL7W0G+F0YqyJ98EaN6saSo19LALgYZ+YaELiSJxHy29euRTA9uEOGLm
wobaLf3LYlkB6F0gqiISWQImYpY9tWq4DzXFtxDeE6MlQ6BuQLM2EkNtw8dGERB/
gGEN/fkvn7V9XtsA4kFTTm3AIL7rx5nDRhTK0FQJR1ZNnS5LTpmZj2sQNnaFPzds
PbpwaTTvUx5zp0il3EdtPReGl5kJy0f9BNQmLnx/YuVEU+kmSyX7TpAc+2/igwot
R/R5L+IWcW4Dwl+bnIaxcILfy0CZzg==
=Jrwf
-----END PGP SIGNATURE-----

--22w3vuvmkgbfe5qv--

