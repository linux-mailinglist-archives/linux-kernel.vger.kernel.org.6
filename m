Return-Path: <linux-kernel+bounces-405767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C029C56C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D261F211CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A822309A8;
	Tue, 12 Nov 2024 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vknOjlpo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653FF23098C;
	Tue, 12 Nov 2024 11:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411575; cv=none; b=SicAf4fd6Kbx8vKS5ZzFHvSi0ovq7PB3oW/r/mNJ+INLAi8fT7/pmq7Eo/1RJo4ij765nG7OOQhMblGGTO2A9xQuQpWv11OYdryNV7iDeXLQK49Z8wMMdYxWvZHjKD0AQ2LwAihsH2xj+bBNZm7Z85d7Yw134ciqIXbeMAcnak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411575; c=relaxed/simple;
	bh=LG7RZyrQQCMMftiyBGThQS+gGDQCRxNRxi5jzF0rtMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brWwCOwjCsznjZNN8YVHfqjz2OwY0fjMUb+i5tlRk/6ggcuH+fOLpj6CicYXSatqe1s8Yh3p+VY0wp2AMq2t62hV1RMaIp8UEWs7GsaDm8vLBbHO2WqIxQq/usCRGpBRnHmbDHX7VhyAc47O2jO/usl8DfNODsOPi2XuvsLO5Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vknOjlpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6627CC4CECD;
	Tue, 12 Nov 2024 11:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731411575;
	bh=LG7RZyrQQCMMftiyBGThQS+gGDQCRxNRxi5jzF0rtMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vknOjlpo6yb1Vp6IvyGWB9fU+5x7MozaZPEx5An53FahQpTAnNO5K4ounXAy8oTiB
	 TMyhmIa3vhWYr8Y70CpG7AqAsJ6Muua1r2mtSVbGPeuPR0Yb5JXd60v2VL3pSHRStQ
	 uWb9VIFmeHvu95V7xCVSAH9p70B6Adjzvh7A37xU=
Date: Tue, 12 Nov 2024 12:39:32 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Gabriel Somlo <somlo@cmu.edu>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
	Ronak Jain <ronak.jain@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
	imx@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-mediatek@lists.infradead.org, qemu-devel@nongnu.org,
	linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH] firmware: Switch back to struct platform_driver::remove()
Message-ID: <2024111223-gizzard-scabby-eb98@gregkh>
References: <36974feb6035201d53384557259ec72fe311053b.1731397962.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36974feb6035201d53384557259ec72fe311053b.1731397962.git.u.kleine-koenig@baylibre.com>

On Tue, Nov 12, 2024 at 09:35:20AM +0100, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/firmware to use .remove(),
> with the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> I did a single patch for all of drivers/firmware. While I usually prefer
> to do one logical change per patch, this seems to be overengineering
> here as the individual changes are really trivial and shouldn't be much
> in the way for stable backports.
> 
> There is no dedicated maintainer for drivers/firmware, maybe Sudeep as
> biggest committer there can take it? Or would it be sensible to split
> this patch?

I'll just take it now, thanks!

greg k-h

