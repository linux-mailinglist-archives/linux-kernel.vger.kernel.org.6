Return-Path: <linux-kernel+bounces-382919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 268079B14E9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 06:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25C028306A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 04:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5BC13C80C;
	Sat, 26 Oct 2024 04:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GKbDnKTE"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C28460
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 04:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729918541; cv=none; b=iTyAmCZnIZ67q91Y8mAc7IuBnj9hFpfhlfsflzrKVX76sdCSQJvMaUuOq2ltoCHvcEijedSsJPG2pyF2zXf1/wUJ1xiiD3rK34SIkSaCrht+PJZV+q5Xjg5qVUGGx9Oa5Hr6bz3Un1MOUyR263b1XmmwtXUWrrDO0Bs+NTYQjPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729918541; c=relaxed/simple;
	bh=SH1PmUFkRextgM0k0nAEUaq1710c+wtNPrZe0xbcC0Q=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=K75alTk2pcJLRGnApfhk3mB/6g8RmZpjFNU1nBUNcLNN0Mdu7s0Q66sxtSbl9dvykzK7FrKK8pkmmFvShZlbw0WuidlRj91J/55+qnqqeCc5JXEUyGmqwIZbFW/vcoW8BP4MCnT/VoZnELHHbMA0wtX8bsDqmpgd3qpjmsnCsOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GKbDnKTE; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1729918233; bh=+kB3580t4aZtzCZjTlSDMOGN+I6kbMUGLo+4PwsopvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GKbDnKTEMkKpKPc2Dom+n/phf1ipGhijz+421fzzZaDCvugOIkf+WKbDhq8aNDz4V
	 40TBW2vAab+uKJu2w/PFbM6h6S5XdDXutXf4Al6JI/b4NuKWWFSQkwlP0+wBi//GSl
	 YA1afYJcPNtlqc2FaOhI7bTHSfx931zyJR7qCACQ=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
	id C9E8040D; Sat, 26 Oct 2024 12:50:30 +0800
X-QQ-mid: xmsmtpt1729918230tp1h395gf
Message-ID: <tencent_8AD1777367243C273694968636624A487409@qq.com>
X-QQ-XMAILINFO: NhpLzBn2I3XwSHfcxv1kEwRu/UT4x+7N89FajUh2Mx00fOxXfylVeBuGh2MqN6
	 YA3dL0COioYkmFGAbrRlacmoNp++gjc8mwB2EOjvdqQ6naaZx4zOBBipwtLD1tbVzBBXpoZ2XTBL
	 D5Bk/HjomGybTL6f2b5S883/nGvDVptXeLqlb/ONOSuMj+zyoCv6mv+6UXQzmq5yQfiGEJp1+Z+9
	 gZWuGvyqy8ZaQN64Ahk7hVLno/m47+ru8qVSeMpjMq5HHTXy9K2yGD5/qg0Uy021IJ3QwdenAl5W
	 +UxVkXOi+0f2laZsTiKm9PAI5KwMF/2blSxKxOXpMf+CeNkJVVbjQHH2pISxJyHhS5PheaenOF6h
	 4YfkhuW+MrsLzi29O2fOahZfmviWittq0SnuoiUW/yuLlYa8kqwJssv8JRKMS16G9+t4VGQsLARm
	 j6px/DM1KwoCeznnSoMPlyvMDsQevCROD0j87CXfPQeLjNzR1vidgqxtVcaZNgoBK7fBUK8jqOfS
	 WNPMch28Tx2u27rhhFkwNOMFQvsLtybE5bcVPse+yJVX1swTdpFVCSVHhPCm00PhOCwQQBKxNPoC
	 E2XPHq2AF2ebnmGVluFNl/ez2VDUsfqNVFKkMrdC6F/iy75bX1TBPrfFMiwiGvRN6Y8XQ5ny0XCx
	 lXoP985Xf+kZ8F9cyUTreo2CCmfwWjSVbko3pFzWADqS48FyrVPyci8KWdhB8daRQ51KzP7jGLoH
	 YlZm3jthbjvLKgmFGE1JM56rK7OTan6+SQyZdonZX7bauEJfAv1CP/caex5/kFkeZamnuTsDhJYo
	 pdjg9oFDowAQE6TzrMi6vGAomQ8OPKGSWr8aKDSGjn3D19MAERWvmpPgih2lZGjL7H6hRygtsHIx
	 Aexs4W3LMdhgycOzGWjOWX6mygTSLHob5JRSp7wBkLcYjTvXymExa6Fkgg4/h5JQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+820dc3b465c69f766a57@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in bch2_journal_reclaim_thread (2)
Date: Sat, 26 Oct 2024 12:50:31 +0800
X-OQ-MSGID: <20241026045030.790461-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <66f872a0.050a0220.4a974.000f.GAE@google.com>
References: <66f872a0.050a0220.4a974.000f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

avoid race conditions when journal's reclaim and flush acquire reclaim_lock

#syz test

diff --git a/fs/bcachefs/journal_reclaim.c b/fs/bcachefs/journal_reclaim.c
index ace291f175dd..58a745c72aac 100644
--- a/fs/bcachefs/journal_reclaim.c
+++ b/fs/bcachefs/journal_reclaim.c
@@ -731,7 +731,7 @@ static int bch2_journal_reclaim_thread(void *arg)
 
 	j->last_flushed = jiffies;
 
-	while (!ret && !kthread_should_stop()) {
+	while (!j->flush_in_progress && !ret && !kthread_should_stop()) {
 		bool kicked = j->reclaim_kicked;
 
 		j->reclaim_kicked = false;


