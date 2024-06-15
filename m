Return-Path: <linux-kernel+bounces-215801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B985C909729
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 11:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352DA1F21B90
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 09:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EFE219F9;
	Sat, 15 Jun 2024 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d7pqz/6L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C21BC40;
	Sat, 15 Jun 2024 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718442020; cv=none; b=ZYy/8emERdTp8ncL+mIrXK/qTiCK0/wbRSu1Fh3f8XqIEq9ih2c9BJAPPe6xSUHRAe40DKBltOlStmW13rd0tkoulsYLAxc0vpebkYiM21Ht/2d92Snwc1s9+MdeT3+/irv4+x9S8+pZjeP8/28y6PiorkQvNK+YDQ48m0LRcJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718442020; c=relaxed/simple;
	bh=92/4lDTp9j2ndMUWZ9LLrkIFA9ewEi7ESZfDgv+7TOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKHQTlA4eGOEMIHh+GnHo7ApDgA85/Y4oaj4TFVIkhUkzmy3PDQ9Dm5OVgCNhIGxVhuoJB4Vs+Zel5yT3M7R1tXmxURvE17mx1ShSgiYBPScts1DYWJ1v0r5vk4XHEPUIfhILKIqdrMA7RQU1NHXqXlCdA26P3ZFxUTFln5NY6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d7pqz/6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3046C116B1;
	Sat, 15 Jun 2024 09:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718442019;
	bh=92/4lDTp9j2ndMUWZ9LLrkIFA9ewEi7ESZfDgv+7TOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d7pqz/6LUO/G08/acpGoTe7XjQ5dW53Yu2uHO8mgG94WxmkTQxv3WRTkJbRvOavkt
	 wJXcOCM7minRLLsjlexHTzpMkrBDAbvIjWRpyPhMyUiEUGe6RzstYWPtYO+xumdqCm
	 OJGJbj83iivzrIOQaLHHmCR31MaLhkFxbB7JGN2k=
Date: Sat, 15 Jun 2024 11:00:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Grant Grundler <grundler@chromium.org>,
	Oliver Neukum <oneukum@suse.com>,
	Douglas Anderson <dianders@chromium.org>,
	Yajun Deng <yajun.deng@linux.dev>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	"Ricardo B. Marliere" <ricardo@marliere.net>
Subject: Re: [PATCH 4/4] USB: move dynamic ids out of usb driver structures
Message-ID: <2024061549-pagan-banter-aa23@gregkh>
References: <2024061448-manly-universal-00ad@gregkh>
 <2024061452-science-clinking-3b92@gregkh>
 <92b4729d-d2a4-4744-887c-744c2145b3c6@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92b4729d-d2a4-4744-887c-744c2145b3c6@rowland.harvard.edu>

On Fri, Jun 14, 2024 at 10:41:13AM -0400, Alan Stern wrote:
> On Fri, Jun 14, 2024 at 02:11:52PM +0200, Greg Kroah-Hartman wrote:
> > The usb driver structures contain a dynamic id structure that is written
> > to, preventing them from being able to be constant structures.  To help
> > resolve this, move the dynamic id structure out of the driver and into a
> > separate local list, indexed off of the driver * so that all USB
> > subsystems can use it (i.e. usb-serial).
> > 
> > Overall it moves some duplicated code out of the usb-serial core as it's
> > already in the usb core, and now the usb dynamic id structures can be
> > private entirely to the usb core itself.
> 
> I'm concerned about the locking of the usb_dynid and usb_dynids
> structures.  There doesn't seem to be anything to prevent these things
> from being deallocated while another thread is reading them.

You are correct, but I think I am just preserving the broken behaviour
that we have today :)

> > diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> > index 3f69b32222f3..8bba102de39f 100644
> > --- a/drivers/usb/core/driver.c
> > +++ b/drivers/usb/core/driver.c
> > @@ -34,17 +34,76 @@
> >  
> >  #include "usb.h"
> >  
> > +static struct list_head usb_dynids;
> > +static spinlock_t usb_dynids_lock;
> 
> Is there any particular reason you decided to make this a spinlock
> instead of a mutex?

I was just keeping the original lock type.

> Why not use static initialization for these things...

Good point, I missed that for some reason, will fix.

> > +
> > +struct usb_dynids {
> > +	struct list_head node;
> > +	const struct device_driver *driver;
> > +	struct list_head list;
> > +};
> > +
> > +struct usb_dynid {
> > +	struct list_head node;
> > +	struct usb_device_id id;
> > +};
> > +
> > +void usb_dynids_init(void)
> > +{
> > +	spin_lock_init(&usb_dynids_lock);
> > +	INIT_LIST_HEAD(&usb_dynids);
> > +}
> 
> ... instead of this dynamic initialization?  Not that it's a big deal.

It saves a function call, so yes, you are right, will fix that up.

> > +static struct usb_dynids *usb_find_dynids(const struct device_driver *driver)
> > +{
> > +	struct usb_dynids *u;
> > +
> > +	/* Loop through the list to find if this driver has an id list already */
> > +	guard(spinlock)(&usb_dynids_lock);
> > +	list_for_each_entry(u, &usb_dynids, node) {
> > +		if (u->driver == driver)
> > +			return u;
> > +	}
> 
> So here, for instance.  usb_dynids_lock is held while this routine
> iterates through the usb_dynids list.  But when an entry is found, the
> lock is released.  What's to prevent another thread from deallocating
> right now the structure that u points to?
> 
> For instance, do we know that this code will always run under the
> protection of some mutex associated with the driver?  Not as far as I
> can see.

Nope, looks wrong.

> 
> > +	return NULL;
> > +}
> > +
> > +static int store_id(const struct device_driver *driver, const struct usb_device_id *id)
> > +{
> > +	struct usb_dynids *u;
> > +	struct usb_dynid *usb_dynid;
> > +
> > +	u = usb_find_dynids(driver);
> > +	if (!u) {
> > +		/* This driver has not stored any ids yet, so make a new entry for it */
> > +		u = kmalloc(sizeof(*u), GFP_KERNEL);
> > +		if (!u)
> > +			return -ENOMEM;
> > +		u->driver = driver;
> > +		INIT_LIST_HEAD(&u->list);
> > +		guard(spinlock)(&usb_dynids_lock);
> > +		list_add_tail(&u->node, &usb_dynids);
> > +	}
> > +
> > +	/* Allocate a new entry and add it to the list of driver ids for this driver */
> > +	usb_dynid = kmalloc(sizeof(*usb_dynid), GFP_KERNEL);
> > +	if (!usb_dynid)
> > +		return -ENOMEM;
> > +
> > +	INIT_LIST_HEAD(&usb_dynid->node);
> > +	memcpy(&usb_dynid->id, id, sizeof(*id));
> > +	list_add_tail(&usb_dynid->node, &u->list);
> 
> Here we see that the spinlock is _not_ held while a new usb_dynid
> entry is added to the driver's list.  (Yes, the existing code already
> has the same problem; it's not something you added.)

That's the main problem here, I kept the existing locking "scheme" which
was only half-there.

I'll make this a mutex and add locking everywhere to properly protect
the lists.

> > -ssize_t usb_show_dynids(struct usb_dynids *dynids, char *buf)
> > +ssize_t usb_show_dynids(const struct device_driver *driver, char *buf)
> >  {
> > +	struct usb_dynids *dynids;
> >  	struct usb_dynid *dynid;
> >  	size_t count = 0;
> >  
> > +	dynids = usb_find_dynids(driver);
> > +	if (!dynids)
> > +		return 0;
> > +
> >  	list_for_each_entry(dynid, &dynids->list, node)
> >  		if (dynid->id.bInterfaceClass != 0)
> >  			count += scnprintf(&buf[count], PAGE_SIZE - count, "%04x %04x %02x\n",
> 
> And here nothing holds the spinlock while we iterate through the list.
> 
> > @@ -160,8 +216,12 @@ static ssize_t remove_id_store(struct device_driver *driver, const char *buf,
> >  	if (fields < 2)
> >  		return -EINVAL;
> >  
> > +	dynids = usb_find_dynids(driver);
> > +	if (!dynids)
> > +		return count;
> > +
> >  	guard(spinlock)(&usb_dynids_lock);
> > -	list_for_each_entry_safe(dynid, n, &usb_driver->dynids.list, node) {
> > +	list_for_each_entry_safe(dynid, n, &dynids->list, node) {
> >  		struct usb_device_id *id = &dynid->id;
> >  
> >  		if ((id->idVendor == idVendor) &&
> 
> Although here the spinlock is held while an entry is removed.  But
> that doesn't do any good if readers don't also acquire the spinlock.
> 
> Overall, I think it would be better to hold the spinlock throughout the
> entire time that the dynamic ids are being accessed: Grab it before
> starting the outer search and don't release it until the desired entry
> has been found, added, or removed.
> 
> > @@ -1100,8 +1173,8 @@ void usb_deregister(struct usb_driver *driver)
> >  			usbcore_name, driver->name);
> >  
> >  	usb_remove_newid_files(driver);
> > +	usb_free_dynids(&driver->driver);
> >  	driver_unregister(&driver->driver);
> > -	usb_free_dynids(driver);
> 
> Here's another potential problem.  You moved the usb_free_dynids()
> call from after driver_unregister() to before it.  This means that the
> driver is still visible when usb_free_dynids() runs, so another thread
> might be iterating through the dynid list while the list is removed.
> In fact, that other thread might go ahead and add a new usb_dynids
> structure right after the function call here removes the old one!

For some reason I thought that we needed to free the memory before it
could be used, but given the locking issues, this could break, you are
correct.

I'll go back and redo the locks here to properly be held everywhere, and
just be a mutex to make things simpler, thanks so much for the review!

greg k-h

