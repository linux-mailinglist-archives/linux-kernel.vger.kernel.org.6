Return-Path: <linux-kernel+bounces-430900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C4A9E36FB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B42286776
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7321AB53A;
	Wed,  4 Dec 2024 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="qY+SjmGk"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C31818A6C4;
	Wed,  4 Dec 2024 09:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306373; cv=none; b=eBt8FCcbZ8AuUYTlzVFeilzjfbqDumefHmwrxTQhv6b5fUykGY6M+ldwXu7L07hRAxQ/mC5abyG3THX20G/a598bvTvmpUH+Xry69eO8Ftnea1S2Vd0Qpef9mI+d0kK2BLnT8Mk99HmRRN3EYj5DY/1YR14vflwQWjN3WDqiHoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306373; c=relaxed/simple;
	bh=FvlgQLDIsF9Xq755Nj8j7WeVcqhuerlvuYWBWOG6FsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G01vkXzWZ+/8wIzcSlLawwAa1fk5b9CTvpX13k1zClNnAZtRWb54Ccj0rmXrByXcAuG2epKXbzQ0bFlpdjv8tcy7EjpD/IJYW1Npoof/rBu9jfxgaPn7tDB66hzk0a6Tzt5MVliRM2YXfmKN1egzNyaBwPdBSirkkRJxA4gtFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=qY+SjmGk; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 5A2421F901;
	Wed,  4 Dec 2024 10:59:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1733306360;
	bh=/qN2pcbKct0OFAiDG1HqVY+jak1ZOWpO63jeufzmzZw=;
	h=Received:From:To:Subject;
	b=qY+SjmGkuiku9yZHG1TAe5R6MaYjbtplKU78gR+iYaKOHtcO3XV46VV5ESV4QTyEI
	 TYJbrN3jEDkPznA/FcMVEZjdar1B4HBIPvr1h/n9gHNfh8Stq3CngcRtlgY5xcbpPk
	 7PtbcGfwpp/v2LTVd887AL1X8qWJwzRs6rfbIqjpT9pwsk+mg3hy8SAIGZW5fm2HU/
	 MlsuLOseuXZMnKAikwW+CUi6ehxr6jWcjRvI47o7nwdh+wFoSjQ7X6dxiAvkpV5oji
	 MKgUJkWWdLdw6zyhjYaYI0lHCuFxn0NUXKO0K/wZyv8cZJSXVBaes7ydENy7NMUHTQ
	 ukzQZy3PYTkfw==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id A0BFF7F9A5; Wed,  4 Dec 2024 10:59:19 +0100 (CET)
Date: Wed, 4 Dec 2024 10:59:19 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Francesco Dolcini <francesco@dolcini.it>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, u-kumar1@ti.com,
	Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
	thomas.petazzoni@bootlin.com, richard.genoud@bootlin.com
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4: use ti,j7200-padconf
 compatible
Message-ID: <Z1An9_auC3dRyPln@gaggiata.pivistrello.it>
References: <20241113-j784s4-s2r-pinctrl-v1-1-19aeb62739bc@bootlin.com>
 <20241119190106.GA70080@francesco-nb>
 <6e47e420-84c4-4539-ba54-5e1e939a37a5@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e47e420-84c4-4539-ba54-5e1e939a37a5@bootlin.com>

Hello Thomas,
thanks for the update.

On Wed, Dec 04, 2024 at 10:08:43AM +0100, Thomas Richard wrote:
> On 11/19/24 20:01, Francesco Dolcini wrote:
> > Hello Thomas and TI folks,
> > 
> > On Wed, Nov 13, 2024 at 11:43:05AM +0100, Thomas Richard wrote:
> >> Like on j7200, pinctrl contexts shall be saved and restored during
> >> suspend-to-ram.
> >>
> >> So use ti,j7200-padconf compatible.
> >>
> >> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> >> ---
> >> Use ti,j7200-padconf compatible to save and restore pinctrl contexts during
> >> suspend-to-ram.
> >> ---
> >>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi       |  6 +++---
> >>  arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi | 12 ++++++------
> > 
> > Do j784s4 supports any kind of low power mode and/or suspend to ram? My
> > understanding was that this was not supported, but maybe there is some
> > details that was lost when I was told this information.
> 
> We are working on suspend-to-ram support for j7200 and j784s4.
> During suspend-to-ram the SoC is fully powered-off (thanks to the PMIC
> which powers off all the power rails except the DDR which is in
> self-refresh), like on j7200.
> Please let me know if you want more details.

ok, that's quite different from the common suspend-to-ram we use to have
implemented on other SoC. You would have some boot firmware (likely U-Boot)
code executing during resume, taking some different code path, in a similar way
to what it is being done for the partial-io support on am62p. It's going to be
more similar to hibernation from some point of view.

Do you expect to have this feature nicely integrated within the standard
suspend/resume "framework" in Linux?

It would be interesting to understand how to handle all the peripherals outside
the SoC, if you have reset/regulator controlled by GPIO from the SoC stuff will
happen as soon as the SoC is powered off since no one will drive this pins any
longer. From my understanding the only solution would be to not have such
regulator/reset connect to the SoC.

Francesco


