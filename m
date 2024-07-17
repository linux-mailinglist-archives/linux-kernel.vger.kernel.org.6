Return-Path: <linux-kernel+bounces-255278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621C4933E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C9A1C20EBA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D15181310;
	Wed, 17 Jul 2024 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h940+Iqp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942CD11CA1;
	Wed, 17 Jul 2024 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226151; cv=none; b=KBie72mZgD3kDk/LzKiTYNxiDTsWiOgFWWid4plErZEhw3sD4GodtRaLcizWjt2QSBAqPYdqYp9JReEdxYjlrOZj2m1AH37C3p21xmiFsdYDxxy0BkA1NKOiwV0ivZvePj5RSs7V5haoxv/WjCZiXfG6KPUUXLnbjDVPLQotTNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226151; c=relaxed/simple;
	bh=qpw0gmAROKWq5JO+7E5zB8zsltIbZLSipVW5lR6xYQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZ/fio8pxs0dRTImqi8iVb/4ax7XX2i7WEF/fm71pyJUqNyCSGbdPNOeaXMrNT26nSS9mFfNYf8Yj8HqBBK4vSwYFX0ujzemx1cLgSMx8LzXSwQgQiKY+nXKjqRatXzbJR7kpZZxNXncJU8QLfHgHOVYFWOouykgQAEBrq8cKkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h940+Iqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AC9C2BD10;
	Wed, 17 Jul 2024 14:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721226151;
	bh=qpw0gmAROKWq5JO+7E5zB8zsltIbZLSipVW5lR6xYQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h940+IqpJyem6GtzsO4sb1hZM/ffjIzjJofavNnuywmhXnOhOtUBZ2sL3RhQuOiO5
	 FMITsQAlJ73EUs1mv4rdOE4999czj5ra56NxeurRFvOfuiVb9XWWL3pUhChgHnxG0k
	 yZ3aahpBz/kOvgOjYgGOKeeIDjHFXP3xi60i8JjIeCOcmr82dHwrcOSRS8DWMCJTCe
	 Sv7oegk1I08LHuRKYcLY8VfLhXV/r4EFtrL4ijuHFEYavQK5UvQ9Pgl1FtlsbeT4Dw
	 ijJI4ld0CRTOm29a7ZynpXw4N84C+djDx2wRXQyXCfhvMW+fKat2MspRRexJamUm0g
	 sy5jpM2cgb+Fg==
Date: Wed, 17 Jul 2024 15:22:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Yanxin Huang <yanxin.huang@unisoc.com>,
	huang yanxin <yanxin.huang07@gmail.com>,
	Wenming Wu <wenming.wu@unisoc.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: nvmem: sprd,ums312-efuse: convert to
 YAML
Message-ID: <20240717-cartwheel-kangaroo-2a1fcc140d7c@spud>
References: <9fba73ce66f1f3b7b2a8f46e7c21f60cff5a85f0.1721199034.git.stano.jakubek@gmail.com>
 <17ccb895a54d7754d3ddd6de633ad045a5271b4b.1721199034.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="37FUYZgEJ4JbXWhT"
Content-Disposition: inline
In-Reply-To: <17ccb895a54d7754d3ddd6de633ad045a5271b4b.1721199034.git.stano.jakubek@gmail.com>


--37FUYZgEJ4JbXWhT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 08:55:14AM +0200, Stanislav Jakubek wrote:
> Convert the Spreadtrum UMS312 eFuse bindings to DT schema.
> Adjust filename to match compatible.
>=20
> Note: the UMS312 clock bindings include doesn't seem to exist (yet?), so
>       the UMS512 one was used for the "CLK_EFUSE_EB" define.

The example is literally just that, there's no need to use the defines
at all.

This looks fine to me though,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--37FUYZgEJ4JbXWhT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpfTogAKCRB4tDGHoIJi
0gQTAP9J9dNClzcI9XGiMKYxJMpNdcbUOkK/5hVlRwTFSzMPyQEAyk8UQ4HPDsst
qe7w2jLvfqJTjlTghm8cOHpLmmLV9gI=
=HL5f
-----END PGP SIGNATURE-----

--37FUYZgEJ4JbXWhT--

