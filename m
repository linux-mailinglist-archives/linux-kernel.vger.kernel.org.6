Return-Path: <linux-kernel+bounces-225928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C7591379B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 06:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F4DE283123
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 04:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B5714A90;
	Sun, 23 Jun 2024 04:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="o+7m8TFr"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69F1D524
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 04:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719116411; cv=none; b=ltSN6tDSF/Q1Aqmc2fID/C2qxGl9q6ws6wGUCc19PL9bTDphBhmN7tU3xHR0mLUlgn+BCGnZ+6ve+cFDBumUMvjoDZZ7KmSFaK0m/Ww/4UoM5nCi02ghVkdtBlF5lyYaBxq8a1LTnw26qV+dPzw48+sQje9xSIlyQT3cKO2tgHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719116411; c=relaxed/simple;
	bh=VdSmvrLk/QtchTc8ShjRj8Ugf6bt8rAXNS8beFcth/0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ILlCLTuPKeIqIHjBCzdbGXNIwuFYgkEyS+lxxUAouQGihEX6M6oukdpjsW2p7Tug3uzPb4htdA5/hb1sPWLuq5qsFObH/xrUYaYCiY8bWT1VfFK06uPio2OPuKMUU+i/hrRfuLw6jJJLN85CQw/72Ok3Ezt7uwV5yOH/ExFVTjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=o+7m8TFr; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719116096; bh=1JsFmtWHZc/HoEzWT90oxTfyq5Uyb6sS9o2y9VsWhyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o+7m8TFrvgLZBA8K7Xj4f+K6XZFKtkzrVEfOfMvRz9TXnCPMOB4shkYen73F7AdgV
	 FG/C2tYIDP8XnrfNN7zYhRH5oAaFYrbWI6hl2IGODFaVvb+vLKWCh/5MxicwRIaPRy
	 zdgiYNNIoAhM3atEHSCyH8ERS/rUFHAfx7u6KRU4=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 3B68041D; Sun, 23 Jun 2024 12:14:54 +0800
X-QQ-mid: xmsmtpt1719116094tkjahl3wl
Message-ID: <tencent_F9D62EDA8CB367C4C6FF92DB065589966E06@qq.com>
X-QQ-XMAILINFO: MQnXMcppzH4KJzkItbeakF8BRthJVYInrlvUoughJqH6KYIltJQdhgysuRbXxj
	 1CsVfD0kogK/KE4MC7DH3+7SnrtndrFVltJmnLlsi4bDxkd+IHqInimDyA2nxM8/KZKaZoeq9r38
	 IZ7XbcKhOJ+jMaNOfvw0c05toDcEM23XALlr4LRJGdA7xpGqmVE0DO6yyWq2hO+yFY5l8GzOyazN
	 vYUnOAeEacZJYCsIvDRKQ0crTmJHAPxoaEblbUvK15OawM0T0g/DDPecQPRUoboRUjiptaq2IBpb
	 P3bV8JilmKXCvWFe5lx3Nw8HwDaVUq1sjkWu+lzA8Jv5tWMHj4fGLrbrei3u7h4FX5YlPt7QlvyK
	 0sqadSvaatbskXNpykjiLeC0mzapL+fD61tG5zmyQwf4IqP9DEEqKsOzTfSjaxNTX7kWhnQQ6WZJ
	 Dz4vtjwUN9ln23xBtIEh9hFfDpGc8OJPdDMvuQ51W7vTrFRj87ykNnnK2KYAMmCwtfNksG0lh4Lx
	 Z4wZ5HOz/hC5LpSnutA0Mj5zXHCfNrpE+/W1holMXnaL/UnTB03uNE5Osm4E/V//HBNEqx4yk5Nr
	 wXPtoGOVEVYb4rwVyfkMqPvP2cpur3JoXTh6pk3fPD82p2UamGvdDdG2Dgr4bmX5kuA20r7+An3N
	 2IXiT3BYLFFSVJG3h+d/kn7WP5/pBYwdNwlPgyZIg99U2ZPzIT98XyZuW174+dkJzfzYsXQh6eXi
	 jpZx1451IomLqz3DE9t+ul52Me/OvnJbx/rQ24N4hqFdeWqQgJjwnD1ypM+9KvDvoKXdDlOJ3vPh
	 3oT1StI7mzNMpHUNcJLuYnU+ghpP8iIxi2sI5CQOFaSolVWOgl4+w/kHGKyWR2jyY0WA88d+nNhm
	 pXKXHy+bILLr+kILHFcuR3ULjt5DVJptGd8gfk0Epe0AVrjF4L+VFu0FdlsrGU9L+cZWAZzzf93G
	 fBtxluq5ybtHPjdisNZfjwzgIM5msj
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: invalid-free in hci_req_sync_complete
Date: Sun, 23 Jun 2024 12:14:55 +0800
X-OQ-MSGID: <20240623041454.3488644-2-eadavis@qq.com>
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
index efea25eb56ce..3862fa6bb288 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -106,7 +106,8 @@ void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 		hdev->req_result = result;
 		hdev->req_status = HCI_REQ_DONE;
 		if (skb) {
-			kfree_skb(hdev->req_skb);
+			if (hdev->req_skb)
+				kfree_skb(hdev->req_skb);
 			hdev->req_skb = skb_get(skb);
 		}
 		wake_up_interruptible(&hdev->req_wait_q);


