Return-Path: <linux-kernel+bounces-225925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D55BD913794
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 05:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7279DB21DDC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 03:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1A2125D6;
	Sun, 23 Jun 2024 03:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="IP+TzyYX"
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67300C133
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 03:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719114157; cv=none; b=sbuKL9hW2dAaa+3ir+6dE0D6FKKHwDYJEA1DUAr6ZVDFUbEU+pMDhS5WLlmvdOuEbdmkGL/cRH568ZHZCk64QjC2JMk8ZDSL8zZ0QUsnpgxBIXDZPlHPxGYkXTmY63A07l1E8y/XW1DPpWxr/4b/xqXpoiiY1C47PML0gFAcqN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719114157; c=relaxed/simple;
	bh=1b2d1zwD+nJk0+1iQfqxGQxNXTBl76gBWs3mtXIqSqU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=giz4TCuNf8x3Tfp9clQ5d/Xr9aONBqhYH+AjpZ+zshsIJZbJOYjMmhnvtqMgdNlJHQeq2k1ehDOMaFfwWBkoLNbL6eeKbOKwJkCq0cGBTcHzsQg5VJ3AhyPs2w5ix1xS1upFsKgvHVndZ/ra6IDWQ5qFPDpD6sctOGAK0ahYNgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=IP+TzyYX; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719114151; bh=IsW4RUOG70FnebIvMX9fSfgltipaO9389oBA9Eb/BCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IP+TzyYXCNTlFGGhB4Fr9lHbx/q4evZcP/3Y/nHhvIW/1nubU8X9ytBzdDnwx6Pbe
	 aQb8XaxumZ1rHydTMpokBGjHCoF/A3SvH0b+8JDUj43EQwHNkRWtTnPiMXGwePw+Ai
	 /JOyx2yopN0zWCMgYb+ZZ39UnvOh7I2awYYhGNOo=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id A9DBA010; Sun, 23 Jun 2024 11:42:29 +0800
X-QQ-mid: xmsmtpt1719114149t7k7x7r1b
Message-ID: <tencent_C4F16D10941CEB5AED86CD707A4E6F502F0A@qq.com>
X-QQ-XMAILINFO: NyL4Ms7JjuobuGygp7A+RmvPhxeuuHQQN/UHQTZe4te4Rwm1Kh0ktxG4fXfJuU
	 eOuGV2EEwoLm+qL7ojuAkzhv0Hng+hfu/bQVkyoIg6iKeRFoJVVrquVfp5fd6qMEWKEc+3gmAv2n
	 8JyJhtnD+38zazViwRu3ppbBrPTNNsdGIVdquRfIqB/sVinzzbwVN4L3sEmqYSCmOXecNJYmXRBN
	 G1i86ARU3MdprqEhYcwiNdrAp5LPcjFPjVgA6TFbCGeFOLAtcatyw8tSKxe8oNRW58S64NkE0O9V
	 i5oEHGUeBRg7gBnfNXUVIPyhxPXwtiOpiBpKQxFycXuMeoDWcDd4q2TQEVuztQr8CWpBudw564QS
	 dSRM0wBRgxBzwbi8KbaYhlLaJ9qda8Z817GMyJYN6lrjD3NPjJSnsx3S2pfz3fngA5nT2icufYs2
	 HadKZbmVFE9UN5x3oOy5veD8wZmXXnFPeqkakp5t+55kyqlE7jxG5uaOC/ek+9nPYoMbbpwCvXXH
	 0Zegzzt7NI7k0+hgATJQljHZciyEdzGoPeutGW/sKcF8CdL3te6HD32RvDBEU/0C7eZW6ORPURhD
	 yKdb/e3TqHOkBRbIs1o0rVuCvh7nifmWLOTQKHx0y4fHTATd1Zc+C+1s39sPEdyxf+SsBo+DQ6bq
	 r8PgyqUvZfUUIniqCrWi7g35iwod/ZvBKNDRWutYpYGZmv1iUmL8MLu4sASZzPmVed/l00zo81sB
	 To+VnIb89NVCVcIyHyYTbSBvyEC9580cBn0xjMUFiDcVIA7GWBlQtEI+8P0RcPFk4WqawP+TnS89
	 ZQ32nGQzxRmTwIz3o/TekjlumYxNkuEXK6OCAGlNmzNOf3hfD+bZk8tXIuQmvTFsdeEu2hWvwzuA
	 myR2dCRV4EXfGgwT4b3XSMd7xQGslOJfLk4IoZGlZex+l9cGVWHtIVlIlLRgQokjfq0M+oNP+d8K
	 u/dyglpVDXmFPkTsWY7HDtVtifKLHKiWZA6q5LoNs=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: invalid-free in hci_req_sync_complete
Date: Sun, 23 Jun 2024 11:42:30 +0800
X-OQ-MSGID: <20240623034229.3457535-2-eadavis@qq.com>
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
index efea25eb56ce..c98d573eae87 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -106,7 +106,13 @@ void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 		hdev->req_result = result;
 		hdev->req_status = HCI_REQ_DONE;
 		if (skb) {
-			kfree_skb(hdev->req_skb);
+			if (!hdev->req_skb)
+				printk("skb: %p, fclone: %d %s\n", skb, skb->fclone, __func__);
+
+			if (hdev->req_skb && hdev->req_skb->fclone == SKB_FCLONE_CLONE) {
+				printk("skb: %p, skb fc: %d, rskb: %p, rskb fc: %d, %s\n", skb, skb->fclone, hdev->req_skb, hdev->req_skb->fclone, __func__);
+				kfree_skb(hdev->req_skb);
+			}
 			hdev->req_skb = skb_get(skb);
 		}
 		wake_up_interruptible(&hdev->req_wait_q);


