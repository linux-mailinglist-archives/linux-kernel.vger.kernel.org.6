Return-Path: <linux-kernel+bounces-393637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B86D9BA37A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 02:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFBBCB21CBF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 01:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB99482EB;
	Sun,  3 Nov 2024 01:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SnW/tR4O"
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5505F27726
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 01:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730598238; cv=none; b=rgOnTEnZDQ1Big1FAk6TppgtkIP2fdecfhNUnaPF+Y+VlxBpfzcmq32l3gKcaH6uFXU0IzuSudswN+2oZAphzRzkYKaqKtO531GeiYIi8NVpo3i5hVY38ZsOMqIcFx91JZkOgv/ffRCXhbLScDAhH5mulur9rU8zwHZHys9Ay3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730598238; c=relaxed/simple;
	bh=k/R+0hlOXJ5kpDRsVzyVGT/r6feWmn46mDZ43f2JOxs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DvT1KMZg8cklYdwLLhVc78lSDdkhS/JMjDxFAedZrU8NkVBic2u8FQM/KXYjYbG1OrFXFtxiK4+6EsPdt4pD6VVBvGldQIFBj5RuIzqq+NP6Cv+c6Nj5T1pouvC+Q1xnXDSJ7gUQSj5udqQdtWeplSy1bJ/QVOtVAFoPaqXNpX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SnW/tR4O; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730598223; bh=00XoRYy0C2JASjj9sgc1nHE6fLwwBvCkvGjWWgHdHHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SnW/tR4ODsAmf6Nn9q56QG4gSZGSlUR0eVMhzkTM3Bt1zla1VQyZ67CotKA8hK5Tq
	 VzaxyPzfyMVXmeeVyLaJAH0UCe1scPGslVaXGgHxe3XvGDZANE16y/iQG7jRsUPUZM
	 p/LuJPThzQWLUPPqFdZ3F0tw14d0IqTDcTcQJm6g=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 960A0236; Sun, 03 Nov 2024 09:37:32 +0800
X-QQ-mid: xmsmtpt1730597852t3pchkdyo
Message-ID: <tencent_8D33119E281B5D4B6A1BAD2543BA98BBB808@qq.com>
X-QQ-XMAILINFO: N3l5ASPewLWqvQawp6YWevmrC4YnOYNJKZBPaNexf89S+K23TuZm8/rzMICZpK
	 ikAZ5ZnMYdnq++gOZXdqSKZUcIXcJ+LbWjJ2DT9C/TvpDuHRA6tjIt18j2rNjyvifBexwTzqBWAw
	 qMg/NWjl2sBXYRvwGcJKZ8SRtPCRtiGduGO8W3fZkg4osbD3vIk7yIi1HNjLiotX3H+FTM/hVnmy
	 oRqs9eHN5JNC5PXclgDhv42TeYATK3esdoZLZao31dY1I8NHdFIM4d0OIt5UMgXQH4i8MKTrUFLn
	 dUIRVESYq4C8OApLOlMsmROb7cYQfoY5cUoTwp365Am0fvV5PPSGyxu94NHQLiX+PGQyvvxkARUv
	 nvZ+cYwryWV6eK1mW6Sd3k/FtPFE6ouPxTDBcxzqobt8KtcPdstAWnK04W40lgXSo49gjoNf7zP2
	 NefFg13JwczuWIup6UDv7TkE5ddZ/VPnhZB5tCFc5+uSh21Lo9HKem/O11xVKLB1SZ8lRVrVaQCq
	 Wcpzb8oDRxWDzA99sGrYJgFmPqJl4wqruwu4jt2DXJCEYf4YrEdND3eDYyO3KxfNYwUtW1v52kmB
	 GXN019LFJ1ggyI2coMQ7U+FCb2GhN8brav/xAU4H6/XJm929DhbrhxUQd3/hJA9SPavmcWCl/YTx
	 izOTbZ0xESfG+HX3Ge23Ak/3yGV0nLK6guiGcdcEGLUsUZzlFctqkQFM3bdUFlGBZht3pSDADYWr
	 fDIaXhjP4zWDxPwlim+wZ7obJYpa9L/bQJDKJRiNofUmPp1bYkxU5lTGzBTAQhS2UX6aPtPebiiB
	 QERF6KfskSfcqbTuWigoAi+NqDI8d2Z5kPesu0jqSrnP74t9IOjmcMmHMhhkfwHgOS+fZlUhN4nl
	 pk5WJRCBr985bd1Ic6+266nwJJ1wwN03paD0Hk2f6I
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f51a2a34984e4d8888fd@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bfs?] general protection fault in bfs_get_block (3)
Date: Sun,  3 Nov 2024 09:37:33 +0800
X-OQ-MSGID: <20241103013732.566038-2-eadavis@qq.com>
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
index fa66a09e496a..d7a464eace81 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -40,6 +40,9 @@ static int bfs_move_block(unsigned long from, unsigned long to,
 	if (!bh)
 		return -EIO;
 	new = sb_getblk(sb, to);
+	if (!new)
+		return -ENOMEM;
+
 	memcpy(new->b_data, bh->b_data, bh->b_size);
 	mark_buffer_dirty(new);
 	bforget(bh);


