Return-Path: <linux-kernel+bounces-336753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB64984057
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF937B20A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA02114D44D;
	Tue, 24 Sep 2024 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWEVrvSy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D16822315;
	Tue, 24 Sep 2024 08:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727166165; cv=none; b=aUVcF6rThLc/MycFmaHopfAd1O6Pl7ojuj2boEo494lKCoy+dDQlVdrvAyFlug926pDVba+oQDPeVOStNzcdIH5QG+r1d2nBekx+pkD4nkJiWqqKyTW9EccqLzRaTUcJaxLx30zgVKbYxZO2P6rfg2pXzFKzEtEYRRGGrbCWX8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727166165; c=relaxed/simple;
	bh=1k2BvdlSnKvudqdu6QNfjXKlDapz+vpyQHbc72gBgqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ij05jGMFdNLEHuEybbFaysXx0BwdbFbLJOCNNL1Gasx88qHuRmOwv5SBSW2RUMcOiJxSSG0jJlKLcz8Ugbcn6VVu6yFyl4XV3rKp6+EkIq0N/LVGixDdNh8ZZ0dmi/9H2v/hVGmE5Yx7ZcRzpHJEL7TO7XLcTUTuNW5M637EbCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWEVrvSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF33C4CEC4;
	Tue, 24 Sep 2024 08:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727166164;
	bh=1k2BvdlSnKvudqdu6QNfjXKlDapz+vpyQHbc72gBgqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iWEVrvSyYOCIUtt0WwFq55vgbUxepj9MO1pdJZtO6UdbpZ4GHA9XYtT0RTVAURm8o
	 EVE6tV2eIMMPhNztX7rm061OslHAWVPFc5rd+TDoqbIK1Qgm7djByqzpt2h6L/NGe4
	 rZX5odGgjvlM92gRMMsMs98FHIJ20aRtxBiyTLmaDSsC3dhUgCoO333a4me8Qu/NlH
	 oj42sgqspBzafTLtr7NxvUuoeHg11fmH+1DV1VvEmEwxTcRlkPPCAEGbsekfCXXbR8
	 esOjnp9DIBNtIkl1egIyJ61sYDezhXRx2r+HmyUJR2AHMXetCcPqVYr3Qmf1VRD8Dq
	 bmlJW0DvPsmKA==
Date: Tue, 24 Sep 2024 10:22:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shawn Guo <shawnguo@kernel.org>, 
	Petr Benes <petr.benes@ysoft.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Herburger <gregor.herburger@ew.tq-group.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Joao Paulo Goncalves <joao.goncalves@toradex.com>, 
	Michael Walle <mwalle@kernel.org>, Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Mathieu Othacehe <m.othacehe@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/4] Add support for new IMX8MP based board
Message-ID: <vghktkih6pdjrui7sjs2gn2elfcdlplh37ahzcm2xnqin3rh4g@cck4xniyourm>
References: <20240923151417.1665431-1-michal.vokac@ysoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240923151417.1665431-1-michal.vokac@ysoft.com>

On Mon, Sep 23, 2024 at 05:14:13PM +0200, Michal Vok=C3=A1=C4=8D wrote:
> Hi,
>=20
> this series adds support for a new member in our IOTA=C2=A0platform.
> The board is based on the i.MX8MP SoC. The first two patches
> add support for most of the board functionality except USB Type-C
> port and some other minor things.
>=20
> [PATCH 3] adds new device tree binding for a Diodes Incorporated
> PI5USB30213A Type-C Controller and [PATCH 4] enables that port on
> the IOTA2 Lumpy board.
>=20
> We also wrote a driver for that Type-C port controller. I would like
> to get that driver upstream as well but I expect it will take much
> more iterations and effort to get it into mainline-ready shape so
> I intentionally excluded it from this series. AFAIK it should not
> be a problem to accept a device tree binding for a HW that does not
> have a driver in the kernel yet.

It's unusual but okay. It will be however more difficult for you - any
changes in the binding in the future (when writing driver) will be
rejected on basis of breaking ABI, even if Linux does not use that ABI.

Best regards,
Krzysztof


