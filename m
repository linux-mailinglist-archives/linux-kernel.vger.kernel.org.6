Return-Path: <linux-kernel+bounces-540125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9167A4ADFD
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 22:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431E616FFF9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 21:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D5A1D2F53;
	Sat,  1 Mar 2025 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="bpnWkhbr"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF733E1
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740863995; cv=pass; b=t+L6gzRkVXolooGuac0CoQgMNCodGa2hCn+ME/Bw/d06qjUn+A7ljdwVeCTP9NjJP9+oI/qjYz7hTscJix2otAUusLR07IkWU4byXfu3qwkx3wcojHeZlTDvswSVkNA415Gf0sPArRBgl0d36D4P64A/XoVrJqworXa0HOaw90E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740863995; c=relaxed/simple;
	bh=DiBsetxv/W6ON55bF1Fy2sUWrQIdKNTGci0bZBHTxGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiXtP/RNl7iSEX8IBVrdm8abxtk3jd2ppFutBdgIwDEP3+ahwCkG17YGKizoZv+YzsuptvR/nrU1amlALAIcJmpb4T4aWoX3ppsOzVIvF45JYGTAMpsAXGOImm7J2W2FpEwDupoW+DgSL4dawpTZk/bIWJ/3Q0bU1eKsIvNEufQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=bpnWkhbr; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1740863974; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JvNY9li9MKQNIVqh5YEVHVYfZj9Is0hV5BsrCAUBI7lHP9z+U8mF2RIUcLUStlqdCtTMAVCl6U1j89Sk5G1MaoPCf5qosBp05WdLbbq3Gs0xV4hkFeMlZ14Tk4s13nMkguhleoUtSO0Dpj9doIes/a4L7zmj+QEpH53zkJBd0nE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740863974; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DiBsetxv/W6ON55bF1Fy2sUWrQIdKNTGci0bZBHTxGQ=; 
	b=aF/WsvSwyRIxFvd8jUS4ijrunje55nfeKoWlFlfPr4lNZOpFmpnBs1xJz22RW3bsgBFd0U80vCIn1QoRrbF+JVZwU4cDUGT3HNK0KC4UDlWR5iQpzgh8VeyFX4KBV5NJEyVj+pbNMG0VSNBWqxHOAtPktx1nwxir/iagRCBXCeQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740863974;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=DiBsetxv/W6ON55bF1Fy2sUWrQIdKNTGci0bZBHTxGQ=;
	b=bpnWkhbrTRYhxpm40pXBs6bMBb5UqeqHWZKNswZ7cscZ6QsnIPyW+9gPMNL13nBU
	PKe7mz93oHi84P/d3tNLFrZLwCpNROTDNcABCrCEEfZCiGPZuzDHQJqvIQxFvFwD567
	ojxK800IEhXFl4GW/0Oj4RmioxhKgTmdz9lHmHEI=
Received: by mx.zohomail.com with SMTPS id 1740863972988230.42996635404586;
	Sat, 1 Mar 2025 13:19:32 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 4037118361F; Sat, 01 Mar 2025 22:19:28 +0100 (CET)
Date: Sat, 1 Mar 2025 22:19:28 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Heiko Stuebner <heiko@sntech.de>, vkoul@kernel.org, kishon@kernel.org, 
	linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr, 
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v2 2/2] phy: rockchip: usbdp: re-init the phy on
 orientation-change
Message-ID: <dkjpudmzuuxvaotz4mx46yx7iacof7q6ck746j3rrqvlgbq3hk@6vtvy3gy3kff>
References: <20250226103810.3746018-1-heiko@sntech.de>
 <20250226103810.3746018-3-heiko@sntech.de>
 <02757b21-7599-4ee7-9f97-247b04ba646a@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xtfa7lnnqa7aoiia"
Content-Disposition: inline
In-Reply-To: <02757b21-7599-4ee7-9f97-247b04ba646a@cherry.de>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.2/240.839.39
X-ZohoMailClient: External


--xtfa7lnnqa7aoiia
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] phy: rockchip: usbdp: re-init the phy on
 orientation-change
MIME-Version: 1.0

Hello Quentin,

On Wed, Feb 26, 2025 at 01:38:10PM +0100, Quentin Schulz wrote:
> Unrelated to this patch (but may be triggered by this patch?), I'm wonder=
ing
> how flip is really handled.
>=20
> It seems like we have flip store the orientation of the cable, but also if
> rockchip,dp-lane-mux is set to <0 1>. But wouldn't that break if we ignore
> that initial flipped lane-mux whenever a USB-C cable is inserted in rever=
se?
> Basically, shouldn't a reserve orientation of the cable when
> rockchip,dp-lane-mux is set to <0 1> mean "normal mux"?

If a USB-C connector is involved, the TypeC controller is supposed to
setup the lane muxing based on the connector orientation. This
happens via the typec API and in this hardware setup the PHY should
not have the rockchip,dp-lane-mux DT property set.

The rockchip,dp-lane-mux property is required if no USB-C connector
is involved. For example if the lanes are routed to a Displayport
connector. In that case the lane setup is fixed in hardware and
there is no TypeC controller involved, which could do any setup ;)

-- Sebastian

--xtfa7lnnqa7aoiia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmfDedUACgkQ2O7X88g7
+poznA//SMzDIpD1hxgbwfDNoKyme+1D1x5wcO9dBkilNby+zQ5rkx37r6ZuO1o2
ZiQYGRi2EFS7S41Ow5UF5Xc1venVA20Y9Rb/dPMn8HET80HDQPvWrAq5NawLq2s1
wNc/O8vh0ztjBIL4oTiy+YnV1UnY3YApoyu2ZCh9KkkilOkiquB4I82VVQ8GOFI8
y/dbgrOk+4b/2e+6o2libH4vQROza/VLGThae6yi54GfYF1+d70wpyyevEDcQ7Qj
KKybjoooO+O9IjF+Kfpr0wMzP4mQIeEsYMiAko46iOPPAApsQVxZ8yPnhUw21PEe
F8ZQ+lvewwsUijUZz8hM+hW9rLCoxQ42s/9EVb5vgeKERphkA22SFj2H0PDPMokj
vvMvSTTr/84P/F2r+29UfQdB1eebo8sSiFDc+EGG099VFWVlzdLPkKVxsmyRjbXW
YA8sVFh3PkewDgoJ6nxuJo5UkuJVepX7Xq4bGW2j1DE28oB7IgKBXdXUHOMQajvW
EuLQl60ndqcDI0TinZYVcI3z/Z+KiuaZtWNAsnQP7fP6o7vHhmDjDi+mfZ+yN+7v
0oCBpqHk15G/yGHeKj87Yk/hBX19xc11TFSEu6/vG3gAKrVZrlzMHZXqfrEOsnWv
xxxAsMnKW34k0fD9gFk84UWIxAHC3HoEyYAYWDPfFElS4uCN0Zg=
=JFVB
-----END PGP SIGNATURE-----

--xtfa7lnnqa7aoiia--

