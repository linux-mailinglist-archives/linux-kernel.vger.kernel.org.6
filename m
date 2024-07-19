Return-Path: <linux-kernel+bounces-257297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D51E937813
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 15:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C791F2166F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 13:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9326F138490;
	Fri, 19 Jul 2024 13:01:13 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222CC10E6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721394073; cv=none; b=ojRGoyW6ldK8OpKlyEN8jFfcEEICzhQG8EGSahEj/t1sWz6D+VupuXGy85tbGzyA6QBNJnDQXcH/2qS1KE5y65QRIfukRu+iI92nPZncUOLfwizXyrj01eIuzCaLxFdpyg34IOpVT0UXROQT7iRykcuh61F5RahbtYtALHm3bS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721394073; c=relaxed/simple;
	bh=XbTbfbqQNijPvJdfWmU1KIwZNjdKHLKSGEchpHxJ954=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dx6Ha9SZR92ukFtJUWLVcFTonkpkSm7JUgIs7nh1KT1i/Zo7Q3KFmPg75gajXuBt9jbrbbTOJ93t8QXfeU4DUjcubyZgHj2ROCyLfWD54pZnylOR2WvWq2L2ka7E68jG1gKdaf4i2ZaJNP7bYm+l/JbGUd3h9eydOydsHJF7nco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.136])
	by sina.com (10.185.250.23) with ESMTP
	id 669A6385000015AC; Fri, 19 Jul 2024 21:00:56 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6748468913666
X-SMAIL-UIID: 5F65E5FB600249AE8ED9D7F24C1376D6-20240719-210056-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] BUG: Bad page map (8)
Date: Fri, 19 Jul 2024 21:00:43 +0800
Message-Id: <20240719130043.1621-1-hdanton@sina.com>
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
+		BUG_ON(atomic_read(&page->_mapcount) < -1);
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

