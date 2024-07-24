Return-Path: <linux-kernel+bounces-260942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A79D93B0AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB141C21A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 11:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F144158853;
	Wed, 24 Jul 2024 11:43:33 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CE715B15D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721821413; cv=none; b=TEb0iE7ZOqzPxt+Jqbw4mO7y10dkBArd/8E5+R/MTB+3aR+61p5Yy6ZEb/x8E/XEnPARPEO59pKVxrXShLQHiBmZlP8PYRTaQbZInEHg3ZxpYi2HDGD6y8SUfJGHLQQSXthmweD6mRXQ9R6X6mNb0GKPlGtHna1TeVm9+1H6QO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721821413; c=relaxed/simple;
	bh=Yum3K5bSwFYp7nkoYqZjk1/jRkUFvl5lEF6f+nbZO5g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=twpMMIR/xNldaCTgycMP6r0cWFMUJmykmltEu6hvshTMmA8Bj4HSb7hxwN0HFz+DImakvsBOzU5bDY+e5uEMgLBycXOznL/pO+P3ian+ppnUhE1936WVctrEw2U6ZtPKUlB/d7LYAp59hCx0ncCu0f8jZKIFD0JiE42p1u1q6WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-80ba1cbd94eso1110569039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 04:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721821410; x=1722426210;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWWAls+MmRZqboRu/ErlI3acV3IMebH0OuktHtqqUTo=;
        b=MtrgdpaXYoJcaq59WWKCnXokQ5dzKutw4LnJ/lKkwPrbs71XnVViTX27HUApfMqg0s
         fSyGiTIRBJ8yJ5LcIGz7nD0M5zccB1NWblFDppGlIFthd+iJjVbPwY24w+SFHfGNvSzD
         EsECsueeC7e5fywqvzf2fJow/G6ggysRp1PyHNzis6WRYsp4v/peTyOCdWPyBwsgm7wO
         VJQL9U+rvcJPUkVinrcMuXpK+bfYKWyzU1rblmCZk+kkw9+N79L/krYHMfzj29D1F/vv
         B6qEHSxEOyT9N90JsPvqghW5SaqiVBx5vN/4AyIZAQhYEgGZrjpARQIImHHsQwFBiGUM
         rqoA==
X-Gm-Message-State: AOJu0YxJ5D2ruTRVJcLh746ZaPy7kuJzJoD6zk7sc5rxTG2stkomqIV1
	yVaX+ymm+7/9yjpidqIbTx2+5wD/WMbEu/dXb+tRghjumAPpgtLucVXifIWe3r41S2w41wMXS+e
	U7Vx1ez3ZVzviMGA1HIJhpWEKD+cG6kEOKX+SZMcPyJifeIdOvcLokjg=
X-Google-Smtp-Source: AGHT+IHlkLyu1Sx4unUGVQdB+L8jL/r7MvFUoBdmxTYIQi+3ZbNvRXhE3AdbqJVhc+jhKuutWBSENPXJzlb1Hkyk0Duzef2ejdKo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:148d:b0:4b9:e5b4:67fd with SMTP id
 8926c6da1cb9f-4c28ed2398amr88539173.1.1721821410281; Wed, 24 Jul 2024
 04:43:30 -0700 (PDT)
Date: Wed, 24 Jul 2024 04:43:30 -0700
In-Reply-To: <0000000000009d1d0a061d91b803@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086df45061dfcc91d@google.com>
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
 drivers/net/tun.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 9b24861464bc..9254bca2813d 100644
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
@@ -2570,7 +2566,6 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 
 	if (m->msg_controllen == sizeof(struct tun_msg_ctl) &&
 	    ctl && ctl->type == TUN_MSG_PTR) {
-		struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 		struct tun_page tpage;
 		int n = ctl->num;
 		int flush = 0, queued = 0;
@@ -2579,7 +2574,6 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 
 		local_bh_disable();
 		rcu_read_lock();
-		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 		for (i = 0; i < n; i++) {
 			xdp = &((struct xdp_buff *)ctl->ptr)[i];
@@ -2594,7 +2588,6 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 		if (tfile->napi_enabled && queued > 0)
 			napi_schedule(&tfile->napi);
 
-		bpf_net_ctx_clear(bpf_net_ctx);
 		rcu_read_unlock();
 		local_bh_enable();
 
--

