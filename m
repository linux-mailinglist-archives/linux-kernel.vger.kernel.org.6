Return-Path: <linux-kernel+bounces-396283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD3D9BCAC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C77A1C22391
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACE11D2B10;
	Tue,  5 Nov 2024 10:45:28 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8CD1D1F70
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803527; cv=none; b=ZIjMzk+Zmt6MbEg6FakUnDXh1Yyc6ZQGtyg17HkcLNZNsxXzSNbagtDH0tufV7IQXXUtf/GH53HlR/8moz9rz56i+lj7qOFFxG0qopT9qgOggkN+KWXd0FfLnnIOSuB5DFKH53wH5RtKsl6n1ZDstTq515lLZIfuaeTxh966130=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803527; c=relaxed/simple;
	bh=R9A04wzaaQwXo5YfAjibsXJyH/TfiaNMitqyREVWNKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RoNEQahytdEnh8zy5kaM+nmVuzsbAHDu3LPN1zdWUCyMzQCIIx/hGMhEzEuaZqm+7Djp6TQxahgpl5d6yfjSdoHmTk8jc+O09RGzgxiSCwRLJHAg1R67cuPQTawMDY/+hnKYKrHK77lM+7OVOMpiDzaSN3sCYd/bj3/JaSsYU80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.8.130])
	by sina.com (10.185.250.24) with ESMTP
	id 6729F735000075A9; Tue, 5 Nov 2024 18:45:12 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 78026310748368
X-SMAIL-UIID: 47A99A219640441793A369A08FF6E407-20241105-184512-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+949ae54e95a2fab4cbb4@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] possible deadlock in __submit_bio
Date: Tue,  5 Nov 2024 18:45:00 +0800
Message-Id: <20241105104500.3206-1-hdanton@sina.com>
In-Reply-To: <6727f6f0.050a0220.3c8d68.0aa9.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 03 Nov 2024 14:19:28 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    f9f24ca362a4 Add linux-next specific files for 20241031
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16749340580000

#syz test linux-nex f9f24ca362a4

--- x/block/blk.h
+++ y/block/blk.h
@@ -72,8 +72,6 @@ static inline int bio_queue_enter(struct
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 
 	if (blk_try_enter_queue(q, false)) {
-		rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
-		rwsem_release(&q->io_lockdep_map, _RET_IP_);
 		return 0;
 	}
 	return __bio_queue_enter(q, bio);
--- x/block/blk-core.c
+++ y/block/blk-core.c
@@ -358,8 +358,6 @@ int __bio_queue_enter(struct request_que
 			goto dead;
 	}
 
-	rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
-	rwsem_release(&q->io_lockdep_map, _RET_IP_);
 	return 0;
 dead:
 	bio_io_error(bio);
--

