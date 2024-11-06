Return-Path: <linux-kernel+bounces-397525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDA29BDCFE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FF261C2318F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E472A19049B;
	Wed,  6 Nov 2024 02:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="dAKO0fq5"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF4C18FC84;
	Wed,  6 Nov 2024 02:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859735; cv=none; b=DYNOdsTscI4RGDDoHyzoaTVXHl+N3G++48WraQE13AaFOkilkYNIvbHeXzCel6dHIouqR1hayDDF1vHlGdZyhw9HTmfKQ8N1/mPY44o8Xy5qmdW6Y7pobzQstE/2W/rpJDAcu6/vjMpU7LxuBGb3PXWyAMkV7WLcEbXH7QqpRhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859735; c=relaxed/simple;
	bh=2qF+i2GBeBNPPdCfJiQ4Zadi5AbhdAUNHJJo39Uo7WA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Z9U39jACoIn4DE3iKZgvbNuduxxeQhe/VCS0qDsYfBDWD+5BSRzk1TQXfVMQvVvlWrO6VC76AMfCdVxcv65mnaNsI80kEQZaL8AatnNG4VMVXjAaXwHTJGpfikmoV0SjE3XhifwsQ2mcxgTgoSGL0+GO1lW/yrIl+dhUNLdyzXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=dAKO0fq5; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730859722; bh=cFaOscYleCwW/uQU8cfrJjLltdjwdkYacmXZzii6qV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dAKO0fq5DECQ7ryAMI9lFWAGuBz5qIK0MwPeHWerRIdeQhAQiUYpwxmtrse9xuZ96
	 eDyDlpIzhCrNNU0L1HmuGgpsOvCrdbyPdzKgbvTqDVIODrJPUrvCpDkUFrEb8Kp6CL
	 1qSE5bBOHsdhqppTbB4FyjQ/ILCv1U75YaN2mAt0=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 3F030E96; Wed, 06 Nov 2024 10:15:48 +0800
X-QQ-mid: xmsmtpt1730859348t2o10k8o3
Message-ID: <tencent_9E3DBD3732961C37FC4AEC74E3763367E209@qq.com>
X-QQ-XMAILINFO: M/M2SMd6THQPRu+ZY7h9Kqc1izHKLaZ+Hq7t0EUOH9huvykFx5MKg6kuUGmnpJ
	 bS44rKV2dpkRj5smGJchqTTnSDvGXlb0lcxh1+WoZIb9UClxl1S93A4aNN8gFPKIgsb49dhdM+6K
	 RHLQ6vW863sxOkwGw863HGOumvgRQ/zOOr6TeLkPbEhHXAGR1qWyKb4ctuF2vqz2j8/Bd4xfl77t
	 2Juzckm4mDPly9OKcwYIQzhFJTMG48VzwS06BsaA+DhdSwAJq5DWrqn29PC+tBQ7s+r7d0IFipV1
	 Vu+WI1r3atvFDJPiycqsfj94Ub1DoZbj7gPkMRnFHXvlz8ovMf9eLFFsw/ksLDAApdlnUS7XFBzt
	 Q6oGNwmu3VyyEeSx6V5qEk9rw14CdU/duFjCtm1jM9IaiuUeim5QCly0+uKhM1HKQqxlcuWgdauu
	 jUkGDwrjmACuGkOZnHHrPrzmjBBQKVyVXDM3yE1/eUN8QLIqW/joackpLWdVBp/m/VY7pE7namjh
	 XdBHQ5IcYQyWCSriHQ4W622vHvM2e5HtPmxByui8WG8Yo1qZoOH5CWGjW+fNJFm7ql388McdR5ff
	 6Pk+X8dJ0brtdCSVFfun4dxAvw8fEGmD/toaYpBCaxDuCPwzAUJKV4zHlqz/wSD4Z6TL4d5Y0nbW
	 B+Yo9GWa6EZUMfliq/86JX34wLW9URzmgLn5PAwgo+f3OYUJQWRqgKNVSFfu4HvatHO99I96JBGN
	 vsFEeTvMROP0U3Fx5VDsoCTJGDx9Qg7iMFQdeVxVR/zckA/Ti2fOYOpLrLm5xb9mXQ1C6CFLqS5K
	 4tEBDQ7ZU5mUl5mxrZk8Zf0gc4RJppT6QtMo0j0r9vaUDvMfs5UgquiNNrbXevbTmclSZ4RR3Bbp
	 vgqFuC+Guc68PXlKkAutZDpYKi+n/Ft4AaMeNxKse8MN4p5Tzy1AFvd/Piwhi8Yi1m7LlcXKZBgR
	 5usanpcpI=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: [PATCH] usb: fix a task hung in snd_card_free
Date: Wed,  6 Nov 2024 10:15:49 +0800
X-OQ-MSGID: <20241106021548.2253763-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <6726bf35.050a0220.35b515.018b.GAE@google.com>
References: <6726bf35.050a0220.35b515.018b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

task 1: snd ctrl will add card_dev ref count and can't call close to dec it,
        it is blocked waiting for task 2 to release the USB dev lock.

task 2: usb dev lock has been locked by hung task (here is usb_disconnect),
        it is hung waiting for task 1 to exit and release card_dev.

Adjust the USB lock acquisition method to non-blocking in ioctl to avoid
hang when the USB connection is closed.

Reported-and-tested-by: syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=73582d08864d8268b6fd
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/usb/core/devio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 3beb6a862e80..dd037dc4cb37 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -2605,7 +2605,8 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 	if (!(file->f_mode & FMODE_WRITE))
 		return -EPERM;
 
-	usb_lock_device(dev);
+	if (!usb_trylock_device(dev))
+		return -EBUSY;
 
 	/* Reap operations are allowed even after disconnection */
 	switch (cmd) {
-- 
2.43.0


