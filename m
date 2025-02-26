Return-Path: <linux-kernel+bounces-533788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B40A45E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D09E19C2578
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041D62356B5;
	Wed, 26 Feb 2025 12:08:30 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BC5228C9E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571709; cv=none; b=ryWwi1KXso6NdgpqbZ2JI0PmnU5aEDZy3ll2UUjRsfKweCPXlB3f5clLbtKm3WrE/S7qVG79QkLMUtcRqRO3lXGQHCnZu+Syw0RXMcU6alwAH1ztfJsNoSj6TwFY4XfWtduSF5HOTQHAnRRv2Q9wBn8P57VmnKk+Ft7IWc43x1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571709; c=relaxed/simple;
	bh=BfWDkOXIVi+phnC5usme1ejCUSGSAk+7jajQgA99Mpc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cyjaA9DLNK0n24HZjnDgJE0GlU8UqvfSkRrHClOQJ4O1nq6ai+o0dt9EkByziw0rUJZ905jq3R33hAhGmBSpoG9VCq7qq9yA8sYvJFyMGHCMJAakBB47gOBY6VfH6nibBBzv72TcaF6MTgTy1YXAUA7Ou1eAgCM2yhnoDwtTARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d2b6d933baso142901875ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740571707; x=1741176507;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AcUYnbqSgo+CcVUyhkeERgrvliM1pLqawbgYN6ofh6o=;
        b=J6LfjKT9wRaMUbHl2U+Yi0hzxRkHjpmQa+yb66gCvozW9nMwOj53SvMDOKA/tXlA+i
         GeG+UUFHUNqV3ooovwqEDhjjDvGbPYADzluWUNU51yUzExjD5HtPOnaoMSY5vuMUIew/
         MOcIxKZDRK4Aa+KgYEXs/ESfDToVXbSEGRdJfuTMKTI5S0wt96hdWKpdRguHAQBFvRcN
         bYdwVWkeWhEi2owfsgfHPPkkBxyrwj6DOj5W9D3Z7nJREmJUyynSO5hFi1pueClqSF7O
         2wIlpiuvyT7y8JdYSN0XdW73Y2Vcl2hbSYtFDq42wYzecZ34QTGhfakTvNmyfygiVh8/
         yEAg==
X-Forwarded-Encrypted: i=1; AJvYcCXLTpBkUDgetQBtSqWMMoOVkKGIL+cF0T51WHptYE1gs9xUjVIYtOyRt3SZMHgAd1uKZoesqYOOD8ZXQXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz39SBUZ0vmVPNPUPgIZMFs7OAYc8v5C06OlEOt9y9xO2LYqpzh
	BCXDbIb0kQiPIYe1G5CWHTk2e1VoZcK7roUggmTID4QiDBFSu1xHRHxr3hK9BptvocXyOU2IWWC
	LFigOJTwmQ9siAJ70KJxh0Oh4JLDttkZvtZVsn1qYV3v8JpFthfQDypw=
X-Google-Smtp-Source: AGHT+IF6mdZ701nOiNAl8RxdOOSTjQsu8YRQ0S+3sDbzfX8SF2PQDNX7VTMhgiAWIFnZd0ct5bmnznMC2/tBM3Rj2oozHtgakMzE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4602:b0:3d3:ce1b:5e84 with SMTP id
 e9e14a558f8ab-3d3ce1b6053mr42976725ab.22.1740571707224; Wed, 26 Feb 2025
 04:08:27 -0800 (PST)
Date: Wed, 26 Feb 2025 04:08:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bf043b.050a0220.38b081.0131.GAE@google.com>
Subject: [syzbot] Monthly ocfs2 report (Feb 2025)
From: syzbot <syzbot+list1987609f74d4a4c47bb7@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ocfs2 maintainers/developers,

This is a 31-day syzbot report for the ocfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ocfs2

During the period, 8 new issues were detected and 0 were fixed.
In total, 79 issues are still open and 15 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  122045  Yes   possible deadlock in ocfs2_try_remove_refcount_tree
                   https://syzkaller.appspot.com/bug?extid=1fed2de07d8e11a3ec1b
<2>  34468   Yes   possible deadlock in dqget
                   https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
<3>  26481   Yes   possible deadlock in ocfs2_acquire_dquot
                   https://syzkaller.appspot.com/bug?extid=51244a05705883616c95
<4>  12874   Yes   possible deadlock in ocfs2_reserve_suballoc_bits
                   https://syzkaller.appspot.com/bug?extid=5d516fba7bc3c966c9a9
<5>  9837    Yes   possible deadlock in ocfs2_init_acl
                   https://syzkaller.appspot.com/bug?extid=4007ab5229e732466d9f
<6>  9270    Yes   possible deadlock in ocfs2_reserve_local_alloc_bits
                   https://syzkaller.appspot.com/bug?extid=843fa26882088a9ee7e3
<7>  4178    Yes   possible deadlock in ocfs2_setattr
                   https://syzkaller.appspot.com/bug?extid=d78497256d53041ee229
<8>  2878    Yes   possible deadlock in deactivate_super (2)
                   https://syzkaller.appspot.com/bug?extid=180dd013ba371eabc162
<9>  1874    No    possible deadlock in ocfs2_xattr_set
                   https://syzkaller.appspot.com/bug?extid=ba9a789bd1f4d21fcefe
<10> 1656    No    possible deadlock in ocfs2_lock_global_qf
                   https://syzkaller.appspot.com/bug?extid=b53d753ae8fb473e2397

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

