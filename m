Return-Path: <linux-kernel+bounces-411582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1F09CFC6F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 04:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8DC2891B3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 03:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB7F1917EB;
	Sat, 16 Nov 2024 03:00:43 +0000 (UTC)
Received: from smtp134-24.sina.com.cn (smtp134-24.sina.com.cn [180.149.134.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F24A1534E9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731726043; cv=none; b=SkY14uTZKUqcslx8yiK9oaBjxRBe/dsG/vQiKtXkwwroIG/PnK9/zM8oTOJAjxIe1UKOb5XBETFbVzbzezN9tZh3XMM5Qbsvj5Jv8YQ8V8PH9HE8REfMYYKFSEnjQ7QR4zx7s1hjgItFiisMv7Emq8r16iCJh/LOc/NUiIHRNig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731726043; c=relaxed/simple;
	bh=mvo5jZrV+aIhDnrISSa5yeUAd0n7xPw4pw3+wJbToeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f4Mc6bF6/84wjHPmQlhxLE2iOWAraz+ybjKz19ePRrSshXqAPGlyC3vkQjnAzGtBeTC+Z0Flt1EHICaENXUFxzLbzBgyK6WExq/e+N7fupkYBjcHXI8NDeArF3XHeGO0cPgA+2N8m8Ow7CrvDBSKWHHDzvXJG0F31+Mh0yq199c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.152])
	by sina.com (10.185.250.21) with ESMTP
	id 67380AC100007D5E; Sat, 16 Nov 2024 11:00:28 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9262183408370
X-SMAIL-UIID: 03A46EBC9AA541B7A30B76F4D81EEE92-20241116-110028-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
Date: Sat, 16 Nov 2024 11:00:12 +0800
Message-Id: <20241116030012.1036-1-hdanton@sina.com>
In-Reply-To: <000000000000ca8574062197f744@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 08 Sep 2024 02:07:21 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    f723224742fc Merge tag 'nf-next-24-09-06' of git://git.ker..
> git tree:       net-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139b0e00580000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git  v6.12-rc7

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
@@ -5185,6 +5185,15 @@ int hci_dev_close_sync(struct hci_dev *h
 			cancel_delayed_work_sync(&adv_instance->rpa_expired_cb);
 	}
 
+	mutex_lock(&hdev->cmd_sync_work_lock);
+	do {
+		struct hci_cmd_sync_work_entry *entry, *tmp;
+
+		list_for_each_entry_safe(entry, tmp, &hdev->cmd_sync_work_list, list)
+			_hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
+	} while (0);
+	mutex_unlock(&hdev->cmd_sync_work_lock);
+
 	/* Avoid potential lockdep warnings from the *_flush() calls by
 	 * ensuring the workqueue is empty up front.
 	 */
--

