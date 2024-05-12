Return-Path: <linux-kernel+bounces-176805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F888C3539
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 08:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60511C20E4A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 06:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA9AFBE8;
	Sun, 12 May 2024 06:29:59 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FE2F4E2
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715495399; cv=none; b=GqJiZhK351+zMwgXVk60rRiUC+FfbmUqtk7x0yVQTm1qeqcJWj8MWpMK+YyVTvq1D//T4h3zOyCCqleSpDaOrSE34rf+2LzdF0Sos4vLie8pOl4dpOt3aia0lkENWjkaMOJSrrsbdiA9gZpuQBOPrZRsecgZiEPMueYOKa8DSBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715495399; c=relaxed/simple;
	bh=We4U4DI0hzgjmbjlN/VFCiTFbi1yTK1ImqqRGWmuzSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IxfTeT+DSFH+PYNZ+/iez6No2+C/aB6huyUSYSOKbgUOo5UrGJLiO27CDBDFUB3GmuQqMbtfE6x/gI60aPL0Mze9DuenXeEQLbcVpkAcuNQkNuks++QazV7GjApNky8nv4kndTAE5uF5QppF5+iMoX/kHafWknU8ZzNONbEA/ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 44C6ToTK048144;
	Sun, 12 May 2024 15:29:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Sun, 12 May 2024 15:29:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 44C6Tna1048139
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 12 May 2024 15:29:49 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <61335219-fbc4-4cd9-af8a-cf69f4c2c873@I-love.SAKURA.ne.jp>
Date: Sun, 12 May 2024 15:29:49 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] [bpf?] possible deadlock in sock_hash_delete_elem
 (2)
To: syzbot <syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000000d7c8f0614076733@google.com>
 <000000000000d0b87206170dd88f@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000d0b87206170dd88f@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index a509caf823d6..66590f20b777 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -66,7 +66,10 @@ enum sk_psock_state_bits {
 };
 
 struct sk_psock_link {
-	struct list_head		list;
+	union {
+		struct list_head	list;
+		struct rcu_head		rcu;
+	};
 	struct bpf_map			*map;
 	void				*link_raw;
 };
@@ -418,7 +421,7 @@ static inline struct sk_psock_link *sk_psock_init_link(void)
 
 static inline void sk_psock_free_link(struct sk_psock_link *link)
 {
-	kfree(link);
+	kfree_rcu(link, rcu);
 }
 
 struct sk_psock_link *sk_psock_link_pop(struct sk_psock *psock);
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index fd20aae30be2..9cebfeecd3c9 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -791,10 +791,12 @@ static void sk_psock_link_destroy(struct sk_psock *psock)
 {
 	struct sk_psock_link *link, *tmp;
 
+	rcu_read_lock();
 	list_for_each_entry_safe(link, tmp, &psock->link, list) {
 		list_del(&link->list);
 		sk_psock_free_link(link);
 	}
+	rcu_read_unlock();
 }
 
 void sk_psock_stop(struct sk_psock *psock)
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 8598466a3805..8bec4b7a8ec7 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -142,6 +142,7 @@ static void sock_map_del_link(struct sock *sk,
 	bool strp_stop = false, verdict_stop = false;
 	struct sk_psock_link *link, *tmp;
 
+	rcu_read_lock();
 	spin_lock_bh(&psock->link_lock);
 	list_for_each_entry_safe(link, tmp, &psock->link, list) {
 		if (link->link_raw == link_raw) {
@@ -159,6 +160,7 @@ static void sock_map_del_link(struct sock *sk,
 		}
 	}
 	spin_unlock_bh(&psock->link_lock);
+	rcu_read_unlock();
 	if (strp_stop || verdict_stop) {
 		write_lock_bh(&sk->sk_callback_lock);
 		if (strp_stop)



