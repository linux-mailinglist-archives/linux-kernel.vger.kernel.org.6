Return-Path: <linux-kernel+bounces-209966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8C2903D70
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25F41C23D48
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EFE17CA1F;
	Tue, 11 Jun 2024 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WCrmGdJZ"
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A6C17995E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112806; cv=none; b=YCZ8WaRGDqAAQ1/kuDQR/7X9kAzUar8vVKwWd8MnBREvxtkBoh9Z7TeEpFi4b3wiYEnpeL0Q0XUZNsSQKks+ulsYRqFQaijrA8lWhj8A+tGjAFvukseAke2nLmFNvyEO3UpfXM76WzJQ9UjA1rAmOKhO9YxzGNAcOLQGmTxkhfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112806; c=relaxed/simple;
	bh=AZrVg5iRAyrbtVUsnP3zN2ge0bp2e4THWQb69Q6ta4Y=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qX8OaON+0BuL13uRgwqIXm8CTW+LhVKw5Wl56q9vJwFW8jOx/vZB5k2H3pJ1x8qOJOzTmWL9NZL+LlsSn6zsO0ULD4DGFk7gZHtCcNF+x+kwJiAiz3EQXwIReeezZ+yIMV6vHfH3ig4iYPG50UqResnLIwcdHBFWTp4AJE833wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=WCrmGdJZ; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718112796; bh=JOpNX/uZxyBIcKljIPD/1YcSOOMRXDuCkoZcUwCNW0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WCrmGdJZGydSNfXDjg6EvMUXDRQDyEYEG0/h9xuYF6XkyxhrLAjlD45WfslWvw+ux
	 D08Ukp1te8+gIMI5e1xTU7H2+ZuvsN74rBBZD+KIEXi4Pq2N4nQSPhOl5ZI201Ojqg
	 7pRh1esuOsV+AbU8WsklDTloMxWhbefz7eUDKzoc=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 6C5964C5; Tue, 11 Jun 2024 21:27:05 +0800
X-QQ-mid: xmsmtpt1718112425tz4nnqr33
Message-ID: <tencent_A26D4970C3B204575761576126CCF3696305@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jhjE6VrM0t1AsvPsP8aIXP3HcDEWebV/Wl4edAmItruJqXsHmUI
	 oFUXWVVQxSR3fTbp+80eWWUu8nJPefTi0RVsiLcjPhZy+SrcgoGRSsvt2f22dCSD/ZfFgWhLdGp2
	 fdHWBm4zs27YTXcD8liGG8Bgvgsdgg/QkW6AUTgkcPVlNsraHOJ0ciCHvr65qmyag+os+60yaqGa
	 89zeEZ8feC8ubwlnaJ9s771BLuI3RjeoLkaNGIMW+yUljhOUO2Mh6KqEkrN1MwlmrQ/EbbfomX4d
	 8GZjeiQf5ZVbWfT2rPjQNjnypyPpn93bq5Nk0RoBuCn5UNx5RKgIqIH5QdcN8E5iPGEHppdgMSMB
	 zI2OJJGj2YSNbEZP475j3NerST0saUHtdomS4VBQv87r8pG0KI9FjEQ5DP7mkHXVJATn5zuQ/u1K
	 U9DKT4PSk83ZhDeZtd0Ya17gP24MDwQ+c/axzD+bLE8ITh91xfbEllhLPruq7zA3ujzUgySC7isw
	 4mXD+I1xEbd7r8AIk+vvACcTryDPj3hKtaLt/iRorz9gi31BATAHDwqtdFwO8tblEcGXP2Ga8xHW
	 AnsWox4wJgLUjeoXaMbdtaWg2tM9PsT/ay21tiOfzlKisu9Ys/MGH3hB0XZCB9xelAJwF1yF4XRu
	 JXwZcV5YTjx84+b0exJH2Nq8bSE4pVXoBzmzGwN0GBP+vw9Uk7o0H1FncZuQqWS5lVDPYFP4aFwX
	 6/GN3rmq5M05KxuAmO1fi8z97E23jfeOtoPrs5qBK3vtzWGwMSWThE8seF+y5OkcMUcHr7GmU3+4
	 BRRMlxpaYm0h+RLZiwZWWEObS16OagHUarRYZVJ8acb83AML5mB1BWL/yrcsSFD6BiNIScO05nYc
	 qpejEFQ1R2MgDRo4xupnsOX3hT019E0Ka5lKP3dmUpvf6PHigjwN/74fCXOq9W3315L7uzEypJPE
	 s3z0K6R8U=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
Date: Tue, 11 Jun 2024 21:27:06 +0800
X-OQ-MSGID: <20240611132705.2012752-2-eadavis@qq.com>
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
index 6db60946c627..9938d3681772 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1413,6 +1413,8 @@ static int l2cap_sock_release(struct socket *sock)
 	l2cap_chan_hold(chan);
 	l2cap_chan_lock(chan);
 
+	if (refcount_read(&sk->sk_refcnt) == 1)
+		chan->data = NULL;
 	sock_orphan(sk);
 	l2cap_sock_kill(sk);
 
@@ -1481,12 +1483,23 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	struct sock *sk = chan->data;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sock *sk;
+	struct l2cap_pinfo *pi;
 	int err;
 
-	lock_sock(sk);
+	l2cap_chan_hold(chan);
+	l2cap_chan_lock(chan);
+	sk = chan->data;
+
+	if (!sk) {
+		printk("%s\n", __func__);
+		l2cap_chan_unlock(chan);
+		l2cap_chan_put(chan);
+		return -ENXIO;
+	}
 
+	pi = l2cap_pi(sk);
+	lock_sock(sk);
 	if (chan->mode == L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
 		err = -ENOMEM;
 		goto done;
@@ -1535,6 +1548,8 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 done:
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
+	l2cap_chan_put(chan);
 
 	return err;
 }


