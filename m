Return-Path: <linux-kernel+bounces-320067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EF69705D1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D1F282DA6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 08:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC3913A261;
	Sun,  8 Sep 2024 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t/3ptwsS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4960139D1E;
	Sun,  8 Sep 2024 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725784394; cv=none; b=HFmaG524e33LxJuyZXfdQi3JL/Jcski+XSHEnZh1XX/w5zMwYrNaHz8DQTiHC+3EsYda4L1TM2J20HzVTN+TgvaZEiVEQqxgwsMKk3r9kBfqT7uclUv0Pm+BewSuc/nBOGWZzNrlBAgl1o7+DFd58GqBfhjXZXSx2SMYBuVufYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725784394; c=relaxed/simple;
	bh=KRBSBkWnA5Oy7vKfkRLxp5pkNZEjHseXzliLTWr2IVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOKTpedAff4d9pg3TrmzZb3u7NkBZdY4Y3fwpBUWsDPLFgdza0GR3gQb8WNHJYB6Srm8PiokfDuJLH6nkZpm/BN+3xvPrLjCmC2bUCa7XIx/Dzk9u7CVeSoIPxB8Md1Y1W+W0ac8qBQwS9R0oTrTqHZELy8rzmveF9dH720Z3Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t/3ptwsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AA5C4CEC6;
	Sun,  8 Sep 2024 08:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725784394;
	bh=KRBSBkWnA5Oy7vKfkRLxp5pkNZEjHseXzliLTWr2IVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t/3ptwsSor/eQSQj/FpXX6lk5Bmrb94QrAtyn63/sohCOTahNtDmCfB5la1HODffD
	 qa0Hw6NmNTJcvw7HAgcmI2/brd6fO93ocr0nqBz749JbDTySkxDev5cZHWJEg6wq44
	 Gd2us+1/g57rrlZHzIvsTKk37PEbO622qHg/gRi0=
Date: Sun, 8 Sep 2024 10:33:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	stern@rowland.harvard.edu,
	syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] USB: usbtmc: prevent kernel-usb-infoleak
Message-ID: <2024090809-subdued-mystify-32b6@gregkh>
References: <2024090832-tabby-mom-e3d6@gregkh>
 <tencent_6C71E6C09363C370897103ADC45ED7743705@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_6C71E6C09363C370897103ADC45ED7743705@qq.com>

On Sun, Sep 08, 2024 at 04:16:39PM +0800, Edward Adam Davis wrote:
> On Sun, 8 Sep 2024 09:54:22 +0200, Greg KH wrote:
> > On Sun, Sep 08, 2024 at 03:35:49PM +0800, Edward Adam Davis wrote:
> > > On Sun, 8 Sep 2024 07:20:40 +0200, Greg KH wrote:
> > > > On Sun, Sep 08, 2024 at 10:20:57AM +0800, Edward Adam Davis wrote:
> > > > > The syzbot reported a kernel-usb-infoleak in usbtmc_write.
> > > > >
> > > > > The expression "aligned = (transfersize + (USBTMC_HEADER_SIZE + 3)) & ~3;"
> > > > > in usbtmcw_write() follows the following pattern:
> > > > >
> > > > > aligned = (1 + 12 + 3) & ~3 = 16   // 3 bytes have not been initialized
> > > > > aligned = (2 + 12 + 3) & ~3 = 16   // 2 bytes have not been initialized
> > > > > aligned = (3 + 12 + 3) & ~3 = 16   // 1 byte has not been initialized
> > > > > aligned = (4 + 12 + 3) & ~3 = 16   // All bytes have been initialized
> > > > > aligned = (5 + 12 + 3) & ~3 = 20   // 3 bytes have not been initialized
> > > > > aligned = (6 + 12 + 3) & ~3 = 20   // 2 bytes have not been initialized
> > > > > aligned = (7 + 12 + 3) & ~3 = 20   // 1 byte has not been initialized
> > > > > aligned = (8 + 12 + 3) & ~3 = 20   // All bytes have been initialized
> > > > > aligned = (9 + 12 + 3) & ~3 = 24
> > > > > ...
> > > > >
> > > > > Note: #define USBTMC_HEADER_SIZE      12
> > > > >
> > > > > This results in the buffer[USBTMC_SEAD_SIZE+transfersize] and its
> > > > > subsequent memory not being initialized.
> > > > >
> > > > > Fixes: 4ddc645f40e9 ("usb: usbtmc: Add ioctl for vendor specific write")
> > > > > Reported-and-tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
> > > > > Closes: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
> > > > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > > > ---
> > > > > V2 -> V3: Update condition and comments
> > > > >
> > > > >  drivers/usb/class/usbtmc.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
> > > > > index 6bd9fe565385..faf8c5508997 100644
> > > > > --- a/drivers/usb/class/usbtmc.c
> > > > > +++ b/drivers/usb/class/usbtmc.c
> > > > > @@ -1591,6 +1591,10 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
> > > > >  		goto exit;
> > > > >  	}
> > > > >
> > > > > +	if (USBTMC_HEADER_SIZE + transfersize < aligned)
> > > > > +		memset(&buffer[USBTMC_HEADER_SIZE + transfersize], 0,
> > > > > +			aligned - USBTMC_HEADER_SIZE - transfersize);
> > > >
> > > > As this is now a pain to read/understand, and there's no comment
> > > > describing it so we'll not really understand it in a few months, let
> > > > alone years, how about we just do the trivial thing and make the
> > > > allocation with kzalloc() to start with?  And put a comment there saying
> > > > why it's zeroed out.
> > > Perhaps I wrote too much in my comments, but in essence, the logic behind
> > > this version's fix is:
> > > When aligned is greater than (USBTMC_HEADER_SIZE+transfersize), there are
> > > (aligned - (USBTMC_HEADER_SIZE+transfersize) bytes after the header and data
> > > that have not been initialized, and these bytes are then set to 0.
> > > >
> > > > Sorry, I thought this was going to be a lot simpler based on your first
> > > > patch than this type of logic.
> > > As you mentioned in my first version patch, this approach is simple and
> > > easy to understand, but it comes at the cost of losing the real issue,
> > > and KMSAN will not find similar problems again in the future, which is
> > > not conducive to making the program logic more robust.
> > 
> > There will not be similar problems in the future as you are explicitly
> > setting everything to 0, so all should be fine :)
> > 
> > The real issue here is that the usbtmc logic of sending data is crazy,
> > and unique to it for various reasons that well all really don't
> > understand.  Given the very small number of these devices in the world,
> > it's probably best left to the maintainers of it to handle any real
> > problems going forward, and just squash these types of fuzzing bugs now
> > with a heavy hammer to make them happy.
> I reserve my opinion.
> 
> If you insist, you can use my first patch directly:
> https://lore.kernel.org/all/tencent_088B2EF2AEE00C8AE7D706CCD2CBC6484906@qq.com

No, that should be 'kzalloc()' instead of alocating and calling
memset(), to save us the round-trip of someone coming afterward and
cleaning up this common pattern to be a single call.

thanks,

greg k-h

