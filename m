Return-Path: <linux-kernel+bounces-257226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 177139376FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 13:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11A11F219FB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FE684A32;
	Fri, 19 Jul 2024 11:07:32 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EC51B86D2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721387252; cv=none; b=Z/w1FIFitwV6n+H4KrUCy16WJyn/Cv4XZkFwpxWgtNyQCCKVl8b142yFmi1mfpekkZVPPOMn6LHXDs9fmGg7IAAEh0j0o9Sj/LZ6HIY+jpsHPbH74JHM3yUCSIYRQ8bnYCP1946cIZbW6XzNE3BM94L0kPaXfFReL8SZBeu5cxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721387252; c=relaxed/simple;
	bh=4RE8KZY9cV19J+XuKOfThxnS669xRNWqduu456sEO/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FvYLqOhBO5pThmhn9ADoFHe0EGOZn0dBTI9V2NEPnKBjteWcm0oFjzY2Iiy35T2JAPdHku6PxDZp6LiWNJiLTnCshmw2bL1snf4+8VIA3sOnvjZn/3lv+PJassScuSi8svhyWUUOSyPvg+ZdFFuFcXwYZMA2S4QJ+Q3MjlwtMIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.136])
	by sina.com (10.185.250.24) with ESMTP
	id 669A48E30000207D; Fri, 19 Jul 2024 19:07:17 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 47071510748364
X-SMAIL-UIID: 8A64C5E3243C4670ADCD4C07E8E3D2AC-20240719-190717-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] BUG: Bad page map (8)
Date: Fri, 19 Jul 2024 19:07:05 +0800
Message-Id: <20240719110705.1508-1-hdanton@sina.com>
In-Reply-To: <000000000000341f5f061d8d6bcb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 Jul 2024 15:51:26 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    4d145e3f830b Merge tag 'i2c-for-6.10-rc8' of git://git.ker..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1366ab85980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  4d145e3f830b

--- x/include/linux/rmap.h
+++ y/include/linux/rmap.h
@@ -327,6 +327,7 @@ static __always_inline void __folio_dup_
 
 	switch (level) {
 	case RMAP_LEVEL_PTE:
+		BUG_ON(atomic_read(&page->_mapcount) < 0);
 		if (!folio_test_large(folio)) {
 			atomic_inc(&page->_mapcount);
 			break;
@@ -419,6 +420,7 @@ static __always_inline int __folio_try_d
 					return -EBUSY;
 		}
 
+		BUG_ON(atomic_read(&page->_mapcount) < 0);
 		if (!folio_test_large(folio)) {
 			if (PageAnonExclusive(page))
 				ClearPageAnonExclusive(page);
--- x/mm/rmap.c
+++ y/mm/rmap.c
@@ -1149,6 +1149,7 @@ static __always_inline unsigned int __fo
 
 	switch (level) {
 	case RMAP_LEVEL_PTE:
+		BUG_ON(atomic_read(&page->_mapcount) < 0);
 		if (!folio_test_large(folio)) {
 			nr = atomic_inc_and_test(&page->_mapcount);
 			break;
@@ -1503,6 +1504,7 @@ static __always_inline void __folio_remo
 
 	switch (level) {
 	case RMAP_LEVEL_PTE:
+		BUG_ON(atomic_read(&page->_mapcount) < 0);
 		if (!folio_test_large(folio)) {
 			nr = atomic_add_negative(-1, &page->_mapcount);
 			break;
--

