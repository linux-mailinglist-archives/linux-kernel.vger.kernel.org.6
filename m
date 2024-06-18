Return-Path: <linux-kernel+bounces-218465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E664A90C03D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 904A61C22F12
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A67D6FC6;
	Tue, 18 Jun 2024 00:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MYxg0hj/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44900A3F;
	Tue, 18 Jun 2024 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669613; cv=none; b=VImko6q+A8ptceRdW9HbJPDklZZzeUb4Qe8qBaLHAM7Q0b66SH2qI4ktiLqPaQPu1OoxuGo8XM64Lw8s36oHOWn1m6wyQ1EiN71SnF+SP4puCV1ME1Wac+POk/iageIOiJ3Z6OdZtTrQWBoA1wXeEaWaQhIosk/48lSHPOK9XIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669613; c=relaxed/simple;
	bh=5aDeHQ6ntKhePhG4Ww9qIOWCKi/Au3oReh9It8GCLrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHQGkSRTnS/zIKO+Y5DrrFokzzr5ru/2SvUX2caX4lJZ3ztNz7R0uv8ciw7gM927znL299h0o158NbgU5cQIRXn4Eu2DJj6QW3qabs0nM+Dv/+3/e39ioGGDXGnPI7Xtwlwz/up1UHcRsmqIryYx64WkJ4L7h1UFzwkeLtELBQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MYxg0hj/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718669610;
	bh=5aDeHQ6ntKhePhG4Ww9qIOWCKi/Au3oReh9It8GCLrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MYxg0hj/1Z+b76/CI3qOU7QKV0sqPoWRAr2OPJv1hKmjA/e62dWWuwWcBdeckeg0d
	 VZQHbf9hX3kwonQFh9J5/KNhT9BS+JViHxtpvJ/clwfrTIOa17npcEKmP7Mlj0Bj+G
	 CBtGcC5i22IdtlBEQhDzrZLJI9C5BjDBEEBnC4mWm9/YvZDOdYStB0ndQXUhmoE9Vl
	 iKZVtw+eSlCScLQSnBBaoPUEE9jO+2NBh562HFs7rua23I7yA1DBlPe6b+F4M6van+
	 XUp2tcIXpeKPf2/SZpoP5fW4lD+7B7+DGAHLhPVo8aax3caZF58PTMTiOoA3ESiePb
	 6qXxLdrkgd/0w==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 39FAE378216B;
	Tue, 18 Jun 2024 00:13:30 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id B34271060734; Tue, 18 Jun 2024 02:13:29 +0200 (CEST)
Date: Tue, 18 Jun 2024 02:13:29 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Jacobe Zang <jacobe.zang@wesion.com>
Cc: Alexey Charkov <alchark@gmail.com>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>, Nick Xie <nick@khadas.com>, 
	"efectn@protonmail.com" <efectn@protonmail.com>, "jagan@edgeble.ai" <jagan@edgeble.ai>, 
	"dsimic@manjaro.org" <dsimic@manjaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] arm64: dts: rockchip: Add bluetooth rfkill to
 Khadas Edge2
Message-ID: <hk7rrm3ljqmrgvdgf23ymhpzwcnq6otwezratoj5k5zt3d6pc2@vjmeh74xjkck>
References: <20240617071112.3133101-1-jacobe.zang@wesion.com>
 <20240617071112.3133101-3-jacobe.zang@wesion.com>
 <f147be11-fc35-44c2-88e8-7421fee47ace@letovo.ru>
 <TYZPR03MB70017A6280F060A6F4A1DD9880CD2@TYZPR03MB7001.apcprd03.prod.outlook.com>
 <a25472f5-3e88-408c-a033-5e338dce6340@gmail.com>
 <TYZPR03MB7001732D8E2F0921BA82B7BC80CD2@TYZPR03MB7001.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cuonu76bp3mxpast"
Content-Disposition: inline
In-Reply-To: <TYZPR03MB7001732D8E2F0921BA82B7BC80CD2@TYZPR03MB7001.apcprd03.prod.outlook.com>


--cuonu76bp3mxpast
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 17, 2024 at 11:22:57AM GMT, Jacobe Zang wrote:
> > If you already control this GPIO from elsewhere (such as from the
> > bluetooth driver), then perhaps you don't need to define a separate
> > rfkill device at all.
>=20
> Yes, I missed the error log before. The rfkill driver didn't probe
> successfully. I will remove this rfkill node and reserve bluetooth
> node next time.

Does it work with the RTC clock disabled? Otherwise this also needs
the pwrseq work I mentioned in the WLAN patch.

Greetings,

-- Sebastian

--cuonu76bp3mxpast
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmZw0SkACgkQ2O7X88g7
+pr7tRAAnvJzZGEyZhPOc6+tjZHrt5Y/HO4Sifx9FsBeynxBXodpcPQevKqnzMBf
24l1XnbasuC9vvwWAlSDr3iomv5TZjw8zdQZKYrzeyeEEnmhmLr1B3Zde2XT73JN
ElZUojtZIqILKpQJLETSkWknYfemsTmO7VY4l7OR5rW/aingKFtb5DwBG8kx+MGd
A0bmUEFBTxT7tR2Q7lBK9cuKXomz84bIwx7ip/4c7iP9YjHEICO7m8IGdFT3XznX
g2Ehjpwm97Qsm4C10fqVnMSXW/C4h1z+K0wln8f1cHdd9EjVZN7Y/Ce3G+dvL5XT
6YGukt8ybsGdVVSWk9DW3Pkwxf3CNOGkVBO6xua5EdUW78so72Kmj2Z4yevF0nZC
tTobcxuNrMCHtVqSFP22p/PFEuNJxvO6Ss7XR3LkAVvgQsXg6yRu1bJRjMahl9tt
JBmQluBmbiD2Ag4QiPhUVglfAC3c28o1RtFiI7rd9ZCReSDcqu/f77BUg9NTWEHS
23Al34wMMynMiemktx+zXgqMHmHEDPrcqsJhPwgWkauzLO97CGqqFTe+18K+8gvX
cqAa0dySwtZ9WkvznBODfI2XxgsVxGsX/4WyQgP6JKto+SxAyuy3sgw/ljo/9B6x
FCVl6+84Mw/3ilWZTfE1vCuku84oJYmyKCOJ/P4d8NaehDl6Ih4=
=YcBW
-----END PGP SIGNATURE-----

--cuonu76bp3mxpast--

