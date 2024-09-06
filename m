Return-Path: <linux-kernel+bounces-318999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F4896F65C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC04286A60
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2641D014A;
	Fri,  6 Sep 2024 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xrj/PiVX"
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F58C1CF7A8;
	Fri,  6 Sep 2024 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631870; cv=none; b=WaymvWh3Q7e1BM2YJegyT/WIpiYnpz8rzmxnFlIHFTrQn1YCGrh1HZrCWClKgNwBYdDrL86SdbqYvcFLpksOHOroPceSNJ2NpKiOxtpKcd1scbKoOU5elg7xO46v6A9kPINpi5X6NLRHuVnBnaCihSkpmqJz54n1FV9CFTCK9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631870; c=relaxed/simple;
	bh=c/t+G8YnmMiXwefYmFLh4cenVroWZGpo0bMweRzBv8U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=JAbHrDj9fTnWXmY5CakHNWk94f167McnwUYBsz9IEiTy5zbbFtlylscH2XAUF0BFziarHAN27nRfOpoqETs8P3jCfwX0/BWzt93W/KXXMTmMbQ1mzUJ6XxtBuyd9l5j/lxhbrFlD+kpv3tYKMwh2CJ4tN2c6Nixwu8TPiKsbZwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xrj/PiVX; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725631865; bh=5fYQjJJeIHbEi/MHYR9mQgsttlxdfBHHE0O6dknJ3Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xrj/PiVXTqidfmJh/BN7GzbmPcYVRueuuK7TD5CDoXYlGT/945RUKSazTb0m3fiA1
	 uP9HQqIlz1RnJ3IeDGTTuEbvgRJFkpk4duV3TO9a5BroqKVfkvd1ylmgRnZmGMB6Vz
	 UpkWDnH6z9ECkFxjAorBMyAkAKHg8wRTj2ThxYeI=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 2C2AAECF; Fri, 06 Sep 2024 22:11:02 +0800
X-QQ-mid: xmsmtpt1725631862tzhi2yfde
Message-ID: <tencent_5E4FB78DACA5F90D97926A5DBE5D96993007@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70Njpei0mZ6yEAAVkWoC/0dTLDvjX6vuKxIvWSRQE6FfcTMWjKxB
	 riWgL0TH7Jm1+RM2+7OXuBWUFEWHnw8KX+RGxjTS7VHsJeUZi2DzrzePQ9SQway7aX/Gg1YkD5l/
	 nxdMA+KuvpZ6CkBu+2RzQZMqjf/UJT3nFAIIZspGyLHG8VfikUaR6/amU6l2XkPSsfXTj7c+KDnF
	 Ipuhx4bi94ZYW7zPFcvsVPBx9YT9S+eTbTeXVoX8/1rL//uwTL1VgRTjnviehI5FW/r8eAU2kq4z
	 pkVywMQiVqzmVfmH7+ehyfmOZsCBrcX2P7rP/Rp8ucMepKAhPD8y3CdGjfJ4bAItiBnNd6KsNM+K
	 e3P2ZMakmu4p0Q4gRDbScsuTehlgiqqOu+0VqNW2ddOAlsBVxKq6sr0vuTc8QijYZo6hYTuD2dqa
	 Bf7hleegOgS5z4kqzEngLCnCxbu9669z3w9Gk54IDlKjE3u6Uwx6TAuaNdy5NA3yRUM3Na/0HGs7
	 P8MV5HlwMk8UkWhyFWt008JIMdl9/MmpNo48A8jwFfWDPq+M6fTntTMwVVMBbP35804egygS+BrH
	 Bdy3F2DzgZbplQPNSa5Qn4t6aeQSjmKzuZuP6zqf3pCOpDeoGi/6EUJ0w0Nm90Zdyksa6TdfKw2f
	 pho6HiALoqMJ4vcwxWEnSSw+uy4wKGBMf721njFXlF2VhT7O9+qeLdH+Y94LqUmQi8/aDYKOyYVY
	 R7Vvca4D4oSIgpktG8ZAj+ANHuALlikjsrMLP7q4yq1J8V95Ow2IE/9AD7fxUlLIYh4H9K6XGRO4
	 s5sEFIDrJ5rncjDjQ3pjw8x04avrZQFfB/LrABzxJgu9fWYfYD0Y+4O1N8y/sQ6V6VybIWbM29k/
	 js5mHlJMPLAf1m0McdaGswkfE9QK7hy3leDWn1VcaPsJ6zkh1Ixvphd8chKEQ94+l46frCLNQ9eT
	 gw3UzEbbU6fj3lagJdpO3XjDPcBQSpUepR0Z01usA=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V2] USB: usbtmc: prevent kernel-usb-infoleak
Date: Fri,  6 Sep 2024 22:11:03 +0800
X-OQ-MSGID: <20240906141102.358431-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <tencent_E8A0E926ED22CE20783A6EC02FC56C18950A@qq.com>
References: <tencent_E8A0E926ED22CE20783A6EC02FC56C18950A@qq.com>
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

The condition aligned < buflen is used to avoid out of bounds access to
the buffer[USBTMC_HEADER_SIZE + transfersize] when "transfersize = 
buflen - USBTMC_HEADER_SIZE".

Fixes: 4ddc645f40e9 ("usb: usbtmc: Add ioctl for vendor specific write")
Reported-and-tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/usb/class/usbtmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index 6bd9fe565385..faf8c5508997 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -1591,6 +1591,10 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
 		goto exit;
 	}
 
+	if (aligned < buflen && (transfersize % 4))
+		memset(&buffer[USBTMC_HEADER_SIZE + transfersize], 0,
+			aligned - USBTMC_HEADER_SIZE - transfersize);
+
 	dev_dbg(&data->intf->dev, "%s(size:%u align:%u)\n", __func__,
 		(unsigned int)transfersize, (unsigned int)aligned);
 
-- 
2.43.0


