Return-Path: <linux-kernel+bounces-313298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C4096A36A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94711284EB8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E5E1898E6;
	Tue,  3 Sep 2024 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DFcQ5cOY"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3009188921
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379010; cv=none; b=Rr/sEXx8j33VKaLAZDzjhGIKLyF/CCCJLN+0y8w1qUoYuHUFOFeL6WnpaOFZFl46r8ToPPDEtBUfllgLGFXDqdSqDWxd0A7WM7Qw6p0AMs5Tm7cHSviNNWOEVBvEmOzImnXl0EtgxE79NyDS7LDc5EDGHs2z9c5E4iWAWfuDhVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379010; c=relaxed/simple;
	bh=isBxdu+nnZiXhS8bTqdyZsUKnIqx6iPAQvxJRppImn0=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lXnWXO+VWXyWh7Rq/a5W7n75U789WJxUFcho4JiWoH6Cf4YkClN2p/HcDqbpAKdyvRCv/GXsUuScr1goMvPa9+KGzG8bMACFrG5JdoxS8V/SOUJM/vUYkfpw+FluQNxax16Aw4FxJ4SjZkUPuXgurpWXBEquzDx4eUGrPhGN2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DFcQ5cOY; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 483FuXiG085518;
	Tue, 3 Sep 2024 10:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725378993;
	bh=UEZJ4sFP7ETW1sRIaOC+SDQVPQJW2Qe93LABTVWeSOA=;
	h=Date:From:To:CC:Subject;
	b=DFcQ5cOYWq4gkrcjSrXGucgTW9qoTG2Wzn9lWBaY2miwlBTd4D2wQ2MkXhuRp0lag
	 IkjRPogJLN3Vx8MoJ9UGDaLx5qMMuRDMXeU/mmEtbjkdg10IMmVDdUKD0BlSap4ifi
	 Zad+g6UA2DBpdA5VUQ+Wu+ld44m8nwwiZKKmZ0ho=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 483FuXps070548
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 3 Sep 2024 10:56:33 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 10:56:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 10:56:32 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 483FuWBN036900;
	Tue, 3 Sep 2024 10:56:32 -0500
Date: Tue, 3 Sep 2024 10:56:32 -0500
From: Nishanth Menon <nm@ti.com>
To: Arnd <arnd@arndb.de>, Olof <olof@lixom.net>, SoC <soc@kernel.org>
CC: <arm@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony
 Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] soc: ti: Driver updates for v6.12
Message-ID: <20240903155632.525twuumykwnfkiz@subtitle>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m7ebxaqyq4z7akcy"
Content-Disposition: inline
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--m7ebxaqyq4z7akcy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-driv=
er-soc-for-v6.12

for you to fetch changes up to 68123510b7c1c610387dd306f92ff539c3c546b5:

  soc: ti: pm33xx: do device_node auto cleanup (2024-08-28 12:18:02 -0500)

----------------------------------------------------------------
TI SoC driver updates for v6.12

- pm33xx/knav_qmss_queue/pruss: Cleanups around device_node scope based cle=
anups
- knav: Additional fixes around of property
- k3-ringacc: Optimizations for data structure

----------------------------------------------------------------
Christophe JAILLET (1):
      soc: ti: k3-ringacc: Constify struct k3_ring_ops

Kousik Sanagavarapu (4):
      soc: ti: pruss: factor out memories setup
      soc: ti: pruss: do device_node auto cleanup
      soc: ti: knav_qmss_queue: do device_node auto cleanup
      soc: ti: pm33xx: do device_node auto cleanup

Rob Herring (Arm) (2):
      soc: ti: knav: Drop unnecessary check for property presence
      soc: ti: knav: Use of_property_read_variable_u32_array()

 drivers/soc/ti/k3-ringacc.c      |  12 +--
 drivers/soc/ti/knav_dma.c        |  22 ++---
 drivers/soc/ti/knav_qmss_queue.c | 105 +++++++++++------------
 drivers/soc/ti/pm33xx.c          |  52 +++++-------
 drivers/soc/ti/pruss.c           | 176 ++++++++++++++++++-----------------=
----
 5 files changed, 166 insertions(+), 201 deletions(-)

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--m7ebxaqyq4z7akcy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmbXMaoACgkQ3bWEnRc2
JJ1pHg/9H8TVXIuY7A9yGfeXU0u0R9pxvdyL0jTM75Ljo7EU5Y4YFqlmXdRSNBml
xQ75Gt3MQ8r0nc8504GlvnWc0TshBLewo+YN8RdYjHOo13wwiW2gDgpuROx74x9c
HCEAtzmUfwO2JzE0NhlmzmZ9hpWnRakxzuDa55+ySE28T9cH2JyGjMnnJ4o6VG06
vfhgwBHdYssKBFCCuMuT+Thajp1eyzb/Kw2RxCUcNUF5E2ROaZs7JaAJU26cLBUT
IW9OiadTuAoDnq8PFdz00u4ECgDNnGFwb2waUFvxZPbcyuvnndMbfYIZBwlNRhNa
jqhA1GGWks3yHabNdrh6MESgp5IqfudFM4zpoAcaHtyevdKrWtNVAJfRKMxLF6L8
3C6dNp48uqV1RO8ydVL3Tr5C9LZOKblF+fyx+gKlYFA8OLvj6nnCZqzZ7ScaY3Oc
tZOHsfvMv2fQ6KqjXAQs6Js3wPQ5a6jSaYmcXPVjzREFd4iT3WYAh6yKx5GI0j85
6X9zdP8Z5WaU7ok9j/OwmCJfTVNMkmaItf5Yyu4tqE99BhuNr/DCPYvmu2NDOnVB
iS2jQNYZwuguWjdm9cSjIwMwVwtbBolTeNMEOIXdx064T51fdXSJup532YSxGBk4
sZ+xXExQxP9xwibyj3RREYClrKKcZ5uzC6yvCxt2UMNs7v6B624=
=H3p9
-----END PGP SIGNATURE-----

--m7ebxaqyq4z7akcy--

