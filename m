Return-Path: <linux-kernel+bounces-338287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0673D9855EB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3689F1C2379C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6EC15B119;
	Wed, 25 Sep 2024 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0T+3eflf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0621598E9
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254557; cv=none; b=OV/qBcAGhKUpc5pPjyiqBOh6pFX8lJBfMo7T5ARyQZCHiu6155jqKvw96rzIDFuAz3jY97k9j3o66MR+O1O5E71ZAsvbWFxQJn7aMOPJKkBcVLaN1MPGQ6BkT3/Qc6G3Z/QUkixnNqD4qfOz1xX4xAaUr+TwN+PPEQCudDxhQsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254557; c=relaxed/simple;
	bh=7+7S9zD6lpVoFKZ0pyXfyfREtCkMjdiiF5aeStNWakA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqnaRgOra/UkQ1myPfg2FRbQ+QTTc6UKEzNRgaZIiL2v8WiBUNUW9DO0xKp/xtWz5Rfo8ye2spwDCWFjWcbTVB3QB5+V4yblnhfrfB0CufP4+BmlyeMyEESf9rTCj71NcAT+rWQYkHq9hK6zB9Hfns527Km22kWs3LkfFtJSvGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0T+3eflf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C5DC4CEC3;
	Wed, 25 Sep 2024 08:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727254557;
	bh=7+7S9zD6lpVoFKZ0pyXfyfREtCkMjdiiF5aeStNWakA=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=0T+3eflfCzR4ZTQPkFV0k7Qkmj3GH/Dpo2lZSoG+A4idYqHbKp0ocd2bkujdTOVMa
	 obQAPJrDaNI85A7qllYS7f+wEqt5YSI2+UB2OhqzGrucuyTJ0u/a1QC2hr7D/Wlopw
	 YIQQhYRXFJuxgrM/UtP5V5lleR74Cw3JtwnAm4Zo=
Date: Wed, 25 Sep 2024 10:55:54 +0200
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
Message-ID: <2024092509-unaired-runaround-dc9d@gregkh>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
 <ZvHUn1Q2R8FumZ20@skv.local>
 <2024092440-embattled-magical-64bc@gregkh>
 <ZvMkkhyJrohaajuk@skv.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvMkkhyJrohaajuk@skv.local>

On Tue, Sep 24, 2024 at 11:44:02PM +0300, Andrey Skvortsov wrote:
> Hi,
> 
> On 24-09-24 11:23, Greg Kroah-Hartman wrote:
> > On Mon, Sep 23, 2024 at 11:50:39PM +0300, Andrey Skvortsov wrote:
> > > Hi Stuart,
> > > 
> > > On 24-08-22 15:28, Stuart Hayes wrote:
> > > > Add code to allow asynchronous shutdown of devices, ensuring that each
> > > > device is shut down before its parents & suppliers.
> > > > 
> > > > Only devices with drivers that have async_shutdown_enable enabled will be
> > > > shut down asynchronously.
> > > > 
> > > > This can dramatically reduce system shutdown/reboot time on systems that
> > > > have multiple devices that take many seconds to shut down (like certain
> > > > NVMe drives). On one system tested, the shutdown time went from 11 minutes
> > > > without this patch to 55 seconds with the patch.
> > > > 
> > > > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > > > Signed-off-by: David Jeffery <djeffery@redhat.com>
> > > > ---
> > > >  drivers/base/base.h           |  4 +++
> > > >  drivers/base/core.c           | 54 ++++++++++++++++++++++++++++++++++-
> > > >  include/linux/device/driver.h |  2 ++
> > > >  3 files changed, 59 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > > > index 0b53593372d7..aa5a2bd3f2b8 100644
> > > > --- a/drivers/base/base.h
> > > > +++ b/drivers/base/base.h
> > > > @@ -10,6 +10,7 @@
> > > >   * shared outside of the drivers/base/ directory.
> > > 
> > > This change landed in linux-next and I have problem with shutdown on
> > > ARM Allwinner A64 device. Device usually hangs at shutdown.
> > > git bisect pointed to "driver core: shut down devices asynchronously"
> > > as a first bad commit.
> > > 
> > > I've tried to debug the problem and this is what I see:
> > > 
> > > 1) device 'mmc_host mmc0' processed in device_shutdown. For this device
> > > async_schedule_domain is called (cookie 264, for example).
> > > 
> > > 2) after that 'mmcblk mmc0:aaaa' is processed. For this device
> > > async_schedule_domain is called (cookie 296, for example).
> > > 
> > > 3) 'mmc_host mmc0' is parent of 'mmcblk mmc0:aaaa' and
> > > parent->p->shutdown_after is updated from 263 to 296.
> > > 
> > > 4) After sometime shutdown_one_device_async is called for 264
> > > (mmc_host mmc0), but dev->p->shutdown_after was updated to 296 and the
> > > code calls first async_synchronize_cookie_domain for 297.
> > > 
> > > 264 can't finish, because it waits for 297. shutdown process can't continue.
> > > 
> > > The problem is always with a MMC host controller.
> > 
> > If you take the patch here:
> > 	https://lore.kernel.org/r/20240919043143.1194950-1-stuart.w.hayes@gmail.com
> > does it solve the problem?
> 
> Unfortunately not. I've applied the patch to next-20240920 and tested
> latest next-20240924 with patch integrated already. In both cases
> shutdown hangs.

Ugh.  Ok, this is making me very nervous so I'm going to go and revert
this series from my tree and let's take it again after -rc1 is out and
people can work through the issues there.

thanks,

greg k-h

