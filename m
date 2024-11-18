Return-Path: <linux-kernel+bounces-412767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3289D0EBF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44BF7280F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD40C194C8D;
	Mon, 18 Nov 2024 10:39:29 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3285405FB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926369; cv=none; b=Dq+cRsQ2uspjLj/PI2uI7pOXCgA1mGQiv/AH4RhkY+iL9W9EFsfXGjhgWOMgwKjrWPH4TkzviRV57V2oDkEGP48SeSDYTk8y4TfemPhDfcpQ84YK75BJcchqeGJWSW+nsFb1SKmPUhdxnBUlPRHYJEK2zGWehO/hv2AMSJTJcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926369; c=relaxed/simple;
	bh=8cMHE7/1igewBZghqDxwQ01J1Xow0bKbnf1uog8Z17U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kVq8fdTZPaT30flQd/hrn7BboFjkB6cTX87+JHOTq+bwFepSHkmMNc6Ot0uz4r/gIYmLWfHIK40vFT4Nkz8Hg8Ck93z5qHm4awp4rkkSYAHlPu0sKAAKziSKGT9mK2nfwrXMZLrA3eQYiT5yV0c0LTz/okRurO472Wa5Y9j6jts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6b9f3239dso18642215ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731926366; x=1732531166;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zz0dExI+86k71TVQecrMYRF7YIQdaQH8XNcjQimG3ic=;
        b=u/At8/iodVY3CtnG9lTy1UeSfXRkhgKWQbPcwQvzc+4CQ5TumQZz+3ofKkWk2ujRtB
         yIepkrMj3hjnMblIbjUpEOWTxMvH/faFRktmGCGY/r18edHNEk6Kj/4m++ynSmHVXbr3
         dSVYOj5imQcVIfQUov4yQaPeKsYZ3AkxmZukfO0WNGNL10Dgtadgghg/+6DrFnublihK
         PfG0agzgixDne6Phi58TYaUlPgZbrbTIsskKwB4K/94xuVMZaPlH60/5xg+GBnfSQM9X
         YxLsCvGM399ecj7A8Cviuto0lkKQPelyAZr+lVZCLQkmHLzHDvvLlfUthKW8RezM6OnC
         8yEg==
X-Forwarded-Encrypted: i=1; AJvYcCU+Hadu3TZJnEpQ/6EWIRKJ52nasf82uAh812v76kc1Ug4vfjwVMBdwEbCzhov4LQLmQRjXYHa/GdfqgAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXssSiPOHqGSxnzOQY+bdilt2IZdmkAMilA3pwwh650k8tgzrO
	Gk+8igUzwsHSrEY/ooTOonZ0IaUhVn6rlCzHUG4lNqSuUiZXmtrK1mHiPid+kOd/hK83Vc8mtC4
	JtfVXOkD+1wjtDadZ1qBWXu9sf0RgGwfdpUnl+qZWYOfCi9ZO3alqIEs=
X-Google-Smtp-Source: AGHT+IHvazNoiLGiKhZl60TcHrnStLVFbWVn+JHz6a7P1bf7lHGan6O1gpSewzj9QKvdSeOCNbjEB9Fl4x/q9sGnMroRMVpmy/MU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3c08:b0:3a0:a71b:75e5 with SMTP id
 e9e14a558f8ab-3a748027c23mr104739245ab.7.1731926366093; Mon, 18 Nov 2024
 02:39:26 -0800 (PST)
Date: Mon, 18 Nov 2024 02:39:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b195e.050a0220.87769.002e.GAE@google.com>
Subject: [syzbot] Monthly btrfs report (Nov 2024)
From: syzbot <syzbot+list69ba8ebe12d504efee8b@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello btrfs maintainers/developers,

This is a 31-day syzbot report for the btrfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/btrfs

During the period, 10 new issues were detected and 0 were fixed.
In total, 43 issues are still open and 90 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6387    Yes   kernel BUG in close_ctree
                   https://syzkaller.appspot.com/bug?extid=2665d678fffcc4608e18
<2>  3458    Yes   WARNING in btrfs_space_info_update_bytes_may_use
                   https://syzkaller.appspot.com/bug?extid=8edfa01e46fd9fe3fbfb
<3>  362     Yes   BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (7)
                   https://syzkaller.appspot.com/bug?extid=74f79df25c37437e4d5a
<4>  319     Yes   WARNING in btrfs_commit_transaction (2)
                   https://syzkaller.appspot.com/bug?extid=dafbca0e20fbc5946925
<5>  303     Yes   WARNING in lookup_inline_extent_backref
                   https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
<6>  291     Yes   WARNING in btrfs_chunk_alloc
                   https://syzkaller.appspot.com/bug?extid=e8e56d5d31d38b5b47e7
<7>  245     Yes   WARNING in btrfs_remove_chunk
                   https://syzkaller.appspot.com/bug?extid=e8582cc16881ec70a430
<8>  141     Yes   WARNING in cleanup_transaction
                   https://syzkaller.appspot.com/bug?extid=021d10c4d4edc87daa03
<9>  90      Yes   WARNING in btrfs_put_block_group
                   https://syzkaller.appspot.com/bug?extid=e38c6fff39c0d7d6f121
<10> 72      Yes   kernel BUG in clear_state_bit
                   https://syzkaller.appspot.com/bug?extid=78dbea1c214b5413bdd3

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

