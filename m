Return-Path: <linux-kernel+bounces-259093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D49093911A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3701F22068
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07F916DC24;
	Mon, 22 Jul 2024 14:57:44 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0647E1598F4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660264; cv=none; b=mcbEzPLn6QX4V4rACh4HzlwNJKZW8nWX+TfqwKO4OKIWiP7mvslfoturPzP7g3KMo2ftPo46oqKHcyiPa6j2JZo3Qiz8Lc3fsc5jYBl2Jpskyu5aQMmfy0cLFX3EMXBnWdwO4noNWRTWWfInFAR/T1ss2cE70dY4UdySY9eSXTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660264; c=relaxed/simple;
	bh=WL/GM7WE0wU/NcCtoanPw23IJTYZBmQy3B/6tKl5tOU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gsQ7kBCMGwyd+qZNCNvHIE4a6OD8269jhU0fxbjDW+jIJ9X/OsjufY/eMfdmA/3q3FevNXkoVY4aCkgS5Orr6E3BuGhN1GjHHPjMg585R+wi3OcAtpFdxlUjMAf8c2lVoKudGC6chXGHc2VWlIO5kE5Zrbq/Ki13AF5rOZa0GS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39941f4c5a1so38906115ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 07:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721660262; x=1722265062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4EMuhfU9gd7TV5OuHBnL1tsJUlRGxE+o4zw1F7KEaF4=;
        b=tDU/I52Vh2z4fXPYM2yY/6ORdHFlQGkMcepi39CFg8q+hbUCYDSetRbNoy+rM40rvt
         W5V75iFwGprIgAZjJgG3wML2SFYo38/KaXbDc6YPUOXTFsDs3kaFrtOFtOANqIcfPUIu
         KvwfoqgwU56IRjF/IZOYOh5f4IVWCFkMg2p2/lxw785AfGvpKYoxGXOpTbpDize3gdJ3
         Mkc4B3JBp345OJwExO8Sc8jex5+n2K3YuuA/7tWlkTKdz5mvEvN9hF1L6tNICK/sPfSM
         Q/yYfO5W5Tqtph674zxfYx5dzeAT/s10Uj9wKrP5oXUr8+Pfwvo52F5blP7GRKKeKBsA
         v5kA==
X-Gm-Message-State: AOJu0YwiQEUAgrLDbKVIn7IOJuFtfCdHAPR8PoELyoL5P+sYXyQMs61A
	5Pl5XWMo4kx24oSyW2UyPv5wYEZ326VvY9Geb1qKBi2JckAYftks20H9IbsmG+pGBW9O2IQ48vn
	m5yudErtFL9av2OJ4c4RGZZzZA0B3P4tGB7+H04E8exf57e69a9H0jLg=
X-Google-Smtp-Source: AGHT+IFTQMalkEpIshLx/WqG6Yy7lsISfkEm+9cORDMEpeqSUnli6Zk2USUTBj+U9t/a6+0bhvUg7ixb7QmcfWCVIwjmyYP7ZCPs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8a:b0:397:3a28:94f1 with SMTP id
 e9e14a558f8ab-398e6d89e9emr6810465ab.3.1721660262201; Mon, 22 Jul 2024
 07:57:42 -0700 (PDT)
Date: Mon, 22 Jul 2024 07:57:42 -0700
In-Reply-To: <000000000000e8fcab061d53308f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a4c84061dd744dd@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] [net?] general protection fault in __xsk_map_flush
From: syzbot <syzbot+61a1cfc2b6632363d319@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bpf?] [net?] general protection fault in __xsk_map_flush
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 include/linux/filter.h | 6 +++---
 kernel/bpf/cpumap.c    | 2 +-
 kernel/bpf/devmap.c    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index b6672ff61407..22691015d175 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -842,15 +842,15 @@ static inline void bpf_net_ctx_get_all_used_flush_lists(struct list_head **lh_ma
 	if (!IS_ENABLED(CONFIG_BPF_SYSCALL))
 		return;
 
-	lh = &bpf_net_ctx->dev_map_flush_list;
+	lh = this_cpu_ptr(&bpf_net_ctx->dev_map_flush_list);
 	if (kern_flags & BPF_RI_F_DEV_MAP_INIT && !list_empty(lh))
 		*lh_dev = lh;
 
-	lh = &bpf_net_ctx->cpu_map_flush_list;
+	lh = this_cpu_ptr(&bpf_net_ctx->cpu_map_flush_list);
 	if (kern_flags & BPF_RI_F_CPU_MAP_INIT && !list_empty(lh))
 		*lh_map = lh;
 
-	lh = &bpf_net_ctx->xskmap_map_flush_list;
+	lh = this_cpu_ptr(&bpf_net_ctx->xskmap_map_flush_list);
 	if (IS_ENABLED(CONFIG_XDP_SOCKETS) &&
 	    kern_flags & BPF_RI_F_XSK_MAP_INIT && !list_empty(lh))
 		*lh_xsk = lh;
diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index fbdf5a1aabfe..8fccc311397c 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -676,7 +676,7 @@ static void bq_flush_to_queue(struct xdp_bulk_queue *bq)
 	struct ptr_ring *q;
 	int i;
 
-	if (unlikely(!bq->count))
+	if (unlikely(!bq->count) || unlikely(bq->count) > CPU_MAP_BULK_SIZE)
 		return;
 
 	q = rcpu->queue;
diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 9e0e3b0a18e4..4b9203deb711 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -378,7 +378,7 @@ static void bq_xmit_all(struct xdp_dev_bulk_queue *bq, u32 flags)
 	int to_send = cnt;
 	int i;
 
-	if (unlikely(!cnt))
+	if (unlikely(!cnt) || unlikely(cnt) > DEV_MAP_BULK_SIZE)
 		return;
 
 	for (i = 0; i < cnt; i++) {
--

