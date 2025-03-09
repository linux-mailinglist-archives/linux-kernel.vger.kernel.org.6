Return-Path: <linux-kernel+bounces-553024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0C4A582A3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FD43AE703
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E38C192B71;
	Sun,  9 Mar 2025 09:21:45 +0000 (UTC)
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CAEECF
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741512104; cv=none; b=aw5bedtDWASEXDkhMMnpFiwOOMp6AAqvWSapvdepfw6Qj6Q596Ur3ivnfEug765gcUJ2tomhRTsbkRDgeCCB8mB7vkArPYVKJO2QiAiVQOJvp/sTc78Wnfv6YiiqGEfxJ+0ZoR74VEG2Gs69IrjhvafQL5jpJRg4Kz/qrSBN8I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741512104; c=relaxed/simple;
	bh=wb2dlZ1czPHYBDPN2EQ5rW6W9Rqar227Dhf4ktCWlGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVX6U3Z6YOfagdLd3GGTx1K629UgFiel6QqrZXA9Yz6jEvxSyrqnDgxb8NKY9KljLNaWuJAOLp0bQxc4UtyDFc5XH23dSb3gj+7jkqYgB2fpwsDUNboo3rSqSF/KscMqWq1Xvl+hTlPIPJBAMXCFHHT+zdrn6o8G1VGqkStK0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.225])
	by sina.com (10.185.250.22) with ESMTP
	id 67CD5D98000005D3; Sun, 9 Mar 2025 17:21:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7779057602345
X-SMAIL-UIID: BED1A7793C434C4C92132C0004974D3C-20250309-172130-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+019072ad24ab1d948228@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [efi?] [fs?] possible deadlock in efivarfs_actor
Date: Sun,  9 Mar 2025 17:21:19 +0800
Message-ID: <20250309092120.3184-1-hdanton@sina.com>
In-Reply-To: <67cd0276.050a0220.14db68.006c.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 08 Mar 2025 18:52:38 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    e056da87c780 Merge remote-tracking branch 'will/for-next/p..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13b97c64580000

#syz test upstream  master

--- x/fs/efivarfs/super.c
+++ y/fs/efivarfs/super.c
@@ -421,7 +421,7 @@ static bool efivarfs_actor(struct dir_co
 	if (err)
 		size = 0;
 
-	inode_lock(inode);
+	inode_lock_nested(inode, I_MUTEX_CHILD);
 	i_size_write(inode, size);
 	inode_unlock(inode);
 
--

