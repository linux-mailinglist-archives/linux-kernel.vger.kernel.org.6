Return-Path: <linux-kernel+bounces-373177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2003A9A535D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 11:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 698DCB212C3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 09:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86938166F00;
	Sun, 20 Oct 2024 09:39:33 +0000 (UTC)
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F5C2942A
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729417173; cv=none; b=gvaTzWDqxUTrfcpG6pDYyhPdg2n+J3ctAJ1GVi1gj5ZaYFFY+cjPTV3WYzsxBafvc7nH5HNuQVedlW5E8p9vobQ/BsH/iGziCt+gcXFnLv76LGmYkg0XcOaL5dh39rId/KSeDyehXxYrxSXrJnobTcaxyjfFkP81oFnZsvdbTys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729417173; c=relaxed/simple;
	bh=OJLXiwAmR4kCB778Ym3Df88sNOMUtoPHYzTQr1I5hp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hsI6X8Oqbck/uXT+ir4OstEh8nstPAK9X0eo9cupUA4/cEqEZ8ew30BkYidnGu9x+HjZ2J3W8Av+ZrYnK5uPIvnZ6rnju6gyfLFAeO7VIhohCZbl1d+9IQ/iIXz7nKIYLkuWHCNNUHCxzUwgdvcPoeZaAWaMfmiY1n1I+eTGmVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.146])
	by sina.com (10.185.250.21) with ESMTP
	id 6714CFC100002A1B; Sun, 20 Oct 2024 17:39:19 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5470063408272
X-SMAIL-UIID: F206A99C333B41C49ED6B53A1BE054CB-20241020-173919-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+65d101735df4bb19d2a3@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fuse?] kernel BUG in fuse_dev_do_write
Date: Sun, 20 Oct 2024 17:39:03 +0800
Message-Id: <20241020093903.2182-1-hdanton@sina.com>
In-Reply-To: <6714bb39.050a0220.10f4f4.002e.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Oct 2024 01:11:37 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    15e7d45e786a Add linux-next specific files for 20241016
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16582f27980000

#syz test

--- x/fs/fuse/dev.c
+++ y/fs/fuse/dev.c
@@ -1668,7 +1668,7 @@ static int fuse_notify_store(struct fuse
 		err = fuse_copy_page(cs, &page, offset, this_num, 0);
 		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
 		    (this_num == folio_size(folio) || file_size == end)) {
-			folio_zero_range(folio, this_num, folio_size(folio));
+			folio_zero_range(folio, this_num, folio_size(folio) - this_num);
 			folio_mark_uptodate(folio);
 		}
 		folio_unlock(folio);
--

