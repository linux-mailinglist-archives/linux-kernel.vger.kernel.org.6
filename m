Return-Path: <linux-kernel+bounces-206644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B6F900C41
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 21:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619651C21D34
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BC314386F;
	Fri,  7 Jun 2024 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fLztfg+p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31A361FF6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787270; cv=none; b=buG98K9X7+u5c5Nxhw7aQi4gVmE0pDJt+sbtCIGRTka/9jFbA9bRhDQfaNbX73+2FtsKOrQsAmrfJui+vgRHCisNrp/jhruk095bcKdxlARUGB2H52EjzKzGINBnjd4gLmTjq6dAk/rS3B7of8mzeqS6YOWG1e4AOHtAMGe7qvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787270; c=relaxed/simple;
	bh=x7XM9AKxegOved0kWZyZbA/FkAuSLgNHE5FU05haFTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0s6oI7m9wMwlpyNe7fuK5KywkbiTO5Db3OaxWbAC9AAUv5y0Kk385TTbba0HME1GW1n/2G/lW+MQ8HT9TGailQ+n4+3EnKietvlqlDdu6uoAb8IitYFZ6xbLSWLR5xpLXgqz6ZOISlzZZW8hF5OmBLPgXIOZ8De1Zb8GlaPL7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fLztfg+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE22C4AF08;
	Fri,  7 Jun 2024 19:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717787270;
	bh=x7XM9AKxegOved0kWZyZbA/FkAuSLgNHE5FU05haFTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLztfg+pfnTV4FQDKbrj+QZ0c2Nf9Vybu4mTptGNEImIu6jC1/7kM3/m28U1W8GAM
	 0DV+imoLqYO5hIej3tgqDhtjqZAbhgqpq/Q+HWs3kGiuPZEtTLN4JMCVug/UCnQ7Go
	 hsusHCyvUSRSrkji0ZsoFJZ22mRDyV4xwLMtWRJ4=
Date: Fri, 7 Jun 2024 21:07:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
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
Subject: Re: [GIT PULL] platform: Make platform_driver::remove() return void
Message-ID: <2024060739-snide-overstep-87f2@gregkh>
References: <20240527083416.1177106-2-u.kleine-koenig@pengutronix.de>
 <2024060432-relieving-yonder-85ae@gregkh>
 <acwqbvhf3h5z4shzwdwwwfkvxvmchlpbh5k6kwcubhpe3ncvdf@v5gai33oolhn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acwqbvhf3h5z4shzwdwwwfkvxvmchlpbh5k6kwcubhpe3ncvdf@v5gai33oolhn>

On Wed, Jun 05, 2024 at 12:33:11PM +0200, Uwe Kleine-König wrote:
> Hello Greg
> 
> On Tue, Jun 04, 2024 at 06:13:54PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, May 27, 2024 at 10:34:15AM +0200, Uwe Kleine-König wrote:
> > > there are only very little platform drivers left in v6.10-rc1 that need
> > > to be changed to .remove_new() before this patch can be applied. They
> > > were all sent out to the respective maintainers, most of them suggested
> > > to apply the patches together with this one.
> > > 
> > > You can fetch this patch together with all necessary commits from:
> > > 
> > > 	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git platform-remove-void
> > > 
> > > If you have no concerns, I can also provide you a signed tag for
> > > pulling. I think that's easier than indiviually applying them, but I can
> > > also send out the complete series if you prefer.
> > 
> > A signed tag is good, I can just pull from that, thanks!
> 
> here it comes:
> 
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:
> 
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/platform-remove-void-step-b

Pulled and pushed out, thanks!

greg k-h

