Return-Path: <linux-kernel+bounces-310130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DC0967550
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 08:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67521C212D2
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 06:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0EE14037D;
	Sun,  1 Sep 2024 06:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zO8gUxL1"
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B998C2033A
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 06:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725172307; cv=none; b=gYDL8dH97V95RsSKWopWBpOrtR9e9us0jHhGTieTFmkEFLh0ZMIbFQc/qoOLRZiXvE6JB2bXDl7mMUfYfQNnufXH/Zsek1VApRnS+tOza1UjHKjHtEQWbSiQ+9BeCzjNh9bpekYBt2DvCO7xHPbsEGgkOdYNOyW66BLram2Mw3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725172307; c=relaxed/simple;
	bh=5Dh7wxe+PujT5nSXMwZDbE2toTtw6hSZ/0CsoQyNBgw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=StXhVy8CposEtmhbt3nvgAi4vFI5CpmJBXlo0lycxiPG3smqOLUfH/85zpNeLgGFvoHKNdaUiGbo1JWU5LEeR452WwUcMM3xOT3gdfgJtI2hRwsMd/P1cPmVvu0H8bMde2bN+rjGwLsXu6swXk6zjwXx87ajqsJZMjDgV4XRzak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zO8gUxL1; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725172297; bh=X33g82d4N7WAFAk4ff3u+3Mdc1/UFf+O8cdllNzI4KM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zO8gUxL1hzASoZ5U47lEMyzFMLrIyfHEhnAWf9oEKumiSm7rC0OOjY1xnMemSfXZZ
	 5ghSWrTzuEvl9bKbphf2uVTGKp8Bwza8/a2COhzQi+Y1LUXeeNPorJlD2ra901seDJ
	 SrR2rcS7PljkSrIM6FL3hLpFaCn343bK+gW1VE68=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 6609E4B0; Sun, 01 Sep 2024 14:25:32 +0800
X-QQ-mid: xmsmtpt1725171932ta7q7n6op
Message-ID: <tencent_E2678967C3A24456B776176C46C9D37BA305@qq.com>
X-QQ-XMAILINFO: Ni8Yhdca2hoVcPyM/o+CbY+UEiHbW17Es/kBieGO9/HNkfxkNeqmzSrBNtHo1m
	 OvMsMH6h1phhFzRa+FI0t0ZpdaaoUeYVwS+lqk5GbjAZkjl78VI8biLkmgCuRC5o5Zi5c+xtGSsH
	 X4ym+afetydU5a9zakdKGIEKGny2RGlYejv0MwLNC3Zt2nDx/qyWY0Dawbeq+Kk0gGwIwI6hZPjm
	 HdXgYPwINuqgu2j2HvBBScGl8xmM96ZHTe9j3JT2ArAvI+pVkeIXaa8GLimCQEQfKSOCuZPg8qJO
	 1nINzF0TrTwTr/ExfdGy+OvLB37gX8xJalppoFQMl9slex9EDC8pE3o5Or/M1JAXQ0FIzTPcmKAA
	 GftO1QLw0VSIYVzEehUU7KSlVEhJllf7TfJH0nEB6E5txLAvHMGB2pr43kL1brbqwR48C5ZIKgpo
	 w0i+dEYj6k0PjNGd0PolrzGAW9SMs0mpfeAUl1EoH74rvs4Wm+3951wJHkgh+0fuH3kd/RT6E6vK
	 cbzlm6b5igWeYACY4xUvtOtEjJ1WrRVsQd89xe55Fk9z/pEQSMU6M89qArCaK7eNkl2y2oHeH19z
	 N+T35Yk6fxXB43Cv73/IXIOHQYgoGHjOnX3/QYYFF12TMjShLI2kwwBxIQZYPtpag/jrzX6bq417
	 V9GQOZ3iiiuWLm34kUBh9Pl77RTVsa25Clb++yCHuWiN582VJGJsLZq92d4mvqpBSyBjiabXyFqT
	 4m5mlwxSCLbzfwS5H1Cp1W/AuYVptnHKgI0Nw0WrFt483EZRLcXBYGiSJ89ssnBsqJXmVBM01q8W
	 G4Pt7cGQOLS/Ao0Af1Owg+imZsye0GDYD+gIVqWUI6HrxYz4FeeJ01G+Yo6wtX91allUqxCpEcoy
	 NCzL/Ln4LgQIX21VMqpEgpc3OgCSDMSRIGZMVNmychW5O8bVY+0W3sBuV2lc2TMg==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_set_doit
Date: Sun,  1 Sep 2024 14:25:33 +0800
X-OQ-MSGID: <20240901062532.2013311-2-eadavis@qq.com>
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
 
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 0bc8eaa5e009..3f2fe684f0e0 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -653,7 +653,6 @@ int nfsd_create_serv(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv;
 
-	WARN_ON(!mutex_is_locked(&nfsd_mutex));
 	if (nn->nfsd_serv)
 		return 0;
 


