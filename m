Return-Path: <linux-kernel+bounces-356669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9689964EF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C50A3B258E9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F4C18B465;
	Wed,  9 Oct 2024 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="vyI3IP+7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lR7txLMe"
Received: from flow-a5-smtp.messagingengine.com (flow-a5-smtp.messagingengine.com [103.168.172.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548C1817;
	Wed,  9 Oct 2024 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465564; cv=none; b=WzMWb9Di/+2kSw/F/fb6IpnifQrsqgnHe72c/oZO1FQ7keE48kpNOAF9P8Nm165aB1mHM2VH5pEk0yEsNIABR2mI63Bz9K8lkYhtf12YrxrdMPJY4DWTVo/LzE0fF7iK821zIdsisnAExCaxkTZuv2bQwdR8k2D0ieTbGFLKZiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465564; c=relaxed/simple;
	bh=U1HviyvjkC2nulCdjObng+ah5olLK4NONSqGo6bwmv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lT7ejccljD8xxE+bZn/tob6L4WKgu0QpHIRZ4Lfg9GUEQvBgZqXcW2+UOzaUXQwAQLfNr6WbSiRgtdqg1n0e8h+2Ab00JU2MKWGkNHc1APkN8jWSMlB7eY2loS4CFn8AxznLygMNvOJSwqq4WrbIYJqN16uugnNR3LFt0pzz8r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=vyI3IP+7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lR7txLMe; arc=none smtp.client-ip=103.168.172.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 7C11D200702;
	Wed,  9 Oct 2024 05:19:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 09 Oct 2024 05:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728465561; x=1728472761; bh=5QMHODHmih
	hrY81Jw53mmTTTo5EFLMunpfVMaJFgMyY=; b=vyI3IP+7ZGyQdEHPeRYRsH3SiQ
	V+DrOqUp1kFtcsUz9xiYhbi8mO4F779ovfgatGaJVHBEjMU3BSjzFl6FLZTE+F4G
	eojKJu1s1e/NfN83zV6IVZjUjgVs9X6M8/Y8EvGYREDRyL6BfGZxCBhGUVIcgsP+
	DL0rGbVgOVJqKJhh77XbBV33yveFb6rQLNzE+S70x5rNuMQUi8y0c5/o1UZSUyNK
	WtyNLUdjul6pvGfN2rMiUVPMsDENpn4F74nASXpfnFtlZcRncQXocIDXicaLC36e
	AZaGfNvkyE0auqGO5jByeQJ1OTwItDZz50RrIFHeImT710QGA1GbuxhxRKbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728465561; x=1728472761; bh=5QMHODHmihhrY81Jw53mmTTTo5EF
	LMunpfVMaJFgMyY=; b=lR7txLMen/WMFfKgncNvjRg6iQ+jp1xpVsWdDrz+wedu
	RhL/LLOZBCulCSYF2cTwyJ6yIc36ltwwMa6R3JD9JDjVsRLJfDN4/oEJbKuRntOb
	Hy2b/6s70/EKI66zYph5yxgTVRQJtNKPo9PFNCdpIdeR3gUytt2etW8wB07N4XBR
	8fGj4gUqyuuuGseFxz2YIXpx6VZrJiQDhyZOYTuksWtm656+1WQNX1ueCmhLL6H0
	+grW+h++7x4v0ChKXqYNFdevSUkBHlRESGGBZswRgklQ1EEFrLic4BZ5jzDn/398
	2RiX7gHd8FSMbt9+W+yJS5loEn7ArjtvFlBa32iUog==
X-ME-Sender: <xms:mUoGZ3NSWGOtBLGvTdE3Tb_KmoVtlMOHR6XJOiNN2CnA2RONdwwTFw>
    <xme:mUoGZx-JqKoQ95zEsJSpezdZ2p-vJnGIgXSuGKb3D-fiH-6Pz4G-khQE3WmHb9mwK
    _MvAOrnnpoA9Q>
X-ME-Received: <xmr:mUoGZ2SU6FZMskM6KKJx7T3m8pgTtNAKq2ikuPlOarS6fJmUvWpyNTT2S5Rs1ESosQcIUEX-zD6eDqGNK8HmRi_n0pFH440H7iXfPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepgeehueehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeel
    vedttddvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdp
    nhgspghrtghpthhtohepvdekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    homhgvthhtihesvghnnhgvvghnnhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqugho
    tgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhu
    gidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrd
    hnvghtpdhrtghpthhtoheptghhrhhishhtohhphhgvrhdrshdrhhgrlhhlsehinhhtvghl
    rdgtohhmpdhrtghpthhtohepshhusghrrghmrghnihgrnhdrmhhohhgrnhesihhnthgvlh
    drtghomhdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphht
    thhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtoh
    hm
X-ME-Proxy: <xmx:mUoGZ7tybL9XUSkH1Eff83xl7yY65ztzIbjZANG2d8IBcuUjlVFwlw>
    <xmx:mUoGZ_ef6BoG4WB7urStM3Bll4hUfN1GVt_EOPYYMVsFEKj9gxYZkg>
    <xmx:mUoGZ32iXp9PDO_DL-cF9j2Upm5s4O6MlH_4fXMQOuE9y661_m1szw>
    <xmx:mUoGZ78OIYWu3_B36Osyiv7rhMdWje5kotEbxoPraSheAZYMIuPU5Q>
    <xmx:mUoGZynyGuIzYpVzLxoyjCH56BLW-VuBhBVl5BsQewIy76eacYgqtMf0>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 05:19:20 -0400 (EDT)
Date: Wed, 9 Oct 2024 11:19:18 +0200
From: Greg KH <greg@kroah.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net,
	Hall Christopher S <christopher.s.hall@intel.com>,
	Mohan Subramanian <subramanian.mohan@intel.com>, tglx@linutronix.de,
	andriy.shevchenko@linux.intel.com,
	Dong Eddie <eddie.dong@intel.com>, N Pandith <pandith.n@intel.com>,
	T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
	Zage David <david.zage@intel.com>,
	Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>
Subject: Re: [RFC 1/3] drivers pps: add PPS generators support
Message-ID: <2024100917-daybed-suffering-7367@gregkh>
References: <20241008135033.3171915-1-giometti@enneenne.com>
 <20241008135033.3171915-2-giometti@enneenne.com>
 <2024100855-unsecured-mammogram-001a@gregkh>
 <541eb5c6-5546-4170-9e8b-d421d55822a1@enneenne.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <541eb5c6-5546-4170-9e8b-d421d55822a1@enneenne.com>

On Wed, Oct 09, 2024 at 10:48:14AM +0200, Rodolfo Giometti wrote:
> > > +	kobject_put(&pps_gen->dev->kobj);
> > 
> > Messing with a kobject reference directly from a device feels wrong and
> > should never be done.
> 
> I followed the suggestions in this patch whose look sane to me:
> 
> https://lore.kernel.org/lkml/fc5fe55c-422d-4e63-a5bd-8b6b2d3e6c62@enneenne.com/T/

That patch is wrong.

> >  Please use the proper apis.
> 
> Which API are you talking about? Can you please provide some advice?

get_device()

You are working on devices, NOT a raw kobject, no driver should EVER be
calling into a kobject function or a sysfs function, there should be
driver core functions for everything you need to do.

> 
> > 
> > 
> > > +	return 0;
> > > +}
> > > +
> > > +/*
> > > + * Char device stuff
> > > + */
> > > +
> > > +static const struct file_operations pps_gen_cdev_fops = {
> > > +	.owner		= THIS_MODULE,
> > > +	.compat_ioctl	= pps_gen_cdev_compat_ioctl,
> > 
> > Why compat for a new ioctl?  Why not write it properly to not need it?
> 
> Fixed.
> 
> > 
> > > +	.unlocked_ioctl	= pps_gen_cdev_ioctl,
> > > +	.open		= pps_gen_cdev_open,
> > > +	.release	= pps_gen_cdev_release,
> > > +};
> > > +
> > > +static void pps_gen_device_destruct(struct device *dev)
> > > +{
> > > +	struct pps_gen_device *pps_gen = dev_get_drvdata(dev);
> > > +
> > > +	pr_debug("deallocating pps-gen%d\n", pps_gen->id);
> > 
> > ftrace is your friend.
> 
> I see, but we can also use pr_debug()! :P
> 
> > 
> > > +	kfree(dev);
> > > +	kfree(pps_gen);
> > > +}
> > > +
> > > +static int pps_gen_register_cdev(struct pps_gen_device *pps_gen)
> > > +{
> > > +	int err;
> > > +	dev_t devt;
> > > +
> > > +	mutex_lock(&pps_gen_idr_lock);
> > > +
> > > +	err = idr_alloc(&pps_gen_idr, pps_gen, 0, PPS_GEN_MAX_SOURCES,
> > > +					GFP_KERNEL);
> > > +	if (err < 0) {
> > > +		if (err == -ENOSPC) {
> > > +			pr_err("%s: too many PPS sources in the system\n",
> > > +			       pps_gen->info.name);
> > > +			err = -EBUSY;
> > > +		}
> > > +		goto out_unlock;
> > > +	}
> > > +	pps_gen->id = err;
> > > +
> > > +	devt = MKDEV(pps_gen_major, pps_gen->id);
> > > +	pps_gen->dev = device_create(pps_gen_class, pps_gen->info.parent, devt,
> > > +					pps_gen, "pps-gen%d", pps_gen->id);
> > > +	if (IS_ERR(pps_gen->dev)) {
> > > +		err = PTR_ERR(pps_gen->dev);
> > > +		goto free_idr;
> > > +	}
> > > +
> > > +	/* Override the release function with our own */
> > > +	pps_gen->dev->release = pps_gen_device_destruct;
> > > +
> > > +	pr_debug("generator %s got cdev (%d:%d)\n",
> > > +			pps_gen->info.name, pps_gen_major, pps_gen->id);
> > 
> > Why not dev_dbg()?
> 
> Honestly I prefer pr_debug() because this message is not device related, but
> it is geneated by the PPS subsystem.

But you have a device, please use it!  Otherwise it's impossible to
track back what is going on to what device in the system.

> > > +static ssize_t name_show(struct device *dev, struct device_attribute *attr,
> > > +                         char *buf)
> > > +{
> > > +        struct pps_gen_device *pps_gen = dev_get_drvdata(dev);
> > > +
> > > +        return sysfs_emit(buf, "%s\n", pps_gen->info.name);
> > 
> > Why have a separate name?
> 
> This can be useful in order to distinguish between different PPS generators
> in the system.

Again, rely on the backing device structure for this (i.e. the symlink
in sysfs), you do not need to duplicate existing infrastructure.

> > That shouldn't matter at all.  If it does
> > matter, than link to the device that created it properly, don't make up
> > yet another name for your device.
> 
> I'm not sure to understand what you mean... The "name" attribute is just a
> label which the userspace my (or my not) use to know which generator to
> enable or not.

Again, it's tied to the device in the system, don't list that same thing
again.

> 
> > > +}
> > > +static DEVICE_ATTR_RO(name);
> > > +
> > > +static struct attribute *pps_gen_attrs[] = {
> > > +        &dev_attr_enable.attr,
> > > +        &dev_attr_name.attr,
> > > +        &dev_attr_time.attr,
> > > +        &dev_attr_system.attr,
> > > +        NULL,
> > > +};
> > > +
> > > +static const struct attribute_group pps_gen_group = {
> > > +        .attrs = pps_gen_attrs,
> > > +};
> > > +
> > > +const struct attribute_group *pps_gen_groups[] = {
> > > +        &pps_gen_group,
> > > +        NULL,
> > > +};
> > > diff --git a/include/linux/pps_gen_kernel.h b/include/linux/pps_gen_kernel.h
> > > new file mode 100644
> > > index 000000000000..5513415b53ec
> > > --- /dev/null
> > > +++ b/include/linux/pps_gen_kernel.h
> > > @@ -0,0 +1,57 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > +/*
> > > + * PPS generator API kernel header
> > > + *
> > > + * Copyright (C) 2024   Rodolfo Giometti <giometti@enneenne.com>
> > > + */
> > > +
> > > +#ifndef LINUX_PPS_GEN_KERNEL_H
> > > +#define LINUX_PPS_GEN_KERNEL_H
> > > +
> > > +#include <linux/pps_gen.h>
> > > +#include <linux/cdev.h>
> > > +#include <linux/device.h>
> > > +
> > > +/*
> > > + * Global defines
> > > + */
> > > +
> > > +struct pps_gen_device;
> > > +
> > > +/* The specific PPS source info */
> > > +struct pps_gen_source_info {
> > > +	char name[PPS_GEN_MAX_NAME_LEN];	/* symbolic name */
> > > +	bool use_system_clock;
> > > +
> > > +	int (*get_time)(struct pps_gen_device *pps_gen,
> > > +					struct timespec64 *time);
> > > +	int (*enable)(struct pps_gen_device *pps_gen, bool enable);
> > > +
> > > +	struct module *owner;
> > > +	struct device *parent;			/* for device_create */
> > > +};
> > > +
> > > +/* The main struct */
> > > +struct pps_gen_device {
> > > +	struct pps_gen_source_info info;	/* PSS generator info */
> > > +	bool enabled;				/* PSS generator status */
> > > +
> > > +	unsigned int id;			/* PPS generator unique ID */
> > > +	struct device *dev;
> > 
> > Why not be a real device? What is this a pointer to?
> 
> This is a pointer to the device created within the pps_gen_register_cdev().

Why isn't it a real cdev instead?

thanks,

greg k-h

