Return-Path: <linux-kernel+bounces-405989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DBD9C59AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1F2284D0D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0405C1FBF7D;
	Tue, 12 Nov 2024 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ah81A8my"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FEE1FBF51
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419738; cv=none; b=PHfeUF+rAn41odAyE7q5TxV1TC3+SntQaVTWeeJEhKey5aSvcDsA0qdNLfVkuS4bAOaLUE8j0dEyJ6MAWYM418/7rAQ365W20MUpP2iEQ06orV3bbvPFbTLCkLWNSzV0NareJ9kiwbnuDQbxsQFsSLFK0Pz5jR7px9uP5xCriCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419738; c=relaxed/simple;
	bh=wVhWepG5ipKBph4MdKxl7IN3Iu15gPli/CQF7GkV1ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsg6BKD/h/U1I0ZWBdfFRGkuoTSBg3cmlheDOOLMymFi3FBIU/W7AZm4oDIZLYP7shLFi6qFpPZbRo6VvafcaEujFwEv0j1HpzwHCjwua2ErFr69E7a6rIHcKq2VgRz30V3AenxBWdML1qd90yIcSsh2RwS0EvFF6Dxee7FkZio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ah81A8my; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B18BC4CECD;
	Tue, 12 Nov 2024 13:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731419737;
	bh=wVhWepG5ipKBph4MdKxl7IN3Iu15gPli/CQF7GkV1ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ah81A8my9r1ybO6l447XUt9Nxob6kD6xCpF6+nIydADyOimPljoPbmC2GM15jTBbE
	 AzbWHVKJA/AdahcslpFpnLiMUJhSpewRRDaI9dBvfJ33TMEEO0fOw5zV1qZ2PqCXNB
	 y2XurDJdgQQkIqa3FuFk2/5iBut+1lfpr8ndhICM=
Date: Tue, 12 Nov 2024 14:55:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] drivers: core: clear wake irq in device_unbind_cleanup
Message-ID: <2024111213-eradicate-puma-3592@gregkh>
References: <20241111092131.1693319-1-peng.fan@oss.nxp.com>
 <2024111207-baggie-eskimo-d2b0@gregkh>
 <PAXPR04MB8459A924A74FE917897F9F5288592@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459A924A74FE917897F9F5288592@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Tue, Nov 12, 2024 at 01:09:19PM +0000, Peng Fan wrote:
> Hi Greg
> 
> > Subject: Re: [PATCH] drivers: core: clear wake irq in
> > device_unbind_cleanup
> > 
> > On Mon, Nov 11, 2024 at 05:21:30PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > With dev_pm_clear_wake_irq in device_unbind_cleanup, there is no
> > need
> > > to invoke dev_pm_clear_wake_irq in driver remove hook explicitly.
> > >
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/base/dd.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c index
> > > f0e4b4aba885..ea3a871bdd11 100644
> > > --- a/drivers/base/dd.c
> > > +++ b/drivers/base/dd.c
> > > @@ -26,6 +26,7 @@
> > >  #include <linux/wait.h>
> > >  #include <linux/async.h>
> > >  #include <linux/pm_runtime.h>
> > > +#include <linux/pm_wakeirq.h>
> > >  #include <linux/pinctrl/devinfo.h>
> > >  #include <linux/slab.h>
> > >
> > > @@ -556,6 +557,7 @@ static void device_unbind_cleanup(struct
> > device *dev)
> > >  		dev->pm_domain->dismiss(dev);
> > >  	pm_runtime_reinit(dev);
> > >  	dev_pm_set_driver_flags(dev, 0);
> > > +	dev_pm_clear_wake_irq(dev);
> > 
> > I don't understand, you say you don't need to invoke it, yet you are
> > calling it here.
> 
> I mean not need to invoke it in driver.remove hook. With this patch, we
> could remove
> https://elixir.bootlin.com/linux/v6.11.7/source/drivers/input/touchscreen/ti_am335x_tsc.c#L498
> and same to other drivers.

But you did not say that, and you would need to make this as part of a
series.

Also, are you sure that ll drivers want to clear this irq flag?  What is
wrong with just doing it explicitly in the drivers that need it?

> > 
> > What commit id does this fix? 
> 
> I am thinking to take this as a improvement, with core code
> has this, the various drivers no need explicitly invoke it
> in their own driver remove hook.
> 
>  And what bug is this resolving?  What
> > drivers are broken without this?
> 
> See here:
> https://lore.kernel.org/all/ZymxvLMkkktRoCXZ@google.com/

Again, this seems to be a per-driver thing.  What do you break if you
attempt to do this for all drivers?  What about drivers that share irqs?

How was this tested?  On what platfoms?

thanks,

greg k-h

