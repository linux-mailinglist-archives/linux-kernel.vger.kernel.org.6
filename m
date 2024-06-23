Return-Path: <linux-kernel+bounces-225912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E3B913763
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 04:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E44283855
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 02:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF20946C;
	Sun, 23 Jun 2024 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZyvpQkDD"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EDB2F4A
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719110205; cv=none; b=qdVUiMaF3H99DaqCEvSRtJD6YYHiCwe4nlmlZ1shgHZWC5RBRtfVxLAYSawrg6uu7eXpu8ILhKqbtAlsGJZYnTyKMbKxzaahqVKjTcZvr6lq79cXRrTsXDp75LLMRXy6dEU+NxkWMHpnxXOLmKV0ZqbiZTph1dEPN5vd2YWqBuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719110205; c=relaxed/simple;
	bh=6+W5s9z/1RC0oPC/W2Z8Qpqif1mAXzw52jIfrq64jXI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=FsX1WjKMrD8iedLVUhFrURiJOgA1ahy2edSJ+QXiObSTcAYwYlt7XZU0GN3JfUhwb9TPcDBHCDRENAVVe2uawefyujc3YHhh/o3WgDRl/PuwZRtY25MybfZZ5BsMNCshn9jiN4TYH/bEVNalU/Lp4FujKgLgXGxI1Grfwhrb8w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZyvpQkDD; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719110199; bh=tfqcN0VRIVQ+F9FyFjz8WL2n+Jtl4i2MDfN6H1a6NzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZyvpQkDDNqqLgfAZ/U0tiEA/JEUeeL9iz+KKshz5vR89P9u6c3Vbdb9PMRhVUCGLN
	 jm+8I02IjAXkNub21ww3IBATTOn50dXh2KPyzsVTUXW4ZBY38Cxdx04xqRze95jnxJ
	 r18UOaQyguCNrorQlF5yp3jQYcpTYDOdywYD4H8M=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 9260BE72; Sun, 23 Jun 2024 10:36:38 +0800
X-QQ-mid: xmsmtpt1719110198t2308miyz
Message-ID: <tencent_F6252CBAF6BB6C338E9E2C1BFF4B971B4308@qq.com>
X-QQ-XMAILINFO: OOPJ7pYMv25t4c2XTOKW2m2lXysaJ4pQ3184RSh6nO32s30D9XA4e783Bud/NK
	 dfb2w0ijqiJORDPC+xEd13+VcEF2bxF3n2fYZXgS+IosdW+BsM8IPjLFnJPWx4smbnzjT7+Q4TL4
	 owfj9x8/4wF1EIO64PFfsFUolcTiv1oOS6/aMhBzcwpkTK1Umod5Ca0yjFVuvcCVDhZFjRCtu/Fb
	 9cu13wvPMngZHB1Uln7DI9vkY1CWZF3cdF09qwE6sn43V8k7j+mBMvg6s6o+0aaTg2kgETGZwJnD
	 SEJMaze48whk9aRdpVY+zBchekRmX1Z3xFnvz+TWI2gCzMYSuF5OMw5oTmgF7cdSembyjT2RSjrd
	 6TDHcf40/AMjMVaSkhub98i/iECL0SHgZmmQDgOuTSu3QWLWhG18fwF+SOxhwrLLhpI3eQJnSgvX
	 3zGNa2prppOA5mCVnb2DIoeS2HHXljdPOKTAqoxY1jQX4Fxp3sWP3sAFgKUw+/ozlka/MXhNe1sI
	 XHZrp6pKWWkQUkQSTqjP8WWgIQ2lGz1hB9tk6XCJIqbdpFiA5W4mjWL0wnKmmlLAKv7Oo9kAC//u
	 1leNZKCK1kojCfNMjAF9rhqsmaTvAElmjQHGdyxBpKgLyWyem+xuTrNKK/T57U7Zh1DK/TtQNhBF
	 n+rq1SMnfBlmCouFdYhAtVndNlBkJ6XDknsoE2Ee8G6segPHpdY8at19mSkaySDN3YCx6om/JvQE
	 QzEFDgBHaQmZu9tQbsj3d75TSMy8h3hHoXQ5OVZaTg/SIno/RsQknR2p7HT2laQisrkftPIS6ddp
	 3YdIWPMT8HHhhs7/lE+D9UuQKbfzqenZMWnL3WMcCnLIwlG6Id74Qd6ZQVCJBlGjJ7STKVzT6/km
	 T6/Tn46r2h24lt4ueSIlzF/wbT3LPShs3E82GNw8PkkWtu/dHLu71f0IB8S6QAvi3RKZ+7sYbJ
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: invalid-free in hci_req_sync_complete
Date: Sun, 23 Jun 2024 10:36:38 +0800
X-OQ-MSGID: <20240623023637.3394117-2-eadavis@qq.com>
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
index efea25eb56ce..60a8968bf854 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -106,7 +106,9 @@ void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 		hdev->req_result = result;
 		hdev->req_status = HCI_REQ_DONE;
 		if (skb) {
-			kfree_skb(hdev->req_skb);
+			printk("skb: %p, skb fc: %d, rskb: %p, rskb fc: %d, %s\n", skb, skb->fclone, hdev->req_skb, hdev->req_skb->fclone, __func__);
+			if (hdev->req_skb->fclone == SKB_FCLONE_CLONE)
+				kfree_skb(hdev->req_skb);
 			hdev->req_skb = skb_get(skb);
 		}
 		wake_up_interruptible(&hdev->req_wait_q);


