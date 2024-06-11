Return-Path: <linux-kernel+bounces-209207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0D8902EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 05:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605721F22B81
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B88A16F8F1;
	Tue, 11 Jun 2024 03:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kuGFqwax"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D4341A84
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 03:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718075224; cv=none; b=GD4E06qYOIxzLIzOHPao8K8ZxsnQPrOuRxiHQuDfMQZKkEiJLR/PD77th45v1E0PYfJJg8UJgdZ6beFZ7aYbG/rXXo1j/E3SvHlju2wzkLT2EdIhXJBJSE4i2rnxGCmGndKe/qyhyZxIIusFOwJMpwmNznsSD2I8O4ybRsS3mw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718075224; c=relaxed/simple;
	bh=4CdiDuxPSMX9XXvKw3y+GAyOWcIJWfNPscCc1ecOWkw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=joza04bBmZEkQdOvjZbYyyvO4rdsy4Zl/veQ1NpOtVtVT9bH1uQ58C+U8DE3eCNi+8tby0coWWcFXHFG6oZEOr5joc1yXxW4VhGQZ4GwtqnDfT92hOoiO4aA53cfSw4BhLIDvDx5TEr8RBLvW30q0Bf1NgSp/suAvyKdL8W8pvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kuGFqwax; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718075210; bh=+g/wCHiOXVyN4zGspHk/x2Qbrb4guWzsA0WpHPqsLrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kuGFqwaxirla65SNozb2KmsFyFV/Ts4zn+X7Ob4MyX/g7N12/Ag8sawDU9PP0tnDv
	 uA1XurG0J6Fna7wtOiETo2jv/zPW10astLvkbTLVHaQFWPW3TrS7UqCUQVae6DQ2e+
	 EtLtudl6i21+Az3VqtP8Zzxy6R6OP3fcbINbY+gU=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 2B3A281; Tue, 11 Jun 2024 11:00:43 +0800
X-QQ-mid: xmsmtpt1718074843tlhrglw7l
Message-ID: <tencent_3E3CF53628970C36A64ACA75A3771B663C09@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8ZOrKAnPRVt9wtRT6UvF/qT4P0JeLtPV6TuBmZ7DwEDqm2xocZP
	 tQuo5jjBKxDXvozcjnarQHWmmfnGHdV7NISyRooBL+akowik0N76S9q/UMslPo5nmb008DmSLphn
	 bn2tejHMUjbZ3uEJGZ7lhyWOoV6kOvabkDHeORALL+weNnh9XCKDuGlQGgq/mfy0sb+ni9VjExdE
	 yOgzGcjHMNj18oHWjapSDgxLv4S0EF3D6EUVuaW8uUeI+op4vSb3JaVDTD0aD2KHZITAhM7ymAhy
	 bUv7wyjYUMppPN+g7O8VoyZ8TVwqef2hyUntCpU9hcm4PBJOmtGLgBbNpbByBy9XY2R3nXnbQVLN
	 BOIDMAGERvdBBJ1BN+sZBC3Soa7S5KLURT8VIAgrcqJZfA/Eu81nVzAzhmcUOu+bnLGeTT92KEAB
	 JTL4OUpaovBKUR4G3kNBnfOz5gAQ0/VmitAa+e+rLjfNSyto+nr4oyiJHhJm5uLPo3UTtYMbVTfE
	 C3I14/DZUr8FkMse6PiWwTWjWKZRNveD2kBmH80FGwz9r4VOk6b79c2j+wyQ5JXvh+hLp58Du7XL
	 qrf6DUdNpD5Rxob+sYnz9qmA1wrWjt7dklkJze7MzeVbV0ixpd99PNTH/1l5Yt5kK9U3nc2vPhki
	 4bxKJ8fXNN+W3IF0NLeJ0VAMHMT3TrH6ScPs7Ejgk2WUqqKmyGKrp4X013Ko3skDf1XHnJ4WBbfm
	 KM5MzWcxn4dixzB2mj1d1Z2zbj1Fc/xzMUxKVnmWu8S7PtKOIOpbOmk749gy0paNxacd5nd/XiuF
	 jK2D+6uJ7FEw65fiVJ7xi/mfRc9P2PZmMwczhU5SD9WSTGeTRaTXpexqBjo47dpaTwmkMOlGFJ+N
	 tcytZKSIUGrypJ+QA0tOjcpEcRXGi7erZAH6djZrbcy6JsBr1sHVyi01Pzk20Tnmn4jDseeCWt2F
	 32HQRljuYrcUyREHOnXm08zZGp1BRLxBKMD1lSFFc=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
Date: Tue, 11 Jun 2024 11:00:44 +0800
X-OQ-MSGID: <20240611030043.1447599-2-eadavis@qq.com>
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
index 6db60946c627..c0072f81e81a 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1486,6 +1486,14 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 	int err;
 
 	lock_sock(sk);
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
@@ -1534,6 +1542,9 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 	}
 
 done:
+	sock_put(sk);
+	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 	release_sock(sk);
 
 	return err;


