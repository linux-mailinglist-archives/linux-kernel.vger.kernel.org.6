Return-Path: <linux-kernel+bounces-176801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CAC8C352E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 07:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13F3C1C20D84
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 05:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F35EAF9;
	Sun, 12 May 2024 05:56:51 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C658C13D
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715493411; cv=none; b=ESlMmNh/NPqa4rKiSpxZU24HbRoe+F7CmMo4Jl8gorVvInpxB8toi8VYxdrUzqTRwyive0bPUu540kN82WywlvUTHynT7q+j2KNrxJAcM6kFET5D67BNWEaUd7B2RC5Fx+QaL0vj0lMsuRQELLdfiIarzT0C2A2JWQWyzhUMKao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715493411; c=relaxed/simple;
	bh=We4U4DI0hzgjmbjlN/VFCiTFbi1yTK1ImqqRGWmuzSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tcigqOuUUbz+bgLxN0AaPAFeAA0ilFp97wZsS6ePnnwvd7nVevufBuICgEhEkra66Rqo1j70cM5yA4BI7eS5aGDJaroChUd2p3TKx5TpFdcN5JI3Dz+SpZnLzIber1yHJdccEt3GNeVb+YHZvnHME7LUfdWQ8Nr9iqvwhMPWV7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 44C5uYOx042391;
	Sun, 12 May 2024 14:56:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Sun, 12 May 2024 14:56:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 44C5uYYr042386
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 12 May 2024 14:56:34 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8ef9e988-7eb1-4020-80d4-c9594c95e88c@I-love.SAKURA.ne.jp>
Date: Sun, 12 May 2024 14:56:34 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in __sock_map_delete
To: syzbot <syzbot+a4ed4041b9bea8177ac3@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000bafb9f06160bc800@google.com>
 <000000000000758c1c0616aecf58@google.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000758c1c0616aecf58@google.com>
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


