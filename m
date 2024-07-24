Return-Path: <linux-kernel+bounces-260650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF07093AC6A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 08:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A311B225EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 06:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675AC49622;
	Wed, 24 Jul 2024 06:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="R7O0kUVQ"
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF26A535A3;
	Wed, 24 Jul 2024 06:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721801125; cv=none; b=r2L6eSDAV1pDVz4U7dFED4KyB0fmxPO5GM/t+YN3evZgWmr7/56ZsgQ/6/ZAqPutIuJjNXDnL2nSUo5rd7o+lr/C2KuQmOGDrrnAG+kT0msqj1DoZCFRUbBTe5nIIyt19ZmJ12YFRJpjHcbwY9JGD+cB7MlUXZEib6p7Fp4uFZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721801125; c=relaxed/simple;
	bh=FbTT5VQ7RFZRhoZk1QUz96CANhgfKYhBvl45FNtMJBE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ZDOMAs91hEe444zNLpd+Bzh/0mPYkzd+3QRHw90/Sqm7wfcUkrTufQ7RbupOZh/sOxLKeIlvLPi3BIZmYSDBZAIDMMfoc4z8QpkJ4C9U+hM8wi56Ogotq7O1Q6Vf9TEfQdCjYN95RaKFmyKtBFZ24kZMCMF1WpoD6EIvztGuBgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=R7O0kUVQ; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721801119; bh=1RSHqUJ8TkszS0AbgUKN3N8zWa79Ibn+2Eb9XNn4CRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R7O0kUVQkOTkY+T9qQw1QejAvkCoQyGroUJx6R8z2YwS8qoH1kKgpEcgM1Z153CRm
	 m/yee+qtEK6Vl+AsHpUwmoU3ykzqzoe+vdzahhjNsQEdzk+HLcLp36jYWijqh27YOx
	 4vx2PRwU0oOpnoi1XFBYZdMiBOXyAlQsulVPWAUw=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id EAC81231; Wed, 24 Jul 2024 13:58:44 +0800
X-QQ-mid: xmsmtpt1721800724tfru4517l
Message-ID: <tencent_6ECFD36FE36EC96283A5C4587761F76F8605@qq.com>
X-QQ-XMAILINFO: MBjwNRQMz5zUrP9bRe4eogkJm3QJ025y1nm+TzdY0ETtFH/Pg8tIjAb1Fp3t3I
	 FtuFJ/VStqZYIVSROvkNCuEmEVXGKSa67r0Bv/Uf3nTfWbUuNSyGYK92kC4qf1G9f4MDRWIch7f3
	 qQyOBFFKwp6fOBmaxhCYane5PMqsZieRVZvHN4XvPiQGo95IB73fus5qMl5E5cUogIX38HsyAlrI
	 4NGhLqax+P4i27zueGnqt7rjv6q7GKxJVYZ1adJ+NxFAsvK8dvy4WNl9gnObjnSEOr9a73+Uo68O
	 4Ua9PT0JFbMO0ayMt0mlAzC5EjLZyrsnlaPlXeNHatQozYfcBjzL2NKrwp++5uWTsJZqsn/gGoK5
	 gwHIMGJv3BhpOoshP5YtOZn9pNfgt04Ez2vlgnklEMLFZ2Fo/EPjyyPBHxgolf+VvZYG/w/ELKGS
	 Vrd5azWq2zT8fMG9YGvhc+aNLfgPj82KVly+p/3d00t6HJEMwzXEum64i1cxtiGVQifhmmv9/qTN
	 V2Z987EREhuJetJMqQ82cXMzwh/OYm3g4dpZd434iRB9AYnkNP8mR25RMIE6x9+V722lhTlNvuUC
	 5HVwPf39703x3SIB0ef11JTqV5EQ8W3B5tk/eb2dphpFyxXLT4o1wwzCju+4nLooXK1gqAqzPWDR
	 aETKdqZFYPmVesJNd7uell5tjWFDJwPOTJ43qEvFhoVXf509HwuKH2AGOY48bxYEx4PAerySSbJ3
	 O0fFew0S+Rk6+rxa3iJf8gnbnktwY4R9CHmBk1CzOalLXaKAsocmzXg6HTllPyRwsP9N0w/nIXy6
	 bd4KeVdmRhsQxXu4tL0rNzr++39zA0Aa4ZFsFa/Rr/vu7PqeWP7mfK92RWRheY9U3sVCjIHNKx3u
	 tr2+klFWLy4uolKbtORUSZwqjHWf5u78sFaCw2nyU1gk+B3yDzlXmo3Yh/Zh1a9Q==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+78eccfb8b3c9a85fc6c5@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: [PATCH] ALSA: line6: init buf to zero
Date: Wed, 24 Jul 2024 13:58:45 +0800
X-OQ-MSGID: <20240724055844.1337846-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000000949c061df288c5@google.com>
References: <00000000000000949c061df288c5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot report KMSAN uninit-value warnings.
When alloc buffer for midi_buffer->buf, init mem to 0.

Reported-and-tested-by: syzbot+78eccfb8b3c9a85fc6c5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=78eccfb8b3c9a85fc6c5
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 sound/usb/line6/midibuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/line6/midibuf.c b/sound/usb/line6/midibuf.c
index e7f830f7526c..1b699cb3b38d 100644
--- a/sound/usb/line6/midibuf.c
+++ b/sound/usb/line6/midibuf.c
@@ -48,7 +48,7 @@ void line6_midibuf_reset(struct midi_buffer *this)
 
 int line6_midibuf_init(struct midi_buffer *this, int size, int split)
 {
-	this->buf = kmalloc(size, GFP_KERNEL);
+	this->buf = kzalloc(size, GFP_KERNEL);
 
 	if (this->buf == NULL)
 		return -ENOMEM;
-- 
2.43.0


