Return-Path: <linux-kernel+bounces-209239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C38B5902F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C69A281FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484EB16F91C;
	Tue, 11 Jun 2024 04:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zH6ECC0L"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AFC63C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718079007; cv=none; b=dOVFxBmL67RztaON38z9KAu3sk9M++M/E/fGQt0ccgBwY616uPZ6c6CwccTC3BifUcTR78CJemeBszFQh6RF4Pp9nQqkfyj8q+2ESU/sFp7PkzWbrIZ6VmT7tyuWdDmVedoWJHlZ/gHTaCOWPlfQO3bzqQ+UxNPaUICp67HDEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718079007; c=relaxed/simple;
	bh=1xOx3yJ04Mv14BS01wdyk+qzPNe+6u3FXVklABZv9a0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=A2pOGMMEZ16v8ARbtd6FRTABVz0JlfkR3Oisu49gTT7bz3gou497Z1yNEwSbuFVmwm1O8SJSzAcg4NvgREgjKwY/PMmiP/y5KawyFqiyjv0c5czdxvj0Jke34Cqi5WglCHK4xHm9+5+81X+0SQt5VohxRDL3z46ETROFpExXhnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zH6ECC0L; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718078994; bh=LtBwg1MlQJhNtkblkMn8rKLkAhBB8bg/QB+Cycj6txA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zH6ECC0LxyUjPQqfL7srrrXy9/dVqo8h6P48ba19gwmmUr5Mm2HOQU48Dz+nzEfYp
	 bOxZWoJH4LR+9wWkVZQ+xmBcxk8pXnkaAv4n0X027b0sf/dRz2syTy0I+Eql9Et6aM
	 u7tUhxJln4vvVBJ4Rjsrm6f82PpYYU9gCpnnktq4=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 27498407; Tue, 11 Jun 2024 12:09:52 +0800
X-QQ-mid: xmsmtpt1718078992td6azahk0
Message-ID: <tencent_0036E097CA36A84BFA74C177EF66FC3CAF09@qq.com>
X-QQ-XMAILINFO: OW6mPzc+Kmdza9KlGhs4hFMNZI2iQyh2ZWRLnPifYiadOOAXon4Ix/x7ylGKxO
	 a4Q7S49jLE45fQJR0aeljUBbVm1OxpbhUYiXIazIbRJflxLo1tu5GXOe9+3MLSUkFvlJFSKusGiU
	 g26jzAAWcq72IPj3ZJESr6l1+9GnhthP3UtuSDNKGoavPPCiOmEVeveLkf34YBcGV7uwgC6pMMud
	 3SbI3fWPTsPKLK75ab5OxVVqvjAjkDIbsZaa+fNR1d2UZf/LiDKoYSb2fPAalZLYjrXHRqF3MAOh
	 OS5gTOgNoc9NbZN+/AlQr4Rap/anKowbuVfR9aHQnaqyUKLsh8kCmIRCSffXDp0eZAGDFceYOtsF
	 5KveiZGCIURiQOK+lCQx/l/aOaZeIawx1IFbJIlBUH1fPRJ7fu6NMwQ15fKhXDuO1f60KUhc9luM
	 ZLUrhyoxPnhfGhHXxren+emcnbnlHsykclvo8PBGe6QGrfA2IyfbH0AI/Lysb4QMXrxlh2wU9WD+
	 bvpxbuikgxRw7PKJgtI0Qbg0QOLJuKaStipE3i1FyK5T7tKkGGLiJ7aLsjghl093pYn7u9HSJ6P4
	 TdtIXfiYJ6SpVlyenReP7pyqgduDDX3wrdWK9CF7qEWSsBVB1cKN8BiBCXt8iWVYseRYnrRqkk0o
	 tgxEwGXn8c3d7zniS44DhGAZyd0McEEs9HPqwixYmTQGXVuEcB07fuR7rUoiOArspfl2ybJIdPC1
	 aAkoEJD+FUO3jdN77kPJUF1wYmHHtU7bqKa7hkJXeDpA2gMfSPTHuwvE6dCx771D3HfZduEjIBeA
	 clwgziT4kt0JUiD2nGy/FzfNu5FJQB8VZmBRqpIxPra0VLjz6pTg4TgWVQi2oVSkMD83cXlUNaB+
	 TnFb7LpuJ8X9kWz1Iqgtf94QVMmHJeNFzOceDNVHKttl/vm4qInLtGNs5T7U5qjikQpqwSrVgoGz
	 /0naCfBrk=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
Date: Tue, 11 Jun 2024 12:09:53 +0800
X-OQ-MSGID: <20240611040952.1512359-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000b0906d061a468b93@google.com>
References: <000000000000b0906d061a468b93@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test null ptr defref in l2cap_sock_recv_cb

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git cc8ed4d0a848

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 6db60946c627..278cc4db922f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1486,7 +1486,14 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 	int err;
 
 	lock_sock(sk);
-
+	sock_hold(sk);
+	l2cap_chan_hold(chan);
+	l2cap_chan_lock(chan);
+	if (sock_flag(sk, SOCK_DEAD)) {
+		err = -ENXIO;
+		goto done;
+	}
+		
 	if (chan->mode == L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
 		err = -ENOMEM;
 		goto done;
@@ -1534,7 +1541,11 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 	}
 
 done:
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
+	sock_put(sk);
+	if (err != -ENXIO)
+		release_sock(sk);
 
 	return err;
 }


