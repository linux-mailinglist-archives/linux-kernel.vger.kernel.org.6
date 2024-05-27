Return-Path: <linux-kernel+bounces-191262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B20E8D08E5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1DF21F23397
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892DD155CAE;
	Mon, 27 May 2024 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnkOyx5A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4F017E906;
	Mon, 27 May 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716828084; cv=none; b=VFuJfrRu6n9hBHIb6szkfRzG+Pp75RE+bDPluks7e5Elowge8prN8xqSsAp/7eK+/uKczIWml2UOxTXk6dDR5BLIMw/MglIbB2f2n+YnXxlmNu4J/TgbQ9jpOHy0I9AiczPzMG3iRW+HgiDCdwIQ23gPnyWXrzaWpTOxpZD4moY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716828084; c=relaxed/simple;
	bh=VP+qsmC54b19MmboZBNiJ4/Iw5W2tqYz1l0e+9i3aFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f890NI8okTNC5/GWnWlchgHUOn4DMvN/P5hnMi7WDGD/JFa20H3LEaBM7uBqMab9TxvkNam2X9r2tlqfb34SxGFSGp74XuwPUOHTQ8oSj3ZRFsf9r6N7i8vrvRlLVVvh95BYMzP1rfb10CA1r4hML73i440luRTtDflQHOH8SAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnkOyx5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3AEC2BBFC;
	Mon, 27 May 2024 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716828084;
	bh=VP+qsmC54b19MmboZBNiJ4/Iw5W2tqYz1l0e+9i3aFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OnkOyx5ALbSmHTXbPoXK+DoM0+zMLpr2uEBJ5j3VgIJhliFWJ8Pjd8SeVL2t0+VPX
	 h4/1TrQH2qC7up8kjrBV04Mxcmww++vsthpYV9knAI6o4MBdSeEpUymCzzn0Xx+vK6
	 q2fR2f/W3BbcV07a05oKKGXjURGn+XkB5Fyrm/5H7T5mVvmbisjUPDV1rUlMm4N7ST
	 sFNwvzXpPAzUp3/BDe9LQi0xzNrfEERm4HK7cGejaRsod80C5AVVcNjZuMkicmnLCL
	 lP82XuC03rUET7RlkWiTtGsmx52PuYhMjJAZhJqCTMSJzNp3nMvy0QsaRLxTkK8Fte
	 jRM8MbmkbIcOg==
Date: Mon, 27 May 2024 17:41:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 5/5] riscv: dts: sophgo: Add LicheeRV Nano board device
 tree
Message-ID: <20240527-skedaddle-flavored-a869c7918088@spud>
References: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
 <20240527-sg2002-v1-5-1b6cb38ce8f4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Yw+/J0Tv/ZDAD4WK"
Content-Disposition: inline
In-Reply-To: <20240527-sg2002-v1-5-1b6cb38ce8f4@bootlin.com>


--Yw+/J0Tv/ZDAD4WK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 12:28:21PM +0200, Thomas Bonnefille wrote:
> LicheeRV Nano [1] is an embedded development platform base on the SOPHGO
> SG2002 chip.
>=20
> Add only support for UART.
>=20
> Link: https://wiki.sipeed.com/hardware/en/lichee/RV_Nano/1_intro.html
> [1]

Just format this as:
Link: https://wiki.sipeed.com/hardware/en/lichee/RV_Nano/1_intro.html [1]

--Yw+/J0Tv/ZDAD4WK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlS3rwAKCRB4tDGHoIJi
0rOkAP9bRQj9cpTdgLImE92TIFi+ah9V2qy65P0BMYXUljfdsgD9GSKX367tx7hF
SgN63XgxVmLn9hrm7OQ1xLo883xL2g4=
=Pqk7
-----END PGP SIGNATURE-----

--Yw+/J0Tv/ZDAD4WK--

