Return-Path: <linux-kernel+bounces-257871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ED4937FF9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 10:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BDC2819EF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 08:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA41328DB;
	Sat, 20 Jul 2024 08:18:10 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FE61803D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721463489; cv=none; b=bjvZ9AuSGANfo14NJeDo+dZCWoiJC+NgbN33XWp4uhy+Stlz40z3cpvOhXV6fExxPWusDZ1g30ihCB2ZVtnUVy3C3aeNzvs5acSfRDxHrKfLnhYbDdpV4lQI2lX1QXuaCZCGtTE2+QOWxeczAqQREemZK0Jl6Wuxr3saeLSAmDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721463489; c=relaxed/simple;
	bh=eGq3lGqKaXEBbWNmvq6EoaVTxMPneuYAgTEBPybs3Zg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C92J3ApiCvqD+n0vT+3pu7O1wJO4ZqFdApi7lOXa4jpKcideFcKRDUiKPseZuSCOJUa5dYZR/e1O4w1/RsQLKctj+L/FGBIqBh7v69MnQ7rL8VVC4EpTGvFpWQ7O+nZcCyt3pl8vSCjXN+YXSpVebTSmY1mV2BC5geR8QMu2vwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-396fa3fe46cso40361645ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 01:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721463487; x=1722068287;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHpc9iNmXjDqLhEZLHYoT0SqXGs6tsOGHhQPx17dpRY=;
        b=Ni0EuUTbbSIF6kNQtX3zgLIE1821x9Z3VNHIJH48DNAN+VVfMZ9Q/bo+E5ZVNyGcOW
         2mAZorBirJ5mVDlL53vwjHxmI6Wpp3HwxsenFV1WtCvA+IlnT0g3o9wW8qkKXpBzyv8d
         PWNyKGGc9Zv1T66yMNNf4NyqOvBBaHLzvk6PTiEv8oFvKyRJzziQn725pORXI9jJ/ZcV
         IDUYP/4vRjAiQtQeBpPe3Pr+eo92VKKaeGPm3I0IeoFi4K/YHg6q766yZOpaTlRUVItc
         feb19PaW6DcbbhRfzmlXRHqSf+Ri0ZhxkEdMkh5Fkihm64Y4ARuDY1cBo+HE0ZG1Z8Kc
         hBug==
X-Gm-Message-State: AOJu0YygQ13i5kgShkRwqUJI++802fJL5yiEhS6toV5NKwqytotRGS5/
	2dSsacwWiUHtrp2EdGAc8AP/sZjtz/2fXNmUlpBfm4rEm5ZREwBwNgCr9dEBvZkq/QkWH1/8r2l
	siH3WJ1iuPUGfZ3YeBJmRTqZrfT7c1dgIn2hd4xdyIxSby39meEITTR8=
X-Google-Smtp-Source: AGHT+IHO4bdzwuFDLfN0iXgPheARn8Vb51fjmNO6NzKaRh+GxVsAwCWKcwEFh/jb35xilrSsYF99jq4EbPZh4ArRdbqLGQq97R21
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d15:b0:398:770d:1fc0 with SMTP id
 e9e14a558f8ab-398e509bce1mr908385ab.2.1721463487736; Sat, 20 Jul 2024
 01:18:07 -0700 (PDT)
Date: Sat, 20 Jul 2024 01:18:07 -0700
In-Reply-To: <0000000000004a86bf0616571fc7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae3dfd061da973b5@google.com>
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
index 73bc6f659812..b7d5b9da881a 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -224,6 +224,9 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 	if (!skb_mac_header_was_set(skb))
 		return NULL;
 
+	if (skb->max_len < sizeof(struct ethhdr))
+		return NULL;
+
 	ethhdr = (struct ethhdr *)skb_mac_header(skb);
 
 	list_for_each_entry_rcu(node, node_db, mac_list) {
--

