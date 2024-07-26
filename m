Return-Path: <linux-kernel+bounces-263163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB3B93D1E0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 545DCB212BE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AC817A5A1;
	Fri, 26 Jul 2024 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AgtbxkRO"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300CB1EF01
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721992499; cv=none; b=cTQNXlMonVZP9SowDucNxZ0QP9/yTZkT9T0HRrJcWK8gLpFtE6TzzB9qLgeSDXXtZUYIgEDn3xIAN49gNHPCNuQksfxc9bxiYF6aSSqQqPAmr7s4QLTaS80Z6ChLiP3pGsbibZGT2N+eUxG7miHYeIAvpGLZfMaSZFKm9OWb6uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721992499; c=relaxed/simple;
	bh=qX8Wm+nVjiipKjmSloflqx00z66H60x4AXk0YhDzRFU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DjnNg/7OjRgLDYS51XPuywst0F5h6LA9SBbdA5xuHZu0LPu9r8IQNLPiwVxbu3ZUIgPFaidWh4t+77d3NIRawF+aEaKTA5BQFiwYcUcUGRPro5tAnAbd0l/MtCSCD3zIC3QLFAggvWBQrqLvXLEx/3vuT4bfZzYZlbb9fF4eAfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=AgtbxkRO; arc=none smtp.client-ip=43.163.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721992480; bh=9y2gQBYdF+4fvGAQLtPbF09d/hGrhhGAx0CEPOjik3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AgtbxkROChEjYLgOT8/tctd6aulrhzz4YJdM8Sz8rJEGxvtpYoDXlVvvC5zWBLpL5
	 /DeHtF6jKasg4oMfi4l1p+EzuXCHhjwJ5UjCrXD+Z/k7IFo8VZ8dR/Q+V3l+kC5cCC
	 nPuXOivWTf4WAOELInz/VLxwwv46en5s0fbA18xg=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 2218FC3B; Fri, 26 Jul 2024 19:08:33 +0800
X-QQ-mid: xmsmtpt1721992113t79n6gfz3
Message-ID: <tencent_6858E8F6EDBECDCC79226C942EA56E00950A@qq.com>
X-QQ-XMAILINFO: NshvC2+mlzw3FeVaB2wNQINgXH6REePmdERlmDl4WGDDQJeeEkCKYKL5B31Q8R
	 fGhqrobt6fjMaB/hMJVJqkycSfhttkvbrXjtgdcIEYbH08+QTlAt7ckRxoLQeB/QlGzA+7q80csi
	 nWtXuNLttTTuky+90MPInmQ7ILdeT3rumJnJJyUoFQ3/FbOU7fxcbkDI68RirGaogzqvhomqM61x
	 oSSUm+dxWeJ0da6AJnyoo+KhJzPNDyNwFUbJkHUOnWv+o40GyIiTmdTUasdKXJYtT9Gp4D0QIFz9
	 cqPzanXmAPxtPmYKZskaMCfXuQ7qanA30Ciyi5AeCHx4YzZYxqL/PUyVtjbCMInWdkaJMVv+4Rv5
	 mWyFM46D1yctz9Gfu/U9OM5H001y6RI35ElEziNH1SS6MrDVIElOc5EW7AkdKdT/T/mUe0YnNgtb
	 2yoGDlw6Jp6r/w2BbS43pQfNlU6Irq1ZomQisew+EzNzsYIaG/PNHvqT2iW+g8hf/y01dPkMZTid
	 mki+J8PGf/YIAfXFqG7Jc3ufqrgoVJx7FR5jyB6CTPleyf9irVp2dA3RqF8BDWOzPnahPg4wdPS+
	 QLs1zjjOrbhBnr1WZ7iqPOMFMs2yvprKi4zK93lhZv0OOGHxP7Kwvr64kKxmuD3uVG2tJF84EARm
	 7epETQ6ESoh6oVaFvsdUfA+A5JA6zUpI6DeisZFL63Jh7rE5jKUzm/99qC6Mt8SHLEQ/LXgcxL2I
	 ofJWKquagXVhVOYJqmFOg3vsxiy0w0JBj2B4CBNM4z1rjNPEZgjSN091mlOX8DHE5dRC0cs5Ezkl
	 w6czTiX5ncC6HDSrabss/8JW4QR5rT0m+je0nBhv+/TT5/6VeZljO5MWYz3A5qtkOBQwCZ4BcMos
	 SUqwiPcOGYD6+XWsborKi98sIuagJErW6jxfLIgmax
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
Date: Fri, 26 Jul 2024 19:08:32 +0800
X-OQ-MSGID: <20240726110831.2101742-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000005c7ccb061e032b9b@google.com>
References: <0000000000005c7ccb061e032b9b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add mutex sync remount and shutdown

#syz test: upstream 2c9b3512402e

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6066c6eecf41..269e11fa477a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -27,6 +27,7 @@ static struct kmem_cache *victim_entry_slab;
 
 static unsigned int count_bits(const unsigned long *addr,
 				unsigned int offset, unsigned int len);
+static DEFINE_MUTEX(gc_lock);
 
 static int gc_thread_func(void *data)
 {
@@ -203,10 +204,13 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 
 void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
+	struct f2fs_gc_kthread *gc_th;
 
-	if (!gc_th)
+	guard(mutex)(&gc_lock);
+	gc_th = sbi->gc_thread;
+	if (!gc_th)
 		return;
+
 	kthread_stop(gc_th->f2fs_gc_task);
 	wake_up_all(&gc_th->fggc_wq);
 	kfree(gc_th);


