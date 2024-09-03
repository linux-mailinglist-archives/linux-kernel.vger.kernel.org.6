Return-Path: <linux-kernel+bounces-312776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4227969B18
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30A60B223A0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD8F1A0BDF;
	Tue,  3 Sep 2024 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yv3H80d3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494551B12C5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725361499; cv=none; b=sNyMz3sFd2xHQ16FvMuhEkARRGs6ng8gznZ/M8M3dNHhHtApfDehH7lp7ko6sXdv7p78osR016XikTn83mQBny779D6mfmX6yu7BTD3hbqwc1dkvxF28xueZX+EqYBBob8RrHYtAO0+JQv3uNtiqDZWg6C2oynNhjXoFxmab49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725361499; c=relaxed/simple;
	bh=O2VlGnt94ZRiK5ft5N3rEZWT68Bt6V4Rwe4zVUHZ5Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ncSPwnA9mxErHQKzGyxU5BbIyQMCWudeb8yPgISbMG75/d2dGdZlO8HqFI3tSj4iytwb4Q05HZjxU8Fqcz36ArhNj/2cCLlC1bRswcXTjVx6DIwSarB+CELPoGff2EWz5t5NUCQROAyIeGfA2tmHpTLYI3O+wtwALAg66ztZF0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yv3H80d3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FA1C4CEC4;
	Tue,  3 Sep 2024 11:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725361498;
	bh=O2VlGnt94ZRiK5ft5N3rEZWT68Bt6V4Rwe4zVUHZ5Z8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yv3H80d30VGzCPCq0enk6A2qy1f26XV5g7wXq9Jp56IsQCBGJ2kXjeazoy+2PySJp
	 kXEhyqAZ4dys5+6ZlF/MkyJSQI9fghXZfl7zaoIrjXzOjxHm4ZsaWqN6ey0F1py/KI
	 HbKPdZ8vRaeViurfapPfhHdov5EkADUOBJi8l0OE=
Date: Tue, 3 Sep 2024 13:04:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Angus Chen <angus.chen@jaguarmicro.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: core: Add more print info for bus remove and
 driver remove
Message-ID: <2024090345-wrist-october-b304@gregkh>
References: <20240827125244.1747-1-angus.chen@jaguarmicro.com>
 <2024082705-decoy-disk-6461@gregkh>
 <TY0PR06MB49846789A7ED4370E825BB0F85952@TY0PR06MB4984.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY0PR06MB49846789A7ED4370E825BB0F85952@TY0PR06MB4984.apcprd06.prod.outlook.com>

On Wed, Aug 28, 2024 at 02:11:10AM +0000, Angus Chen wrote:
> Hi，gregkh.
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, August 27, 2024 9:19 PM
> > To: Angus Chen <angus.chen@jaguarmicro.com>
> > Cc: rafael@kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] drivers: core: Add more print info for bus remove and driver
> > remove
> > 
> > On Tue, Aug 27, 2024 at 08:52:44PM +0800, Angus Chen wrote:
> > > When enable initcall_debug,some devices call bus remove,
> > > Some devices call driver remove.
> > >
> > > Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
> > > ---
> > >  drivers/base/core.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index 8c0733d3aad8..ff965cd51bcf 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -4833,11 +4833,11 @@ void device_shutdown(void)
> > >  		}
> > >  		if (dev->bus && dev->bus->shutdown) {
> > >  			if (initcall_debug)
> > > -				dev_info(dev, "shutdown\n");
> > > +				dev_info(dev, "call bus shutdown\n");
> > >  			dev->bus->shutdown(dev);
> > >  		} else if (dev->driver && dev->driver->shutdown) {
> > >  			if (initcall_debug)
> > > -				dev_info(dev, "shutdown\n");
> > > +				dev_info(dev, "call driver shutdown\n");
> > 
> > I do not understand, why is this needed?  Who needs it and what is going
> > to rely on it?
> Thank you for your reply.
> While I'm troubleshooting the shutdown sequence of my own bus, I get the same print of the
> Different devices. Because some bus->shutdown call the drv->shutdown first, so I want to
> Make different print info to differentiate it.
> > 
> > Really, this should be moved to dev_dbg() instead, right?
> You are right, dev_dbg looks more better . should I take this patch together or just change it
> To dev_dbg?

Yes please.


