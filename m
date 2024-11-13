Return-Path: <linux-kernel+bounces-407437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CA59C6D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B67B27248
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FCB1FF5F9;
	Wed, 13 Nov 2024 11:07:27 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230BF1FEFA4
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496046; cv=none; b=Ub7iS5uGEzCaia76GKX5MWW7Jkd3Gj++FIh4rgn7IuGfY+WqjGSiVJ0ndUnirejV9pbt8XfQdrKUXmQV3JTddLTfoLVUsrJ4Q87a3Tf1vvAMPEciF3kCSb+3e7xTNAsYEFOeQQw/5LCjAdXVEYPn9yHqScQX9JPj29lajmxvtAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496046; c=relaxed/simple;
	bh=SjEdKI+Kf2R/D5KyAWV7tYeKtJYT89P1xDRnIawO9Z4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GrDHKtTSzXFTz2pRadxVrcIa6bFx+8GoN3T0H/NX7FZ8/6c0CSuCU5HU+GHKW+ciNzsYL1XLnGXvrpL3BhWrartGY6VwtfEeylMjwnmvVWRFbA+yOdSCvOcq9eUe7wGqgoPukqbphU63zbcHqZvafZ9E4RhUGvxSrjNe9fEzjbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7158d5c8aso7615275ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731496044; x=1732100844;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ia67arJPZRlvAYh7PoL/9fY5Xwvq773i9uIxPQF94OA=;
        b=LgeYZd1EYIumic0WEbqHSP12cMLwqFSMCQh3c3Fu7K+wZEZ0NTDA/qX56mxatUuw8o
         4cv3pIswYg6gjW976JFbZrapjuMC2QcLo+jmTDgam5cp1I20bniG/Wi0WMqv4ksc3ul7
         T7Y3Kc6tbFD8TKDBRoAb6yPrwUY/aHC7WQRaIyryUzgsOaCchbfXZ0LMJfxmBB/F7SY3
         QwoizrMwxlqzyTetQFP3IjLheyCWRCVVuMTAvOV34L2JlUXVT4MmUTqnmoYdrWbxTERQ
         gbbQEtJqsFWzP7jub90N7QJVS+3gehWTQIIhRKebnHuSbSkbBA2Xyqw74rUZYn/9N5SX
         CL7A==
X-Forwarded-Encrypted: i=1; AJvYcCUMY5y+a6VIgbL/BeE+nUwdECfW+s1E4TeTu8WIq4Dx5z8pYcrXJKNjb5ylCCar9J3uotmyXGqqY7JZO2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFDfZNuJhiYr4EawNVYHb3DWWU1bfLMOKYmc0wfR/V3yiL+/ap
	17zm4Ixfxnm9jC8D5PQT0qSO7ICguImqP/BtqpWcUr31+fQi8Kfp8uc4KfCH/L2laLO8QF5bZBH
	zF5QMAtquapd9TxBHhiG7kvw17JYOEbGwFafsrkK5mm/V9uVZ4ejRxLk=
X-Google-Smtp-Source: AGHT+IHb1qQ281rd8LQ1YRUaOEUlsWojI7DHK9jf4xZnGydMEjXlCKwBSxGrPBN9YWVUkVgPxVqZrerO9cmUFkgZ2Vdbf0Z6JEp7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:388d:b0:3a6:aee2:1696 with SMTP id
 e9e14a558f8ab-3a71578db17mr25270845ab.21.1731496043969; Wed, 13 Nov 2024
 03:07:23 -0800 (PST)
Date: Wed, 13 Nov 2024 03:07:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6734886b.050a0220.2a2fcc.0009.GAE@google.com>
Subject: [syzbot] Monthly ntfs3 report (Nov 2024)
From: syzbot <syzbot+liste07f67aea454cc1bcc00@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 5 new issues were detected and 0 were fixed.
In total, 41 issues are still open and 57 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  14466   Yes   kernel BUG in zero_user_segments
                   https://syzkaller.appspot.com/bug?extid=78eeb671facb19832e95
<2>  10502   Yes   kernel BUG in dnotify_free_mark
                   https://syzkaller.appspot.com/bug?extid=06cc05ddc896f12b7ec5
<3>  9346    Yes   KMSAN: uninit-value in longest_match_std (2)
                   https://syzkaller.appspot.com/bug?extid=08d8956768c96a2c52cf
<4>  5539    Yes   possible deadlock in ntfs_read_folio
                   https://syzkaller.appspot.com/bug?extid=8ef76b0b1f86c382ad37
<5>  3780    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<6>  2983    Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
<7>  1538    Yes   possible deadlock in ntfs_file_mmap
                   https://syzkaller.appspot.com/bug?extid=c1751b6739d83d70bb75
<8>  1302    Yes   possible deadlock in attr_data_get_block (2)
                   https://syzkaller.appspot.com/bug?extid=262a71e9d2faf8747085
<9>  529     Yes   kernel BUG in ntfs_extend_initialized_size
                   https://syzkaller.appspot.com/bug?extid=39385e8595a092bae44b
<10> 313     Yes   possible deadlock in ntfs_fallocate
                   https://syzkaller.appspot.com/bug?extid=adacb2b0c896bc427962

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

