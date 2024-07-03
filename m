Return-Path: <linux-kernel+bounces-239249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 639D792587C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1C2AB22FAA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8182515B984;
	Wed,  3 Jul 2024 10:26:59 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D23156F28
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002419; cv=none; b=kH7z02UJDcQl+C4Dhkmr7QRrt22NR0y6DxKaCJ0JX0slLpCgsgUJ8V7GVsaPxUwQiE9dape5mF4hGa+ONNqZAV6QEDAW3CZkfdriILWAt78+DiIsrj20pi8cEWcplOAWtOo1itlrZ46FDnmJg1NJq9oN+YQmVNrs6RKtoew41v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002419; c=relaxed/simple;
	bh=Lyl7brd58UZD41Tu4tAVEWaLVNMkmy7WTmd0GqIb8j0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SkGyiJaKLB2ar2K0A5w64D26bZlSngbTtptu1NdwU6Ws1RSQLZi/8/5G6lq8HZ7E8SlnTP/7AtYtDPOqYRqQ9hkywyWxV/pNZLWLat3nUUjzY5sZeRg8rAj0TcbZ2GHoeQXvBsiwQEMfMCPbRnEgUwS0rauBX8U7LfvRlRcN3ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.67])
	by sina.com (10.185.250.22) with ESMTP
	id 6685276200007C60; Wed, 3 Jul 2024 18:26:45 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 962727602745
X-SMAIL-UIID: 305151AD62A1492E90EF020340F63037-20240703-182645-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+91dbdfecdd3287734d8e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] possible deadlock in touch_wq_lockdep_map
Date: Wed,  3 Jul 2024 18:26:33 +0800
Message-Id: <20240703102633.2821-1-hdanton@sina.com>
In-Reply-To: <000000000000fb901b061c4e0282@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 02 Jul 2024 18:47:23 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    734610514cb0 Merge tag 'erofs-for-6.10-rc7-fixes' of git:/..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1424d281980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  734610514cb0

--- x/net/bluetooth/hci_core.c
+++ y/net/bluetooth/hci_core.c
@@ -1075,6 +1075,7 @@ static void hci_power_off(struct work_st
 static void hci_error_reset(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, error_reset);
+	bool put;
 
 	hci_dev_hold(hdev);
 	BT_DBG("%s", hdev->name);
@@ -1084,10 +1085,13 @@ static void hci_error_reset(struct work_
 	else
 		bt_dev_err(hdev, "hardware error 0x%2.2x", hdev->hw_error_code);
 
+	put = !test_bit(HCI_UP, &hdev->flags);
+
 	if (!hci_dev_do_close(hdev))
 		hci_dev_do_open(hdev);
 
-	hci_dev_put(hdev);
+	if (put)
+		hci_dev_put(hdev);
 }
 
 void hci_uuids_clear(struct hci_dev *hdev)
--

