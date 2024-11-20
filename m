Return-Path: <linux-kernel+bounces-415687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CE69D39EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9835B2955F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907AB1A7264;
	Wed, 20 Nov 2024 11:47:38 +0000 (UTC)
Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB421A08CA
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103258; cv=none; b=Ki4NER5p37FjoyWxB91PfzR0NWgw+gqZPqiO60kIP/T5TjwTxZ+mrHZAkaYYsPNmnNC2aHHJgf7M/Rt27a7C0fKcFGYFDt3RW75YdPef461heGMS2Fm1YPp47DUU3tI+fJ9aby29zLzfbO8iOuOzkSDlk0RXXrdbRFareIGA45M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103258; c=relaxed/simple;
	bh=vg0dgulQ6/Mv7SZhnXLETZG+jQxfcjSh+ndeykGBdL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GZAmXmDiSx/trj3U50fYv5u9/Nc2hFIwlU9MTzscPY1uRnu+xtnqUik5/1VuQcNAv4t4hKc7QnijCD+Fzx4r28GZpdMRDK2aKwBTt2uBjWiEBctW1fOIKccJDvTzInHP2btg1+20lT4WICIiCslLGDcx4/+nxJtdThGE9fcpNGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.11])
	by sina.com (10.185.250.21) with ESMTP
	id 673DCC4000003B09; Wed, 20 Nov 2024 19:47:17 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5999363408448
X-SMAIL-UIID: 8F3EECE0BCB74ED1849098864C27FDCA-20241120-194717-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+3e07a461b836821ff70e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_recv_frame
Date: Wed, 20 Nov 2024 19:47:03 +0800
Message-Id: <20241120114703.1293-1-hdanton@sina.com>
In-Reply-To: <673da95e.050a0220.363a1b.0009.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 20 Nov 2024 01:18:22 -0800
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    a5c93bfec0be Merge tag 'x86-mm-2024-11-18' of git://git.ke..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12694ae8580000

#syz test upstream  master

--- x/net/bluetooth/hci_core.c
+++ y/net/bluetooth/hci_core.c
@@ -2901,12 +2901,18 @@ int hci_recv_frame(struct hci_dev *hdev,
 {
 	u8 dev_pkt_type;
 
-	if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
-		      && !test_bit(HCI_INIT, &hdev->flags))) {
+	if (!hdev || !test_bit(HCI_UP, &hdev->flags)) {
+out:
 		kfree_skb(skb);
 		return -ENXIO;
 	}
 
+	hci_req_sync_lock(hdev);
+	if (!test_bit(HCI_UP, &hdev->flags)) {
+		hci_req_sync_unlock(hdev);
+		goto out;
+	}
+
 	/* Check if the driver agree with packet type classification */
 	dev_pkt_type = hci_dev_classify_pkt_type(hdev, skb);
 	if (hci_skb_pkt_type(skb) != dev_pkt_type) {
@@ -2933,6 +2939,7 @@ int hci_recv_frame(struct hci_dev *hdev,
 		break;
 	default:
 		kfree_skb(skb);
+		hci_req_sync_unlock(hdev);
 		return -EINVAL;
 	}
 
@@ -2944,6 +2951,7 @@ int hci_recv_frame(struct hci_dev *hdev,
 
 	skb_queue_tail(&hdev->rx_q, skb);
 	queue_work(hdev->workqueue, &hdev->rx_work);
+	hci_req_sync_unlock(hdev);
 
 	return 0;
 }
--

