Return-Path: <linux-kernel+bounces-437936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699EA9E9AB6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B25286106
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329ED1C5CCB;
	Mon,  9 Dec 2024 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AVyPCnIW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42FA1B423A;
	Mon,  9 Dec 2024 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758819; cv=none; b=WWpVy1PUO5jLg2mMAA2SWRDTy5df4JBjs5rKylA1NYKwA7lyaPrPko7NQZ4yyFceA+pHHR0pO0NxgbJjdHXvGhaFYgTDLAA+B1xTHsBn+1lpicCOYyBUutZ+Zsf0dJp7iXVJI7o7AvSJT+OiSbeDlOKZNyZanNFQRwxnmtdqDhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758819; c=relaxed/simple;
	bh=8jMH4whOeClBjX7QkdPZmkXcWvRAUKZUkmqneFHY5Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqnzaA5JGlzBJJNGTNuETuZrTJz8yi035AbXOHaNvUKBIfoB6z6hrw/xqMIS+FRLM4DJtm/lB3Vt1mvLr+cu6HUeJH9IlH//r2T9RBWxYCW19imPhWh5NBZ2GwsMv+Iio6rAtqHKNiBTaXOtWw7vYqDqRX23KI+1B4Q1Wqzy6jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AVyPCnIW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733758818; x=1765294818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8jMH4whOeClBjX7QkdPZmkXcWvRAUKZUkmqneFHY5Gk=;
  b=AVyPCnIW4bZ5YUZhmadh2YIbawruEwAvtc+z5+xdXYs3QvrPz23nv/BF
   Bnk4JkCz0CpZERtaZggzZ+AdPlwM/EOOO9osX2lRteyWpR6gisEbsfeiu
   LnHE/rb6MA1tLjLkwor/pbgz6MzhSsHg6LzVmEuzBFiQ7Pc4fJME3jL6L
   WzRRbtqv49+ZDg4U30FBBFnSPIgs/kIaiVCeHIpr4+3w15OPb5gTyMxZ7
   ggI59zfv1aqQHwwY15yqAW4V+2gNxqw2350gylWRJBcXrANibzCLYV1Hm
   viuprFt6iW6b2hVbNdZTwZk1bfqFxhco0mFAImlRjGMYWicehifgj5hG5
   A==;
X-CSE-ConnectionGUID: GfTgrF3wR/O2QeFJlTDGyg==
X-CSE-MsgGUID: km/Lh9nRT0G3OwvM9ITu9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="45078463"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="45078463"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 07:40:18 -0800
X-CSE-ConnectionGUID: D7okewWJR7yMjNhkahWHmg==
X-CSE-MsgGUID: E9A/Vu6eSyCNah0HZ230Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="94921785"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 09 Dec 2024 07:40:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 15C1E44B; Mon, 09 Dec 2024 17:40:13 +0200 (EET)
Date: Mon, 9 Dec 2024 17:40:13 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH] thunderbolt: Don't display retimers unless nvm was
 initialized
Message-ID: <20241209154013.GK4955@black.fi.intel.com>
References: <20241206183318.1701180-1-superm1@kernel.org>
 <20241209062415.GG4955@black.fi.intel.com>
 <c40bed54-63e9-4535-b17b-fba980f19382@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c40bed54-63e9-4535-b17b-fba980f19382@kernel.org>

On Mon, Dec 09, 2024 at 08:15:16AM -0600, Mario Limonciello wrote:
> On 12/9/2024 00:24, Mika Westerberg wrote:
> > Hi Mario,
> > 
> > On Fri, Dec 06, 2024 at 12:33:18PM -0600, Mario Limonciello wrote:
> > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > 
> > > The read will never succeed if nvm wasn't initialized.
> > 
> > Okay but we would need to understand why it was not initialized in the
> > first place?
> 
> Oh sorry I should have included that/
> 
> https://gist.github.com/superm1/c3763840fefa54298258a6fbec399007
> 
> As you can see it's an unknown retimer NVM format.  So this ends up down the
> path of "NVM upgrade disabled".  So that's why I'm thinking the visibility
> is the right move to adjust here (IE this patch).

This is actually on-board retimer of the AMD platform:

Dec 09 07:29:11 fedora kernel: thunderbolt 0-0:2.1: retimer NVM format of vendor 0x7fea unknown
Dec 09 07:29:11 fedora kernel: thunderbolt 0-0:2.1: NVM upgrade disabled
Dec 09 07:29:11 fedora kernel: thunderbolt 0-0:2.1: new retimer found, vendor=0x7fea device=0x1032

I would think you guys want to make it upgradeable as well, no?

> > I see this is ThinkPad Thunderbolt 4 Dock so probably Intel hardware? You
> > say you can reproduce this too so can you send me full dmesg with
> > thunderbolt dynamic debugging enabled? I would like to understand this bit
> > more deeper before we add any workarounds.
> > 
> > > Reported-by: Richard Hughes <hughsient@gmail.com>
> > > Closes: https://github.com/fwupd/fwupd/issues/8200
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   drivers/thunderbolt/retimer.c | 17 ++++++++++++++---
> > >   1 file changed, 14 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/thunderbolt/retimer.c b/drivers/thunderbolt/retimer.c
> > > index 89d2919d0193e..7be435aee7217 100644
> > > --- a/drivers/thunderbolt/retimer.c
> > > +++ b/drivers/thunderbolt/retimer.c
> > > @@ -321,9 +321,7 @@ static ssize_t nvm_version_show(struct device *dev,
> > >   	if (!mutex_trylock(&rt->tb->lock))
> > >   		return restart_syscall();
> > > -	if (!rt->nvm)
> > > -		ret = -EAGAIN;

This is actually here because it might take some time for the NVM to be
available after the upgrade so changing this may cause issues on its own.

Instead we should check first the

	rt->no_nvm_upgrade

and return -EOPNOTSUPP which I believe fwupd handles?

> > > -	else if (rt->no_nvm_upgrade)
> > > +	if (rt->no_nvm_upgrade)
> > >   		ret = -EOPNOTSUPP;
> > >   	else
> > >   		ret = sysfs_emit(buf, "%x.%x\n", rt->nvm->major, rt->nvm->minor);
> > > @@ -342,6 +340,18 @@ static ssize_t vendor_show(struct device *dev, struct device_attribute *attr,
> > >   }
> > >   static DEVICE_ATTR_RO(vendor);
> > > +static umode_t retimer_is_visible(struct kobject *kobj,
> > > +				      struct attribute *attr, int n)
> > > +{
> > > +	struct device *dev = kobj_to_dev(kobj);
> > > +	struct tb_retimer *rt = tb_to_retimer(dev);
> > > +
> > > +	if (!rt->nvm)
> > > +		return 0;
> > > +	return attr->mode;
> > > +
> > > +}
> 
> I just noticed I had a spurious newline here.  If we end up taking this
> patch would you mind just fixing it up?  If there is other feedback I'll fix
> it on a v2.
> 
> > > +
> > >   static struct attribute *retimer_attrs[] = {
> > >   	&dev_attr_device.attr,
> > >   	&dev_attr_nvm_authenticate.attr,
> > > @@ -351,6 +361,7 @@ static struct attribute *retimer_attrs[] = {
> > >   };
> > >   static const struct attribute_group retimer_group = {
> > > +	.is_visible = retimer_is_visible,
> > >   	.attrs = retimer_attrs,
> > >   };
> > > -- 
> > > 2.43.0

