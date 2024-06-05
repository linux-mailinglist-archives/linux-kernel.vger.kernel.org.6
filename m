Return-Path: <linux-kernel+bounces-202202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C1D8FC925
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 12:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0E21F24BC2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EEC18FDD8;
	Wed,  5 Jun 2024 10:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Arlaf8Mh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95AC1946CA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583594; cv=none; b=jL3OIhc1OOtQf4Gw1AkhlVjRxmoD++q7Jwys8lxrEzT5CyQgjWCw921XfAh6xwTNSodt2bNo+WF+MrhnpGhj0nPZQeeAFfjCdpprGolbYay23C4GpYBwp817Jx9ZrQTsdiV/OozFtwN7MQq80RwiQ1roptBKdezgWg/aZTb/Rfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583594; c=relaxed/simple;
	bh=UhlqKw31cR63cDLMm166EF4MS9lRx0CSQT24lYtMin8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdZlMZHDLjQ93jptXZr5p5AR0Zg/RU6tqTvY78a7GNoHF3Efk4e+VcC7p0RwIqAV3he9fl/gGE65GdsbBX0GQafBiYLXvewBJLdEpwQo/6hvjWclhkwEIiUzQpP5VqoBnmKhhlDrh1BzGAe5IUYw3KvV4EkmUk+W40C1tv5IrWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Arlaf8Mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D644FC32781;
	Wed,  5 Jun 2024 10:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717583594;
	bh=UhlqKw31cR63cDLMm166EF4MS9lRx0CSQT24lYtMin8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Arlaf8Mh6Cb1dijCZ/OmgTWkTYUvkMo9Vwtal/air+jE+IQASimjkoObGnlqzXGVo
	 atKztKtgwROxefXZTU2IMqBzR+81XnJ5FBzOVqA5DMDp81gkbxotgP3UbhlReIPx5x
	 yaJxXUkrfetjoSqIlgLP10JTMbowf0ywUui7p8aMivWXQ8ypYtf3jfc53OHkNzX991
	 7kuc2ed5jsKZiLxrdEJcGWaiz2mYdbuDf6GUHYSffjozEYIyQq/1I+x051orrjlg0F
	 WzRcmuN3JHj/ZJC2p+svj97bAL0zOzZrI7dYrfAYm52TwL7i4s+5x5Fxvapsai0P1K
	 fo4g5VLHeIaiw==
Date: Wed, 5 Jun 2024 12:33:11 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, David Gow <davidgow@google.com>, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>, 
	Nishanth Menon <nm@ti.com>, Jeremy Kerr <jk@ozlabs.org>, 
	Rodolfo Giometti <giometti@enneenne.com>, Thierry Reding <treding@nvidia.com>, 
	Matt Coster <matt.coster@imgtec.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Bjorn Andersson <andersson@kernel.org>
Subject: [GIT PULL] platform: Make platform_driver::remove() return void
Message-ID: <acwqbvhf3h5z4shzwdwwwfkvxvmchlpbh5k6kwcubhpe3ncvdf@v5gai33oolhn>
References: <20240527083416.1177106-2-u.kleine-koenig@pengutronix.de>
 <2024060432-relieving-yonder-85ae@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k4kblf7m2zlxrzw2"
Content-Disposition: inline
In-Reply-To: <2024060432-relieving-yonder-85ae@gregkh>


--k4kblf7m2zlxrzw2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg

On Tue, Jun 04, 2024 at 06:13:54PM +0200, Greg Kroah-Hartman wrote:
> On Mon, May 27, 2024 at 10:34:15AM +0200, Uwe Kleine-K=F6nig wrote:
> > there are only very little platform drivers left in v6.10-rc1 that need
> > to be changed to .remove_new() before this patch can be applied. They
> > were all sent out to the respective maintainers, most of them suggested
> > to apply the patches together with this one.
> >=20
> > You can fetch this patch together with all necessary commits from:
> >=20
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pla=
tform-remove-void
> >=20
> > If you have no concerns, I can also provide you a signed tag for
> > pulling. I think that's easier than indiviually applying them, but I can
> > also send out the complete series if you prefer.
>=20
> A signed tag is good, I can just pull from that, thanks!

here it comes:

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
latform-remove-void-step-b

for you to fetch changes up to 0edb555a65d1ef047a9805051c36922b52a38a9d:

  platform: Make platform_driver::remove() return void (2024-05-27 10:34:35=
 +0200)

----------------------------------------------------------------
Change struct platform_driver::remove() to return void

This is step b) of the plan outlined in commit 5c5a7680e67b ("platform:
Provide a remove callback that returns no value"), which completes the
first major step of making the remove callback return no value. Up to
now it returned an int which however was mostly ignored by the driver
core and lured driver authors to believe there is some error handling.

Note that the Linux driver model assumes that removing a device cannot
fail, so this isn't about being lazy and not implementing error handling
in the core and so making .remove return void is the right thing to do.

----------------------------------------------------------------
Uwe Kleine-K=F6nig (18):
      reset: meson-audio-arb: Convert to platform remove callback returning=
 void
      reset: rzg2l-usbphy-ctrl: Convert to platform remove callback returni=
ng void
      reset: ti-sci: Convert to platform remove callback returning void
      Merge branch 'reset/next' of git://git.pengutronix.de/pza/linux
      fsi: master-aspeed: Convert to platform remove callback returning void
      fsi: master-ast-cf: Convert to platform remove callback returning void
      fsi: master-gpio: Convert to platform remove callback returning void
      fsi: occ: Convert to platform remove callback returning void
      pps: clients: gpio: Convert to platform remove callback returning void
      gpu: host1x: mipi: Benefit from devm_clk_get_prepared()
      drm/imagination: Convert to platform remove callback returning void
      drm/mediatek: Convert to platform remove callback returning void
      gpu: host1x: Convert to platform remove callback returning void
      gpu: ipu-v3: Convert to platform remove callback returning void
      nvdimm/e820: Convert to platform remove callback returning void
      nvdimm/of_pmem: Convert to platform remove callback returning void
      samples: qmi: Convert to platform remove callback returning void
      platform: Make platform_driver::remove() return void

 drivers/base/platform.c                 | 10 ++--------
 drivers/fsi/fsi-master-aspeed.c         |  6 ++----
 drivers/fsi/fsi-master-ast-cf.c         |  6 ++----
 drivers/fsi/fsi-master-gpio.c           |  6 ++----
 drivers/fsi/fsi-occ.c                   |  6 ++----
 drivers/gpu/drm/imagination/pvr_drv.c   |  7 ++-----
 drivers/gpu/drm/mediatek/mtk_padding.c  |  5 ++---
 drivers/gpu/host1x/dev.c                |  6 ++----
 drivers/gpu/host1x/mipi.c               | 17 +----------------
 drivers/gpu/ipu-v3/ipu-common.c         |  6 ++----
 drivers/gpu/ipu-v3/ipu-pre.c            |  5 ++---
 drivers/gpu/ipu-v3/ipu-prg.c            |  6 ++----
 drivers/nvdimm/e820.c                   |  5 ++---
 drivers/nvdimm/of_pmem.c                |  6 ++----
 drivers/pps/clients/pps-gpio.c          |  5 ++---
 drivers/reset/reset-meson-audio-arb.c   |  6 ++----
 drivers/reset/reset-rzg2l-usbphy-ctrl.c |  6 ++----
 drivers/reset/reset-ti-sci.c            |  6 ++----
 include/linux/platform_device.h         | 15 +++++++--------
 samples/qmi/qmi_sample_client.c         |  6 ++----
 20 files changed, 44 insertions(+), 97 deletions(-)

Thanks for considering this,
Uwe

--k4kblf7m2zlxrzw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZgPuYACgkQj4D7WH0S
/k6BOQf+IQTl+EBUsW7y5sIUElNQb299hOQfaxdDWvFu6im/T12dNTzp5k9dM0C2
EdH5038yJQtmlFLoYLZlIUKEm2hYN/qL5ofgPBfp5VjPzxQ7tfbSqg316aL9aLh1
1SoKlEW6XSUyC4m9xWPTTBudfO8OcitK5IZidvIwAJFQFlFCF4YfETRVeUYORK6i
LlSgnwp2SGHURnsyW837BkadpzoV3FgThMH9BS4qtkli1QQWxExATSEIO3FGSU8l
s4kYA6W9S5fSLB8JYlOcDC6hIHJ397DL3Py7m/oi6VaauLojCiJmZI4WeesKBCrG
qC/6iDPo4X92MDkHjKDi7Dv5A3M/Bw==
=EYSE
-----END PGP SIGNATURE-----

--k4kblf7m2zlxrzw2--

