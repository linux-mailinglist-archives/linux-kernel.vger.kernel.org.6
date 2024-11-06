Return-Path: <linux-kernel+bounces-398185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D14389BE7C8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 13:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899511F21904
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2BE1DED49;
	Wed,  6 Nov 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y1FjKAkQ"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95DE1DF267
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730895461; cv=none; b=p5xuvdmJAQV6UyFyAsZ07eC9dVnBITtiYV/Y4LhIXbPEWWQFLdvYa32FJ4vgRadVJZ06KouU8g6UE0ypkb2VtZO5Qhc3TW8Vu698gJVzcTMAHqm3HuPN4gFTQO2s7XpJPGlSnA7FYq4IfS+SUpKTMhG+fasfqwUrzCXuZRUcRzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730895461; c=relaxed/simple;
	bh=i/wM7PZHZFJEg7x+YJLArxESnTqOgu6l1Q1hRu+GCfc=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RlOFsEy2s62eB926nw+F4CTAE9a8yhYJ8HI4S9PQnpsUDO8kNheS7SubeT/13Xbl1GON9Qw/UvlxHzt5NXwXUXMMGPVXe9Wqg/rFtHos0X8cyMMdWL/NOGTaFoWmp3d7+3/lkqygr8ylklWDhnrKdiSeBwbe+xmwpxktZ4ki/yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=y1FjKAkQ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A6CH8Ju067692;
	Wed, 6 Nov 2024 06:17:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730895428;
	bh=Nd7Yyls8bxkG0sJ+SExvF+TjygQKqRXiCTn67uB60tY=;
	h=Date:From:To:CC:Subject;
	b=y1FjKAkQy+DIMAOY3LAIOFtY+pK8j13tRSL3QiLK0iDhwAa64FEkdG8O4m0cOFXtt
	 1oM+AX6hbxLjzxg0s7vvsOFba/ioeifLpN2ndhMvOpTygMNSpM1KD2q3LEBUsNncy/
	 3KDsQa3Ee43nX60nSKytjiuJH1cF1I8lie13uEyk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A6CH8Hb017034;
	Wed, 6 Nov 2024 06:17:08 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Nov 2024 06:17:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Nov 2024 06:17:07 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A6CH8Qn083811;
	Wed, 6 Nov 2024 06:17:08 -0600
Date: Wed, 6 Nov 2024 06:17:08 -0600
From: Nishanth Menon <nm@ti.com>
To: Arnd <arnd@arndb.de>, Olof <olof@lixom.net>, SoC <soc@kernel.org>
CC: <arm@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony
 Lindgren <tony@atomide.com>
Subject: [GIT PULL] soc: ti: Driver updates for v6.13
Message-ID: <20241106121708.rso5wvc7wbhfi6xk@maverick>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ih4nfsy4jsvbujjr"
Content-Disposition: inline
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

--ih4nfsy4jsvbujjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please pull

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-driv=
er-soc-for-v6.13

for you to fetch changes up to a4c14f509509a6a24f25edb7619f55f204a8433f:

  firmware: ti_sci: Remove use of of_match_ptr() helper (2024-10-25 12:56:3=
7 -0500)

----------------------------------------------------------------
TI SoC driver updates for v6.13

- knav_qmss_queue: Cleanups around request_irq params and redundant code.
- ti_sci: Power management ops in preperation for suspend/resume capability.
  Also includes dependency patch to export dev_pm_qos_read_value
  (acked by Rafael).

----------------------------------------------------------------
Alessandro Zanni (1):
      soc: ti: knav_qmss_queue: Drop redundant continue statement

Andrew Davis (1):
      firmware: ti_sci: Remove use of of_match_ptr() helper

Dave Gerlach (1):
      firmware: ti_sci: Introduce Power Management Ops

Georgi Vlaev (1):
      firmware: ti_sci: Add support for querying the firmware caps

Jinjie Ruan (1):
      soc: ti: knav_qmss_queue: Use IRQF_NO_AUTOEN flag in request_irq()

Kevin Hilman (1):
      firmware: ti_sci: add CPU latency constraint management

Markus Schneider-Pargmann (1):
      PM: QoS: Export dev_pm_qos_read_value

Vibhore Vardhan (1):
      firmware: ti_sci: Add system suspend and resume call

 drivers/base/power/qos.c               |   1 +
 drivers/firmware/ti_sci.c              | 489 +++++++++++++++++++++++++++++=
+++-
 drivers/firmware/ti_sci.h              | 143 +++++++++-
 drivers/soc/ti/knav_qmss_queue.c       |   6 +-
 include/linux/soc/ti/ti_sci_protocol.h |  30 ++
 5 files changed, 662 insertions(+), 7 deletions(-)
--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--ih4nfsy4jsvbujjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmcrXj0ACgkQ3bWEnRc2
JJ36TxAAh4kYatZvq4I71XeciAfFK6VujsT+qEMjXfxf077vPRRiJkvjV3Kr0Yok
RvuYgSysH7zx5vFYEnvImlgE7cesq5DQeXeMalFSv4QSU+wKgDI5K7EJefAfXX1x
0BFQG1cIcdMJ1D1etL/evVrB2KG7V/zsouVVRvlx2rAmqVYREYFasO1GbbB4P4Df
UTHFORVlqRby3HuoLujCBULsE8giPx0XJEu2qgOVbgKjzaeXcVOkqS17W//EszTZ
8bRiGDhF73oWoDyzo5ERgNI4QyaWAQJSfROt3Atm4DBYiAkWvrPT4JoLhrZRvJ1v
1OYLxs5sCFY/uv2Fryq1fCPmYSV5JXorgOfJRdPa2LDURZvBaFn744brbz1yFtAT
QaxalE5ISlN+PeanHtqJ1Cov02BxdT1hv2nhmCPUWaOM2iQ+3wD9rQiww1qhQmgR
XthNmZ2l7toBzdw3zKvX5CN9FbMZ5oXRLvWG8/NzXcFGjJbxBm9wqRVaCLSqA8Cl
vq8KTTb1XTTVveBc1rOBfQ5EiF6GKRlqMcpzY5NcSpfJRgzCST43EgZsWm8y8aO5
XQK8n04nF7QLP4MLvVr8O41xDXaB+oO95y2PgbVNgz/Ktijakxc4/2Dn8gJrqnsV
G9SXyl7SaLch0YYlArACBiZeIIkCVr2EGsUMRkRrGHRTl5tE7kI=
=3YLN
-----END PGP SIGNATURE-----

--ih4nfsy4jsvbujjr--

