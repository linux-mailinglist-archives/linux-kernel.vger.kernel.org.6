Return-Path: <linux-kernel+bounces-398328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A24BE9BEFA3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F2FAB25681
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6017201018;
	Wed,  6 Nov 2024 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TesP+4rK"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6072117DFF2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730901470; cv=none; b=hQ8s6XqmjGKWBsvT28g343hO8Gd+3jIRYMpnfRR+FVSc6HHCnPaxhzBLWfme2Ngk3SqGiV739Nl4GCvJdgCNtzv7/9t7jkoQHzWM8nFndWMkfBOPUIEKlW0gPWPBArObfoAIQ7KnFVLPzzzHxYR5b+avXziCEynsD6P1aLo9UMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730901470; c=relaxed/simple;
	bh=BwPjfhJ6zHiv9ahOO5Y1SN2iWZaAKh737Ie2cZw3Ipw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=T56hw/eVyI9/5cjJP9PBKy85J2X8wfIaOci8VqsYcbnIHOa4RufDz6FPlQ2uWehdUSM/BcXGN6sOBr15CynOIHxFIcPpALcYnnzOCK43/pJ/UStVDDQGyOc2X2OMCi5T5hk2ixXw/LtYe7S+ph/m7qo41isL7Qf7+IN5517pMOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TesP+4rK; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A6Dvced099950;
	Wed, 6 Nov 2024 07:57:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730901459;
	bh=DSqnZgLZFmjR/zI09hPj35lExE9DozM7LRLSXNYuBeQ=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=TesP+4rKGnJ6jtqqLzP9Yqm7ZsdGP4CH/HkGIMrdU7rORd+CDqLAdBQPBByR0pt9h
	 wKcpnT7GG0WfBuolJIb4Ql/ADKwPuxA0QQZzdbYQySqDtt/g8Ql85pOVxuWKb/CgoS
	 SZbL38q62GI1j1jAUcYp20FiVjtzyNuMcCCrNhLM=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A6DvcYS002611
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Nov 2024 07:57:38 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Nov 2024 07:57:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Nov 2024 07:57:38 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A6DvZWm062961;
	Wed, 6 Nov 2024 07:57:36 -0600
Message-ID: <b13eabeb-48dd-493e-a7c7-fd247c971ae8@ti.com>
Date: Wed, 6 Nov 2024 19:27:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [GIT PULL 2/2] arm64: defconfig: Updates for v6.13 for TI K3
 platforms
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm-soc
	<arm@kernel.org>, SoC <soc@kernel.org>
CC: Tero Kristo <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>
References: <3ded4795-2186-4e06-bda6-9c9a65a3fdb9@ti.com>
Content-Language: en-US
In-Reply-To: <3ded4795-2186-4e06-bda6-9c9a65a3fdb9@ti.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------0BYMO8heXxr4akuBJs0wGJ5K"
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

--------------0BYMO8heXxr4akuBJs0wGJ5K
Content-Type: multipart/mixed; boundary="------------Wti14dmmowaCZOnaHPCZPIia";
 protected-headers="v1"
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
 arm-soc <arm@kernel.org>, SoC <soc@kernel.org>
Cc: Tero Kristo <kristo@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>
Message-ID: <b13eabeb-48dd-493e-a7c7-fd247c971ae8@ti.com>
Subject: [GIT PULL 2/2] arm64: defconfig: Updates for v6.13 for TI K3
 platforms
References: <3ded4795-2186-4e06-bda6-9c9a65a3fdb9@ti.com>
In-Reply-To: <3ded4795-2186-4e06-bda6-9c9a65a3fdb9@ti.com>

--------------Wti14dmmowaCZOnaHPCZPIia
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758e=
dc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3=
-config-for-v6.13

for you to fetch changes up to 8461bcf0a3d9d39ff9d858c06c2c820f711a8182:

  arm64: defconfig: Enable PCF857X GPIO expander (2024-10-28 20:42:47 +05=
30)

----------------------------------------------------------------
TI K3 defconfig updates for v6.13

Enable driver for GPIO PCF857x I2C GPIO expander present on multiple TI
boards

----------------------------------------------------------------
Wadim Egorov (1):
      arm64: defconfig: Enable PCF857X GPIO expander

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

--------------Wti14dmmowaCZOnaHPCZPIia--

--------------0BYMO8heXxr4akuBJs0wGJ5K
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEyRC2zAhGcGjrhiNExEYeRXyRFuMFAmcrdc8FAwAAAAAACgkQxEYeRXyRFuM9
sQgArcKMxrJqwx6+LcLpHZ3B8pOnVUXjfvva32PE059xUWqB636BxhMl/kGVlrxtUpPayNBTLniY
QpQ/Fr/NnCDwuv0nhUEA+SQcChb8onDT0/hBAj5Y37vnQPQuywHRIrv9smXjsuFiM8gPt/ybi8+f
V2XK6jrf9gFRpLBq/+mxqYt5/zbNeg5/oUge53EoT9v7MogH/ek3bI2zDu66jW+nwETGjyxk77F5
eUEWSK/4M1vzfiapnmxW6h3jezQzlDAMqdjk2ezCMBUfQjYIPyOdDwGgB3iU5rH0SdVvC7fbV73I
viUwcJ81+a9224s3MXWPiPWpyc3+riaEf+nRAPQGfw==
=LJ9D
-----END PGP SIGNATURE-----

--------------0BYMO8heXxr4akuBJs0wGJ5K--

