Return-Path: <linux-kernel+bounces-409931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ACE9C9389
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D6CB27C83
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B581ACDED;
	Thu, 14 Nov 2024 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="fQ4a4y9T"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21241AC444;
	Thu, 14 Nov 2024 20:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617679; cv=none; b=r7OM7TWvMoNwA+MlJK0mFSLszOv9nDdeNeGiezYcMqUcO3B+D0n8Lhgl7hRBJlV0rNpYzgEk/9PW86jffhqWxrhfE1tg38d9gI6Ar4q3kBr/1H/CvY5sXy99huiFrg4dp4o87jfSxBqdXGOD+p2FcgqkDe/pbvN3JZIBuaUVoS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617679; c=relaxed/simple;
	bh=fC1CyN/jUcLq5zElWf+TEdfY6+GtKrVkUWm/RCiagnQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WwgtZ/iCGLqqCKQCCaSGUMmhSEvdSgbPtBMDSpHDUw2zcChw3mchRSbh1JQk/yWr80abbA8wIPMh+TmovhWv9lmoTpqkSth6VIeOZgGIELNRTuuDVdSeui9w7oS7k4slmtHAcGB+U9FF+eWC3GIhEOrCMqPoLvcxzrcTm98thB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=fQ4a4y9T; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 169331C00A8; Thu, 14 Nov 2024 21:54:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1731617668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=6AfdPO9uto6PI3w/9dGE4/G2+im6nBiFczmI7RkVNog=;
	b=fQ4a4y9TTpo8sb0/IkNeQXVjfCLr45g4TXpiWzy7rb5OV9/DaiJQfgaxT/VVKSEBnHfwhj
	u6K9N0D2hCd1bsnzgkwOrbWC59MMeENYi+AXGObXDWj18Xk9tJwdBaSzZN/pAn5BZgsjqh
	uTWSGvRpM1qKqxt6580gUFd2QkzEM9E=
Date: Thu, 14 Nov 2024 21:54:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: linux-usb@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>,
	oneukum@suse.com, gregkh@linuxfoundation.org
Subject: Thinkpad X230: broken USB device causes softlockup and kills whole
 system
Message-ID: <ZzZjg4VdtrU0Vx70@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rss/zPvErh0U6pBU"
Content-Disposition: inline


--Rss/zPvErh0U6pBU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I have x230 here, and it seems to have trouble with one of internal
USB devices. According to logs device misbehaves, and eventually
causes softlockups and whole system dies.

I guess I could just open it and reseat the USB bluetooth... or I
could try to gather logs, and help debugging. Is it worth debugging?

This is kernel from Debian 12.

								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--Rss/zPvErh0U6pBU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZzZjgwAKCRAw5/Bqldv6
8mk1AJ46GpEJfeDNA8J9hoG+eUuHCw3bKwCeNjxumMLxUsM+GtPnpIcYeDAMiq0=
=yaW7
-----END PGP SIGNATURE-----

--Rss/zPvErh0U6pBU--

