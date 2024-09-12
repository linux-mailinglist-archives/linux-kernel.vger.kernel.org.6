Return-Path: <linux-kernel+bounces-326431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CE0976842
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AB031F2217A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 11:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBF51A3025;
	Thu, 12 Sep 2024 11:49:35 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3621A264C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141774; cv=none; b=S3x8LFq8+uhhlCVKKkbv6+IGeS9h1zlE7fAuYZR3/PCw/dHvj93i4+oNqY42EWtVHi9kuFEaQ1kwINS4SPQ4Z131GsGGny9bgiVYKV8AKtm6aIxDRXt9JC2+yKlyQBzv0N8Y7I1fN4AHbO2RJncfvq/mt/9/xHbxFTlv8qPIrT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141774; c=relaxed/simple;
	bh=wF0SA/1exCcp+O+tObj5khz6T3eGucy+bFebMkhCaSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rT1h0hVyHIdpzoI9/+FOoNN3p8XKKTUtTxHf4gTk1+t1sv/uOD+C7kqQRIxjKFnq84rtKcYhfbqJBUsGX45773alFjWCAxcSHAtdaag/VsUn/OcZPAJFU3XdecehalyKNoOaQYQeXQVrNeCnfAoVRGrEUWgDiOocaUpzCZpGS68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.190])
	by sina.com (10.185.250.22) with ESMTP
	id 66E2D53C0000767E; Thu, 12 Sep 2024 19:49:18 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9166587602646
X-SMAIL-UIID: BF86566F7D0A482AA9369AC033C5D3DD-20240912-194918-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_connect (2)
Date: Thu, 12 Sep 2024 19:49:08 +0800
Message-Id: <20240912114908.2976-1-hdanton@sina.com>
In-Reply-To: <0000000000004a130a0621888811@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 07 Sep 2024 07:42:26 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    788220eee30d Merge tag 'pm-6.11-rc7' of git://git.kernel.o..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1304189f980000

#syz test

--- x/include/net/bluetooth/hci_core.h
+++ y/include/net/bluetooth/hci_core.h
@@ -511,6 +511,7 @@ struct hci_dev {
 	struct sk_buff		*recv_event;
 
 	struct mutex		req_lock;
+	struct mutex		rx_lock;
 	wait_queue_head_t	req_wait_q;
 	__u32			req_status;
 	__u32			req_result;
--- x/net/bluetooth/hci_core.c
+++ y/net/bluetooth/hci_core.c
@@ -2507,6 +2507,7 @@ struct hci_dev *hci_alloc_dev_priv(int s
 
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
+	mutex_init(&hdev->rx_lock);
 
 	ida_init(&hdev->unset_handle_ida);
 
@@ -3977,6 +3978,7 @@ static void hci_rx_work(struct work_stru
 
 	BT_DBG("%s", hdev->name);
 
+	mutex_lock(&hdev->rx_lock);
 	/* The kcov_remote functions used for collecting packet parsing
 	 * coverage information from this background thread and associate
 	 * the coverage with the syscall's thread which originally injected
@@ -4043,6 +4045,7 @@ static void hci_rx_work(struct work_stru
 			break;
 		}
 	}
+	mutex_unlock(&hdev->rx_lock);
 }
 
 static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
--- x/net/bluetooth/hci_sync.c
+++ y/net/bluetooth/hci_sync.c
@@ -325,9 +325,11 @@ static void hci_cmd_sync_work(struct wor
 			int err;
 
 			hci_req_sync_lock(hdev);
+			mutex_lock(&hdev->rx_lock);
 			err = entry->func(hdev, entry->data);
 			if (entry->destroy)
 				entry->destroy(hdev, entry->data, err);
+			mutex_unlock(&hdev->rx_lock);
 			hci_req_sync_unlock(hdev);
 		}
 
--

