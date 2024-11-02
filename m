Return-Path: <linux-kernel+bounces-393219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE8A9B9DE6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 09:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C075FB216F7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 08:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96791156677;
	Sat,  2 Nov 2024 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="PAm4xQX6"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7903A42070
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730536131; cv=none; b=ZDaXADqtoZSlbbV9hQ1ttp98ZY4INy/eg/LSB+qy99QzIj35ciDfwHTXICT7uqFehUBT0m9gvvugAjgUTwMKJReLzz3sbIVyBIhYvDfBY5EVHpBYc9xUZ894l1uR+Muchr/72+/qYt/BU5IUxoLggsZSe2Gp0SX5ob9S1iGhXis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730536131; c=relaxed/simple;
	bh=VucVWMwmqOoxwHUI426J6iBczgkBi6FfGNvz8HXKWg0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=mbUx5moh5YBH1k8HbTLHziAUWgS4DYcvI9DG5ESWvw8CHcDOtvYakSJ0GPqT/eAChGUJ0hCo4Tn0+NBIma1UWGQXQEXjRobLyGEW87P/2AZmPl97askt/EuDBxEelowkd7WmPgqn2riUBuOv+xO5JnVeVZj/6f0yT0f1AWFA7gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=PAm4xQX6; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730535814; bh=56bfg8HErm/Yf4IHwIPGaZpVasaUNl/SrVReGKrfo5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PAm4xQX6q3+qphA4kEt/zuFiwqZkSTBWYBy7CPdR1zRb1acFkpsPxq5p30EcobPcO
	 mYles30HQi+QvF2zcO80rAdmXAamdab91l496mm3TO86W9AHP6VClSA0evLAjOOLZo
	 Zc82+HbTQAEPi1IfNOoDRwiIa9H4x1c50TzFim6w=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
	id 5E10A4AA; Sat, 02 Nov 2024 16:23:33 +0800
X-QQ-mid: xmsmtpt1730535813t35l1n5d1
Message-ID: <tencent_F5D894DCE9D6EE76CF4C7BCE6CBC2FAD6E0A@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9+sRo5sukoIcvVWU1miBjLMwz74M8LEgujI/vWpnMoMQgLUNiKD
	 frfA9X6sgszR2Dx30/MknW+SHtvfDoNxm/+W4MOgAiEDzpi+6qKasJzrDT0IVzggWdZeXu0lnuam
	 yfCIq0tFvuzCb/DisDpHB0oetW3gmmank1lPhC8ETI8yBskvPSrQqiY1+Fu/scgpgWBwGZ6+IuiE
	 rkL0k0WskIht7195zZtLFGh/HwDE+g3ul8/WaQrjzdpsqoYBgK3Vy/h0P8vabioTJteRD7npS861
	 R8TKtF+nUuqBUFDQmBD3OYKgt8LGDO7BRmsVZSBlu//qOgCDjYipH/27x4GoF5VW1u6XO0Ngw6zg
	 f78776aejkLilZCkOkbxOPQHHtcjOkq9Gy+hm9DbkX8glz1hXYr14uTuqrQRVM5qFHHmr3g7IfU9
	 bloYAOLFQjM1fYitgO1cWbbQAz0cZ3kaZHczBlgHUG+YZQkohO1WS8gPjgC+9G48sFMRBxE/rIvG
	 KZLnMaNkQEqhsDvqsWiNIcvSRsIQzneGQy0FQNAOd4qUyXZN3LRuJKdIiGbVS7gDK+er8gwyAYLo
	 w/RtAu0kb76A142x88fmG+/zPVgWybLHn78a1Dr1qJqQvY7TqSos0bOax9SItJB8WN4VYGbt+cBs
	 RbOXh4SDm7IjwkZktCG7AL9PrR8yVcHVXGO3ztEcnEhJtiHOF5gIRNrmIuvR12fajgMnQyvqb1O+
	 ZRSc7n/IRicdbRJoiO3kgmsouw5yUYgMGBtGFEteNLAQd01zFWS51LwpVcRdcKcPKM5AL92hXxPh
	 K/vAHaferwTpTc8ZvUgvy5S+JlUjb3dVWXNOiuo94Bma4yg4vfZ9ChH7PSAErLUfukEOs3ZMhWE5
	 2T0aOomwKNl1nFzikr8GQd2OrkkfPP0x9i0pHjxdua
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d2adb332fe371b0595e3@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] WARNING: locking bug in bpf_map_put
Date: Sat,  2 Nov 2024 16:23:33 +0800
X-OQ-MSGID: <20241102082332.180525-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <67251dc5.050a0220.529b6.015c.GAE@google.com>
References: <67251dc5.050a0220.529b6.015c.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

there is a raw_spin_lock and spin_lock:

      raw_spin_lock(&b->raw_lock);
      spin_lock(&map_idr_lock);
      spin_unlock(&map_idr_lock);
      raw_spin_unlock(&b->raw_lock);

#syz test: upstream master

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index b14b87463ee0..c2e0b26c8053 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -78,7 +78,7 @@
  */
 struct bucket {
 	struct hlist_nulls_head head;
-	raw_spinlock_t raw_lock;
+	spinlock_t lock;
 };
 
 #define HASHTAB_MAP_LOCK_COUNT 8
@@ -140,8 +140,8 @@ static void htab_init_buckets(struct bpf_htab *htab)
 
 	for (i = 0; i < htab->n_buckets; i++) {
 		INIT_HLIST_NULLS_HEAD(&htab->buckets[i].head, i);
-		raw_spin_lock_init(&htab->buckets[i].raw_lock);
-		lockdep_set_class(&htab->buckets[i].raw_lock,
+		spin_lock_init(&htab->buckets[i].lock);
+		lockdep_set_class(&htab->buckets[i].lock,
 					  &htab->lockdep_key);
 		cond_resched();
 	}
@@ -164,7 +164,7 @@ static inline int htab_lock_bucket(const struct bpf_htab *htab,
 		return -EBUSY;
 	}
 
-	raw_spin_lock(&b->raw_lock);
+	spin_lock(&b->lock);
 	*pflags = flags;
 
 	return 0;
@@ -175,7 +175,7 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
 				      unsigned long flags)
 {
 	hash = hash & min_t(u32, HASHTAB_MAP_LOCK_MASK, htab->n_buckets - 1);
-	raw_spin_unlock(&b->raw_lock);
+	spin_unlock(&b->lock);
 	__this_cpu_dec(*(htab->map_locked[hash]));
 	local_irq_restore(flags);
 	preempt_enable();


