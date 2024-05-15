Return-Path: <linux-kernel+bounces-180142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450308C6A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A2A71C223D3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD85364A0;
	Wed, 15 May 2024 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtaHsBhM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938EC38382;
	Wed, 15 May 2024 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790608; cv=none; b=uAh0QFAl+NeU5RJ8K4hTDcMSy5t0ZSE/wC4bvkpQGe70gBam4705XYRjN578TEMKqN3T1Ljx/qKWHiYSaqG1gxbcH7u/N9U83TgHrrDboR9uHT7ujLmuHDVIN6dfsKDK5u2sXwDFaPRm82EXGJZFEpO1NPqD1kexZhzelCb8GZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790608; c=relaxed/simple;
	bh=b6uOhLr5+sNikINkdW52UqVYtu5Q8MJRE/rYI96Vk7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FS5yxPVPYYkHzKHw2J9232ZrW7X3B9Xxy2xYYXuskVWfVgR3Vx/kuKS1Nkz0jaKOX0MlsEIGeKEgD3Rq/sEnItbNEIwl5SkobIzoVKOMpIfc1NGxFneXzIaUOP5htMEL3E5x8yG2huMZhFiKzVmnNeErdthogIDxbBxaHNBgCNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtaHsBhM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E881C116B1;
	Wed, 15 May 2024 16:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715790608;
	bh=b6uOhLr5+sNikINkdW52UqVYtu5Q8MJRE/rYI96Vk7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XtaHsBhMDyJYm5SKHP6Fjz/B2vn3eXKF0hqyN8fTzRq3m+CH0ez+mlCv+xMz6NQCg
	 Eg3YOAcg7GFEFRorZCOrAfO/fCU6aijvikwMRDWP9g43jMcqO9k51imp+BJWfvLZNt
	 vFt8ZDojVHRS4+FrN4tCQCE/ocjf2zq0Q7d3hXVC2I5tXLen9RyCTRGwnWD/Ye/Lc3
	 nQm6mTN2mClmV263HTxrs3qoKvs/cG/KSSid7qprGQdpGRt8+4HevwH/IgUspQq2+q
	 i/8t2Jp8ZN9CtAn75sbrQuDbu65qVMOnIgqhB6Ar1dQ46d6CPrCSmUt2yatplQPvER
	 TUtpxKRQpRAdA==
Date: Wed, 15 May 2024 17:30:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] Add notifier for PLL0 clock and set it 1.5GHz on
Message-ID: <20240515-reorder-even-8b9eebd91b45@spud>
References: <20240507065319.274976-1-xingyu.wu@starfivetech.com>
 <20240510-unfounded-syrup-d1263d57d05a@spud>
 <NTZPR01MB0956D48361098E8AA4B3930A9FE02@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20240511-unbiased-dainty-ccb5ece9b1b9@spud>
 <NTZPR01MB0956A7393097129D3CD048EB9FE32@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20240514-congenial-smother-1e4b0fc6a5df@spud>
 <NTZPR01MB0956CF1AA9EA5A20A174FD8A9FEC2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0esYplcxwawkbSl6"
Content-Disposition: inline
In-Reply-To: <NTZPR01MB0956CF1AA9EA5A20A174FD8A9FEC2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>


--0esYplcxwawkbSl6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 15, 2024 at 02:23:47AM +0000, Xingyu Wu wrote:
> On 15/05/2024 02:08, Conor Dooley wrote:

> > There's a push in U-Boot to move devicestrees to use "OF_UPSTREAM", which
> > means importing devicetrees directly from Linux and using them in U-Boot. I
> > don't really want to merge a patch that would present U-Boot with a problem if
> > the VisionFive 2 moved to that model there.

> Would it be better  if I  change the rates of PLL0 and CPU core in the driver not dts,
> and avoid the dts of Linux and U-Boot being different?

I'd definitely prefer if we don't include stuff in the kernel tree that
would cause problems for U-Boot if imported there, yeah.


--0esYplcxwawkbSl6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkTjCwAKCRB4tDGHoIJi
0mXdAP45Fq2HjIOOGuw/DNTX8COHl/M4Og4CCDPl9ZvpBSrKhAEAnXj3M2a41LKv
r68Iay0nVDI4wfm5b+vYD81nKcHouwo=
=t5CG
-----END PGP SIGNATURE-----

--0esYplcxwawkbSl6--

