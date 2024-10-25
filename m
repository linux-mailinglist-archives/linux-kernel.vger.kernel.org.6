Return-Path: <linux-kernel+bounces-382139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2D89B09FD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669541C22E64
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C91B1885A0;
	Fri, 25 Oct 2024 16:30:33 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053332AE94
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873832; cv=none; b=lgk5Q+kKAq0eEukzwkvbe04SSMBSK51kAWh0QCNf7AncyrnqnRmhhFu+95p5/s5ppF/Z4UQE9KK73II0H+FTXcv8Y0G558O0SrY6Djdo6Mtkp6ey7SO/7Wpf25lYt3ZVa4gTST+CbTAWYwF/YpAMgJzenyM7PjoBdiM3JqTh9DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873832; c=relaxed/simple;
	bh=v3AmUxSZinie3kY6rCCo2G1fBqaygrpd7NEogDL2DaE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=G2mN2sFhtZkFF7wpyg9NnQCvsZoX23odcmBlXnC/inx4X6IxwmMn1dhwo9gJqTXIVrZLceqGB/KqwzL27ntxVTlLoUBA2LAFCN3VRj20mgRT+c3r3Q9CXi4QcpUAL7sQ7scTGwI654GvPhQYWrLvlJsWV77KS5utcse312+7e7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b7b13910so19578945ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729873830; x=1730478630;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NIW1Xg1eCyy8o9hfXx0wcdeH5tOpw0wvnt4LVfkAy/E=;
        b=TIz/V9gZj8RSwsxsIvBnWxKiEoMjmUzxOzKCJEi/L4jtNvFlXSad1BGDI9PMP55Xe6
         rXthZw/dpIazOMyg0aSxA1EDmtNQFJTGURNq5X0w9RX0Qf56ZoVR6XhFcFeXP/GY93pG
         bt+kydjUV2xFhk3/8bHYnDhNIa2qq54ZiYwyjxTjyrtSvpUtBcZiDLG42pcuBF8pDPvr
         usQoYXSZQgSJSq50K9pLZ++sUnyOn1NAOxTYeD1Zevu7UoUh3crRlfeVC0qwvJgRYg0i
         Lr+P2tmWWIXIsutW4pF1QY3qkAEkZyGlrAbjD73/8p9pxn/tScxpFxYpnB+M81YlywVk
         Pmgw==
X-Gm-Message-State: AOJu0Yxm9AzbgjCf4PQ578L2GsmIv5FOOlE873AG9KF+/Vuk0p5SqV/7
	muo8X7pxhD/pHhnod6t9El7iWU8KkZFH4Wv+NcbS1bSZcstM48xH2sK33Q8l7vuOEq/7ulgGcu1
	PP8SA6wdaPRr+oevS4xnIjaThNGON7G9wSrKHoeecNgM147o+/ctcGS8=
X-Google-Smtp-Source: AGHT+IFapfbHyLbp9os7QdT3HS/4kCR4g22M3JWxpSu+foJLslwmekHcQ5QGe14EGZZ8O0B5OIa1FAvudJqxpMB+jU+pjNF13UOv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a83:b0:3a3:b1c4:8197 with SMTP id
 e9e14a558f8ab-3a4de827cd1mr71689245ab.23.1729873829865; Fri, 25 Oct 2024
 09:30:29 -0700 (PDT)
Date: Fri, 25 Oct 2024 09:30:29 -0700
In-Reply-To: <671b3f75.050a0220.2eb763.00d7.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671bc7a5.050a0220.455e8.0229.GAE@google.com>
Subject: Re: [syzbot] [PATCH v3] jfs: UBSAN: shift-out-of-bounds in dbFindBits
From: syzbot <syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: [PATCH v3] jfs: UBSAN: shift-out-of-bounds in dbFindBits
Author: zoo868e@gmail.com

The starting bit number of free bits should not be >= 32 as it is
0-indexed.Assert that the number of bits is < 32, or if it is 32, the
input word must be 0.

#syz test

Reported-by: syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com
Signed-off-by: Matt Jan <zoo868e@gmail.com>
---
Changes in v3: return the result earlier instead of assert
Changes in v2: Test if the patch resolve the issue through syzbot and
reference the reporter.

 fs/jfs/jfs_dmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 974ecf5e0d95..346f2617b744 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3017,6 +3017,9 @@ static int dbFindBits(u32 word, int l2nb)
 	nb = 1 << l2nb;
 	assert(nb <= DBWORD);
 
+	if (nb == DBWORD)
+		return (!!word) << BUDMIN;
+
 	/* complement the word so we can use a mask (i.e. 0s represent
 	 * free bits) and compute the mask.
 	 */
-- 
2.25.1


