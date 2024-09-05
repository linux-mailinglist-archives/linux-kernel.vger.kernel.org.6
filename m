Return-Path: <linux-kernel+bounces-317253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 067AA96DB83
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A2228AECA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6E7433D8;
	Thu,  5 Sep 2024 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="yfSeVyQW"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70BFC0A;
	Thu,  5 Sep 2024 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545818; cv=none; b=sB0nHu7hOwk1czda0hrwLW4UNZyyIVD5CKJWO97FVSdt8e/6V0AnaXA2DG7ziYNkqXy1YJerEsTJofGtG8MPshcMC3rDiyCQMKtyUS1qRJralIWSuXey4T1SeDG5ElBOK8jZ6cs5EcjrQMBo5VH7OlchL6u4/Bu/j11rtcq15FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545818; c=relaxed/simple;
	bh=BmFUxc36gXnyRR1v9s19TeUHtlb9giQ1BkhVp4ilmb8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YwQDM2J2glY8Xgi17DOkfxY+gsZ+cnq81mzqHI9gb4AWyYOIDRCx4l0V/d0OxfUB24/grlCnV3dF3fUEsKnkmB3jY5vL3LNUZ19VOVy6TAie8IDB8nTFZ7zehHo+LbXC8oWVdacQ5VmFspvYsc7irMJQ9HYEAHYePag1ywIG8OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=yfSeVyQW; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725545811; bh=vUeEdzuJMCTavjl12SiZh7EdGYDTv0QOn3m3dBuR5kY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yfSeVyQWwn21XVBBQTcBFTqqXXGxGdqgyghstHHGfJV6O5WquqyHSIOBsw6Xg1hqv
	 +EBd5vvLkuVrUD1C7gTISTZaB7TJZaWrDCOs7VrmfrdYYijXQB0uUnINNbY1A+W90X
	 NMZ2AV3fsc1/KptmC6PGN2NSSN1/Q1EGKuhQN3qY=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 43082276; Thu, 05 Sep 2024 22:16:48 +0800
X-QQ-mid: xmsmtpt1725545808tlm9348a2
Message-ID: <tencent_E8A0E926ED22CE20783A6EC02FC56C18950A@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8tFugrFYQ+3VnwFJCNMOCZIf6fPV4+FpQKcmLD3VPZb9X/iZzZn
	 WKcx3MIhlv7s81qoAKj+6yaOdVt5TSh+D+pNtZDKJpGgqUGdVXmC9zX4LVGQA79G0O5/UKebfxIc
	 Dyj7IIwYPTE3qItZ6O6515UGBXBmd4dAP3AVhq3iUXd6n5Vsg6Z22dHE2AJuIlckSzOX5SJwIS5l
	 J6JP+yMPjZBTD1/7wAZOPUfRmze+PzHYztg6ZfBcdzh+RMYHX1h5zE0+5ZiiYSCY4MmlEI60Na/Z
	 K1CXPQqW7EnEBplL0+qKV0fa34D8WS+5neUcE+t0PlrCPDKS4J8VvivDKV1oxdWae2zut+6DZZH5
	 ilj4GNulVoN4q6Ou5Dp8S2eKd8Zi8/lMwQUchWt89GacZK8E4ulMcbLZ9DF4V7xLNJGhgA1NMlez
	 doNivezPi11gmippjmbbDs5iNftn7Rdu6VC7Ni0DLRtOzMQONO+7yBZmjYcUHJdTiUTOwMojMqmL
	 j8HXDQeBah55yb0wrGHuyXRCFM9L58la3iroYxuiKlujG9tNM5sy3zSq9owQ4GMugX7oVzwSSsWV
	 EOj5F/L/yiol1C3hRwp62g0OgxSVQe8u21LVSlDq63dc8zjVebqvwMHt6AIMCY0lYdQs6w8EV0PZ
	 JlNw2BHWc91JmJdMpaFUwKhpLbouhSmt76M6v75WkOCkd067ge28cUbv/WA3bZPMZZVxAxRcZwnL
	 UM+BoEn9Il0q3JiODdzRuy6wWo+XlnJ7ODx5ZqJwUKsETbeWE8816XeYZdZocC6E4FIZ3YmqSVvR
	 SquKBioAIteRLTjPEb9tZx/KDn2eJDUWxQBI7+pKtj3Cfz2M4fU6hANvpOeGbQaB6MZ50PgXHsdd
	 tgVietMiJXcKJ51IXNwYtreYUEENZm9ERw5OUj2KMbZj9xr3Hm0gjKPOpNx/umr1/R5MUl0TRK7h
	 ZrE5kHUWrjFcWDTlMbRxb20T0bzLKWEWWpXB/DweY=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: gregkh@linuxfoundation.org
Cc: eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] USB: usbtmc: prevent kernel-infoleak
Date: Thu,  5 Sep 2024 22:16:49 +0800
X-OQ-MSGID: <20240905141648.201312-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024090522-gauntlet-dropper-7590@gregkh>
References: <2024090522-gauntlet-dropper-7590@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 5 Sep 2024 16:04:31 +0200, Greg KH wrote:
> On Thu, Sep 05, 2024 at 09:56:53PM +0800, Edward Adam Davis wrote:
> > On Wed, 4 Sep 2024 16:13:03 +0200, Greg KH wrote:
> > > On Wed, Sep 04, 2024 at 04:09:15PM +0200, Greg KH wrote:
> > > > On Wed, Sep 04, 2024 at 09:55:43PM +0800, Edward Adam Davis wrote:
> > > > > The syzbot reported a kernel-usb-infoleak in usbtmc_write,
> > > > > we need to clear the structure before filling fields.
> > > >
> > > > Really?
> > > >
> > > >
> > > > >
> > > > > Fixes: 4ddc645f40e9 ("usb: usbtmc: Add ioctl for vendor specific write")
> > > > > Reported-and-tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
> > > > > Closes: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
> > > > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > > > ---
> > > > >  drivers/usb/class/usbtmc.c | 1 +
> > > > >  1 file changed, 1 insertion(+)
> > > > >
> > > > > diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
> > > > > index 6bd9fe565385..e9ddaa9b580d 100644
> > > > > --- a/drivers/usb/class/usbtmc.c
> > > > > +++ b/drivers/usb/class/usbtmc.c
> > > > > @@ -759,6 +759,7 @@ static struct urb *usbtmc_create_urb(void)
> > > > >  		usb_free_urb(urb);
> > > > >  		return NULL;
> > > > >  	}
> > > > > +	memset(dmabuf, 0, bufsize);
> > > >
> > > > To do this simpler, kzmalloc() above this would be nice.
> > > >
> > > > But, this feels odd, where is the data leaking from?  This is used for
> > > > both the read and write path, but where is the leak happening?  A short
> > > > read?  If so, we need to properly truncate the buffer being sent to
> > > > userspace and not send the unread data.  If a short write, that makes no
> > > > sense.
> > A short write.
> > >
> > > I looked at the report and this seems to be data sent to the device, so
> > > somehow we aren't setting the length to send to the device correctly.
> > The length of the data passed in by the user is 3 bytes, plus a TMC header
> > length of 12 bytes and an additional 3 bytes. The actual length of the
> > data sent to the device is 16 bytes((3 + 12 + 3)~3 = 16).
> >
> > Normally, when executing copy_from_user, the 3 bytes data passed in by
> > the user is written after the TMC header, which initializes the first 15
> > bytes of the 16 bytes. But it is not yet clear why the 15th byte is not
> > initialized. The kernel data leaked to user space reported by Syzbot
> > should be it.
> 
> But why are we sending 16 bytes to the device?  Is that the format of
> the message it expects?  If so, that's fine, just set that byte to 0.
Yes. I have set them to 0 before calling copy_from_user, and now still
running tests.
https://syzkaller.appspot.com/text?tag=Patch&x=14cb8f33980000
> 
> And as the device is the thing that is getting the kernel memory, that
> really isn't a big deal as we "trust" hardware once it is up and talking
> to the kernel.
:)

BR,
Edward


