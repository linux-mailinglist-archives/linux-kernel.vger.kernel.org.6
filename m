Return-Path: <linux-kernel+bounces-336874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C3C9841F9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A017282B45
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D074A15574F;
	Tue, 24 Sep 2024 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d9WS/icW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A33014C581
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169840; cv=none; b=RVaxu4OkIYBMDcmZ3Hazx/BsfRQ65LmoVk83d2iKH9c+GIoBvZfhfo1dfSF4V6Ts+aqsm/vsYFsadHkhplenWkEuHfaYSeyjdnER+uSGVbKlztjjr9wGex/I/zqA05XodUo8NXjjyhYpyowh7adzTiqU0g+ra9TxTLZwgVop+o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169840; c=relaxed/simple;
	bh=zHnhnNw50/GZkwB5R09yISn41wHHH7beW/kuu6jT2gg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVSsFhDZBoSMC3IOfD8XxRMHKI+NK+zlRXQo5kr1ODH2OS/Qd8ellUokYgn9r8YIatutBIMpl11FEvSGBryBAl7esYgQIMRXUhr4ga+ew8KCpaD8MocLbkPmeP3t1DWZY3PvEn18z+Yax3voCa4sTach86/+w9W5pqJ42qYN0Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d9WS/icW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B77C4CEC4;
	Tue, 24 Sep 2024 09:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727169840;
	bh=zHnhnNw50/GZkwB5R09yISn41wHHH7beW/kuu6jT2gg=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=d9WS/icWwOQs7cnEcZQt1AM2tN3uzB/0WuXjHFdjBVh+2MnPshixayinVzkxgtNVb
	 5fWjCS2o4u7z46w9GJevwlJdzlvJVPU1S2WHrv83hqN6yWerL5uF4MEeHChlRimpkm
	 CfePTGPnjY9mrBg2CTKUJ1lyFYrUAOOGGIoJdmlU=
Date: Tue, 24 Sep 2024 11:23:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
Message-ID: <2024092440-embattled-magical-64bc@gregkh>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
 <ZvHUn1Q2R8FumZ20@skv.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvHUn1Q2R8FumZ20@skv.local>

On Mon, Sep 23, 2024 at 11:50:39PM +0300, Andrey Skvortsov wrote:
> Hi Stuart,
> 
> On 24-08-22 15:28, Stuart Hayes wrote:
> > Add code to allow asynchronous shutdown of devices, ensuring that each
> > device is shut down before its parents & suppliers.
> > 
> > Only devices with drivers that have async_shutdown_enable enabled will be
> > shut down asynchronously.
> > 
> > This can dramatically reduce system shutdown/reboot time on systems that
> > have multiple devices that take many seconds to shut down (like certain
> > NVMe drives). On one system tested, the shutdown time went from 11 minutes
> > without this patch to 55 seconds with the patch.
> > 
> > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > ---
> >  drivers/base/base.h           |  4 +++
> >  drivers/base/core.c           | 54 ++++++++++++++++++++++++++++++++++-
> >  include/linux/device/driver.h |  2 ++
> >  3 files changed, 59 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > index 0b53593372d7..aa5a2bd3f2b8 100644
> > --- a/drivers/base/base.h
> > +++ b/drivers/base/base.h
> > @@ -10,6 +10,7 @@
> >   * shared outside of the drivers/base/ directory.
> 
> This change landed in linux-next and I have problem with shutdown on
> ARM Allwinner A64 device. Device usually hangs at shutdown.
> git bisect pointed to "driver core: shut down devices asynchronously"
> as a first bad commit.
> 
> I've tried to debug the problem and this is what I see:
> 
> 1) device 'mmc_host mmc0' processed in device_shutdown. For this device
> async_schedule_domain is called (cookie 264, for example).
> 
> 2) after that 'mmcblk mmc0:aaaa' is processed. For this device
> async_schedule_domain is called (cookie 296, for example).
> 
> 3) 'mmc_host mmc0' is parent of 'mmcblk mmc0:aaaa' and
> parent->p->shutdown_after is updated from 263 to 296.
> 
> 4) After sometime shutdown_one_device_async is called for 264
> (mmc_host mmc0), but dev->p->shutdown_after was updated to 296 and the
> code calls first async_synchronize_cookie_domain for 297.
> 
> 264 can't finish, because it waits for 297. shutdown process can't continue.
> 
> The problem is always with a MMC host controller.

If you take the patch here:
	https://lore.kernel.org/r/20240919043143.1194950-1-stuart.w.hayes@gmail.com
does it solve the problem?

thanks,

greg k-h

