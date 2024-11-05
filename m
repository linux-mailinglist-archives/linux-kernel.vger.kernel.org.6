Return-Path: <linux-kernel+bounces-396344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380389BCBEF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BAD1C2280D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83ED1D4341;
	Tue,  5 Nov 2024 11:36:06 +0000 (UTC)
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BA61CC893
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730806566; cv=none; b=Lg9Lk2Pj0mJij0Mnn4pHlViiWx6rqQeGvDkOi0ROdIXQTiN5PdItUe6OEEO62FjB/N9UhaLPBH8vEwvPflsvLaSVxUO93HWaAerGg5AtcEeMQ2QC9Yk3oe3VpoOHi80SmGgl9ml+6Ulsq8hmcTeJ2tN+6JocIRTBIWNBFOoi66I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730806566; c=relaxed/simple;
	bh=JZ1gDqJm3eL7KeI/D94B5YqxVE6VrD5ULlYccrl7YPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UP9rU1cFqos6zE7CmQg1ULO4nQXgxGtsoI/QtQAzfCeFd8hcQ1Eubc7Df/OdgnUjS21LcIRCQ9lbw7RSowYFM1eOyr4tTQA0y60hnuI/xdF9GFT4/z0HUNthlKxIWMrFa4hBG2njXpgbvIBVHVtRWr8MxEsNyJ9H3ztI5REu4ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.8.130])
	by sina.com (10.185.250.21) with ESMTP
	id 672A030A0000110E; Tue, 5 Nov 2024 19:35:43 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3389153408354
X-SMAIL-UIID: BF37F4FD81654950AE1C4B9CAE9AE29F-20241105-193543-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+949ae54e95a2fab4cbb4@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] possible deadlock in __submit_bio
Date: Tue,  5 Nov 2024 19:35:29 +0800
Message-Id: <20241105113529.3257-1-hdanton@sina.com>
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  f9f24ca362a4

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

