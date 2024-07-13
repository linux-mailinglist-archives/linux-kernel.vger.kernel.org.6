Return-Path: <linux-kernel+bounces-251298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C8193031B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 03:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20756282D3E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768EF11CA0;
	Sat, 13 Jul 2024 01:51:40 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC22A101C4
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 01:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720835500; cv=none; b=VO56piTRGfObf7B+Jkhb7i8MlvBaz2VFMorEuY+csDmPOqmlkXXe4Sr5jFR55zg7Amuy4WWjDsP02O4q8utGzjI21SqxAourvRBnEDtfoFKqlTJ7ROsW9QaHfV/Vpr9gb6AwI5DmsewIQ+VznirV+yzxwwLwOxfnhmxaWx2C95U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720835500; c=relaxed/simple;
	bh=adCyKKkMwjJZDcM9U8gURfC4VUQHEm1LBHVXeI7ccgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eiyiXchTB4MTxUv9gzmPAVGpuluhhYF3UUZyGYVxKKh+0+0u8Wn4Ko7PELA47JygEYLVvmHf7yJeKq6U8VKkbcvAA9YLeSQYnvoIrqtmEHzQmArg8fxLV//NtlIzo6WtNzMkwOxmnqsu31/oLf+CTHtBaiQeKHpr/PYHkXVDDHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.52])
	by sina.com (10.185.250.24) with ESMTP
	id 6691DD0F0000028E; Sat, 13 Jul 2024 09:49:06 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 13578110748490
X-SMAIL-UIID: B59426E96D894658A91CB898A4239E91-20240713-094906-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2403e3909382fbdeaf6c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in list_lru_add
Date: Sat, 13 Jul 2024 09:48:58 +0800
Message-Id: <20240713014858.1281-1-hdanton@sina.com>
In-Reply-To: <0000000000002d320c061d0ff813@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 12 Jul 2024 10:11:25 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    43db1e03c086 Merge tag 'for-6.10/dm-fixes-2' of git://git...
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b1da7e980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  43db1e03c086

--- x/mm/list_lru.c
+++ y/mm/list_lru.c
@@ -94,6 +94,8 @@ bool list_lru_add(struct list_lru *lru,
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
 		l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
+		if (NULL == l)
+			l = &lru->node[nid].lru;
 		list_add_tail(item, &l->list);
 		/* Set shrinker bit if the first element was added */
 		if (!l->nr_items++)
--

