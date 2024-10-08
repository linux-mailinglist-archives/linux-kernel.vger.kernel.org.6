Return-Path: <linux-kernel+bounces-354924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F749944A9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81FC2870CE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94375185945;
	Tue,  8 Oct 2024 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="h+Udlwas"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1420216EB42
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380874; cv=none; b=BYBysiW4z89gbX9WVz7rrHL9BbayxFyY0w4FfAzP6YmbZjH36G7pVhmGwasnPtVs8TVaho+9vgAW5fb+LO45feQoj2Yl54UB2m+zF4Z7g2AkGugnv5FFZP1Txb/7L6CAsc5RZ5peegqXNDHmw1SzPfL0CW3t6lwl8pGn85e9/YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380874; c=relaxed/simple;
	bh=vdkgWC1VGtHqQ5/DMFASq77YSXBqJVNRiv/dL+dDk1k=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bAvfBkO7SIyIYhObyToLrX9feyNIPXXgcUbNntHtkv7tjjKQ8kAcecc9stUx/G5bKzMyi7mSFJMVWQ7j2v8abuJbwTLjxWBIrgg+GfFM/rQQnqnhGTrC1SRrUhPiJ8e7IzEMgYvIbTVG+ERSTlApTY5Wjy0M1aYOyNcUo3lZNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=h+Udlwas; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728380863; bh=sM1Vx7uEDLDdo9UpFpm77dgeh5hlNeWrphun466pwck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h+UdlwasaOxxdecy0Wj/b1hxXF6shfmGl5QXNVYbyZHmMRALf0YZHFyOJbflrzlnM
	 eeohxep80QOBkkEvqK4aBplZdzrqFfoJ93TwvKnlwFcR53xwvZzvn2WTJN9AOc4936
	 10TPcjhPMfvm2hoDs1VdSrz2Qff8iqII6troIl+E=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszgpua4-0.qq.com (NewEsmtp) with SMTP
	id 79C3405C; Tue, 08 Oct 2024 17:30:28 +0800
X-QQ-mid: xmsmtpt1728379828tgb2y5bd9
Message-ID: <tencent_E64189A52EEFAEE6CC83A7C746FAD2E6C606@qq.com>
X-QQ-XMAILINFO: NLjOrOCrlCm6ji8eUvpsgdY9AYI/jVVTCa4tf1WjhItHOMm8jaCms6ZG9AImf5
	 KNBlLIhaaA9wi9Yz4j1DFw+HaGZSHiQYpi9w9zmdEdfSbyM8o5T5lkP9g9v8ec4t7AOP/Zny+/SX
	 Nc5wK2PoZgNOFvLjaSXZbrRI5nx/zYBZ5nQVyQ972M1LKfSr5oBC20DtXr6q7ouLzLmIQPlD0mHd
	 DAYrc13/G03xec7ZIu9N433H4HfT4E8Wvnlfo7cDVXgQS3K+75vuKNEucDaeudoeCBC1Ss05i7eq
	 hBS9EuPwOlHb/HBtIiag66GQdi5heYjHXVuoOeDYZhzERSyh+VYjKZVTy4r0XdE44hBpOuAxgZb1
	 tkqivjL/c3m9E8Ykb/QtxGOpd7Ms+iFgtZQms3qibKz+UTNs2VgWB66eMwz8096f7EsXd/c37U+1
	 xnaVzgLc/Y30xv0I+Mi0YZPuPgvfPjIfET+cndzgUpbBxm1Khx5eHHt78x9Bcx8WVMj5SL+2x0IE
	 ZkTWuMR8ko2h+ZU4gC2RsO19r0eGstoZUurm7PQS/bHM99f2MtJb6sZ/pL50kW+W+thiOl70CujU
	 C55dzUozdHwCCsi5FAlTGU61gX0bSIoGx6OyGDagGfSxpWC16ItEBSudSj2l/cunxm83mtKEGh4U
	 hu8ENh0JcXN0auzvofRIiS25U04Y/fR+xIvXO6daDFIaQyHXrT+aTr1jDI5yrzwdZ7GO2N70CReh
	 n0TIY7Inuuob33BQNvX/8X6ymCjQ0xFMxHSPacDNi90XVmz2wDNPk9CyHPdND2rTrR9PN5/vEfL8
	 RmWKhdvZV5JsOOua6b6OFazlMDxKLiOEiYH/qFyd3mQBUM9VQxAFClz4r4pyqkpmhfiZ2A1k7ZXw
	 lRZICQOCSdyMgD0TWntdEzgxgRjeTqomHnOG01bOL297pjuh1/O7WsBmgwL5nGOg==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+6ea290ba76d8c1eb1ac2@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KMSAN: uninit-value in hci_rx_work
Date: Tue,  8 Oct 2024 17:30:29 +0800
X-OQ-MSGID: <20241008093028.434627-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <6703b264.050a0220.49194.0502.GAE@google.com>
References: <6703b264.050a0220.49194.0502.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If hci_queue_acl is not executed, where does hci_acl_hdr->handle come from ?

#syz test

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d6976db02c06..6e22eb33fdc7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3185,6 +3185,7 @@ static void hci_queue_acl(struct hci_chan *chan, struct sk_buff_head *queue,
 
 	hci_skb_pkt_type(skb) = HCI_ACLDATA_PKT;
 
+	printk("conn: %p, cnn H: %u, %s\n", conn, conn->handle, __func__);
 	hci_add_acl_hdr(skb, conn->handle, flags);
 
 	list = skb_shinfo(skb)->frag_list;
@@ -3791,8 +3792,7 @@ static void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		l2cap_recv_acldata(conn, skb, flags);
 		return;
 	} else {
-		bt_dev_err(hdev, "ACL packet for unknown connection handle %d",
-			   handle);
+		bt_dev_err(hdev, "ACL packet for unknown connection handle");
 	}
 
 	kfree_skb(skb);


