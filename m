Return-Path: <linux-kernel+bounces-412108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 450A79D03F8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 14:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A38C28289F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 13:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6F3190470;
	Sun, 17 Nov 2024 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CGA1YMPx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8390E224D7;
	Sun, 17 Nov 2024 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731849145; cv=none; b=uJwVSlR4uy99UG5+y059/XgMsTS+JiJO6zSqpnhXpAqi7UfEqNbA5zhknFmG6ZdMfG56oZ2MbzNGUEBBAHuBNvL71wud4tuX38h5PeyfvqVRAWXEHD7NUlcfXcajuhcA9BXc41e80+Y92Hr7QST3vhuxlsBYrsyhEW66/JD93K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731849145; c=relaxed/simple;
	bh=rU9M05aj4MiXLkJ6DmViYmPFtHC0b0iauT5fQ0vK1ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmLvLsVk2zGwn36+4oqpvsVXbCFpMwX4coA8YNSF0ueol6yTyQflQlngh+NW9DStkCralgdQ3KO5dh8or75D1VDhnUKlazHxLNLaZTY47+cTFJTXXS8AK/Tt61Uee2+26K7vNYLiZzobNOJvBohcA3P1yEo1ZIsHL9y7gt/pegs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CGA1YMPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43CFC4CECD;
	Sun, 17 Nov 2024 13:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731849145;
	bh=rU9M05aj4MiXLkJ6DmViYmPFtHC0b0iauT5fQ0vK1ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGA1YMPx11HAVBKqblY/xOVux/2+htu9dNrcsQm3dc+BD0VbW9gx7+ePHfdhXd7HR
	 QxfVEZbHW6BT9V7Wi3cISmRMq3QBveNJafzBd7mnu0nz4lyFTUSYHOoygyQvVhYb0U
	 Vj6g8aq+SeqwsU4wfKcpOaxqhXzdpmH3n+PiPBts=
Date: Sun, 17 Nov 2024 14:12:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Markus Rechberger <linuxusb.ml@sundtek.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Highly critical bug in XHCI Controller
Message-ID: <2024111732-repeater-earthly-365e@gregkh>
References: <3905c1c88695e0ffcfabf700c06dd7223decef8d.camel@sundtek.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3905c1c88695e0ffcfabf700c06dd7223decef8d.camel@sundtek.de>

On Sun, Nov 17, 2024 at 03:33:28PM +0800, Markus Rechberger wrote:
> Hi,
> 
> 
> the issue was first reported at vdr-portal.de
> https://www-vdr--portal-de.translate.goog/forum/index.php?thread/136541-empfehlung-dvb-s2-tuner-oder-satip/&postID=1376196&_x_tr_sl=de&_x_tr_tl=en&_x_tr_hl=de&_x_tr_pto=wapp#post1376196
> 
> we've got around a highly critical bug in the xhci driver.
> 
> https://sundtek.de/support/uxvd32.txt
> 
> In xhci.c
> 
> The bug is still active in Mainline:
> https://github.com/torvalds/linux/blob/master/drivers/usb/host/xhci.c#L2382
> 
> static int xhci_check_bw_table(struct xhci_hcd *xhci,
>         struct xhci_virt_device *virt_dev,
>         int old_active_eps)
> 
> bw_table can end up with a NULL pointer.
> 
> This problem will lead to a complete kernel crash, rendering the entire
> system unusable without any access to the actual linux system.
> 
> How to trigger the problem?
> Short D+/D- or pull them to ground on a USB device while connecting the
> device.
> 
> The problem can happen due to following cases:
> * a device is getting suddenly disconnected during enumeration
> * a faulty cable
> * a faulty device 
> * a malicious device triggers this issue on purpose
> * if there are electrical issues during connecting a device.

Bad hardware is always a problem, can you send a patch to resolve this
as you seem to be able to reproduce it?

thanks,

greg k-h

