Return-Path: <linux-kernel+bounces-235212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A044491D1A7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 14:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E75C0B20DD4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 12:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E424413C819;
	Sun, 30 Jun 2024 12:45:29 +0000 (UTC)
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9474B2E419
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719751529; cv=none; b=GBpBJmfcbGDi2BHJ/DY8twbSVfL+NRpPDzsglmdZQ3BR8+FN/sKRfMZ7Zp4AXoDSTtwymv8jaD/0Zvum3sXHRLbCsGlpH6Su1WKb7U53qLR1cHF6xFYQKlE7Mmr8S12LumOO3XAHUMSYYC9+7QqSlIlNwncS0ElKz+atEOwoD6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719751529; c=relaxed/simple;
	bh=hhIXgolmf4Gst45B4isGYdFvq8H5fJ3jMyise2w6WnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kL1Kd48ZmkzlghFbJVVDimEChDqCuctO1C0wlwOeMXlri5VjmKh8OahIm2EghEeLx51/ZYvkD7Xo+ylCBtPD2kUq19LF+xFXVr4VhLiePzJcEJW9Uzp36qgPN9DB4NjX1S/RlljjIv+43Z/Wz+tABklVCrAvg659nTOLGuK1DxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.55])
	by sina.com (10.185.250.23) with ESMTP
	id 6681521700001B82; Sun, 30 Jun 2024 20:39:53 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8599518913586
X-SMAIL-UIID: 50D24F33A7224A01BEF57335C8E2447B-20240630-203953-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+1e1b380ef8d95b36f789@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] INFO: task hung in journal_quiesce
Date: Sun, 30 Jun 2024 20:39:41 +0800
Message-Id: <20240630123941.2689-1-hdanton@sina.com>
In-Reply-To: <000000000000c5e7f60619bb5ccb@google.com>
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

