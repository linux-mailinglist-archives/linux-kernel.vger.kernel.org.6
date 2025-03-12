Return-Path: <linux-kernel+bounces-557632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F70A5DBBB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4F51881480
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CF423ED58;
	Wed, 12 Mar 2025 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FJuhLKTU"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15B91EB5E3;
	Wed, 12 Mar 2025 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741779523; cv=none; b=XBbA7gy3M/JmGg/++fU+TTJLKlotDrbCCeR4JuHN3Ip+sWZoyViHB83RxH+SZUEiYPajH0EbTlQ0hxAxt5oJjBSeYDP7+vUQkD5K5uP1VkMgRsDpQ6vMLXki1qDzZ6znbvzXeRG4qGG8KXuZA8RoHuRyJYW3deP7T4iJPQ8BSOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741779523; c=relaxed/simple;
	bh=p9vmPAJ+IfD7JfIpR1rDY4RWu0cMfzDiYKuZriZ0KCs=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d2JMYMA23D/JKXTD25fz7klCwGiDC6XxesfY4JlUPehfwKOJ+Valodx86OJBu0NmcRo4sVY4MpaelLWW/x4MH8R0+4Zr8+McdL/vpU/I74r9cvmFwwZHVfNkxRrkK0vVqwDwrV0a3U1pSjXIZsnv5jAGH0OqN4FUJmjf7TXM4Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FJuhLKTU; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52CBcR7D1047265
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 06:38:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741779507;
	bh=cyDhaKqlqsDkMfTnrMH67D5RQyLpYOtC8HL308/2ZoA=;
	h=Date:From:To:CC:Subject;
	b=FJuhLKTU1SrrTprGVp9zbhiLAdE1oVQVP4NpJtPmn0cFsayjxBZFBrW2pHTS7bqN0
	 p/4am0f5yb0EJ7BJRAHFTf3gt+ZvX2rFb98lDIAM2u/3Xr4ZjcC2mLmtNdKwlt09pF
	 ZTElQk3ZEjaxBnE/QQeqQONVPlyvUR5GFOBcmOUg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52CBcRmx014034
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Mar 2025 06:38:27 -0500
Received: from flwvowa02.ent.ti.com (10.64.41.53) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Mar 2025 06:38:27 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by flwvowa02.ent.ti.com
 (10.64.41.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Wed, 12 Mar
 2025 06:38:26 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Mar 2025 06:38:27 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52CBcQw1040494;
	Wed, 12 Mar 2025 06:38:26 -0500
Date: Wed, 12 Mar 2025 06:38:26 -0500
From: Nishanth Menon <nm@ti.com>
To: Arnd <arnd@arndb.de>, SoC list <soc@lists.linux.dev>
CC: SoC <soc@kernel.org>, <arm@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] soc: ti: Driver updates for v6.15
Message-ID: <20250312113826.ka63nijuftgs6h52@mocker>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r5zummcjnd24hbjs"
Content-Disposition: inline
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

--r5zummcjnd24hbjs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-driv=
er-soc-for-v6.15

for you to fetch changes up to 9a9b7cd77b2427d0722fe52301fa270690928989:

  firmware: config: ti-sci: Default set to ARCH_K3 for the ti sci driver (2=
025-02-26 12:45:53 -0600)

----------------------------------------------------------------
TI SoC driver updates for v6.15

- ti-sci: Default set to ARCH_K3 for the ti sci driver in preperation for
  the driver to be default set as module in defconfig.
- k3-socinfo: Explicitly build up regmap instead of depending on syscon
  helper

----------------------------------------------------------------
Andrew Davis (1):
      soc: ti: k3-socinfo: Do not use syscon helper to build regmap

Guillaume La Roque (1):
      firmware: config: ti-sci: Default set to ARCH_K3 for the ti sci driver

 drivers/firmware/Kconfig    |  1 +
 drivers/soc/ti/k3-socinfo.c | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--r5zummcjnd24hbjs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmfRciwACgkQ3bWEnRc2
JJ2b3hAAll6igclF5cvAYpG52TUOQDPdUjfE4xC1qukOmbySKRxfES9LUDaV4Vsc
swv6uBOhdxa/Rx44fEoS+VuNHUlyWcVvo2i1tqy13tlvfULEg/tXK0yEuYo4CBVq
O4Z4GwESTzSG3BDdQNE7AeBrUXvZnIis1abcpkVvxBMaWPaIjBSkU9CkBryEocRb
2P+pmEGZmsTo9+PLCcfh2rCR5qRup8Tn8urqP3BliUEQlOcJnXm0WsbUJbGjT8t1
iVDTOoBm8WSpbJwWsL2PcC22N1uX2RVE36evnFlmhgO1UGECoUpN/8gBz2xIjjM9
uGAW/j/1Y5gHz2MmnaajlgG8UPhFWrQsPqckY6sSxGC13Kb0At3PhxEF+p9Y+MNl
elKSs+3ANhosdLRACurfR0yHlzrgnw3EJRhxVZ8NHPMlChXUIwIM/Gf/u8wtwCtJ
z+IUf7VNosWzH1Bz6Cn6GCs4DLXM3f1RAcCgULcRcFbdgnmPomxPhJtt8nCHlRyO
WnnX9AVZg70ixmYLdxMHPxS9ad8rzeWh4r1RXqKRR9WRerlEQAKdpD/FeRwQ/ZC/
IgAjbYGhkX4efMKeSsGSkcUHAIcPwOAMwd/iJ0AuA9O1JshLB5Cc3OfCgNyixAkR
dG1AbIYsJQClKkQp/QPf2OwmpK/7Ozcmy+H3/CXFAcHEbCTIPeo=
=6rrW
-----END PGP SIGNATURE-----

--r5zummcjnd24hbjs--

