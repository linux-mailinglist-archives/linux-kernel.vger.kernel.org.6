Return-Path: <linux-kernel+bounces-228165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308F0915BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 904A0B2110F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0E61AAA5;
	Tue, 25 Jun 2024 01:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="i3OBgSmW"
Received: from out203-205-251-82.mail.qq.com (out203-205-251-82.mail.qq.com [203.205.251.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C510918B04
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719279418; cv=none; b=AKQvXpr0MJDE/ACmuQ8xCn7V8XAUdmjFLtO8WTob11I9iubnZhxoKjRsCPTT6+pjoGgFnInzskEqI7U3he2QEMK2Ks+1qRY/9RIsRReqT1q0FyU8xvCmKfEwaNmk25a/ZaHB3CYiQMF7WQDtFLxACQOqoz0MHVKDha3mNb/3JTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719279418; c=relaxed/simple;
	bh=8EjHr65PqUluLMIlelVxJBgfD9kXSwBVKfIOEhpRwzo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ueYaQZBBLbddgFOwDVgKVyIQoYvOTRoOdHEHDrLsxWw53m/XAiRzRuNnGpZYT2pGQjwORldoDU8LHGwM1IMal3dOlIyRE6VGW3G/AY5LzoEmPstOpGjkxxS1cz3OMKyOVt5fWPDnmOzH181/avK6S2Yr3UIDwV85I7cVIN6Kyb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=i3OBgSmW; arc=none smtp.client-ip=203.205.251.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719279402; bh=yG9CowTovmcKn8NWGo6ZF6s/KGjA+Y734rgmx1QzCA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i3OBgSmW7HmFyOhVsp29o4YWM48hYpEUPyo7XeGN9yjC+NyM6qJM15WTt830snO+z
	 RglwID0VsWqalSLfTs4e4GH5RPIDlP+fvVqEAY8ph2vC5FqgE0Oj2kGnNC+61/Ih6n
	 S85mn+eGPG7NntJbdRlVTJY1g7OP+WdbqptoIbT0=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 7A735A42; Tue, 25 Jun 2024 09:30:39 +0800
X-QQ-mid: xmsmtpt1719279039t9abxdiiu
Message-ID: <tencent_76254CBA77BBB533DB9E261BD64BF01BF008@qq.com>
X-QQ-XMAILINFO: NzOHSugmTg7Xb8RikqmNW57/7zEE9VYMG4ZH5GKELqjUgQV84pgKZXiyG2RKrN
	 57nzPJIedbMPGLuaMXRYtGbA+TLFlC5U+4pbx9pMCTvKBTuYIIvgquAAoxfFl9OO2w3dvkr9RV3H
	 Mz2nQmkOV9oJZ0P4UujlKM2kFCktbHQpi9zc6MMhNo7QyqMOGvhSJjgUqNXOIGC5CAJHRs6OW+6n
	 fFWlpokewicuVqCzFoqUcdxOpi9bO/gw5U3NsbZdCajZdYvvhG8I+X7W22A4e4yWnoojmvBL/9a8
	 AWdlVNBI6ABHksbVIhYcIFizfeYMFaRJTA5x9x1RAqbX+dmjJez486DK6D6xuO5EKVB+prAhXYTW
	 Liu4NsxvUSmN/AJWLZsDGXDEx7BzaHIonncs4qoa0GUEV+P07woKVy//aSpmFa6tadk93MiEAn0r
	 mrnqSCBLK2UVQ7g9bxA2rtzGCnhIZNLKmOhsgxoKaHJKEQQoPEB4QOBU8Mntc+/JGez/mjAqnnEp
	 fA6K7SV5SbCKEMCkPczYySAePxWZGYDxFbj5LvIKnZ7ScivIgztpWbphO5zDV300xhjguUf/McNk
	 UeL7PMs3gbiP4aOS6yBJG6eKbjIH8Ae/CvfBTHT3QfXBEJERQA2It6J24tFzAP+io0KWcADhq2S4
	 B6QjPg3oCS0gTgFapC3dVS1psJuaFEMmViKNwnogxrmsoRt68iGUGDmA3mdkKS3XqMW76wmNDTiO
	 IVqyMvPoV6WasNZZPoWTWW+JIltp4sUK+0qTZM/o7GEIMCiHnccejVzEirQl3HsLE+LJWtah2S0F
	 fovI0W1NE8A+hEn5Aba0zc1InV89KGMnUsVrKCj/dkOpmjonSkopP70wM8r/CWu5hG1Czf4pHRlD
	 9MHRmaSnwhF7l3y/S/2eniLLqxOTMMu7MfFQBPH4M3M3L2nvFxhi5Bd3Tf8RgpuC8g1O5ChiPK
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f115fcf7e49b2ebc902d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in sk_skb_reason_drop
Date: Tue, 25 Jun 2024 09:30:40 +0800
X-OQ-MSGID: <20240625013039.83412-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000387998061ba467ac@google.com>
References: <000000000000387998061ba467ac@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uaf in sk_skb_reason_drop

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 84562f9953ec

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index efea25eb56ce..6f3e2e6cd2f4 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -106,8 +106,10 @@ void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 		hdev->req_result = result;
 		hdev->req_status = HCI_REQ_DONE;
 		if (skb) {
-			kfree_skb(hdev->req_skb);
+			struct sk_buff	*old_skb;
+			old_skb = hdev->req_skb;
 			hdev->req_skb = skb_get(skb);
+			kfree_skb(old_skb);
 		}
 		wake_up_interruptible(&hdev->req_wait_q);
 	}
@@ -120,6 +122,7 @@ int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
 {
 	struct hci_request req;
 	int err = 0;
+	struct sk_buff	*req_skb;
 
 	bt_dev_dbg(hdev, "start");
 
@@ -181,8 +184,9 @@ int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
 		break;
 	}
 
-	kfree_skb(hdev->req_skb);
+	req_skb = hdev->req_skb;
 	hdev->req_skb = NULL;
+	kfree_skb(req_skb);
 	hdev->req_status = hdev->req_result = 0;
 
 	bt_dev_dbg(hdev, "end: err %d", err);


