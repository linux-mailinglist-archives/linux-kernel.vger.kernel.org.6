Return-Path: <linux-kernel+bounces-257874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DA5937FFE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 10:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E143281D8B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 08:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AEE288A4;
	Sat, 20 Jul 2024 08:30:45 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802698830
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721464244; cv=none; b=BvpUu0Bo0T4AkNL2dIi3qv15ENFOMGpC9A9j0nLavCLCH+Aud4EPPpG/V1Eca+aFxo9Sa29IYM2llKa2JJdc0177eF0oM6gDdfCV9tltPfDCqiyhejqqvTIf9K8JGMmdyzT3Xj3c3S/vHmhB+0x0PlXqjmfQTv8R2Qty5d8DqnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721464244; c=relaxed/simple;
	bh=rYSMhlcYUfuUJmk7W0A2GRupXQQQxzarnjBcJ2gBuJs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fJIrI9ivTUEbukBgl1TLy48nSn0MX5QvqoXDjWzM2zZrkdLRCS0SVnKSOKtycTE+GmsHo3WbKh3phRGHKBGum3nfjiful5KWQeavYtDqcD3mQS+c/lpqG8RM2pEkaprQfbU/KLjIpLrquiMCKB71emZAqpdadHd0lwbZOLw99cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f682fb3b16so442870539f.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 01:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721464242; x=1722069042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/8XzY4rPxD3nry/QyJLQA7kZA0p4z0MbynfkV9ZB1I=;
        b=LpGoBYMfjrFg4bxxgJc5JXnwsj9KiCkC1UZhFyldnD4r8HwzwPaPvWA546MRO5aRqO
         U/3xme15ZjcoZ4AV6Ssh5zOSyMOmzUEZkRZfTf3ck6hMCdQbDNiwWOdb49fgDNmEBkzM
         hm8996EwBEGk0Z/JWSyoEmzEZPbHsOs6XVrurQ18FfQrIizX2SKyW5H+PsHbmjl3KAvz
         b0M6ea8G7MUHXOi338fNlo3bfd7MtgySw5QDjuP3JCGfDofpB8bZUNnHPiOUP+Yh8Kz3
         5sPAjQ+j8XTMt5lcywn2wvvuplQefLofzDNe9G+49Vu2o9v3SBJ84KZ9sWucfFSPT3TM
         h+xw==
X-Gm-Message-State: AOJu0Yy31ibF1+2PsrDx57s6QkruiQuKi+9v+Tt+Sp6gMAiRyL49c0Ca
	+CkkotMO3hi2GckQ3NI0IH81HtC0tc+jFuYscWqt79+hDaXpAqLX8b8BywvLR8x2sMuWJjZDgJ+
	5c1ACVVFVNAFKjbjBdCRqaVXn32LzsiFqGwww5xF5u0TAxEM58jamWqc=
X-Google-Smtp-Source: AGHT+IFf0VD/zQW37S2mTPNPUWsT+NA4vqq2N2Q++KYyXyfjoP0usWqfLL0khkBLt/lYTetDnjbJ+fQ8m9bzDUMrpIY4FMVgdy7V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22c2:b0:4c0:9a3e:c263 with SMTP id
 8926c6da1cb9f-4c23fae6db7mr132849173.0.1721464242742; Sat, 20 Jul 2024
 01:30:42 -0700 (PDT)
Date: Sat, 20 Jul 2024 01:30:42 -0700
In-Reply-To: <0000000000004a86bf0616571fc7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aeb998061da9a010@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
From: syzbot <syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 net/hsr/hsr_framereg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 73bc6f659812..1c492146594c 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -224,6 +224,9 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 	if (!skb_mac_header_was_set(skb))
 		return NULL;
 
+	if (skb->mac_len < sizeof(struct ethhdr))
+		return NULL;
+
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	list_for_each_entry_rcu(node, node_db, mac_list) {
--

