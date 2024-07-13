Return-Path: <linux-kernel+bounces-251512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E14B9305BC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 15:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC6A28200E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 13:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5199A132130;
	Sat, 13 Jul 2024 13:21:25 +0000 (UTC)
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2809C6EB46
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 13:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720876884; cv=none; b=uHWOhnC6ms1rvlH90zYeOuVm4HQKsvXeeNBGgFPn5DHUYYXw+G8l+jwiYQ08KWhOOA9/+JIicO7G8fqc+tmr0ib92L0GdK0JCqeT2lnlzVBmFUAfde8/crV0Nbe00B6oiguvAnyvQhXu3oGqboJPZA4p4jaoO/NeUiSTMJDBen4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720876884; c=relaxed/simple;
	bh=dff+k0Cdom64PE4xsA4RuieExJAXBhMBmJOri9Gzzy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N9d87z+/9sGjGSwz/L0OdW8D+gzTZQy4vtkbYN05hgAom8FqVZkWqFIys66Gyy8Kl9Uts/h8YRCxbPbyrr40GwPzMbmlakVPWc6m0KqSh/tJojVNf8Y04ojzVV7dQ+IMB+hRCruLykdGnbkksV/eQsL3uuwn0gFjuqszrSM2OEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.52])
	by sina.com (10.185.250.22) with ESMTP
	id 66927F4400001D53; Sat, 13 Jul 2024 21:21:10 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2881667602825
X-SMAIL-UIID: 0FD220E835BB4088AF57A1D5EBB3950F-20240713-212110-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] kernel BUG in binder_inc_ref_for_node
Date: Sat, 13 Jul 2024 21:21:01 +0800
Message-Id: <20240713132101.1009-1-hdanton@sina.com>
In-Reply-To: <000000000000c1c0a0061d1e6979@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 13 Jul 2024 03:25:20 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    82d01fe6ee52 Add linux-next specific files for 20240709
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a4869e980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  82d01fe6ee52

--- x/drivers/android/binder.c
+++ y/drivers/android/binder.c
@@ -1131,6 +1131,7 @@ static struct binder_ref *binder_get_ref
 	struct binder_ref *ref;
 	struct rb_node *parent;
 	struct rb_node **p;
+	struct rb_node **p0, *pa0;
 	u32 desc;
 
 retry:
@@ -1147,6 +1148,8 @@ retry:
 		else
 			return ref;
 	}
+	p0 = p;
+	pa0 = parent;
 	if (!new_ref)
 		return NULL;
 
@@ -1158,11 +1161,10 @@ retry:
 	new_ref->data.debug_id = atomic_inc_return(&binder_last_id);
 	new_ref->proc = proc;
 	new_ref->node = node;
-	rb_link_node(&new_ref->rb_node_node, parent, p);
-	rb_insert_color(&new_ref->rb_node_node, &proc->refs_by_node);
 
 	new_ref->data.desc = desc;
 	p = &proc->refs_by_desc.rb_node;
+	parent = NULL;
 	while (*p) {
 		parent = *p;
 		ref = rb_entry(parent, struct binder_ref, rb_node_desc);
@@ -1172,11 +1174,14 @@ retry:
 		else if (new_ref->data.desc > ref->data.desc)
 			p = &(*p)->rb_right;
 		else
-			BUG();
+			return ref;
 	}
 	rb_link_node(&new_ref->rb_node_desc, parent, p);
 	rb_insert_color(&new_ref->rb_node_desc, &proc->refs_by_desc);
 
+	rb_link_node(&new_ref->rb_node_node, pa0, p0);
+	rb_insert_color(&new_ref->rb_node_node, &proc->refs_by_node);
+
 	binder_node_lock(node);
 	hlist_add_head(&new_ref->node_entry, &node->refs);
 
--

