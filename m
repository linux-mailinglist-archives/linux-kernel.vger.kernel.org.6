Return-Path: <linux-kernel+bounces-209470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E58DF903674
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9512B28668
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA0A174EC6;
	Tue, 11 Jun 2024 08:27:28 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64103F8C7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094448; cv=none; b=M7HpYL3OA9f5ifasqERdwCl0Vv8baD6ZwQn7bF+y0qYlKrcKq3U6Z5s82yO9xSUrzw8pbiV2XS+aqNtObGhiliKDAWViekrguL6dOjAoCVBCvZ4TsA3PaDiS3vgDMTEagNgn6MRuy7XXaVhVq4uitLqH1zOWv491uaz1kOMhuho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094448; c=relaxed/simple;
	bh=4846dXCi+LLa+oRqvFIzMnMlIKpDWNszKOj8xaC2DZY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YS1AdLMzaXJOow+LHu4y6gskPvrpmuuKGAf3HX00iQYxFfkEjNbutLtPcW+8TBGkWTp2kJRz9lNQM8P/ytrtaVaPcubs+SY6qD8r+K7GAWyhKlSAlWGofl4NnWqr1hgJSNuvKLW3VQYsN1RWcLRaeR8eAaJ++k2/zF4MEbmXke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3737ee417baso44814485ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718094446; x=1718699246;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i5XKnkHLsIoqOGAS3OERR6bhoari0fo/c4MqVHhGMVA=;
        b=N5Z6ME8wmHLT+J6ZwFkpZXJaomCcQRLNoZEe1X0smi6v3fSBVYk01/FVF5FWqTV1T+
         nRX8vPTZ22HnNqikpWQ64gz4ARWz5MSKafurxcJUqKxJEgjrLQaIYxUN0kDsQHYdsy4X
         CDyYn/r6mfBZFnMaAB2BkuTGiKEzDRTjNw8BovG8djBmYA2bqunC0pGKFvaR3Rk0ikkn
         Qjb5X0k7CI/ghfkKHC7nz/zSB9c2ApST0nszfjaeEU8p6Xt4dQQM765aSpN7H5yrCLOp
         m7lTfKEgxFGT571HRTF5yhh+tUIN0ycXphAgYQwyEsmuE9WmbNsHs+GHDkUoPIaynNp1
         sXrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcni2GjQGoPFFonj7sYlWAW7hViP2Ko7boH9KaJ3nlzrxVYy6j7bmvSn1F+W5WruZt2mdVq9UJpSBtTcQDLo/SraM3Rzw5uHkifdsp
X-Gm-Message-State: AOJu0Yyy0zshoWb+1cgKvd33Nl7zcRfEP57BlUyVd+xuu79LF5obU99Y
	7hjKcnvKYQH7axBDKMz76l1+G37Ot/yTVVhb3Ei/xAAVg82hO+xM+uCCH4Kcnh6N9IsuaSeoHHY
	ERXHFFErx5+b7Y51udTT9pe98RiOwCsnY+LTY4Cqlk5TG8xwKXZ/R3yQ=
X-Google-Smtp-Source: AGHT+IHNQFjX7nXtcEGVrCfUjJQTGAwh53HEqyZkAYPKF01NcC8BWO2SzrSRycYpJoEOKitThluVmUtW2DwOM/ljmxzKGAzvXeKU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214a:b0:373:8d04:28b2 with SMTP id
 e9e14a558f8ab-375b30d379dmr1024555ab.0.1718094445998; Tue, 11 Jun 2024
 01:27:25 -0700 (PDT)
Date: Tue, 11 Jun 2024 01:27:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002502d7061a9909cf@google.com>
Subject: [syzbot] Monthly bcachefs report (Jun 2024)
From: syzbot <syzbot+liste26a67e46fe73e904149@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bcachefs maintainers/developers,

This is a 31-day syzbot report for the bcachefs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bcachefs

During the period, 37 new issues were detected and 15 were fixed.
In total, 59 issues are still open and 30 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2800    No    WARNING in cleanup_srcu_struct (4)
                   https://syzkaller.appspot.com/bug?extid=6cf577c8ed4e23fe436b
<2>  1722    Yes   WARNING in bch2_trans_srcu_unlock
                   https://syzkaller.appspot.com/bug?extid=1e515cab343dbe5aa38a
<3>  1620    Yes   INFO: task hung in __closure_sync
                   https://syzkaller.appspot.com/bug?extid=7bf808f7fe4a6549f36e
<4>  1070    Yes   KMSAN: uninit-value in bch2_inode_v3_invalid
                   https://syzkaller.appspot.com/bug?extid=d3803303d5b280e059d8
<5>  578     Yes   BUG: MAX_LOCK_DEPTH too low! (4)
                   https://syzkaller.appspot.com/bug?extid=46405fa9afa07e6c8c40
<6>  221     Yes   kernel BUG in gc_bucket
                   https://syzkaller.appspot.com/bug?extid=246b47da27f8e7e7d6fb
<7>  187     No    INFO: task hung in bch2_readahead
                   https://syzkaller.appspot.com/bug?extid=a6060114362257e9798a
<8>  185     Yes   KMSAN: uninit-value in bch2_alloc_v4_invalid
                   https://syzkaller.appspot.com/bug?extid=3b2968fa4953885dd66a
<9>  148     Yes   kernel BUG in bch2_fs_journal_stop
                   https://syzkaller.appspot.com/bug?extid=10b936c5eaee2819b49b
<10> 104     Yes   INFO: task hung in bch2_fs_read_only_work
                   https://syzkaller.appspot.com/bug?extid=8996d8f176cf946ef641

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

