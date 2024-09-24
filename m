Return-Path: <linux-kernel+bounces-336740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7633984013
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60F4BB240F3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41B514BF8D;
	Tue, 24 Sep 2024 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFdu8cOm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3132214B092;
	Tue, 24 Sep 2024 08:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165538; cv=none; b=cBuS8BjZJHpG1dDqi6AX3YKqAY/RfoG1+mOF7m6LedtnTgRGnngmKbftxAIl6AeZZcJmhnYpQILZSR6qMGLHvObsPw57B0oaD0CikHxd5+HafCUoADoeSgFsphwTKH+RzSsCpiPspgUBktvGWtOVpQsl+FXXdhu6fhMg282nSps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165538; c=relaxed/simple;
	bh=iUpcSaGr7iLjsSYAwxOzfjwVdfOIH/Rhk21DNLcNFV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2esneXlJaBYt6lStVXxdBLEmVC3uFIr81hrkrz+FtwTaQ/D3R0h1bhdMDq2YSstib2gKGC5cyNBVZHqqi3b/7epZ8VjiSu0NDeq7Ytb/qNMaCxQawpoKGiH8x8gqoYwjb8XZyxJJWhh+NfH/TaBNn7CDlj/ZCAY9A3Ke4lVNuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFdu8cOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4FDC4CEC4;
	Tue, 24 Sep 2024 08:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727165537;
	bh=iUpcSaGr7iLjsSYAwxOzfjwVdfOIH/Rhk21DNLcNFV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFdu8cOmjZsMjW/g/TQA7xx3YjdjRoAmTdLQGnzDDoWIsOwL5OKTwJc3EVuUK33p6
	 JxJtTWT2tA7yp75DFRsYzJeo60ajsxmq56p03Qda15sD9Vz7l6rsWd8xppUQqsved7
	 zuoS/GBC7rRpDkxl2IChyWq4SBEDbHOaG1hM/EmPXYsbGJOGonqckTuorW74++8Am4
	 GtCSVSLnsxBtrfMizWgdObuRlJeqY90BbnguKp84BCoQiwlBsiqm9KGqy6hLbXKOxK
	 IQ6q6KhuFOclj9k7nXoKzl+MkN5Pt63W7ow6wIJ04YVg9mTQH72Ago+O85Uw1Spk7Y
	 kzA2GWcIgf2qA==
Date: Tue, 24 Sep 2024 10:12:12 +0200
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/5] regulator: core: remove machine init callback from
 config
Message-ID: <ZvJ0XIF8FW_HiM0I@finisterre.sirena.org.uk>
References: <20240920-pmbus-wp-v1-0-d679ef31c483@baylibre.com>
 <20240920-pmbus-wp-v1-2-d679ef31c483@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aTcDCwg1q99Fo/13"
Content-Disposition: inline
In-Reply-To: <20240920-pmbus-wp-v1-2-d679ef31c483@baylibre.com>
X-Cookie: Editing is a rewording activity.


--aTcDCwg1q99Fo/13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 06:47:03PM +0200, Jerome Brunet wrote:
> The machine specific regulator_init() appears to be unused.
> It does not allow a lot of interactiona with the regulator framework,
> since nothing from the framework is passed along (desc, config,
> etc ...)
>=20
> Machine specific init may also be done with the added init_cb() in
> the regulator description, so remove regulator_init().

This makes sense regardless of what happens with the rest of the series.

--aTcDCwg1q99Fo/13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbydFwACgkQJNaLcl1U
h9Cj0ggAgEOWV5/gcx0JmZoCxeIxvIpNMnR1BVx7O0ufkxYPPWRSPjH+jijsNftG
qS2xJ9EFhZafzVrSgPs0/w2JiN0AEFPnUnEFU9jT77QNOqUJ+LRNymytO2u6gHhI
dUTSiDgLD/swzh0cuMF2QaYDPTJMsaUjmlpQqKiRNyu97lfnJ87FvsMsXWLsgI8H
JZzppy5zIAoXHP1B9+GumG0nn8JM4HuWhqqUvIKHNK9onn1SmFKVJSOW/LsW8hZz
QHJ3J8WOtkDFwldDFaYxKJQNDIB6jlA7XFe6UgmfP5w1RWdqseiYU2YXqiHo4tXk
f0yyXlGLdfDQ1BTStP0/vJgQ+1t+HQ==
=WKI4
-----END PGP SIGNATURE-----

--aTcDCwg1q99Fo/13--

