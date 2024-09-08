Return-Path: <linux-kernel+bounces-320062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3809705C3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727DE1F21D65
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FD6130AC8;
	Sun,  8 Sep 2024 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="o6vCzqqK"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B881D1CA81;
	Sun,  8 Sep 2024 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725783716; cv=none; b=TbJRIoW+Xyc4Q7IZF0Oaq/bYk2dpy5ShUV5a6J/APgqNKMxW4DjLhpKM/ac8RcOxuiu3BJw6eQa/Dnt7xrEKOLW/CyyAvPLqASMDQ0CBnWxdse4U/Fzx1bR7Go9rjhE09OGfQ19txvsu9glEKfNBy/o2AyPhcdUIv8aQRofkaH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725783716; c=relaxed/simple;
	bh=XpDvroTCD7M7t0/pWIpHFxvlLBovbtfrCd2SaWdEZAw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nkaFHJZtvTbRF0FdsqAEokhRV1sT5vYYzX0x6+J4XVjyT7slDUlkMO9bDEtYaTPIppR825upDCJlAHXFgiGFT585nSBqpKy0JINyViBZsEKFrq53z1DiePLd94JwpO7Uzic8mYJO/VKx8QO5+IY79oLx5JqYgM8kcXMahgwlKk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=o6vCzqqK; arc=none smtp.client-ip=43.163.128.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725783403; bh=MTFiqidyfyd1lVibjtfJKQcnAojxFXUIWUWS/TMg16E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o6vCzqqKVefhtrB5XfajCRxTTnU7LXg/56V15FCns2gma/JXGWcnYWruhZ0V222kW
	 IQTsJM35fHPZkBulAktOsgyUju/2Io717S7NL6VkzAuPkIcCdAHi4YBLjOLORoqiwA
	 8UaNF9KL3F6npDoNlHeaok14hGryZJF5cYvq8tZU=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 4281F460; Sun, 08 Sep 2024 16:16:40 +0800
X-QQ-mid: xmsmtpt1725783400th6vr957d
Message-ID: <tencent_6C71E6C09363C370897103ADC45ED7743705@qq.com>
X-QQ-XMAILINFO: MidKUt01ypo8g6gIhpBCHgnOUZDnCKXQPLjtbtXrhP+H1yQ6QxSBWoSbZjJdVJ
	 8BXGuTlj2QxKrm1sw/46XFhThkFbWP4ALD9ybnFBnauzOnq3IDaw8t387xH1JIDPh8W0a9y2Es2U
	 g2fvOukDmtRwvBhByjLg+MAu3WR4phqNQcqCXhsPmWsGgzFUgzSzNgIYYvzV78nEX3/uYKKs20pM
	 i5qce6mM9fniF8gZZHU2GSgdPYIoqsmXjkXzn9C5Q4rvWc6U0RIos2UNInOmH2/ecXsEqFuArcOs
	 /Ofasx/xyUvOmkwqElUMtvd6mtDcSNDBPXtWA4H5T1juacHXN/09WALevnCllfbsMJCPXUzuJVB1
	 CHEz4NRLAmCKtWunep9ddy7QYAtNq+Y3RLhomQq/ERSCPSgSsufaExiQogYJns4RCCc4DWcS2BL5
	 Ad/oG9MOyG78wN+NdPW6ViX7A31iig+eU0UV5aF6AjoJ6ItEnViAjH+ZWbo8vdHzGj3xjAj3bAs3
	 G8aiV/cc7CFVLkprjq/L1vSCGh+t/JyyR6hpngq40FB/btbtFb1pKGDq2c2ku5r5GKw46KqZvwp+
	 hSrd0O3gRS2Ebt7mys60UEN1bey0fP+rgWV79+BWzx2Pmfu/ukxrTWxiWI3845xPNDo3i0EoyLoi
	 qiPHQeelNTygab6aSLOsu322/mcttQLYfYtN5f61988uAnwnpiTRxTW0Zx9srdUu2bhJPycdimOf
	 e4jOjIaYV7vde+O5O9jBx+ZNJFrpAy8qm6BTDzCbhEBbwMcMToXLo9zdwzqgH/q/55MBu0E1s2PM
	 hZp+TutfpcPewQoojCjD3PNLhCz+jsQnj0eym9Z642iXADI9magQ8bWMe2tK0QjvxphnDvNs7+l+
	 ekPRSBNl3GXOJpr6AUkaWNcKChfqnI6TBwz6Ttnzsx/H9s8cZAwnUdnUJFlFN8dLqYPOTNNisXNd
	 ivs3beLwkDQ7P4ahLRVmtDJ7lk4eDG8CV39R6FeQCCPahZ3c16O+yA+cQjLIvPZ55ykhPZ1DK5Sb
	 a6E8EPZDtIKtdEMyYkqnHmsbgcJ7c=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: gregkh@linuxfoundation.org
Cc: eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stern@rowland.harvard.edu,
	syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] USB: usbtmc: prevent kernel-usb-infoleak
Date: Sun,  8 Sep 2024 16:16:39 +0800
X-OQ-MSGID: <20240908081638.1595458-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024090832-tabby-mom-e3d6@gregkh>
References: <2024090832-tabby-mom-e3d6@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 8 Sep 2024 09:54:22 +0200, Greg KH wrote:
> On Sun, Sep 08, 2024 at 03:35:49PM +0800, Edward Adam Davis wrote:
> > On Sun, 8 Sep 2024 07:20:40 +0200, Greg KH wrote:
> > > On Sun, Sep 08, 2024 at 10:20:57AM +0800, Edward Adam Davis wrote:
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
> > > >
> > > > Note: #define USBTMC_HEADER_SIZE      12
> > > >
> > > > This results in the buffer[USBTMC_SEAD_SIZE+transfersize] and its
> > > > subsequent memory not being initialized.
> > > >
> > > > Fixes: 4ddc645f40e9 ("usb: usbtmc: Add ioctl for vendor specific write")
> > > > Reported-and-tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
> > > > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > > > ---
> > > > V2 -> V3: Update condition and comments
> > > >
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
> > > > +	if (USBTMC_HEADER_SIZE + transfersize < aligned)
> > > > +		memset(&buffer[USBTMC_HEADER_SIZE + transfersize], 0,
> > > > +			aligned - USBTMC_HEADER_SIZE - transfersize);
> > >
> > > As this is now a pain to read/understand, and there's no comment
> > > describing it so we'll not really understand it in a few months, let
> > > alone years, how about we just do the trivial thing and make the
> > > allocation with kzalloc() to start with?  And put a comment there saying
> > > why it's zeroed out.
> > Perhaps I wrote too much in my comments, but in essence, the logic behind
> > this version's fix is:
> > When aligned is greater than (USBTMC_HEADER_SIZE+transfersize), there are
> > (aligned - (USBTMC_HEADER_SIZE+transfersize) bytes after the header and data
> > that have not been initialized, and these bytes are then set to 0.
> > >
> > > Sorry, I thought this was going to be a lot simpler based on your first
> > > patch than this type of logic.
> > As you mentioned in my first version patch, this approach is simple and
> > easy to understand, but it comes at the cost of losing the real issue,
> > and KMSAN will not find similar problems again in the future, which is
> > not conducive to making the program logic more robust.
> 
> There will not be similar problems in the future as you are explicitly
> setting everything to 0, so all should be fine :)
> 
> The real issue here is that the usbtmc logic of sending data is crazy,
> and unique to it for various reasons that well all really don't
> understand.  Given the very small number of these devices in the world,
> it's probably best left to the maintainers of it to handle any real
> problems going forward, and just squash these types of fuzzing bugs now
> with a heavy hammer to make them happy.
I reserve my opinion.

If you insist, you can use my first patch directly:
https://lore.kernel.org/all/tencent_088B2EF2AEE00C8AE7D706CCD2CBC6484906@qq.com

BR,
Edward


