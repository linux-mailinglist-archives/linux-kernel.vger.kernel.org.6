Return-Path: <linux-kernel+bounces-184878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD66F8CAD55
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28B71C21B42
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAC174402;
	Tue, 21 May 2024 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1ypRIZl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40DF55E43
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716290858; cv=none; b=rJUMxFwKbyFhrhzLnj0LEoCCjgA8sWuE5P3UQbdsR39c/pmSf4IBg9AcPMeujcLAr25MXRtqGsoP0PCclPEEBWkoVMBoXjAAWMKZ0Ti9sT4Qj4h9qtXhtNPGr7hrizfngxXYDoMzF51oBe5av7BPfxQ/kYopR4xxW09wlKAPPGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716290858; c=relaxed/simple;
	bh=QJEOti30TUFfXopxVupzeWTdP85mJ5RBYrkLXn3WW14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecMFkx5JNT0GSnW5FVE7pTEEoL/7Bzf+YiTmYnXqBY9Sdc/jyEvykRtMXFQNED2f8a2HGjIqomp8QBpUO2tarT0WM0ae9hK4pjbQTyJo1EfEF7eWU09qwk7TqeN0EnpmdV/g4CBxTgqzyrL1RjGlrK+W6Fmu55Wzj60HU0eJ6pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1ypRIZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AC0C2BD11;
	Tue, 21 May 2024 11:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716290858;
	bh=QJEOti30TUFfXopxVupzeWTdP85mJ5RBYrkLXn3WW14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1ypRIZl9T5wuVJ+13fMvNoOrte48ZY4CU3w6cvNKbmvYxoZ/R0oLW1SFi8ubq6Qt
	 Yo8vz4ekYsjcSdQSG23CKEbg0XSs/k06hvVz/rWEkndqtZG82wqvH+6waYL+bNr+9r
	 2MoFhLcAql0yLWLkUB1x2nSw5J0QY0sfNSMTHb9vNv39DJUMFhrq6UQz/wMBQ1wLMi
	 roOptJllLmF3h5/Y0vpoSwJOSMYAsbEe0Pd1iouigeDdqu5ZnBJLMgerk4zQb9B2LU
	 cYuNhCS+e/lpR0jTg7E9fXnV37QIXBK1yC6pejnYRHe7DLk5nWnkscR1CyAQduEFje
	 HMtW3Uwn/xCew==
Date: Tue, 21 May 2024 12:27:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: lgirdwood@gmail.com, jneanne@baylibre.com, eblanc@baylibre.com,
	linux-kernel@vger.kernel.org, nm@ti.com, vigneshr@ti.com,
	u-kumar1@ti.com, j-keerthy@ti.com
Subject: Re: [PATCH] drivers: regulator: tps6594-regulator: Correct
 multi-phase configuration
Message-ID: <ecf39bd8-5a97-410f-9dd3-3c63d60b723c@sirena.org.uk>
References: <20240521094758.2190331-1-n-francis@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rv5BNHrjDlHb1fLH"
Content-Disposition: inline
In-Reply-To: <20240521094758.2190331-1-n-francis@ti.com>
X-Cookie: Eloquence is logic on fire.


--rv5BNHrjDlHb1fLH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 21, 2024 at 03:17:58PM +0530, Neha Malcom Francis wrote:
> According to the TPS6594 PMIC Manual (linked) 8.3.2.1.4 Multi-Phase BUCK
> Regulator Configurations section, the PMIC ignores all the other bucks'
> except the primary buck's regulator registers. This is BUCK1 for
> configurations BUCK12, BUCK123 and BUCK1234 while it is BUCK3 for
> BUCK34. Correct the registers mapped for these configurations
> accordingly.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--rv5BNHrjDlHb1fLH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZMhSQACgkQJNaLcl1U
h9ATGAf9GBMKrVhgY7nhh7NrlJjFIoghxC234utI+ZFGsx7reZIAhc91L8mHUlxk
6G+CkZfN/BAqjjWGTVsEvwkO9kYVcbPyhTAqqbpo/CjJmjstS1KSwnCANo8zZ1M5
lhRhcBfzBFGiExXN9ZR5THCRpusR/+tOhusree2o9XC1KBz5twJR1EAq09pXW5q6
Oa/mOMlmgtmzIVp2wVRKp/3ZMXrBZKvkBY8JgGZ4sUCjf5HDkIGkil5xRdtL7uXS
M9AmwqHJHrXSbDcxidYHSF27MurGyh38PNh5flo/5uC0JVHo73Z2F8ghHCvMAlIM
1n5BPo4PHrJWemkFLQ+Fdw/9p9KZ5Q==
=6YhH
-----END PGP SIGNATURE-----

--rv5BNHrjDlHb1fLH--

