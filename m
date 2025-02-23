Return-Path: <linux-kernel+bounces-527641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED3DA40DA0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 10:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FEE16DF39
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 09:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFEE201113;
	Sun, 23 Feb 2025 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HmEan4f6"
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28ED1A260
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740302890; cv=none; b=X32vjzp1T6Jq0FFV7TJxCssIz7T4thjofjqspgiqnum3eysI3jHJPON38hjaeVuYO/pUrcJVgYd4Oq2vWwU7V2k36duFCyWXwi0JEE11Gs9XzTji9LvN0lcoOTpayy0DJhHfaMgIuSBtKPOpz9MigNN9A03Juqyp5a4KsNp4juM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740302890; c=relaxed/simple;
	bh=oMAa2gMr18NbvAq6luKunKVGjxM77I4jtyAjHMiLXGQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Wx4FA1zCgVfm2bQ6LGJhOE3gjsKNOYkQAsy4wiI5/FTUIalZFyO+VY/WsnRgEaF/o7R73kV0aRUigLMsGRNrprCcUaTlNneCjWv5ns6XGd9cRWU52sJHYh3y+86MPHVGNfhnM16Cqpe/g29t4obt+FpSWa+U78z5NY4oznbDrYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HmEan4f6; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1740302576; bh=IhibKaVXbTmkqPD3DxqcyBe3pJ01X+Fs2z31lKrZStE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HmEan4f6+ibcjSJDgcEuS3/kbrU48BadbFyV8m+s3Jn6xAjvCD8DN0yj0Ai/jlGnj
	 26pwosoATSAUn13XRfnHeJwKxOb2VBB0Vv2i5T751AO5s6Ve+Xh+oCTGgL1NbXZlru
	 2TGY4WrGMBRPeGq9prUsk4qc489+UT6bdIAmTnqc=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id 5B635261; Sun, 23 Feb 2025 17:22:54 +0800
X-QQ-mid: xmsmtpt1740302574t0udy52c2
Message-ID: <tencent_2FD373236F497A83B5C45FB762F77786DC05@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2FvxosGU4uVX2h9Fs3+3DY5ae+azSmrSoL3wCyo6k8DU8i+A0zF
	 hiZJCKt2lSQ1vtvZFER5/pwCTEgUZOm1I3+6/lbikEA4IeIwwqDDWXeSbINRnx5hnq17bAEAPcQQ
	 grBuzkkkzm9KeIbW1mlhlsqUmjsuO3+nexX7pmpBCWoHdU8c5F3tYG+NqiQFPg6sn6Xj9G+wtbl6
	 RcmJNM6TnURXgHRHjbbRMeAzkNhX2I6FtInjk4D9JXEuQ6vOH/wZT4y/wEXnznNs0rAqVksKd4fh
	 zT3DuT78g2mTPEagIcGyZvpLb2ZUlkIIqs5eHZS98uT+jdnKfZ/jy9H6ei2Hmcv05UT7uYIf69RW
	 +lupiGUzmRxjb55UrUxUzr3Xn/VCm0TZSnR3xBzKM8LXJl/joh1xqsTQ+Y74ChdTSW9RKWluN3pd
	 I+0obxfL0/V+DGJoqRXWECgp33wftOq3bVo0BZiglbX0ktzCL767LwMV0pO/bmRReNsz0moeHqI1
	 BZsnblqaDd45w7ZK2zgonseBt9BHn87CFT5uIgcdiG+JQJhMnMAOGKybbKGFpbsvQfVQdzlCNhSY
	 4n5MhCQEupcXq3WBIclzhEUeS0Hn0JTUdxjyGHp8/vzVCBOc+2NAT2iCHjCYC+Hr/zC0cF8VqFrh
	 I44QrccIPKhOdGk/61Tp92WUtUBl2T29Nbmtbjsy4+eNq7QMCD7CdOasbr5rSUr3R8JNl/sZ+nGY
	 Iaz0LEj5AoTPmxPZYjbhJ9EO/JrxZllhVbWEyDci9yPzNTH+2HRO3n9CkNR+QwBTxVTmUJgaoE15
	 7+KJLVS9qSwgWERDqA95HSewwfb1vsmeNMpjsUbPoZKxwbNzm273HPqI/lbw/EBFL6w112ps8+Sp
	 g/mA1zKj+UyEXQGNUklPdwvUEzWiRgZef/3pDYKwn1JB3AdY1LeKE=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
Date: Sun, 23 Feb 2025 17:22:55 +0800
X-OQ-MSGID: <20250223092254.279678-2-eadavis@qq.com>
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

diff --git a/drivers/input/input.c b/drivers/input/input.c
index c9e3ac64bcd0..75d273630ce4 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -579,7 +579,7 @@ int input_open_device(struct input_handle *handle)
 	struct input_dev *dev = handle->dev;
 	int error;
 
-	scoped_cond_guard(mutex_intr, return -EINTR, &dev->mutex) {
+	scoped_cond_guard(mutex_intr, return -EINTR, &input_mutex) {
 		if (dev->going_away)
 			return -ENODEV;
 


