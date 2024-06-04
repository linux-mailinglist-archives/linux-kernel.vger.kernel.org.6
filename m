Return-Path: <linux-kernel+bounces-200623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8D68FB283
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78A6BB24A3D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC4014658B;
	Tue,  4 Jun 2024 12:45:53 +0000 (UTC)
Received: from smtp134-24.sina.com.cn (smtp134-24.sina.com.cn [180.149.134.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D201D1459F7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505153; cv=none; b=SvoJvKhuT5DEOugBLpnNSVV33SIwjUbENO1ogw0qC2TeVvU4wsDvWQkK0K/2Yk941ZX7crdz+iYBl9/o9i7EM6qBUpnvZRLU4FBc4/14YTjITS/4FsDwY5436RMe4p81c9Sm+B2i9Sj71xjy3VHO4Dykd1n6ggmNQtoekVb/QZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505153; c=relaxed/simple;
	bh=0iEF8wETT6G6fBhdJDXKqrY/qYuqjEBpgN/0oFGZ0gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uI/pHipB9qBKN4DFWjno2XhP2d90814Cucqi7nn2bfcArOMlzq2B6mNZc7VJXBbHLB18KOYeqW9gA++Xl5k8Ln/2BCCOMqeMSLwy1Msh0laVRlVc6/0ZdOY73HZiChdS77024KMa9Pkbcfe95PDnAAsxRwR3rkHFYHENWjtC0KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.129])
	by sina.com (10.185.250.21) with ESMTP
	id 665F0C6C00002A67; Tue, 4 Jun 2024 20:45:34 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5692173408666
X-SMAIL-UIID: 9B1112607D4845C4913DF2D3AB39891F-20240604-204534-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+558f67d44ad7f098a3de@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer dereference in __hrtimer_run_queues
Date: Tue,  4 Jun 2024 20:45:22 +0800
Message-Id: <20240604124522.1781-1-hdanton@sina.com>
In-Reply-To: <000000000000deb5250619f9b5f4@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 03 Jun 2024 03:22:29 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c1b514980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -376,7 +376,7 @@ void contpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
 	 * clearing access/dirty for the whole block.
 	 */
 	unsigned long start = addr;
-	unsigned long end = start + nr;
+	unsigned long end = start + nr * PAGE_SIZE;
 
 	if (pte_cont(__ptep_get(ptep + nr - 1)))
 		end = ALIGN(end, CONT_PTE_SIZE);
@@ -386,7 +386,7 @@ void contpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
 		ptep = contpte_align_down(ptep);
 	}
 
-	__clear_young_dirty_ptes(vma, start, ptep, end - start, flags);
+	__clear_young_dirty_ptes(vma, start, ptep, (end - start) / PAGE_SIZE, flags);
 }
 EXPORT_SYMBOL_GPL(contpte_clear_young_dirty_ptes);
 
--

