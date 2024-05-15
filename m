Return-Path: <linux-kernel+bounces-179614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 608C28C6246
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7CD3B2078C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED978482E2;
	Wed, 15 May 2024 07:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2A0P9NiG"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CCB374D1;
	Wed, 15 May 2024 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759745; cv=none; b=AqFUbdiQMzUP+A2pEazG/s8SsEqfKuB4pVpvxd3jpkWhu0YGxCNXG4fei57+B2WlQyV5IxNR25251lrxtw9+qLRdiWdBHqZ9PH5Mj7vi44B2iH4ftqPOZmV+JQgNLKGQzoKzdMG3v2p2t8ed+UrFKtNFDVxyZTduUm6nO2R23Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759745; c=relaxed/simple;
	bh=te+JUZp//zm2HGD0dBdZNmi69bBpCYVM6qw/DcC/rgw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h20eHOEBsrdUxGGQNg08m1j8r5Kg+XtEQF+STDxmBEb1Lc5ZdgEp20HQ2UiR4OMkULVsnqXg56IHp7hPOTWWLaMY8j4wNp7ECEsmpD2a+3YEOMdd0eu5tn2AqXxq4T1w2VboaC/XqaN5LbrtXFfFNAacn1vZ8BsumufGhmYiqTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2A0P9NiG; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715759742; x=1747295742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=te+JUZp//zm2HGD0dBdZNmi69bBpCYVM6qw/DcC/rgw=;
  b=2A0P9NiGpvl9qjZn13/TYNM/Odbebm83mLuYTtAwqtCxLNGmsjT+/QYD
   XDXQkLO7CR2p2v9XiCOFjjGBntVHojdl5Lq1GurvI0BJZhssN7HjIoFNp
   ovKssBsZNZ413Pfc1Cw5AZInL+tORFzt2uQ+BnyYXXxkzabyqwIKq5ZGa
   JurD8F5VPFt4HPhf73IrDxvT9nvb8+l7hhAR84fA8GsJLC6X3XA0/XS2h
   jOwev6qVJlv6m62ezLmn3A54ttetW46R3bvINjMCG5uLCYu6mMFPilOUM
   C6OxApg/lco0ZiHMR8kCYuFHQ41cZeimjz56IffrbwiRJhcNsg+BurDcZ
   Q==;
X-CSE-ConnectionGUID: vh6L3V53RnWoYN/VR9JRog==
X-CSE-MsgGUID: 4xLYoIRATzaCkFyYlr4QYA==
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="asc'?scan'208";a="192150437"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 May 2024 00:55:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 15 May 2024 00:55:06 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 15 May 2024 00:55:03 -0700
Date: Wed, 15 May 2024 08:54:50 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
CC: Conor Dooley <conor@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>, Bjorn Andersson
	<quic_bjorande@quicinc.com>, Maximilian Luz <luzmaximilian@gmail.com>, Ard
 Biesheuvel <ardb@kernel.org>, Johan Hovold <johan+linaro@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>, Sudeep Holla <sudeep.holla@arm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, "open list:COMMON CLK
 FRAMEWORK" <linux-clk@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 1/3] mailbox: Make BCM2835_MBOX default to ARCH_BCM2835
Message-ID: <20240515-reporter-audacious-d06b1009dd52@wendy>
References: <20240513235234.1474619-1-florian.fainelli@broadcom.com>
 <20240513235234.1474619-2-florian.fainelli@broadcom.com>
 <20240514-amiable-unequal-d4133956c80c@spud>
 <b422f395-7554-4596-b779-268718b34383@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Mz+E0rUbLMI09FPs"
Content-Disposition: inline
In-Reply-To: <b422f395-7554-4596-b779-268718b34383@broadcom.com>

--Mz+E0rUbLMI09FPs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 09:20:06AM -0700, Florian Fainelli wrote:
> On 5/14/24 05:29, Conor Dooley wrote:
> > On Mon, May 13, 2024 at 04:52:32PM -0700, Florian Fainelli wrote:
> > > This driver is depended on by CONFIG_FIRMWARE_RASPBERRYPI which provi=
des
> > > a number of essential services, including but not limited to a Linux
> > > common clock framework provider. Make sure that enable
> > > CONFIG_ARCH_BCM2835 does enable the corresponding mailbox driver.
> > >=20
> > > Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> > > ---
> > >   drivers/mailbox/Kconfig | 1 +
> > >   1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> > > index 42940108a187..2b4cde562a90 100644
> > > --- a/drivers/mailbox/Kconfig
> > > +++ b/drivers/mailbox/Kconfig
> > > @@ -109,6 +109,7 @@ config ALTERA_MBOX
> > >   config BCM2835_MBOX
> > >   	tristate "BCM2835 Mailbox"
> > >   	depends on ARCH_BCM2835
> > > +	default ARCH_BCM2835
> >=20
> > This is just "default y", since I doubt ARCH_BCM2835 can be a module?
>=20
> Right, although I intend to also add COMPILE_TEST, by then, it might be
> preferable to have it "default ARCH_BCM2835".

I'm not sure what COMPILE_TEST would have to do with the default,
the default shouldn't be important there, right?

--Mz+E0rUbLMI09FPs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkRqRgAKCRB4tDGHoIJi
0s++AP9VkKvYd49Km7eaKWM91c2R7SxFYFIUvnTjkgV6uXc3wAD/fUc2WcAdBmMl
xNV/8Qr1a300hr58owwMAePh2K6jsw8=
=CCbx
-----END PGP SIGNATURE-----

--Mz+E0rUbLMI09FPs--

