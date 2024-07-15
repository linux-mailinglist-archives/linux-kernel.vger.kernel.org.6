Return-Path: <linux-kernel+bounces-253002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 510D1931B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E235FB2200F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBBE130E4B;
	Mon, 15 Jul 2024 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bjqeqgm1"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326636E61B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 19:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721072003; cv=none; b=DXsG5AOTIswW18KLnzoRVEezvU+X9V2bX04Qh4y9GXSoSsXKUeNDPLzif2LLyu3feFqeSz8dNSZl+6HUgYUampIRNDmfE25ItZgrWRDbNyXposqn6M59w2vOdZvDZSxPKQqbwN3cBaQWbJoOK+BhtrPOpQBXXhl8GLoUr1wo8Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721072003; c=relaxed/simple;
	bh=XvO/IQPBY3WxMzOIIj1lPrjiKqO7ITQ9tRLogvdaoz4=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=ZD5ipDVALXZw941f02xvE/YSc5/SDQHEDTuhW3bJN880XSu8TaRKZy4qdMi1SPNyY4Z9JuI3LRuxt//9oIGSrYi3BodlwCWZeDoxwvmxUeVpl1oJXqO76iy++eZB9OQj+y6MOOl3Ai2ObhTajIeLz38lcyxWMQ+4KPkjnUmHu2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bjqeqgm1; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46FI7p3p126761;
	Mon, 15 Jul 2024 13:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1721066871;
	bh=hQ9KDt0pj5QqeR51RglSiqAIoTDr1j7wa4/OE1HUhrs=;
	h=Date:From:To:CC:Subject;
	b=bjqeqgm1ZFt00bEoDMcquuQZ/dBdYg15taX2LiPwv+e4EXaNsoPs8S/ENB3hdi/xb
	 rL6VAxqW6pq9kNFfQOFl24qATWvTXDxHW7ro8QObD0Ht6xyMiWXO7XXscgxs2diTOJ
	 zMFh4X3ez95uXKev8Cad3m3VC7VWwA/Y4T5YAO90=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46FI7kWW014962
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 15 Jul 2024 13:07:46 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Jul 2024 13:07:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Jul 2024 13:07:45 -0500
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46FI7g72004328;
	Mon, 15 Jul 2024 13:07:43 -0500
Message-ID: <aacd1e96-9ff4-4222-9f4d-29e63041f7fb@ti.com>
Date: Mon, 15 Jul 2024 23:37:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm-soc
	<arm@kernel.org>, SoC <soc@kernel.org>
CC: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>
Subject: [GIT PULL] arm64: dts: ti: K3 devicetree updates for v6.11 - part2
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------RUwPAC00nLsJ4vnxysuoeY8i"
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--------------RUwPAC00nLsJ4vnxysuoeY8i
Content-Type: multipart/mixed; boundary="------------ueqxuF7AE95w104VQykrKzYI";
 protected-headers="v1"
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm-soc <arm@kernel.org>, SoC <soc@kernel.org>
Cc: Tero Kristo <kristo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Nishanth Menon <nm@ti.com>
Message-ID: <aacd1e96-9ff4-4222-9f4d-29e63041f7fb@ti.com>
Subject: [GIT PULL] arm64: dts: ti: K3 devicetree updates for v6.11 - part2

--------------ueqxuF7AE95w104VQykrKzYI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi ARM SoC Maintainers,

Please pull below PR which consists of a late fix to my earlier pull requ=
est:
https://lore.kernel.org/linux-arm-kernel/37f251a1-f3bd-402f-ab22-cf786c38=
71d7@ti.com/

The following changes since commit 6406c5d5512c0814b8c155df7f833a98d9069a=
72:

  arm64: dts: ti: k3-am62a7-sk: Reserve 576MiB of global CMA (2024-07-03 =
19:51:21 +0530)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3=
-dt-for-v6.11-part2

for you to fetch changes up to cc5049007d722364bca4a4eeb619d5629733a004:

  arm64: dts: ti: k3-j784s4-evm: Consolidate serdes0 references (2024-07-=
12 17:08:40 +0530)

----------------------------------------------------------------
Late fixes towards v6.11-rc1

First patch fixes warning splat seen on J784S4 due to overlapping
serdes0 lane. Second patch cleans up the serdes0 references for readabili=
ty

----------------------------------------------------------------
Andrew Halaney (2):
      arm64: dts: ti: k3-j784s4-evm: Assign only lanes 0 and 1 to PCIe1
      arm64: dts: ti: k3-j784s4-evm: Consolidate serdes0 references

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 25 +++-------
 1 file changed, 8 insertions(+), 17 deletions(-)

--=20
Regards
Vignesh

--------------ueqxuF7AE95w104VQykrKzYI--

--------------RUwPAC00nLsJ4vnxysuoeY8i
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEyRC2zAhGcGjrhiNExEYeRXyRFuMFAmaVZW4FAwAAAAAACgkQxEYeRXyRFuMp
XAgAvyMc9Sy66U1Vk0pNe6ebRIFaA2Tt/Dwp4FuOsoCT/7I6jW9uonvRLqY4XjkQJhm9ER/vzPXS
EYAKDHQlaZ9bGUo9pTY0+RF25tlse6cL7icOiEsoj65DNmeVm7xo18q8hfPw0XmbQVSjK5/l2UWY
8VQueqtQ8T15ufRo6XuRSfjfPoeO+vpqMynqMpz2JKc+YP8vouRqrUWzVwQARqv8OrqWdl2KTmgs
kX3oX55+UU+if0xoNCPM4j/tS/jtyqlwSYEU7LQpjrHMc0oM9n8om4Hw4dF2aMh6CoowYtq9MjNl
HFMGZfeUPpA1z/xPQwmYopSEywXDYQIQ5BbZ9gaCuQ==
=TME8
-----END PGP SIGNATURE-----

--------------RUwPAC00nLsJ4vnxysuoeY8i--

