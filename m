Return-Path: <linux-kernel+bounces-309891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E58967191
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 14:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0591F22A32
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D5417DFE9;
	Sat, 31 Aug 2024 12:30:55 +0000 (UTC)
Received: from smtp134-32.sina.com.cn (smtp134-32.sina.com.cn [180.149.134.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5914478289
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725107455; cv=none; b=W2BbB42dCPuR1e90mufKYggL3JwKGKstfpEJs0ByXgD3Nkj6jNCcRPnG1XLQQ6Y84POwdX6E6jBlx1Zs57rIbxmGnEFMYARjF3mIsEv/uDfvozH3C+idnKIALSCHb9UMlOHRIJRHgvenikDGVw7YCsIZWpQ654F7YhOkQsxVlXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725107455; c=relaxed/simple;
	bh=ibWR5oj/i+PDg1gOX80v0djJfJ8+JGd230Geby0SPJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=foEd/Kl+SfLjw1RZzGqSMHd41TjvwEGGeNJ5Vm2X0sArT/TDu9sqbef5V0jcMsaFqM5/9Rn5AcHSAbsf6kT+rgntEW7L5xJo6Gdy4p4vKn7Rv+CwGoHl7pl5GuWHs6UOscSiUDXNEOIDOp9D8MZILq8W5No2k3OU0abzp9EwdMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.55])
	by sina.com (10.185.250.21) with ESMTP
	id 66D30C5600002351; Sat, 31 Aug 2024 20:28:18 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7840513408532
X-SMAIL-UIID: 61DDD826364C4A4D95AF248B25BC84BF-20240831-202818-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+fcb79916dcfe2a4ed10a@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_nfs_sync_lock
Date: Sat, 31 Aug 2024 20:27:56 +0800
Message-Id: <20240831122756.1426-1-hdanton@sina.com>
In-Reply-To: <0000000000007c90b60620f79447@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 31 Aug 2024 02:46:20 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    a18093afa393 Merge tag 'nfsd-6.11-2' of git://git.kernel.o..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f51063980000

#syz test upstream  a18093afa393

--- l/fs/ocfs2/suballoc.c
+++ k/fs/ocfs2/suballoc.c
@@ -962,8 +962,10 @@ int ocfs2_reserve_new_metadata_blocks(st
 {
 	int status;
 	int slot = ocfs2_get_meta_steal_slot(osb);
+	unsigned int pff = memalloc_nofs_save();
 
 	*ac = kzalloc(sizeof(struct ocfs2_alloc_context), GFP_KERNEL);
+	memalloc_nofs_restore(pff);
 	if (!(*ac)) {
 		status = -ENOMEM;
 		mlog_errno(status);
--

