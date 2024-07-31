Return-Path: <linux-kernel+bounces-268778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6528D94292C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 970181C215A4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DCA1A7F93;
	Wed, 31 Jul 2024 08:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZgYgAoj+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF291B7F4;
	Wed, 31 Jul 2024 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414620; cv=none; b=J6GEjOOSMVTQihIILlO5LDJGsZ6XA1KAyDA7iYLHICbIQDNicIzZzw24N2PETHxsHANdddVI7oQT+T/a+T5BPUuuix6kxdPBXjc90VaHVj4df0idxuSmBpDE6Xlce/1ksu8l10BruW2ZY9of2J50MMHNEiUI/ES/BQ3zmKhk9H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414620; c=relaxed/simple;
	bh=OR8H7WCKIvfDnHtuwKjrLnw1TJnOIDK3iNbYRPYfkJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JAZPV8tulliNWIHakX8Vx2LXiSd2jf73GQRr3r0xv/lB3BvTR1ol85gpZtC7UsFfGjZblPxG+KZEt2IoxTUKtPpI6WNbpcAx7lbC2wvvZ56ijzGN882yj3bBv1eN9ABDVYYGc3KoImtvTaQ4/yaMjCcgW0m9B36bbnhUXT1lV0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZgYgAoj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD2EC4AF09;
	Wed, 31 Jul 2024 08:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722414619;
	bh=OR8H7WCKIvfDnHtuwKjrLnw1TJnOIDK3iNbYRPYfkJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZgYgAoj+0L9QnXpC9qJ+G5XctMKEzn88t9UaPCQdzjJ8+cQ+8EI4tXXP0thqV68Xf
	 RTRvG/Or5nMDk0OAUiWmkkp1pagorkqxR8X/i+GyLeHyVbwVRqLTVNT2D/hwGBiwPl
	 tbzT9GZoPOhYJDk4Mn2IanG/C5xLD1pnrvb/pcJE=
Date: Wed, 31 Jul 2024 10:30:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Daniel Scally <dan.scally@ideasonboard.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: function: uvc: set req_size once when the
 vb2 queue is calculated
Message-ID: <2024073100-manor-sworn-7bf2@gregkh>
References: <20240404-uvc_request_calc_once-v1-1-fea7fd8f0496@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404-uvc_request_calc_once-v1-1-fea7fd8f0496@pengutronix.de>

On Thu, Apr 04, 2024 at 10:35:01AM +0200, Michael Grzeschik wrote:
> The uvc gadget driver is calculating the req_size on every
> video_enable/alloc_request and is based on the fixed configfs parameters
> maxpacket, maxburst and mult.
> 
> As those parameters can not be changed once the gadget is started and
> the same calculation is done already early on the
> vb2_streamon/queue_setup path its save to remove one extra calculation
> and reuse the calculation from uvc_queue_setup for the allocation step.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  drivers/usb/gadget/function/uvc_queue.c |  2 ++
>  drivers/usb/gadget/function/uvc_video.c | 15 ++-------------
>  2 files changed, 4 insertions(+), 13 deletions(-)

Is this still needed?  If so, can you rebase and resubmit it?

thanks,

greg k-h

