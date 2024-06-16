Return-Path: <linux-kernel+bounces-216323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BB9909DE4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 16:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6606B1F218A5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 14:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E78101DB;
	Sun, 16 Jun 2024 14:05:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965BBDDA6
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718546705; cv=none; b=EkjjNJLh1FNyJNm4F/mkIeF0rGOPQNPu3T5RpT30/fhgayniqLAtw5IpmqIOQ4Y8Ce2Lic7VSQxdrwTY0pG1kYwI2WI0yAnEtpZpa5208REQbWPlnz2ZzHHxHZ9quHx5tYIRDViO8EME6V/0tP+DmxSc5ikEtHp6JZzjgj9fxgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718546705; c=relaxed/simple;
	bh=6io00tG+BXXD/bjavj6Wc0ZSI2uXwoyQQXTJiFre6ec=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DEVFvP7uDwfR0Y1ML2Hz0O2ekDTwgByCpm1CkEQWKarhvzThonifsSLvW0fz+7iimSvMhBvWaGqV7oaEZIzGLQhjgmS6p5dQjmsQDDDiIx/idwnIPsNvrsQCR6HdnA/xz2dXVg1h0jevNjv+BLWf69L5lrzSaXhstS0tl7j6dCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7ebcbef22c8so443706739f.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 07:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718546704; x=1719151504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLcaaWng2TQ/H+FaOLphi+VM/bKUwUbvtr6FoaGnNrI=;
        b=W6hgI3rvxQx1nuGAhkISaiS62x5p7/vdNRrdOnutoAfQ+gWK9YP+a0ptifN93yyR8N
         7RC7X6r5kByqT3/8uqkg6be4B7RrwUTez3ESSjvqNeWwq7DqIFBmsCnvHsTZ3NpxTnCo
         lNKwqzXe7B1YAv8Dn2iDRbN5ptdt1yxwSUc+XUImu2Lj28DWhsM+hS14e7UCAPabilzU
         EzH7VYN6yhk7JjR23R5zf38NvUDdya+pFhFbGhkmhGCLjm1etxSLcmE4AIMRGE/Pz4pI
         ywdfQalDy4q+Dv1MaKBptkiiNaHtdAe5vz5svYi88vb4T7R1vGr6P04vlYChxfikR2Qp
         zlcw==
X-Forwarded-Encrypted: i=1; AJvYcCVupBwE+/k13IOulttJSmeK2a1EU6cJkV0tAAkCDUCigAlhPNcNmlhyWDLO4T/mTCC7f8pyovEQ0nDYMxzSbkca3x9PYYQm+tVwu4fA
X-Gm-Message-State: AOJu0YycSeYKj9NatX5tS8mIZAJm9XJbgriZ+RRTp8z5i5eZhpJCQUGJ
	FPQ/fLrEBmkYy+zl+KKKxKN0lDt4PscrdzjiW7gw2W94DK/guzkcraQAwebg2g31XPSJdB9YuOw
	dUGwXia+bwDfBAxIw/EZfbVGEfoDK5h2yDhAZBSaa2CXK8yT/K4Xciko=
X-Google-Smtp-Source: AGHT+IGHyeFtvlt+ImnEUgnwm5dEInqksvU32QABvMV0/yconOjWp25/ZCqoFaDWtWWVmgcbKMIB0yhITZPgs6UzpCsDR8a/2Hhl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:150f:b0:7eb:78b4:faff with SMTP id
 ca18e2360f4ac-7ebeb62c796mr20918739f.3.1718546703860; Sun, 16 Jun 2024
 07:05:03 -0700 (PDT)
Date: Sun, 16 Jun 2024 07:05:03 -0700
In-Reply-To: <00000000000041df050616f6ba4e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d05580061b025528@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in __mmap_lock_do_trace_start_locking
From: syzbot <syzbot+6ff90931779bcdfc840c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	hawk@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, lizefan.x@bytedance.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, netdev@vger.kernel.org, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 21c38a3bd4ee3fb7337d013a638302fb5e5f9dc2
Author: Jesper Dangaard Brouer <hawk@kernel.org>
Date:   Wed May 1 14:04:11 2024 +0000

    cgroup/rstat: add cgroup_rstat_cpu_lock helpers and tracepoints

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16695261980000
start commit:   36534d3c5453 tcp: use signed arithmetic in tcp_rtx_probe0_..
git tree:       bpf
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15695261980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11695261980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
dashboard link: https://syzkaller.appspot.com/bug?extid=6ff90931779bcdfc840c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1585acfa980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bdb7ee980000

Reported-by: syzbot+6ff90931779bcdfc840c@syzkaller.appspotmail.com
Fixes: 21c38a3bd4ee ("cgroup/rstat: add cgroup_rstat_cpu_lock helpers and tracepoints")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

