Return-Path: <linux-kernel+bounces-370885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B069A333D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707782855E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 03:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A3413E04B;
	Fri, 18 Oct 2024 03:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="qdvBHEWT"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7157C3FB3B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729221465; cv=none; b=A9iCT1bKfmlkeE5dZVTgiO8JOYeseww921QadlVTVwkt5NYA1AagABZrsJZ6bJbPlPPzjNGLlP9Fz7v0GVe+I3fn3i259mB4rkyc1rF9o278dSBf1tEokfjbBnSzomrj2TsgLprpfQ57td+9CCUtn+M4RJYpOxi9FQNDPpVO+sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729221465; c=relaxed/simple;
	bh=cUrpr9qroScqXZT5dhpQhY0mis+F5rsSbBg6Ficg7MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQJN2iUJhmSx9X9vTHWhSg3BOP0Z/dziWB8zUYfL7DPZp23LbIEl97a2JFtnfqmZmJNOFtOE4CUPuJKpmelmMlH0YdsCI/uMFm1IXtOwoTbxibYNj2IJroflm4yO9Uo1wpzyVecstB+SFK1UBHGaR5jlp+vIo2A3bcAldiN5JTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=qdvBHEWT; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=yEk24EEbUheM26KZ9Y5UZSg71Glq65ticUsqrmiR49g=;
	b=qdvBHEWTAB+JUPEtaDPM9Ll5UYrYHsKf2aglfn8A8DYK3g/+bg9RLAP2SFu8zV
	K8LyrJbdtjWsYTWWXHbGXSvCgg3NuzKiraACCIZjvWAaMpaUb6PCRNZAZP4/swcs
	7kUKoDJDUzoPNTwfR0WDf+Da6MVQYZ45p02+Seixsnj8U=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgC3Acab0hFnc11BAA--.2050S3;
	Fri, 18 Oct 2024 11:14:37 +0800 (CST)
Date: Fri, 18 Oct 2024 11:14:34 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, kernel@dh-electronics.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@gmail.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Saravana Kannan <saravanak@google.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] soc: imx8m: Probe the SoC driver as platform
 driver
Message-ID: <ZxHSmt0Aml3Zkewe@dragon>
References: <20240929184930.73049-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240929184930.73049-1-marex@denx.de>
X-CM-TRANSID:Ms8vCgC3Acab0hFnc11BAA--.2050S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww1UtF4kZry3uF4DZryftFb_yoW8KFy3pF
	4fJr17CF4kGr47Aw17Ar45Ar45tayUA3W8Xr1xJr18uF15Cr1UAF1xtFWxGryDArWjqFn3
	tF1qq3y8tF4rJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2NtsUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAhh8ZWcRl-6bMQABs3

On Sun, Sep 29, 2024 at 08:49:16PM +0200, Marek Vasut wrote:
> With driver_async_probe=* on kernel command line, the following trace is
> produced because on i.MX8M Plus hardware because the soc-imx8m.c driver
> calls of_clk_get_by_name() which returns -EPROBE_DEFER because the clock
> driver is not yet probed. This was not detected during regular testing
> without driver_async_probe.
> 
> Convert the SoC code to platform driver and instantiate a platform device
> in its current device_initcall() to probe the platform driver. Rework
> .soc_revision callback to always return valid error code and return SoC
> revision via parameter. This way, if anything in the .soc_revision callback
> return -EPROBE_DEFER, it gets propagated to .probe and the .probe will get
> retried later.
> 
> "
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1 at drivers/soc/imx/soc-imx8m.c:115 imx8mm_soc_revision+0xdc/0x180
> CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-next-20240924-00002-g2062bb554dea #603
> Hardware name: DH electronics i.MX8M Plus DHCOM Premium Developer Kit (3) (DT)
> pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : imx8mm_soc_revision+0xdc/0x180
> lr : imx8mm_soc_revision+0xd0/0x180
> sp : ffff8000821fbcc0
> x29: ffff8000821fbce0 x28: 0000000000000000 x27: ffff800081810120
> x26: ffff8000818a9970 x25: 0000000000000006 x24: 0000000000824311
> x23: ffff8000817f42c8 x22: ffff0000df8be210 x21: fffffffffffffdfb
> x20: ffff800082780000 x19: 0000000000000001 x18: ffffffffffffffff
> x17: ffff800081fff418 x16: ffff8000823e1000 x15: ffff0000c03b65e8
> x14: ffff0000c00051b0 x13: ffff800082790000 x12: 0000000000000801
> x11: ffff80008278ffff x10: ffff80008209d3a6 x9 : ffff80008062e95c
> x8 : ffff8000821fb9a0 x7 : 0000000000000000 x6 : 00000000000080e3
> x5 : ffff0000df8c03d8 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : fffffffffffffdfb x0 : fffffffffffffdfb
> Call trace:
>  imx8mm_soc_revision+0xdc/0x180
>  imx8_soc_init+0xb0/0x1e0
>  do_one_initcall+0x94/0x1a8
>  kernel_init_freeable+0x240/0x2a8
>  kernel_init+0x28/0x140
>  ret_from_fork+0x10/0x20
> ---[ end trace 0000000000000000 ]---
> SoC: i.MX8MP revision 1.1
> "
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied all, thanks!


