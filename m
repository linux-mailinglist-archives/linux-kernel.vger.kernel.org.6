Return-Path: <linux-kernel+bounces-320049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F60970599
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACF22821DE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 07:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9951D74040;
	Sun,  8 Sep 2024 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HQ97m91n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021F74C66;
	Sun,  8 Sep 2024 07:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725782066; cv=none; b=DSzM3dVL9JycTdryJ1pkXuwQs6IaZm0G1v/0ZIoOKup9uX4ZErAri0UWisbpsfbYOcWYnPYl2Mfm5o7Vwu1xD3mvnagleOje6AW/SCXgN4l2Rox6XHJOljmb8WDsi/otikgHXZT8JIEt0yN4J8pHtYRE1WNNT42hsr9TJubvrYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725782066; c=relaxed/simple;
	bh=ILYqftmtMuZNK51jHq+yDX0+y9CLy3G/YcuYbf7yHkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rR2P0VZona378lCGJj+nWsqMC0fPPQKdRrdj+X0ZUimT7E49tyU6D+utpVDFAgqSTOFqaHCxkOMS2oRnImjCXafiAGLJLphxkTLapP4xHFLmQSKlqL5YOHSFpokZZtx55P4nfAFKxSDsOCzyrI48xEAz7U/54/kK8VruOYaDg5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HQ97m91n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23051C4CEC3;
	Sun,  8 Sep 2024 07:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725782065;
	bh=ILYqftmtMuZNK51jHq+yDX0+y9CLy3G/YcuYbf7yHkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQ97m91ng8zpfEjL902Z4yc63dB7Ek9gHhVyia4K97NAtgIAB776riXbo0CxoJhpK
	 KDUhqWnDLTldtmDeAeJ5dLoje1r+J5BHmzFIqr/vqveLL2NDz4enQHYaem80PzFpGn
	 w9kOrApjb1Kg1xK0VMRXUdDIkLNuUm6c1RE6g7mY=
Date: Sun, 8 Sep 2024 09:54:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	stern@rowland.harvard.edu,
	syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] USB: usbtmc: prevent kernel-usb-infoleak
Message-ID: <2024090832-tabby-mom-e3d6@gregkh>
References: <2024090810-arrogant-disallow-6f08@gregkh>
 <tencent_E06EEC2C516D3C9500E952ED0ACD9C787A0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_E06EEC2C516D3C9500E952ED0ACD9C787A0A@qq.com>

On Sun, Sep 08, 2024 at 03:35:49PM +0800, Edward Adam Davis wrote:
> On Sun, 8 Sep 2024 07:20:40 +0200, Greg KH wrote:
> > On Sun, Sep 08, 2024 at 10:20:57AM +0800, Edward Adam Davis wrote:
> > > The syzbot reported a kernel-usb-infoleak in usbtmc_write.
> > >
> > > The expression "aligned = (transfersize + (USBTMC_HEADER_SIZE + 3)) & ~3;"
> > > in usbtmcw_write() follows the following pattern:
> > >
> > > aligned = (1 + 12 + 3) & ~3 = 16   // 3 bytes have not been initialized
> > > aligned = (2 + 12 + 3) & ~3 = 16   // 2 bytes have not been initialized
> > > aligned = (3 + 12 + 3) & ~3 = 16   // 1 byte has not been initialized
> > > aligned = (4 + 12 + 3) & ~3 = 16   // All bytes have been initialized
> > > aligned = (5 + 12 + 3) & ~3 = 20   // 3 bytes have not been initialized
> > > aligned = (6 + 12 + 3) & ~3 = 20   // 2 bytes have not been initialized
> > > aligned = (7 + 12 + 3) & ~3 = 20   // 1 byte has not been initialized
> > > aligned = (8 + 12 + 3) & ~3 = 20   // All bytes have been initialized
> > > aligned = (9 + 12 + 3) & ~3 = 24
> > > ...
> > >
> > > Note: #define USBTMC_HEADER_SIZE      12
> > >
> > > This results in the buffer[USBTMC_SEAD_SIZE+transfersize] and its
> > > subsequent memory not being initialized.
> > >
> > > Fixes: 4ddc645f40e9 ("usb: usbtmc: Add ioctl for vendor specific write")
> > > Reported-and-tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > ---
> > > V2 -> V3: Update condition and comments
> > >
> > >  drivers/usb/class/usbtmc.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
> > > index 6bd9fe565385..faf8c5508997 100644
> > > --- a/drivers/usb/class/usbtmc.c
> > > +++ b/drivers/usb/class/usbtmc.c
> > > @@ -1591,6 +1591,10 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
> > >  		goto exit;
> > >  	}
> > >
> > > +	if (USBTMC_HEADER_SIZE + transfersize < aligned)
> > > +		memset(&buffer[USBTMC_HEADER_SIZE + transfersize], 0,
> > > +			aligned - USBTMC_HEADER_SIZE - transfersize);
> > 
> > As this is now a pain to read/understand, and there's no comment
> > describing it so we'll not really understand it in a few months, let
> > alone years, how about we just do the trivial thing and make the
> > allocation with kzalloc() to start with?  And put a comment there saying
> > why it's zeroed out.
> Perhaps I wrote too much in my comments, but in essence, the logic behind
> this version's fix is:
> When aligned is greater than (USBTMC_HEADER_SIZE+transfersize), there are
> (aligned - (USBTMC_HEADER_SIZE+transfersize) bytes after the header and data
> that have not been initialized, and these bytes are then set to 0.
> > 
> > Sorry, I thought this was going to be a lot simpler based on your first
> > patch than this type of logic.
> As you mentioned in my first version patch, this approach is simple and
> easy to understand, but it comes at the cost of losing the real issue,
> and KMSAN will not find similar problems again in the future, which is
> not conducive to making the program logic more robust.

There will not be similar problems in the future as you are explicitly
setting everything to 0, so all should be fine :)

The real issue here is that the usbtmc logic of sending data is crazy,
and unique to it for various reasons that well all really don't
understand.  Given the very small number of these devices in the world,
it's probably best left to the maintainers of it to handle any real
problems going forward, and just squash these types of fuzzing bugs now
with a heavy hammer to make them happy.

thanks,

greg k-h

