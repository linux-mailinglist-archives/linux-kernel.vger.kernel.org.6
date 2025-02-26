Return-Path: <linux-kernel+bounces-533788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72089A45EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099953B4AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41CC229B32;
	Wed, 26 Feb 2025 12:08:29 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC78227E83
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571709; cv=none; b=WvFfgspTW9JQJfRfIHGCvsBm9sAGrRt+9QnE956VL+tXp799skL+pKvn27Zm8hNqZQ5tZwtYvjEOAMKi8kwVx/U8/jQWEZlTlBYhQli2OR3QKXKiAmTzFvN2dwNBIGyFiejVlDSjOcjmmrVUl2ukqDy2/y7UfYYoVi22sqlj1M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571709; c=relaxed/simple;
	bh=xupxm3WRPZw4QYViT8wcT9c1RNLyq0mKVxoDQQdltDQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sM0CeooCXCuZCT6gfNEIgIr/E0abJq20G+K2zUMGlowDnqT2irSsV8aUBb5wAOmFn7jmwnC8f3aRCXSvwB15sF06N8+xA9IxkCi8T06XdLo5Bu3tGHeXbd5vRnMqafdZC+bk0UltxZZN0TziheGOEHvLIAb4daqNNE1ji20w8OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8559d67a0daso1322179339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740571707; x=1741176507;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjJ/MEQxUyuHDV16+PJgywoQMc7ZlV9Krg1MunFx0o0=;
        b=A4Je1CtKZSbacz24ofrgs3+F2QoW6EZrgChKz5PDRyN9ER1wROnMcbw4yhDmJfUQeK
         c6EqSD5iJMYfIgVSu5OpKQxftyxh4CQtnO6331qw/SmQJ09jsPAV8WLE/bWsQ9Vvly9q
         hmS/xXnyEf2fb+xrIMkYRP6rEkzLuf2cbZVFditA3P0i4Pl53ykI+/FPoWzuv6OidS8J
         o1/tSVI88n+b2bxaHn84F1eJLphqGICyWZBVNZDoFm6lFuNdXP+tgXHoeoVGhoznEJfN
         dhJl9B6uEkyMUdRd7Jg7he/A4AhbXDaQz0vur7+fXFvjVSIrCthwjIPrkko5qVe67NLC
         KA1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1Xk8cMoSBWxhV052p1QrW87shWLWvhv0VAdwX0k4xUu1reqk26T4+nxrcbr4Ip2NwwRBYFX8gB0okDFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCzIcvXb2gbX3pVY/5/xV/PIzWZiMcYITsxSThNSg5JSvu+tcc
	vV2nGaGu5HevQx9pCUCGfXDwrIr20ThW8FHj25WroTIWwgTC2rYsAj25BmW9JeoBWefoO90ccCh
	gSrKC2NSwfmlroMU5+gH/OBlzcJzb05sKVKgUmiGZJH+EUC7exOi8riw=
X-Google-Smtp-Source: AGHT+IG6NABG+FUudq5++1rGPeYyvRYXk8TlADiLlr5ghSf9tQRr2s3pjOftfoUrSfHg678gl/ALTtrko4Uphqs5S6vPggU1hAg4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:320d:b0:3d2:b66b:94cd with SMTP id
 e9e14a558f8ab-3d2cb43252amr218741695ab.3.1740571706989; Wed, 26 Feb 2025
 04:08:26 -0800 (PST)
Date: Wed, 26 Feb 2025 04:08:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bf043a.050a0220.38b081.0130.GAE@google.com>
Subject: [syzbot] Monthly f2fs report (Feb 2025)
From: syzbot <syzbot+list32cc6c8959bc9c611c66@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello f2fs maintainers/developers,

This is a 31-day syzbot report for the f2fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/f2fs

During the period, 2 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 54 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1243    Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<2> 3       No    UBSAN: array-index-out-of-bounds in f2fs_truncate_inode_blocks (2)
                  https://syzkaller.appspot.com/bug?extid=51d857eed5614c310da0
<3> 2       No    kernel BUG in folio_end_read
                  https://syzkaller.appspot.com/bug?extid=92895fc54ccb69ca6fa9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

