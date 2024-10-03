Return-Path: <linux-kernel+bounces-348458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8951A98E7F6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 03:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0327AB24636
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F51510A0C;
	Thu,  3 Oct 2024 01:00:57 +0000 (UTC)
Received: from smtp134-32.sina.com.cn (smtp134-32.sina.com.cn [180.149.134.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0978C0B
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727917257; cv=none; b=Hb27+KSxDmNy3N71WFstRCDuCi21Dgd0rYcVhDH5EelgVhClCNa6xbELOjw/D6bfN0QTZJMTpZ0TufVXwIB+jL19iKhz2HsRSUnaw2fnaA4JuUpbhvEoGhV/Z5vdh3emwdUmFr6emGlGJCG5Q3baDq1i3ufLWXFfZBLRPBgkjH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727917257; c=relaxed/simple;
	bh=e9yA2aMsSnI27oqa2pmoQRgb3I99jrGNJchdG8Jnwwc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kb6QhRJUt+M7C4fDis2oxQbi28eWp6jKa6mN9+1B+ukwe0/tCvboWijeUzkSLUUjHDMqcWboFvxC3NZikmvdlzZH9xjCJWVqDrVAHGjrlqZo7NI/XDpDrsnO+JLsNyg774hRcc4/7r741AnojMAYg6ApfYydKMHtdth+jHJHdb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.67])
	by sina.com (10.185.250.21) with ESMTP
	id 66FDEC9700002C03; Thu, 3 Oct 2024 09:00:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6079593408336
X-SMAIL-UIID: 8185E8D8BF2C422B8278CC8D749533FF-20241003-090009-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9ba7a8cdae0440edd57b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in binder_release_work
Date: Thu,  3 Oct 2024 08:59:56 +0800
Message-Id: <20241003005956.1869-1-hdanton@sina.com>
In-Reply-To: <66fdb6be.050a0220.40bef.0024.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 02 Oct 2024 14:10:22 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    ad46e8f95e93 Merge tag 'pm-6.12-rc1-2' of git://git.kernel..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ff3507980000

#syz test

--- x/drivers/android/binder.c
+++ y/drivers/android/binder.c
@@ -6252,6 +6252,7 @@ static void binder_deferred_release(stru
 		ref = rb_entry(n, struct binder_ref, rb_node_desc);
 		outgoing_refs++;
 		binder_cleanup_ref_olocked(ref);
+		binder_dequeue_work(proc, &ref->freeze->work);
 		binder_proc_unlock(proc);
 		binder_free_ref(ref);
 		binder_proc_lock(proc);
--

