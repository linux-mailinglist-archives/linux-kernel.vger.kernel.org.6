Return-Path: <linux-kernel+bounces-261025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2003493B1C0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2496282980
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CCA158D84;
	Wed, 24 Jul 2024 13:40:19 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCC722089
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721828419; cv=none; b=qPkYrVDfd2VtFvjzGDdITHTXknvhn9ZbpXxkEy7FM3HpNoDrSv6Bxi41ZKx2kq+pZAT9nRqOWzn9r/h/fNlz61u8YzG+92ctSzzmFdluHeY0o8BrN7JOp16j3APN0Ft86oyiMEmltkGNw3R0qiAAxv0t4LaMRwXWHYFR5OWKtUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721828419; c=relaxed/simple;
	bh=IMHq6VSQhX04awl8XcAowJGmScNEUw3R77oQoHI5xOY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AUtpEJBgE7BZInA5E9NI17MD7vDA65zj6kBplX4xbiw8PpS6JKh/EEWUMKbUuom1RsFc0sZW2H1Dp94HVGZkIudvT1U/yZBoUfAsqcbaSVbxl3WvbcthBnHio0nuQBhFW2DhVqSBnpYzzdloWs77sBxHYVjAgzj0zf5CCppNChI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7fdfb3333e5so1135641239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 06:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721828417; x=1722433217;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bswPnsyRcE+B86xCqYjvc+DKT/fsk8X/2wwjq5gF534=;
        b=QJYSm7/pHYPpMX0F1Wx0h3YXvq9ol6wp5Au+h/JphPsvB/gD0CgIBQLqR5ZNYC3XdI
         FWtvLzdY/f9mjH6UURuin+/P+zsEg5OEg5oRGf0jFy0a0sYEzKUERRJ3XEdDBAQZGTma
         Lvmzx7DSYOzyFBlZcF88EQ+TUus/xh4psG8oWtz8nfS2QvSzwAFTUUwanPfbNsjbmYeT
         1cs+6ywyI+butmDPEMo6FiY7N8U5ByEpFYtzLG5AMom8iG8zmQCyuUh6RFkYA/3v68G8
         5Tw2eZpg/1JwtbzcKJPG0vaaLilMVqhx9ysf8Ml05XaeG4GdF2u4aRKlewRk76zs/gWO
         6Rfg==
X-Gm-Message-State: AOJu0Yzb61qUHxEYQaL9ekNDjbb8YYuBuullne6DIkXONaH9v64HKMQy
	vc6EQ4Om432vjqGZu/7HdAzb491uekWUCSCLQuzUyAfNsHB9mEhqn3/sq00KvUXXn9wvIMnkAGK
	Wlf3gOYHduCwEKZh8Qwe4v+QvvQ8U3wUFuSS3cuZc/nwSPARUrtApOFo=
X-Google-Smtp-Source: AGHT+IEeNbRgkra62nhyWU6iwg+xaeTHcpb47uaCFnjgt2l55lw8xAk08jhUaFtR0kYmFSBxQlkx/a62RSB3e9bZVBKWGPb92a3n
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8616:b0:4c0:8165:c39d with SMTP id
 8926c6da1cb9f-4c28ed2a57amr90842173.2.1721828417134; Wed, 24 Jul 2024
 06:40:17 -0700 (PDT)
Date: Wed, 24 Jul 2024 06:40:17 -0700
In-Reply-To: <0000000000009d1d0a061d91b803@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002af3f3061dfe6bc2@google.com>
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
 drivers/net/tun.c | 3 +++
 net/core/dev.c    | 8 +++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 9b24861464bc..095ada4a525e 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1919,10 +1919,12 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 
 	if (skb_xdp) {
 		struct bpf_prog *xdp_prog;
+		struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 		int ret;
 
 		local_bh_disable();
 		rcu_read_lock();
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 		xdp_prog = rcu_dereference(tun->xdp_prog);
 		if (xdp_prog) {
 			ret = do_xdp_generic(xdp_prog, &skb);
@@ -1932,6 +1934,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 				goto unlock_frags;
 			}
 		}
+		bpf_net_ctx_clear(bpf_net_ctx);
 		rcu_read_unlock();
 		local_bh_enable();
 	}
diff --git a/net/core/dev.c b/net/core/dev.c
index 6ea1d20676fb..26f9fdd66e64 100644
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
@@ -5475,10 +5470,13 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 
 	if (static_branch_unlikely(&generic_xdp_needed_key)) {
 		int ret2;
+		struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 
 		migrate_disable();
+		bpf_net_context = bpf_net_ctx_set(&__bpf_net_ctx);
 		ret2 = do_xdp_generic(rcu_dereference(skb->dev->xdp_prog),
 				      &skb);
+		bpf_net_ctx_clear(bpf_net_ctx);
 		migrate_enable();
 
 		if (ret2 != XDP_PASS) {
--

