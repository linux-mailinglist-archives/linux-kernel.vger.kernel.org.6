Return-Path: <linux-kernel+bounces-315245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1986A96BFC2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA051C241DA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04711DA62C;
	Wed,  4 Sep 2024 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m2E58tiU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1221D9D70;
	Wed,  4 Sep 2024 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459187; cv=none; b=lrO1L1yp+zMW6HmboD84Qq2VmtXAH6ssm0IJon/OmfX0MgmeOR4GaGAIpmayRU44ahvNvHaZ79AGUbW+s0IfErddjFZhrJfILe8gXf42JXgLvomAnGgCTFXj7isuz/ZPOuKc/Yz1R1ca6S1+chmRkcNrpyDq6j5w4bb9p8lyHBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459187; c=relaxed/simple;
	bh=RrFPDPZeZLM6GXuS6xgLbpxSSAazd3xRY/Ov7VdhJTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CotKSS28HiHggZHdeGLzUMdEJZ78fvWxJvWkDb4ZZd8zyfhf6KirApNiEOpgxiXg4E7b7dzTshzRiYc9+j5OeXMwXGqTrnxS3nqNk/5uVrKZzJX7jHaEE+kk3F/D6RpKJzpBD8yG1maz1bHkrh6kwMBFJ2pL+fCmJBMUZDNq8MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m2E58tiU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAE5C4CEC2;
	Wed,  4 Sep 2024 14:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725459186;
	bh=RrFPDPZeZLM6GXuS6xgLbpxSSAazd3xRY/Ov7VdhJTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m2E58tiUogfSLAVqXAojnuaQINFW7uzDemNJN6IWUD3ZGiH9HybxwKtWuJmX5M3iE
	 NiaH9eM1dLV1Sj9bURV0BsZ+vyJuOUZi0vERIRgJh9dxPUrUX3pP8SxC3Bx9+ZGIP+
	 QDd1zr9MJigDyokSHkGwN4w1RPs7lISsaLWkfECw=
Date: Wed, 4 Sep 2024 16:13:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] USB: usbtmc: prevent kernel-infoleak
Message-ID: <2024090427-trident-delegator-0781@gregkh>
References: <000000000000a338d6062149eb22@google.com>
 <tencent_088B2EF2AEE00C8AE7D706CCD2CBC6484906@qq.com>
 <2024090430-revolving-unmindful-75b7@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024090430-revolving-unmindful-75b7@gregkh>

On Wed, Sep 04, 2024 at 04:09:15PM +0200, Greg KH wrote:
> On Wed, Sep 04, 2024 at 09:55:43PM +0800, Edward Adam Davis wrote:
> > The syzbot reported a kernel-usb-infoleak in usbtmc_write,
> > we need to clear the structure before filling fields.
> 
> Really?
> 
> 
> > 
> > Fixes: 4ddc645f40e9 ("usb: usbtmc: Add ioctl for vendor specific write")
> > Reported-and-tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  drivers/usb/class/usbtmc.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
> > index 6bd9fe565385..e9ddaa9b580d 100644
> > --- a/drivers/usb/class/usbtmc.c
> > +++ b/drivers/usb/class/usbtmc.c
> > @@ -759,6 +759,7 @@ static struct urb *usbtmc_create_urb(void)
> >  		usb_free_urb(urb);
> >  		return NULL;
> >  	}
> > +	memset(dmabuf, 0, bufsize);
> 
> To do this simpler, kzmalloc() above this would be nice.
> 
> But, this feels odd, where is the data leaking from?  This is used for
> both the read and write path, but where is the leak happening?  A short
> read?  If so, we need to properly truncate the buffer being sent to
> userspace and not send the unread data.  If a short write, that makes no
> sense.

I looked at the report and this seems to be data sent to the device, so
somehow we aren't setting the length to send to the device correctly.

Good luck!

greg k-h

