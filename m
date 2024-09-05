Return-Path: <linux-kernel+bounces-317217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 421ED96DB09
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E06284ED0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985A719DF83;
	Thu,  5 Sep 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="EooB0z4b"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8392419D063;
	Thu,  5 Sep 2024 14:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545003; cv=none; b=a4wMRaYKxq4BujfMFkhbGRih+AnafO+PwWw4e8lC5Y8q3sRBuc8C6bKo5bTFaPZ83bULK/cdteGVI0x3ZmiIQINIscN9ypAWWNI7IMJ0Wb/YXWD8RTHS6dSh3BhzgasoZYTEM/JWIkA9GpoghL1AI/LB0j3fflmJ1dn0M6PCyfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545003; c=relaxed/simple;
	bh=2PIdgmYCTQhpB3buDWDS+H+ZtKRl7MiH0GDhZc1dNx4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Hq6RZkIcdJGcF9/+rYNjsl944Jn7dZ7b3jvmZsWmF7+IejxP+Gpny01tfG8BWfp4YPFyvAiuHJiphF7Y/5Cuby747JRZiQaCp84+DE3x7amuo6LxCVMmVbM/nxMx98+G8DkuB29dlqHDC46qsrTPdiV7/lJAquuC+1FF+bwgVLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=EooB0z4b; arc=none smtp.client-ip=43.163.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725544991; bh=XgohNXx97I0uptF7u5z6FP7cxt8HsRv5HFOo2nDId/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EooB0z4btVCd+UdkYFz+CojkMU+R57gdLgWF3BumFP+HPia81UY4EE4uy7BSWDHLC
	 5yolGZsW++MDrrHb2zMzHC9a41cMaH7aBvjzntHPSyH5TXmcg+K2PzVR4H5JGD6qEO
	 CHWAfoQTfhEPVK4B4rFtGf/IQ5+MGBky7tn9XqRI=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id E3528AA6; Thu, 05 Sep 2024 21:56:53 +0800
X-QQ-mid: xmsmtpt1725544613tl2cxml02
Message-ID: <tencent_70402C916F4897E0E81EEEEACE287B726D0A@qq.com>
X-QQ-XMAILINFO: NhpLzBn2I3XwL71riNAFusPou+gQw+nHNV+5xQ2bOcVVBDKi4GP9+pS4PxjMnb
	 pmy3XQgBqzjCJyIeP9gcXbUddXnTIGToWNoV8hbEsDkCvy7qTqsGyl67ygOJkrqGXXVvo+YFsRe3
	 X297PrYTAIQCTlq+nluuxxtzGcBu/ZTxJPNPcyX2910F91xg0lWnx8QglCYfoCzMUM2asGn3v2Kl
	 O58gZxOQX+ZB9cTJtIMj9MQj+Awmh8jSroLNEQBDAkH8h66I7PPYGuA9RX4zjFoSE1LGPvuMv2nw
	 3ScyV6MD8jMtCQFhCzT8IPGmefyOUTkoVAJyDQG/jp2LXIwQTYf2uw3zINmqN1GQdrk0LHa1XR4w
	 o+Njo7FdThg83C2WmNQiHk7ekJg2S/vrNZOeW9/JFKKiyg0B5ZSfjRKn6bhHI6ex3yuHTdK+PV5a
	 VlY6iogn2/6SmjjYfAcLf9i3QM/dmghpKAHWLFmJigeo/SVqg6mS3eZg3qk4782LXI0Q3bsOesG2
	 oPIFSs/zh9vnOkAKQN+pnv3NBtYcZq/iot4sXTPVxliuB34yTZQhNqHg0p1RmOcyv9CxUXOMor6z
	 nvLLzKsrHG7emEskvigWydjWXcVwfg4OA7iji/uuhsiZ6VQLqvFhhvV+DepEQZurJtdJ6GPTZR/Q
	 MjXJppo9a7dYckCiGCoPufiYy+w+pF0vjauuviPs5yOLrbQVLNNya8ZyxfBKfYuE9LRUkXYi4Zr9
	 4G0hkIPUl9Mxon1+H1b7QTH/NFG26pnmmqRdgpor5XIFVhs725I3YijJvXzN+VC6mAp5240ZBcCZ
	 lxtK8BL88cqIghTEKAaBTHMuU9pLSIuBpH9zBKNcteJqYN5ru5Jw2se3cGBP7dB5HcxffE+tj/HK
	 zZvB9e9XpHEQETWDq9xsvkFXkVG+fHeGUfkfE4cKwCpcOhtrzQLq5xDF3hS/fyykmLFiH5ZjGHuB
	 llEMq/vSp/f17qtjDOWZbNHjyh9pqZOKmflyBWwBM=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: gregkh@linuxfoundation.org
Cc: eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] USB: usbtmc: prevent kernel-infoleak
Date: Thu,  5 Sep 2024 21:56:53 +0800
X-OQ-MSGID: <20240905135652.179197-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024090427-trident-delegator-0781@gregkh>
References: <2024090427-trident-delegator-0781@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 4 Sep 2024 16:13:03 +0200, Greg KH wrote:
> On Wed, Sep 04, 2024 at 04:09:15PM +0200, Greg KH wrote:
> > On Wed, Sep 04, 2024 at 09:55:43PM +0800, Edward Adam Davis wrote:
> > > The syzbot reported a kernel-usb-infoleak in usbtmc_write,
> > > we need to clear the structure before filling fields.
> >
> > Really?
> >
> >
> > >
> > > Fixes: 4ddc645f40e9 ("usb: usbtmc: Add ioctl for vendor specific write")
> > > Reported-and-tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
> > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > ---
> > >  drivers/usb/class/usbtmc.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
> > > index 6bd9fe565385..e9ddaa9b580d 100644
> > > --- a/drivers/usb/class/usbtmc.c
> > > +++ b/drivers/usb/class/usbtmc.c
> > > @@ -759,6 +759,7 @@ static struct urb *usbtmc_create_urb(void)
> > >  		usb_free_urb(urb);
> > >  		return NULL;
> > >  	}
> > > +	memset(dmabuf, 0, bufsize);
> >
> > To do this simpler, kzmalloc() above this would be nice.
> >
> > But, this feels odd, where is the data leaking from?  This is used for
> > both the read and write path, but where is the leak happening?  A short
> > read?  If so, we need to properly truncate the buffer being sent to
> > userspace and not send the unread data.  If a short write, that makes no
> > sense.
A short write.
> 
> I looked at the report and this seems to be data sent to the device, so
> somehow we aren't setting the length to send to the device correctly.
The length of the data passed in by the user is 3 bytes, plus a TMC header
length of 12 bytes and an additional 3 bytes. The actual length of the
data sent to the device is 16 bytes((3 + 12 + 3)~3 = 16).

Normally, when executing copy_from_user, the 3 bytes data passed in by
the user is written after the TMC header, which initializes the first 15
bytes of the 16 bytes. But it is not yet clear why the 15th byte is not
initialized. The kernel data leaked to user space reported by Syzbot
should be it.

> 
> Good luck!

BR,
Edward


