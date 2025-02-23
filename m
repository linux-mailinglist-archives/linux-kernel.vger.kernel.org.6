Return-Path: <linux-kernel+bounces-527744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 035CAA40EED
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 13:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0108189AAA4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ABF206F09;
	Sun, 23 Feb 2025 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="eRTbiZ7C"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913861FDA86
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740313452; cv=none; b=FmQbw/3rj9yrDRPVopNcRBdCHFbuZqIRO7+JBnhGBfphOTE3eDWA4r/dHawsEWyV01Xni91GkxJifiUF+OewCtdBeT4U7yuced0b6Rt1CCQUe0Jqo61fxkwRAX+/Fp5jdxxgG9Risq5ebLmHT1dtWk6W9utgwbwBoqkjtFkuJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740313452; c=relaxed/simple;
	bh=SAtjKJzWIpJyRrFIuLsbqjKbdqlRUwzMsn7039kipes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjFq05uPpZNwsZMJ1dbDQELsxkArg0nZWjQbQg005AGcptG6hCLkAPtfythAQcy+eyoY7eJHKKzZkYjERglgUg1TFbwFNaUcoqqHCT5XMjNqA9aqZWSXPxU2RX1xBvmM8G2We0YlP5t1DmGrwwHnAGNzbBbUfHOPYTHmhhOAPO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=eRTbiZ7C; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=snjxivABr1OyDqYb2NVPxunB52diksXhIJ5NrLLPtwA=;
	b=eRTbiZ7C2HzhplWvs668ZS3GL4umJm5x5LFASkoRGSETScNulnTjRECIP0N2qg
	LJjI6/yLL6PMYe+JlohMdMxDdVmqHgYcs0gZQvAkH4G1m3innCX8fH44Vsh6zIYZ
	T3hF4SScFaLi4FR8iEYTSyqXI1z3qju5RjMO1iamFp4TI=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgBHbxscE7tnTfSOCQ--.21898S3;
	Sun, 23 Feb 2025 20:22:54 +0800 (CST)
Date: Sun, 23 Feb 2025 20:22:51 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mark Brown <broonie@kernel.org>, soc@lists.linux.dev,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] firmware: imx: IMX_SCMI_MISC_DRV should depend on
 ARCH_MXC
Message-ID: <Z7sTG4yMsek11nLe@dragon>
References: <9638976432d8dfcb0c4df9d454b661f9022a2d7b.1738766259.git.geert+renesas@glider.be>
 <Z7rMdg7+m6qa0Hft@dragon>
 <CAMuHMdW=ZH7D+m54rh-25nFShCYhRhEjkjaB1LtOrRF5RyrXiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW=ZH7D+m54rh-25nFShCYhRhEjkjaB1LtOrRF5RyrXiQ@mail.gmail.com>
X-CM-TRANSID:M88vCgBHbxscE7tnTfSOCQ--.21898S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrur45ur18tFW3AFWUGFykZrb_yoWDGwbEyr
	4vkw1DC345GryDCF1qgr1avr17t3y2qFWYq3s5Ga17WayfXayDAFn5CrWfAwnakay0gF1a
	krnIqrnYk34aqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnI38UUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEgH8ZWe63ifITQAAsr

+ Uwe

On Sun, Feb 23, 2025 at 09:29:29AM +0100, Geert Uytterhoeven wrote:
> Hi Shawn,
> 
> On Sun, 23 Feb 2025 at 08:21, Shawn Guo <shawnguo2@yeah.net> wrote:
> > On Wed, Feb 05, 2025 at 03:41:43PM +0100, Geert Uytterhoeven wrote:
> > > The i.MX System Controller Management Interface firmware is only present
> > > on Freescale i.MX SoCs.  Hence add a dependency on ARCH_MXC, to prevent
> > > asking the user about this driver when configuring a kernel without
> > > Freescale i.MX platform support.
> > >
> > > Fixes: 514b2262ade48a05 ("firmware: arm_scmi: Fix i.MX build dependency")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Thanks for the patch, Geert!  But I have just picked up the change from
> > Uwe [1].
> 
> Thanks, but mine has been upstream since Friday ;-)
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=be6686b823b30a69b1f71bde228ce042c78a1941

Ah, Arnd beat me to it.  Thanks for information!

Shawn


