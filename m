Return-Path: <linux-kernel+bounces-227174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1AC91497C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F3B28168C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914EE13B59B;
	Mon, 24 Jun 2024 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NGtmbrsm"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202D92E62F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719231221; cv=none; b=AOFWYgO9nHFl0zAd4fAF5HemquAWl8KV4FSNWZZtLIs8Tgcl0Z5CGirvx+y5fIio6RGdjYlyytnMaWnB7ekBEqL5nPDDcQVrSxCGXjeIKbhFuvHdR+Gl9QVo1N4fMxi0Y+0fkU3KhICuF8RtjKOjiKZZ+z7UAw8XTR6P/HiNT54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719231221; c=relaxed/simple;
	bh=GIxLdIsyWlZUZPcbyc0JyW6DAXfVqlQ2QrS9G9V95YE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Q9s9FXTzn6gMlWRKp2wFxRXObaGqNCI7Ohur1eQb/z/dgmbUBwl85IwNQdSMugn7DHDJ6GiQMFKa2FRrALwHBOcFlJd1MWJi6CuGF+MWfLjaOtecbjvPw76Ikv0avGokwJnYovVKJ6bHCMbnyWc+RsjKKTfismkBovI1O/Vsjms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NGtmbrsm; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719231210; bh=wQQy1lAElZCsGxIm/cSRalwDRWHw4b4nb35rnkPOCks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NGtmbrsmcBRkpKS30i/U3CQsa9dvPFMNBe9yd+Y7FGdSj5/UJdv1bHgNQgk955b9n
	 KSbe4EEs05SpJTyK+SLhTbO4znaMTiHUgM9tpF3LomzrUcqrg6YgTmeQrxrbfD1Hln
	 sXTQmMJWEGkY96g5kJvvaT0tBASqpdqKb+MaQZGs=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 1DA34473; Mon, 24 Jun 2024 20:07:26 +0800
X-QQ-mid: xmsmtpt1719230846t4o8h1laf
Message-ID: <tencent_86BE4A6A74B1761566A83D5B36EC969C3609@qq.com>
X-QQ-XMAILINFO: NY/MPejODIJVpgDJJE8wGTTIThhfHuhAQv7T0EqneHz83O9pShEBYr+OLZuxYA
	 VlU5CapZR9DSHJ9t27WORziFZW7xsXrWmMBm9WfGcy5Qjmg9DsE16K5R/nBfESUVJKkQ3PaVRd/C
	 HgKGAg/kyfpZP3hRQxlqZxLGzZuvD+e87TN0wKPrD7T+jih4VwKli8mKMoYo9eSOpgKIUJtvgJo8
	 8J/MNS6x33jbjRSjWWzfYK9AZEtoISC732QARZ/weY9rX2c7LHzBkqE3lo8xwTc2PMy/PgNe8Otm
	 i7YmFgbMuYjaxa/t9Gex66A1pWDHTeZlpYzQoLDLVvrbVfwr15r8FnzxxXJOU6I8uUapFetTRTBx
	 mCKHUpSDeLkKAXTUHperBStdVdVzVPo6WufxyteLTlC7M+u8n928hAIkOBAMYdDqfUM3FduPEwsG
	 HX/F7T6nQJ8MxvgpeNJ6uu7YL6RJPZgfrbi2SUhVOxj4IHp/zIlzfDEu+27ClhxJfVxWjusnfe61
	 Ig0ivzIybTCVSeZWMCxWDcj6+JDoBY1u98qIiBMgqjOOQp8r5KJp38f5uOlyGJzQ4Ij6ZmQ1Rm/E
	 QkUFlZ2bW+R06sgM3jLnyT8t3A3phnIYPRbWKpomrJSRIWCxygEumH4uNkwwWh58eTpro0AnWnuk
	 vn64xetZ56z9Sld+YfjVpBdCZZLMedyCYzw6fsl6C2cLq9iBYB93DJctgPwpyquH5TodSWSC9/5J
	 5DVUiAMXa9FQ2pL+7gI9h6cLw2OHSnxWFUjEjubgE3unXOfgXdWa9/uIK+cri05kuVcRUndIVSHG
	 u0Vvq0WhBSnp3CaS7YWfHcjHOZ+okIgZ5TsQkz8rFywq12dekWcns9/fm/LwaZcAxFRtIsDmIkoT
	 an1eU7PKrREZXuEhQ94U3E7CvJ2iKobwXGUIS9nvzWwuJ6W9auRRlNnvYazQtZ4rpHNYJCAHHK
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: invalid-free in hci_req_sync_complete
Date: Mon, 24 Jun 2024 20:07:26 +0800
X-OQ-MSGID: <20240624120725.4062978-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000033a6e8061b3c6d4a@google.com>
References: <00000000000033a6e8061b3c6d4a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test db free in hci_req_sync_complete

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2ccbdf43d5e7

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 3862fa6bb288..4d5807fff946 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -121,6 +121,7 @@ int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
 {
 	struct hci_request req;
 	int err = 0;
+	struct sk_buff	*req_skb;
 
 	bt_dev_dbg(hdev, "start");
 
@@ -182,8 +183,9 @@ int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
 		break;
 	}
 
-	kfree_skb(hdev->req_skb);
+	req_skb = hdev->req_skb;
 	hdev->req_skb = NULL;
+	kfree_skb(req_skb);
 	hdev->req_status = hdev->req_result = 0;
 
 	bt_dev_dbg(hdev, "end: err %d", err);


