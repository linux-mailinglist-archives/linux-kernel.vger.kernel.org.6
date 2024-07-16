Return-Path: <linux-kernel+bounces-253729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD3F9325FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6C11C21AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9F5199EAF;
	Tue, 16 Jul 2024 11:56:02 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A071991B6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721130962; cv=none; b=JZ8q7iyIJ7gpHHr0g7ypU5ZTz9wYK19H5943a2rEYRrT74s0qeuWt/n6KlWqAXyySD0xPt83NiNj4VFdURlHrPBWCMdMSqH/6CH+EEg4gsOsb9AhwUuqRhuXhFgHpgpf2r7dQK32L8H1uQJLfbUeGIEwKVa/BUc8w3/j1ubWgHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721130962; c=relaxed/simple;
	bh=jcyOZAZhrzDLiwCRu+vbMJi3B2tD07/bCVkjvCqKT0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YQQt5sDwyO1vvrcp9dW2SKHxA6Z27H5QmTBil+WrnFfNker5NFD7ACqdg/Mo/9ZeCwYRLJLNBzmZ+Fb7ZnrOfyIa0fP+NH3KM6Mx/CK8eT6ukLtjRXdEfkOcz/DekLyLSfBSa2GjNR7wVdBBzLM/g9zEk1EOwqR+mGnFCuRxjpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.121])
	by sina.com (10.185.250.22) with ESMTP
	id 66965F9D00004688; Tue, 16 Jul 2024 19:55:11 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4118887602671
X-SMAIL-UIID: FF9346E961754E6EB7B5F848E06E5431-20240716-195511-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4c882a4a0697c4a25364@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [crypto?] KASAN: slab-use-after-free Read in handle_mm_fault
Date: Tue, 16 Jul 2024 19:55:04 +0800
Message-Id: <20240716115504.1136-1-hdanton@sina.com>
In-Reply-To: <00000000000037cdb0061d5924b3@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 16 Jul 2024 01:29:17 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    3fe121b62282 Add linux-next specific files for 20240712
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ce3259980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  3fe121b62282

--- x/mm/memory.c
+++ y/mm/memory.c
@@ -5808,6 +5808,7 @@ vm_fault_t handle_mm_fault(struct vm_are
 	/* If the fault handler drops the mmap_lock, vma may be freed */
 	struct mm_struct *mm = vma->vm_mm;
 	vm_fault_t ret;
+	bool droppable;
 
 	__set_current_state(TASK_RUNNING);
 
@@ -5831,6 +5832,7 @@ vm_fault_t handle_mm_fault(struct vm_are
 
 	lru_gen_enter_fault(vma);
 
+	droppable = !!(vma->vm_flags & VM_DROPPABLE);
 	if (unlikely(is_vm_hugetlb_page(vma)))
 		ret = hugetlb_fault(vma->vm_mm, vma, address, flags);
 	else
@@ -5839,7 +5841,7 @@ vm_fault_t handle_mm_fault(struct vm_are
 	lru_gen_exit_fault();
 
 	/* If the mapping is droppable, then errors due to OOM aren't fatal. */
-	if (vma->vm_flags & VM_DROPPABLE)
+	if (droppable)
 		ret &= ~VM_FAULT_OOM;
 
 	if (flags & FAULT_FLAG_USER) {
--

