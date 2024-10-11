Return-Path: <linux-kernel+bounces-360498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35061999BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24E51F25B28
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16141F9428;
	Fri, 11 Oct 2024 04:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WWmVV0SK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8931F4FA8;
	Fri, 11 Oct 2024 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728621635; cv=none; b=i5jb+t9zldrCcmQGnTWDhJCCDBXK3XScVWV6umLtnbmum16egLsUtSmW2tBbL6iUBsT01xcwPwkywKbPL/KlFYr03+eYlyG4e+aQsdhfxj9yZZj52qZLiR6X0zKaYm1cLsClcgxvxe7XBRBmsSnBI+1yClgK+RIDcfVNJXTNnxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728621635; c=relaxed/simple;
	bh=fv7ZcG807Xn3XkqYXMc7par4sQR3IJcSD+cX+aEunVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLefQpamKkSBtwpEPzpQ7ctq0M14QoWcxgKTdqZt+nhm421OAq6Z/q/e05VNn1FBFfhiwgJm4gkgzHjkNLy1kWX6KASD8HJKFhklQyvY8xdEzQQ3MuRk9Q8BdIb0wYp2HqGF/4a77srg6TpcCQ4mZBO3zXuJ9ao7aECQ+cq+7/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WWmVV0SK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0939C4CEC3;
	Fri, 11 Oct 2024 04:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728621634;
	bh=fv7ZcG807Xn3XkqYXMc7par4sQR3IJcSD+cX+aEunVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWmVV0SKZrhfAKyDVF45vorJzXEuQ9GyG3iy2i+Vz7yDdoQnCEyX6gmSh8Wx21DvT
	 PCfq2zLKOw0EVw3cJ8QLnWs8s+6uzTXfGqumlMrcEpuHpNkfnYYV242neIu3Kg2wee
	 /dSfEi72bjjFc3iYaMF9jZK5vU7j1q8RovVPhmys=
Date: Fri, 11 Oct 2024 06:30:58 +0200
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
Message-ID: <2024101104-feminist-gulf-97e3@gregkh>
References: <20241009054429.3970438-1-guanyulin@google.com>
 <20241009054429.3970438-4-guanyulin@google.com>
 <2024100941-limping-dislodge-5c74@gregkh>
 <CAOuDEK0a43yLhCoA8iq=stj+QQAmKTCVWGKHvKM6-GPEaN9C3g@mail.gmail.com>
 <2024101021-vertigo-gopher-e487@gregkh>
 <CAOuDEK01Ke9KZqPf6KOfXaAQRRvw-y0Vagd9NrP8e8_EG-w52g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOuDEK01Ke9KZqPf6KOfXaAQRRvw-y0Vagd9NrP8e8_EG-w52g@mail.gmail.com>

On Fri, Oct 11, 2024 at 12:14:00AM +0800, Guan-Yu Lin wrote:
> On Thu, Oct 10, 2024 at 2:33 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 10, 2024 at 01:30:00PM +0800, Guan-Yu Lin wrote:
> > > On Wed, Oct 9, 2024 at 8:44 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Wed, Oct 09, 2024 at 05:42:57AM +0000, Guan-Yu Lin wrote:
> > > > > +             parent = parent->parent;
> > > > > +     } while (parent);
> > > >
> > > > Woah, walking up the device chain?  That should not be needed, or if so,
> > > > then each device's "usage count" is pointless.
> > > >
> > >
> > > Say a hub X with usb devices A,B,C attached on it, where usb device A
> > > is actively used by sideband now. We'd like to introduce a mechanism
> > > so that hub X won't have to iterate through all its children to
> > > determine sideband activities under this usb device tree.
> >
> > Why would a hub care?
> >
> 
> Without the information of sideband activities on the usb devices
> connected to the hub, the hub couldn't determine if it could suspend
> or not.

You are talking about an "internal" hub, right?  And isn't this already
covered by the original sideband patchset?  If not, how is power
management being handled there?

> > > This problem
> > > is similar to runtime suspending a device, where rpm uses
> > > power.usage_count for tracking activity of the device itself and
> > > power.child_count to check the children's activity. In our scenario,
> > > we don't see the need to separate activities on the device itself or
> > > on its children.
> >
> > But that's exactly what is needed here, if a hub wants to know what is
> > happening on a child device, it should just walk the list of children
> > and look :)
> >
> > > So we combine two counters in rpm as sb_usage_count,
> >
> > Combining counters is almost always never a good idea and will come back
> > to bite you in the end.  Memory isn't an issue here, speed isn't an
> > issue here, so why not just do it properly?
> >
> 
> By combining the two comments above, my understanding is that we should either:
> 1. separating the counter to one recording the sideband activity of
> itself, one for its children.
> 2. walk the list of children to check sideband activities on demand.
> Please correct me if I mistake your messages.

I think 2 is better, as this is infrequent and should be pretty fast to
do when needed, right?  But I really don't care, just don't combine
things together that shouldn't be combined.

> > > denoting the sideband activities under a specific usb device. We have
> > > to keep a counter in each device so that we won't influence the usb
> > > devices that aren't controlled by a sideband.
> >
> > I can understand that for the device being "controlled" by a sideband,
> > but that's it.
> >
> > > When sideband activity changes on a usb device, its usb device parents
> > > should all get notified to maintain the correctness of sb_usage_count.
> >
> > Why "should" they?  They shouldn't really care.
> >
> 
> Hubs need the sideband activity information on downstream usb devices,
> so that the hub won't suspend the upstream usb port when there is a
> sideband accessing the usb device connected to it.

Then why doesn't the sideband code just properly mark the "downstream"
device a being used like any other normal device?  Why is this acting
"special"?

thanks,

greg k-h

