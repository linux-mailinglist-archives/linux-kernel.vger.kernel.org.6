Return-Path: <linux-kernel+bounces-412775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CD79D0EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1B0282A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C19619750B;
	Mon, 18 Nov 2024 10:47:30 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AD519415E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926849; cv=none; b=uhvHbxpINgFKvDPd6RT0C8OVkgS6Gsuc49/jkKf8B4iMMPm5ic+ss462sZbPJd0Fxz4+LMaIBsE9/regyxkNWyJttTnszOn89SU6tdk3/fDCO7IxqVralJ64VYXy7FNygWbJDHLFfecD9Bb5J0hPJBAQz2ESYVAZl6CvK+njTjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926849; c=relaxed/simple;
	bh=Gf8eEWVvFhUCKkLtiXICZZ+u2faMFGrYc8gSrJ/uBFw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=V92xi2p7osNPzecixalYbY/cCQuyzvZshRSr61ZyG+wNsK6NAFAq4ftHeabPdeR0GzyDVr7mr0u2RZKa9lAyqMi/gYFvslGzZFa342I4+i15gt3vds301ewomz8eoZFfrKK74i1S9gYXjek+I154jh4PeZabdJFtlYElLJ/h1m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83abb2b6d42so285270339f.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:47:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731926846; x=1732531646;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSjCy1ZybpwZB7K4sbkHiQc0pzvKqHISOttFeMm25xw=;
        b=HNaK28XjWx5QdX/x63qQPgwjP0deyiQi3L73fJPy8wfAETL5kLtd2lY7fKelKPikto
         tGnQfDo0HCpFHH4Rqn+MBHUR49r/CkxPfW/aM+DoII1ovYdDsjFsma0loRE7SQgBN/qS
         86vYPLeUj87wOVP4X7B3SnJuDuEMYyILkQ1ixNKeZCHsJaz0ShiMDGPKKvrBkFS+A53S
         3skYMIbj3mE9qPRi9DHlgjCGG2y9vviepyQzPe3sDBUZ+uU6vYXfJxhC67Be6ExswCA+
         nx4yn3Wnyw2jwN/Yd3CP3Xs61ij+M/Xk7N5b3/mBQc5sdjT2/CjlwQohrYcFLGcaRh6V
         UXew==
X-Forwarded-Encrypted: i=1; AJvYcCVEhwWHOiCiSn7WmpYJbujzlvaQsvPA4X4wAnpGb2IiwMuK6YCPOWgCnVITchGoWoEo/01PXm5vg9iS1gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlPlt9TTs+daewAxwKmtYT90petAC3CAPaZklJ28HjDE5xxCGL
	lABXQnff1/pWodi9q8IOs1PZDZTfCd4fdTmDeQEe+vOPwpu1qi8FbkA+yDHf3IeEaDC+fajWl/J
	N5yhqZNbizYkljy91iSuS+4LdbIt2pxRrt4up9q0lmAcbixa+sDj1IoQ=
X-Google-Smtp-Source: AGHT+IEZdBRTVR7//FElZJfqdMZHC4QFr9tf01rseNOPrLDoDkviicBCePTCWZWfr5rxqwMyXmp6UgURL3y8tmz75KD82wcGbH58
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c4a:b0:3a7:629a:8bf3 with SMTP id
 e9e14a558f8ab-3a7629a8d52mr38986535ab.2.1731926846390; Mon, 18 Nov 2024
 02:47:26 -0800 (PST)
Date: Mon, 18 Nov 2024 02:47:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673b1b3e.050a0220.87769.0030.GAE@google.com>
Subject: [syzbot] Monthly hfs report (Nov 2024)
From: syzbot <syzbot+list633574df4e9b6c4a50f7@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 44 issues are still open and 21 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  29630   Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<2>  11478   Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<3>  10079   Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<4>  3712    Yes   WARNING in drop_nlink (2)
                   https://syzkaller.appspot.com/bug?extid=651ca866e5e2b4b5095b
<5>  2602    Yes   KMSAN: uninit-value in hfsplus_cat_case_cmp_key
                   https://syzkaller.appspot.com/bug?extid=50d8672fea106e5387bb
<6>  2241    Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<7>  2069    Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<8>  1926    Yes   KMSAN: uninit-value in hfs_find_set_zero_bits
                   https://syzkaller.appspot.com/bug?extid=773fa9d79b29bd8b6831
<9>  1728    Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<10> 1721    Yes   KMSAN: uninit-value in hfsplus_lookup
                   https://syzkaller.appspot.com/bug?extid=91db973302e7b18c7653

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

