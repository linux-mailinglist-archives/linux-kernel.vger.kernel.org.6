Return-Path: <linux-kernel+bounces-335892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F31297EC2E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2A31F21E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732921993AF;
	Mon, 23 Sep 2024 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQOREanU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FE553373;
	Mon, 23 Sep 2024 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727097692; cv=none; b=SUOgrvHMDgJkiUkqyqSMTRO69wIupV7DU2AjRyjVcnxQ8gqyd3yrvh9g8d6ux/hGC7N7pHlcBkd8GqRB1EVhrS4o5bHKnV3lOTwTE98rMBJX9S8/xNv+vh4O65kqd1h52wvSHq9cdLreniV/bkiMu4Uqu8Kh/fq+/ZlZR7fa5fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727097692; c=relaxed/simple;
	bh=E306zOT+XloAE6oX3ODJdm/0hX6vuEMFsI2lvp4roaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jp3XYbDM5JSCJEiTPEQ0r4vLSm6usJNezg53giiA5P45gB/FZLk0CQvzGuG01+e5mvsBrRQya6AFS64bNe7dD7qbSgfCldctSFzBAZddgPekbmQjW1qc8RFslqKn+XsIueuc4N7tdXMBo4tZND50dL4S6PN7r/x1zObxdr4xbdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQOREanU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A8FC4CEC4;
	Mon, 23 Sep 2024 13:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727097692;
	bh=E306zOT+XloAE6oX3ODJdm/0hX6vuEMFsI2lvp4roaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQOREanUwrJXVJpkgSXkf0kxXdips9J5navkZLaKvH1PatNZb8pncPpbj5jDZ5EuS
	 EaRZBIhd6WsC3mrj3Xc+vOToUL7x+IU7EVm4tk8pTTPL8Nto1kwg4kyvjwkJWM8U08
	 eSPvayD/4KAjWnbXsoZSJYq2CM+JBuC4n5cJ1AY7CIT33SlnOhkQgnet8mGThvPWqb
	 07HGaSoTSEuRUDzJoiiZowu90BYdcVYPpK/ZQpJ/nm2VzRUpnsJ+BF6njHf0+SL+Oa
	 bNgqJ4YXf/rz3HWih7/e69xkr6OTJZv8jtBtEmrG8jdaWnJ480Gbbc2dDol/wmhCMP
	 j/JNIFJuIbCZA==
Date: Mon, 23 Sep 2024 15:21:28 +0200
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 4/5] hwmon: (pmbus/core) improve handling of write
 protected regulators
Message-ID: <ZvFrWDF6Pn9zOb23@finisterre.sirena.org.uk>
References: <20240920-pmbus-wp-v1-0-d679ef31c483@baylibre.com>
 <20240920-pmbus-wp-v1-4-d679ef31c483@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6iy5Tqbs7EFl+Qz+"
Content-Disposition: inline
In-Reply-To: <20240920-pmbus-wp-v1-4-d679ef31c483@baylibre.com>
X-Cookie: Editing is a rewording activity.


--6iy5Tqbs7EFl+Qz+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 20, 2024 at 06:47:05PM +0200, Jerome Brunet wrote:

> +int pmbus_regulator_init_cb(struct regulator_dev *rdev,
> +			    struct regulator_config *config)
> +{
> +	struct pmbus_data *data = config->driver_data;
> +	struct regulation_constraints *constraints = rdev->constraints;
> +
> +	if (data->flags & PMBUS_OP_PROTECTED)
> +		constraints->valid_ops_mask &= ~REGULATOR_CHANGE_STATUS;
> +
> +	if (data->flags & PMBUS_VOUT_PROTECTED)
> +		constraints->valid_ops_mask &= ~REGULATOR_CHANGE_VOLTAGE;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(pmbus_regulator_init_cb, PMBUS);

I'm fairly comfortable with this from a regulator point of view, modulo
the suggestion I posted in the other message about registering separate
ops.  The fact that there's three combinations of ops is annoying but
doesn't feel too bad, though I didn't actually write it out so perhaps
it looks horrible.  In general removing permissions is safe, and without
separate steps to remove write protect (which I see in your patch 5) the
writes wouldn't actually work anyway.

--6iy5Tqbs7EFl+Qz+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbxa1gACgkQJNaLcl1U
h9CpcAf6A49BIiFBHQIkvhxz+iKWNjQtbVSuuTT82zLviL66UgU2vRovsAhYS1rg
2NtJZ+FxJU5oy5j0qotaNYx4mBPTgqHYn6blBbOFZx1ds3JhkKz7Os3UNoxDe0dP
DkIWtIN+wpBbgKhPDF3ATHZWdQTdEiLN9XPQliY+jf1SZGULqNy9p86OpM92e2wt
sq4wfx3MQqADr8pPVuaGa6zcUBRj+zMUZGhVSHhEpvywNCcJJMckmzLgoFYh/EUJ
NPIJwhEb+FbVCFdNlFJs3/8bXl5LkkAtvowQs78thZdrd5aX7wCX2opybklVZU34
zIsYRtqtDicc+r16ww6AiztXn0F4kQ==
=5FU0
-----END PGP SIGNATURE-----

--6iy5Tqbs7EFl+Qz+--

