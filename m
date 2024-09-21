Return-Path: <linux-kernel+bounces-334715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8ACC97DAF9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 02:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41031C20F9C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 00:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D37E15C3;
	Sat, 21 Sep 2024 00:23:43 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8986F23BE
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726878223; cv=none; b=nxWHYfFRhL/06GbhVeD4YH2QefKPlYny2RYKD+wlBlNou6PYpy5BFGtDtVXxarLzBb2tbgWnzmPc1subFULBCPov2rQEmTCXgtVRsRH5dOH2teunMM93zRPkH9QYmyiD4gc9NkHCxQ1UhD2IH2DxcDrPoJDSIVsJGkZOR+kpz+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726878223; c=relaxed/simple;
	bh=u3rB5hTcQZuAa3rbKg+NZtZmddC3KHjKGLwztVJusSY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hfx2dE9UbstUvkqWwSEJl/pFq0L+5eyuEBPmR6t++OaZi0wnqEqdNJ1E5q7i7HUyo4XjDl7WOrAbMLKikAB5ug3o4Mbv8qFax19mmcCcZBehmOxQ4Y2lH4RXMBj5NQgYZD9wsm0IRt1rtt3vKRcQHDwymcdHvO6GSAN1e21/EuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0a2c95e81so32545205ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 17:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726878220; x=1727483020;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zyv9c9d6atwEArdssp7ggLPbXX30xCj+fHgKHGN4Xao=;
        b=ExSyT4xzrWNE2/oz09DyrjbtbrzuqVRcJRd8y20RzriG5ZuE0ctR9icQa2igB0+V9l
         LmbGTABAdfQF80iLJazK7Y2ydlr14G1VOQQQEShBHwDU9jPoJePCszi+rM785AVGgEAm
         zowXo+sVW6gORBnzM2cLlUrpXz+vyloJgNr6ifu2QvHRL4eebfXThPPTlFtV9N34SaC1
         3H/TM0TSvrg+GrwNF9Oh13VkPtOLiVdpXSmzQIOicPLZa9qbtoS2pgfW2EQQNrmHcGcO
         ouJ4APuqyymcLAZYjXbxEAiNfIVcbRCdn8Rmn8zlLgMmJUXpT3T8AQvhVTFXSS/S7vqJ
         ETMQ==
X-Gm-Message-State: AOJu0YwYpChbSZWMIh3WKws4+m/IQl6B0GghNPQBqkXwxh0YdMMXgILp
	CHCKkMMvJAHLS6V8m50xKrj73JCbBP3/h4AQvT4FK1mQWjXSzsAtR6Z8yZ5zEe71uL6nyCzolBA
	i8+IeegkEctvyyYjHQVdROWNKXwYo4j4GS6CzT5dGKSE4sKiBACRevKc=
X-Google-Smtp-Source: AGHT+IE6q+nEU4Y1AUHYw3pEc0tK42TWbDeZnJyb+wjbke+bJbf3QCt8oSKR2Tg14y26tBFCrahY5fDI0cLsWhTrKqdQzm1kpV9r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc7:b0:39f:5521:2cd4 with SMTP id
 e9e14a558f8ab-3a0c8d3978amr47903515ab.26.1726878220637; Fri, 20 Sep 2024
 17:23:40 -0700 (PDT)
Date: Fri, 20 Sep 2024 17:23:40 -0700
In-Reply-To: <66edaa30.050a0220.25340c.0006.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ee120c.050a0220.3195df.001f.GAE@google.com>
Subject: Re: [syzbot] [PATCH] netfs: Fix a KMSAN uninit-value error in netfs_clear_buffer
From: syzbot <syzbot+921873345a95f4dae7e9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] netfs: Fix a KMSAN uninit-value error in netfs_clear_buffer
Author: marcus.yu.56@gmail.com

#syz test

Use kzalloc instead of kmalloc in netfs_buffer_append_folio to fix a KMSAN uninit-value error in netfs_clear_buffer

Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
---
 fs/netfs/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 0ad0982ce0e2..6f967b6d30b6 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -22,7 +22,7 @@ int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct folio *folio
 		return -EIO;
 
 	if (!tail || folioq_full(tail)) {
-		tail = kmalloc(sizeof(*tail), GFP_NOFS);
+		tail = kzalloc(sizeof(*tail), GFP_NOFS);
 		if (!tail)
 			return -ENOMEM;
 		netfs_stat(&netfs_n_folioq);
-- 
2.46.0


