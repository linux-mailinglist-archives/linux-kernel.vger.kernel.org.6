Return-Path: <linux-kernel+bounces-235201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BE991D173
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 13:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EDC61C20DD7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 11:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B4E13AD22;
	Sun, 30 Jun 2024 11:40:33 +0000 (UTC)
Received: from smtp134-24.sina.com.cn (smtp134-24.sina.com.cn [180.149.134.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475CA2E419
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719747633; cv=none; b=WPZ6TJtTh2IdnBJbd1JEF2Nyh2B5N2JBVqQxSfNdXl6CKnHneOn6nSAKGVX5lkSlyTo3WsVtGjqVR6j1w7QhVJ1iLK22immifuMFd0IkmKKLv/63h+t2l9FewhHmduCboxenY3SuPqYGCbz+Jt30L9EWbLQnGIQLS3pj2m3e1nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719747633; c=relaxed/simple;
	bh=hhIXgolmf4Gst45B4isGYdFvq8H5fJ3jMyise2w6WnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RDRrR/a/mCvp0S0ZEobSZfD4rJQT+fpck/Jja22Yhk9cDTAPR5cSgnv67EdCjneJHRVV7s3fqeN77JGJB2oLH3yus7Hrwn2sOQtKxn9oLvb7fhi7DV1yBX49bqEL4aA0cR2fVmB1vtTZjQ8eG7lr0tKIz+SrbCzGFaycfuAImaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.55])
	by sina.com (10.185.250.21) with ESMTP
	id 668143FF000036CE; Sun, 30 Jun 2024 19:39:45 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4753173408426
X-SMAIL-UIID: 8FE74908CD114D3BBEF59D1B214B88AF-20240630-193945-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8996d8f176cf946ef641@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in bch2_fs_read_only_work
Date: Sun, 30 Jun 2024 19:39:33 +0800
Message-Id: <20240630113933.2634-1-hdanton@sina.com>
In-Reply-To: <000000000000d4c7f4061a080a7a@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/fs/bcachefs/btree_locking.c
+++ y/fs/bcachefs/btree_locking.c
@@ -10,7 +10,6 @@ void bch2_btree_lock_init(struct btree_b
 			  enum six_lock_init_flags flags)
 {
 	__six_lock_init(&b->lock, "b->c.lock", &bch2_btree_node_lock_key, flags);
-	lockdep_set_novalidate_class(&b->lock);
 }
 
 #ifdef CONFIG_LOCKDEP
--

