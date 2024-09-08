Return-Path: <linux-kernel+bounces-320090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D48970609
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 11:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06EA1C20E26
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 09:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AAE146A96;
	Sun,  8 Sep 2024 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="RHRdMv3T"
Received: from out162-62-63-194.mail.qq.com (out162-62-63-194.mail.qq.com [162.62.63.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7F4503C;
	Sun,  8 Sep 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.63.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725787071; cv=none; b=cAyVJQHgvz6x06jS4Xs9CeBwa1eBbPRO08vOgAJRoLEiOQYKXFlNJiF3+NZPxje6gboJLTR5xwK6NJIrY5OorJ4quVR20gRdWGy5Jav47RENF+nPOOD8zNzolBF20ZtBFdMrgU9g57EIdHLjD2zarP9+wPmXLYdNYsyEdfREG50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725787071; c=relaxed/simple;
	bh=KNiAWgioIIbSFVYvb7drSuk15+yw2swoWPymYD/4JFE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=KTz1FH3/rYrxHsnEqcCFROQMH5w+L2BASr/4b07WoHCTURD4GuKJMfkOvh6yn1QnY8DvBvTwLuAWJ++FfkWw21LIe8s6J5kE+9xNoADlniM/b+RJlu/QUf3E/ricirULgDUYFAsdM93laM8c7F9AFaVjvtb00sNdy3Ne80JUnEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=RHRdMv3T; arc=none smtp.client-ip=162.62.63.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725787063; bh=y0p9JmcPRv/f6HrUX29PawNNh+68n+DScGdTHzfOYuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RHRdMv3TcJcwizOHfaKrR8bMBrYb7YwdBCsnzGQ3kBn9/945OyMcmrI6f4+9/zWxI
	 4DnijVU7uOtrVD61ufAsRXUuzc/5xnor8r+F0q7D4PaSZ3fCZKIYgGeg455+CubvIZ
	 IaXnu6vMGa4E3LnMcRIp3k1KnnHNNpcOPyHDv2II=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 468958AD; Sun, 08 Sep 2024 17:17:40 +0800
X-QQ-mid: xmsmtpt1725787060t8mxsp5y8
Message-ID: <tencent_9649AA6EC56EDECCA8A7D106C792D1C66B06@qq.com>
X-QQ-XMAILINFO: My/elTziho8N0LIPiBaRHpCnGGsmIsLyYzSTQLYPfwaNuhjrPbHcfCYBN2xhvx
	 vGvx0JVDwWXVf2Ywnm0N1yRppyBGE7k25/iqh/DFDMV7neWv0dvBMiYWA1UWC6TI9jn18rfNoJ29
	 DkqTESvc3/WvmHBiGX7X8IhmHT6x9ihrJAXHrhLsR2czeppOckIc/7JWuF+oc4irfYgK8Qp4SV2i
	 E6cLnJRfVV7BcETDj/EiyhnotjIW+NENWe1gIzni/MEi8fBMlgOcqtS0kZHluSSFNVwzapPZo59k
	 7lpgVpyk4hGoHNafTbQu68sLNXN3uzlq1FDRpXe0gDGyhTbpl7IJB5nDUb1yPX53Q+74O3BS38MJ
	 eZgJiAX9AelPK13efnGaFyw5X62eclJ9peW+ques8QpH4hbIWYNrE03SYq34ilA0k1212TUWwmDc
	 gjeKWyk3G1f8Yhz6ohHxoXQvgWZo4rXSc7XjM6g0t5RGe7Ch0ztoXA/Dqhxcg58Z9j68pr5fpAS9
	 xcmr2JbsxpNYRE8C1/K8Q3AbiTQhEavIJACfA6279ISmk6ri2o5bJLOxqghAGKACEVR4mEs9ccp9
	 WU4vTcftlZKFjiaBm4gGL1D6Tdk/H9f50k83J86r8j5yueQNpTb4TbAoNE/GdHFziWpNIQAPxtnU
	 v82pT05ujVFmG9O0KO08sQoSejOvTuGCR0ItuMSQt1GWU5pCUl4m/ACvpcxRuoBPlzDPsTc7KuGj
	 0ZeLimpi2QzT62ee5bFT101P3KVG68pWQT5OugDxNYuViclZ93ekXfjIzBR1EjtE+N7qf+LULOLu
	 hvDU/ju7InixdwE4dVyd9vlhg0RZ8vDC1j8s+eraVBGeE+7KzMuKtXpoek3vy0IVAowFyS3Lrg2k
	 DVUGHwogp1fX2BIxPKkRlTjVuf8iDbQhqzrygzqwRxR7gc4ansyeDdYOzbxbbxLFCOWUWs21EAHa
	 Ss1bUkj1tb4Azm/42ZOB9NAKg7SI0gDTGjxm2O265ne4eoiD0Jxe5NvfW4hSJ2IMy1gBqFdeo=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: gregkh@linuxfoundation.org
Cc: eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stern@rowland.harvard.edu,
	syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH v4] USB: usbtmc: prevent kernel-usb-infoleak
Date: Sun,  8 Sep 2024 17:17:41 +0800
X-OQ-MSGID: <20240908091740.1648566-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024090809-subdued-mystify-32b6@gregkh>
References: <2024090809-subdued-mystify-32b6@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The syzbot reported a kernel-usb-infoleak in usbtmc_write,
we need to clear the structure before filling fields.

Fixes: 4ddc645f40e9 ("usb: usbtmc: Add ioctl for vendor specific write")
Reported-and-tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V1 -> V2: Only clear uninitialized bytes after header and data
V2 -> V3: Update condition and comments
V3 -> V4: Use kzalloc to clear up dmabuf

 drivers/usb/class/usbtmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 619123e24c41..7866ea6dad37 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -754,7 +754,7 @@ static struct urb *usbtmc_create_urb(void)
 	if (!urb)
 		return NULL;
 
-	dmabuf = kmalloc(bufsize, GFP_KERNEL);
+	dmabuf = kzalloc(bufsize, GFP_KERNEL);
 	if (!dmabuf) {
 		usb_free_urb(urb);
 		return NULL;
-- 
2.43.0


