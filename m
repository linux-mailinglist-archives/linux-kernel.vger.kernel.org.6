Return-Path: <linux-kernel+bounces-319989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C385C9704C7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 04:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 767B51F21FF0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 02:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065071C687;
	Sun,  8 Sep 2024 02:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="dWn5CaKJ"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F761C6A3;
	Sun,  8 Sep 2024 02:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725762439; cv=none; b=My2Rk5vfXlaSw1j1rWFRAw9fTiN6njylrg4y+MVrtm8duVfBje6rSot8lg4V7yRjnTOllqeHSeLwGFCFqZ3cRu26bvqVYKoLpP0H1QdRZV1BgxqBuOHeKIRLeZ/ni6WUOVqhg0b/0qXjNiWrx45EBLdc0AmM3BzF4QkkP+OBGzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725762439; c=relaxed/simple;
	bh=AR5x396hMeoSem05Pk2AvKmRJ6WuVPoQprpA1QtXPj4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qRRCdUzrXW4d315uapeyKiAw5y3DxH8RoqyXjTfg7TMoCn+Guhwe9nOiTxyw+TK37HUOnOCQI19NJ28T7ajGQCE7LeHKFm6L2TaZmuJDCnYoE6bP92lPdYBDUT/qelaaViW6yRx+TObVun4efrH1utmT+oQhhNJhVLGqqQI1ne0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=dWn5CaKJ; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725762428; bh=UudtNL88LUJ3NB8arAYr34hP2OIPJIAhi9QV+4JSPGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dWn5CaKJ6vXwXGxkWqX98nFa3qlhbhkomVGhP+D617fhnWbmVHyi+UDbR8QH1G5f2
	 VtEHC/PPukv9hFEAntQkghe6DOp8gvtyDrx7E3dSf2i2TCZ978PJVjZHeNnj1hn31h
	 qJoUkPzYjkKYNQRPtJZvOniwLWXz+mDaFlJR+nhw=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 53915208; Sun, 08 Sep 2024 10:20:57 +0800
X-QQ-mid: xmsmtpt1725762057tsgdbm3ks
Message-ID: <tencent_5F7E6CD82F3D6FB49414E9D6EC3ACCFC780A@qq.com>
X-QQ-XMAILINFO: MfTIjKnZiIhe9l50zj7PLAadxBLycdpkrfqd8JFMvsnwZlST30ze3ifXbumsKz
	 RbEiZ9MHIg18vHSapTnvOFazYfWxCliB4sNBbCZI2dBbd39LSsYzrKJB7AcERkWHKHjo6kPEOJX4
	 0ZWWuwVKr8VpihgZsegcRDFttNhjqwX5b+95y5IT9b43sp1HEFEHvtT+2aicDgHYqU5qC6gkCFKh
	 fsDi8Nt3EfkQiqQfBDWEiBhhyYWe6z/s03nrjnZDv9PYaHo8FI+e4EenB/PIyGArkA2S+v58HG33
	 Fj8LmUZG+GOED8s6MYTXy89da8wHovJWi0ecW8Fv+G0LXRKGa7RAX9sBJRotuyYaUxveJ6Yg9gbI
	 OQfNsCHCrsGt8grMPPaUk2MjS/8Joyazk3gR1YdGy+bjkrKEfJ3F17NvB1F0gi5Glpobe5M+cAP0
	 RVazcRSmU45EWO+ad20IYFxOFhh2y0TUQPSvHf4g9REo8b/TTw+jbiAerD0iSDX5A7N0RRO146Xj
	 Drz4T839hayCP+1VxReDTTSdvgbLkxJyTybll+hXQc4ra+SECoNQYJ/n8xikEWys2QGhbwzQ5Frw
	 pR6E5If/Y74dp6IHRkqrOnwhBLgvrL8wc/IjkvEyT5xjIyPTLiS/Ft3frDNGBlpZdqAngfRH/Spx
	 2/XNAB4eHHENl6iuGldyMibeh0P8bKkgsMzPF5Vz+jcUdTHtKRp5VSiSngT0wWpwMiI+j7G2lnaR
	 I2sXQEBPZRae8boEx8d8B/zoTtasd0uKqc/aP+LPezYweGkkLdzsYWRqcXRcW7Hqm0ehsWjmZdqN
	 WpOqNLewhtIU+UFuP9X+eqStXXtbAGeVx9CTqPolA3XHrAJ/LH45Fp+XpXSrS1EH6/oGVIlrFbW5
	 UQR2NRW7zufK+LoRvCJNGBihEKnIGn3YCqQYBurnkiS69gDPRm1JDoT9k4dmGCfEOMfi+vBJRPI7
	 hZ6ghN9RO+qCahtoP6deL3jrnABq9M
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: stern@rowland.harvard.edu
Cc: eadavis@qq.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V3] USB: usbtmc: prevent kernel-usb-infoleak
Date: Sun,  8 Sep 2024 10:20:57 +0800
X-OQ-MSGID: <20240908022056.1286558-2-eadavis@qq.com>
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

The syzbot reported a kernel-usb-infoleak in usbtmc_write.

The expression "aligned = (transfersize + (USBTMC_HEADER_SIZE + 3)) & ~3;"
in usbtmcw_write() follows the following pattern:

aligned = (1 + 12 + 3) & ~3 = 16   // 3 bytes have not been initialized
aligned = (2 + 12 + 3) & ~3 = 16   // 2 bytes have not been initialized
aligned = (3 + 12 + 3) & ~3 = 16   // 1 byte has not been initialized
aligned = (4 + 12 + 3) & ~3 = 16   // All bytes have been initialized
aligned = (5 + 12 + 3) & ~3 = 20   // 3 bytes have not been initialized
aligned = (6 + 12 + 3) & ~3 = 20   // 2 bytes have not been initialized
aligned = (7 + 12 + 3) & ~3 = 20   // 1 byte has not been initialized
aligned = (8 + 12 + 3) & ~3 = 20   // All bytes have been initialized
aligned = (9 + 12 + 3) & ~3 = 24
...

Note: #define USBTMC_HEADER_SIZE      12

This results in the buffer[USBTMC_SEAD_SIZE+transfersize] and its
subsequent memory not being initialized.

Fixes: 4ddc645f40e9 ("usb: usbtmc: Add ioctl for vendor specific write")
Reported-and-tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V2 -> V3: Update condition and comments

 drivers/usb/class/usbtmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 6bd9fe565385..faf8c5508997 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -1591,6 +1591,10 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
 		goto exit;
 	}
 
+	if (USBTMC_HEADER_SIZE + transfersize < aligned)
+		memset(&buffer[USBTMC_HEADER_SIZE + transfersize], 0,
+			aligned - USBTMC_HEADER_SIZE - transfersize);
+
 	dev_dbg(&data->intf->dev, "%s(size:%u align:%u)\n", __func__,
 		(unsigned int)transfersize, (unsigned int)aligned);
 
-- 
2.43.0


