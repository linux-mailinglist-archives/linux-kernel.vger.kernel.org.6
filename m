Return-Path: <linux-kernel+bounces-414862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33059D2E73
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CFA2846CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346751D0F68;
	Tue, 19 Nov 2024 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="dO0X1I9g"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4DA13BACB;
	Tue, 19 Nov 2024 19:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732042880; cv=none; b=hrUeiDRDvAX+9DmxbWAqqL/Av2hN3jw1B7FEe+H5bvQilHwtikdculK/vKyF0kW/fCVNW0MY01tk9pG+avHs1x8pryw5wQcQ32NYyIQNy3tHDdBCioVlLWAL0fVieEInUfwfW9qBfn6RQQl0knwnpP5VJGtVkhHCn6rgp/BowuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732042880; c=relaxed/simple;
	bh=as1XVcosRkNzaH4BRJpnPhqnZ9iJCYHOUq2IzoL4jV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWgz49g948f0UYfs2BWO/u2W+cdVDOJWkIavdxjGWbxtPyh00wRORyVv+2l/FfS8G8dYnwyryiJy4KtBSWbm8+XMzWjlFxJqt18q74mBaqM1z4QAmrknb2BnWhpF1d+UL1AdbMQ+pYkH1PB3heQowuZV0voOxCcVXaO6SZmtdyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=dO0X1I9g; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 3F0A51FAC7;
	Tue, 19 Nov 2024 20:01:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1732042871;
	bh=UrTn/7rSGKkdLfBOAcUSvtVasFAVwxg9Ht3qmWHbO4k=; h=From:To:Subject;
	b=dO0X1I9gtg95s0+CuA9dLwF/VeTrEI8NLVnAfWrYYnOouPz6U4RIPdUBXHDFAcjaf
	 dLMZUP9TXMcmrB+IZh8VT9Im5nRDsEuanxgcko04Ym5mamhSrUGfhBjaON9TFigj5Z
	 CO0J2xJCKRJP5+Tx49eHyM64XI68NuSyx3ci6EbGWW4AUyJBMXGvomSyjbSUSdBXFV
	 Bi5AZ3fmQOHng5iebh0qZsrboI6Uf/P1hyZNZB0W9Jnkrid9OUHR/inLRcCzYm3zlF
	 pwo16o4Troc1wpXDkevHJIQOgRSaBkMzeawtOBWhSUaUs2gBOMnM1H4J0hL2azK+h2
	 f/8/0Cw7TJWoQ==
Date: Tue, 19 Nov 2024 20:01:06 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Thomas Richard <thomas.richard@bootlin.com>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, u-kumar1@ti.com
Cc: Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
	thomas.petazzoni@bootlin.com, richard.genoud@bootlin.com
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4: use ti,j7200-padconf
 compatible
Message-ID: <20241119190106.GA70080@francesco-nb>
References: <20241113-j784s4-s2r-pinctrl-v1-1-19aeb62739bc@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113-j784s4-s2r-pinctrl-v1-1-19aeb62739bc@bootlin.com>

Hello Thomas and TI folks,

On Wed, Nov 13, 2024 at 11:43:05AM +0100, Thomas Richard wrote:
> Like on j7200, pinctrl contexts shall be saved and restored during
> suspend-to-ram.
> 
> So use ti,j7200-padconf compatible.
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> ---
> Use ti,j7200-padconf compatible to save and restore pinctrl contexts during
> suspend-to-ram.
> ---
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi       |  6 +++---
>  arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 12 ++++++------

Do j784s4 supports any kind of low power mode and/or suspend to ram? My
understanding was that this was not supported, but maybe there is some
details that was lost when I was told this information.

Thanks,
Francesco



