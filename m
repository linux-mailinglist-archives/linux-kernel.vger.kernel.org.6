Return-Path: <linux-kernel+bounces-397383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B408E9BDB40
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611C328487E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB0A185B6E;
	Wed,  6 Nov 2024 01:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HEDAogc+"
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB73C3D66
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 01:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857045; cv=none; b=cfZ0cpv1nPZeplGJE8oc6DizBp9mcUpN207cKFr38blwXQF4O6tjrhlevJtRrDeibE/y5E8gLBQhPzkxm2I5mTRgmsRxvfI+ZdCkmaH26lLfHhf5Zsce/8vRMBKGXlcNa3MztGfXng2R0C3nL1midTAlAUBkLCVHD+AkP96UxaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857045; c=relaxed/simple;
	bh=vabt5aHJ2m/TaOaBaVsD8SEAA5FR/yue4kyc+PEzCZk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=RYYfpkWrMKvUn+YxslFxfYz/DURo7+34SyJgUELKu9NNwOqfhPPQPHyRAjNc4/NYIwF0hfMIUIb7T7KHNvwMfW7aN2II+4RnQK+0I09vRDySELJIMSHK45pbMpE9RuPHRlMJgbLEQP808n8gJDQTsDWCKf1FzCPlTl2hRIfut0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HEDAogc+; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730857037; bh=Q2Z8ohk0jiV8ER6ljZcNvDhwwSGVmcRI/ED6p+5Gvj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HEDAogc+jyDVaguvXpk3FTdk7D1OS+eAR010G/cbrZDpSyDu/3gEY6RIHp9Rhp3lp
	 VdnRlawX1ukBbIRVNaVk10XyAIrn4kgxOMeAmAQ9QvUQ6ctSbMomhgR37e9XUYUu77
	 umjjojX9kxp36TIIZrdwbMWOA5mZq8FkFRixTuYI=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 94FAF42D; Wed, 06 Nov 2024 09:37:15 +0800
X-QQ-mid: xmsmtpt1730857035tlx7pj5ud
Message-ID: <tencent_C01B2E4B191BB0251ABA8BBB47338C9E3508@qq.com>
X-QQ-XMAILINFO: MKNfDyfSZgoorU1mziw2SLvNE4Fg08aLM9k2QUAx5DAkg/1me66O9R4mZf0mok
	 7DO5IdYogTIDith8DNeFGyH6Uxj7oyF6IF0A/PpIEI6sQOxfIWKO9nRIUMzWF4ksF73Mnz35VW0W
	 LSwSBxmOp7p6PSCZO8m/ULZ27fySiaiezuCaNIiwQUFO2VTs0C7wZBwUPoagIp3b+5JWlKqyEzKb
	 AXRlS82/1tzbzqfXXZE8rJAVFP4N2xHyqw1SToFj93MOJP9lsH2fGhE0FwSIVvSTSGsrcs56eM+E
	 5GsDRVa2uh3x4yiW77e1XWi5HWZXNJX7+50p9P+vU6RQYrZCy2lXLVGm5mOVkCTu3s2x5Kk7jE03
	 QdVJAo/+rbu7JrCssn493BUXpDdmZkwT2V5QqMSCrSSosnR8+7diwIlifqnQw9yU/M11UhoM7nYy
	 2nJv8lzEClUDCBrfbMZplAGTv20Q79/iP6763WyIiq6SwwPQWZEH1qVzDB3AqpclsbkRF3EiBl8h
	 9XSzgR/WKGpvbgfdHz9Do6lC+6+ZcWTkjQBvnchBWayXppSCl4JjAupUSK9lIBUr3FpaR/8VbZ3P
	 dTQ0NjSng6xLnicgNAAMqLdJUdlPcadf7OyXcHPmdEmqOxTqkc5xE7tmunpkMmska7Q/1CLdmoS7
	 kIC5vm5EsIfDeDmIaCzUfdUp17yOJeUEEn1BVrLbMzhp7ZSUZYJ0fYAJyFPZ3HySWQxOp2q1pwjt
	 +gKztm981nfY8yNTrlr7R4oEernzWkUc25bHWMi6E2v0l4/oCLA20rkWr3nkNwecsJ6gec9aosEL
	 RESvZGjRKsW+joazlnhktlqIskld0z9xMZY0HO4j4lymxOGBg0qNSkRmbvQk1418mC0Mom4kHHSF
	 HzA1m1nApmDoTfpNNzoEmQsidqW1sfyQ==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+73582d08864d8268b6fd@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] INFO: task hung in snd_card_free
Date: Wed,  6 Nov 2024 09:37:16 +0800
X-OQ-MSGID: <20241106013715.2219896-2-eadavis@qq.com>
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

1. snd ctrl will add card_dev ref count and can't call close to dec it,
   it is waiting for 2 to release usb dev lock.

2. usb dev lock has been locked by hung task (here is usb_disconnect), it waiting 1
   to exit and release card_dev.

#syz test

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


