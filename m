Return-Path: <linux-kernel+bounces-393827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 952249BA5E1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 15:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54B3281802
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 14:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F8D70809;
	Sun,  3 Nov 2024 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qRAZTgy8"
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28FA4120B
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730643219; cv=none; b=L6EPvDdTURI3klt46I3YcIEfaYcRZPj5DVRCAkhZ4HIAwaTEyxTYTmBZX4Cwb1U9hjvBiuSmdvHkCh2rLQf+lJ1N8Ay9etdmR0+hCQT4OZwk43y6t0eJkC86A2tcLA6gA2rBJBdD3OWD8QkOwAWqTDNAEvp/rzp1fbgfNU9/QdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730643219; c=relaxed/simple;
	bh=H45fMlO7DahjMIogpImrZgTf1xLowFN/sJcfFDHtaQc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=o5fp7WfkGo+J1rOOhzbo3PfxXOGdKBoO0uF0tCO/INAxjL6I/HBgYcpm85Vqoq/eKWzaWpLAZs51CThV2oMFgbqJ4DDyXRh7uW8JSf45awT3nUeD9f2gYbqmOiAvdwxTUSCtlrPTyk7dwDRzxcKvqiOR/l3r/YKR1AGkmCuE3Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qRAZTgy8; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730642904; bh=n4A3h6E6YDMA82yUeFYacP+nJcNixG1/44TN/dCmi58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qRAZTgy8Z9aWnXdSBwdV/MqhRgv+kFxHt+FgGo02x2FZnOLbaEMz17W6ReMWCzRqt
	 C7MbniiXO3zMnL5Ngzo/q4ThRx2oPjjfSaTKZtn3Qy5HBkr+Lvplo64NzxixH8AooO
	 DXIWjh9o/I62qu2TC9i58OnnI8mcVg5AjVKKtDRA=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id 21701208; Sun, 03 Nov 2024 22:08:23 +0800
X-QQ-mid: xmsmtpt1730642903tyknyl1q5
Message-ID: <tencent_A5864B09B4AED4AEEE8CB467D086DB52F106@qq.com>
X-QQ-XMAILINFO: ORuEwgb9eurk0eN6cNqEMLCM+COkEumG13SDNGLYDxR4u3lPJyYGLZ0FNrgbKN
	 WtrY5BDtVyQ5K75rAGDMOup17l54fZY/RQANCmS8Mqm11H3SVfYjtcooEhnfOjTj2UNGNJKazXvr
	 ajPJSYsMAgiR7GH3RCK7yzRKs2yT769XTedJtE5ZyTm2R1ttS8L/EEoYDRblwrmmkiUUXvnpsR3n
	 mpAqmtRKi2uiWzodP2jPI/kzsQW1pB/JVExybmFqPIF5LVx9VhoAiBZeDP2kbhvaCexUSPiMh460
	 imXDMjW3plNzSiHhLXKev5xp3zCgU6dUHaX3wS6KN2hE1Apa4p7//6J4pZT6WswEa5EqWmJA21v2
	 cqOVkVQS1OIlUJQKlD4gWvOsTPJJXIJVdsbmJntRMocqi6cdW4Kroks06vRtk+AeninL0MsJtg/l
	 AJXstQOytjsAvMWNY/qn05Uku7ALL623QrxxGNTYga5m5iwJrsGb4jVSpwh3eO14sITWbfUkRHuY
	 GlGF9Enlna+jdpqNug8mdn1AVN5ZIRjfW+wlLHgYJtW3E6++DEgJ/9ZN+INnunoGkn6myTCWoEON
	 lj6fW9K/cs5zP6zjGRwDIPloGpSALAlCej4Hefl32DQoCGdWNh2pKL0z18ze47A8ZvYLlj5Wn8r6
	 /FR9Yy7d0sUoMn3zy4VxSe+sI4G6Cd/DGqk9eFJhuCCMzRloBfNYdu5ROt5WgI4LcktNQKiSZ2xB
	 ZoBkbl4qifmwS0E5aZWo4dxdNkwakOPi1HR47yHisKb/u6PqQWAAUbr7w0Cx7eyDQWw5U+bT0CFN
	 W7dJb6x/O1Z//Gg1xpy9APWx4Kmw/dJN6iDuWRvg5vjbKU6A+hRwT9aHkaKSkU652AxxGQyrlq0K
	 vTLxR+CdJGjsDwnnrvFYYgpRdvuu8SdYxShK0InVt3gKBK/0x9iaH8NVDdjIm+LQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f51a2a34984e4d8888fd@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bfs?] general protection fault in bfs_get_block (3)
Date: Sun,  3 Nov 2024 22:08:23 +0800
X-OQ-MSGID: <20241103140822.1232652-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <67218131.050a0220.4735a.0265.GAE@google.com>
References: <67218131.050a0220.4735a.0265.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add a check for new bh 

#syz test

diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index fa66a09e496a..983cc191d1e3 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -35,16 +35,28 @@ static int bfs_move_block(unsigned long from, unsigned long to,
 					struct super_block *sb)
 {
 	struct buffer_head *bh, *new;
+	int err = 0;
 
 	bh = sb_bread(sb, from);
 	if (!bh)
 		return -EIO;
 	new = sb_getblk(sb, to);
+	if (!new) {
+		bforget(bh);
+		return -ENOMEM;
+	}
+
+	if (!buffer_uptodate(new)) {
+		err = -EIO;
+		goto out;
+	}
+
 	memcpy(new->b_data, bh->b_data, bh->b_size);
 	mark_buffer_dirty(new);
+out:
 	bforget(bh);
 	brelse(new);
-	return 0;
+	return err;
 }
 
 static int bfs_move_blocks(struct super_block *sb, unsigned long start,
-- 
2.43.0



