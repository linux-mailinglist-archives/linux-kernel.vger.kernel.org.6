Return-Path: <linux-kernel+bounces-257710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 172F4937DF1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8D01F218BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4094414884F;
	Fri, 19 Jul 2024 23:08:47 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190B2C8C7
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 23:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721430526; cv=none; b=RRzCBdn87RwDb+erdvL9nEVzAP6Wdp0pPlHO75dsuHpcdMdP2rQ43LgHz0hO55Fxdr9qAjYiLCsUlVj8IF/L0fJEZXb1UYBX/Yj5fTw56jEeEj4QNUG0Nea6ui/GnhdbcxlK490ZE781KnJ21UH3vBRXcTcHWFX7USi9SFVqFd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721430526; c=relaxed/simple;
	bh=Q8P7qoxw+ioU8sFQiIPqQOBd7LK46PHKRO7tcclHUHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FOZKl5igLLpZYmX7xhLM7QyDuZxZpqV0n7QVMyPTIpk4oFB5d2lZ1NuJaNnKbTmqqas0ADShP0OPhpo0ql1+el/fv3fMpb/Ia3C6r2Eo3GifT8vEJpioJRu1ftRCgqiQu8yQAi7TlXSIeoNT9Ioj414Em0EXoG7BYoVKGUI7X2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.143])
	by sina.com (10.185.250.22) with ESMTP
	id 669AF1F4000050DB; Fri, 20 Jul 2024 07:08:39 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 540367602659
X-SMAIL-UIID: 165FA03A0CA7493A9954FBB67506C6CA-20240720-070839-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] BUG: Bad page map (8)
Date: Sat, 20 Jul 2024 07:08:27 +0800
Message-Id: <20240719230827.1693-1-hdanton@sina.com>
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

--- x/mm/truncate.c
+++ y/mm/truncate.c
@@ -192,6 +192,7 @@ int truncate_inode_folio(struct address_
 		return -EIO;
 
 	truncate_cleanup_folio(folio);
+	BUG_ON(folio_mapped(folio));
 	filemap_remove_folio(folio);
 	return 0;
 }
--

