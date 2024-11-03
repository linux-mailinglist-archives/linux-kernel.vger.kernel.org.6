Return-Path: <linux-kernel+bounces-393832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 054399BA5FA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 15:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7871F2175C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 14:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9CF175D37;
	Sun,  3 Nov 2024 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ISwhzWij"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7173B33FE
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730644914; cv=none; b=iHKnJpQyf1A13lMGM3l6M1iSEXEf1azIHmXXtQwI/aJxACyDffTo/ibLfBFPqzS/ZiaEvqOrbHKPeuKJzqKhBQdii3itpR+qAgGax6hYaEF8Onp6I6UPR2LkJdcBgbXuoQRqhSq8YIPELOoon5rPJTfnGyN/56pYaVwWKXMXGe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730644914; c=relaxed/simple;
	bh=yiZ3U48fvMm+mbRRn94ICyazjR0Jt6iFhAqOYggot6I=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=mrzHT3upnVyHvbPgLHRjcUMi9OuRI9oyYjnr/tCXpgPbdytQUak5c7ngPyea7QxU3b+fSTD+d5JcjaqoEFvOTrKy+asYqopqnfvTdljPkEu9hUcoGzVfNAwjC6ZRycLzo+9rVuaFSqrqcJbsLtxP45BCQBwO70IFo1Qmp2AqGlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ISwhzWij; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730644601; bh=JygKIRRXTvpANN2AeH4F+3oGnhQ7OACWaQTyEfhPt2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ISwhzWij4+K9BS4EtN6REG/uzx7SoIP0p9HtlmeK4TcvGiGxLo7UfovMoBcSgzrAX
	 Pa1GWcbWwWCKrTjabm3Z9w5WSj0I3ohitVUtbaMO4fQZ7juE3QfxHvGmipxH3xsCym
	 1EHUT5pk27wyAjRlWyP4V2X+oyNYE6k7dZvktcqo=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 927B0EA1; Sun, 03 Nov 2024 22:36:39 +0800
X-QQ-mid: xmsmtpt1730644599ty2bccfva
Message-ID: <tencent_9D1D4FB28DB4A59E0DBD9245DD84DDDC9907@qq.com>
X-QQ-XMAILINFO: MFdGPHhuqhNoRvcSRagK6DgerqfnoLoJyTUKxph8xaOq7y5TEjnWOD83y+3wTA
	 r4N7EthBBO8gzbI4GAUlaaXX0uUE9AN+M6aPukwYTZO49iTjzdOaNOoQbPqgy2+jPedEWB8kBlPS
	 68KgCpfPuG+Oz5c++ZRIwrcfJf9kK6UBs1ngtKgiskPvYnkgJRaq6VrKs02qrDJwB33S89mmqH5p
	 bKA5gFZGo+8MavLhy41G3OCIM8rf0GdMwdFPuEfoQPVeIQvKmpE6CTt/5//2ZlBqHYr2mXBGzB1K
	 jH3noOY5o4Pis5g4HVhodM+aapEpqQ+m07EN1mhCdPI6Yu2MYFYMCHoP1RX3Y4BbLzE0+gVBtqef
	 kQpi9k8ac04YhP5fSYnPBc94ybDa4rqJ2Q1K8t2Sc22w+9c6HAqOwfLA3HEehT4aShL6++zkuvjk
	 ghVzkFAPQjdlIC/0uGO/Q13MQWUOHGDive7Rh4XFceeuUGrnSPQ4rJf9K5b1AXQXsaF0LfX0j+HN
	 8hapXRBrxOJPto3DvnPIr7A+id97REB4fIUNfwS+wquQo50aaL7koNn7lDCyCaz00SeY9L2dUli7
	 zhtE1SBSrr3rahh2RrTQ+FOS8XDAuu0OgMWfF+21FwGSl+t1IQRZdxCaIsdZt2jbJwIvny5/4R8V
	 HZspRu2Bg6CxEyhpO2Qqxh4WGePbmKwyJn8j31V77tZRIQh33AvpBlpaqc3fkkIkqpQ5PeN9w7pF
	 DGkJl3YLSnrc3xvuHxAeY5qG0m7GfYPFVS33749FTXqNGc71hqTBxVK1OZA9pHKrF+5V53FNe2xN
	 WCaZmwh9Q+jhaBvQqqB6emoA3avCVkG3jQPR7/rrgRAJYzGvY2Cg68IsAVT6OgaNsNysKGDWJgVK
	 eqyOAOY4yayw422fuPi07hS/fvSGXw7vtYJQ03H0oa8rpMLCkwzOaLwsj28POJug==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f51a2a34984e4d8888fd@syzkaller.appspotmail.com
Cc: aivazian.tigran@gmail.com,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] bfs: add check for return value of sb_getblk
Date: Sun,  3 Nov 2024 22:36:40 +0800
X-OQ-MSGID: <20241103143639.1260230-2-eadavis@qq.com>
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

Syzbot reported a null-ptr-deref in bfs_move_block.
sb_getblk() can fail, so need to check its return value.
If returned buffer head is not uptodate, it is considered corrupt.

Reported-and-tested-by: syzbot+f51a2a34984e4d8888fd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f51a2a34984e4d8888fd
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/bfs/file.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

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



