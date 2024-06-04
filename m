Return-Path: <linux-kernel+bounces-201049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5B78FB89A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544E4289218
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8771474BF;
	Tue,  4 Jun 2024 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0o8vBLq6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516E777A1E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717517761; cv=none; b=Hlsf2z1EO0BThM4nP93c0bU0m2oMjukTQm32k45D5QZsYBGmFmeezbwJNHT5qLHaXUHV8NgP/12m83vgswkjh4sPWgR0ZnvosPsvogKCTVNn4ggP7IIvdiRcd7fUo7UVBs6tgBfcv0dJ4zvQyERSqxiauIaga+MBP2VcGLwdvuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717517761; c=relaxed/simple;
	bh=poT0v2FdUDfb3BEOAqGetdclur+49x8g5bWIztN0LU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtI65WJ5bp3C7cgEBTUtDVOzyO0Mz8bs0VXVzMBbV1wk0Eb51elyoNpM+YhYg0gpjaXOFUcT7IADPFdLspxb1Gsw2ElfX88hZXAqJz0XUUf7b9xwroglG2v760wK4GV9eLGxhrR/LvXM8PXbo/+PGyOI5SYVQPX96MCs/BOhzY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0o8vBLq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F231DC32786;
	Tue,  4 Jun 2024 16:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717517760;
	bh=poT0v2FdUDfb3BEOAqGetdclur+49x8g5bWIztN0LU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0o8vBLq6b9jT2dTw/8TRrHwtEx7cy5f4s4c3Z6KC8n+G0PeaD8YBf45gqdGGXGTCQ
	 o0v50dyzwENby5kmKFHD46jlzp6M8cjXT16Q9cKQdX2FYG6YckDBwTEvXJdo9pGFMt
	 YT4awQeoVcQ5aSsyG7CCAXtMWIPbxokdCw3Nosf8=
Date: Tue, 4 Jun 2024 18:13:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
	David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>,
	Nishanth Menon <nm@ti.com>, Jeremy Kerr <jk@ozlabs.org>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Thierry Reding <treding@nvidia.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH] platform: Make platform_driver::remove() return void
Message-ID: <2024060432-relieving-yonder-85ae@gregkh>
References: <20240527083416.1177106-2-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240527083416.1177106-2-u.kleine-koenig@pengutronix.de>

On Mon, May 27, 2024 at 10:34:15AM +0200, Uwe Kleine-König wrote:
> struct platform_driver::remove returning an integer made driver authors
> expect that returning an error code was proper error handling. However
> the driver core ignores the error and continues to remove the device
> because there is nothing the core could do anyhow and reentering the
> remove callback again is only calling for trouble.
> 
> To prevent such wrong assumptions, change the return type of the remove
> callback to void. This was prepared by introducing an alternative remove
> callback returning void and converting all drivers to that. So .remove()
> can be changed without further changes in drivers.
> 
> This corresponds to step b) of the plan outlined in commit
> 5c5a7680e67b ("platform: Provide a remove callback that returns no value").
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello Greg,
> 
> there are only very little platform drivers left in v6.10-rc1 that need
> to be changed to .remove_new() before this patch can be applied. They
> were all sent out to the respective maintainers, most of them suggested
> to apply the patches together with this one.
> 
> You can fetch this patch together with all necessary commits from:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git platform-remove-void
> 
> If you have no concerns, I can also provide you a signed tag for
> pulling. I think that's easier than indiviually applying them, but I can
> also send out the complete series if you prefer.

A signed tag is good, I can just pull from that, thanks!

greg k-h

