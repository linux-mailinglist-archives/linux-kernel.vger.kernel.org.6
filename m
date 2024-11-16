Return-Path: <linux-kernel+bounces-411556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B4F9CFBE3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43CFCB2A91B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4EF746E;
	Sat, 16 Nov 2024 00:58:49 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03DB184E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731718728; cv=none; b=UT21fNpZiCOFjOfRX05MIaEt5uZE1IEmSVkqlNxa/qPl/Y/tajGI0coegsAjJ3viKaTEb07A/lyLekWiVy59XF7SO/nnwyzJugXBdycUtvyfH6RpTM+rFTYeRfU4nTFJGOKP1NaD60STm3aHMKOISbRh2sZ89GwTzmwauBWjRz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731718728; c=relaxed/simple;
	bh=YaW/24nK64co++amxOfrWIgnzOV7/IvxdQD0kOXWSgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ai1/z5/3Ny7oxdKO/oUSAQPzxw7t8TkLWW07hFbpsbq97lNJZX/V+0xcGjmip+KYmu3MvBQutNy/nK5aPF82lI8iFh/L2tLEgyJ+AVRl2Dz1XOcXBMA1kV38V2vnZon+i/rEb51zUXOSSbp3kJXdAUk2eSVjvLtY0qoC8PoPsYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.152])
	by sina.com (10.185.250.23) with ESMTP
	id 6737EDAA000073D3; Sat, 16 Nov 2024 08:56:14 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4408438913378
X-SMAIL-UIID: 86DDCF6805E64E25A9F4367571791727-20241116-085614-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
Date: Sat, 16 Nov 2024 08:56:04 +0800
Message-Id: <20241116005604.3932-1-hdanton@sina.com>
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
--

