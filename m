Return-Path: <linux-kernel+bounces-375396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E399A956E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78161C22ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88042129E93;
	Tue, 22 Oct 2024 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Nj86iHVW"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25D8A927
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729560441; cv=none; b=aUUUqMhiBU/rmIKD9+FhXrGGBiyGrpSL2Hy2FLRX9PX1qHa0rfWdyVZVl7hymxSKCVssN0AzNsGS4Cptc4A6zGwBAjjACZf9469y7SmMhESv8meLDOn1j+WWhNj2jn3I6lH+OzdjVO9w23ShhDZw0PkqPBa749k4YbiAaTgSRdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729560441; c=relaxed/simple;
	bh=GNEsb1IDR1LtCglHvquGxieYelSvfTTE/KMUc/uVdmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=favclruuGU572u7UZGcdABzbBsueZ3QPPUYS6QsYgyXPxzM/XXp60moOlR6e8xsUevx40luitrIOM4xcjbb3DlMwve/nizALKTvyiJkb1fg8B+X5MMMY5XtIKZqdicUBQ0MdPmirMQ1dieH1UOFq4eFRVYUeAqYTHUax+r5hk+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Nj86iHVW; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=sZCXentdPD4D2xRsno79MZC4VEJPNh7C5JfKH0j0D/E=;
	b=Nj86iHVWI4x6AgMry/rjvx5arRkwQ2tGH+BctwDvjvf2DQmR/C9WcS2I4Vtlfb
	trMWjRXK7iWRrquJ595I1fxEIv/bzLJ9LJeBjfJfLy4sfoadD7QPU/il2i03Ikya
	WHlkj+oRh46qiDHeXqcwrBedNBiYMp7sG5BBF5FA3AdQM=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgBn41YY_xZnu7ORAA--.5277S3;
	Tue, 22 Oct 2024 09:25:46 +0800 (CST)
Date: Tue, 22 Oct 2024 09:25:44 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Andrew Davis <afd@ti.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v3 2/6] ARM: imx: Switch to new sys-off handler API
Message-ID: <Zxb/GEC2OXNs9K94@dragon>
References: <20241011201645.797394-1-afd@ti.com>
 <20241011201645.797394-3-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011201645.797394-3-afd@ti.com>
X-CM-TRANSID:M88vCgBn41YY_xZnu7ORAA--.5277S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVFALDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiER+AZWcWdwL5JAAAsy

On Fri, Oct 11, 2024 at 03:16:41PM -0500, Andrew Davis wrote:
> Kernel now supports chained power-off handlers. Use
> register_platform_power_off() that registers a platform level power-off
> handler. Legacy pm_power_off() will be removed once all drivers and archs
> are converted to the new sys-off API.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Applied, thanks!


