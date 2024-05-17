Return-Path: <linux-kernel+bounces-181722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADB38C8040
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 05:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1481F2249D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 03:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F402C133;
	Fri, 17 May 2024 03:45:22 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDF6B647
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 03:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715917521; cv=none; b=CGue8LxnwP3399EkVkPiGVltqI/auo3Zw76nubig3uz8Qi73/k7UtmaVNHDBmd3BWI7EBqjv/RmMI31d+knjbUgDUxuEg1pxJpe6PuMDNS8R//oXFzojOgDYlheKlznMSfFMJBVnv5bjveN2A1uTgC8LUs9kgqmqVUnhkp0RT4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715917521; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E/u9NTOfZyUbhdhW///g3ZY3AnCCi5saohusF/Wnhbxm5/u1wmgDrW56GZSlnrlKq77ekVmzTRG5h73MsuRFwkNGL/Zy2M0WcQagmRnHPfOezQVOPGCMgVwvJl+V0HA/TsSvpcP0jIvo+3Q41EjcYoPeJ/7ZhouvBHp09jGh4YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7ddf0219685so1055659239f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 20:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715917519; x=1716522319;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=LMMO7nkcDUq4yh6AtCOSmXXFkAB+Zj2Q5OxECVEhajK9+qI0C4Gz7yVQq13qUnvqbC
         BcfhiQDGBQzdasFyuluYN8KBDvkALUpacmS05zegl5VT/8rlKak3i4ThPku1gRZqzQir
         UiGumMiK5pITkTkJvEIPJ741s5a2G8VGcpEj1/J3Qie6/4+7MQrwSGYxRydIs2NV64/w
         7viR6S55/Tgzlyo+d28s86XoT2iFs524q9oc3XxEXgnqDPF4U+5OFmT/ZaA03T6YG89K
         KyjcbKuw3LjSnHW75zUP1Abc2ChAzy2QbdQkTx4bltSw9I/E37vnDOgkictEom1ef3QJ
         5b8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1GfBGMYaJLkgIVB8yeHXZKqr3gNKA3MUCOtkFzhkXReek+GFNZG43gCCEmHEMp0W1FyTVipit/aqByDlWYnEMZFU7X7ER8epLZzp8
X-Gm-Message-State: AOJu0YyRBeUpwZ9wvDxe1nqZOg7dywKwGoi+1o6Ol1D7hBmZLdOACKej
	vxFFO+3E9MAQ6zoxfhuDLwL5EefQSQntwdpYRSdNz9roYv+IoSy/X0hfC7dDDEflaKnurn8f8Dx
	2UnXtVdv9GI30/Jzk1Oy4doWJENRnzAfhT8tY2LH2n4kuGQjpC5//tNI=
X-Google-Smtp-Source: AGHT+IHeRF5znd2RauvqwoQWzfQBK+/EpMeBkZLGuJ5vLdevUzahzVwExTNmN2kCcFtSeiUfNNLxE7EvP+y7R4QwsCuNtP2hxld8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2727:b0:488:b7c1:401b with SMTP id
 8926c6da1cb9f-48958e0d1e0mr1629654173.4.1715917519347; Thu, 16 May 2024
 20:45:19 -0700 (PDT)
Date: Thu, 16 May 2024 20:45:19 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000346e8f06189e2e1e@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

