Return-Path: <linux-kernel+bounces-260838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E57693AF27
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9F428390E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCE014D29B;
	Wed, 24 Jul 2024 09:39:11 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C7813DDC2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721813950; cv=none; b=Fz3eQPAyYDV+yxtiXXqS7Ut8XF43LJnIwe9CKr6Tl2WQk8zw4fJUcbp94KRWzdjNw20PwE0pDMjiadcIEjQFGXlHa+nq6yX2RdHItOMo4c3Fmakb6t3tpd82zzA8wu3tZHICAYftIbuqrabHqToMBKp6X9OcbAoLHuK4y3eizNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721813950; c=relaxed/simple;
	bh=Bp81iqZIOYmPiZ/Bh1NDCZ12s/a/ruOql1tu+JpFESg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=N4do0M55h0NG0TR7tmA0j7cxE1w8l9hK7qvaQZ07b0CeIyoS8E3JOEHENT3jCUqa0UoJociRbHVHdrvDWuLFZ0RlNILqWQPtWmmPkc8IFq03ROwr4K6Dbzf1F2mxbWfmeoyi3hm4PJKRvh5Lpe2wJKGMRo5qCQq9KE5SgPUBDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39835205d20so91190455ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721813948; x=1722418748;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GyUkjtNhd14qYqsMaoK4xiiu1t1Nq0fBgKjw3ohaDzI=;
        b=tNRRwApdNhFCZBwPFd/niJuRlGjkZAx7edjhkNleVqG1t6YfPanU2QEWT5soS2JGrJ
         uR2cCH9gKk+88niwFTOWC1Xa6PMmi5XZzJFX2pLsVSinfC+I5TzYL65gwiR60kY/4BHz
         qxN9GmP4VluEuvpkONa4xJvAXJFxQ5h1cgUqKJVtsAOMEnj0+HBWLA36n/aszAnhduIN
         zdodyF88qJiUFpy/Ev59VbpFEGYzuu0HGWcU9Hueg/Lev5kZv2rvD2HIK8PWezELGBXE
         9gc4t7iDSdV7j5Ucn1j/TgpgVO9T0pLlkf8Sc14ets1oktTPW7S7J7qhA6uWnLTxtr4j
         MpQw==
X-Gm-Message-State: AOJu0Yx9DU7Me4B1TZuZpTZCE0USTthXBe/7WJRSA+nODa0J6GF4GGqy
	j9TIPnaUP/q3kUzuWKkm8ynwMxjL6DfnLjnaI+EZsIITLBqviLFoQ6XfY3DY3bq7EijVzrcCIFS
	/AM+vcrsRAvcwPsPxf8k+aQ88EApWiDidpWNhj0auoBU0T1s/YRjk6k8=
X-Google-Smtp-Source: AGHT+IEKz1CWOsSrTakcdR6Mff8ypIrFc0rBf3/hyTEU9yhIIjwJyw1UJw2m2Vrs1mkOFTEGNtDARE0wCJ8TQA45arvrdZmOJwWn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1c:b0:376:1fae:4604 with SMTP id
 e9e14a558f8ab-39a19768a28mr1705055ab.4.1721813948529; Wed, 24 Jul 2024
 02:39:08 -0700 (PDT)
Date: Wed, 24 Jul 2024 02:39:08 -0700
In-Reply-To: <0000000000009d1d0a061d91b803@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c59739061dfb0c1f@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] [bpf?] general protection fault in __dev_flush
From: syzbot <syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] [bpf?] general protection fault in __dev_flush
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/net/tun.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 9b24861464bc..022ffadae2af 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1661,7 +1661,6 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 				     int len, int *skb_xdp)
 {
 	struct page_frag *alloc_frag = &current->task_frag;
-	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct bpf_prog *xdp_prog;
 	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	char *buf;
@@ -1701,7 +1700,6 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 
 	local_bh_disable();
 	rcu_read_lock();
-	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog) {
 		struct xdp_buff xdp;
@@ -1730,14 +1728,12 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		pad = xdp.data - xdp.data_hard_start;
 		len = xdp.data_end - xdp.data;
 	}
-	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock();
 	local_bh_enable();
 
 	return __tun_build_skb(tfile, alloc_frag, buf, buflen, len, pad);
 
 out:
-	bpf_net_ctx_clear(bpf_net_ctx);
 	rcu_read_unlock();
 	local_bh_enable();
 	return NULL;
--

