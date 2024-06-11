Return-Path: <linux-kernel+bounces-209186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0509902E71
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D95F2851F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8908016F851;
	Tue, 11 Jun 2024 02:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="d4CCwgxD"
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737D614F9FA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718073294; cv=none; b=e9Q4R7oX4d5M4apWsNb3cg7hv2kbVcv2BB0ojbKTiy0HtMx2KLmbioJ/IonTuOs+dOBj06u+WqWXOC2lmXFYw0SCC+TwoAf35udHg5CcGqcZsynTCs3Xt3h9B06Pk6rSXNgJU1rhr6mhR9PYMT47LrRGd1IqkCgYRTSRmuCUsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718073294; c=relaxed/simple;
	bh=KnAmKro879fRFq+RiQ5LefGpzSwBeLfGvMuFjATxW2E=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gFmmWNXwQMP1NQCpWENfSh3XBWvTcdzbB51n2gICT/4TuvVfaXwpW2xuhRuUcKGqwVWPFFUCQpIM+eUA7b0Mn0zWUeXp8heEQ03pFkIYPoVmssDOfSFLnbALZXqt93jcsDKkg+PuVp1WBnnofzXCJWPVbshoBMYd/sStrjGzfek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=d4CCwgxD; arc=none smtp.client-ip=203.205.251.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718073285; bh=RqDYlNEj89LVooht78uM6N9w3lcGxiYS1Vsrlw1PlCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d4CCwgxDBm2ARJXRMLW+zBIMvfgFdxQB0sKXvu6gRqe5YPgzO5wGisuDIpsWb8z2z
	 dSaGM1wKGi+Ir3XvlZh4NQVFJ/Q4JMaLAcaQyQNGJAsgPdzv5j8BXnpbfGsschBkof
	 Cb/II2bJehaO/bhCxdjspoq2I+MbSC+EPASa8IvQ=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 7209947C; Tue, 11 Jun 2024 10:28:32 +0800
X-QQ-mid: xmsmtpt1718072912tb3d1endf
Message-ID: <tencent_DC337C9ECD1BAD4BFC1B4C25ACBAF1BB7E08@qq.com>
X-QQ-XMAILINFO: N7/wgsuYk0Vx7zKEW34DSnHyfNSWFmm4pwThrtf0saieUV8rdGNVzRA/u/Etfi
	 reQ+rVGrftYSvNnCjhcZj1o6m5Oa6vCRshwAyACiLFp8UWB/L+jO/rVd2Ur6zJOR9RxXtYyG+3SN
	 mTn9o6Exo7IdrgWup4oCg7AhNpBBIKFDBjfN2owJb610sTtE6rv5Hyi3bTmxAdenI7i8a5MKQC1l
	 9eaFvjy8ED72h90jQ0HIqHKFMM076kdtsM7uDb+/GC6DG2uwcVKBpihXBDgoo8vKEB29IdNQ7rKo
	 Pm3eaT+SOBL0RF3GdRRjUK0DTtIMzdIX4Mx7z8QkLZNyfHCAVQJknjwvxvhkepDoRsFPvTJG+sF5
	 nPB44nYE1QYLfIbZzVYIn9TyGk6EaFwDiHxQxgaS+1I735twTuyim8jQ8VmR8pN05IckY+bTcp4H
	 4IgSkJLh04tR4nP0YgOkf6JIjPC0XeiM1GLnblQEkk0JHkKAQYhZpKXx92jzUOI2qtoBRfaLzjSh
	 w4HR3JgLEUmiKuOV4+KGryumlTUPd+XmW01LclCr02Y1CIeIDfR7uAYEnkHuDPy6RQ26L6Wr2pyN
	 o3mox7VCN9SUFag8G96RzhVJfAySxt8qOOoFNAylVoHa/SNC/EgqriuKYF/vUZweqkXFAixxtE0x
	 ust1h0bya1x9x2qn9Dn3CGtdASwbBbzA3iMceMdaLObrDchoeIRdfOO1irqZ7a7V6OWe8aMzmQH5
	 iF8FmP1NkUnfQ+0CEMdU43hzZZs1QO409UkllmGpujcmVnI/GsQqmdJu1JRwzInNymUwj4B0oYt5
	 rIS0cICv/5P+mW4ejGzO04HBszqCRtu3b+Tuo1xz7laTodnh+QXwNbj3fi3Vfmhks2MRv2a4PCaO
	 l4CLhKl3L5Z44YWeb7AeYUxbthEcx7WEqQoQkPE+4tvgfJh7SAowhvMbMRwvATgA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
Date: Tue, 11 Jun 2024 10:28:33 +0800
X-OQ-MSGID: <20240611022832.1419703-2-eadavis@qq.com>
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
index 6db60946c627..6f01920586e6 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1486,6 +1486,8 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 	int err;
 
 	lock_sock(sk);
+	l2cap_chan_hold(chan);
+	l2cap_chan_lock(chan);
 
 	if (chan->mode == L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
 		err = -ENOMEM;
@@ -1534,6 +1536,8 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 	}
 
 done:
+	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 	release_sock(sk);
 
 	return err;


