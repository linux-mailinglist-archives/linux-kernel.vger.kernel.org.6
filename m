Return-Path: <linux-kernel+bounces-224927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 518969128C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F371C2625A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EB74084D;
	Fri, 21 Jun 2024 15:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="YZsdXlQq"
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353A9250EC
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982098; cv=none; b=UR4/+Y2dnDDDk4tWabgu80uWnWqdlgz90COdM8RvIqENPhv9Wxy9hCTtOjiOV9OzL3ckZFf7qbXh0jPwb2sf+HG4vMyfL9898TsI4obim4s6kDMko/suyDub/pMxgQ+3fnb3zeaXBNOTiODWaBwqX8Kd2vdZZoeVCeqmVsw7NvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982098; c=relaxed/simple;
	bh=93O4/7DFpdjROLypmde/a3JcWpFq0dkcjGqSHxHkJOI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=TKcES2gUM8K6AyeqU8HWLoJXrAw1k1btTgZi/bRLxHediUvPyET7wx2zaQE6+nEY81tUeazhHmNFE+ik7R1Occ7PekGLFYYx0scxow599nzooQurCFoEzhu+KAyXgbHHMtd3duJgHxEbWSX38zho8abx2RW1Kvxgk/8s9yEQbG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=YZsdXlQq; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718981787; bh=u11VC9vTA/IZRdXHWSyfPdljHk8ljFmOZB+QjWrnNKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YZsdXlQqKSnvtO2szpQpI9O9FsBf1A4wZmFF2LiHqbVph1rxb68+hHijzgB3QhdNL
	 HwExJfCtDkx1h1enCX6/CKBg/Xi5hM/BnlB6vsYw5omiN2GfmuXBYxEHArBufDnHfm
	 xpLeaK6qJn3Xk+qR//MgTMWXCT0R8Uk8g2jHfu+8=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id E19A0E51; Fri, 21 Jun 2024 22:56:25 +0800
X-QQ-mid: xmsmtpt1718981785tljmbu58d
Message-ID: <tencent_EF3CBD367097AC370E4A5E7525769D668209@qq.com>
X-QQ-XMAILINFO: MprdIpiwXvQIZJGIMSzOwI9Gs5wqc0M3LGfI190cfBEB8DfzPY/zelSjNJXHmv
	 DDpFRQJVLjY+yYdDEGOATPDLV5/68LPY74I42h5fJsHXQSZu8qImT6EXxMp94HVA4lKhWUqvD/dF
	 62+fr22tVj/spn1oUdzXbgyflDgJd1ZWiUNLECmU8Tdk6pe1i1FC2qQBi/UquRw0P4C0ATaDBMV2
	 6vtNNnP7UKYSl6gqEeNWlSAIfg+pYK3NhCl1+JLGWCN4h+nBAxQp6dibGASdDpvl5dXOFuPJsNBS
	 p1mBL4H31u/oLJjjjpvAAcPSgy+s5rb26O1eNABfihdUrZ/WBsIkXUXEpZLNW4zw0GAYKAavDINE
	 0AvZG7d0MaMmEp6CwGYQLjXbtIImN5d5/CeFCZUs4DzQhxaYEOkq0dPylao4N5qV4AUhvfB+d1mG
	 LGUF1fmzGhjte/FTkHQ/utlVsmyEyoFrEGoS8XQBcF5HeQfn5MF0igzMm8cfzSdMvj2NQsCACER8
	 orPB69oe083BGLDAnK8Dfw/yLbvgmcZr6y/O6MD+OK1Fbd0+o0fP0ackctTNUw+WYkpmbs4aUDp5
	 q4YHtdkb2u/5cko+CfNmRrFTJbriHa7gEVZPDDSrvx7dDqrdWMP7D2x47THB+0XPAoEtyM/Y8n2a
	 9E7vfG39p8Y9WVgI0suu9mnrkT8JuIqvfULjIYy5iVAQAYx2+XxHZQdloM1YXVjUKd0rAI78SUf2
	 bOCzmPl3redEFChgmVsQK4Mf3O21G9gNk3N0fReXPUr8Dh0gk2De8quPy8HJsFi3Vk3Kz4C+BXAc
	 kyQucMl9hfk6flAhsCVx7Fu/p5iMLLJEQueJKWoMVcljHhRyGRCNYY/XoA4l8CgITwybnHDkModK
	 kxTGgnjMevFvfe2X+JEtRo8ELNE3NgWjrflWP9RYU+encPp2TRvQd0Ea4yBMc/sNkZSj154CekdD
	 RIUGX/Twk=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
Date: Fri, 21 Jun 2024 22:56:26 +0800
X-OQ-MSGID: <20240621145625.2692300-2-eadavis@qq.com>
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
index 6db60946c627..c0fe74a6b45e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -47,6 +47,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent);
 static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 				     int proto, gfp_t prio, int kern);
 static void l2cap_sock_cleanup_listen(struct sock *parent);
+static DEFINE_MUTEX(chan_data_lock);
 
 bool l2cap_is_socket(struct socket *sock)
 {
@@ -1239,6 +1240,9 @@ static void l2cap_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
 
+	mutex_lock(&chan_data_lock);
+	l2cap_pi(sk)->chan->data = NULL;
+	mutex_unlock(&chan_data_lock);
 	/* Kill poor orphan */
 
 	l2cap_chan_put(l2cap_pi(sk)->chan);
@@ -1481,10 +1485,18 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	struct sock *sk = chan->data;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sock *sk;
+	struct l2cap_pinfo *pi;
 	int err;
 
+	mutex_lock(&chan_data_lock);
+	sk = chan->data;
+	if (!sk) {
+		mutex_unlock(&chan_data_lock);
+		return -ENXIO;
+	}
+
+	pi = l2cap_pi(sk);
 	lock_sock(sk);
 
 	if (chan->mode == L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
@@ -1535,6 +1547,7 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 done:
 	release_sock(sk);
+	mutex_unlock(&chan_data_lock);
 
 	return err;
 }


