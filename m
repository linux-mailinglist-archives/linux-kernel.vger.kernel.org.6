Return-Path: <linux-kernel+bounces-322609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9590972B71
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2931C2193B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8CB184535;
	Tue, 10 Sep 2024 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZEyx6jcI"
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB2F183CD9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955426; cv=none; b=Mwm5HoJu3ch75P5nJgyoaNg6VD5BpDbttX8Y9XchS+VTBvrrerq+EMAd5e2kmm6dw6ke6L34t0w5jgfsipwM6Ca7dPJaMO1p19q9bZ7ubikzdi9o0OpC/flDAIw5UwkS2KIkmCUtY35uMp5GpJ6SSyLvjor3m0f11Ik1SFYVMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955426; c=relaxed/simple;
	bh=HqbW8dy/+rSyl/ZkQAICdVZPytPBjlz234TbreiqZck=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=aJwQzJOqxgfsxAVf+LdXae+Rdw2aBYagy/+M20dFGJHiPA23GHPN1eituQ/98P2L6GpH5pEDYF8repOuTUHfxlM0H8TekaLocDEW+NSgxZ03GGuuWL8Z7g5ccmEB4DFpKns7TfnnbtMHCd1XGxLq0HK4vxUsP3WGKfsu6VuBMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZEyx6jcI; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725955411; bh=Ke6llP5aTC6wJl5ezxb6Oyg4/JgEY6h24W6FPOQpXfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZEyx6jcIVtDFt6JPsZbnHnlRfa6pknNXR7T+QFUIX18+3y6hTFBNoeHmMY9EYBm5D
	 tRz9lMcsB1zQMH5qdP7BE4cfBVxMkZxX9JSPQPgRIGjHSHtJ4hacwcgZz+kGkHLnsE
	 C2Jto0FQ9Ok9Yb4o0a+yNGRr2YRls7CVvOBFHXxk=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id DD8BCC2; Tue, 10 Sep 2024 16:03:29 +0800
X-QQ-mid: xmsmtpt1725955409t53nwapj4
Message-ID: <tencent_C01BE84B281BB025FFBA45BB0733AC9EC408@qq.com>
X-QQ-XMAILINFO: MTEKjEyAppcsxn4ZJ/5W+R7JrDrz8yLAn3588Xgbw7Zz51yaOlVahETQaaR17B
	 BSxB3Ojz+SYxJKz++jMtx35i9GAcmZm1zD6pwwq9lLLJGSEswKM7s7YG/gfffqcNU69nQPbwKDoZ
	 Xa0W/NoPTuJ03O7jdTS/AZz/xrUoohmqjc0ur1F8vD8bUO30ByvA5HiBK64Ja0ItcWdE3fpdN3WP
	 WlCAmucNZc4YgnHudtQtTw6ZqIqEj+TpUNOcz2gQgXzeMkfGYj5prVbz6zv92Ux9JxIiHxGCGLfB
	 1WXzbOvPPAzD6L5aQH9iNT7o7XT2H4lLLLOZNUcaUpeKamyFtuysR50lNo425TZwWvod3lWosRSs
	 h05mV8Sn7vTnaPxAgFUnQwzmGl1K3ybb5gz2pXUZwzku0wagU3FdmtJK8ppv5EVln9IRIwDQnX0q
	 AQ+ANZol4k8xgJc9z/dlfw6NMa5eA/ZIdHmb5XU4DpIKFEXsuznnZCFL+N7AT2wxJlU2i6ihzvu2
	 afMmg1V4VmNRvZy4iyNXDV4Ne1Xd3DL3n7T523u0zUn3YhR9ipcG1u11KQT2KkW6Gv4i/uLrhCdO
	 5cOhxaSJlSELsFNt3qIYTSltOd82UH2waK+k08s+lJYXhj6pEngOAgczDPUAjxirEmD064dUBaEt
	 RzCN5jxv/dNzAeKweRPQQav8wqsfRjO/YydLQvapIsMIOrC/8N35szCpNXZvHFUwHFkmUT9jfJz9
	 aluhxVB7gOp10Q9hiWqAzSrDqttJvwTNROjbAKNurrCdgMw9Xesp81SP5CYpWhuNivifz0Py+ae/
	 ja0JmfWWNHIT9NSaZU5pIxEIkRitprKGTbmVJCJ2RNGzEPDUUqHQj2JUq15R2fV2CWu38sVCo0Oh
	 0KKDdjZ+0ajfYkW7OJc2/5WgjqGeqnlDBlHG7zGvQTRRu0NMJIT53uafWxOH0NvV6rQbqmmRu8sz
	 BJHulgNAdAt1qlKdS+iG5CdnNUcJuYh+W6xk3VQEU=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [mptcp?] KASAN: slab-use-after-free Read in __timer_delete_sync
Date: Tue, 10 Sep 2024 16:03:30 +0800
X-OQ-MSGID: <20240910080329.2515966-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <000000000000b341bb062136d2d9@google.com>
References: <000000000000b341bb062136d2d9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

entry need to be protected by pm.lock.

#syz test

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3e4ad801786f..b09268fc7fc9 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -329,17 +329,28 @@ struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       const struct mptcp_addr_info *addr, bool check_id)
 {
-	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
+	struct timer_list *add_timer = NULL;
+	struct mptcp_pm_add_entry *entry;
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
-	if (entry && (!check_id || entry->addr.id == addr->id))
+	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
+		add_timer = &entry->add_timer;
+	}
 	spin_unlock_bh(&msk->pm.lock);
 
-	if (entry && (!check_id || entry->addr.id == addr->id))
-		sk_stop_timer_sync(sk, &entry->add_timer);
+	/* no lock, because sk_stop_timer_sync() is calling del_timer_sync() */
+	if (add_timer)
+		sk_stop_timer_sync(sk, add_timer);
+
+	spin_lock_bh(&msk->pm.lock);
+	if (!check_id && entry) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+	spin_unlock_bh(&msk->pm.lock);
 
 	return entry;
 }
@@ -1426,16 +1437,7 @@ int mptcp_pm_nl_get_flags_and_ifindex_by_id(struct mptcp_sock *msk, unsigned int
 static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
-
-	entry = mptcp_pm_del_add_timer(msk, addr, false);
-	if (entry) {
-		list_del(&entry->list);
-		kfree(entry);
-		return true;
-	}
-
-	return false;
+	return mptcp_pm_del_add_timer(msk, addr, false) != NULL;
 }
 
 static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
-- 
2.43.0


