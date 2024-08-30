Return-Path: <linux-kernel+bounces-308409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206E0965C93
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DD62B24521
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C42170826;
	Fri, 30 Aug 2024 09:22:11 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7AB16F909
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009730; cv=none; b=SeCzCWiIvJCg92j0f/bK7BID9NKtXQiLFixuEAllZO/Sk5mDrJxThd1lyp5gzgBP7LpCiU1MRhgxhvNqdGaKqoCFX5KKomubIfJN6MZN/uAJ8BMY23xSTSJxESedfMe+P0YUyFfJ+Q5UL6m9BRyek4vC05H+maMWJSGMHa79NKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009730; c=relaxed/simple;
	bh=1HOpoxBA+uaZiDmwoZLiWA0rTOMUQoek2BkUnKTBKe8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=euwB8ra8N1cThO0E519t4dz0IUP+nLFLJJlJLdeT07yL9yMvBl5ak3lStuBRyKhtzbLUfPr/IEv6kZbTUn0IisFnv8Tzj8rY28qeagB1GRtr9fNj/RPTHauwCcfv+3o/hWCb+0Dxld7aT303vL1u+07IBdqK4B5gJPSvYFaPmiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a1c57f4a1so168494739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725009728; x=1725614528;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzI6woW6FUbrqeE58HOUd30TAk1QC3w7jfY1MYw6jYc=;
        b=aLyueqXGBYX2IlaIHpqQj0UbviincmpDyG3wJ2hHuJYkvI3aMv8tF4RjbYHGMcV+M3
         lISnqcZ/l2GuVQl/A8a0Us9S10tlalqxufS1Deuw2IsQOEig3fO22NeonmwwiTSnKXmC
         jFAgfh/afaaIyfWdLcMero7FCMI7XFDzXiUuL9Mg0B3f9qyt38sRuU2zyA0c4g3bCAQt
         PxgVrk1cdeWGef8SxfB8T8yH865ta8QFVzl4Gu0Datjx+SFKKD65uMwdvMqToeKwZm39
         aoElNhddUIlVbbvLcdmXr6VNV5I5clg76fOL/AZXXeUjUJ9acXCgNgkT4bJR+XBMnU32
         MByA==
X-Gm-Message-State: AOJu0YyplQhv8vkxdgqN2/wjOepjqa9tLVy9A1YmM+6o3GNLEGlJQaMM
	Wvg8nFYxJKaHTdRmb7FxZK2tlgfUjD0aljXJWxY+Ce2wl9FVOcNmYcrVNkYeLmUGP2jU6ZbnNEx
	3+rvVcooGJOcaw0rtfaQMb6T8XBdClNhiFe56D3Ot2Wz9hFz1DNl6rYk=
X-Google-Smtp-Source: AGHT+IGYxpH1JuBtyCnvz15EjdGBjTDpJ0NzJQZbt50khiggUTgcz8sr0kggssuPnfroBr9Mh+qQDAu36hDvoW1DjN2qYT6zepuo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:210a:b0:4ce:8f9d:2d67 with SMTP id
 8926c6da1cb9f-4d017ee6c32mr86714173.5.1725009728368; Fri, 30 Aug 2024
 02:22:08 -0700 (PDT)
Date: Fri, 30 Aug 2024 02:22:08 -0700
In-Reply-To: <00000000000044ff540620d7dee2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001806c20620e3205f@google.com>
Subject: Re: [syzbot] Re: [btrfs?] kernel BUG in btrfs_get_ordered_extents_for_logging
From: syzbot <syzbot+4704b3cc972bd76024f1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [btrfs?] kernel BUG in btrfs_get_ordered_extents_for_logging
Author: lizhi.xu@windriver.com

or i_mmap_lock ?

#syz test

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 82a68394a89c..d0187e1fb941 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -1015,7 +1015,8 @@ void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
 {
 	struct rb_node *n;
 
-	ASSERT(inode_is_locked(&inode->vfs_inode));
+	ASSERT(inode_is_locked(&inode->vfs_inode) ||
+	       rwsem_is_locked(&inode->i_mmap_lock));
 
 	spin_lock_irq(&inode->ordered_tree_lock);
 	for (n = rb_first(&inode->ordered_tree); n; n = rb_next(n)) {

