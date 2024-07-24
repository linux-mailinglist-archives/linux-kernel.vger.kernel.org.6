Return-Path: <linux-kernel+bounces-261064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9353893B280
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ECB3B22F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FF815921B;
	Wed, 24 Jul 2024 14:13:32 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3C5613D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830412; cv=none; b=kbCYXNDJTna0jsTyFqTuHttZIPOGcLL1jLtV9S5Eo9mF3INRhxP22+iHIBib/1ofPR6CGD53o5YEHPC2unYLXI/n/cYxrFZSmX6+P/ej3dg6bI3s4eF0/tdiloLDtc/BxcS2fxQ3MAKwwvKZr1Nzoloe2dLo0WGITDzKerXKQj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830412; c=relaxed/simple;
	bh=spl4D/0sWXkvoKxaCgGn8MrSzOO6wvbBTkc4knGsxf0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UmLrjINEmhyOAvylulFRr/0YIxt5+B3MDM38c6ENTQL+/Txwrx1TEA/V5SNjb7cVc+n9EOmkc8LAafy8L/2CrL03XfD2RL583xIdoMqHenannyhmnpBxDkM+jpp9En1IpXtwV+l474t6zNOonQC2hYAnyiQuIL5v90OvbrAtz/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8152f0c4e1bso1181224339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721830410; x=1722435210;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOJYsfuFSa7RXdaUea8c8BQsiGhcY9xwVrvk5f30c4s=;
        b=fIY167fOurVUXxJs9iZ+I7RPEPYdeTQWDKFUh/0p/wP+QkH+XX3InwZGoppqc0i4BJ
         Xanefe23NGYbOQDE18AjwImcYt7RDJP3ygh1pL0qcymX7X3G/u+Ybu+DEI1ynkKdJ94r
         vvmEoX6H2LAK5TxHoRVpJLjHPd9IFXtx8IqcJWEWbZe3mbdQFXSmeHhCRd0pd4MF+Wou
         9uLzf1PdE1y1R7kB+vNJV2EGMs1ZbUpgNlvTM0LUvoqjIFO5TEQThKYAF06WZ4GN0X+S
         myTNHcBYpXs6Gi9MIoGVlC/kEnXfwVvDjuh7G7exQBRUCkEsdIQdVc+5Dq8mMLgVjwFL
         wS+g==
X-Gm-Message-State: AOJu0Yz5VZuVBkcCP27sY94ns2yK+TF/F6O1s9rNr/jeNPsxHfn0o7CR
	HAwJC10dcXHvTDOKPYaKNvexx0/gB9iS8Uc0rG6Q5Fm7oTll0PemH/QDr49bEDLPsva7IZ/OoHU
	WDWL80A2ntZQH3aA5A6udHDqquwiTJfVlRuPv3cIbkoPb2VpGpg/Fzu4=
X-Google-Smtp-Source: AGHT+IHps3iqaJ+7NPWvVc4mfrezufNXjRTGgsqOOcCMu93T1i9q8LyoZt42lQUmNSvjG4flJP7m4W6ZqH3To8a6DptxzppPJwL7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c4:b0:397:9426:e7fc with SMTP id
 e9e14a558f8ab-39a191c59d3mr2079325ab.0.1721830409878; Wed, 24 Jul 2024
 07:13:29 -0700 (PDT)
Date: Wed, 24 Jul 2024 07:13:29 -0700
In-Reply-To: <0000000000009d1d0a061d91b803@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1d2a2061dfee175@google.com>
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
+		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 		ret2 = do_xdp_generic(rcu_dereference(skb->dev->xdp_prog),
 				      &skb);
+		bpf_net_ctx_clear(bpf_net_ctx);
 		migrate_enable();
 
 		if (ret2 != XDP_PASS) {
--

