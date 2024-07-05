Return-Path: <linux-kernel+bounces-242691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EBC928B7C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7B02834F7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351A416D30D;
	Fri,  5 Jul 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ru05mTUX"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B613F14AA0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192627; cv=none; b=kXBTxSlEJQuSG+7yEB13oe4tdExrDsRQvRoXQg0i6h2OvXRKr/EjGaPcr0Ctio+MWxzBa+lq2UBppJCnLlmzfE/0EqUfewYaDAk6DOjm/odwMU5Q+pbd7RGx+a/fhTLJmj3n8oVsPqtl3pjVOy6vDSSgiYdVSfggY6tiESv6Yao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192627; c=relaxed/simple;
	bh=HDfTIlNv9e5ezTyTzT0ihQuPbcElfxNoXJYJi+0N0M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NFfbTW+g+kh/gCnwZYTS79UFuTZ75dPzGbxyNf5ElXiXDQvL461dQJjWpXaFlYwfKOVyEPrcPMrHdcB1AFWnYX63qZa73QheaK3GUgSiN92A1DzWw5DtjU1C3nkBWQIiM7G2DTqpnNrcQUqIby9N7oHJMAKMIp5c/TRsTtr1F7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ru05mTUX; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 465FGs5M118267;
	Fri, 5 Jul 2024 10:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720192614;
	bh=SOCJihyMudDYbXAQtiHVqLLecu3CNpgoUVt3jGljzyA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ru05mTUXAvFNW+9NevyEWOIQ4ObvRCSdouqVoVx2lFHXQkEoo/nAuQfedQ+QfPKNh
	 U9BjrJWJuxyheVIbT5yDS8dJgRagg7N6u+Ugfe+OuOM7qw4UHA0aMOQ6Sd+d7jh8xX
	 owDd+UVKGOmae0AHeXRKcH1ZSkoduIKKZ+EYvRFc=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 465FGsPS013070
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jul 2024 10:16:54 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jul 2024 10:16:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jul 2024 10:16:53 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 465FGo6i110570;
	Fri, 5 Jul 2024 10:16:51 -0500
Message-ID: <c6b2a0c3-e8c3-4e7a-90ca-a3b9834c63c9@ti.com>
Date: Fri, 5 Jul 2024 20:46:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [GIT PULL 2/2] arm64: defconfig: Updates for v6.11 for TI K3
 platforms
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm-soc
	<arm@kernel.org>, SoC <soc@kernel.org>
CC: Tero Kristo <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>
References: <37f251a1-f3bd-402f-ab22-cf786c3871d7@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <37f251a1-f3bd-402f-ab22-cf786c3871d7@ti.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------49olJoLJPLagJ6kQj0AEPVIw"
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--------------49olJoLJPLagJ6kQj0AEPVIw
Content-Type: multipart/mixed; boundary="------------8mDuihRvdyg8E6si09AbN22H";
 protected-headers="v1"
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm-soc <arm@kernel.org>, SoC <soc@kernel.org>
Cc: Tero Kristo <kristo@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>
Message-ID: <c6b2a0c3-e8c3-4e7a-90ca-a3b9834c63c9@ti.com>
Subject: [GIT PULL 2/2] arm64: defconfig: Updates for v6.11 for TI K3
 platforms
References: <37f251a1-f3bd-402f-ab22-cf786c3871d7@ti.com>
In-Reply-To: <37f251a1-f3bd-402f-ab22-cf786c3871d7@ti.com>

--------------8mDuihRvdyg8E6si09AbN22H
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfab=
d0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3=
-config-for-v6.11

for you to fetch changes up to e05bc474310336e1ab03ed79112909dd0f74d039:

  arm64: defconfig: Enable TI LP873X PMIC (2024-06-12 21:52:38 +0530)

----------------------------------------------------------------
TI K3 defconfig updates for v6.11

Enable Hyperbus support present on various J7xx EVMs
OMAP_USB2 driver for AM65 SoC
LP873X PMIC related drivers for am642-phyboard-electra

----------------------------------------------------------------
Nathan Morrisson (1):
      arm64: defconfig: Enable TI LP873X PMIC

Ravi Gunasekaran (1):
      arm64: defconfig: Enable USB2 PHY Driver

Vaishnav Achath (1):
      arm64: defconfig: Enable MTD support for Hyperbus

 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

--=20
Regards
Vignesh

--------------8mDuihRvdyg8E6si09AbN22H--

--------------49olJoLJPLagJ6kQj0AEPVIw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEyRC2zAhGcGjrhiNExEYeRXyRFuMFAmaIDmIFAwAAAAAACgkQxEYeRXyRFuM1
rggAssY5Q7Yj20OI5MwE2IbhgRgsaM/EMyjngqbrDKNrRFTSPRVdZ+lZT+jjeTKZAqv8znYW5fVb
It+6FrJ2+ZUj57ICX23XmNCcHxVAizKQN7qAhSNVLyib4NM/9PBM8rK+MV4TM2t6j5u4S4BHrGY8
6UK4sCABlDO3wN8vPpAqNFnZhH7uph19igyR69w8qF3+byVqx6ovfvDUTxZepcLY7/tnHGYSOrYn
4L/bTa9RaVyrRH6bzKVUZOE9ViK5FH0gWYy/gqj6As7mRrZtXeSv3+LIJjRYemYyLEpxH2ql8ecX
Vc73aKTfM1NEz3AAR7Ve0jDYNaSlD2SludZ3OrZhYQ==
=D9OH
-----END PGP SIGNATURE-----

--------------49olJoLJPLagJ6kQj0AEPVIw--

