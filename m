Return-Path: <linux-kernel+bounces-200612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCDA8FB261
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6A41C22BEF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA04146A6E;
	Tue,  4 Jun 2024 12:37:55 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926D6146582
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504674; cv=none; b=MLjT95Rs/Y6cfIfySIDrQHll3IqKuPCM/VseIocHB4vxRtOMOMatEfUs7tKFfOp9+AqGYKUHMirr1KyYowDc4K0TTixdoh1MDiXBSKuhg/Nr8Fb7K6pdAydpELWgq2FSC5MFaFCj75OdK3WJLVI/7wItERZ0j28TsE7XOCk2Jmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504674; c=relaxed/simple;
	bh=TNuljGCIjYraC1j8XPFvGeBDRiILJdeJOQEZcYiIDHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ETPsRw8vFVr5jYHZ8AGy0dA9oNmBVNXf2/h1ckkCQ1uNs+kdqkNJpH4fVkW/8YawAV4+UEMLuOMXIuRuVxS8UqRb3GUHt9+9XcHa4BczAFAzH9fOVrMA9Oby5u/edfaAtyYO5JenzEqDxDVuQims3kRFb4Ftr4Epz9JRUT9hgVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.129])
	by sina.com (172.16.235.25) with ESMTP
	id 665F0A7000003CF9; Tue, 4 Jun 2024 20:37:07 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 60384634210408
X-SMAIL-UIID: 572F591C2B6A4CCAABC88C7DE272A6B0-20240604-203707-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+5a1cb2c00e895afca87e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel panic: corrupted stack end in userfaultfd_ioctl
Date: Tue,  4 Jun 2024 20:36:56 +0800
Message-Id: <20240604123656.1730-1-hdanton@sina.com>
In-Reply-To: <000000000000109e6b0619fbfd44@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 03 Jun 2024 06:05:33 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    4a4be1ad3a6e Revert "vfs: Delete the associated dentry whe..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15683162980000

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

