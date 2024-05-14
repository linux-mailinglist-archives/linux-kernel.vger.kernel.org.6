Return-Path: <linux-kernel+bounces-179005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9608C5A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607901C218FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A3A180A61;
	Tue, 14 May 2024 17:24:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4948F17F39E
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715707445; cv=none; b=hNPnMYRlglRhwXSQTDiLXAzZffEUFfH5NkujLMUc2rqmeTkmLQS7EKVKtYOWIMwd/Sr1worWXaCxheSWCldKxlOtO0TU16vqjLXu+Ajc2hyzWBprWM3nUR3oDaab/n6qmcQZAlf91QQFyCFWwZeyMHzRAIe4t6+DGdm/PEtO3Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715707445; c=relaxed/simple;
	bh=Nt7kzmwYkg3z/+qBGi8DCs/A+qqr7TXzumkpN8K82Og=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SP5+BcVzg+IesBxsNao5WjjM4Fk5iEqBfbqnynoH49pJjhl5/o6/4g6IGGQD/9WuLpWrbF7T5vM2etLtDmzxhkXLoaJfP3Smq7KzJCwkCO3mvbUvZP79p/R/qhWH0vXneZIKEF5AOeSbV0itOhg7nf7B0BuwHlpKWLNXj2pS7T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da4360bbacso722587239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715707443; x=1716312243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpglLF3GjUgpNPy5ZOgoKguxNCERy2murGYTeXb8VZM=;
        b=EzEGTdLUVZpdSDTwhJvAWyr3JgPKWG7WqvKDgt1JB7iMnRabct+XjPPlY1aMMANmGc
         CKitsWQXrNnfaQbF2i9tQ3H9etB9/dhqIe0tFmc54kE6YkUXc7Hqs06V8Nwl6WKvom2n
         TNOBTZphaDF4wvuhNIOCsNIHbUO2EjYuaMSu6mD6WOhXEUuEIo9pTtgfyiCSYs731mZn
         1zAmHcMmlf0uckDpgAwb4SOG4yxmOyJ0Gr6Bv8Kp4A4DIqnrWIJ3aNVrpKflt2Wcho6H
         Hw2j/0J0hfF33RFWarXp2tmvSe/NChyfwLxcmeFAHjuSe2DU9PryNagwvUis+xDfGlDk
         2l4g==
X-Forwarded-Encrypted: i=1; AJvYcCU8hn2+oRSh7fclkr9gQqHi/QTgzf4gKV4GShxz8t1lYSaXVsjB+f4vaXGpnPRz9/8K8GjtEwV4nmDk6zAug8LBfmJ2TIxbQxnfvsOS
X-Gm-Message-State: AOJu0YyIusk4Bwzup+/gWYkV8q4Bz4cTHvldwXJhtq1AS2KVbCHNYCOy
	JcngbQVfUji64uPmj/8ER3pjjuFm2q8Qf9CVH2anCi7CcfZ8lUQK7KRWntPUa8QfHJY+S8f2spE
	Ouynb2LX0QQxdApEuVY2QAXveV0JDFPi4agImSzOiwRcCAXfwZO3LMjE=
X-Google-Smtp-Source: AGHT+IF7QyGQ0xCvHt8AkBxfvj8CQW8ltH8uSHctPuqZV3eCEXXtjchifDfUzLV819WqaFCCzSoRSIVR71AXYzbJTHGO0yUWEznq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c11:b0:7de:e1c6:c72b with SMTP id
 ca18e2360f4ac-7e1b51991admr45652839f.1.1715707443527; Tue, 14 May 2024
 10:24:03 -0700 (PDT)
Date: Tue, 14 May 2024 10:24:03 -0700
In-Reply-To: <00000000000091ad3106157b63e6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b5cd8f06186d446a@google.com>
Subject: Re: [syzbot] [bpf?] BUG: unable to handle kernel paging request in jhash
From: syzbot <syzbot+6592955f6080eeb2160f@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	joannekoong@fb.com, john.fastabend@gmail.com, jolsa@kernel.org, kafai@fb.com, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@google.com, song@kernel.org, 
	songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 9330986c03006ab1d33d243b7cfe598a7a3c1baa
Author: Joanne Koong <joannekoong@fb.com>
Date:   Wed Oct 27 23:45:00 2021 +0000

    bpf: Add bloom filter map implementation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13412248980000
start commit:   f99c5f563c17 Merge tag 'nf-24-03-21' of git://git.kernel.o..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10c12248980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17412248980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=6592955f6080eeb2160f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134c0cad180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11faf09d180000

Reported-by: syzbot+6592955f6080eeb2160f@syzkaller.appspotmail.com
Fixes: 9330986c0300 ("bpf: Add bloom filter map implementation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

