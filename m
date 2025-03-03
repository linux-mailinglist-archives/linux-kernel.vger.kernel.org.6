Return-Path: <linux-kernel+bounces-545161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5ADA4E9C8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD95B423AD1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD8E2D1F74;
	Tue,  4 Mar 2025 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQgWRqwK"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334F0234994
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108739; cv=pass; b=uuuBnQyozyS/Xa0b9/FjAURWZ5T6IBrVdModM2eTwXOF7g6xhzXg2FV8AjvjGwpHv3X+ozumxBJmqkYNX9RELb55S4i0lyeO4hR+k6ncJ0nEaTqDnv4BOlKnqAUDvq36eU+5RyDLE0xCiwG+mGPO+qFM7T+mM3sB+J6gVUIdFo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108739; c=relaxed/simple;
	bh=Ev5SKxfHjDqDzCGwE0MrQkmFFNsf+Ifg6zSxPrf9e4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haCUNnXQtayBx3iiECAoemJ1731hm+DiurEj01+GDxzmJvpfzrwL6NMkxNQvSFe2WuKhYPzLnO6zFIW3mo1OCtJqWiGT/TPnI7DauTUMsXvOS+u2FUJ6lk8VXW1m8dFg8zgMemt193UHWYGGgpCbbh4+k/+K7Ximoa0wQKg7g4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQgWRqwK; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 5E7AA408925F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:18:56 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nQgWRqwK
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6ftR1njJzG0tJ
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:36:47 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 517EC4275D; Tue,  4 Mar 2025 18:36:39 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQgWRqwK
X-Envelope-From: <linux-kernel+bounces-541741-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQgWRqwK
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 8253041D3C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:56:28 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 5AA083063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:56:28 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3AF188B131
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8496210F6A;
	Mon,  3 Mar 2025 12:56:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1E73BBD8;
	Mon,  3 Mar 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741006575; cv=none; b=BGtR7lQsIbcWbfXcssCCdUVcVeLFDDPLdIY0y0/hQlA3BAA53hLC0gc2a0C1kUtUeeWGozS+4mcU+/kLcs/FWU2c6Bj7+TyKajy4jAN6fgmd5xwHPZJWXoS00OCFO6TD9CDXn/W1x+AaGnpILqAPk90YlipxwFOUm3ztwPl6eSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741006575; c=relaxed/simple;
	bh=Ev5SKxfHjDqDzCGwE0MrQkmFFNsf+Ifg6zSxPrf9e4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEfY4MwppZmFrVOIBSRzbGizJiDyFMJ8jZxNijRkNIvVPN+PO6fKCk4OMcIX06tlxvTbESewme3/n/TnRP8h8SerdYk1VJwG8HWD5tLo0OZSfBXewvAQlx+LzrXX1RbgiC+RJy9fgZijIHgGMpL1d9ma6U2PWSSu1j8U/YhT7Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQgWRqwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB27BC4CED6;
	Mon,  3 Mar 2025 12:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741006574;
	bh=Ev5SKxfHjDqDzCGwE0MrQkmFFNsf+Ifg6zSxPrf9e4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQgWRqwKuT1Oo2+hzyUjZaaBeHxS+JzswVkZ3IcpxM+0txxGFd09xfUYwQdAAldMJ
	 3dxfDjO0/g0d5TI1ztufEITw41xWhqqNNpUf8L0xZ7Wvlivx+O3mY+IuTDFm7libiQ
	 wj58t/ZQu3Kbx4xnbqecGbW/T2Tt/sPxeErUViGiKe+XyhgTAvx7LoxGZn5NjgOo2Q
	 rkUoqBsdhVBRmDqHHbcUX3Xh35YRskMrkC+06fWOVf6LERp/KY4ZMM2JfjrRAXNVVc
	 NSVm9SHGlGvXk82LSYrsI24e0GObX3xEpSGRKd2ew0NAamCwyqorOXXPyD4am65Twu
	 BUKwepksALVTQ==
Date: Mon, 3 Mar 2025 12:56:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, peda@axentia.se, andrei.simion@microchip.com,
	nuno.sa@analog.com, paul@crapouillou.net, oder_chiou@realtek.com,
	kiseok.jo@irondevice.com, shenghao-ding@ti.com, kevin-lu@ti.com,
	baojun.xu@ti.com, srinivas.kandagatla@linaro.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH 11/12] ASoC: Tidy up SOC_DOUBLE_R_* helpers
Message-ID: <5b319436-cf3e-4fd6-89a6-87e1afcf1ee1@sirena.org.uk>
References: <20250226153137.2791938-1-ckeepax@opensource.cirrus.com>
 <20250226153137.2791938-12-ckeepax@opensource.cirrus.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RoR8hd1BzWUnIGTH"
Content-Disposition: inline
In-Reply-To: <20250226153137.2791938-12-ckeepax@opensource.cirrus.com>
X-Cookie: No purchase necessary.
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6ftR1njJzG0tJ
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741713396.14676@lljxax8x7aoZaBF9j6ZzAg
X-ITU-MailScanner-SpamCheck: not spam


--RoR8hd1BzWUnIGTH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2025 at 03:31:36PM +0000, Charles Keepax wrote:
> Re-implement SOC_DOUBLE_R_VALUE() in terms of SOC_DOUBLE_R_S_VALUE().
> SOC_DOUBLE_R_S_VALUE() already had a minimum value so add this to
> SOC_DOUBLE_R_VALUE() as well, which makes SOC_DOUBLE_R_RANGE_VALUE()
> redundant, so its usage is replaced.

This doesn't apply against current code, please check and resend.

--RoR8hd1BzWUnIGTH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfFpugACgkQJNaLcl1U
h9AN+Af/fKSNcDYJBdpB2CpuPssT8MvsuizseNovlE8SR67M8irBy34gVRRSEzPQ
EP+yra221mu+SjIjqlpveqTU3GLfX9gCpbr29lgACZhSeKlB310jtdUOitP7BDB2
aTxZ2/dkWWQ/CAY2Lf+qE30in5bWSj5CLCXKrDrnqdHIP2UrCxm7O3PIyVVbD+Ow
aFS7MoPpYasv8AsKpo4CrT/46/Z3blB2K9UwGZqa+yMBEQNJ+v1P5ES6+eQ/4LCr
57Tb/JsATEmXGCEWgX17X8dVnG9nkhAhZ885xFJorhcMS787R63nr6r27DZQJjWR
2num4biSZWf0fB8aoK/cCg9455a39g==
=i4Az
-----END PGP SIGNATURE-----

--RoR8hd1BzWUnIGTH--


