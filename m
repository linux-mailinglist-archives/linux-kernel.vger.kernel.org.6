Return-Path: <linux-kernel+bounces-536684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA28A48301
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C7B172D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6991B26B94D;
	Thu, 27 Feb 2025 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CvPZfcZD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A804B25742F;
	Thu, 27 Feb 2025 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740670299; cv=none; b=C0CNedWbF3Qx0F+9rAFFK/GY6PTW42FOttz10GtAnW1ssiQOrO/SCFJNM5oIb7KJXcv/8sIsjnTTwICO07NTpE23tsT2l79qxb5N8Z6Pe2CQDCTRyBpRgsz5/qOOq+/hxRJaJWbmHhWQL98R6zwrDudewZyO0RQJ+HEJCDLIUxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740670299; c=relaxed/simple;
	bh=Q3lRWLaWxbeTrZTVVmnpz4D86xLuv8RWW2vivnHRv/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crOk9s2zMuTOVapXxP5EkymKqR4yUOurizjaGGYxRhxxfOJI7ZWYxY7e5aBsC4++vmz52VjI1ha8fY6cSZV0xfWhoG28d9+jShoKJaeBDezHuZaHZ/h9ikzPJ29I1sWaE6vevMR94taI4xL6gZ5qXBoq7iE3npN8Y6WIwN3gsb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CvPZfcZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A045C4CEDD;
	Thu, 27 Feb 2025 15:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740670299;
	bh=Q3lRWLaWxbeTrZTVVmnpz4D86xLuv8RWW2vivnHRv/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CvPZfcZDeH+L36p6g94hOMY7MuDA6i3eoVtEoTeLgSFjC/k1mdI/RZ3Kn6ZiWVGAn
	 EYKNeDkUOdxB11ZadqNYXHk3ILkS3Z8HXPGifSj1zXflDGrdXqetqVK0qcGvDDXam7
	 vQFYNxBe42hTJLlSFqBVuC5dMKhBAxea3S+P3gkg=
Date: Thu, 27 Feb 2025 07:30:29 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Lukas Wunner <lukas@wunner.de>,
	Mark Brown <broonie@kernel.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	Robin Murphy <robin.murphy@arm.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Zijun Hu <quic_zijuhu@quicinc.com>, linux-usb@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	=?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Subject: Re: [PATCH v4 0/9] Driver core: Add faux bus devices
Message-ID: <2025022719-papaya-resample-0b59@gregkh>
References: <2025021023-sandstorm-precise-9f5d@gregkh>
 <7d196a91-220a-41a5-8577-198b436d8440@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d196a91-220a-41a5-8577-198b436d8440@bootlin.com>

On Thu, Feb 27, 2025 at 02:06:21PM +0100, Louis Chauvet wrote:
> 
> 
> Le 10/02/2025 à 13:30, Greg Kroah-Hartman a écrit :
> > For years/decades now, I've been complaining when I see people use
> > platform devices for things that are obviously NOT platform devices.
> > To finally fix this up, here is a "faux bus" that should be used instead
> > of a platform device for these tiny and "fake" devices that people
> > create all over the place.
> > 
> > The api is even simpler than the normal platform device api, just two
> > functions, one to create a device and one to remove it.  When a device
> > is created, if a probe/release callback is offered, they will be called
> > at the proper time in the device's lifecycle.  When finished with the
> > device, just destroy it and all should be good.
> > 
> > This simple api should also hopefully provide for a simple rust binding
> > to it given the simple rules and lifecycle of the pointer passed back
> > from the creation function (i.e. it is alive and valid for as long as
> > you have not called destroy on it.)
> > 
> > I've also converted four different examples of platform device abuse, the
> > dummy regulator driver, the USB phy code, the x86 microcode dvice, and
> > the "regulator" device that wifi uses to load the firmware tables, to
> > use this api.  In all cases, the logic either was identical, or became
> > simpler, than before, a good sign (side note, a bug was fixed in the usb
> > phy code that no one ever noticed before).
> > 
> > Note, unless there are major objections, I'm leaning toward getting
> > patch 1 and 2 of this series merged during this -rc cycle so that all of
> > the individual driver subsystem cleanups can go through those subsystems
> > as needed, as well as allowing the rust developers to create a binding
> > and get that merged easier.  Having patch 1 merged on its own isn't
> > going to cause any changes if no one uses it, so that should be fine.
> 
> Hi all,
> 
> I have a maybe dumb question regarding the patches 3..9: do they break the
> UAPI?
> 
> With a platform device, the drivers appear under /sys/bus/platform, but with
> faux device, they appear under /sys/bus/faux.
> 
> I ask because I found out that one (see my reply to [2]) of the main drm
> library expects to find all the devices under pci, usb, platform, virtio and
> host1x buses [1], so at least for the vgem and vkms driver, this library
> will be broken (it will not crash, but previously detected devices will
> suddenly disappear).

Why does a userspace tool want to walk bus types?  Shouldn't it just be
iterating over the userspace class type instead?  classes are how
devices are exposed to userspace, not through a bus.  That way if there
is a new bus type tomorrow (like this one), code will just keep working.

What does the tool actually do in the platform device's directory?

thanks,

greg k-h

