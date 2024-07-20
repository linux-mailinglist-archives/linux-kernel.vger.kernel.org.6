Return-Path: <linux-kernel+bounces-257918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C609380D7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 12:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61CB6B212FD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 10:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B28B84A52;
	Sat, 20 Jul 2024 10:53:27 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685F13A1C4
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721472806; cv=none; b=XrHNBVJOSe/OZoyY5SVxQHNcY8XdI9BEEX7j4A9IOhCjH7JqFz5vUcsl+wu1aLu6QYGQWbp/lKBoo6j3PlsqK5B5c3jENq23H8Ibx1bsGAQmTiWbTAeI+LTCV7T9FnHSY4sjy9Tpp7fODCObitN5+/h6jQyX4uEmdufUZcEcYGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721472806; c=relaxed/simple;
	bh=Og/j0vGQCVeLWmBbzbcmrl6f929LVEsWW4X18yRhg2A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NIKfp18keId/M72cxWfFxTU5x1F2eRWbSpMQYPMlxMMAhB1JAJ1UyjSzrgMdDuKVERBd1j+YVLSy5n9ffupdLRvl7/AibepIafDaURuVIoXr2hwDdNHYueBuhg8atiTfRA0piLdw8nXIKsnD0Buq3nuqhrcdMvTeyhKzhbunR9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f682b4694aso391267839f.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 03:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721472803; x=1722077603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t4ixF7J58Z1EAA9WRGdFo8eCLbhgr9+xEe+G3JoCLzQ=;
        b=CEpww8nX/vkRZXZ8zvZgTRjrKAzsu8SUDisBdsXwzQz+ZYMbNStBeaaI0uo0z+1RBd
         yEVwt9dEY6CgezGmoN1i7S5C9CeQlGZFIW6/UEfpvAEDiNDc75J1qQWx4YlEZPda5oWM
         5G/uvcZyePZheDym9MxpEST2Sg9xzwpPb6bof8+lQtR9hTvPyynUnGqLkFzHmI8TV9xG
         wP6WFL39k40m5Eb2PmS4w/rW1ZgG/k+IQw4lnl0x08dgl1e/FtXshtyCcqNYM3lXYBU4
         1JByZab3GyIptLpHdcXDujGg4M+0dPj7BJlHI4SQ7GXyZhm+Ctp0MaMigi+cEkb3JKa4
         sQRQ==
X-Gm-Message-State: AOJu0YxxLgPc/r06jRuDR0CHTGqWTTGWwtxhUmj6y+uye76d2yR0UG3Z
	O7v2FgV3EQFsxDIPLHWJcWwzbY9eHjEZo33jbZjnKFQsv9xjyWV0t4IZeUaVgBzPir44HFJ5jpr
	BmwSgoHImki2qPtsZu7MCCbGL8/tBfDUZN3OoKPSUi8wAMArzmiHt1mc=
X-Google-Smtp-Source: AGHT+IHHRnIOfgMyotEn2Nt+cFcd439j5GX9LGwTP674weZW+NXiMV+nbPYYiJPVeBJEiP1G2XHzfStSCLPGXUmEyaP7OrBXmMxu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3044:b0:4b9:6637:4909 with SMTP id
 8926c6da1cb9f-4c23ffe1519mr145391173.6.1721472803599; Sat, 20 Jul 2024
 03:53:23 -0700 (PDT)
Date: Sat, 20 Jul 2024 03:53:23 -0700
In-Reply-To: <0000000000004a86bf0616571fc7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f33668061dab9e7b@google.com>
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
 net/hsr/hsr_framereg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 73bc6f659812..ee388739f1f3 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -154,7 +154,7 @@ void prp_handle_san_frame(bool san, enum hsr_port_type port,
 static struct hsr_node *hsr_add_node(struct hsr_priv *hsr,
 				     struct list_head *node_db,
 				     unsigned char addr[],
-				     u16 seq_out, bool san,
+				     int seq_out, bool san,
 				     enum hsr_port_type rx_port)
 {
 	struct hsr_node *new_node, *node;
@@ -219,7 +219,7 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 	struct ethhdr *ethhdr;
 	struct prp_rct *rct;
 	bool san = false;
-	u16 seq_out;
+	int seq_out;
 
 	if (!skb_mac_header_was_set(skb))
 		return NULL;
--

