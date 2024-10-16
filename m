Return-Path: <linux-kernel+bounces-368801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C93669A151C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EDBB285253
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668471D3181;
	Wed, 16 Oct 2024 21:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab5xwJqa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC0B125B9;
	Wed, 16 Oct 2024 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115397; cv=none; b=Y6tNmbfFsD9g6YS3EvPDzvHH1an1Ypq7yeA9e/3a9j8Ok2WeDMq1DGpA5PsbLt0Ba/IMKX9UMwTwBEePSzigr1Xk9DNpJRTt1drVYo2eYfPM8vkv0rJRLWZBzkGAh77O4dY82TBQdPENEsjU7kPnkjq1HqWEeK+MdpSiBG6PFdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115397; c=relaxed/simple;
	bh=Hp+H7yoAyapEdhvaBlQzGXZZGhKUy3jtoMpeNHH/Y0o=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=eFRW10rye4ej2OB/r07pw9dhxaX8KtxZtG5nS+NkQhnoMkzNd0hcplcDq8h/OwND9LoDOh4NnFBohHtjvjCQc9hJNYSrw+JOC8RVlzElbgKQFEyqYVQM0FDpnL3K7CHrZ3otwdpMxfkNxRmSBOgkMJqkJEljz1zFA3swU4sB5vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ab5xwJqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC69C4CEC5;
	Wed, 16 Oct 2024 21:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729115397;
	bh=Hp+H7yoAyapEdhvaBlQzGXZZGhKUy3jtoMpeNHH/Y0o=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ab5xwJqainPvNFCX2PalKHOxzA3L3nK5zwFARgT7/XEdijZX9hA/UkoSQkW7mAhg7
	 d+GCqVvXl2YVMFIF6IQHziwyR5aQbcUH/Om7q9iPTziNPrO6mN4HclkwRDecstvltL
	 PGbCqzvHo26Yka4ACeSDyJL7mGbTcsMmpnv8AXQ36QeRbTgTRsJ9cSZzJIqWLVanpl
	 IRmnWcCWUUGWAuah2wOXkmrZT6F6tgPWmOp9yA96Al8enfsKSM+zVQUSkYfoSDLFlw
	 a6q05U84twcZ+PLbdsOsZ5ToLR5vT8WtU61x+hrddn0ZtNeCqin6YLT1lOwGVjFbLR
	 TgafhqGvGqgmw==
Message-ID: <4c7956afc86ea05f07b25d98ffb5b80c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241014-imx-clk-v1-v1-4-ee75876d3102@nxp.com>
References: <20241014-imx-clk-v1-v1-0-ee75876d3102@nxp.com> <20241014-imx-clk-v1-v1-4-ee75876d3102@nxp.com>
Subject: Re: [PATCH 4/4] clk: imx: fracn-gppll: fix pll power up
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Peng Fan (OSS) <peng.fan@oss.nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Date: Wed, 16 Oct 2024 14:49:55 -0700
User-Agent: alot/0.10

Quoting Peng Fan (OSS) (2024-10-14 02:11:25)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> To i.MX93 which features dual Cortex-A55 cores and DSU, when using
> writel_relaxed to write value to PLL registers, the value might be
> buffered. To make sure the value has been written into the hardware,
> using readl to read back the register could make sure the value
> written into hardware.
>=20
> current PLL power up flow can be simplified as below:
>   1. writel_relaxed to set the PLL POWERUP bit;
>   2. readl_poll_timeout to check the PLL lock bit:
>      a). timeout =3D ktime_add_us(ktime_get(), timeout_us);
>      b). readl the pll the lock reg;
>      c). check if the pll lock bit ready
>      d). check if timeout
>=20
> But in some corner cases, both the write in step 1 and read in
> step 2 will be blocked by other bus transaction in the SoC for a
> long time, saying the value into real hardware is just before step b).
> That means the timeout counting has begins for quite sometime since
> step a), but value still not written into real hardware until bus
> released just at a point before step b).
>=20
> Then there maybe chances that the pll lock bit is not ready
> when readl done but the timeout happens. readl_poll_timeout will
> err return due to timeout. To avoid such unexpected failure,
> read back the reg to make sure the write has been done in HW
> reg.
>=20
> Introduce fence_write for this purpose.

Please just write out the readl() instead of introducing a bespoke macro
that isn't generic for all architectures.

