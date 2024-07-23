Return-Path: <linux-kernel+bounces-260042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B9893A1F0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DAD2841BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB84E1509A9;
	Tue, 23 Jul 2024 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Oul8SF9y"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1BB8F70
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742648; cv=none; b=qEde4nVJw4/CgaFRstpYZnTHScKf6UXhLLDBLBFT9DWhTi0b+spWSMubK7HNH0gr/BP3mRua+RO+kmb2UtPOiiVzr4zQjMO6dLX1xlqNZeaWgHPment2KxINT4Ez0Fb9JTmXJfXFmwC6D87NvBbInlCgK1LNAoxRuY1saztt9DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742648; c=relaxed/simple;
	bh=tW6HsmQOjj7xPFL6XEyV/XE4WS5aT2bJPBoSRsPQ1xw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=QxoVnNTHbFn0MtL0excHh/Bnjzs8H/0Nd/mPloitmNphBQa8g1yL+RbXI+xRHOmp2dxjRAhp5Wmh8QDhN/aXbNjRNbHl3U/DP9I6RTS6bvsJ7PwgyP8yBEX1n8IKSWQlCLYPtsfxdP+iRSFd/Bn0kR81OenDF/RYjH+O/qYpJ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Oul8SF9y; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721742637; bh=gfegjeFnJsdVXr1kv41jgaCMDzrCuvT6UucD50J0yKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oul8SF9yFIZRPupqIW29IkTNk2eCI5hQSfszN/whRL9igegC1b5iALbAUN+lU5XmJ
	 rx0GLrRORkwZMaIUkdYryuQW8PftAagTScmZCWjsDYK9dvOiQSV7C/TBCjNBhOVv8z
	 Bc7K/KArHtkYALvQo0QWHAX+nUNcD55CVfLAvfSQ=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id B0A38E1C; Tue, 23 Jul 2024 21:44:10 +0800
X-QQ-mid: xmsmtpt1721742250toccw706f
Message-ID: <tencent_A688921FDD9E5D95993ACFF58D87259B0D07@qq.com>
X-QQ-XMAILINFO: MesT5uKpDagVV8yG3LJVEpP5hWMYZB1u239lEKc0U2cFrT5re3mp78cWO4k8is
	 i7FvAlGUTrXM26E96fTcGZVjJ5eXdkwfVwg3A9paiPPIz+p2Ki7Fr1Z8NHb5eYl8CSHWJPq+/sJP
	 xDqBa9fYBji2Lk1KHIw5o8UBhcyJbhFgStaL15gDQK1ixPQ9vKc86WTJckM0SMVf8SBeKoDVsiMt
	 uQlKZMnsXmJMdsH/hGtVbTXjaPjhjAeoGJCyXcE+tEdiXmT31tviwAJHVNiRjA6ebMgIkX45BSqh
	 PfYyOyuzlMJeVXcrCTmr5t0EFU7qSqVIjXAt93AB/Gnsz4/d8eunRGIR8WQThDczFtato0zXOrMN
	 osIZsaehsTV7EdIDwojUOhd0tegmzB4TBHEsZsP6PeirT4a1Ckkz9W6GEdZSzmkhPyydOt+RCHPm
	 uW1aD9mhJM2PZ6+ChLKBMpxl0KM/6co1wfui5zkjGc7aMZJYceQ7BYOVpNMK1WoMGduojEtDApeo
	 xZ7qARoPCg6dCN9vNOs1xiaTI5GhK3F0ZtFIcQLrkmqGNfVobUA0N1RKzykS8SHoge+kiexOWXIp
	 7mgv99rM/ecaKjHO6JwScok9Dr7uJjYinZRdVVrRSZ3SLXg2QZ2SMZD5ddM0EoOKUhn/jd+k56+X
	 COGlkp/8MS+Ls5LuJ48qPV3u4MaIXQe7FmUMHFHvluXKlIeRVXqAfmo8MzWP5CQhU4vCJFUEYdUr
	 /IZfeRZGCmhp3VwyIz8EUeCubk8M7tJfTRsZjnUnI8MXYnE40xRbA4PFseVGS1iBYA1iZ22YMFcL
	 d9LarRKRUs9hMv462bWv/gdFR0GAAbz8YS9aWwzlU6sxEcgcFjnq16wNRdyNbpaFKgMeGttRWPzK
	 ni9QSewLrVUTkhwomWF+he/oB0fWnrovncDeqPChqHfme+92aD90E=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+784d0a1246a539975f05@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rcu?] WARNING in rcu_note_context_switch (2)
Date: Tue, 23 Jul 2024 21:44:10 +0800
X-OQ-MSGID: <20240723134409.925075-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000d0e3b5061dc16993@google.com>
References: <000000000000d0e3b5061dc16993@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

miss rcu read unlock

#syz test: upstream 51835949dda3

diff --git a/fs/nsfs.c b/fs/nsfs.c
index a4a925dce331..e228d06f0949 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -188,8 +188,10 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 			tsk = find_task_by_vpid(arg);
 		else
 			tsk = find_task_by_pid_ns(arg, pid_ns);
-		if (!tsk)
+		if (!tsk) {
+			rcu_read_unlock();
 			break;
+		}
 
 		switch (ioctl) {
 		case NS_GET_PID_FROM_PIDNS:


