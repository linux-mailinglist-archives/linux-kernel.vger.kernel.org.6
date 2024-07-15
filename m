Return-Path: <linux-kernel+bounces-252760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA4E9317CF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5911C21A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF8118F2FE;
	Mon, 15 Jul 2024 15:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jwIUsPse"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BC01849DD;
	Mon, 15 Jul 2024 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721058201; cv=none; b=omE4xdxHs0/UOVHjSSN0V7yITA4Rii7GgFmZ0BYZHKX0wj0J6IzKUHFrX5ZVMUcxbUnE2SHv4+E7uVYlqKz9hrmgOf+74s8Z0HkPMnXjx+1tnjkQ7a+FkVhkUGfwETR0EiGfrvDGSHJsXlBAL9yVeDC3Yzjubr+etMUmqsSflUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721058201; c=relaxed/simple;
	bh=mE2xxwtTjMUyrjUohekIkGGG3Hq3+me6hazFaOgSVrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptj0ObCXWMv/q0ahkafAp586YrllTy0G9Ryel/1nuUDzCe9OAI2nJGeXvcb4AUl/xJ7U9jImqnxjOzSecGqFOBxJUcfyhtDAMYc4lsBaTl7uU6XXaUQkfS0CDQQKGjTEJMs6Xs6SquhJ8MPvqCC0j79aqku39LZN5Hh0OVFXQCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jwIUsPse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63716C32782;
	Mon, 15 Jul 2024 15:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721058200;
	bh=mE2xxwtTjMUyrjUohekIkGGG3Hq3+me6hazFaOgSVrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jwIUsPse2yBvTbsC1TRGwdD9v8LCNOTX1Wu442U0Ni4tFXySw+0vWPhU5OMMXvny7
	 cVATWs8dMtadx0kO3s8x06E5B754Ao16i4p/tpiUBxSPda194Ce6FZwUYJYSrqB/zD
	 vn8J1BYr2XOm5Ai4NdAneBx+adZzdtNlRTQd59yg=
Date: Mon, 15 Jul 2024 17:43:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: ryan zhou <ryanzhou54@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, jikos@kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid: usbhid: Enable remote wake-up based on device
 configuration
Message-ID: <2024071518-progeny-unsecured-2926@gregkh>
References: <20240710231606.3029-1-ryanzhou54@gmail.com>
 <f0c789d8-8ae0-4a46-a5b3-aa9a5a758915@rowland.harvard.edu>
 <2024071104-rental-bleak-b273@gregkh>
 <CAPwe5ROTfQVQ2fF3ab05E51X+_5zFpSNK-qrEh-ev-WWBzY+DA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPwe5ROTfQVQ2fF3ab05E51X+_5zFpSNK-qrEh-ev-WWBzY+DA@mail.gmail.com>

On Mon, Jul 15, 2024 at 11:36:57PM +0800, ryan zhou wrote:
> On Thu, Jul 11, 2024 at 3:41 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jul 10, 2024 at 09:47:39PM -0400, Alan Stern wrote:
> > > On Thu, Jul 11, 2024 at 07:16:06AM +0800, ryan wrote:
> > > > According to the USB protocol, the host should automatically
> > > > adapt the remote wake-up function based on the configuration
> > > > descriptor reported by the device, rather than only the default
> > > > keyboard support. Therefore, it's necessary to support other hid
> > > > devices, such as digital headsets,mice,etc.
> > >
> > > It's true that the host shouldn't try to enable remote wakeup if the
> > > configuration descriptor shows that the device doesn't support it.
> > >
> > > However, it's not true that the host should try to enable remote wakeup
> > > for devices other than keyboards with boot-protocol support.  History
> > > has shown that quite a few HID devices don't handle remote wakeup
> > > properly; the decision about whether to enable it should be left to the
> > > user.
> >
> > I agree, this patch isn't acceptable.  Ryan, why do you want this
> > applied?  What userspace control is missing to allow you to do this
> > today on your systems with no kernel changes for devices that you know
> > will work properly?
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Many thanks to Greg KH and Alan Stern for reviewing the patch and
> replying to me.
> I'd like to start by asking Greg KH's question.
> 
> A1:This patch is expected to be applied to the USB digital headset,
> mouse, and keyboard,
> and we expect to wake up the system by operating them when the system
> has suspended.
> 
> A2:I've verified that user-space control does the trick, but
> Personally speaking, it's not a good solution.
> For each device plugged into the host, the user space needs to check whether
> it is one of the three and to enable wakeup.It may be better to enable
> wakeup when loading
> a HID class drivers, from my perspective. Could you please give me
> some advice if possible.

You can run anything you want at device-plugin-time in userspace by
writing a udev rule, that's exactly what that was designed for.  The
policy you decide is under your control in userspace, no need to do
anything special in the kernel at all.

> I have spent some time studying your responses, and learned a lot. I
> absolutely agree with many
> of your points, but still have some doubts.
> 
> Q1 for Alan Stern: Boot device includes a boot mouse and boot keyboard,
> why the patch(3d61510f4ecac) only enables boot keyboard by default,
> and in addation boot
> protocol is used in BIOS,why is it used as a wakeup judgment condition
> in the OS?
> 
> Q2: for Alan Stern:  As you comment 'History has shown that quite a
> few HID devices don't
> handle remote wakeup properly'  I consulted the USB20 Spec in Chapter
> 9.2.5.2 and it has
> this description:'If a device supports remote wakeup, it must also
> allow the capability to be
> enabled and disabled using the standard USB request'  So these devices
> that you're talking about
> are not compliant with the USB20 protocol specification to my mind. If
> so, shouldn't we
> support these non-standard devices.

If you do not support "non-standard" devices, your operating system will
not be used by anyone in the real-world as there are TONS of
"non-standard" devices out there, sorry.

try it and see, go to the local store and buy a shopping cart of cheap
mice and keyboards and see what happens...

thanks,

greg k-h

