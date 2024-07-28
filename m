Return-Path: <linux-kernel+bounces-264890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 584DC93E9C1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 23:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1364D2816BD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 21:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E4D78C7E;
	Sun, 28 Jul 2024 21:43:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C224477109
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722202984; cv=none; b=dc9fHSM701NH7mk2OXKXVHTF1qODE9tOe4cERlmJUihxqe9KhZGvIZntkHuT1lcdUG7+GegWfvN1aK9v2RNBqIbebHFUJAW3/4F0w5Yj6avN7z5FPbjPEilu06weijN7CrP7lGXxQJzv7CPsoZWbZYugrAwqeaEnZWeiWizEc4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722202984; c=relaxed/simple;
	bh=MYduZ0IdORuSmWQu5YXNctyDIni5ClmQH5IEUUo18/8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HRy/9JL+gdSPst8nngZ1JfP7K5HMXbrHKnpZZc7/PoF9wJNKs7MC8l3Qj/3JFKHGRKQ9bMu405+MEhWUqMCEI/cp5Nqz8Weikf8Sl57ON3yoJCrbKEt8OOzJeV61QE4hTyCBEFryoRBDLPbJQpXtYS7Oy9g3VBynrwpME5bqq0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-806199616d0so454755639f.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 14:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722202982; x=1722807782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgeFmqomSS4eKslD4QaSEsWobihSIfo0Ye5W+dY4btg=;
        b=ncwPbyA4LJ3nATEtu2HQq+0wi1tp5Qcyw4bbDGbNeZXmfuALbeS53l0g/QNpaUcDkb
         8org36FwYuu8Wq4ZUnVlzJtoZy3+07xyJ+GboAAKEgbZU3wNEat6oYgEfKEReiY1Jbdg
         xUnHB2o0yIKx4cffijwbEU2j4z2HeW77Hf1Jk0/7LxmKQ1LtitpQkJiybCVgBrItOhlU
         44ZZKLNegaPbDFYJmT0HJnY6jgQtSqJo16EY3st3cu9nKmfEec6qJ4vjinejNhWIlWm8
         cPOQXa5KuTiEUCAo6wlgDO7Y1SZq9yJOpLOHhTdV7cKaj1ROzMn5seZwrxmyCcOkAX4E
         92bQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3au5ES/N1QXa69nxqz87k+yC4xwHYEHhvHLVGPW/LN1zI3qQIgiW85HiKuAsqm9aOweJ3jGhfd1HO90XQZL9z/hZjCBPgLLx3ee+f
X-Gm-Message-State: AOJu0YyXZ2/BKXHTTzIa0VFuwPRZrGd2GS7zsLxOeh6bNRJfsMnSwD/v
	/CkJolv9+ZqzOg8SoBKinjravn+D02fhWZDdsWksaXtR+uNIGT8OMRbV9f6sa5Iw3jB5NX4Yzqc
	/eBYxqB9fOc5bt0BE72kRDD+HlZLFI5rnXGbGZMfSAtbzNoM8GWejYn0=
X-Google-Smtp-Source: AGHT+IHYOQdWon2gqthL7m7IB3zOfELdp40XTGsJ7KaDanvxoPsy9ppv0v6sUc3XWLnVY4wPky7BNhk6t2qKnjUfIwWajDoVCUO+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d05:b0:80c:826f:ae77 with SMTP id
 ca18e2360f4ac-81f960b9a57mr15715039f.2.1722202981854; Sun, 28 Jul 2024
 14:43:01 -0700 (PDT)
Date: Sun, 28 Jul 2024 14:43:01 -0700
In-Reply-To: <00000000000099a654061e4a0d97@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f70500061e55a074@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_read_inline_dir
From: syzbot <syzbot+ee5f6a9c86b42ed64fec@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, asml.silence@gmail.com, axboe@kernel.dk, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit e5598d6ae62626d261b046a2f19347c38681ff51
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Thu Aug 24 22:53:31 2023 +0000

    io_uring: compact SQ/CQ heads/tails

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=179f26bd980000
start commit:   910bfc26d16d Merge tag 'rust-6.11' of https://github.com/R..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=145f26bd980000
console output: https://syzkaller.appspot.com/x/log.txt?x=105f26bd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b698a1b2fcd7ef5f
dashboard link: https://syzkaller.appspot.com/bug?extid=ee5f6a9c86b42ed64fec
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ddcb03980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11cb739d980000

Reported-by: syzbot+ee5f6a9c86b42ed64fec@syzkaller.appspotmail.com
Fixes: e5598d6ae626 ("io_uring: compact SQ/CQ heads/tails")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

