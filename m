Return-Path: <linux-kernel+bounces-295353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1529599FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03841C21530
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839481B2527;
	Wed, 21 Aug 2024 10:43:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6BD1531F3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724237032; cv=none; b=PThSn0C1CtZT6c5hFyWuuyrANBhymdH+JAhIEE8y7hbe+EIMtlIXRdxKGSTEs1b/c4oP2/Uwgh8lBwSgDAjxfTg3JxWOW1H8VVASe5x045BoCE+ihrRcJZWKqEtWblsTnBx4FmXzbGUS3QElQ346M3YbyeCdPTKbw+tJDWnaruY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724237032; c=relaxed/simple;
	bh=LyaB+owgaWByCR46XNCEzrLlyYBnWR3RnEUCDqhzieM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDS8i3zYHvxxIQkIv0Asm+MpFCRPbn8j47dC0Fe8ghd8naZ4S4aMfIVsCXCWhvtOQP4Ombb2tsMQpQK/u9NJywK430PfXeHMqR8eV38mD1qZl6nd5xYgxtxYYzUKJtgCiBzoV8IT188KDC/cQxFo/z1p5L6Q9T0fIadPwYe5POU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602D1C32782;
	Wed, 21 Aug 2024 10:43:49 +0000 (UTC)
Date: Wed, 21 Aug 2024 11:43:47 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Arnd Bergmann <arnd@kernel.org>,
	Judith Mendez <jm@ti.com>, Will Deacon <will@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: Re: [RFC PATCH] arm64: defconfig: Set MFD_TPS6594_I2C as built-in
Message-ID: <ZsXE427Dh6w35wvz@arm.com>
References: <20240819204352.1423727-1-jm@ti.com>
 <1a7def3f-a19c-4f1c-845c-a3854c165995@linaro.org>
 <20240820115331.myibtim7enhpg4cm@mortality>
 <323cc7c0-8511-4d21-9925-97a6ba94280f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <323cc7c0-8511-4d21-9925-97a6ba94280f@linaro.org>

On Wed, Aug 21, 2024 at 08:33:49AM +0200, Krzysztof Kozlowski wrote:
> On 20/08/2024 13:53, Nishanth Menon wrote:
> > On 23:01-20240819, Krzysztof Kozlowski wrote:
> >> On 19/08/2024 22:43, Judith Mendez wrote:
> >>> SK-AM62A-LP is a device targeting automotive front-camera applications
> >>> among other use-cases. It utilizes the TPS6593x PMIC (interfaced over I2C)
> >>> to power the SoC and various other peripherals on the board [1].
> >>>
> >>> MMCSD requires the PMIC to be setup correctly before setting the bus
> >>> pins to 1.8V using the TPS6594 driver interfaced over i2c.
> >>>
> >>> Currently, the following could be seen when booting the am62ax platform:
> >>>
> >>> "platform fa00000.mmc: deferred probe pending: platform: supplier regulator-5 not ready"
> >>> "vdd_mmc1: disabling"
> >>>
> >>> and a failure to boot the SK-AM62A-LP.
> >>>
> >>> One solution is to use initramfs [2], but using initramfs increases the
> >>> boot time for this automotive solution which requires faster boot time
> >>> parameters.
> >>
> >> This is a defconfig, not a distro/product config, so your product
> >> constraints are not really relevant. You are supposed to boot defconfig
> >> with proper initramfs with necessary modules.
[...]
> > I understand that you have provided similar comments for other
> > platforms[1] as well, but, I am now wondering if this is a new rule
> > we are taking in aarch64 platforms to allow just initramfs and
> > force all drivers to be modules (I understand that is the default
[...]
> There are different point of views. I am presenting here mine and I back
> it with arguments, that such changes accumulate and have impact on
> developers workflow.
> 
> Defconfig is for developers and as starting point for distros or
> products. Not as final product defconfig.

Drive-by comment here (defconfig is mostly an arm-soc thing): in general
I agree with this position. Just because a product cannot (efficiently)
use initramfs, we shouldn't pollute the default built-ins with random
drivers. If you want something optimal for your product, just tweak the
defconfig or take it up with the distros. I'm fine with built-ins,
however, if they are required before reaching the initramfs stage (e.g.
interrupt controllers) but that's not the case here.

-- 
Catalin

