Return-Path: <linux-kernel+bounces-368333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC59B9A0E69
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773DC282448
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AF620E03F;
	Wed, 16 Oct 2024 15:35:40 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BAF20E010
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092940; cv=none; b=FULBsKM0PAuqdJTr6X7rr6HDywhz3S91aWCSCP7T+LBIcOLEMYNqIBp8TrIXnUvowX5dTY7vJe9XXoDZ7ACfTV8Z6iO11IEU6/4LMGJ0ZqvPGlj8OZ9UqD22m2xpzY6ZsWqaM2hZBHmnf1smY/FZIw4GWGJNnXCYjG/msm/oDUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092940; c=relaxed/simple;
	bh=GHjwlwxveIPYDnG8AMYjvLxv+SlAx7mv+T7WRWCO6lc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QV23agKV/sKjsb468b2GvYrDoiP6HzEk5PfMx37oy028XgnBgXOrOgWewVA58M+1t6XIkJ3JpBrZFAdqA7yVzJsRy4tvnTYXJ37LM9V1eorpV90f7M5cOmUeb4uV/yAz4hpsexpCgAPDTheutOyajpAVSalpDdRBb4Abj1iQWa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3b7129255so73679595ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:35:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729092938; x=1729697738;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JqhR4ZtEuyLzM/TTx/0hTwfmqZsDh9mfAHJ0ABaYb8=;
        b=sMzoCve+oRPrZ4lOwPMn/jFEMjWxWGBXUIw0va435vYi5USA42xXrLCsVG3QBMuX1I
         ucMRQEApGKKCvoTrpagc/ZGXoG5ehwW6HEhJjL/VKZ0ITyhTGslFDKW2Obg7A0nUp4JP
         IUDkLf27OYWLgA+h7r2g/hHEOyYpmUmtbzCPbjE35JuzbS28ZvdrHv0JbCuxWe2UMSea
         PK9c7Gym5c7bzXy9HyS14GI4p27Lu2yVaeTftgW3iaHERzvP0Zf/3zyRS0UfeVIREfol
         tMcDgNbCOxS3uRR1w9OppYINpSouojg46adc5pp3vCR6Wt5bdjyqn7nmatjjzj5pb030
         Sh2A==
X-Forwarded-Encrypted: i=1; AJvYcCXGaQcXx/Pb5wpZEO8HPNQ72c84gnSg7Ah8eefkgN6H/7Tg6AeD1l+6wGKrBxduoBO1GFtlRFJ3ryJATGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxaPupPtiEKP1COce1A1AyOgkm9i5/G7FjDGXrWbf30wgeD7BS
	nstS/FluqGx2/h+Sr3c6xTu56MvZRjDQtPOg3qT3TmwS/1tMW/mIy1lhb6wjPeniqI8EKcFeLEE
	wFHmqvKowZEPXJbRkXAm9WAelNirIU98b/gYyXGVR/FOUiQ33fJbFYI0=
X-Google-Smtp-Source: AGHT+IFVURw2c73YcMmgIkcpLXz8fFY44ICkuTuu+hnvO4F0VDcH5uubNGoWH8SBWce8uUkxlD+AGWtvyTiTAg9b3tVI8Ev0MHuu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0c:b0:3a1:a26e:81a with SMTP id
 e9e14a558f8ab-3a3dc4a7b7fmr44327775ab.7.1729092938153; Wed, 16 Oct 2024
 08:35:38 -0700 (PDT)
Date: Wed, 16 Oct 2024 08:35:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670fdd4a.050a0220.d9b66.016e.GAE@google.com>
Subject: [syzbot] Monthly block report (Oct 2024)
From: syzbot <syzbot+list57f9fb326ad19207a6f6@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 1 new issues were detected and 0 were fixed.
In total, 23 issues are still open and 94 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4260    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<2>  2332    Yes   INFO: task hung in bdev_release
                   https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<3>  1566    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<4>  584     No    INFO: task hung in bdev_open
                   https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
<5>  89      No    INFO: task hung in read_part_sector (2)
                   https://syzkaller.appspot.com/bug?extid=82de77d3f217960f087d
<6>  44      Yes   INFO: rcu detected stall in schedule (7)
                   https://syzkaller.appspot.com/bug?extid=005409b89b9a9675cb2a
<7>  37      Yes   INFO: task hung in nbd_add_socket (2)
                   https://syzkaller.appspot.com/bug?extid=cbb4b1ebc70d0c5a8c29
<8>  30      No    KCSAN: data-race in block_uevent / inc_diskseq (2)
                   https://syzkaller.appspot.com/bug?extid=c147f9175ec6cc7bd73b
<9>  16      Yes   INFO: task hung in truncate_inode_pages
                   https://syzkaller.appspot.com/bug?extid=bae3c73c7bf2fe3a740b
<10> 11      Yes   KASAN: slab-use-after-free Read in percpu_ref_put (2)
                   https://syzkaller.appspot.com/bug?extid=905d719acdbd213bf67e

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

