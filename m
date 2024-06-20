Return-Path: <linux-kernel+bounces-222237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3258C90FEB1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE843287251
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDCF18EFEE;
	Thu, 20 Jun 2024 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bzA/JTEb"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09435B05E;
	Thu, 20 Jun 2024 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871747; cv=none; b=O1tq3viGSGFjb+Ypuq7Sb3XwCQsHzZ5g47jiCg5Cjj694ZX+HnuDvworN3QRWermqcJT+5DDBI7JQM9vGanGsdG4vJVlsAjdtdKXPyiinZ3ddsFYDNroFZ5CsEvzXxUP+KavGKTV1BNLsYzSweLr93qqIxE2L8dWSf/GGKBeCTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871747; c=relaxed/simple;
	bh=DgkvKqufEzVzA4mCCc5Izp084ePjsPRawcTM+KusyrY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCuXDcJMYfMHkGDa2mqPPydcPx960evxedJp4LK+5JjAAVVKx0LgEDgGPLscYXeDZcmX3v2GSWsEhCKkKe0MpjAxTo3O+z054uwsgoOOhymy8ldnG8dk/Oaf8QGigvjMlV5enRXrfHcL0DZYnRydlSB0Q4FQec1iFj8AU7azDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bzA/JTEb; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718871746; x=1750407746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DgkvKqufEzVzA4mCCc5Izp084ePjsPRawcTM+KusyrY=;
  b=bzA/JTEbNLhNHk602tpK/ERTU+FlluweZvZtGR7dYJHR19Ki25mJMugJ
   DcHKlYBnbBdmvgOc75BRprRyiq3PDgxKaCl5IXaKx+EYz0X8lvHwmXxd5
   mfvL6CKHX26tffh5p3hwoNA+le/NEoSCZxHsx3WCobKHe20BafeINqWAV
   rQws+225NQhj7IIa1AeAArbFplBJ/tM2cp2UAWzzaKNpV7aikuUzdWvhK
   A76ntdqJkkJ6LKUrzSdaZqwYWCYcNLqGxCr+NK9e3kLhy+wc3rgMzOg3m
   VOsjDngFbCx9GXG3/mDtafdZ+7sfj6Krqb9F+G5W6kVHeqnG+MpM1DUyN
   Q==;
X-CSE-ConnectionGUID: BfXzup/sSuCPo1L9vCsj6w==
X-CSE-MsgGUID: ecnZoOx/TbqPi03KL3ujjw==
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="asc'?scan'208";a="259148518"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2024 01:22:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 20 Jun 2024 01:22:24 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 20 Jun 2024 01:22:20 -0700
Date: Thu, 20 Jun 2024 09:22:02 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Conor Dooley <conor@kernel.org>, <krzk+dt@kernel.org>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <matthias.bgg@gmail.com>, <jassisinghbrar@gmail.com>,
	<garmin.chang@mediatek.com>, <houlong.wei@mediatek.com>,
	<Jason-ch.Chen@mediatek.com>, <amergnat@baylibre.com>,
	<Elvis.Wang@mediatek.com>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<kernel@collabora.com>
Subject: Re: [PATCH 3/3] dt-bindings: mailbox: mediatek: Avoid clock-names on
 MT8188 GCE
Message-ID: <20240620-district-bullring-c028e0183925@wendy>
References: <20240619085322.66716-1-angelogioacchino.delregno@collabora.com>
 <20240619085322.66716-3-angelogioacchino.delregno@collabora.com>
 <20240619-sleeve-citable-a3dc10e5cd4f@spud>
 <a7317981-8690-4d45-81b6-cc6a63c459e0@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vDd3+enh6BC9rJov"
Content-Disposition: inline
In-Reply-To: <a7317981-8690-4d45-81b6-cc6a63c459e0@collabora.com>

--vDd3+enh6BC9rJov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 10:01:18AM +0200, AngeloGioacchino Del Regno wrote:
> Il 19/06/24 19:49, Conor Dooley ha scritto:
> > On Wed, Jun 19, 2024 at 10:53:22AM +0200, AngeloGioacchino Del Regno wr=
ote:
> > > Add mediatek,mt8188-gce to the list of compatibles for which the
> > > clock-names property is not required.
> >=20
> > Because, I assume, it has some internal clock? Why do either of these
> > things have no clock? Doesn't the internal logic require one?
> >=20
>=20
> Because there's no gce0/gce1 clock, there's only an infracfg_AO clock tha=
t is
> for one GCE instance, hence there's no need to require clock-names.

clock-names, d'oh. I misread that completely yesterday.

> I can't remove the clock-names requirement from the older compatibles tho=
ugh,
> because the (sorry about this word) driver (eh..) gets the clock by name =
for
> the single GCE SoCs...
>=20
> ...and here comes a self-NACK for this commit, I have to fix the driver a=
nd
> then stop requiring clock-names on all compatibles, instead of having this
> ugly nonsense.

Is it not worth keeping the clock names, even if ugly or w/e, because
things have been done that way for a while?
Also, what does U-Boot do on these systems to get the clocks?

> Self-note: gce0/gce1 clocks lookup was implemented in the driver but never
> used and never added to the binding - luckily.
>=20
> Sorry Conor, I just acknowledged that there's a better way of doing that.
>=20
> Thank you for making me re-read this stuff, I'll send the proper changes
> later today, driver change + binding change in a separate series.
>=20
> As for the other two commits in this series, completely unrelated to GCE,
> those are still fine, and are fixing dtbs_check warnings.

--vDd3+enh6BC9rJov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnPmqgAKCRB4tDGHoIJi
0kReAP9+nHTN6lCNnpAg765nXa6b1QwdTBEFjAYmSXPq03sY+QEAtvDHFzs69uth
qgd15/M32kAL2PfmVibeGNuC6SuDsQA=
=4tAi
-----END PGP SIGNATURE-----

--vDd3+enh6BC9rJov--

