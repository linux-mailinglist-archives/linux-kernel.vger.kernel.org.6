Return-Path: <linux-kernel+bounces-527771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948ECA40F46
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 15:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A949167340
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 14:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA92207E00;
	Sun, 23 Feb 2025 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="onCGxQtW"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37312AF04
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740321220; cv=none; b=cnNCAcO6J6WLjKx+LFsQ7JJktS1I5MXoOgFqeGipJyZnx8jBTDMklfdo7/BwVuCvGq6wpRgX7xDq/MRZjCsZ7pGRjO9ZqpGZcbnWC0QHUiw/7LpS/GojFj1jpAcP2HOEiQt8UyLWRSoviVu4w38jsmv6wbd/BefNhNA6PYWFnYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740321220; c=relaxed/simple;
	bh=4LYCqximZy+Pa6ZXAw6ugta2CFF5G4dzzhuMMfYA8uw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=izLyxZqsLUnUFNJPtaoHTwgwC4ZPYYuvSuLEl1akLsg73sNrR08mhSFLClaNzgc2bMAzDIW20+P6crd5w3Zlho7n1FxDKuwT05FReJrLQJs0Gj7iL2jaDk5C/YJOmWhlRH99AzK5OiYd5bucrW+IWJ+PsxRIZhwr+jwBop7mo8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=onCGxQtW; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1740321214; bh=4ehgIESXH6cBFpBIB2idD5osE/i2AyX+jsHczH7hll4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=onCGxQtWJmoEieQHTq57VUn7sAtuIspHnUUVwcNUUvakJgvr+Av5yaxAF/+R8F1ul
	 soLcDzwzOjFz2fajSHkbdSTT4W7ZHB/qjFFgJ4E/N5aBdXIpQc7jdJG28IGvj6nlnn
	 PMxeW3BGc978t2L3bvfzLiiQoWSWu1B0YW4rPLKI=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id 7D6270CB; Sun, 23 Feb 2025 22:31:22 +0800
X-QQ-mid: xmsmtpt1740321082tf3ppkaq6
Message-ID: <tencent_383767B76C06D3F379C37E296A63A0045205@qq.com>
X-QQ-XMAILINFO: Nr8YfRCXK4tZH5q/lpMLZoZz5DhyOn24j04komkTrESfIvnRmRoMx8pxNYwY1P
	 gB41Grknr0hP1RCqfsl7HhA58TCt6fo+x4ezWVuHStr3RYtHvvJ21vr/qnh3a8XRbIdXTtoc1Glu
	 g2LRZZXr99QoN1kV33M9ASvdLsI4avFYEC7TNGXc+/q0wJO7p7FpfBudDR2r4olD3sXxWdxJVlGC
	 0020nJzrAYHcM7Ou/2Mnn4dWf3NtejTnHlfgEI0tGIzmRLOMlWfYgjrlIBX68jpfktiy2SwIUSOs
	 i42YC2IBT7RmtXxwxbqOtICY6PB9xdz9ZnT7nHN3BkmADiskJG++JwIC8sh7rlFCaInoZYIWe0Je
	 rlTcol5jJOiqmvcany+y5081x0zyhjHPitjceTponyiie3pjI2Hn0mSG/Hz5aq62R4POocxRm0FU
	 t1K6nUgXqvNubj9vSZCLmNibqg0a8gA+MczEQtoFsxoA2O/4j+sZ/xpWW0RmT9c+aPMqxI7g5r03
	 s0IrINKPHiB7lwRupStjTsNZNa0AZ2XZgBkOJn5sILoe3pxHXU3/+Y+D4B1vo6dnJQANdr8BVMNe
	 m8FjliOFfYmu0AgUqdouOzjRWbZwND8VvsA0k0FWFhMAr3//lbZgq5q6tw4e41XBxqL8Iq4lNF3a
	 0yxzAfUPGPeaKBv4QcLeatzxOpDjrrWVW8ub6aQZcmliBXtJ00DVAtrNiFZ22vOdkrnC5XPsstTA
	 z7GqrGNRx7dtxSrsae9nGABxxuAx6XmUuLj84Qki903W4UxzEw4uEzWM/3/P4m0pp5sjhdbz3UQr
	 9n06+EiL0nZoxbJ/bTpdTpavFT4ogzqYHEvsFeP243MHJccg8lSUD4hyyJMKF58XQ+QEGsl8UXcd
	 8cPtuPlAje8CcjhhnC+WlnFJ5EmzcqVvwQOQR8dwT4VVJop1O9s/skyI1NQcG8twjTmJyGIN203i
	 Z/PmhMpgCGG3AjkkkfBkirdlqgXtm0Fqu2kA+bGdU=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
Date: Sun, 23 Feb 2025 22:31:22 +0800
X-OQ-MSGID: <20250223143121.558336-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67ba02e3.050a0220.14d86d.065b.GAE@google.com>
References: <67ba02e3.050a0220.14d86d.065b.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index c9e65e9088b3..cf7a74343454 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -596,6 +596,7 @@ static int steam_input_open(struct input_dev *dev)
 	unsigned long flags;
 	bool set_lizard_mode;
 
+	printk("steam: %p, %s\n", steam, __func__);
 	/*
 	 * Disabling lizard mode automatically is only done on the Steam
 	 * Controller. On the Steam Deck, this is toggled manually by holding
@@ -1086,6 +1087,10 @@ static void steam_work_unregister_cb(struct work_struct *work)
 	connected = steam->connected;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
+	printk("steam: %p, client_hdev: %p, opened: %d, connected: %d, %s\n", steam, steam->client_hdev, opened, connected, __func__);
+	if (!steam->client_hdev)
+		return;
+
 	if (connected) {
 		if (opened) {
 			steam_sensors_unregister(steam);
@@ -1153,11 +1158,10 @@ static void steam_client_ll_close(struct hid_device *hdev)
 	struct steam_device *steam = hdev->driver_data;
 
 	unsigned long flags;
-	bool connected;
 
 	spin_lock_irqsave(&steam->lock, flags);
-	steam->client_opened--;
-	connected = steam->connected && !steam->client_opened;
+	if (steam->client_opened > 0)
+		steam->client_opened--;
 	spin_unlock_irqrestore(&steam->lock, flags);
 
 	schedule_work(&steam->unregister_work);
@@ -1322,6 +1326,7 @@ static void steam_remove(struct hid_device *hdev)
 {
 	struct steam_device *steam = hid_get_drvdata(hdev);
 
+	printk("steam: %p, hid device is group steam %d, %s\n", steam, hdev->group == HID_GROUP_STEAM, __func__);
 	if (!steam || hdev->group == HID_GROUP_STEAM) {
 		hid_hw_stop(hdev);
 		return;


