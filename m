Return-Path: <linux-kernel+bounces-424584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 448999DB64F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3CE9B23C45
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 11:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAF8194A74;
	Thu, 28 Nov 2024 11:11:26 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390DF192D82
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732792286; cv=none; b=UfsjBKbqazbgDjEwvmchplKudHI2kRKsT8kVa9xczPshyROgchCg6hYNfZgYi30x7L9uXSE+gQ+cueZgPFmN1Jn5XrM0Cp/S/ua/5JSkJqBuPRgfsbdMYxrjavqDaNBOuynYodXTBHsZVpRTP8QnB8SQbkQow+I7FTQ2Gs5HInQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732792286; c=relaxed/simple;
	bh=LSTYiD73U24bZGPTcOFKayv1popmuxkAHPHkd55TQiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QCbSJHA4UnTloKGCUon2hAJelxlyYcLdzHFGH0u9yvPYh3K/AFCN0L3MDsR/DLW8mc7nWSpHxNw6X3pt5oZ48gayAGS241H3WMmQB9/gZGEEWMf19AIDN3E3QeCEvyaCw6s+2W09bDJoDJI7ft+sNMZc9ZAWyt/xwzzi45iHFWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.49])
	by sina.com (10.185.250.24) with ESMTP
	id 67484FCE00004DA5; Thu, 28 Nov 2024 19:11:15 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 24719110748365
X-SMAIL-UIID: 7AABE4A5422C4DFCBF2472C2F404EB69-20241128-191115-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+cc0cc52e7f43dc9e6df1@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] BUG: corrupted list in mgmt_pending_remove
Date: Thu, 28 Nov 2024 19:11:01 +0800
Message-Id: <20241128111101.1788-1-hdanton@sina.com>
In-Reply-To: <67482f4a.050a0220.253251.0078.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 28 Nov 2024 00:52:26 -0800
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    5dfd7d940094 Merge branch 'bnxt_en-bug-fixes'
> git tree:       net
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c5ef5f980000

#stz test

--- x/net/bluetooth/hci_sync.c
+++ y/net/bluetooth/hci_sync.c
@@ -308,6 +308,7 @@ static void hci_cmd_sync_work(struct wor
 
 	bt_dev_dbg(hdev, "");
 
+	hci_req_sync_lock(hdev);
 	/* Dequeue all entries and run them */
 	while (1) {
 		struct hci_cmd_sync_work_entry *entry;
@@ -328,15 +329,14 @@ static void hci_cmd_sync_work(struct wor
 		if (entry->func) {
 			int err;
 
-			hci_req_sync_lock(hdev);
 			err = entry->func(hdev, entry->data);
 			if (entry->destroy)
 				entry->destroy(hdev, entry->data, err);
-			hci_req_sync_unlock(hdev);
 		}
 
 		kfree(entry);
 	}
+	hci_req_sync_unlock(hdev);
 }
 
 static void hci_cmd_sync_cancel_work(struct work_struct *work)
@@ -5192,6 +5192,15 @@ int hci_dev_close_sync(struct hci_dev *h
 			cancel_delayed_work_sync(&adv_instance->rpa_expired_cb);
 	}
 
+	do {
+		struct hci_cmd_sync_work_entry *entry, *tmp;
+
+		mutex_lock(&hdev->cmd_sync_work_lock);
+		list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list)
+			_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
+		mutex_unlock(&hdev->cmd_sync_work_lock);
+	} while (0);
+
 	/* Avoid potential lockdep warnings from the *_flush() calls by
 	 * ensuring the workqueue is empty up front.
 	 */
--

