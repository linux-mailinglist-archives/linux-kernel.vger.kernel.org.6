Return-Path: <linux-kernel+bounces-287409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A58395277B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 03:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48957284ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 01:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3552847C;
	Thu, 15 Aug 2024 01:21:17 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC97164A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723684877; cv=none; b=KSISnhljHiOhDEjuDlCbaBzAZvkOqTHtPTTumQhXpTmIhauRw7RQnvPHwIAkRntT9bJbI0pCyFj4l/g2ztn+F8ehQm7PkRFufX+TjTjQMBczlw8O5PnHN1KN4ePGm45461j507Eo0CJB6ow9nIWhbSqUa6RWREsyXsCqukebv2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723684877; c=relaxed/simple;
	bh=Hb3X4riTxNkNCGjBLuPrCPRcXoa2jIrWSholPAoh3Io=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YtBd2BNGp9oLtih5X9d3sn4wRv8tPpzD0rrQ/cFcMS71zte0VjSK8wUoT/dYaKvmQrKmHq2+WW1B5QxG8OK2eLYVOeaUKY8k8F9hvq9MY3WnqJWvzclll2WW4VW83ASlCUP21NH5QUViH/imMPea3oukiW6/o2+V8YFo0GwRmCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39b3245b20eso3787565ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 18:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723684874; x=1724289674;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hb3X4riTxNkNCGjBLuPrCPRcXoa2jIrWSholPAoh3Io=;
        b=bTKoYRGofn7DBG4n/JGy1h2HDXzcAce5r86IUL2sQ6IgGRaa1Qg/uZDCD0GRTLQKcx
         bHL3c3jgDVsp4ruPUyNOQuCyWYL0HWxCFrDbXifbnPfzQ4eo+p89PGJ0GtcpPc+AMMFu
         GAWpXLejkRzX02Z/F+CT7j/jnbUVb58Rn0R0YoWtOJ6+kTm8FcDbRTY6ogFZTd4zaE3O
         5q+5vPKYHQS3PRfvXvlq2Ejm0LAMRJ6xkqyXg4JFAwIUziZEx3kndoIdi9GfLuCg5v37
         USOQJybJFylNc0OvI37kF3Lu/9yNw0FH74tZ0BfPVCLyqLcqf90FbJ8mrEJOEklJM+dM
         /Nfw==
X-Forwarded-Encrypted: i=1; AJvYcCVrXcxMLcFSjJY9Ccmu3WiLnRLVMTj98K0f1WO/ltMcJDLVVhp2fH1KlI8zJx8t/BHdAmG6GJjgfjhneSSCOuQCyb9AdGHmyyHvD4CA
X-Gm-Message-State: AOJu0YyleTNGfBy/G9K56NiolfjHb3m1KVvARYRqI4Off1MJZl3uAEz2
	/K3ILOfs2lgDqGzx9EjUDpVpxQWqxqoI8keod6YdEfYox92kn9t6FkIRyr5JyfZ+CPJci9pG48N
	ge6l+f89JG246DfNPzb/FmFspc3DzkzeUo4pkBFTfPHQ1p4f40eu4In4=
X-Google-Smtp-Source: AGHT+IE1L+cIMMAFHcc0Wx8kcH60VX5XGrnjTgUDbjMF+9tGU9/HcW1WoLcbwHPNqV8SKgFyweHjql3dcF+ilk3XSi+FpZYWPhcz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2181:b0:39b:c00:85aa with SMTP id
 e9e14a558f8ab-39d1bd3bb90mr881145ab.0.1723684873954; Wed, 14 Aug 2024
 18:21:13 -0700 (PDT)
Date: Wed, 14 Aug 2024 18:21:13 -0700
In-Reply-To: <000000000000ac237d06179e3237@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009df8df061faea836@google.com>
Subject: Re: [syzbot] KASAN: slab-use-after-free Read in htab_map_alloc (2)
From: syzbot <syzbot+061f58eec3bde7ee8ffa@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	houtao@huaweicloud.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
net/sched: unregister lockdep keys in qdisc_create/qdisc_alloc

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=061f58eec3bde7ee8ffa

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

