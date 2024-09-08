Return-Path: <linux-kernel+bounces-319987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD2E9704C3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 04:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66D11F21FF2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 02:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9FD18E06;
	Sun,  8 Sep 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="umhyDdvQ"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA93125D5;
	Sun,  8 Sep 2024 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725762029; cv=none; b=MOr0jZFwzvd6Yh0AoLHw6nMF83CV0lU8BJuJSGC1l2f6utHsNBbhroPLk4trZPihPoD7NgGdSY4qzZ/fb0//DEYNdy2xvGgqTyucGDaRGj6d2XcMrtnGT47MZpPVDxeRxX2F1SCKigQ2IvPaCns/SbXBSWvC2cv7uErUqAMGLq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725762029; c=relaxed/simple;
	bh=J4qr3v2Mdzv92TMvuAm+dPU6VPF9uZeekbZg8Reul5M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DsPD+iVXLr8s3+Eu6hlKiXgS+y0gw7rxJCSse6ZmY3yUsXLbqMhTRgZGd8QenxsMB2gOhzYN9P450fpn7t0tE7rS2lhpdRcsLHlr+dVqWnLmTdoRaXF0zveI8rGS5eZp0xS/MTtZXjwi7j9XfueyLkQhqKJOK2LxrlXmgW8auHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=umhyDdvQ; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725762016; bh=TtuGWsCia5VjbyWal9ifCrOgyvpZ8zbv46wJgeyXfsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=umhyDdvQujuAVLdnzXwglIhfNL3BfyD5iNTqwxoOo1xIrrfSkmXibubRuSfDHlH/Q
	 9dEhvKRq7a5sW3PL72ujt08G3ABIKxwWG1fTCAb3e+F8BoXBHo3omyO79YO55qm52W
	 WvLlkDYKLub3VYdFSEOHyzZUHQJaRLMNN3Q5pMs4=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 7324659; Sun, 08 Sep 2024 10:01:51 +0800
X-QQ-mid: xmsmtpt1725760911t275vfi1c
Message-ID: <tencent_D062C96FE3AC045EF77E5779C6C4B36D4305@qq.com>
X-QQ-XMAILINFO: Nfm/+M6ONQ578eDlZc2q6l/1UWAX2b1l3B3HzWKV9CUNCdDXikv7CG8ztLNV6X
	 EtUvGeAig1enXu96QPWZVMJYmfQLV2D83j/5RsqgQmK1zzZjsRPhDvNCvf1gQtbv4YPtNgWORwJ0
	 Q28rd44sTRMPMQXaxJxxeqhYinlrsXITPqmoXENdJ3AL6/lwL6gIdCbhWkYNfTrZxG99t4ZnGlOs
	 oW1X5Sc+e1utskQ2R5Nifpm26CLL3siwL7lEcoCpyAldQzybyCG2yY/clcqWVLqH1lNXF+0CrPn1
	 gefH8Q/ZxWI17KasWvhGuhxxANFOxx/d3FZqeFJ3dD22oM9mcih3U3tFP5U/frPZgCqPcN0lGect
	 OMpagbiHzq5uGZLpPtm3QNgwbneR6lhFwH6jtB14gteX906939/qKV7s9wJswnFJB0lDbwjWyocL
	 pfWxXTYKM9yHFPWH/FUVzyLaf6miEf4D+xxg8t1sjEOlwEUtfAhaBVKR2riMItO0fqpwqq0FMjjC
	 rRuBUX5xA7l39Spyqpf6Z1jh1GPHM1qhvyXzcUo4V2ZDaFXKEo/T7Gmp4CF8PThnGnjdrv6xscNX
	 Hd29a1wwLdg+/n0taGFbmpd22WpNKXwfzOL02+cMED+qvsO8lYzx+30ckBFduyQH03xIBUwkMIkX
	 i3q7x8JYJdtNvwGENtUolXne7qu/bhFRGISCYJ8tsVHGQLAXBcAXAoWkUAkMrxuyBX3iZ1WbxjUQ
	 biwQ+hd1ZN64QBthOOYkf+Lu/O02NunKFU8paiKufJ9k2ZkgiTrMMFDpXABKgcu0VqA+NMJfPHUo
	 KSAFK3CH2n8neptTOQHTpnYAbHylgMGTyAL1RSb4WRC2/XnSGuz1eMx70YeX8Ffxv/VmjIXooizB
	 xrx6iLgy8yAQnn3yASOr6sYvgYP+hF9wfIDyF26xQapFx/vivT/d0TbLwakmmbFw+RG+tIO8zk6n
	 DlxfWFSw4s4fuEezJeyx0Ni4ZMr6zb
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: stern@rowland.harvard.edu
Cc: eadavis@qq.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] USB: usbtmc: prevent kernel-usb-infoleak
Date: Sun,  8 Sep 2024 10:01:52 +0800
X-OQ-MSGID: <20240908020151.1274323-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <3b4b8e7f-57b2-4ca1-8dc1-63faef573df3@rowland.harvard.edu>
References: <3b4b8e7f-57b2-4ca1-8dc1-63faef573df3@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 7 Sep 2024 21:32:28 -0400, Alan Stern wrote:
> On Sun, Sep 08, 2024 at 08:59:48AM +0800, Edward Adam Davis wrote:
> > On Sat, 7 Sep 2024 10:45:52 -0400, Alan Stern wrote:
> > > On Sat, Sep 07, 2024 at 10:08:57AM +0800, Edward Adam Davis wrote:
> > > > On Fri, 6 Sep 2024 10:28:11 -0400, Alan Stern wrote:
> > > > > On Fri, Sep 06, 2024 at 10:11:03PM +0800, Edward Adam Davis wrote:
> > > > > > The syzbot reported a kernel-usb-infoleak in usbtmc_write.
> > > > > >
> > > > > > The expression "aligned = (transfersize + (USBTMC_HEADER_SIZE + 3)) & ~3;"
> > > > > > in usbtmcw_write() follows the following pattern:
> > > > > >
> > > > > > aligned = (1 + 12 + 3) & ~3 = 16   // 3 bytes have not been initialized
> > > > > > aligned = (2 + 12 + 3) & ~3 = 16   // 2 bytes have not been initialized
> > > > > > aligned = (3 + 12 + 3) & ~3 = 16   // 1 byte has not been initialized
> > > > > > aligned = (4 + 12 + 3) & ~3 = 16   // All bytes have been initialized
> > > > > > aligned = (5 + 12 + 3) & ~3 = 20   // 3 bytes have not been initialized
> > > > > > aligned = (6 + 12 + 3) & ~3 = 20   // 2 bytes have not been initialized
> > > > > > aligned = (7 + 12 + 3) & ~3 = 20   // 1 byte has not been initialized
> > > > > > aligned = (8 + 12 + 3) & ~3 = 20   // All bytes have been initialized
> > > > > > aligned = (9 + 12 + 3) & ~3 = 24
> > > > > > ...
> > > > >
> > > > > What is the purpose of aligned?  Why doesn't the driver simply use
> > > > > USBTMC_HEADER_SIZE + transfersize instead of rounding it up to a
> > > > > multiple of 4?
> > > > I just found out that the logic of aligned calculation is like this.
> > > > As for why it is calculated like this, perhaps Guido Kiener can provide
> > > > a clearer explanation.
> > > > It was introduced by commit 4d5e18d9ed93 ("usb: usbtmc: Optimize usbtmc_write").
> > > > >
> > > > > > Note: #define USBTMC_HEADER_SIZE      12
> > > > > >
> > > > > > This results in the buffer[USBTMC_SEAD_SIZE+transfersize] and its
> > > > > > subsequent memory not being initialized.
> > > > > >
> > > > > > The condition aligned < buflen is used to avoid out of bounds access to
> > > > > > the buffer[USBTMC_HEADER_SIZE + transfersize] when "transfersize =
> > > > > > buflen - USBTMC_HEADER_SIZE".
> > > > > >
> > > > > > Fixes: 4ddc645f40e9 ("usb: usbtmc: Add ioctl for vendor specific write")
> > > > > > Reported-and-tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
> > > > > > Closes: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
> > > > > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > > > > ---
> > > > > >  drivers/usb/class/usbtmc.c | 4 ++++
> > > > > >  1 file changed, 4 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
> > > > > > index 6bd9fe565385..faf8c5508997 100644
> > > > > > --- a/drivers/usb/class/usbtmc.c
> > > > > > +++ b/drivers/usb/class/usbtmc.c
> > > > > > @@ -1591,6 +1591,10 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
> > > > > >  		goto exit;
> > > > > >  	}
> > > > > >
> > > > > > +	if (aligned < buflen && (transfersize % 4))
> > > > >
> > > > > Shouldn't this be
> > > > >
> > > > > 	if (USBTMC_HEADER_SIZE + transfersize < aligned)
> > > > Logically, it seems possible to write it this way.
> > >
> > > In fact, what you wrote is wrong.  Consider the case where buflen is 32
> > > and transfersize is 17.  Then aligned = (12 + 17 + 3) & ~3 = 32, so your
> > > condition would fail to initialize the extra 3 bytes.
> > The buflen is equal to USBTMC_BUFSIZE and can not equal to any other value.
> > You can find it in usbtmc_create_urb() and usbtmc_write().
> >
> > Note: #define USBTMC_BUFSIZE          (4096)
> 
> All right, so what happens if transfersize is 4081?  Then aligned will
> be equal to 4096, so your condition would fail to initialize the extra 3
> bytes.
Not bad, when the transfersize values are 4081, 4082, and 4083, the aligned
value is 4096, which will result in 1, 2, and 3 bytes not being initialized,
respectively. I will update my patch.

BR,
Edward


