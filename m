Return-Path: <linux-kernel+bounces-445773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB6A9F1B6D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC4216B21D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 00:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B30BBE4A;
	Sat, 14 Dec 2024 00:45:47 +0000 (UTC)
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDC92119
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 00:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137146; cv=none; b=fqCaE2mX2ni5ecBDqAgbMUE3PLpXThmf4PWsKKUzH8xHCPj7+kSCS/g0uuC+d+850Z5ldz8GBOwPNZd9mnmSwwgsuCdA9Gc09B0+lT8QqF5w10kk3NpybrV2KqoAORPVOEzWoiSnLEWnYRDdNLH06cq96jbY9YJwbmNrUoYI7Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137146; c=relaxed/simple;
	bh=+RBqWLVjtr1EEKGdz7+HwG1Ur6TrYF46EuT7DVK5CeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i2rHfsiilt1k80OUxHcNQu8vmLPyP+4qayFSrn/fyDhFBNtfr5uXuYM1R+eYihnRaxDmeMiD0pMlqztzF2qjSbqGrCCJN3Fj9O6A6NxH0hy/JlJxZCpazFnDqs22SBd+NDhUsrdIFne5XU7c1AgapbKRr5MXUVdxPSxZpE5oX3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.238])
	by sina.com (10.185.250.22) with ESMTP
	id 675CD50500005C80; Sat, 14 Dec 2024 08:44:56 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8472767602739
X-SMAIL-UIID: 839957029A68473EA4BF542F67B8F97D-20241214-084456-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4c7590f1cee06597e43a@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in folio_evictable (3)
Date: Sat, 14 Dec 2024 08:44:44 +0800
Message-Id: <20241214004444.792-1-hdanton@sina.com>
In-Reply-To: <675c5e51.050a0220.2875e5.0049.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Dec 13, 2024 at 9:18
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    f932fb9b4074 Merge tag 'v6.13-rc2-ksmbd-server-fixes' of g..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14654730580000

#syz test

--- x/mm/filemap.c
+++ y/mm/filemap.c
@@ -871,6 +871,7 @@ noinline int __filemap_add_folio(struct
 	folio_ref_add(folio, nr);
 	folio->mapping = mapping;
 	folio->index = xas.xa_index;
+	BUG_ON(mapping_exiting(mapping));
 
 	for (;;) {
 		int order = -1, split_order = 0;
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
--

