Return-Path: <linux-kernel+bounces-307954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EE896558F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DB01F24086
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 03:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AB913665B;
	Fri, 30 Aug 2024 03:12:23 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A14D481AB
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724987542; cv=none; b=CKPMoGHZBsG1Q7uO76HNAUzKYpd8cLUF+7wHtRzuKiSIhn6r3ii5FP22DwelY2Cu0F5xyr4T0xyyAFpNXH/fXwAmTlNul3ZKgDoZ5+qTgo4eXQwgoY2EOLi7CFjT+IqarwaNDfO9X89iCUzurNpms9S/MyGWQUQqIUo84gM/004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724987542; c=relaxed/simple;
	bh=8YOzYnu9nUupDIcVBx5GKlwyRFiuUjbB7ECFrS5PqPs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TrXWVM/Y7a8x3jV6IBXbse7zUq4XsrTdTElFeVo5uCCsb/IO7jBrgw4f8oxrqzyG14YcN3RnFUJZGizRR2gIdjq9l/tM3CZz49ifyrWj/InAqUpecGlZivQ87HPWvJkv58oiwVxQfvCN1VPScDkR8RPIU2I09UstFN90nl2UPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d28a70743so12961105ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 20:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724987540; x=1725592340;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2X9cgzIusJJpRm4ht66Xz9QGYg4njF2L5m9NAeBrq0=;
        b=xJz3q5T4yQ6NNH2sAHuzxQ9e05Twpuh+FsUcUEzH7S70j609DZcy53cwOf345jX2tu
         62PonMBvCg/mpOdSl9GoRQIMzEVwURs3BVvi3ed0D8ghrnu/ccavTK2fHTSbKUavh/Z4
         3f1urkqKJeLuS9w34DjMaKaNaraJi7ICEh7rV80YVabekxzJwjcXq4+4CkVjEsciLcbK
         a7JsGPo8c5WI4jtd0G6DbT7egzVZMCpK6F+w7W8c17PbsXMqHN8DEobTu3M5bGqIAxVF
         Dwa+CcvbMa3ZgEZZ7TxKJx1WR93Nz0QPI5c/3P6qq7kSU93XE1EUmkzo/WfcCNiAARqs
         +4kw==
X-Gm-Message-State: AOJu0YwgdjetuEyy4lPnjwq1vu7sXdIsJvWLVFymO0K3mZOZOAOgKOlC
	em6pMxrLxKvDwC1rlcg8Yfb6Pg/XAowdPKX6BvjsF05u7rDO+hSTjZ/MyBRiWbymQLRajxv9G+E
	zXyF99pJ/hgIOzvMCDFNgfVFubtbpP/YPOXHE+TroW0hiXgrouGiCzGA=
X-Google-Smtp-Source: AGHT+IFIKN6XQ9uqJ3clcosM5x+Jm4HIMjZwTUVcYOOAmnEsRJxnYW1/yh7PziUX2CxqZtEhSD+rKG1TqPIKwMNoogNniCpVr4P2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d02:b0:39d:268a:e920 with SMTP id
 e9e14a558f8ab-39f413ce342mr499755ab.3.1724987540098; Thu, 29 Aug 2024
 20:12:20 -0700 (PDT)
Date: Thu, 29 Aug 2024 20:12:20 -0700
In-Reply-To: <000000000000be46510620da5362@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091e02f0620ddf5cf@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] WARNING in hsr_fill_frame_info
From: syzbot <syzbot+3d602af7549af539274e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] WARNING in hsr_fill_frame_info
Author: lizhi.xu@windriver.com

missing lock before call hsr_forward_skb

#syz test

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index e4cc6b78dcfc..32b43bd9f542 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -405,11 +405,15 @@ static void hsr_announce(struct timer_list *t)
 
 	rcu_read_lock();
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
+	if (!master)
+		goto out;
+
 	hsr->proto_ops->send_sv_frame(master, &interval, master->dev->dev_addr);
 
 	if (is_admin_up(master->dev))
 		mod_timer(&hsr->announce_timer, jiffies + interval);
 
+out:
 	rcu_read_unlock();
 }
 
@@ -427,6 +431,9 @@ static void hsr_proxy_announce(struct timer_list *t)
 	 * of SAN nodes stored in ProxyNodeTable.
 	 */
 	interlink = hsr_port_get_hsr(hsr, HSR_PT_INTERLINK);
+	if (!interlink)
+		goto out;
+
 	list_for_each_entry_rcu(node, &hsr->proxy_node_db, mac_list) {
 		if (hsr_addr_is_redbox(hsr, node->macaddress_A))
 			continue;
@@ -440,6 +447,7 @@ static void hsr_proxy_announce(struct timer_list *t)
 
 		mod_timer(&hsr->announce_proxy_timer, jiffies + interval);
 	}
+out:
 
 	rcu_read_unlock();
 }
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index af6cf64a00e0..3971dbc0644a 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -67,7 +67,9 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
 		skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
 	skb_reset_mac_len(skb);
 
+	spin_lock_bh(&hsr->seqnr_lock);
 	hsr_forward_skb(skb, port);
+	spin_unlock_bh(&hsr->seqnr_lock);
 
 finish_consume:
 	return RX_HANDLER_CONSUMED;

