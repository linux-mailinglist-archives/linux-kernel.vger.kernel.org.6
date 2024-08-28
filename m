Return-Path: <linux-kernel+bounces-305198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 829E0962AE1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AD8528420F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45D61A0B07;
	Wed, 28 Aug 2024 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="asXgWhRm"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0A19AA75
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856864; cv=none; b=JJVL1nCPrFMgt8ST0D6X2s84c9JW6oOJDEDxg6x5HR8tVkwRNo93tgikA6HnDRdtUFkcG4CRketZMS4RPxcPiT5I5e6aNNkDUSzw8V0CPGfpOQQV6KuebBvYwYWkDph37Od52PAlRqKXVTqbUNNudpUl9yE7g+9/LKm4Q2GJx+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856864; c=relaxed/simple;
	bh=8hzPD33CbZBcgUSyyLMRU9NbMcPOpuPpikLc8tiVvzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJiNnYlrgsiL+suyGlHzJMWfpYzwBVdLpQVW2W33a9aq8O06MFDSLcuDB/SVWFogJzfYT32bBqv9Urrvkb4TO3f2hzit5SMP5sKTzZ8lRr1Y6XmHGk/38qotE8bpq1X/xp14CPXgT+zhjNhHyX8CAvDXnvwN6KozAZ8r/DykuB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=asXgWhRm; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bf6755323cso39368776d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1724856862; x=1725461662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6nhujPZHs27SEAYURkVKz04PPXoynmdVoaZNb24tNBs=;
        b=asXgWhRmbGIBKGmjQuKCL3mNteYxW7dGvol24DrsPWncuW34mmfUF9XJtl75ygA3Wg
         v+5VnReLQzOIYQmr7kMC5m9X837rJFcJnb8ehcXCEt4DwV2D78xNQ2vUKupZXDhQhS7g
         K7+cmCxvTBr2UKwBxMJ6UbGJdZAvUUeaXw6/73wqa2f8gCCXhNPuyo/YhbXll7Se9+Vz
         XwuoQ4fTB1bJq03I3UaEPaXStG0SznXOyGH8VviBIT8vFbHhRKKYNKTfM4UTFoeS6Rui
         n5QngeOE9AH4hF6KdxEmUw3q2/UtXEVYaAnsYmldEfUS0LA0cShSr0snLO3ZrMsTLaSD
         i8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724856862; x=1725461662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nhujPZHs27SEAYURkVKz04PPXoynmdVoaZNb24tNBs=;
        b=PYvVaASmjDC1dHZN6IqsE+o3t/C6RJZkO9Kqux6TIigRrwhS8ol3Thlhc+six0UVCX
         xDnvUxWxggLK0gLs1h5v3ksyYMZGptfxovK4foRyeLRCWSnrzEFnko7Ywt/fo6PYal+b
         UVRSCyklUMTYoIV9pWgRaXn4w6p0ljgYkpA81YSaohCcl4E2vMlGwebFwVjNHO2vnFJ6
         R/7XO0ip84oO1w8omUZ4GBFanPlw0U8ldG0xXX8Hr9yE+cFxgAouNpzJpkqudQLVAj9B
         VSSqu5TMwaKmN3fLGdk1l5PK+TSZW3yW+iHm9l5jX4O03lWmG/4YIBUeRB2wxOdzebWw
         0uLw==
X-Forwarded-Encrypted: i=1; AJvYcCVV/XMOXDS1zWzbJFm0XSlhlGjFAfCpd0ErtFy/nEt96RnycSrQikwi3d3cBYPX89/XCmq0svFFVN/GSos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS/3sVbUe6/76PGwvtno16Yz3Wd6RTLiOHcvhevOo8MKlmloIB
	BQCWVhryhbCqZBw2+GwadG/A+xK7kAbmVx5+3xcTOtT5B2GVKsctxKwiMP9LAw==
X-Google-Smtp-Source: AGHT+IG7YLFsUh+1XQ6LBSM1kv2m/SlRXCAKyBwLLTF7t7Vy4VG2teF/Z8KUcHJAFgEVRXsEq9GITA==
X-Received: by 2002:a05:6214:2f90:b0:6c1:6b00:6e90 with SMTP id 6a1803df08f44-6c3362be166mr25423966d6.7.1724856862018;
        Wed, 28 Aug 2024 07:54:22 -0700 (PDT)
Received: from rowland.harvard.edu (wrls-249-137-9.wrls-client.fas.harvard.edu. [140.247.12.9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dd1cfdsm66104336d6.129.2024.08.28.07.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:54:21 -0700 (PDT)
Date: Wed, 28 Aug 2024 10:54:18 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Selvarasu Ganesan <selvarasu.g@samsung.com>, royluo@google.com,
	paul@crapouillou.net, elder@kernel.org, yuanlinyu@hihonor.com,
	quic_kriskura@quicinc.com, crwulff@gmail.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, rc93.raju@samsung.com,
	taehyun.cho@samsung.com, hongpooh.kim@samsung.com,
	eomji.oh@samsung.com, shijie.cai@samsung.com,
	stable <stable@kernel.org>
Subject: Re: [PATCH] usb: gadget: udc: Add null pointer check for udc in
 gadget_match_driver
Message-ID: <4c64791e-a2f0-4878-8025-4ced94da6bc3@rowland.harvard.edu>
References: <CGME20240828070538epcas5p2ce9b001afd4588139070d01f0fb2ac37@epcas5p2.samsung.com>
 <20240828070507.2047-1-selvarasu.g@samsung.com>
 <2024082801-dissuade-starlight-e5ad@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024082801-dissuade-starlight-e5ad@gregkh>

On Wed, Aug 28, 2024 at 11:39:58AM +0200, Greg KH wrote:
> On Wed, Aug 28, 2024 at 12:35:04PM +0530, Selvarasu Ganesan wrote:
> > This commit adds a null pointer check for udc in gadget_match_driver to
> > prevent the below potential dangling pointer access. The issue arises
> > due to continuous USB role switch and simultaneous UDC write operations
> > performed by init.rc from user space through configfs.  In these
> > scenarios, there was a possibility of usb_udc_release being done before
> > gadget_match_driver.
> > 
> > [27635.233849]  BUG: KASAN: invalid-access in gadget_match_driver+0x40/0x94
> > [27635.233871]  Read of size 8 at addr d7ffff8837ead080 by task init/1
> > [27635.233881]  Pointer tag: [d7], memory tag: [fe]
> > [27635.233888]
> > [27635.233917]  Call trace:
> > [27635.233923]   dump_backtrace+0xec/0x10c
> > [27635.233935]   show_stack+0x18/0x24
> > [27635.233944]   dump_stack_lvl+0x50/0x6c
> > [27635.233958]   print_report+0x150/0x6b4
> > [27635.233977]   kasan_report+0xe8/0x148
> > [27635.233985]   __hwasan_load8_noabort+0x88/0x98
> > [27635.233995]   gadget_match_driver+0x40/0x94
> > [27635.234005]   __driver_attach+0x60/0x304
> > [27635.234018]   bus_for_each_dev+0x154/0x1b4
> > [27635.234027]   driver_attach+0x34/0x48
> > [27635.234036]   bus_add_driver+0x1ec/0x310
> > [27635.234045]   driver_register+0xc8/0x1b4
> > [27635.234055]   usb_gadget_register_driver_owner+0x7c/0x140
> > [27635.234066]   gadget_dev_desc_UDC_store+0x148/0x19c
> > [27635.234075]   configfs_write_iter+0x180/0x1e0
> > [27635.234087]   vfs_write+0x298/0x3e4
> > [27635.234105]   ksys_write+0x88/0x100
> > [27635.234115]   __arm64_sys_write+0x44/0x5c
> > [27635.234126]   invoke_syscall+0x6c/0x17c
> > [27635.234143]   el0_svc_common+0xf8/0x138
> > [27635.234154]   do_el0_svc+0x30/0x40
> > [27635.234164]   el0_svc+0x38/0x68
> > [27635.234174]   el0t_64_sync_handler+0x68/0xbc
> > [27635.234184]   el0t_64_sync+0x19c/0x1a0
> > 
> > Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
> > ---
> >  drivers/usb/gadget/udc/core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> > index cf6478f97f4a..77dc0f28ff01 100644
> > --- a/drivers/usb/gadget/udc/core.c
> > +++ b/drivers/usb/gadget/udc/core.c
> > @@ -1338,6 +1338,7 @@ static void usb_udc_release(struct device *dev)
> >  	udc = container_of(dev, struct usb_udc, dev);
> >  	dev_dbg(dev, "releasing '%s'\n", dev_name(dev));
> >  	kfree(udc);
> > +	udc = NULL;
> 
> That's not ok, as what happens if you race right between freeing it and
> accessing it elsewhere?

In fact, this assignment does nothing at all.  This is at the end of the 
function and udc is a local variable, so it's not going to be used 
again.  The compiler won't even generate any code for this.

> >  }
> >  
> >  static const struct attribute_group *usb_udc_attr_groups[];
> > @@ -1574,7 +1575,7 @@ static int gadget_match_driver(struct device *dev, const struct device_driver *d
> >  			struct usb_gadget_driver, driver);
> >  
> >  	/* If the driver specifies a udc_name, it must match the UDC's name */
> > -	if (driver->udc_name &&
> > +	if (driver->udc_name && udc &&
> 
> I agree this isn't good, but you just made the window smaller, please
> fix this properly.

I don't see how udc can possibly be NULL here.  It gets initialized to a 
non-NULL value when usb_add_gadget() does:

	gadget->udc = udc;

and nothing changes its value thereafter.  It seems much more likely 
that the error shown above is an invalid pointer access because 
gadget->udc points to a location that has been deallocated.  Adding this 
NULL check won't fix the bug.

Apparently the problem is caused by the fact that bus_for_each_dev(), 
iterating over the things on the gadget bus, is still using gadget after

	device_del(&gadget->dev);

in usb_del_gadget() returns and while

	device_unregister(&udc->dev);

runs and the udc structure is deallocated.  The only solution I can 
think of is for the gadget to take a reference to the udc and drop the 
reference when the gadget is released.  Unfortunately, several UDC 
drivers define their own gadget-release routines; they will all need to 
be modified.  And the core will need its own gadget-release routine for 
use when the UDC driver does not specify its own.

Alan Stern

