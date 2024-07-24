Return-Path: <linux-kernel+bounces-260960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9147A93B0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396B11F2525A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0691581F7;
	Wed, 24 Jul 2024 12:28:03 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383C53AC0F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721824083; cv=none; b=ckkFEZ6Te06vP+KA4VoQDDGepwOobgi/4YDGtwdm0XMSCv2GkqXy5F4bzoCJ+Se9ZjZJfl550TMMfqZDPaJTLxvchX49Gly05RhaA/qc/dWFTVuSVm5UVIAmJHOpfuZv5tc1Exy+GGwo9dtkgqTDG6BkKlMFXnd9UbSqXsA4YTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721824083; c=relaxed/simple;
	bh=qTwqc7Z9ZK4WI3fs36JvahdOoZsltbJ1IgWFeBwWuLg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L7pPnDRbm5PBzaQCKmtYf8RazrA+DcBff8dbFIEjnFN5EXMNINnmgYzvpU5r4srnFwbbjzsZb8xsRzg46HLEIfB+6SsG90f65NvgBFhBnMqGq3Ere3SXO6HV4Q5RKTpTgRDMvV1bPiJ1TljNem80bJdkZADRcZcXu2NjGT7jQ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-80502b81995so1041188039f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 05:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721824081; x=1722428881;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAziGL5dYE03IQe3n0IIUnCB04695IdrE//nx5TbNf8=;
        b=SBjwzJykUurE1BgWiyMADbPMeACdC4myW9lBxdWrGmwy2pIRoBMi4tgdW34uGz6CFC
         kNGs/jwgzQ+89+DjE9kG0QEA0IXyBq6fr0qYQpVSRcaFHe19iK4NgprOP/gnTbRQOlZL
         9LoqhEbvnJlVa4AWTt+w8O7yUt0q6aZnja+cji25Us/ZxvP4s51TpceRUja1MfvR5I6V
         sj1dgbVDQAqKlXdd+0lad2N4A6KkQxuch20YV+s0cWiLBWSlWGK37lgjiRWzr1bUiAEx
         JoXKtWIulcWof4EtymRlAK5K6tty7QkIwRV71AhYtoEzcCKEFQvrO8eDT+tjWdfwF9TV
         hbWQ==
X-Gm-Message-State: AOJu0YzeQXdXnf/9Sc7+heHFyemw5I7L4r3tdtXu8Ts8Qm1urd0YYI13
	y5wgvxILrTShldVBb91V1jZUnlb8QPjlkswRA/y+TW3oQZaz2xMBy194146O1LCZFASgMNomoef
	2yL//N1lSoIfsQq4HmSi6DbMdusSUYcbsZySJhmFDbLf5OFgYiuOMhzE=
X-Google-Smtp-Source: AGHT+IHAlyBfTzP3NESiEs9dVeOhJSMlArNYMMAcxCjq4pa9ArVIZr/zLcdBABg9n8+mfNvtPbGQgUZufkbb+06STNImcQYFYVq/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8403:b0:4c0:a90d:4a7c with SMTP id
 8926c6da1cb9f-4c23ffc473fmr900942173.6.1721824081385; Wed, 24 Jul 2024
 05:28:01 -0700 (PDT)
Date: Wed, 24 Jul 2024 05:28:01 -0700
In-Reply-To: <0000000000009d1d0a061d91b803@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bcb243061dfd6886@google.com>
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
 net/core/dev.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 6ea1d20676fb..ca1d470bc48a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5126,14 +5126,11 @@ static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
 
 int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
 {
-	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
-
 	if (xdp_prog) {
 		struct xdp_buff xdp;
 		u32 act;
 		int err;
 
-		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 		act = netif_receive_generic_xdp(pskb, &xdp, xdp_prog);
 		if (act != XDP_PASS) {
 			switch (act) {
@@ -5147,13 +5144,11 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
 				generic_xdp_tx(*pskb, xdp_prog);
 				break;
 			}
-			bpf_net_ctx_clear(bpf_net_ctx);
 			return XDP_DROP;
 		}
 	}
 	return XDP_PASS;
 out_redir:
-	bpf_net_ctx_clear(bpf_net_ctx);
 	kfree_skb_reason(*pskb, SKB_DROP_REASON_XDP);
 	return XDP_DROP;
 }
--

