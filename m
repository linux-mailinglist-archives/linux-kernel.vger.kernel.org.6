Return-Path: <linux-kernel+bounces-232732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B09A791ADBE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8482842F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAF61993BE;
	Thu, 27 Jun 2024 17:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD1/f9Ib"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7491817BD3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508543; cv=none; b=j0aS093KrTuIH30jDGNmOC+ZHIoR3efKJM2AQSFVHyNsvYVqHv3UzHbnGIBVKlo6A+OdUeGP50vBHO/5qiwynQ1fh7clsoCbg0uS58PIcAUXZXNnAOURMkQWiuiTsEr4TSSbs5A6nLzPmpQbWefj+psuy7RPLaU0zcPj2kQTEH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508543; c=relaxed/simple;
	bh=+hP+jAPGf0xz4r6p/jABsIHs3HYQLkqZhBI5/pESDCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeCMaupjCXDrIiDbsBzYmZywMqolX3lqmC7EknnWBLfK14rcZubPSBzksUxaC8eJunYnWFYWgwr4naJ6rRm4bWG331iTU+W72xnTQrIYYlgh452g6RAaNfFsLxHNzt4SXoX56qs6hKPrLOcdLIcT4dqvCI9VGPpVEOU9c90CZuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD1/f9Ib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FC8C2BBFC;
	Thu, 27 Jun 2024 17:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719508543;
	bh=+hP+jAPGf0xz4r6p/jABsIHs3HYQLkqZhBI5/pESDCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WD1/f9IbfXhaA3dwCccLIWMm+xixFF6YstvtcEqmQ73OqbzqrZnxpWRbQKbPG6sll
	 3XvWVvG2D/mgRsoZ2Lt2CecqaSd7dctdg4gEug7+MDOcRZbyZPsOCG0P880hoKlXk+
	 uWL2F+8sVkwTL57D7oZeA3kzLHcbfrHk47zrCxLm301QODeFGA/7YlFgkKA+j7Ri1p
	 8p+BE7F1ql3RFCqy109T1wADTX3cZbU5mheMCG1s7nnJAvVxYE5f5nHvEjYU+qOueW
	 GzwUhRc2MsvMheozBGfdDIpw01K8V1PcEulAQsDGL03ygR1IZEOfoYIXSBPRizjE+m
	 yp8Gb1y8vPR2A==
Date: Thu, 27 Jun 2024 18:15:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, catalin.marinas@arm.com,
	will@kernel.org, oleg@redhat.com, tglx@linutronix.de,
	peterz@infradead.org, luto@kernel.org, wad@chromium.org,
	rostedt@goodmis.org, arnd@arndb.de, ardb@kernel.org,
	mark.rutland@arm.com, rick.p.edgecombe@intel.com,
	leobras@redhat.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] arm64: entry: Convert to generic entry
Message-ID: <4030b9dd-0156-4fa6-9c1f-caa6a079b5e5@sirena.org.uk>
References: <20240627081209.3511918-1-ruanjinjie@huawei.com>
 <20240627081209.3511918-4-ruanjinjie@huawei.com>
 <202406270958.D73912B@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qls9jNY9VIi6BMtX"
Content-Disposition: inline
In-Reply-To: <202406270958.D73912B@keescook>
X-Cookie: I just had a NOSE JOB!!


--Qls9jNY9VIi6BMtX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 27, 2024 at 10:01:11AM -0700, Kees Cook wrote:

> I've really struggled to get MTE working with qemu, so likely real
> hardware would be needed for that... I'm hoping the ARM folks have
> access to something that would work well for this. :)

What issues have you been running into?  You could also try the fast
model - https://shrinkwrap.docs.arm.com/en/latest/ packages up the
firmware building and execution stuff to make it more approachable.
Note however that fast is a relative term.

--Qls9jNY9VIi6BMtX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ9njcACgkQJNaLcl1U
h9BoMAf/fYV/j4W/3ZCtQ2XV0g9QtOTD7dteKaITt7biGcEVZ4c1rITAZIxGFUCD
zdOqT4e/kGcZDCFNyuLQHirDZD6dcnsiHs7DKP1y8OzxYfq51m1kEmrHmMUHaRGP
891+8ddjXVziP4jl5krmt2SuT6YBmYzXQ20RwiiRw4A4Egj8XQRXNgQabj8ozmwc
h+bYsxfh7IJfedTQ3q2Y6LHc1AC6D0s3tcFOPe/9Wx3E9YJJNikNp4/CuamgXrBh
EO+d2oMNEB+q7E28cqMXGG9GHZeplg6XenWgakiMbuui335SMWBa1Wl6/Sy1dkjB
/uIBfTR23fuRILQ8W1JmxdQZS4F25Q==
=L4rn
-----END PGP SIGNATURE-----

--Qls9jNY9VIi6BMtX--

