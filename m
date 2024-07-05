Return-Path: <linux-kernel+bounces-242687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 286A1928B72
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7E71C2463C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7028516D9AA;
	Fri,  5 Jul 2024 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hCeQYlnA"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF561487D8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192511; cv=none; b=ANB/1p8FPmGvGTowAYbJ3tJRo5JMljECa6gJeEw5pFSoUO1nXRA+yJEGxl7DCAxG8L/RJdrKjsjNmiONUFR8E75H9ms6Celp5bpahZ+pjjYiMChrWvWuoZR3rfTQJOInKTCmH8i36i/Udr5RZF3Oiksg5p3C62FoDqk7D0Jjso4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192511; c=relaxed/simple;
	bh=I5qnt7eNv1oH86ZEyuQAkRUZ7jxEDsUS86Git0ulbT4=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P9SDYAK5i+pLTd1nHGCrolgam7Pyuq2DvYXM9owUrBq+vEsm4aB+sWVT2vq2RmTHIHoo6vfLuQYiRqNdcb7cKTUq5ib7F0+2jtzStlFb+hcS0neKZBvRGlVYY1UWxF0YvaiuMCxcNcujbegU5e6PKY1/eTBFoyN26xLbPk5g3Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hCeQYlnA; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 465FEnOf063250;
	Fri, 5 Jul 2024 10:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720192490;
	bh=pxHBl3JxTXfLPHWST+yT08WLecjyDtqhyPWFl2R9XO4=;
	h=Date:From:To:CC:Subject;
	b=hCeQYlnApfCGv1yMDgLVIO+jdF8nGiRkSylgvC8PI2y8bbSDQrg7Tf3hVjiHFMzNh
	 u6lxW2NiJbEGQwN/D1O5hkbHOkwDNB5y5i2InU9FPONa8NIz97rUZYtlCTu9CFleq5
	 BgNRsl9Mw0lvMgCiUt4zOOZ0DvTX68oodumG7cSc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 465FEnSe011599
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jul 2024 10:14:49 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jul 2024 10:14:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jul 2024 10:14:49 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 465FEnXB027305;
	Fri, 5 Jul 2024 10:14:49 -0500
Date: Fri, 5 Jul 2024 10:14:49 -0500
From: Nishanth Menon <nm@ti.com>
To: Arnd <arnd@arndb.de>, Olof <olof@lixom.net>, SoC <soc@kernel.org>
CC: <arm@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony
 Lindgren <tony@atomide.com>
Subject: [GIT PULL] soc: ti: Driver updates for v6.11
Message-ID: <20240705151449.s4rngkehjn73favn@stream>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ds5cc3igitvhtjwr"
Content-Disposition: inline
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--ds5cc3igitvhtjwr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please pull:

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-driv=
er-soc-for-v6.11

for you to fetch changes up to b87a1cbb3385a806f8abfd9b8a2191e4c6620347:

  dt-bindings: soc: ti: Move ti,j721e-system-controller.yaml to soc/ti (202=
4-07-01 08:09:27 -0500)

----------------------------------------------------------------
TI SoC driver updates for v6.11

- Update TISCI protocol URL link  which was dead
- socinfo: Add j721E SR 2.0 detection support
- MAINTAINER list additions: ti,pruss.yaml and ti,j721e-system-controller.y=
aml
- pm33xx: log statement improvement
- knav_qmss: minor data structure optimization

----------------------------------------------------------------
Christophe JAILLET (1):
      soc: ti: knav_qmss: Constify struct knav_range_ops

MD Danish Anwar (1):
      MAINTAINERS: Add entry for ti,pruss.yaml to TI KEYSTONE MULTICORE NAV=
IGATOR DRIVERS

Neha Malcom Francis (1):
      soc: ti: k3-socinfo: Add J721E SR2.0

Richard Genoud (2):
      dt-bindings: ti: fix TISCI protocol URL link
      firmware: ti_sci: fix TISCI protocol URL link

Roger Quadros (1):
      dt-bindings: soc: ti: Move ti,j721e-system-controller.yaml to soc/ti

Vasyl Gomonovych (1):
      soc: ti: pm33xx: Fix missing newlines in log statements

 Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml            | 2 =
+-
 Documentation/devicetree/bindings/clock/ti,sci-clk.yaml               | 2 =
+-
 Documentation/devicetree/bindings/reset/ti,sci-reset.yaml             | 2 =
+-
 Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml           | 2 =
+-
 .../bindings/{mfd =3D> soc/ti}/ti,j721e-system-controller.yaml          | =
4 ++--
 MAINTAINERS                                                           | 1 +
 drivers/firmware/ti_sci.h                                             | 2 =
+-
 drivers/soc/ti/k3-socinfo.c                                           | 2 =
+-
 drivers/soc/ti/knav_qmss.h                                            | 2 =
+-
 drivers/soc/ti/knav_qmss_acc.c                                        | 2 =
+-
 drivers/soc/ti/knav_qmss_queue.c                                      | 2 =
+-
 drivers/soc/ti/pm33xx.c                                               | 4 =
++--
 12 files changed, 14 insertions(+), 13 deletions(-)
 rename Documentation/devicetree/bindings/{mfd =3D> soc/ti}/ti,j721e-system=
-controller.yaml (96%)

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--ds5cc3igitvhtjwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmaIDd8ACgkQ3bWEnRc2
JJ2zTg/9HgAcxzlVJjtsVovpga3vZTtcSOb9RvdNrKMrERe0TwEBzUA7dFnj0lLy
xPQKGEorhrCHc/50j/VeSkgGbPtLaOGhjpzxn7bUqBR+9BTlviBqn7nDujCl6fW5
INt2hlKbMm+l6LTX7/CTUWBBRaoC2AqibGtU4ZSWFzWA/G5UAABXK3E2OhgSFPiw
FfNVIDzSzwHw4kDTPIUMdnCKue0UfCFMF/JyCqXYt4wd0SuWEqDnT/s+e0qm/kwO
+LAOyrcjjCDS1vKc21ayhSz9T05WsHwJnGtlWgd9WHTE+lumsYoZMU7eoc78aE4E
YuQJO3nIJVLSTCtQ9jn7A+y20/hSV8GsqxXPmxKQAxxhQdFoR6VdB2bkwKGMwtRX
5p9a/MfJRfPxDdQzU0THHsAN2YegUUEEBsTsulkUfSWh/hBtMsfYrMM55d0DHdte
mo6y+xtuCbzP4etIvyFzrWq45OYrsd2+mX1iUu1+LUYPTC1eR+A38OXIfd4D89CU
3+RohINUHJmEQ/qF96M0o1WvbcL2OvMxFOjpuNqCb8IarYT24krW3V017CIYo1eU
2a0y6/8n74Y2EmH+alDSCmRSEMwzw3SkSLCLhaKWF34Jm/Zr2jbgtl4ynXqsbMUE
t1EU39z+Vf3ioGdwLQhSBFYQ9E+9gEvJ4gvI82/dQLItTXCropU=
=HovR
-----END PGP SIGNATURE-----

--ds5cc3igitvhtjwr--

