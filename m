Return-Path: <linux-kernel+bounces-319976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9161697049B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 03:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D6BB21F98
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 01:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B1D8F77;
	Sun,  8 Sep 2024 01:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rLRv7+2a"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DA12F2C;
	Sun,  8 Sep 2024 01:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725758012; cv=none; b=e2YhaxM1xgD7lLhJh6CwPROFhkupUHkbUA0t4mL25pqslLHbO2uka76pG2NTwvJx4wBBrK9lfLY5bSeqUJkV48B1yuS7uySPZ8JK24LgGmPJnVMdDSgfP9ijZ5ObgxtI1HAS7xPZF8UFaBDxwvvf9qz9oiUwynduuG7SiPV+fK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725758012; c=relaxed/simple;
	bh=DgZcOvKPBSwAmip5A6MqupecVKvMA+n9ChhlUYhHyAw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=azzKznssmXuCLpBfU+4YUh1KrryPHki5wnvnWfymeWVzpoEQ4eFBo5OjgN65pvFIrGpZFV4MH9cBb7fEpu4GhIYt+yzxYvUMawJO/Bqi9v1/8Ro9mYjcoZn6D2hrEODUBs9vhay4trpH7wkk/NAU+VBKP0hYzkiCuWGdL1ryC1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rLRv7+2a; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725757999; bh=CeGEpHwJdC86LeRy+UEkWILLt2ZvLXUiEV0BNgHFh1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rLRv7+2aPWRvmhjojeBGFQU/9KZTjBGe8W/aqD2BQOf6QnWkBJsWOIyJlSLA0vHwg
	 6REiCP73ZlnS2xtOTOnDtRqqjYEjx3ry8CGYnjn8M42C32VsglElFuuSi9sJzGxq4Q
	 2w5d8u5zyAqZk+VNznHpOGSLNj+kIqtmC784LeGw=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id EEFA3C86; Sun, 08 Sep 2024 08:59:47 +0800
X-QQ-mid: xmsmtpt1725757187tbyju58h0
Message-ID: <tencent_13C00D8E12545D9DDDE1193ECFED8D83A507@qq.com>
X-QQ-XMAILINFO: MmPNY57tR1XnHqK/65UZE20DtdqLO2kMgSg9Zemp6CW/UNKeVsgTEU3tqnFiT7
	 arTzMw0B/K+TyFGthzvvLriKlcZRW+u9lAy+ou7mTyLQMOqiH5JQOFozQuOKB8+KeUqmWfeW+kPJ
	 vlgjL9qvVO5H/qxDc542DCvxA55CPjOkSJU9LLx8yP1QnVpWPEcMJu8keEwHKBiq6BUF+fktZH1z
	 t0rYIvKK/rC7Gx4S5J5gzzjJ0LPu1qdCiutoB5R89FrcXZ/Bn/eQbXz9aOAWVYgQ/EXYD8nzBWOH
	 3S0s8vBqAuuS87YrfF89pCNIqdA2n9Btz1VUIkoe1Nw9EOJcTGsyafVmEaSGrB4afcr3NOGiP2c+
	 +8f5KEd9G3Z1qlnIkEAo5XkF57TNcPLbjlMEq/f4y7vdTkd/lJK0OhEnEu2SzlWfpDtDnQFLDuNj
	 gNCuNqpJhHQu9LibTYa6GeC6NQF+pkrbc9EZqNCL4SIepkku13eWQMS6mnr3Ab3NXcz5oJ/3Rgah
	 mH/B49OI0wORzlWwa/ZGTdV8BUEglWVKhqzgKXAJnKNV/LChruBjKbUgAqa6HY4PM0qnMjiVC5BG
	 PAfHPLbbf1wPQKT6b5u742jDftoobkCU0nJyI505iCr6m+3DMI2T5kwiSlVPFe3KLP2jtYIRGfPp
	 U9rQN1zva1mID3EtaNrEBxmWUPfmdB2zrnLxsnhGtN0hW5EM+RbB3RcYEcXbLpsxHCHiTMYZQamW
	 iMy2afz3U7zlqGsGyGdiazDrQSpcXjO4MvoGxwA/HHT1refTMLw7A8Zo0RxdvLPSMupZb4ZK6zu9
	 RtDS2bKtI319uqsE9EVWYZggqyPeiHrW1YdJcr0Km3VmF5o40c6LYc7W4NYToDdcn2Vb5RxWfUgC
	 7DrhxVrfK7LoQvG/55WcL6PyL4QrHyB3Ci30mtiU0fzw9+L2PetP2IGGqmo8eBeDxx/hBNvvfNuV
	 fkzX6m2w56tP3JRbrNdw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: stern@rowland.harvard.edu
Cc: eadavis@qq.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] USB: usbtmc: prevent kernel-usb-infoleak
Date: Sun,  8 Sep 2024 08:59:48 +0800
X-OQ-MSGID: <20240908005947.1218188-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <608621b0-6a6b-46d3-bfa8-ff907fb83148@rowland.harvard.edu>
References: <608621b0-6a6b-46d3-bfa8-ff907fb83148@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 7 Sep 2024 10:45:52 -0400, Alan Stern wrote:
> On Sat, Sep 07, 2024 at 10:08:57AM +0800, Edward Adam Davis wrote:
> > On Fri, 6 Sep 2024 10:28:11 -0400, Alan Stern wrote:
> > > On Fri, Sep 06, 2024 at 10:11:03PM +0800, Edward Adam Davis wrote:
> > > > The syzbot reported a kernel-usb-infoleak in usbtmc_write.
> > > >
> > > > The expression "aligned = (transfersize + (USBTMC_HEADER_SIZE + 3)) & ~3;"
> > > > in usbtmcw_write() follows the following pattern:
> > > >
> > > > aligned = (1 + 12 + 3) & ~3 = 16   // 3 bytes have not been initialized
> > > > aligned = (2 + 12 + 3) & ~3 = 16   // 2 bytes have not been initialized
> > > > aligned = (3 + 12 + 3) & ~3 = 16   // 1 byte has not been initialized
> > > > aligned = (4 + 12 + 3) & ~3 = 16   // All bytes have been initialized
> > > > aligned = (5 + 12 + 3) & ~3 = 20   // 3 bytes have not been initialized
> > > > aligned = (6 + 12 + 3) & ~3 = 20   // 2 bytes have not been initialized
> > > > aligned = (7 + 12 + 3) & ~3 = 20   // 1 byte has not been initialized
> > > > aligned = (8 + 12 + 3) & ~3 = 20   // All bytes have been initialized
> > > > aligned = (9 + 12 + 3) & ~3 = 24
> > > > ...
> > >
> > > What is the purpose of aligned?  Why doesn't the driver simply use
> > > USBTMC_HEADER_SIZE + transfersize instead of rounding it up to a
> > > multiple of 4?
> > I just found out that the logic of aligned calculation is like this.
> > As for why it is calculated like this, perhaps Guido Kiener can provide
> > a clearer explanation.
> > It was introduced by commit 4d5e18d9ed93 ("usb: usbtmc: Optimize usbtmc_write").
> > >
> > > > Note: #define USBTMC_HEADER_SIZE      12
> > > >
> > > > This results in the buffer[USBTMC_SEAD_SIZE+transfersize] and its
> > > > subsequent memory not being initialized.
> > > >
> > > > The condition aligned < buflen is used to avoid out of bounds access to
> > > > the buffer[USBTMC_HEADER_SIZE + transfersize] when "transfersize =
> > > > buflen - USBTMC_HEADER_SIZE".
> > > >
> > > > Fixes: 4ddc645f40e9 ("usb: usbtmc: Add ioctl for vendor specific write")
> > > > Reported-and-tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
> > > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > > ---
> > > >  drivers/usb/class/usbtmc.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
> > > > index 6bd9fe565385..faf8c5508997 100644
> > > > --- a/drivers/usb/class/usbtmc.c
> > > > +++ b/drivers/usb/class/usbtmc.c
> > > > @@ -1591,6 +1591,10 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
> > > >  		goto exit;
> > > >  	}
> > > >
> > > > +	if (aligned < buflen && (transfersize % 4))
> > >
> > > Shouldn't this be
> > >
> > > 	if (USBTMC_HEADER_SIZE + transfersize < aligned)
> > Logically, it seems possible to write it this way.
> 
> In fact, what you wrote is wrong.  Consider the case where buflen is 32
> and transfersize is 17.  Then aligned = (12 + 17 + 3) & ~3 = 32, so your
> condition would fail to initialize the extra 3 bytes.
The buflen is equal to USBTMC_BUFSIZE and can not equal to any other value.
You can find it in usbtmc_create_urb() and usbtmc_write().

Note: #define USBTMC_BUFSIZE          (4096)

BR,
Edward


