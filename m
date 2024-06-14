Return-Path: <linux-kernel+bounces-214520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D579085E8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E8A0B25C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2B81836FB;
	Fri, 14 Jun 2024 08:14:22 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47AB1487E7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352862; cv=none; b=nSgnBD68XhIwf09tMQczXyMa7y5UzHyRLWTL0iGfzAE3COO6+QObUuB6Z7UHr3adaQLdMWf27B00cR/FdJD2svEdlKlIPma4C30r6X6sZIk2e4wfcExI+CsOSDFylXOi9CdEYghHDK5jylsUP57HRUjCvKkxK6OwcxrLFJD3cHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352862; c=relaxed/simple;
	bh=jhpWYrJNConC9KnrC72RhUqyqYd+IViilg+I2fFGSS8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kDkr6HgTwbnN0ZKIRPpjoVV378AY1RbnlK5Z6bKrlkdEmGSOoZa8aTW+Es+070bf4w41cKOzkUjvjnTWWldUNvMpPGWisfrrcjCZdM4ohn/Jk5W5fRDDqlFqnJ5C733xJgQsuLUYTf02bJd8ipxnn5Z3LXvzKg+yM9eNCsQmOhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3737b3ae019so18442525ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718352860; x=1718957660;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dl5c4gLKxIfqfWO11ZrXKYy6JlfOap8HlXYhdcou/Mw=;
        b=TQ3WlfYllgVN+nkPCF8vvrn92M69GmWWGfp6nkj8/ab4magrG7WEzLyma/TYZu7Ewt
         Z1L5uk59iyyh1/Irmzg0CcNx13UicF4t/wiM/aHllUywzfoOx8oEBwT+6n+6wW94yjQm
         NAfgk+XSFH3OtI1UmbgkmOpZ9ti4s5HjyIv9RQDIhzJNK3EvLFfmUmkyOnVdIw8nI76r
         SN2YMN9Gh1F1bD5g7tU6ZWxeuV9yspaw7yfsjePYiOlpMkAIR1wykjzZykS6PC3vPnrT
         LwiMdlqI77IRy0FFZvrFSkXSjCuw9SVEOst1l9VJbnBwOAlhyUh10fQlvjYLOuMxt+2T
         SKQw==
X-Forwarded-Encrypted: i=1; AJvYcCXHI0F/wSJS0yC0e8mBoY0S9bALWl57n9dhuW+kT5nte0v+WsDB9GwxPCHYtSIp03DlcyasoSy5TmkoSn7QuQ9Ljr7P0D33GbfLDRXm
X-Gm-Message-State: AOJu0YzCiosyN3Nftt8MhgyPPh+wjFisguK0yE2BVTkX58USshKbkd5f
	/yZ3gt/kOFfrS02zGCpJtaiQfC2/vpeagEgxbm0LzZ95hoQHMpOoI4TW80c8TBEF+jiaUlQ26jQ
	mFn58xoMgclUXH5i9QASamXZGRiI9DZJIP1sV6+DEi4OWg+FS9oiEDYc=
X-Google-Smtp-Source: AGHT+IHE9h+cvJMGbDicq40xjzx80lY23g8esKCauhch5MZ+3jumizawZyeADaC4+rjOLbxtKME+ycd6jQQ33BbnPUdmUX71owNF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aab:b0:375:ae47:ba62 with SMTP id
 e9e14a558f8ab-375e0e2db33mr1009415ab.1.1718352859969; Fri, 14 Jun 2024
 01:14:19 -0700 (PDT)
Date: Fri, 14 Jun 2024 01:14:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d15551061ad53378@google.com>
Subject: [syzbot] Monthly btrfs report (Jun 2024)
From: syzbot <syzbot+list6fcd25ac4d21d8f673e0@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 13 new issues were detected and 2 were fixed.
In total, 40 issues are still open and 64 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6014    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  2994    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  526     Yes   KMSAN: uninit-value in __crc32c_le_base (4)
                   https://syzkaller.appspot.com/bug?extid=549710bad9c798e25b15
<4>  301     Yes   WARNING in lookup_inline_extent_backref
                   https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
<5>  252     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<6>  230     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<7>  217     No    general protection fault in btrfs_stop_all_workers (2)
                   https://syzkaller.appspot.com/bug?extid=05fd41caa517e957851d
<8>  211     Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<9>  145     Yes   kernel BUG in insert_state_fast
                   https://syzkaller.appspot.com/bug?extid=9ce4a36127ca92b59677
<10> 114     Yes   kernel BUG in btrfs_free_tree_block
                   https://syzkaller.appspot.com/bug?extid=a306f914b4d01b3958fe

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

