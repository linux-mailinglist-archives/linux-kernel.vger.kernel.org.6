Return-Path: <linux-kernel+bounces-310104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2895967506
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 06:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F386B210C8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 04:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E82F28DA0;
	Sun,  1 Sep 2024 04:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mOXsg2MQ"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C17B17C
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 04:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725165623; cv=none; b=qi9vaB/y4xUvs5pgxGlWheVTM69hJKigN8SUS52jbGb1r8op1fOo3+2rdPnhB5RtHrvXvLLTd4u6YvAP4E2gQZz+U/xMW23cBcKH5qzOHT0O2hxHGxaAWLBRTq6klSK6a/xfuUEkHDx7q5FRNCCuFoS3GxiiKvyAivTXXKvUaBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725165623; c=relaxed/simple;
	bh=OM5usAhYQPhhGsfjhmJq2PSB9ZwP2Bh8dw/AnmPbLCA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jnRuyLtp1eU109y/881r5eZIUrFrlr8C6DgbmSf3pAFDVGJQ6Kgax9KyLW+HLvaBowzkBTMKMO4g4PAuZKHl8Ir3yNHsJ8/zu/u6m2QifKpnDMZhIkxQZ+lhJ9lHGj/cHv9qmEyTy9tIwg3C/4aA1w4dtI9gBJDWF/OpG2a9W58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mOXsg2MQ; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725165309; bh=goP3FOSCRmukplUMiTIStyPDCRL5ys3ZCX+hr+sxWYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mOXsg2MQ5MtUHwtAHp/Bs2OC4n+0Xl0xGpcgcrlMuwwapvoAM3FKH48BGPRSFhnhz
	 FEHZrky/dYPfk2BqwnFdqj/oYyhvftZA2v3NTXm4vqtgIDAz/hNya/dJFR72oNNJO7
	 KmE+EyHPOFYseqQUfftdx5YkmyQbbnGDrK6WOPpA=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 8C798643; Sun, 01 Sep 2024 12:35:07 +0800
X-QQ-mid: xmsmtpt1725165307tqmaa4jrz
Message-ID: <tencent_8764481771D77F06D7136EE36C496203AD05@qq.com>
X-QQ-XMAILINFO: Ni8Yhdca2hoVcPyM/o+CbY/8FKurS678XqOBJczsnn1vmpJPIlmJH2/G1SlIo0
	 GA5Moo+qtZ4/6PgS/MlzZHovsDTjVkrD+N7Ai+frSIRbGJPIv4J4quzDZMf/zz5vFJwCVzkC5pWR
	 QtnVuLRPDbpcXVyQhyaNqltdWdWnP/qKsgdpPqGrjpmJI7pgSPyimC6eJt+o5VBvsNuq56M+drBV
	 5HEXhJK0X/JCkJNUd16wD8ZaIHFR/38slx9C79TD0YFImcJrFhb0+FoUSzVOu1Ga1bdbCLjSUFb0
	 QnYRPe3D4lXcvFVxvTLDB5qrklWj3hMHes64jRoErxYAMrSxc2dIPVJV97hC7ziBniLafFRjYQMP
	 Sarvv1TrZxuI926ZiABMteB7pJTf7N69Prx0uSaJm1J0C+h2LkZCAWqIf9r14EnWLDtSHYeSls8r
	 Ckcl289nQfbGThgngu+h4gI6O3giYzdPr0QFvK1NK3bw9sWfDFODbtzi1KEHCY5RhgAVvQcIPAhE
	 8UzOPQ40wC1cmr7oP2+46pFbqeifK22VcZEyd6Wzx6z8Rv9TIk9S1OVwkyLrohPH1abe0fLdznlZ
	 ZIxVNR6Fcuorif6u6E1hS2okKofebd7nsD9lG+CKm1mOtslmpgtOjPJWzZPc7tswv0MpR60XM/Rf
	 E7QDwhKsgn3nMJvZKNOy1Cfg2QDJIjQWXCzHCMxbz4vH7iuEjKj+jmX4zKw/69NAXb7eZFjMpMAA
	 luE8wpNegFYPSJYaN4vLKk6A0FboXpWMhzEFck/lElRpyzmnrxl0RvlzaIxZlLNbIktBezbYnn2X
	 HslfKb1QqJNIS4fXEHu5stlpxaIbyTBXvbKO2DrIDec1mJOJMUGuLSE/jSBEQdpaBQRaoUbueNwP
	 FuzuLGVot8MIL3QIz432AZD+aywoBz+t8Gc02qNmeq
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_set_doit
Date: Sun,  1 Sep 2024 12:35:08 +0800
X-OQ-MSGID: <20240901043507.1915252-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <000000000000b5ba900620fec99b@google.com>
References: <000000000000b5ba900620fec99b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 9ab49bfeae78..51c4e811c01c 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -137,6 +137,7 @@ struct genl_info {
 	possible_net_t		_net;
 	void *			user_ptr[2];
 	struct netlink_ext_ack *extack;
+	struct mutex		fslock;
 };
 
 static inline struct net *genl_info_net(const struct genl_info *info)
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index feb54c63a116..abf52285e26a 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1105,6 +1105,7 @@ static int genl_family_rcv_msg_doit(const struct genl_family *family,
 	info.extack = extack;
 	genl_info_net_set(&info, net);
 	memset(&info.user_ptr, 0, sizeof(info.user_ptr));
+	mutex_init(&info.fslock);
 
 	if (ops->pre_doit) {
 		err = ops->pre_doit(ops, skb, &info);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 34eb2c2cbcde..8d0ac4f699bd 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1953,11 +1953,11 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	struct nfsd_net *nn;
 	int err, rem;
 
-	mutex_lock(&nfsd_mutex);
+	mutex_lock(&info->fslock);
 
 	err = nfsd_create_serv(net);
 	if (err) {
-		mutex_unlock(&nfsd_mutex);
+		mutex_unlock(&info->fslock);
 		return err;
 	}
 
@@ -2080,7 +2080,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		nfsd_destroy_serv(net);
 
 out_unlock_mtx:
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&info->fslock);
 
 	return err;
 }
@@ -2110,7 +2110,7 @@ int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_free_msg;
 	}
 
-	mutex_lock(&nfsd_mutex);
+	mutex_lock(&info->fslock);
 	nn = net_generic(genl_info_net(info), nfsd_net_id);
 
 	/* no nfs server? Just send empty socket list */
@@ -2141,14 +2141,14 @@ int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 	spin_unlock_bh(&serv->sv_lock);
 out_unlock_mtx:
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&info->fslock);
 	genlmsg_end(skb, hdr);
 
 	return genlmsg_reply(skb, info);
 
 err_serv_unlock:
 	spin_unlock_bh(&serv->sv_lock);
-	mutex_unlock(&nfsd_mutex);
+	mutex_unlock(&info->fslock);
 err_free_msg:
 	nlmsg_free(skb);
 


