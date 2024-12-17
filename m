Return-Path: <linux-kernel+bounces-449090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DC59F49AC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C742188BE24
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88801DE3A3;
	Tue, 17 Dec 2024 11:15:31 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A301EE028
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734434131; cv=none; b=HyMWOfJOKWEY+P0ROG9eD2Sy/oJT3PxrUaMekf17RyfUffVrq5VxdCQ5OpDvKC0dCYX28a4X4K7GjDUTjP3YATjGEXS3V9ZI+Yd3V6bp/qC5ELhFpPrEln6JdrDJi8F5DxeNuqkE6A8xF9xOwaeIBRep33L09MOXMNVVoqmDhqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734434131; c=relaxed/simple;
	bh=tGf+d4e1wiEjSi+GxtugJZN7SUrfIYVmQEzlm5NGcBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWnCrE8Ukz8vZPofwOUbamKSIQfRS6r5vVhAYbt6LNVLECdsutnRvheCqdAtLxeDGW04gjWOWz3Pl+ckNmbKcoXkkFiOQGQDqx0byPz5Xk2eJ1pUqqt5OgRBS0hNu4Uwr0Fk3EIQM8WnEJqwEucwIDRkAjeKI0MTWC6Te9LOS+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.172])
	by sina.com (10.185.250.22) with ESMTP
	id 67615D4800003AA1; Tue, 17 Dec 2024 19:15:23 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5090397602670
X-SMAIL-UIID: A07DFF544C69490CBCEF08E8D25EAF70-20241217-191523-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+c2e074db555379260750@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] general protection fault in find_lock_task_mm
Date: Tue, 17 Dec 2024 19:15:10 +0800
Message-ID: <20241217111514.207-1-hdanton@sina.com>
In-Reply-To: <67607c8c.050a0220.37aaf.013a.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 16 Dec 2024 11:16:28 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    231825b2e1ff Revert "unicode: Don't special case ignorable..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102844f8580000

#syz test

--- x/mm/oom_kill.c
+++ y/mm/oom_kill.c
@@ -137,7 +137,10 @@ struct task_struct *find_lock_task_mm(st
 	rcu_read_lock();
 
 	for_each_thread(p, t) {
+		if (!tryget_task_struct(t))
+			continue;
 		task_lock(t);
+		put_task_struct(t);
 		if (likely(t->mm))
 			goto found;
 		task_unlock(t);
--- x/include/net/neighbour.h
+++ y/include/net/neighbour.h
@@ -302,8 +302,11 @@ static inline struct neighbour *___neigh
 	struct neigh_hash_table *nht = rcu_dereference(tbl->nht);
 	struct neighbour *n;
 	u32 hash_val;
+	u32 shift = 32 - nht->hash_shift;
 
-	hash_val = hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
+	if (shift > 31)
+		shift = 31;
+	hash_val = hash(pkey, dev, nht->hash_rnd) >> shift;
 	neigh_for_each_in_bucket_rcu(n, &nht->hash_heads[hash_val])
 		if (n->dev == dev && key_eq(n, pkey))
 			return n;
--

