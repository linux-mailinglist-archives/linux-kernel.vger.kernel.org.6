Return-Path: <linux-kernel+bounces-319607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A484E96FF2D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 04:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0954EB24103
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 02:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A0517758;
	Sat,  7 Sep 2024 02:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jKoPCrmm"
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEC912B8B;
	Sat,  7 Sep 2024 02:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725675702; cv=none; b=btPEcD/fFJMurCqiW0xD7XjzBhaSTnW/WR7ton1c19k1M+Z+jUa3PsME1DWOeWvl9rbR81gGq1lYqoeJ+bBwnQRLWzfbHotRUmgbfAcxyjIGJMb+WY6PIQ93xn2DgJ2giNEuX6oXC6JGr3xfrbX5eJychfbv4X6kW39pkrqjBCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725675702; c=relaxed/simple;
	bh=KVcgGbe0Puvlh9uvndA1cO+hW+yn7BeykjWh4EST4VY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=VIvwA8NmnpSDSljqueQ+qvYdFolPSrralw5WODS3ApEMNiDxhyfjl0Y47qEUDSkAUztQwD8gwfaZxKB9huVXOPzNUBOiUEmMDJfERAclB6jLpGQYjWs/E0GCEkK0bONkL27djfFbrNyotQ5sHc0HGpN9Gs6XyjEA53aMos0lQDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jKoPCrmm; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725675696; bh=Cs/wCkkTNRrnDJRzRsiiPM+4JJOLnstAMMJ0VZ91F4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jKoPCrmmcBackERXWDPFQbiLoYtB0afP4gAniqU3l42cROsWImnjH9aa1pgKzZT5k
	 2D49uQddq9T6BLQ0iO2ZS63pG7hZRbhmiRiWwaffwY4o+qKBZpeXyIgXTestGWYJad
	 PQK1HOpF+NpOjSKM7su6R/gzrYseIVYKa0fWZWwU=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 2389A6BC; Sat, 07 Sep 2024 10:08:56 +0800
X-QQ-mid: xmsmtpt1725674936tu3i6opnr
Message-ID: <tencent_F437644B027489769D66E43D51361E965A09@qq.com>
X-QQ-XMAILINFO: MgQY1K25Ph0mgpImX9e1MHEKA5FoAxz0ZtgOTaMoTLFN4Tosn6+6jExf/HSbMC
	 cJboQiC/8v7SGzowUNNCQbpop3N9bkFY6nF88oDsytf6oUUEyeaoAbyh3TO4nORLTdAx4b5moQ4q
	 1YWjr0dzYRh9GfmS8HFlL6T9G+24t3zrI2oMFqAJpVy4QrHylKQC9HHISQ+mtXRRLx8a6TBsOtcy
	 a/2UuKH5BRenk9PREr/J8zmVVO8T81xEDtFr/815H217V6i3QfhLNRabkfuJK/5hDbP/hekT3WYn
	 rYlb5mRrMsvHPU2mq0VjgQ+ZDmXfNom8Nf6VZ6bdAsF0C2mVSYP2OxdUkyZtEFeAlcU6sCKXRU/M
	 HWNhHVtmn/Xsyj19lbiVmKOPpDy0lNbOXzrNdDSysmllJhLCWaUspJpFU1LSnnlkESMrQ0CqQnAq
	 guy50zBXyI07w2Ah7mK0aK6Gu3TUqiPnbENkKXLXdvWcjnaLITrIdmpa2YKUEwVolhvcwKs28aHW
	 qwar/r2zwAz+2+MyMsXOsVsWAnk1Sbwod3+yrzLBuNmQC8y5UlJcm/P/HUVcPdl1Dbkndqt8awZV
	 2l6+al2hZYIvj1SKcUn49CEycDPHSvA8GrQuCXXjL8oQlfonHDYrHIOVu6N3v2G4vAz6U9toqZOy
	 GyWrRMKfvtUaqhz6DXalgGNFpKkYg+DFtoy+92ZhksZQubY+PlS+uCY/bJd0i4VVdSYKkU7qkBT5
	 adXSd/afIJZMQnpMTMQRZ8Y03H0mtzerEx4jsL34i3PNeIN4JvGsTemhmOPHj1I7dkIWA7ezAsf7
	 oRfgdKjyYyYcrKwkMSxw0SwwgT6NfMeXL4a3YcdMpLPxUtEBFExDnHNe3nCs/hgXzimtyKUJBhx0
	 P9RSoBXCmwjyniS7kWi+GJUDLjpBFaGB+74kGoITG79t6cwLzg1TFTrJdLikqcxtTeacH2zPgSqy
	 w0356afhFJNh7lx4HwEDv+QFsjfB8J
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: stern@rowland.harvard.edu
Cc: eadavis@qq.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] USB: usbtmc: prevent kernel-usb-infoleak
Date: Sat,  7 Sep 2024 10:08:57 +0800
X-OQ-MSGID: <20240907020856.519704-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <25d5853a-7156-4892-a383-4547e9c95472@rowland.harvard.edu>
References: <25d5853a-7156-4892-a383-4547e9c95472@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 6 Sep 2024 10:28:11 -0400, Alan Stern wrote:
> On Fri, Sep 06, 2024 at 10:11:03PM +0800, Edward Adam Davis wrote:
> > The syzbot reported a kernel-usb-infoleak in usbtmc_write.
> > 
> > The expression "aligned = (transfersize + (USBTMC_HEADER_SIZE + 3)) & ~3;"
> > in usbtmcw_write() follows the following pattern:
> > 
> > aligned = (1 + 12 + 3) & ~3 = 16   // 3 bytes have not been initialized
> > aligned = (2 + 12 + 3) & ~3 = 16   // 2 bytes have not been initialized
> > aligned = (3 + 12 + 3) & ~3 = 16   // 1 byte has not been initialized
> > aligned = (4 + 12 + 3) & ~3 = 16   // All bytes have been initialized
> > aligned = (5 + 12 + 3) & ~3 = 20   // 3 bytes have not been initialized
> > aligned = (6 + 12 + 3) & ~3 = 20   // 2 bytes have not been initialized
> > aligned = (7 + 12 + 3) & ~3 = 20   // 1 byte has not been initialized
> > aligned = (8 + 12 + 3) & ~3 = 20   // All bytes have been initialized
> > aligned = (9 + 12 + 3) & ~3 = 24
> > ...
> 
> What is the purpose of aligned?  Why doesn't the driver simply use
> USBTMC_HEADER_SIZE + transfersize instead of rounding it up to a 
> multiple of 4?
I just found out that the logic of aligned calculation is like this. 
As for why it is calculated like this, perhaps Guido Kiener can provide
a clearer explanation.
It was introduced by commit 4d5e18d9ed93 ("usb: usbtmc: Optimize usbtmc_write").
> 
> > Note: #define USBTMC_HEADER_SIZE      12
> > 
> > This results in the buffer[USBTMC_SEAD_SIZE+transfersize] and its
> > subsequent memory not being initialized.
> > 
> > The condition aligned < buflen is used to avoid out of bounds access to
> > the buffer[USBTMC_HEADER_SIZE + transfersize] when "transfersize = 
> > buflen - USBTMC_HEADER_SIZE".
> > 
> > Fixes: 4ddc645f40e9 ("usb: usbtmc: Add ioctl for vendor specific write")
> > Reported-and-tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  drivers/usb/class/usbtmc.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
> > index 6bd9fe565385..faf8c5508997 100644
> > --- a/drivers/usb/class/usbtmc.c
> > +++ b/drivers/usb/class/usbtmc.c
> > @@ -1591,6 +1591,10 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
> >  		goto exit;
> >  	}
> >  
> > +	if (aligned < buflen && (transfersize % 4))
> 
> Shouldn't this be
> 
> 	if (USBTMC_HEADER_SIZE + transfersize < aligned)
Logically, it seems possible to write it this way.
> 
> ?
> 
> Alan Stern
> 
> > +		memset(&buffer[USBTMC_HEADER_SIZE + transfersize], 0,
> > +			aligned - USBTMC_HEADER_SIZE - transfersize);
> > +
> >  	dev_dbg(&data->intf->dev, "%s(size:%u align:%u)\n", __func__,
> >  		(unsigned int)transfersize, (unsigned int)aligned);

BR,
Edward


