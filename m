Return-Path: <linux-kernel+bounces-386810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B35CA9B4826
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15421C22528
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44EF20512F;
	Tue, 29 Oct 2024 11:21:18 +0000 (UTC)
Received: from smtp134-31.sina.com.cn (smtp134-31.sina.com.cn [180.149.134.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AB5204920
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730200878; cv=none; b=fTukOiexfG7xl65K+WFK/Jd7vwq7nKh6YxaUhhJ6hgL9epeoBK85OS4TdNl4lQv8QAtOEFkBvVc3uvwCU0mHF+3VMri4Cnp1BrJ1YVSL+3cyfDLP4kgULxwL4aO1V3IxC3BkWaNAp4InJFLOxbCgSRiXuedWethsjK0XbWF3bHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730200878; c=relaxed/simple;
	bh=UHc9rjyMIma+ORa8jGU8w8SfaZ180hfOr82zRTl+RTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YFEExSTF7QsY62HUmihFpByFgTkoi21oCBrSdWROsoUqzxRaOiKW/xIOsebsIAop0GZoqN/czV8x3c1lq2PtQUb0yfVnGhI8e+xWDa8R+wQ+Z66BPAZLiHksAgjf/hNP2KuYOBUnzgzEdmAsFr97AJfEdFf2Qw/smuZyN32ksbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.172])
	by sina.com (10.185.250.21) with ESMTP
	id 6720C516000030AB; Tue, 29 Oct 2024 19:20:59 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5280533408318
X-SMAIL-UIID: EBC68F18A80B4D3CB14A82701F1D684B-20241029-192059-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+dee8aa54cb2f5a150f9e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] kernel BUG in binder_alloc_deferred_release (2)
Date: Tue, 29 Oct 2024 19:20:46 +0800
Message-Id: <20241029112046.2492-1-hdanton@sina.com>
In-Reply-To: <671fbcd6.050a0220.21b2f.0009.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 28 Oct 2024 09:33:26 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132b2ebb980000

#syz test

--- x/drivers/android/binder.c
+++ y/drivers/android/binder.c
@@ -6307,6 +6307,7 @@ binder_defer_work(struct binder_proc *pr
 		hlist_add_head(&proc->deferred_work_node,
 				&binder_deferred_list);
 		schedule_work(&binder_deferred_work);
+		binder_alloc_vma_close(&proc->alloc);
 	}
 	mutex_unlock(&binder_deferred_lock);
 }
--

