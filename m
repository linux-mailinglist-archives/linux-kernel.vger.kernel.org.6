Return-Path: <linux-kernel+bounces-250123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F3592F47A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 05:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3AF1F2423D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 03:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63EE171CD;
	Fri, 12 Jul 2024 03:49:15 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC62A101C5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 03:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720756155; cv=none; b=H7IGhx3DSC3z4CbeHZmb+PsuRyDU2rceUDSfHQ6Ljclp8buQ0jVaV5COiT8uJHnLyTLRTnb9QBxgev6iw4EEwBfxRiLbACdnl/m+FbQbpJCjh+pouO6eWTDlo+w6UhCFo4MpBR9ixWfghcwZA/QKfBWgTaQejlcB4c58gCqgj6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720756155; c=relaxed/simple;
	bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Jdq7eKNJP/fg4tDWMusNEulkSrGgX+n6aUQvSSEnGDjYRbFmVFXj9AxUukCAKcZtBQIX8ed3lOP/1YSzDQBV0DYkweMzo6w8f4hphVUB38ed1w0VVH/07vWkfTGAdOWy5lEply28JMrvlGT3SEL2mP0DNwjUJ1ZVrkciBzFjzD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-803aad60527so171872939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720756153; x=1721360953;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
        b=t+s6YICH0yEaJOMCHy32V5XeNs9NHOCe1B4KOiphHpUEVazy7o197gq5mGkmYkH4U9
         rfZb9jOwOQrmasmMmjNhSVrD73BwBJ7SqBr0bOcswOUxpvlD7KLjKyboQvZykY1ZcYo8
         5do3KxxD52N1WLYRhW0yLXNKMBklSfO6aKP2jvHMv1frGUPQm34ZJgD4TA13faQWdXAc
         i62oM+7yZvMKK95phIsK8uKxElHMBrf+B6KY20/b8s4LsfqVZhYG1i1fgG/g7NNThpPf
         ox8l6ds+I0h5bguA5WpSjDOmP+6lc8USmGtx96XTtDrWCfrTt7xcRv6isG2OeuCg28HG
         xcnA==
X-Forwarded-Encrypted: i=1; AJvYcCUw3qH5ZSLROfqoE+PwuBP6jJYWvNryW/PPgIXyjlPmTpfGTxecH6LNTimVHu1XKhWqGrxSOSCtovkAZIQqs89+qfy/jN4D5W53xt+v
X-Gm-Message-State: AOJu0YxwSooXHvpxP0zZJUuA2IHHZq4cQJzKjNNCUgZ6f+wAkijJ7gFj
	9SpBnFVoSgfKFhz8VE8ybfaKa8BymeyScuswQFifqIoVxvdrIJQP5EOxv6la5wUaLLuNCyYPo3W
	LIXwL/C+28gktGbq1Y/OtYtYzVv2pMgpQp3EaIARqs3WyHNxkbTgpJWw=
X-Google-Smtp-Source: AGHT+IGO1C3eimY+4kIjVYqb90gWSiSxmLVY7QCe5wkotAoBk1JzawhvczBY+BJ5rlCzBB8bpnwnqt4PrdEYmYSUKM6HECZBL4ud
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d581:0:b0:376:44f6:a998 with SMTP id
 e9e14a558f8ab-38a5b9aec76mr2280375ab.5.1720756153127; Thu, 11 Jul 2024
 20:49:13 -0700 (PDT)
Date: Thu, 11 Jul 2024 20:49:13 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040a981061d04c3bb@google.com>
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

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos

