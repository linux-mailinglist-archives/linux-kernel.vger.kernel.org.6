Return-Path: <linux-kernel+bounces-192331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134A68D1B9E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4354F1C21254
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0F616D335;
	Tue, 28 May 2024 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="cfWiiXfu"
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC5A7316E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900575; cv=none; b=sMvY1kleL9PQr0tR5d28/2IlvNJhdLe+xyLc1RlgYLpz9kE2FcOg/c0pC/QN0mFaZDrNopGs3Fy2cIAyCnxqwbsVI0IED/Tdx8qZdVcTbydW2l3o/JqYiOxWBaeaOYdIi0FaMbxGMw9g8BC9OwVpmoylGuCEqTOHdlbsPIKZa00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900575; c=relaxed/simple;
	bh=eskFZzuz0sBw+qow+jUURiVDJ/Ihsw3DjEQhU+Dwx+U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=XRKaHKUV8uY74Zy/dCCzElu8l3oy+8dg7ulfViyguvYMqlIj3bhSCPd2QK35QeiLivE4A9ZhLrJcJNCO+LTx2BfDJcmSAWTxqYrFwsuYwqDYKo8E6jNb1mmC2s4UhCt8i8g44vhrAxB9feAI9yyEbraaxtweYypspOmJ+3pNLEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=cfWiiXfu; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716900563; bh=4X+71YgTs5RtTppyyiiPJcwtubGMqCcsHi1CEdzzrf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cfWiiXfuJZrUG7kSjdNI6tDXqDVR/kbMP1ZqWHpZs0Qlvgu/RBAA8YSE+WYkPVDum
	 /LJ/vf691TPep20cXJ0JL3gi8UKvsF/XXkLru29jbY2wdqJ5x/2XRbr2PlSLq+UUQZ
	 iDVDGnVDVgzz63nsoYOvOfNVa9uoxj0AYmWWp2DE=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 734BD064; Tue, 28 May 2024 20:28:52 +0800
X-QQ-mid: xmsmtpt1716899332tz6r2oqqd
Message-ID: <tencent_9FA58DAAA5CF0D8B9250DDB2DDF4192FCF07@qq.com>
X-QQ-XMAILINFO: MmPNY57tR1Xn1VYbDdYGMPX+WEO97G8eisA7LlPfqrz6o2XabzF3LLjtA4cueX
	 Ruj8yLnj+hD5WrPYxdtbvR8FZ5GWGXe2D+13/qe6gd/jsOt3zKHV8G6SnnGKwQRaqno7JQlbnAIA
	 TA3//bFXYzkV2Tev8ToHGXMqPbrGvWaJtMyv5gh9hW79tlQxQr3hUWtCIqLS/8Z0X5DdN5fWHtsc
	 ObP+miZ1G5xVxzTVNANPYIVxsXqJHQpV+bmadvkwmg9o93zHbrxuEH0skcAcKlDcjmS1sWCt131p
	 A6xhzvz+qE6pY/DMBJsdw8TBeYTaQol1Ur25uo/5A0QVOTSF65VYFlPvZQ4hAex2hhrhXi/S7mYt
	 KFJ8e9Pn8a7MXDdEDmkO8uRIdHRdksHGjpzqf1bS9a7vXxjn+x4Ldwc5yVVx6JOgw37x+FYvKxo7
	 7TEpp5fxRi/JStwjtLyczhVdUuKTeTspKD30Vfav6Znbh+Zhc30IJ/sC6xj/ETSW6uPvPzlK3ZpC
	 Es9D13OSU1jB+UqXC26cjQPVevIO2xRyJdEde/yS82cwIFCjxOHHq41M/2EzIMz+9G37gL+lzCt9
	 Y/AU1f0+4n4Mp5kRVdN8r0lpAONy+74B3ogfYB/a+/lsYClF49mLmqqjsrduzu1i11k0gBpYNlja
	 J9JxuJqhyXkPD003jPZJYrk2nsw2vjBAGS2CClYKHSUjA6kFnpo55b9EH37FrUfPdQaXvpfyqhcY
	 4XuxkJH16C9onCNBGQc3A2PZVxzsTvWda8VcGPG8EWrqAhkvni9J49JpeLCFiUp4NfRgND7rs8kJ
	 aI4E1rtPPIijW8UtxQ4lcgkQkHVKhwrzUw2+DPAHWs+CfYM33FT/gUWiG+ev1SmCG6Pay7YyDo3w
	 RDwQkqB5uWDGfy+mkZcwFbYR+7O5Fj/kf8F0tZWSy7AoQSl0WAtZUg64CMIdczFtzUMUQIAHgPfo
	 ET4gcldK0=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+07762f019fd03d01f04c@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] KMSAN: uninit-value in asus_report_fixup
Date: Tue, 28 May 2024 20:28:53 +0800
X-OQ-MSGID: <20240528122852.1885479-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000915d550619389e8a@google.com>
References: <000000000000915d550619389e8a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uv asus_report_fixup

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 70ec81c2e2b4

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 02de2bf4f790..1a92392967fc 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1204,8 +1204,9 @@ static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	}
 
 	/* match many more n-key devices */
-	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD) {
-		for (int i = 0; i < *rsize + 1; i++) {
+	printk("rdesc: %c.%c.%c.%c.%c, %s\n", rdesc[0], rdesc[1], rdesc[2], rdesc[3], rdesc[4], __func__);
+	if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD && *rsize > 15) {
+		for (int i = 0; i < *rsize - 14; i++) {
 			/* offset to the count from 0x5a report part always 14 */
 			if (rdesc[i] == 0x85 && rdesc[i + 1] == 0x5a &&
 			    rdesc[i + 14] == 0x95 && rdesc[i + 15] == 0x05) {
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index a90ed2ceae84..9f0e09f667b1 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1029,7 +1029,7 @@ static int usbhid_parse(struct hid_device *hid)
 		return -EINVAL;
 	}
 
-	rdesc = kmalloc(rsize, GFP_KERNEL);
+	rdesc = kzalloc(rsize, GFP_KERNEL);
 	if (!rdesc)
 		return -ENOMEM;
 


