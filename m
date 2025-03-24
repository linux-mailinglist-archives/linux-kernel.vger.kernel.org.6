Return-Path: <linux-kernel+bounces-573581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86EC1A6D954
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9122F3AED4D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395D125E476;
	Mon, 24 Mar 2025 11:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSj0jwIT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A14F25E469
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742816985; cv=none; b=EOJz2jcspa/VTdNLfifCX0i01qudCEbF1a1NkLtJFkAyHg7H6to7fKCSnsKGlH3OwA2BJxwXM076leGwpcPop0X0DnfbuETsk1LbOQc/MdJQLI8XDMD8itlnwSQfOypqqW/ilurFyl5yrUmq4j6jcxPACevRgQXpHXPEF9wGFkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742816985; c=relaxed/simple;
	bh=vr/oTXFzFR9Y3VuFg7RbsLwrGmb0uJmEySHHZNiSAC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFIu5xxSsJ8hzODArbCh5FUnACURTkfKbb75kpxhu2fROPUo2OoMnV9BBpMw0QVSMZHHLvDuN9vL+k73vZy8i3AyCTQgwgFjUR+V5XNZ0a19wbC5xo9GDLUET/+2yZku1pVbo9+mAPObTt9fvNZX5R7Awek3m0Lae148/+eSqlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSj0jwIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E75C4CEED;
	Mon, 24 Mar 2025 11:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742816985;
	bh=vr/oTXFzFR9Y3VuFg7RbsLwrGmb0uJmEySHHZNiSAC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NSj0jwITslTf/S1qJuluslbxI0uA2Z1TDzPdvifelHh+HpiCJM/a9gALdo6+jBwkH
	 4IF3faN2AKPbYxzte6QBWBGHlWxgOXNE/BiasgBhP4QYci01l33gf+06Gwvpc8ckEl
	 Jzw0dcdIV0VlCwVcYefiUFJZmXUEbRnzzal+tCnq9mpMngD/o3ynzdDg0lC918RNuN
	 wNNtf2pxgPPjHXerg40mOCj+rEv64pFv+m9fmZTpgA1Xq+WAG5iUkZFl+n0JK2sBv6
	 v7bf2pUnFdRMJ7km8ep5DGNr9r0VRMKj/2g8/08aFQczeUBfSUZtYw9Inu9zeYnsO3
	 ZEKjw+0zw9ZRw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 2/2] f2fs: zone: fix to avoid inconsistence in between SIT and SSA
Date: Mon, 24 Mar 2025 19:49:35 +0800
Message-ID: <20250324114935.3087821-2-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <20250324114935.3087821-1-chao@kernel.org>
References: <20250324114935.3087821-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

w/ below testcase, it will cause inconsistence in between SIT and SSA.

create_null_blk 512 2 1024 1024
mkfs.f2fs -m /dev/nullb0
mount /dev/nullb0 /mnt/f2fs/
touch /mnt/f2fs/file
f2fs_io pinfile set /mnt/f2fs/file
fallocate -l 4GiB /mnt/f2fs/file

F2FS-fs (nullb0): Inconsistent segment (0) type [1, 0] in SSA and SIT
CPU: 5 UID: 0 PID: 2398 Comm: fallocate Tainted: G           O       6.13.0-rc1 #84
Tainted: [O]=OOT_MODULE
Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
Call Trace:
 <TASK>
 dump_stack_lvl+0xb3/0xd0
 dump_stack+0x14/0x20
 f2fs_handle_critical_error+0x18c/0x220 [f2fs]
 f2fs_stop_checkpoint+0x38/0x50 [f2fs]
 do_garbage_collect+0x674/0x6e0 [f2fs]
 f2fs_gc_range+0x12b/0x230 [f2fs]
 f2fs_allocate_pinning_section+0x5c/0x150 [f2fs]
 f2fs_expand_inode_data+0x1cc/0x3c0 [f2fs]
 f2fs_fallocate+0x3c3/0x410 [f2fs]
 vfs_fallocate+0x15f/0x4b0
 __x64_sys_fallocate+0x4a/0x80
 x64_sys_call+0x15e8/0x1b80
 do_syscall_64+0x68/0x130
 entry_SYSCALL_64_after_hwframe+0x67/0x6f
RIP: 0033:0x7f9dba5197ca
F2FS-fs (nullb0): Stopped filesystem due to reason: 4

The reason is f2fs_gc_range() may try to migrate block in curseg, however,
its SSA block is not uptodate due to the last summary block data in still
in cache of curseg.

In this patch, we add a condition in f2fs_gc_range() to check whether
section is opened or not, and skip block migration for opened section.

Fixes: 9703d69d9d15 ("f2fs: support file pinning for zoned devices")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2b8f9239bede..8b5a55b72264 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2066,6 +2066,9 @@ int f2fs_gc_range(struct f2fs_sb_info *sbi,
 			.iroot = RADIX_TREE_INIT(gc_list.iroot, GFP_NOFS),
 		};
 
+		if (IS_CURSEC(sbi, GET_SEC_FROM_SEG(sbi, segno)))
+			continue;
+
 		do_garbage_collect(sbi, segno, &gc_list, FG_GC, true, false);
 		put_gc_inode(&gc_list);
 
-- 
2.48.1


