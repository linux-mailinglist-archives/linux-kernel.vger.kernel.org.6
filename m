Return-Path: <linux-kernel+bounces-198188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A3D8D74AB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 11:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0493282376
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CBE36AF5;
	Sun,  2 Jun 2024 09:50:52 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E49E29CFB
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717321852; cv=none; b=d7vEn1B5Hdg8t84uIWWu9Zxnhr7rgC/zvK6vTb+jINRxwfsk5uNNj58ot37kUNDHbDNTHVwKhJdl6w32x0c17GPA5AR7HoBnsth3bvBmGZxKLSQWl0yZEMwkUXE1AV9CypHdS5nyeYO0HbDCA2VHps5cdgYWjjaNha8j+20Gn7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717321852; c=relaxed/simple;
	bh=6Qk3EhFI6l02CTzu7dOTv1ZIxT/EvVODd1HgAUac3ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TuWiZ/rQNTQBdZXZcqwQKWMmhBi3AlckxZfH/tC7z3Xwj3UuewZgiVRsWaKWReLD9Tyg6YT2KelhuLBVPCUCq45tJL0n8LO/ulmHnY1nuOO9fXCPKoGApwk/FN9coj4tell4TgqnVOu2MxrqsY4l7uQRQYJlOBj6GmVJ/llQm8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.183])
	by sina.com (172.16.235.24) with ESMTP
	id 665C406A0000490E; Sun, 2 Jun 2024 17:50:36 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 53371945089237
X-SMAIL-UIID: C0900DA4704744BC98FB16A3F5398444-20240602-175036-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] BUG: corrupted list in gfs2_fill_super
Date: Sun,  2 Jun 2024 17:50:24 +0800
Message-Id: <20240602095024.3791-1-hdanton@sina.com>
In-Reply-To: <0000000000002501960619e2366b@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 01 Jun 2024 23:20:21 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    9d99040b1bc8 Add linux-next specific files for 20240529
> git tree:       linux-next
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100817e6980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  master

--- x/fs/gfs2/ops_fstype.c
+++ y/fs/gfs2/ops_fstype.c
@@ -1137,6 +1137,7 @@ static int gfs2_fill_super(struct super_
 	struct gfs2_sbd *sdp;
 	struct gfs2_holder mount_gh;
 	int error;
+	int destroyed = 0;
 
 	sdp = init_sbd(sb);
 	if (!sdp) {
@@ -1301,6 +1302,7 @@ fail_locking:
 fail_lm:
 	complete_all(&sdp->sd_journal_ready);
 	gfs2_gl_hash_clear(sdp);
+	destroyed = 1;
 	gfs2_lm_unmount(sdp);
 fail_debug:
 	gfs2_delete_debugfs_file(sdp);
@@ -1308,7 +1310,8 @@ fail_debug:
 fail_delete_wq:
 	destroy_workqueue(sdp->sd_delete_wq);
 fail_glock_wq:
-	destroy_workqueue(sdp->sd_glock_wq);
+	if (!destroyed)
+		destroy_workqueue(sdp->sd_glock_wq);
 fail_free:
 	free_sbd(sdp);
 	sb->s_fs_info = NULL;
--

