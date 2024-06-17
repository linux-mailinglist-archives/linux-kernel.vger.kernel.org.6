Return-Path: <linux-kernel+bounces-216618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7E290A24F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9751F22075
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C167E161310;
	Mon, 17 Jun 2024 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="U75G3swG"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1647879F3
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718590135; cv=none; b=qpjDGx5pJWrYqdjZ/302WygroyYIzCLupEgSofsgPzZnC5Br8hsDRGt7MaFC+dXEixVldfLTW8lCNMuA52nv1OcaCCJZrBjxvPR2q9QH5Ne+S2QHlOxLTskLDlJUkcWjvPiCi9STkFUd0fY0nKyVr/gm4NKwzfYnhnRXZjU+nOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718590135; c=relaxed/simple;
	bh=/XmKsJyGEinE7lOhcuaR9pp9pCTWZBqAYc1028/Hr6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elzG8hd+u9RkykaztxMNoBJiS0WDSH4kYsvn7g8+n5tNKIaUuBUORmOr9CAL8WyZ0RzdAV1bqAGf5idbcfx8QGEIenm4zWfcMHbzTnmzg2vYUZPXTDLJrwh8LvCThbBdmhglfFX467KpLISWrFjNS7B0tTCabkl+XoghJ+iYh1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=U75G3swG; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=eUJbS9Qt4DWbWT3Zmh3rSQs58LkamINvp8lvJ2sZAyY=;
	b=U75G3swGPMxSe1fxh3ViIqabYOGc8pCjediQbe++98avINjFQmhmv88+NqRvwv
	qc55t3JiVcsJ+bmOUq+nbbqtulplhVUizmqvBpaWKOGmHNNKNolQn6FBzlEEWQDI
	ZFFfjX6HCcEq3LRWdSNF2alQOc/vEB47JNh9Cz/6xgWw0=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrAAHbvp4mm9m9QMMCA--.41974S3;
	Mon, 17 Jun 2024 10:07:53 +0800 (CST)
Date: Mon, 17 Jun 2024 10:07:52 +0800
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
Subject: Re: [PATCH 2/6] ARM: imx: Switch to new sys-off handler API
Message-ID: <Zm+aeGXQvxgiHv3M@dragon>
References: <20240610125924.86003-1-afd@ti.com>
 <20240610125924.86003-2-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610125924.86003-2-afd@ti.com>
X-CM-TRANSID:ClUQrAAHbvp4mm9m9QMMCA--.41974S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUafMaUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBRkBZVsVCpyjVwAAsU

On Mon, Jun 10, 2024 at 07:59:20AM -0500, Andrew Davis wrote:
> Kernel now supports chained power-off handlers. Use
> register_platform_power_off() that registers a platform level power-off
> handler. Legacy pm_power_off() will be removed once all drivers and archs
> are converted to the new sys-off API.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>


