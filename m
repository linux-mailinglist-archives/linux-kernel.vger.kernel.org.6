Return-Path: <linux-kernel+bounces-317222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 807D096DB1C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3664E1F24605
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E4919E96D;
	Thu,  5 Sep 2024 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D2bqarac"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC819E7E8;
	Thu,  5 Sep 2024 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545075; cv=none; b=j0akDHNQtYFaqU51H37xq7ITGrbAMO/CsGePsS2jlQnGQvqgRT5PVgaeJyfVPXRVMcKVff4+502JgXJyuzBpr3tDeYJf60+pQqLVoMNsAa5EUsf8UHCFWqAo/mcZEN7ob+Ke+Ywax8qLzmy+K63o8IpROuHEbEd46iOVE+scrdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545075; c=relaxed/simple;
	bh=YRUYN9ldTcmOGt4iSrAJ5QgNCVf+64KJjODYFuOp4b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZuqrFHzErKoMwSKnNhP/wRRn2q8319pu65uUeLTNo7R53PMkuJwjb3+2OiJ7wJkcJ4IFscfSsc1A2ZHFZni5EevUOHVnQLx3Mqwpwqz7I62LkL4bWiDAokMYJmZ/HTs8De8xpBxQsRLxmNnFQRuRdxoVnqRH4kOXogSrCYcp8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D2bqarac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38366C4CEC3;
	Thu,  5 Sep 2024 14:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725545074;
	bh=YRUYN9ldTcmOGt4iSrAJ5QgNCVf+64KJjODYFuOp4b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D2bqaracnYkE020hvGpf3MmQ4ZoMQLAkOdUcgC1cqwCnPpHg3QuWa338qY7RL7nVl
	 0hV0qXAM9IIRK+dVoDgpgJyt1HNXT0S+HkOHxKyC5zXRq1j+zvufENFSiFXXvxwBxL
	 X421YN95VRpdaxgXE71Yuo8ggwxAHVsZUELWS5mY=
Date: Thu, 5 Sep 2024 16:04:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] USB: usbtmc: prevent kernel-infoleak
Message-ID: <2024090522-gauntlet-dropper-7590@gregkh>
References: <2024090427-trident-delegator-0781@gregkh>
 <tencent_70402C916F4897E0E81EEEEACE287B726D0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_70402C916F4897E0E81EEEEACE287B726D0A@qq.com>

On Thu, Sep 05, 2024 at 09:56:53PM +0800, Edward Adam Davis wrote:
> On Wed, 4 Sep 2024 16:13:03 +0200, Greg KH wrote:
> > On Wed, Sep 04, 2024 at 04:09:15PM +0200, Greg KH wrote:
> > > On Wed, Sep 04, 2024 at 09:55:43PM +0800, Edward Adam Davis wrote:
> > > > The syzbot reported a kernel-usb-infoleak in usbtmc_write,
> > > > we need to clear the structure before filling fields.
> > >
> > > Really?
> > >
> > >
> > > >
> > > > Fixes: 4ddc645f40e9 ("usb: usbtmc: Add ioctl for vendor specific write")
> > > > Reported-and-tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
> > > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > > ---
> > > >  drivers/usb/class/usbtmc.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
> > > > index 6bd9fe565385..e9ddaa9b580d 100644
> > > > --- a/drivers/usb/class/usbtmc.c
> > > > +++ b/drivers/usb/class/usbtmc.c
> > > > @@ -759,6 +759,7 @@ static struct urb *usbtmc_create_urb(void)
> > > >  		usb_free_urb(urb);
> > > >  		return NULL;
> > > >  	}
> > > > +	memset(dmabuf, 0, bufsize);
> > >
> > > To do this simpler, kzmalloc() above this would be nice.
> > >
> > > But, this feels odd, where is the data leaking from?  This is used for
> > > both the read and write path, but where is the leak happening?  A short
> > > read?  If so, we need to properly truncate the buffer being sent to
> > > userspace and not send the unread data.  If a short write, that makes no
> > > sense.
> A short write.
> > 
> > I looked at the report and this seems to be data sent to the device, so
> > somehow we aren't setting the length to send to the device correctly.
> The length of the data passed in by the user is 3 bytes, plus a TMC header
> length of 12 bytes and an additional 3 bytes. The actual length of the
> data sent to the device is 16 bytes((3 + 12 + 3)~3 = 16).
> 
> Normally, when executing copy_from_user, the 3 bytes data passed in by
> the user is written after the TMC header, which initializes the first 15
> bytes of the 16 bytes. But it is not yet clear why the 15th byte is not
> initialized. The kernel data leaked to user space reported by Syzbot
> should be it.

But why are we sending 16 bytes to the device?  Is that the format of
the message it expects?  If so, that's fine, just set that byte to 0.

And as the device is the thing that is getting the kernel memory, that
really isn't a big deal as we "trust" hardware once it is up and talking
to the kernel.

thanks,

greg k-h

