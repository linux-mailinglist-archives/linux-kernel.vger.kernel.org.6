Return-Path: <linux-kernel+bounces-510658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2A4A32015
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C54188923C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20342046A5;
	Wed, 12 Feb 2025 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="czuCKK9M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C573D1DACB1;
	Wed, 12 Feb 2025 07:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739346017; cv=none; b=pUTMNR1hVltnDNd00bBYH4Fnbsv4/pt5nuvN332FquKYBsPBNe6Oo4wYCtew4TQduvfrT1fdd1Lg5FkTjZy8qOsq1xCD5U0Af17nyA2omnTZYKXR1BXNBbZdIe6KCMCTg35Vocgb1FP8MrwRXoPaaw0z8qgLUr6lfiwrmFHqnwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739346017; c=relaxed/simple;
	bh=JTl7E5auMjAWSwtkSkJOr08cyWlGJ4CniI1B/9Pp0D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYDwcbwDMAoJ3X0EfvGtwiYmExIs2iygJmHti34TPpnwx3LGhfe7t8w1p0LT2r5DrqVdKe6t+Gu7Lmwxau0NFysMPcBH6vrbhY4V1vsd5em/edDfSvOuv3WOCygIGOXQbxpGbJTbqEzgyRAKGjGpyda/BbO8I3LcMDGJTtA05zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=czuCKK9M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF738C4CEE5;
	Wed, 12 Feb 2025 07:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739346016;
	bh=JTl7E5auMjAWSwtkSkJOr08cyWlGJ4CniI1B/9Pp0D0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=czuCKK9MIeKkqWcEuk0XXFX7fJRj4gL/oh6h1kIllbYWYJOhO2EpLVVDKNfmfAWQZ
	 cne9HkIu6bPoBMPBtH7f8wFnB7X7qfg89z9jl5yo5jOz/ZWYs13piMApQfLUQFfrD5
	 P40yv4UULUoCq28dfsNQZE5jUPRZlybWTMTMLT00=
Date: Wed, 12 Feb 2025 08:39:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org,
	Lyude Paul <lyude@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Lukas Wunner <lukas@wunner.de>,
	Mark Brown <broonie@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Robin Murphy <robin.murphy@arm.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Zijun Hu <quic_zijuhu@quicinc.com>, linux-usb@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH v4 1/9] driver core: add a faux bus for use when a simple
 device/bus is needed
Message-ID: <2025021209-ultimate-dazzler-0e81@gregkh>
References: <2025021023-sandstorm-precise-9f5d@gregkh>
 <2025021026-atlantic-gibberish-3f0c@gregkh>
 <D7OU5VOXCS8M.39YEYRWFL1MPW@gmail.com>
 <116e9983-6c5f-45f3-a933-dcded223f6d7@icloud.com>
 <D7PQHGGX4WPC.26F52356ISZU8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D7PQHGGX4WPC.26F52356ISZU8@gmail.com>

On Tue, Feb 11, 2025 at 10:49:34AM -0500, Kurt Borja wrote:
> On Tue Feb 11, 2025 at 10:29 AM -05, Zijun Hu wrote:
> > On 2025/2/10 22:29, Kurt Borja wrote:
> >>> +
> >>> +	ret = device_add(dev);
> >>> +	if (ret) {
> >>> +		pr_err("%s: device_add for faux device '%s' failed with %d\n",
> >>> +		       __func__, name, ret);
> >>> +		put_device(dev);
> >>> +		return NULL;
> >>> +	}
> >> Now that the probe is synchronous, what do you think about returning
> >> -ENODEV if the device failed to bind to the driver?
> >> 
> >
> > Result of device registering @ret is not, should not be, effected by
> > "device binding driver (probe result)"
> >
> > if device binging driver failed, you may return -ENODEV in
> > faux_ops->probe(). not here.
> 
> After thinking about this discussion, I understand why this might be the
> expected behavior. I'm thinking about very simple modules that would
> remain loaded even if the probe fails. But of course this may cause
> problems to other modules.
> 
> In the end, this is just my opinion so it would be up to Greg to decide.
> However, there is still an issue with the groups added to the device,
> which a user might expect they are tied to an "attached" device
> lifetime and this currently not the case.

I agree with you here, this could be confusing and cause problems, and
we should be creating apis that "work properly and simply".  Having a
probe callback is good to add device data like you mention, so that you
can properly add the information before the sysfs files are accessed,
removing that race condition.

> >> This would be useful for modules that may want to unload if the probe
> >> fails.
> >
> > may need to root cause if probe failure happens.
> >
> > how to unload module automatically if probe() failure ?
> 
> If we check for !dev->driver, a module might propagate an error to the
> module_init, thus making it fail to load.

Agreed.  Thanks so much for your review comments, they are greatly
appreciated.  When I get time next week I'll make these changes and send
out some patches.

thanks,

greg k-h

