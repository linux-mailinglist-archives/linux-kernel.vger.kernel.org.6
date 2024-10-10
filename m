Return-Path: <linux-kernel+bounces-358331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2C3997D43
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6F7285FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7EB1A2622;
	Thu, 10 Oct 2024 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GnjyFDR6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810643D6B;
	Thu, 10 Oct 2024 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542012; cv=none; b=AUrQPok4vjITu41EgqV45Aq8Hh+/BHjOhQ76xRi8TxdYe9LrsiDLx1beQA6kNzudCXmwFB2keRXDhFfhvkJAkUSv3zaSxozgBOKYrjQnXlF6im2W5zUF/YEw+undeYw7t1PjFbrFjos6giX4byoCux2WuSdw29VfJnPq6KuhmJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542012; c=relaxed/simple;
	bh=p9rPLBe/DEXOANoZKaKJAocYBwz5DgORng0qEelVSWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs8a0shHjDEG1gBQFaRk3KVTUL3eUw5u+apmfe1qbqlkh9HaPiPkq1FCmM/4Y42NC5jC4s2hILgVV/2cy/1Lxe8rIWzZN/CTRxd2BlcMpHTpGTn3bgND+yKWjXuoQyCa2gwHPIKaP4yVZl3BQorbppgHtgGr5UtGbR6HasRVjcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GnjyFDR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679EFC4CEC5;
	Thu, 10 Oct 2024 06:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728542012;
	bh=p9rPLBe/DEXOANoZKaKJAocYBwz5DgORng0qEelVSWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GnjyFDR6nlQ3klC0WZeg54bSLxAKC2AwnP3442CHqDrlyLMQyoqifh0bdeY4QPAnV
	 7okv7WrLxcu6wd/0FePlDVg73tr1IwNtRfW9u4A5X0BXxQ8FU5z0Kiq4ZXrVTsHrI/
	 GtW61Z69ohb17K5z/DIj1DspNORVEk1B5Pvjw0B0=
Date: Thu, 10 Oct 2024 08:33:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: Thinh.Nguyen@synopsys.com, mathias.nyman@intel.com,
	stern@rowland.harvard.edu, elder@kernel.org, oneukum@suse.com,
	yajun.deng@linux.dev, dianders@chromium.org, kekrby@gmail.com,
	perex@perex.cz, tiwai@suse.com, tj@kernel.org,
	stanley_chang@realtek.com, andreyknvl@gmail.com,
	christophe.jaillet@wanadoo.fr, quic_jjohnson@quicinc.com,
	ricardo@marliere.net, grundler@chromium.org, niko.mauno@vaisala.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, badhri@google.com,
	albertccwang@google.com, quic_wcheng@quicinc.com,
	pumahsu@google.com
Subject: Re: [PATCH v4 3/5] usb: add apis for sideband uasge tracking
Message-ID: <2024101021-vertigo-gopher-e487@gregkh>
References: <20241009054429.3970438-1-guanyulin@google.com>
 <20241009054429.3970438-4-guanyulin@google.com>
 <2024100941-limping-dislodge-5c74@gregkh>
 <CAOuDEK0a43yLhCoA8iq=stj+QQAmKTCVWGKHvKM6-GPEaN9C3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOuDEK0a43yLhCoA8iq=stj+QQAmKTCVWGKHvKM6-GPEaN9C3g@mail.gmail.com>

On Thu, Oct 10, 2024 at 01:30:00PM +0800, Guan-Yu Lin wrote:
> On Wed, Oct 9, 2024 at 8:44 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Oct 09, 2024 at 05:42:57AM +0000, Guan-Yu Lin wrote:
> > > +void usb_sideband_get(struct usb_device *udev)
> > > +{
> > > +     struct usb_device *parent = udev;
> > > +
> > > +     do {
> > > +             atomic_inc(&parent->sb_usage_count);
> >
> > As this is a reference count, use refcount_t please.
> 
> Acknowledged, will change it in the next patch. Thanks for the guidance.
> 
> >
> > > +             parent = parent->parent;
> > > +     } while (parent);
> >
> > Woah, walking up the device chain?  That should not be needed, or if so,
> > then each device's "usage count" is pointless.
> >
> 
> Say a hub X with usb devices A,B,C attached on it, where usb device A
> is actively used by sideband now. We'd like to introduce a mechanism
> so that hub X won't have to iterate through all its children to
> determine sideband activities under this usb device tree.

Why would a hub care?

> This problem
> is similar to runtime suspending a device, where rpm uses
> power.usage_count for tracking activity of the device itself and
> power.child_count to check the children's activity. In our scenario,
> we don't see the need to separate activities on the device itself or
> on its children.

But that's exactly what is needed here, if a hub wants to know what is
happening on a child device, it should just walk the list of children
and look :)

> So we combine two counters in rpm as sb_usage_count,

Combining counters is almost always never a good idea and will come back
to bite you in the end.  Memory isn't an issue here, speed isn't an
issue here, so why not just do it properly?

> denoting the sideband activities under a specific usb device. We have
> to keep a counter in each device so that we won't influence the usb
> devices that aren't controlled by a sideband.

I can understand that for the device being "controlled" by a sideband,
but that's it.

> When sideband activity changes on a usb device, its usb device parents
> should all get notified to maintain the correctness of sb_usage_count.

Why "should" they?  They shouldn't really care.

> This notifying process creates the procedure to walk up the device
> chain.

You aren't notifying anyone, you are just incrementing a count that can
change at any moment in time.

> > > +bool usb_sideband_check(struct usb_device *udev)
> > > +{
> > > +     return !!atomic_read(&udev->sb_usage_count);
> >
> > And what happens if it changes right after you make this call?  This
> > feels racy and broken.
> >
> 
> Seems like we need a mechanism to block any new sideband access after
> the usb device has been suspended. How about adding a lock during the
> period when the usb device is suspended? Do you think this is the
> correct direction to address the race condition?

I don't know, as I don't know exactly what you are going to do with this
information.  But as-is, you can't just go "let's put an atomic variable
in there to make it race free" as that's just not going to work.

> > > @@ -731,6 +732,8 @@ struct usb_device {
> > >
> > >       u16 hub_delay;
> > >       unsigned use_generic_driver:1;
> > > +
> > > +     atomic_t sb_usage_count;
> >
> > Why is this on the device and not the interface that is bound to the
> > driver that is doing this work?
> >
> > thanks,
> >
> > greg k-h
> 
> If the count is bound on the usb interface, I'm afraid that the
> sideband information couldn't be broadcasted across its usb device
> parents. Do you have some insight on how we can achieve this?

But the driver that is "sideband" is bound to the interface, not the
device, right?  Or is it the device?

And again, nothing is being "broadcasted" here, it's just a variable to
be read at random times and can change randomly :)

thanks,

greg k-h

